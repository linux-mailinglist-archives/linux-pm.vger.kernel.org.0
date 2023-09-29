Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71EE7B386F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjI2RQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2RP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 13:15:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21C193;
        Fri, 29 Sep 2023 10:15:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB92C433C8;
        Fri, 29 Sep 2023 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696007756;
        bh=7AVz0kPivWQBR06i2p6a/CrWEaQAzDjbiSIr2+/B5fE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dte4q0nIE1wdPH8uWWsKdRseAuGKtJpYAB5SkFGzIRMcDNQ9/Sr0aobhUd/K+xElh
         pSgTl8maVw/r/OCtg0JG7KXPVKYZLr6A+gwEjVmXSTawdaRGJ4q8z35PHNQVdNnQlC
         2HkD6eMvLsdlb04DDTdXSRWrciQL91pvatt5AJr+xZ4H4YFT8YsZ8pVaMP4VhzbncG
         CNv+gyZQADOmmrxLm9LSOdzed+tp91AfSRnCGcKQksKodOXgaCRWNlmwMi+yEYGriZ
         Xw4Dzgb7mxb4O9LGyR34dcHFRJfWd3Xoeizmnm6u3EWwJJ0hiOO0XLV54vSlF164Ok
         hOKVoHHgzuo+g==
Received: (nullmailer pid 4170258 invoked by uid 1000);
        Fri, 29 Sep 2023 17:15:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
        linux-remoteproc@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
In-Reply-To: <20230905-caleb-qmi_cooling-v1-2-5aa39d4164a7@linaro.org>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20230905-caleb-qmi_cooling-v1-2-5aa39d4164a7@linaro.org>
Message-Id: <169600775352.4170222.9360806659423431462.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Date:   Fri, 29 Sep 2023 12:15:53 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 29 Sep 2023 17:16:18 +0100, Caleb Connolly wrote:
> The cooling subnode of a remoteproc represents a client of the Thermal
> Mitigation Device QMI service running on it. Each subnode of the cooling
> node represents a single control exposed by the service.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 ++
>  .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
>  .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 +++++++++++++++++++++
>  3 files changed, 187 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.example.dtb: remoteproc@4080000: cooling: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8996-mss-pil.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230905-caleb-qmi_cooling-v1-2-5aa39d4164a7@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

