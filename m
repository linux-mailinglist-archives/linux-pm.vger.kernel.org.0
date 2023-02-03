Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E875A689E03
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjBCPSr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 10:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjBCPSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 10:18:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1695CD21;
        Fri,  3 Feb 2023 07:15:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4246B82AF1;
        Fri,  3 Feb 2023 15:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B9FC433D2;
        Fri,  3 Feb 2023 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675437303;
        bh=x0NLukImJJDpktA+YghswEFtxNLyI5xpCIdNlCmuBO4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NLUBn4h/CKILAGCpjGu0PzQnrUCRnVJbM6dZx7IIfZywK5lylTRd8Avflxpbo09Q9
         xQh545o7xNOt9qNyT2m5rcTqJgOm9ejCcQrbPVLOdZ8zQirekTYRrPOYoaRELSPbP+
         MZVsIk2wd94x2Civ0+bm9wZohVR08BZ1C6Mr5TFGnrATDaM5CNhzU77xPG1lGEKKHL
         34iY8ZdLhmQ7CBUp8sdh/+obu+7giWUNwSMp8JC8C1+Kr3uOeaScfCIbYxSCq2wYfW
         kde7404ixw4A57qmXhwmIx+yUTCY5PAphPEJlxLrc76ji4EvL8mi0LUtosVWw4LdBp
         dEynRBEqO5BBw==
Message-ID: <ed9c3224-2f1a-c335-3028-6c23f40f57f4@kernel.org>
Date:   Fri, 3 Feb 2023 16:14:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 18/18] dt-bindings: devfreq: event: convert Rockchip DFI
 binding to yaml
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pegutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230203125012.3804008-1-s.hauer@pengutronix.de>
 <20230203125012.3804008-19-s.hauer@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230203125012.3804008-19-s.hauer@pengutronix.de>
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

On 03/02/2023 13:50, Sascha Hauer wrote:
> Convert the Rockchip DFI binding to yaml. While at it add the newly
> supported rk3568-dfi to the binding.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> ---
>  .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ---------
>  .../bindings/devfreq/event/rockchip-dfi.yaml  | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> deleted file mode 100644
> index 148191b0fc158..0000000000000
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -
> -* Rockchip rk3399 DFI device
> -
> -Required properties:
> -- compatible: Must be "rockchip,rk3399-dfi".
> -- reg: physical base address of each DFI and length of memory mapped region
> -- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
> -- clocks: phandles for clock specified in "clock-names" property
> -- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
> -
> -Example:
> -	dfi: dfi@ff630000 {
> -		compatible = "rockchip,rk3399-dfi";
> -		reg = <0x00 0xff630000 0x00 0x4000>;
> -		rockchip,pmu = <&pmugrf>;
> -		clocks = <&cru PCLK_DDR_MON>;
> -		clock-names = "pclk_ddr_mon";
> -	};
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml
> new file mode 100644
> index 0000000000000..e082a0df7895a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml

rockchip,dfi.yaml

> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/event/rockchip-dfi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip DFI
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rk3399-dfi
> +      - rk3568-dfi

These are not correct compatibles.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  rockchip,pmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the "PMU general register files".
> +
> +required:
> +  - compatible
> +  - reg

clocks were required

> +
> +additionalProperties: false

Best regards,
Krzysztof

