# Onenet Self-Hosted Setup

This example provides a fully configured and tested setup for deploying Onenet using the following components:

- **Service Mesh**: Istio
- **Database Storage**: SQLite
- **Identity Provider**: Zitadel

## Prerequisites

Before starting the setup, refer to the [Onenet documentation](https://docs.l1fe.network/selfhosted/identity-providers#zitadel) to configure your Zitadel Identity Provider and generate the necessary parameters:

- `idpClientID`
- `idpServiceUser`
- `idpServiceUserSecret`
- `idpProjectID`

## Kubernetes Secret Configuration

This setup requires Kubernetes secrets to store sensitive data. You'll need to create a secret named `onenet` in your Kubernetes cluster, containing the following key-value pairs:

- `idpClientID`: `xxxxxx` # The `clientID` from the Zitadel onenet application.
- `idpServiceUser`: `xxxxxx` # The `service user` from the Zitadel with permissions to read Zitadel directory.
- `idpServiceUserSecret`: `xxxxxx` # The `client secret` from the Zitadel onenet service user.
- `idpProjectID`: `xxxxxx` # The `project ID` from the Zitadel.
- `relayPassword`: `xxxxxx` # Password used to secure communication between peers in the relay service.
- `stunServer`: `xxxxxx` # STUN server URL, e.g., `stun:stun.myexample.com:3478`.
- `turnServer`: `xxxxxx` # TURN server URL, e.g., `turn:turn.myexample.com:3478`.
- `turnServerUser`: `xxxxxx` # TURN server username.
- `turnServerPassword`: `xxxxxx` # TURN server password.
- `datastoreEncryptionKey`: `xxxxxxx` # A random encryption key for the datastore, e.g., generated via `openssl rand -base64 32`.

> **Note:** The `datastoreEncryptionKey` must also be provided in a ConfigMap for the Onenet setup.

## Deployment

Once the required secrets and configuration are in place, this setup will deploy all necessary services for running Onenet, including the following exposed endpoints:

- `onenet-dashboard.example.com` - The Onenet dashboard.
- `onenet.example.com` - The main Onenet services (management|relay|signal).

## Additional info

Starting with Onenet v0.30.1, the platform supports reading environment variables directly within the `management.json` file. In this example, we leverage this feature by defining environment variables in the following format: `{{ .EnvVarName }}`.
