# This is just used for when using a Sandbox approach
# where the Route53 HostedZones are not defined by us
# therefore the variable needs to be set dynamically
# e.g cmcloudlab838.info.

echo "[INFO] Collecting data about the Route53 HostedZones .."
read route53_hostedzone_name < <(echo $(aws route53 list-hosted-zones | jq -r ".HostedZones[0].Name"))
export AWS_ROUTE53_HOSTEDZONE_NAME=$route53_hostedzone_name
echo "[INFO] Using the hosted zone: ${AWS_ROUTE53_HOSTEDZONE_NAME}"

sed -i "s/.*# DYNAMIC_ROUTE53_HOSTEDZONE/  default = \"${AWS_ROUTE53_HOSTEDZONE_NAME}\" # DYNAMIC_ROUTE53_HOSTEDZONE/g" ${PROJECT_ROOT_DIR}/terraform/variables.tf
