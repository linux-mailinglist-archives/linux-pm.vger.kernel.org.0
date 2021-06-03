Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC339A978
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFCRsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFCRsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 13:48:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3DC06174A;
        Thu,  3 Jun 2021 10:46:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so6718799wrw.3;
        Thu, 03 Jun 2021 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNHNoyIPc56JzvVDn+fQoTPRGO3k2WWty4qeqb/AesU=;
        b=B9hDeW0WbnAZidcvhpT+0xu5iLMKTSrBjYuow6ssTqM/0K4FTi7irW5EO/NwypOe32
         LbHTvarsy0ZS6pebaKI7+nQI8hHp2WDYb6++qq7r3lSQ/tL0wcXsSK/9vQdintAjN6Kp
         0DvCugCBQ/LRUHndP7LQe8+49fEk2Pt7nwvTCVRj7Myu1Azvc5SdQjAwHDF2QHZNzlJy
         z3M6aqFbePyN0CF7Yqk03G6hhizbWnoRff26KK8rRTxPZNOUQMM+40O67j9kU8bEo1EZ
         YDQ8CWfHAdDTaJ7/aA8/EIumC+9iBa0EU98va53s/VN9m9dJTedBft0tRlF6/Za/tVy1
         fxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNHNoyIPc56JzvVDn+fQoTPRGO3k2WWty4qeqb/AesU=;
        b=cKOOErThMimKcxR24n6XXr22HAXnKtl6Mfp9ARmDKOU+JeFgYxZn1k7sofmRcdCjPH
         n1F2GaBuXC8qyQEyMcaG7ilrx1ol17+ZIUHpDENmqn/Z7DZUcfaqMzPxIZif0zomZnQO
         7aR4kaaMkG8NEc2fA8s6DcZHReLaNe2v4SDNprgxbX3dn4YgtOGGOLGB/l3iJ88MCF11
         XyMFWokQXxyGNZmpTg/afrzij4iCu3NDZOMDt2jfvT/lOYs6iMEs4GCgwPCDitwX5B/t
         sq8Lwch2VGGEAhM7d0IgcKtTVmOsDEKAXBk2aaJbAQeOZHfI/Zud5Db5JFCRKXr0Yvrn
         joWw==
X-Gm-Message-State: AOAM530FDqufKJ8UcTlW1nPBskag5tKhKceVIOvdnaERExGdP3Mboxhe
        q/M5WM95pG4xEvLQHrd5jg8=
X-Google-Smtp-Source: ABdhPJzmelXmMojIaThGJLerEKR3ZHv8GnmRuap9Pmzthk93MEz3Msq9ANIri+xeybPllvt47KtDmw==
X-Received: by 2002:adf:a503:: with SMTP id i3mr166016wrb.334.1622742370252;
        Thu, 03 Jun 2021 10:46:10 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id h1sm7458431wmq.0.2021.06.03.10.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:46:09 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: mt8183-kukui: Enable thermal Tboard
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
References: <20210603105901.21552-1-ben.tseng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b8c4023e-498c-c30e-e4cd-35fbadaf6b5d@gmail.com>
Date:   Thu, 3 Jun 2021 19:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603105901.21552-1-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 03/06/2021 12:59, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add Tboard thermal sensor settings.
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
> ---
> Change in v2:
>         - Rebase to kernel-v5.13-rc1
>         - Resend
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index ff56bcf..65768ab 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -847,6 +847,20 @@
>  	status = "okay";
>  };
>  
> +&thermal_zones {
> +	Tboard1 {

Lower-case please. It would be also good to know what tboard1 and 2 stands for.

Regards,
Matthias

> +		polling-delay = <1000>; /* milliseconds */
> +		polling-delay-passive = <0>; /* milliseconds */
> +		thermal-sensors = <&tboard_thermistor1>;
> +	};
> +
> +	Tboard2 {
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
