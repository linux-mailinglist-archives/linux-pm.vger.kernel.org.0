Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F6454C96
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 18:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhKQR5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 12:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhKQR5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 12:57:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA62C061570;
        Wed, 17 Nov 2021 09:54:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2811143wmf.0;
        Wed, 17 Nov 2021 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NxuLEKIm0mXrsHGG2Rnv1TyH8J27v/jCNCdg57uUOwk=;
        b=br8vmMvp8cjSC2cQS37z8XFmzlVPwzqxSZqD8h/oMhNrGhzSuNCSgt7WQ3aFH+XLNw
         DwvuMtsXME7FCS/8bsJxMfjSO3Q9ZMcTEXg4umtEj+ijuSnGCjMocLkj+9/5194ksfMS
         MIcgIkumprcAbKWR8ugkkobjjvxk2fv1/VoOXL3/QV51pIitQlHCHXHn5GITD9IicieS
         uO5JYJfpC4nLaK5r0SBPqGHCDJidIYq8AW3M/6cDJahTAzUup6pmaxZWlb49k/vHLsqr
         9eVXv2RW9pA4y5LijhVAm6KTttY1Q63hQYqGb0VzXZ9StTBiqUeEGng/hmqN2BfW7KTC
         Kwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NxuLEKIm0mXrsHGG2Rnv1TyH8J27v/jCNCdg57uUOwk=;
        b=0ExHu1nI5a7jKNwhk+1ld2sjP2pANtjvh2t8YBbIiIjtkfv6t/Udp2ayk9gRTMRwbA
         FoW6GxBCoM/jdq+SAijlBngtCnzFL2ZRyn2QR+QTgaj6enqFWYyQs8/8Gc0R8t1M+d7T
         lAhBnRV5aSut58E/UFc1rGjy5FZ/SJUcSE4kHU3AElMRQaL7k1TTyJmOFtbD7D/Algj8
         HPya6MsJZa0Nw40vx1z37Pg2QgBBgPDEPvhOnZxP7hLW0AfVE5GusL8x/Omg2BG/lcjd
         KmNijJ0LjJodywfbcp5PmNEPBySE2+3TGujcErdkpYIrKtfWQJwxfvtXmahrLVhWieGD
         YsAg==
X-Gm-Message-State: AOAM532PpGgqW8aEEHXjPR4cePV/LZWjY9pPI+ZPgbR6M/ZfSr8XTD0O
        G34lf25PkZjcJ+eKYzwnREo=
X-Google-Smtp-Source: ABdhPJylfeVPDVluNe8Z1is9/DaZeUH9l24hBfQrovOruKeoN87UMCnek+wHL8acgy+jli87m8PJkA==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr1762917wmj.13.1637171675530;
        Wed, 17 Nov 2021 09:54:35 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id b10sm553689wrt.36.2021.11.17.09.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:54:35 -0800 (PST)
Message-ID: <b3f2391e-7310-ea85-515b-c52caebb66f2@gmail.com>
Date:   Wed, 17 Nov 2021 18:54:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/1] arm64: dts: mt8183-kukui: Update Tboard sensor
 mapping table
Content-Language: en-US
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
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211103033044.2777-1-ben.tseng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211103033044.2777-1-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 03/11/2021 04:30, Ben Tseng wrote:
> According to auxadc change the readback value from raw data to Vsense.
> Update the tboard table that temperature map to Vsense.
> 
> pull-up voltage: 1800 mv
> pull-up resistor: 75K
> 
> Vsense = pull-up voltage * Rntc / ( pull-up resistor + Rntc )
> 
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> 

Applied to v5.16-next/dts64

Thanks!

> ---
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 108 +++++++++---------
>   1 file changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 8e9cf36a9a41..65447de64f06 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -151,33 +151,33 @@
>   		#thermal-sensor-cells = <0>;
>   		io-channels = <&auxadc 0>;
>   		io-channel-names = "sensor-channel";
> -		temperature-lookup-table = <    (-5000) 4241
> -						0 4063
> -						5000 3856
> -						10000 3621
> -						15000 3364
> -						20000 3091
> -						25000 2810
> -						30000 2526
> -						35000 2247
> -						40000 1982
> -						45000 1734
> -						50000 1507
> -						55000 1305
> -						60000 1122
> -						65000 964
> -						70000 827
> -						75000 710
> -						80000 606
> -						85000 519
> -						90000 445
> -						95000 382
> -						100000 330
> -						105000 284
> -						110000 245
> -						115000 213
> -						120000 183
> -						125000 161>;
> +		temperature-lookup-table = <    (-5000) 1553
> +						0 1488
> +						5000 1412
> +						10000 1326
> +						15000 1232
> +						20000 1132
> +						25000 1029
> +						30000 925
> +						35000 823
> +						40000 726
> +						45000 635
> +						50000 552
> +						55000 478
> +						60000 411
> +						65000 353
> +						70000 303
> +						75000 260
> +						80000 222
> +						85000 190
> +						90000 163
> +						95000 140
> +						100000 121
> +						105000 104
> +						110000 90
> +						115000 78
> +						120000 67
> +						125000 59>;
>   	};
>   
>   	tboard_thermistor2: thermal-sensor2 {
> @@ -185,33 +185,33 @@
>   		#thermal-sensor-cells = <0>;
>   		io-channels = <&auxadc 1>;
>   		io-channel-names = "sensor-channel";
> -		temperature-lookup-table = <    (-5000) 4241
> -						0 4063
> -						5000 3856
> -						10000 3621
> -						15000 3364
> -						20000 3091
> -						25000 2810
> -						30000 2526
> -						35000 2247
> -						40000 1982
> -						45000 1734
> -						50000 1507
> -						55000 1305
> -						60000 1122
> -						65000 964
> -						70000 827
> -						75000 710
> -						80000 606
> -						85000 519
> -						90000 445
> -						95000 382
> -						100000 330
> -						105000 284
> -						110000 245
> -						115000 213
> -						120000 183
> -						125000 161>;
> +		temperature-lookup-table = <    (-5000) 1553
> +						0 1488
> +						5000 1412
> +						10000 1326
> +						15000 1232
> +						20000 1132
> +						25000 1029
> +						30000 925
> +						35000 823
> +						40000 726
> +						45000 635
> +						50000 552
> +						55000 478
> +						60000 411
> +						65000 353
> +						70000 303
> +						75000 260
> +						80000 222
> +						85000 190
> +						90000 163
> +						95000 140
> +						100000 121
> +						105000 104
> +						110000 90
> +						115000 78
> +						120000 67
> +						125000 59>;
>   	};
>   };
>   
> 
