Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2836861E4
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBAInz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 03:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBAIny (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 03:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29B4FCE5;
        Wed,  1 Feb 2023 00:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7989061703;
        Wed,  1 Feb 2023 08:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4E3C433D2;
        Wed,  1 Feb 2023 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675241032;
        bh=R1VT1TpqN8xjr/SuaSd4KCnH10Pd9NZAXV9LuD/rLvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cUzIfS1iNfrdtB+b3hoVw6f2cUQ5130EbehpQmUK42Oy7powO2fBjeb3PE0wkd0wm
         QaqjFoFFMOJkDFTGYH5SAEi9SeKpsWNRqWaBc8ZUo45SKiZc/AvV3Zbu4ecMxY/WFa
         T619jSPmZvd7+tBSEFKsWBN+Dv/gixJM/saaEM79XM2yfpkyut0967JvPq0ttfj5cy
         Zh6VUPgfeHrlJJrpea/JiAn3NstYgJJHQGTfi07CMPPQPI+bwQGTOdvDB+2w/VrvEq
         O02UtvfIo7DFHRsjHPPd8W0W7dZ8XHpDlvIMwWYQYMBruOGSlj5UT3U9RDo66ajVP/
         twYTCqCqezL0A==
Message-ID: <9ab7383b-f3ed-3e48-d275-3c8933be5f2f@kernel.org>
Date:   Wed, 1 Feb 2023 09:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm CCI
 dt-bindings
To:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     bryan.odonoghue@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230201080227.473547-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 09:02, Jun Nie wrote:
> Add devicetree binding of Qualcomm CCI on MSM8939.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Subject: drop second/last, redundant "dt-bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/interconnect/qcom,cci.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml b/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> new file mode 100644
> index 000000000000..100c440ba220
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Cache Coherent Interconnect (CCI) frequency and voltage scaling
> +
> +maintainers:
> +  - Jun Nie <jun.nie@linaro.org>
> +
> +description: |
> +  Qualcomm Cache Coherent Interconnect (CCI) is a hardware engine used by
> +  MSM8939. The driver is to scale its frequency and adjust the voltage in
> +  hardware accordingly. The voltage provider is modeled as power domain on
> +  MSM8939, so power domain dts node is required.

Don't describe other bindings, but the hardware. Last sentence is not
really related. What's more - it does not fit what you wrote below.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8939-cci
> +
> +  clocks:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +  opp-table:
> +    type: object
> +
> +required:
> +  - compatible
> +  - clocks
> +  - operating-points-v2
> +  - nvmem-cells

?? You cannot require properties which are not present.

> +  - power-domains

Same here.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cci: cci {
> +        compatible = "qcom,msm8939-cci";
> +	clocks = <&apcs2>;

Messed indentation.

Use 4 spaces for example indentation.

> +	operating-points-v2 = <&cci_opp_table>;
> +	power-domains = <&cpr>;
> +	nvmem-cells = <&cpr_efuse_speedbin_pvs>;

How does it pass testing?

Best regards,
Krzysztof

