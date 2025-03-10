// Copyright (c) Aptos
// SPDX-License-Identifier: Apache-2.0

use crate::{account, block, construction, network};
use aptos_rosetta::{
    client::RosettaClient,
    types::{NetworkIdentifier, NetworkRequest, PartialBlockIdentifier},
};
use aptos_types::chain_id::ChainId;
use clap::Parser;
use serde::Serialize;

/// Aptos Rosetta CLI
///
/// Provides an implementation of [Rosetta](https://www.rosetta-api.org/docs/Reference.html) on Aptos.
#[derive(Debug, Parser)]
#[clap(name = "aptos-rosetta-cli", author, version, propagate_version = true)]
pub enum RosettaCliArgs {
    #[clap(subcommand)]
    Account(account::AccountCommand),
    #[clap(subcommand)]
    Block(block::BlockCommand),
    #[clap(subcommand)]
    Construction(construction::ConstructionCommand),
    #[clap(subcommand)]
    Network(network::NetworkCommand),
}

impl RosettaCliArgs {
    pub async fn execute(self) -> anyhow::Result<String> {
        use RosettaCliArgs::*;
        match self {
            Account(inner) => inner.execute().await,
            Block(inner) => inner.execute().await,
            Construction(inner) => inner.execute().await,
            Network(inner) => inner.execute().await,
        }
    }
}

/// Format output to a human readable form
pub fn format_output<T: Serialize>(input: anyhow::Result<T>) -> anyhow::Result<String> {
    input.map(|value| serde_json::to_string_pretty(&value).unwrap())
}

#[derive(Debug, Parser)]
pub struct UrlArgs {
    /// URL for the Aptos Rosetta API. e.g. http://localhost:8082
    #[clap(long, default_value = "http://localhost:8082")]
    rosetta_api_url: url::Url,
}

impl UrlArgs {
    /// Retrieve a [`RosettaClient`]
    pub fn client(self) -> RosettaClient {
        RosettaClient::new(self.rosetta_api_url)
    }
}

#[derive(Debug, Parser)]
pub struct NetworkArgs {
    /// ChainId to be used for the server e.g. TESTNET
    #[clap(long, default_value = "TESTING")]
    pub chain_id: ChainId,
}

impl NetworkArgs {
    pub fn network_identifier(self) -> NetworkIdentifier {
        self.chain_id.into()
    }

    pub fn network_request(self) -> NetworkRequest {
        NetworkRequest {
            network_identifier: self.network_identifier(),
        }
    }
}

/// Wrapper so that it's easy to tell that the output is an error
#[derive(Serialize)]
pub struct ErrorWrapper {
    pub error: String,
}

/// Arguments for requesting a block
#[derive(Debug, Parser)]
pub struct BlockArgs {
    /// The index of the block to request
    #[clap(long)]
    block_index: Option<u64>,
    /// The hash of the block to request
    #[clap(long)]
    block_hash: Option<String>,
}

impl From<BlockArgs> for Option<PartialBlockIdentifier> {
    fn from(args: BlockArgs) -> Self {
        Some(args.into())
    }
}

impl From<BlockArgs> for PartialBlockIdentifier {
    fn from(args: BlockArgs) -> Self {
        PartialBlockIdentifier {
            index: args.block_index,
            hash: args.block_hash,
        }
    }
}
