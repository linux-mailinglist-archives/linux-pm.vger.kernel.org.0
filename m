Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACE52500A
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355295AbiELOcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355300AbiELOcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 10:32:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFE62120
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 07:32:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q20so3156434wmq.1
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gfV6hdj+G/eKhil+K8KKf6Xy30nkm2zLFDY36R9t3Bg=;
        b=N2yYG9TriNOJkpOXXy+kvvvM/AVOyWksfsEqkamccWwpC1p89jHbnFVmMIbjpVpHqn
         ijVwQn5PbA+yltYmAjcbEzdfyMcGeik0hu/dBbEjKrW96bUcGb/31M2/C2xVd75uvGxQ
         7Lu+Ojd2bUFvks7wdtkzdhLxEf1xlOe2mO+vit3gJb4HFJ3V/J/gDz6mwInwXvjDlMS7
         Bu8hBAteXfuNqmRV0VLeKs0YUIIa6pUjdm+qvUS2f/h2cl2LauaSzKOh6WE8miCAm/VN
         CaNlV4gGIPF67/MjFTemRYxuNztld9/UNCXJm51mBxAgRN3DowKDKH3mOu5UnjLxaV6n
         cbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gfV6hdj+G/eKhil+K8KKf6Xy30nkm2zLFDY36R9t3Bg=;
        b=4KpffngHZXh0iq1+Q4TfoBfvtx+2ZJHSp3hQHwN55HPhsfL528o8H49WSw0BixJqWA
         fMGpHUtBH/JQYus35CIDqIb7At1YQS35XGuU0/LPJPcwI1DWfRRhxVA5on8ThtfkbDeK
         31EFsf1AuCO504Kjq4X5+NGg5mjCe0eHPezlzXPyqbrB03p9Mcmq1BZ4PryXVyP0mlU2
         vcoWpgIcskCVxmzebOlWU4aN13B6KcC92LF0B8+1P9PY19pMWx5HukyK5Ko2CW3bGpUP
         ap1+KizkrxXe57v2bpHrD/78/EDe/94dwz50DgzHYXpXKq6seVcYSj0k/aunyb7/r5eR
         oYdw==
X-Gm-Message-State: AOAM533aGX8p8DpKOumq0AsXHQIUY+lu2eCB8QIO5exfaQ1L8n9hf0yT
        8OvGy6a2GQ4BahMZtVxJ9P+iKg==
X-Google-Smtp-Source: ABdhPJzn0NdYnZ6arUr+7JV+G5AsR7rJ0k6j66fzM/lksa0zMGVqxos0KZ1oxRF7R+mdChnOviCSnQ==
X-Received: by 2002:a05:600c:b47:b0:394:1200:957b with SMTP id k7-20020a05600c0b4700b003941200957bmr10506789wmr.2.1652365963660;
        Thu, 12 May 2022 07:32:43 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d684f000000b0020c5253d8fesm4459561wrw.74.2022.05.12.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:32:42 -0700 (PDT)
Message-ID: <a219c974-a291-7fb5-bdd0-1979d9083eb1@linaro.org>
Date:   Thu, 12 May 2022 16:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 7/7] arm64: dts: mt8195: Add thermal zone
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com,
        Tinghan Shen <tinghan.shen@mediatek.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
 <20220512122433.1399802-8-abailon@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512122433.1399802-8-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2022 14:24, Alexandre Bailon wrote:
> From: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> This adds the thermal zone for the mt8195.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 103 +++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 12887fb4d0d1..d6e5b595a89f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -823,6 +823,21 @@ spi0: spi@1100a000 {
>  			status = "disabled";
>  		};
>  
> +		lvts: lvts@1100b000 {

Generic node names.

> +			compatible = "mediatek,mt8195-lvts";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x1100b000 0 0x1000>,
> +				<0 0x11278000 0 0x1000>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			clock-names = "lvts_clk";
> +			resets = <&infracfg_rst 1>,
> +					<&infracfg_rst 2>;
> +			nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
> +			nvmem-cell-names = "e_data1","e_data2";
> +		};
> +
>  		spi1: spi@11010000 {
>  			compatible = "mediatek,mt8195-spi",
>  				     "mediatek,mt6765-spi";
> @@ -1627,4 +1642,92 @@ vencsys_core1: clock-controller@1b000000 {
>  			#clock-cells = <1>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu_big1 {

No underscores in node names. Generic node names - please open existing
thermal zones schema and look how it is done. This probably fails
validation, so be sure your DTS passes make dtbs_check.

Best regards,
Krzysztof
