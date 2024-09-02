Return-Path: <linux-pm+bounces-13348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2489687EA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A558E1F22F13
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4F1D61A1;
	Mon,  2 Sep 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuFQT7k1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD9185947
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281429; cv=none; b=EcFiHIKVhI9lbQP4IYYS2mBVJ63EZ4AuWhnTZS1fu2KWGjmWWxoazYx1GD4zsHgz4ibPgb7huoeyFiYxpqri4fpEYo2/0+h4TujQ/AcDSIlG9YLOr6dwlbbnwj7j+ZWJSbTVHYxq19+WBi8DiFn1sforLMXGxVPoBrcRCfVr6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281429; c=relaxed/simple;
	bh=oOLgdqKaqIoYmrt80N2TWv861dQVRS2CRaQHLQS7ngs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bewfKoSVDHZGoIRBIF4uANXcsm9oOKiDdyIsTBW9QgpjLTUwHu1z6BwaxokSuof7d4gocNw8KNy2RHbOGxJAGJUtTVNe+XvsXVJxGEw76JrjjwqGl/RtbRtfMdO+BF0iZDUuKN/C/Pq7oU9BzK+nAX4JmrtFxzZEYZRHGXtxGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuFQT7k1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371ba7e46easo2799762f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725281425; x=1725886225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4zZp0vvL8qAqOWFo0YibynCaMgnBEJ9RqtvAY0A5+A=;
        b=YuFQT7k1WfcQ4nlU6Xl6MymfndYQ7zEWslxkoyW5lDk7C+LQ+CpU5DYQmkKwRvfJ7T
         brHBe0ziZ0AMK2ri0IxhQQeJ73cVE85PYV3M1YJheE3u2tZ05AnrG4ngOxY5ysfk9emA
         dXK/pLxGrkIjfbxyQO0HMuSrM5vJPYkq2zwfIHumHWlbzf15UyprdUthazrgzUWLskJK
         Hc8b/uHIkAWlkW3ikRAOAxtiAcsyYAqK37vHQfdXi0RPfzoiJZ9AysfctL6lU4Iv0Iz3
         Iuzyr3ur/3ycDKetqI4i9zG2FS+68xDtNYX2ma+9u3XCzM8bceyiiNShQZ7avWSC5Uri
         Tj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281425; x=1725886225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4zZp0vvL8qAqOWFo0YibynCaMgnBEJ9RqtvAY0A5+A=;
        b=rr5A/UwYjmpIPbAi5aS3YOr4RYIAmS+KI2tLntou47DtOJSEwLB+kIN7J/vvgUxgXx
         fkLQspd3q/7yFL5EcvYB7GeA0IBHLGjDb7lS5ZhSnOMEZVLIRW0fOxjzBqblx1v0xtFe
         RQvpz1PCr52XbazvoNyIOR17X5aZ63IlWNRocdDyQD2gc5Tx/pf52xcLsEdgO9BZkQ+z
         Df20izaY/IhB/ApS1OUKn71pN4wzmF+N92ZKjUx8aOeiLujGSruFqvPB87PlFdzS68RN
         Cu/AOv/P2WT1o8GlDuTTGj8Txmr5yn2P5rx8lmBu4ch5zrDdkvg//6VyHLoY0XuvzrdA
         WX2g==
X-Forwarded-Encrypted: i=1; AJvYcCXSjRauVLOwiZ0UvU4XiWXsLGuNrfwerpVo1gZBNhvgPH8iFk4htXYQda6mS1F6j6wuT2zgGfhg+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWh0A5Te8VLm3j7F2g/tGs84UaBnCH22C2FwzhW30xQE79KhEn
	KanB2/HrUFjJq7ddz0YZQKB+Tc2/nCSYxq1qpQ5lN5hDgP5fxCztA+TC6dobmZE=
X-Google-Smtp-Source: AGHT+IHFfdhySS3bPqgfC/v2cGnExHRAs4Obow5fte98bTQ+aBzvgmgBl+9odUWSSlOqKZmpiyXt7Q==
X-Received: by 2002:adf:f550:0:b0:368:48e6:5056 with SMTP id ffacd0b85a97d-374bcead8cemr5185465f8f.22.1725281425119;
        Mon, 02 Sep 2024 05:50:25 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749ee40d5asm11399232f8f.11.2024.09.02.05.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 05:50:24 -0700 (PDT)
Message-ID: <664344db-5a60-46c4-b108-38ca1b4e1a13@linaro.org>
Date: Mon, 2 Sep 2024 14:50:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] drivers/thermal/exynos: improve
 sanitize_temp_error
To: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Anand Moon <linux.amoon@gmail.com>
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
 <CGME20240807084912eucas1p20af043b96b6d741a0c7d7ae36efe5ac5@eucas1p2.samsung.com>
 <20240807084829.1037303-4-m.majewski2@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240807084829.1037303-4-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2024 10:48, Mateusz Majewski wrote:
> There are two minor issues regarding this function.
> 
> One is that it attempts to calculate the second calibration value even
> if 1-point trimming is being used; in this case, the calculated value is
> probably not useful and is never used anyway. Changing this also
> requires a minor reordering in Exynos5433 initialization function, so
> that we know which type of trimming is used before we call
> sanitize_temp_error.
> 
> The second issue is that the function is not very consistent when it
> comes to the use of Exynos7-specific parameters. This seems to not be an
> issue in practice, in part because some of these issues are related to
> the mentioned calculation of the second calibration value. However,
> fixing this makes the code a bit less confusing, and will be required
> for Exynos850 which has 9-bit temperature values and uses 2-point
> trimming.

May I suggest to convert this function to a specific soc ops to be put 
in the struct exynos_tmu_data ?

> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
> v1 -> v2: reworked to change shift instead of only mask and to also fix
>    the 2-point trimming issue.
> 
>   drivers/thermal/samsung/exynos_tmu.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index b68e9755c933..087a09628e23 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -111,6 +111,7 @@
>   #define EXYNOS7_TMU_REG_EMUL_CON		0x160
>   
>   #define EXYNOS7_TMU_TEMP_MASK			0x1ff
> +#define EXYNOS7_TMU_TEMP_SHIFT			9
>   #define EXYNOS7_PD_DET_EN_SHIFT			23
>   #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
>   #define EXYNOS7_EMUL_DATA_SHIFT			7
> @@ -234,20 +235,23 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
>   	u16 tmu_temp_mask =
>   		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
>   						: EXYNOS_TMU_TEMP_MASK;
> +	int tmu_85_shift =
> +		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SHIFT
> +						: EXYNOS_TRIMINFO_85_SHIFT;
>   
>   	data->temp_error1 = trim_info & tmu_temp_mask;
> -	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> -				EXYNOS_TMU_TEMP_MASK);
> -
>   	if (!data->temp_error1 ||
>   	    (data->min_efuse_value > data->temp_error1) ||
>   	    (data->temp_error1 > data->max_efuse_value))
> -		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
> +		data->temp_error1 = data->efuse_value & tmu_temp_mask;
>   
> -	if (!data->temp_error2)
> -		data->temp_error2 =
> -			(data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
> -			EXYNOS_TMU_TEMP_MASK;
> +	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> +		data->temp_error2 = (trim_info >> tmu_85_shift) & tmu_temp_mask;
> +		if (!data->temp_error2)
> +			data->temp_error2 =
> +				(data->efuse_value >> tmu_85_shift) &
> +				tmu_temp_mask;
> +	}
>   }
>   
>   static int exynos_tmu_initialize(struct platform_device *pdev)
> @@ -510,7 +514,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
>   	int sensor_id, cal_type;
>   
>   	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> -	sanitize_temp_error(data, trim_info);
>   
>   	/* Read the temperature sensor id */
>   	sensor_id = (trim_info & EXYNOS5433_TRIMINFO_SENSOR_ID_MASK)
> @@ -532,6 +535,8 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
>   		break;
>   	}
>   
> +	sanitize_temp_error(data, trim_info);
> +
>   	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
>   			cal_type ?  2 : 1);
>   }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

