Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5A21B94F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGJPUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgGJPTe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 11:19:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60CC08C5CE;
        Fri, 10 Jul 2020 08:19:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so6560964wmg.1;
        Fri, 10 Jul 2020 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XrzFqDjZylNG+KL47kJnNsuvtb+1kxd+FPY+/i5mZt4=;
        b=UNtM+doYl8G3EzvIWbXAfCydIYtbFtA/G65jpu8mwF5//qs+MAlXc3y9qszbPU687D
         CYDVzXa2j2Q3IkfrxO+d/sRFSUEpP+FtA6lJISsji6Kx7ufcEJGzD4Ej6oO94KwzB63u
         sO1yqQuF4Fta7foJsA5tYSNCrtdbZX8Mb5V8VrM8/Yl+m88PJBesCAhnrkKOstjyODIf
         qjNHQsapydA7qW5u/AB0Etram1VzVzJL+zLiSZhH3ZXB84kpS/C756PaUXH24wtYfULd
         nOACW/fPGEPhSjHnfgROOQ1pGrgfesos7KeIznyfbEJVkxM6M8RpkkxOlnKHrtS/OkGg
         kZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XrzFqDjZylNG+KL47kJnNsuvtb+1kxd+FPY+/i5mZt4=;
        b=h+bMnpbWZNTg3eZ8/f53VZY3pvP4T27rM2wNBEPKDcKHKbmr+xT7IqKqI8QjZj7p+K
         s0l5AWwbpaCuiKeO2Fg5wqdp6mUjdTW6IIw1zkf2+vmP4BnhhbzkV1oqIOFf6QwQuO9h
         KyB9Iqo+c33aXqVRpKT75AW1+dTZU/SV5oHIuRgA//xE6kM5XXLefEkgS62npCx1Rhj+
         9YUqK4lBJ6vl54ESBn+1wYWX4bEwpsaFGt8jqvhO63tBDlBwwSc9p4+e/h8YyBSqHLkP
         WG1NjcucgqqLtIgCzsbTsB6hyhkgaz6IPqRKWkPwkexxnbA8vL7mBwS2I+/OsnlgwHU3
         KepQ==
X-Gm-Message-State: AOAM532bmRWwCZxym3qyjlImHVsP4Prf0GiT/T3FWl3cGx8t02tjpoeT
        VIIgbAtfQ7+y/lmTJPpdzzpG1tHENak=
X-Google-Smtp-Source: ABdhPJzCkcfkGK+ERXI385yQy9ajXHjD/934EyflpmvQE2QG2B1P+YuyDCKd9EOc/U3LBtnDAZ1wBQ==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr5420848wmo.62.1594394343258;
        Fri, 10 Jul 2020 08:19:03 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id r10sm10531744wrm.17.2020.07.10.08.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:19:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] thermal: mediatek: prepare to add support for
 other platforms
To:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
References: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
 <1588238074-19338-2-git-send-email-henry.yen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <94d81c8a-2710-98a1-4cae-040e9b51fcd9@gmail.com>
Date:   Fri, 10 Jul 2020 17:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1588238074-19338-2-git-send-email-henry.yen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 30/04/2020 11:14, Henry Yen wrote:
> It is known that Mediatek owns two thermal systems, which only differ
> in the way of reading calibration data and converting temperature.
> MT8173, MT8183, MT2701 and MT2712 belongs to version 1 thermal
> system, and MT7622 belongs to version 2.
> 
> In order to handle both systems, the suffix _V1 is appended to the
> current code, and then the second patch will add _V2 functions with
> the same purpose but different implementation.
> 
> Signed-off-by: Henry Yen <henry.yen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/thermal/mtk_thermal.c | 114 ++++++++++++++++++----------------
>   1 file changed, 62 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 76e30603d4d5..10107d9d56a8 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -120,18 +120,18 @@
>    * MT2701 has 3 sensors and needs 3 VTS calibration data.
>    * MT2712 has 4 sensors and needs 4 VTS calibration data.
>    */
> -#define CALIB_BUF0_VALID		BIT(0)
> -#define CALIB_BUF1_ADC_GE(x)		(((x) >> 22) & 0x3ff)
> -#define CALIB_BUF0_VTS_TS1(x)		(((x) >> 17) & 0x1ff)
> -#define CALIB_BUF0_VTS_TS2(x)		(((x) >> 8) & 0x1ff)
> -#define CALIB_BUF1_VTS_TS3(x)		(((x) >> 0) & 0x1ff)
> -#define CALIB_BUF2_VTS_TS4(x)		(((x) >> 23) & 0x1ff)
> -#define CALIB_BUF2_VTS_TS5(x)		(((x) >> 5) & 0x1ff)
> -#define CALIB_BUF2_VTS_TSABB(x)		(((x) >> 14) & 0x1ff)
> -#define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 1) & 0x3f)
> -#define CALIB_BUF0_O_SLOPE(x)		(((x) >> 26) & 0x3f)
> -#define CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
> -#define CALIB_BUF1_ID(x)		(((x) >> 9) & 0x1)
> +#define CALIB_BUF0_VALID_V1		BIT(0)
> +#define CALIB_BUF1_ADC_GE_V1(x)		(((x) >> 22) & 0x3ff)
> +#define CALIB_BUF0_VTS_TS1_V1(x)	(((x) >> 17) & 0x1ff)
> +#define CALIB_BUF0_VTS_TS2_V1(x)	(((x) >> 8) & 0x1ff)
> +#define CALIB_BUF1_VTS_TS3_V1(x)	(((x) >> 0) & 0x1ff)
> +#define CALIB_BUF2_VTS_TS4_V1(x)	(((x) >> 23) & 0x1ff)
> +#define CALIB_BUF2_VTS_TS5_V1(x)	(((x) >> 5) & 0x1ff)
> +#define CALIB_BUF2_VTS_TSABB_V1(x)	(((x) >> 14) & 0x1ff)
> +#define CALIB_BUF0_DEGC_CALI_V1(x)	(((x) >> 1) & 0x3f)
> +#define CALIB_BUF0_O_SLOPE_V1(x)	(((x) >> 26) & 0x3f)
> +#define CALIB_BUF0_O_SLOPE_SIGN_V1(x)	(((x) >> 7) & 0x1)
> +#define CALIB_BUF1_ID_V1(x)		(((x) >> 9) & 0x1)
>   
>   enum {
>   	VTS1,
> @@ -525,7 +525,7 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
>    * This converts the raw ADC value to mcelsius using the SoC specific
>    * calibration constants
>    */
> -static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
> +static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
>   {
>   	s32 tmp;
>   
> @@ -594,9 +594,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   		raw = readl(mt->thermal_base +
>   			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
>   
> -		temp = raw_to_mcelsius(mt,
> -				       conf->bank_data[bank->id].sensors[i],
> -				       raw);
> +		temp = raw_to_mcelsius_v1(mt,
> +					  conf->bank_data[bank->id].sensors[i],
> +					  raw);
>   
>   		/*
>   		 * The first read of a sensor often contains very high bogus
> @@ -758,6 +758,51 @@ static u64 of_get_phys_base(struct device_node *np)
>   	return of_translate_address(np, regaddr_p);
>   }
>   
> +static int mtk_thermal_extract_efuse_v1(struct mtk_thermal *mt, u32 *buf)
> +{
> +	int i;
> +
> +	if (!(buf[0] & CALIB_BUF0_VALID_V1))
> +		return -EINVAL;
> +
> +	mt->adc_ge = CALIB_BUF1_ADC_GE_V1(buf[1]);
> +
> +	for (i = 0; i < mt->conf->num_sensors; i++) {
> +		switch (mt->conf->vts_index[i]) {
> +		case VTS1:
> +			mt->vts[VTS1] = CALIB_BUF0_VTS_TS1_V1(buf[0]);
> +			break;
> +		case VTS2:
> +			mt->vts[VTS2] = CALIB_BUF0_VTS_TS2_V1(buf[0]);
> +			break;
> +		case VTS3:
> +			mt->vts[VTS3] = CALIB_BUF1_VTS_TS3_V1(buf[1]);
> +			break;
> +		case VTS4:
> +			mt->vts[VTS4] = CALIB_BUF2_VTS_TS4_V1(buf[2]);
> +			break;
> +		case VTS5:
> +			mt->vts[VTS5] = CALIB_BUF2_VTS_TS5_V1(buf[2]);
> +			break;
> +		case VTSABB:
> +			mt->vts[VTSABB] =
> +				CALIB_BUF2_VTS_TSABB_V1(buf[2]);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	mt->degc_cali = CALIB_BUF0_DEGC_CALI_V1(buf[0]);
> +	if (CALIB_BUF1_ID_V1(buf[1]) &
> +	    CALIB_BUF0_O_SLOPE_SIGN_V1(buf[0]))
> +		mt->o_slope = -CALIB_BUF0_O_SLOPE_V1(buf[0]);
> +	else
> +		mt->o_slope = CALIB_BUF0_O_SLOPE_V1(buf[0]);
> +
> +	return 0;
> +}
> +
>   static int mtk_thermal_get_calibration_data(struct device *dev,
>   					    struct mtk_thermal *mt)
>   {
> @@ -793,43 +838,8 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>   		goto out;
>   	}
>   
> -	if (buf[0] & CALIB_BUF0_VALID) {
> -		mt->adc_ge = CALIB_BUF1_ADC_GE(buf[1]);
> -
> -		for (i = 0; i < mt->conf->num_sensors; i++) {
> -			switch (mt->conf->vts_index[i]) {
> -			case VTS1:
> -				mt->vts[VTS1] = CALIB_BUF0_VTS_TS1(buf[0]);
> -				break;
> -			case VTS2:
> -				mt->vts[VTS2] = CALIB_BUF0_VTS_TS2(buf[0]);
> -				break;
> -			case VTS3:
> -				mt->vts[VTS3] = CALIB_BUF1_VTS_TS3(buf[1]);
> -				break;
> -			case VTS4:
> -				mt->vts[VTS4] = CALIB_BUF2_VTS_TS4(buf[2]);
> -				break;
> -			case VTS5:
> -				mt->vts[VTS5] = CALIB_BUF2_VTS_TS5(buf[2]);
> -				break;
> -			case VTSABB:
> -				mt->vts[VTSABB] = CALIB_BUF2_VTS_TSABB(buf[2]);
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> -
> -		mt->degc_cali = CALIB_BUF0_DEGC_CALI(buf[0]);
> -		if (CALIB_BUF1_ID(buf[1]) &
> -		    CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
> -			mt->o_slope = -CALIB_BUF0_O_SLOPE(buf[0]);
> -		else
> -			mt->o_slope = CALIB_BUF0_O_SLOPE(buf[0]);
> -	} else {
> +	if (mtk_thermal_extract_efuse_v1(mt, buf))
>   		dev_info(dev, "Device not calibrated, using default calibration values\n");
> -	}
>   
>   out:
>   	kfree(buf);
> 
