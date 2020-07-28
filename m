Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD023089C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgG1LZo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 07:25:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37048 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729068AbgG1LZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 07:25:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595935543; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8upMbsqwYExTRhsaJQnXRaraZZZZtTNHPhUFTDZNV7g=;
 b=p+Z789DUciiWCxyYfVBxXRTcTwdwXfEOehUj6I26SGaBj+TpUrH70FIPoMKwgShr8zxhw5Dg
 4TED519pzV59mbEZV9aWXk0yWzt4cGnjNLqe38Bx8KFispAVgK3i9sC/yL+D4Tb9BveEc9FT
 rKHADuJbtSiZsck9BJmRYM4/egM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f200b27298a38b616fb7035 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 11:25:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD6DEC433CB; Tue, 28 Jul 2020 11:25:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE63FC433CA;
        Tue, 28 Jul 2020 11:25:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 16:55:25 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: interconnect: single yaml file for
 RPMh interconnect drivers
In-Reply-To: <20200728023811.5607-2-jonathan@marek.ca>
References: <20200728023811.5607-1-jonathan@marek.ca>
 <20200728023811.5607-2-jonathan@marek.ca>
Message-ID: <bcf1b1b105dbb33b0377597b215925ef@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-28 08:08, Jonathan Marek wrote:
> These two bindings are almost identical, so combine them into one. This
> will make it easier to add the sm8150 and sm8250 interconnect bindings.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> ---
>  .../{qcom,sdm845.yaml => qcom,rpmh.yaml}      | 20 ++++-
>  .../bindings/interconnect/qcom,sc7180.yaml    | 85 -------------------
>  2 files changed, 17 insertions(+), 88 deletions(-)
>  rename
> Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml =>
> qcom,rpmh.yaml} (76%)
>  delete mode 100644
> Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> similarity index 76%
> rename from 
> Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> rename to Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 74536747b51d..6a457f914bb5 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -1,16 +1,17 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> -title:  Qualcomm SDM845 Network-On-Chip Interconnect
> +title:  Qualcomm RPMh Network-On-Chip Interconnect
> 
>  maintainers:
>    - Georgi Djakov <georgi.djakov@linaro.org>
> +  - Odelu Kukatla <okukatla@codeaurora.org>
> 
>  description: |
> -   SDM845 interconnect providers support system bandwidth requirements 
> through
> +   RPMh interconnect providers support system bandwidth requirements 
> through
>     RPMh hardware accelerators known as Bus Clock Manager (BCM). The 
> provider is
>     able to communicate with the BCM through the Resource State
> Coordinator (RSC)
>     associated with each execution environment. Provider nodes must 
> point to at
> @@ -23,6 +24,19 @@ properties:
> 
>    compatible:
>      enum:
> +      - qcom,sc7180-aggre1-noc
> +      - qcom,sc7180-aggre2-noc
> +      - qcom,sc7180-camnoc-virt
> +      - qcom,sc7180-compute-noc
> +      - qcom,sc7180-config-noc
> +      - qcom,sc7180-dc-noc
> +      - qcom,sc7180-gem-noc
> +      - qcom,sc7180-ipa-virt
> +      - qcom,sc7180-mc-virt
> +      - qcom,sc7180-mmss-noc
> +      - qcom,sc7180-npu-noc
> +      - qcom,sc7180-qup-virt
> +      - qcom,sc7180-system-noc
>        - qcom,sdm845-aggre1-noc
>        - qcom,sdm845-aggre2-noc
>        - qcom,sdm845-config-noc
> diff --git
> a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> deleted file mode 100644
> index d01bac80d416..000000000000
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/interconnect/qcom,sc7180.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title:  Qualcomm SC7180 Network-On-Chip Interconnect
> -
> -maintainers:
> -  - Odelu Kukatla <okukatla@codeaurora.org>
> -
> -description: |
> -   SC7180 interconnect providers support system bandwidth requirements 
> through
> -   RPMh hardware accelerators known as Bus Clock Manager (BCM). The 
> provider is
> -   able to communicate with the BCM through the Resource State
> Coordinator (RSC)
> -   associated with each execution environment. Provider nodes must 
> point to at
> -   least one RPMh device child node pertaining to their RSC and each 
> provider
> -   can map to multiple RPMh resources.
> -
> -properties:
> -  reg:
> -    maxItems: 1
> -
> -  compatible:
> -    enum:
> -      - qcom,sc7180-aggre1-noc
> -      - qcom,sc7180-aggre2-noc
> -      - qcom,sc7180-camnoc-virt
> -      - qcom,sc7180-compute-noc
> -      - qcom,sc7180-config-noc
> -      - qcom,sc7180-dc-noc
> -      - qcom,sc7180-gem-noc
> -      - qcom,sc7180-ipa-virt
> -      - qcom,sc7180-mc-virt
> -      - qcom,sc7180-mmss-noc
> -      - qcom,sc7180-npu-noc
> -      - qcom,sc7180-qup-virt
> -      - qcom,sc7180-system-noc
> -
> -  '#interconnect-cells':
> -    const: 1
> -
> -  qcom,bcm-voters:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    description: |
> -      List of phandles to qcom,bcm-voter nodes that are required by
> -      this interconnect to send RPMh commands.
> -
> -  qcom,bcm-voter-names:
> -    $ref: /schemas/types.yaml#/definitions/string-array
> -    description: |
> -      Names for each of the qcom,bcm-voters specified.
> -
> -required:
> -  - compatible
> -  - reg
> -  - '#interconnect-cells'
> -  - qcom,bcm-voters
> -
> -additionalProperties: false
> -
> -examples:
> -  - |
> -      #include <dt-bindings/interconnect/qcom,sc7180.h>
> -
> -      config_noc: interconnect@1500000 {
> -            compatible = "qcom,sc7180-config-noc";
> -            reg = <0x01500000 0x28000>;
> -            #interconnect-cells = <1>;
> -            qcom,bcm-voters = <&apps_bcm_voter>;
> -      };
> -
> -      system_noc: interconnect@1620000 {
> -            compatible = "qcom,sc7180-system-noc";
> -            reg = <0x01620000 0x17080>;
> -            #interconnect-cells = <1>;
> -            qcom,bcm-voters = <&apps_bcm_voter>;
> -      };
> -
> -      mmss_noc: interconnect@1740000 {
> -            compatible = "qcom,sc7180-mmss-noc";
> -            reg = <0x01740000 0x1c100>;
> -            #interconnect-cells = <1>;
> -            qcom,bcm-voters = <&apps_bcm_voter>;
> -      };

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
