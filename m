Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A741CC0A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346282AbhI2SmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346190AbhI2SmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 14:42:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F99C061765
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 11:40:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c4so2164744pls.6
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4jwM7sobvyC/yr53MKLR0xpqrIrHAxpL22WbxQS8Ssk=;
        b=BO4+2wrBhpWuCNj60xpuPgO7J50jiinFUZAkXTz6DPCNbk/I5aD11OhFxHjNtyFxYf
         RvbtY17gJxHrUyr27wF6UBUJhxcBqQjmphC31JZ64+fNg3H8Bwg86zMp615PKpLSaL3v
         mAQ9BTwki3iV5apUvUPYwTeH/26Af/6eh1ChA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jwM7sobvyC/yr53MKLR0xpqrIrHAxpL22WbxQS8Ssk=;
        b=4Mm7hX6w0fFc+HTztBBNRhFXChweBJzK0Sr6xe7t6IaFhVQZGmZVt37j3MjiY6dZIX
         V7gJkwBzpcZ2L8gbTb1C1hYaO+o804WxYzISOKIv3PMgi3GWtc7gUvCTvfeXZTSRjsdd
         DXb4E3SkN28T7fw96C1qgwbFGwqIQb2NfHSfX41tTc5uT+pnWsnWgTo8xu0x12jft7v7
         bFa+1gwUuvPAbVzWxUCHf5SZKfAPmUwIA/B6wMRYIK/To+wc/GJqsR5X8n4WYZRwas3I
         /ddvvQtZZ36uEReIx4aZj3n6lMtJn+P4IJhnIf6C7VqLFxGsG1a3cI/U6yC+P41StYo1
         0v5g==
X-Gm-Message-State: AOAM533BG+QwQ6zFsQy4D0iJQC1Tm0xERAjQNgD/mvCNtEGW9rzuVghA
        R7R1TwfA7g25NzfZquANjANYwQ==
X-Google-Smtp-Source: ABdhPJyU6YGAnOeNMh7OS1RrgoT3QJ2xKwQz0u5IBYHVhIbWpHqBeKoWjIxxse5LTwLah0AAs5Kibw==
X-Received: by 2002:a17:90b:2385:: with SMTP id mr5mr1478243pjb.189.1632940839770;
        Wed, 29 Sep 2021 11:40:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2f10:2763:4825:1f01])
        by smtp.gmail.com with UTF8SMTPSA id c9sm425983pfi.212.2021.09.29.11.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 11:40:39 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:40:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
Message-ID: <YVSzJZ8G43CLml3L@google.com>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923212311.2877048-5-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
> Downstream defines four ADC channels related to thermal sensors external
> to the PM8998 and two channels for internal voltage measurements.
> 
> Add these to the upstream SDM845 MTP, describe the thermal monitor
> channels and add thermal_zones for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
> 
> Changes since v1:
> - Enable the pm8998_adc_tm and describe the ADC channels
> - Add thermal-zones for the new channels
> 
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 52dd7a858231..e3b40daef801 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -10,6 +10,8 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
> @@ -46,6 +48,68 @@ vreg_s4a_1p8: pm8998-smps4 {
>  
>  		vin-supply = <&vph_pwr>;
>  	};
> +
> +	thermal-zones {
> +		xo_thermal: xo-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8998_adc_tm 1>;
> +
> +			trips {
> +				trip-point {
> +					temperature = <125000>;
> +					hysteresis = <10000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		msm_thermal: msm-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8998_adc_tm 2>;
> +
> +			trips {
> +				trip-point {
> +					temperature = <125000>;
> +					hysteresis = <10000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		pa_thermal: pa-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8998_adc_tm 3>;
> +
> +			trips {
> +				trip-point {
> +					temperature = <125000>;
> +					hysteresis = <10000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +
> +		quiet_thermal: quiet-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8998_adc_tm 4>;
> +
> +			trips {
> +				trip-point {
> +					temperature = <125000>;
> +					hysteresis = <10000>;
> +					type = "passive";
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &adsp_pas {
> @@ -469,6 +533,70 @@ &mss_pil {
>  	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mbn";
>  };
>  
> +&pm8998_adc {
> +	adc-chan@4c {
> +		reg = <ADC5_XO_THERM_100K_PU>;
> +		label = "xo_therm";
> +	};
> +
> +	adc-chan@4d {
> +		reg = <ADC5_AMUX_THM1_100K_PU>;
> +		label = "msm_therm";
> +	};
> +
> +	adc-chan@4f {
> +		reg = <ADC5_AMUX_THM3_100K_PU>;
> +		label = "pa_therm1";
> +	};
> +
> +	adc-chan@51 {
> +		reg = <ADC5_AMUX_THM5_100K_PU>;
> +		label = "quiet_therm";
> +	};
> +
> +	adc-chan@83 {
> +		reg = <ADC5_VPH_PWR>;
> +		label = "vph_pwr";
> +	};
> +
> +	adc-chan@85 {
> +		reg = <ADC5_VCOIN>;
> +		label = "vcoin";
> +	};
> +};
> +
> +&pm8998_adc_tm {
> +	status = "okay";
> +
> +	xo-thermistor@1 {
> +		reg = <1>;
> +		io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	msm-thermistor@2 {
> +		reg = <2>;
> +		io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	pa-thermistor@3 {
> +		reg = <3>;
> +		io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	quiet-thermistor@4 {
> +		reg = <4>;
> +		io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +};
> +

The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
redundancy bothered me earlier, it's not really clear to me whether it's
needed/recommended or not. Do you happen to have any insights on this?
