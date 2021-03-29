Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B734D5CB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhC2RMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2RMN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 13:12:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DD7C061574;
        Mon, 29 Mar 2021 10:12:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x13so13604741wrs.9;
        Mon, 29 Mar 2021 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rqpj3tJ8Hp0uec22wW3HCaakBv7Gn530wlfuwOnGxhw=;
        b=svjoxxu8FXf762k81J7JdAXqRNI+vJYzDQsRHhKReveRENd5hA/nL4sxdOCM8Tpw2b
         jms8DR+rMzQA+E8eHeSxAVD3gBLZ0fmbX/nOvEs+yhJ9Cd7NHwaNkZp+6OMruZL7M3nM
         14EtQNaq1ZeRqx4VQSZFvbGHGPL3ZCJLyZudwVwVvev+WX/qHbvM6oZ7IFuRyCWjne47
         tFZWU54daMIHV/6GmTa5DpzB0aa2HZj6beq9z4vBy8FmPAR6LWLmL1RW32gmhrG/1E77
         bmiftc2mdowy7poAXlHwHXUi+hKWTLswhIfff4RDuRi+cqB8Ur8iKbAaEVKicuXnjvJh
         uddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rqpj3tJ8Hp0uec22wW3HCaakBv7Gn530wlfuwOnGxhw=;
        b=A652Xc2khtIH0YMmDxHFKjMW+V9Pxv96WwGd8MXflRz2XxAo+EZA9nxNCLvm9G44EM
         goCIl80rFeQGH6zaW2X7wrYNSgp788fx05em5RDRpRIymPfRS3jBMOzOHvTCEkX72qqK
         zy1Qm4bIRzarw66uv/G5IPmHfvBBMSfVA/iJ5y34XyxBGiVZcuvy7bys8uJBFGlnFCCO
         pYFXeJPvYLk/S+96TjDLRHdbWxfeRLQmzd2MWuBE0dpVLCXL2s28hlhlsC56xxJ0AOva
         qeZPoeerngf0XxODXHWlGZKeZCyUwGGW5qgxPn1pCanVVV7Xb0leVtWF4mFIcex6QGSL
         TB9Q==
X-Gm-Message-State: AOAM533euQoBZHrztUTQtFpXRETS4+BQ4uFZ5qipeWUiiHAs+2AK0lQw
        AQKM0oO9vylG3OyPEUOsXAg=
X-Google-Smtp-Source: ABdhPJwutr/FGR0+TNlVNDBj+Z8mVQFMNgwXhcRLsKhhcyvZ+gR2gDLvdYZOR88VUK8ix8W0Ot/K+g==
X-Received: by 2002:a05:6000:137b:: with SMTP id q27mr30057996wrz.168.1617037932014;
        Mon, 29 Mar 2021 10:12:12 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id g11sm30636553wrw.89.2021.03.29.10.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 10:12:11 -0700 (PDT)
Subject: Re: [v7,2/3] arm64: dts: mt8183: Configure CPU cooling
To:     Michael Kao <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>
References: <20210316070144.28440-1-michael.kao@mediatek.com>
 <20210316070144.28440-3-michael.kao@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <25e4c77d-7548-a135-3f94-4f6224de1f91@gmail.com>
Date:   Mon, 29 Mar 2021 19:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316070144.28440-3-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 16/03/2021 08:01, Michael Kao wrote:
> From: Matthias Kaehlcke <mka@chromium.org>
> 
> Add two passive trip points at 68°C and 80°C for the CPU temperature.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Applied to v5.12-next/dts64

Thanks.
Matthias



> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 56 ++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index d3550af06408..1ad0a1d55d53 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/power/mt8183-power.h>
>  #include <dt-bindings/reset-controller/mt8183-resets.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "mt8183-pinfunc.h"
>  
>  / {
> @@ -678,6 +679,61 @@
>  				polling-delay = <500>;
>  				thermal-sensors = <&thermal 0>;
>  				sustainable-power = <5000>;
> +
> +				trips {
> +					threshold: trip-point@0 {
> +						temperature = <68000>;
> +						hysteresis = <2000>;
> +						type = "passive";
> +					};
> +
> +					target: trip-point@1 {
> +						temperature = <80000>;
> +						hysteresis = <2000>;
> +						type = "passive";
> +					};
> +
> +					cpu_crit: cpu-crit {
> +						temperature = <115000>;
> +						hysteresis = <2000>;
> +						type = "critical";
> +					};
> +				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip = <&target>;
> +						cooling-device = <&cpu0
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>,
> +								 <&cpu1
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>,
> +								 <&cpu2
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>,
> +								 <&cpu3
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>;
> +						contribution = <3072>;
> +					};
> +					map1 {
> +						trip = <&target>;
> +						cooling-device = <&cpu4
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>,
> +								 <&cpu5
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>,
> +								 <&cpu6
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>,
> +								 <&cpu7
> +							THERMAL_NO_LIMIT
> +							THERMAL_NO_LIMIT>;
> +						contribution = <1024>;
> +					};
> +				};
>  			};
>  
>  			/* The tzts1 ~ tzts6 don't need to polling */
> 
