exports.handler = async (event, context, callback) => {
    const request = event.Records[0].cf.request;
    const headers = request.headers;

    if (headers.cookie) {
        for (const element of headers.cookie) {
            if (element.value.indexOf("X-Redirect-Flag=Pro") >= 0) {
                request.origin = {
                    s3: {
                        authMethod: "origin-access-identity",
                        domainName: "terraform-serries-s3-pro.s3.amazonaws.com",
                        region: "ap-southeast-1",
                        path: "",
                    },
                };

                headers["host"] = [
                    {
                        key: "host",
                        value: "terraform-serries-s3-pro.s3.amazonaws.com",
                    },
                ];
                break;
            }

            if (element.value.indexOf("X-Redirect-Flag=Pre-Pro") >= 0) {
                request.origin = {
                    s3: {
                        authMethod: "origin-access-identity",
                        domainName: "terraform-serries-s3-pre-pro.s3.amazonaws.com",
                        region: "ap-southeast-1",
                        path: "",
                    },
                };

                headers["host"] = [
                    {
                        key: "host",
                        value: "terraform-serries-s3-pre-pro.s3.amazonaws.com",
                    },
                ];
                break;
            }
        }
    }

    callback(null, request);
};