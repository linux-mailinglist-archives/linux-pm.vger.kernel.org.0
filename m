Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5444359735
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhDIIKS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIIKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 04:10:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E111C061761
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 01:10:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so954931wrt.5
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KwLBWMBZRdz46SUCvmDH9Z5zZXCHk+G/HINFfQ17P4M=;
        b=hNhtj/aNpiqdIzZxP30CSRrlHSEJ+O8XRNC6jWPo79WZV4eucvGfZoZkKIdlEF6Khu
         N+SQeipigjG2DjlfUvoxpdaaHARK2jibT3Ojl+9fBLq90YpUiKiJZAFS1RkH4ZC07h/u
         p+WxjHZXM1FPv+9AWnAjECvuHh4dW66akPp3V7i2jJAzYNGjBOq8m91JKig8nHsDClHA
         wDszXITwkUa3he/ggRpNIGHI0P/qgrs0BYF4MpTe3Zf3zHBbK0XaSzRZw0rM1XdDtJmW
         MPsTCb833ukTW1aPV15PJuTaQOEw00OlZeSqY3JBQ3ltR1bsHn5hpL+mZzdfzF3fyw65
         Ebfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwLBWMBZRdz46SUCvmDH9Z5zZXCHk+G/HINFfQ17P4M=;
        b=iP1vjc3VJ1EeCbCFtDwY3ed2hFx0d4naDEoskTI9gMH0cZfeyqAhZG8AGa07mhEEYf
         iuqhD6YSPq6zQxLFrcZtjkmTMWk1UYHaCih/Hj7MbNfOS1Z0GupuESk8qt9Dlp9NYPPN
         rnQbq0nqGbBLQjJ80Q3vriW6UadTzNj0fsXdlzPvzypNycrIvtyREnDh7FiwOcTAa31g
         4RQKWunuc/okVa1JkkcF5QYNrfot/+LcZ03WqPFFDtwFmjnwWqCBzPVStqwT+5pE3/bd
         VRcW+UikxASbtn+aXHnW1RzvHTp22z/xHvplnhq9T1Jh44zbPs5va/yCwDRzuMhduwMy
         ammA==
X-Gm-Message-State: AOAM532HW8TFXFP8+RnWNTrTs2F6qbhgIZMP/G8apRvIWvh1ZkSarWCq
        pUMIjEAd5HnxgOVwQQCHPdQmKQ==
X-Google-Smtp-Source: ABdhPJy4XQCBVWHdPm5wWRMqkGkFiEZh0CiXWdXcPLlAZvt02L7wI+v/m2X3FQwQNaQuzsiZpcriMA==
X-Received: by 2002:adf:dc4f:: with SMTP id m15mr16484222wrj.420.1617955801641;
        Fri, 09 Apr 2021 01:10:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d29:55c:ba8e:9bff? ([2a01:e34:ed2f:f020:5d29:55c:ba8e:9bff])
        by smtp.googlemail.com with ESMTPSA id u9sm2677419wmc.38.2021.04.09.01.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 01:10:00 -0700 (PDT)
Subject: Re: [v7,1/3] arm64: dts: mt8183: add thermal zone node
To:     Michael Kao <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210316070144.28440-1-michael.kao@mediatek.com>
 <20210316070144.28440-2-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f7003979-0210-882e-bb28-f24047e18061@linaro.org>
Date:   Fri, 9 Apr 2021 10:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316070144.28440-2-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/03/2021 08:01, Michael Kao wrote:
> From: "michael.kao" <michael.kao@mediatek.com>
> 
> Add thermal zone node to Mediatek MT8183 dts file.
> 
> Evaluate the thermal zone every 500ms while not cooling
> and every 100ms when passive cooling is performed.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 85 ++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7..d3550af06408 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -657,6 +657,87 @@
>  			status = "disabled";
>  		};
>  
> +		thermal: thermal@1100b000 {
> +			#thermal-sensor-cells = <1>;
> +			compatible = "mediatek,mt8183-thermal";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_THERM>,
> +				 <&infracfg CLK_INFRA_AUXADC>;
> +			clock-names = "therm", "auxadc";
> +			resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +			interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +		};
> +
> +		thermal-zones {
> +			cpu_thermal: cpu_thermal {
> +				polling-delay-passive = <100>;
> +				polling-delay = <500>;
> +				thermal-sensors = <&thermal 0>;
> +				sustainable-power = <5000>;
> +			};
> +
> +			/* The tzts1 ~ tzts6 don't need to polling */
> +			/* The tzts1 ~ tzts6 don't need to thermal throttle */
> +
> +			tzts1: tzts1 {
> +				polling-delay-passive = <0>;
> +				polling-delay = <0>;
> +				thermal-sensors = <&thermal 1>;
> +				sustainable-power = <5000>;
> +				trips {};
> +				cooling-maps {};
> +			};

What is the point of defining the sustainable power with no cooling
device associated ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
