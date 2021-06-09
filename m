Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609573A0E99
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhFIIRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 04:17:02 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39759 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhFIIQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 04:16:59 -0400
Received: by mail-wm1-f48.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3636872wmh.4;
        Wed, 09 Jun 2021 01:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDejX14cuoEO/H0sRTILaHtqtnRlGOdZIVyLc1gELHM=;
        b=Z77K2BYnb+Go65fwl0un25idVvkqskG0HIPT/qX1xuMGcqLCdmhusQc1pc5IuAIyNE
         zQpyAltc7qofw7NDilEFmZW7m5Dt6YaeUS6eU9gZv5yGLhJQHoewFCy2Fr0UbbKOkkkf
         MU2vNTXoOyRuQgJMRiyn/16ui3KMDj5FIX1xRIqRmTmglVTdZRxYm25qL8XNLUXU0avG
         dQM9XPtgpW0gBBi/Wrh0LoOeOXw5dUQ6Hh94EwF8qUOsiSsEw0K7kqQnMENDL0ooyBup
         n9+0APznaBA1vI7Jca5LrqIFYMbnH0gm47Fx7zZLVzn9qUMZYpYNzxPtJi3wBRG42YZb
         g3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDejX14cuoEO/H0sRTILaHtqtnRlGOdZIVyLc1gELHM=;
        b=maho4MzIRtvet2SGP3P9//N4Qo2zjlOb3g1TMR7KOLLrblBpxfxR6cgo0Sk4EKisYW
         211RtDVpWCrGcZlgm8jkuKGxaHtSbN7UHdDEu36UGYXsK/XE4/zKNtchU5Z6+eWikczx
         wVycCfgLnjiJViW7sbf6W24fjy+fzWQGsqkBNeMrSk0HkQ7nS+1jjMbsJA8QXkZLloXx
         Trk7aGgV2j7OqDdLMHC+kYqhFW+pzXSfzCaYWD2emt+sN0cljXMP9hQnW+DzJQql9Xui
         uKrn2VXuLzCozI6rQyn/8/wU3uogutCEu9C5Mw/EyTxniiqk4S60tJteILpm0UxYg1kz
         QYvg==
X-Gm-Message-State: AOAM532/0sh6Y8UlyPWlO2oCbVkz4oUhRPjiPw+nta4lpw+uJsAmPT7j
        JOD0JlNdxWqCUXzU64I9F0Q=
X-Google-Smtp-Source: ABdhPJxf7dhagIxY/xwnJJ5qRNr31sHti4hpeyNOyE/mNhLkwm1Lwdkn+cVNJ4Mcw+uIV+cdMplYBg==
X-Received: by 2002:a05:600c:3393:: with SMTP id o19mr8623579wmp.163.1623226444421;
        Wed, 09 Jun 2021 01:14:04 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id n13sm25862628wrg.75.2021.06.09.01.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 01:14:03 -0700 (PDT)
Subject: Re: [PATCH v3] arm64: dts: mt8183-kukui: Add tboard thermal zones
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>
References: <20210604093755.13288-1-ben.tseng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4b94148e-f52b-c8a0-d068-2b7b65f61240@gmail.com>
Date:   Wed, 9 Jun 2021 10:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210604093755.13288-1-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 04/06/2021 11:37, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add tboard thermal zones.
> The tboard thermal sensors are a kind of NTC sensors which are located
> on PCB board to correlate the temperature of the case (Tskin).
> 
> pull-up voltage: 1800 mv
> pull-up resistor: 75K
> 
> Vsense = pull-up voltage * Rntc / ( pull-up resistor + Rntc )
> AuxIn = Vsense * 4096 / 1500
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 

Applied to v5.13-next/dts64

Thanks!

> ---
> Change in v3:
>         - Modify Tboard to tbaord in mt8183-kukui.dtsi
>         - Add more description about tboard thermal sensor
> 
> Change in v2:
>         - Rebase to kernel-v5.13-rc1
>         - Resend
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ff56bcf..601f866 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -847,6 +847,20 @@
>  	status = "okay";
>  };
>  
> +&thermal_zones {
> +	tboard1 {
> +		polling-delay = <1000>; /* milliseconds */
> +		polling-delay-passive = <0>; /* milliseconds */
> +		thermal-sensors = <&tboard_thermistor1>;
> +	};
> +
> +	tboard2 {
> +		polling-delay = <1000>; /* milliseconds */
> +		polling-delay-passive = <0>; /* milliseconds */
> +		thermal-sensors = <&tboard_thermistor2>;
> +	};
> +};
> +
>  &u3phy {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b..4173a5d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -673,7 +673,7 @@
>  			nvmem-cell-names = "calibration-data";
>  		};
>  
> -		thermal-zones {
> +		thermal_zones: thermal-zones {
>  			cpu_thermal: cpu_thermal {
>  				polling-delay-passive = <100>;
>  				polling-delay = <500>;
> 
