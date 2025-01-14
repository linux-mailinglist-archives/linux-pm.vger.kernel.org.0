Return-Path: <linux-pm+bounces-20401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61DA102F3
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 10:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E983A4688
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229D824024E;
	Tue, 14 Jan 2025 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9/CvVal"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2A22DC20
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846628; cv=none; b=FlZ+375zbFVhdPf7jY0Rr3EMaHEOfYep5zvCLUHt7z7TmUlTzcetSGsgY/s58/cMMNjSYQF9Pd9J7aatpIIIN1D1T26Pg9DPHYqifBcXXcFCPCWwFjFTukCUMjX0xgnTPQmxTYu69pvXja/qEn+tzYZ3tmx2Ipe2G0vDnSMKaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846628; c=relaxed/simple;
	bh=oYpAQBhA6oPHH4Ricya3Bzgts/o51VFx30fQ7a+NYj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/YrYqggqf+fdAU2yZ05zarv7JP+LW/DO/lyM2K4/HrnCNJwNO1R2GiRGZ9oyb3b+RHbJvn8ZeowyoU6pyb5k1kYZx5zalJR0whJpR/kKWZ0VFnvFDYLY5R12REWbYbwbKFxei8AFprOOS04NUooHRW6fZY0NePn5yWwMAZwpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9/CvVal; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so4543751f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 01:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736846624; x=1737451424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ujceh96Zfu+ZZBCUYvGUXM3Y+jEAHufrqSQjtD+xc6o=;
        b=t9/CvValVtjyN/seQoO26P1c1AAKpOehFqzGbtV04iZlvjkFg6QpOm9uxjYJRf1wEk
         oYMzf1pWBtqNFdO32OnQNEggoa0rLm+Ig1b/fZA1PG05UlZ0/E4CsWhV7V5nxsUgAqA0
         +sNLX5Ib87QdJtAm/FZ2VScJ+ZAfRdhA7pYJ2ycTHNb+GBBQLIexm2OsoFCHLxZxl4my
         iO/P/ruFQznpxMnEajfAoDpid701tw85DdZSRW4Nh1JdWscE/8vrHlzOBNjZpy64YY6j
         cMIYGc4CAVY+AMqRV12o8jG5qtRsJ2q2mLDkHX2drKFCIAcAMEhKKjEzb2f+bXELZplK
         xvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846624; x=1737451424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujceh96Zfu+ZZBCUYvGUXM3Y+jEAHufrqSQjtD+xc6o=;
        b=kugs1z89n/pO3KScvmDxdV+RbiHs7p4gyMF3wwaoydk+oW2Tf+GSb7TkKM/dN1RjcR
         z5QeXCReaE9sCmnMb0smX3/14r2Zrj/vxeC7z3SAqksuT3pO2ri68f1hblOUyZwa97ur
         3TC+9vqql0QGF/TFyD77p4D0PPNOH7i/hauvZf1yZ04ybK/wBLFwrffQgjClxCMw9p0e
         z3D4+xT6ZupCLu+VV4kwSc+/7nG4u/UGhaca7MymYzqMpCtkURJC9SrmUedZ/QO4fhrL
         JyERJRJ3CoO6SthIgfnHGfLmqQsEXrcvHcHV2d3A4NanR/dacrshvoKQObjAtVm+tHaK
         Lb9A==
X-Forwarded-Encrypted: i=1; AJvYcCUECkcqJKxVulSZawaw0vHMYI7RF2nf6Ry3BtqBZMcXl/VZiakOkZp08AWp64rPt1xBeE0N/KhQug==@vger.kernel.org
X-Gm-Message-State: AOJu0YypmmxaF9CElqrgrwDR+zluUMdUu8oNMZ9T4JXG230vfoPZtIXS
	wh63BqmsUV6pweRRFa1k6t4G4UIHtXfwuOk7koApLqT7xoXrXdqKbtXaHurpCx0=
X-Gm-Gg: ASbGncvimN7VCWQcsxSa7iXOHMUyYn02LuwgHY+EFFIdThGs8ShnxMckv83LU4ziqkX
	7P8wZK/in6WsVEuP5rsFCVteN88mblHv9Yc2z1aT2N5jFgo/E5ILJyUG7fO5oOMYtVyeWP/YDzf
	TsM/gHYhI6lt0zSVqTTnzGmAOKj6XZB7V8ROUUjcJUBsjd6lBPwPv7gYsgwdlwA04+rBcY8c9hB
	2GtsANWUR0SZwzjtenIBuoD9UFiCn1gnEY7uR1pMp3MWSd6xMoFecUymzleY2njEomX4JJCPU1L
	n/Xob7UtYrwH9UWxNvM0
X-Google-Smtp-Source: AGHT+IGUa5x9kNh4WH7UnCyzX3Q2GslgbUWvRhsg8TCGNensTbTol30VhBNVgwctwPWzJvCkmK/QEA==
X-Received: by 2002:a5d:5e8a:0:b0:386:3918:16b1 with SMTP id ffacd0b85a97d-38a8730fc4bmr23941231f8f.39.1736846623863;
        Tue, 14 Jan 2025 01:23:43 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e4b7ff0sm14396260f8f.77.2025.01.14.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 01:23:43 -0800 (PST)
Message-ID: <20828ba5-ecb5-46a4-8be3-9119d93c383a@linaro.org>
Date: Tue, 14 Jan 2025 10:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/5] thermal/drivers/mediatek/lvts: Disable
 monitor mode during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
 <20250113-mt8192-lvts-filtered-suspend-fix-v2-1-07a25200c7c6@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-1-07a25200c7c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Nicolas,

On 13/01/2025 14:27, Nícolas F. R. A. Prado wrote:
> When configured in filtered mode, the LVTS thermal controller will
> monitor the temperature from the sensors and trigger an interrupt once a
> thermal threshold is crossed.
> 
> Currently this is true even during suspend and resume. The problem with
> that is that when enabling the internal clock of the LVTS controller in
> lvts_ctrl_set_enable() during resume, the temperature reading can glitch
> and appear much higher than the real one, resulting in a spurious
> interrupt getting generated.
> 
> Disable the temperature monitoring and give some time for the signals to
> stabilize during suspend in order to prevent such spurious interrupts.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
> Fixes: 8137bb90600d ("thermal/drivers/mediatek/lvts_thermal: Add suspend and resume")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 07f7f3b7a2fb569cfc300dc2126ea426e161adff..a1a438ebad33c1fff8ca9781e12ef9e278eef785 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -860,6 +860,32 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
>   	return 0;
>   }
>   
> +static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_ctrl, bool enable)
> +{
> +	/*
> +	 * Bitmaps to enable each sensor on filtered mode in the MONCTL0
> +	 * register.
> +	 */
> +	static const u8 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
> +	u32 sensor_map = 0;
> +	int i;
> +
> +	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
> +		return;
> +
> +	if (enable) {
> +		lvts_for_each_valid_sensor(i, lvts_ctrl)
> +			sensor_map |= sensor_filt_bitmap[i];
> +	}
> +
> +	/*
> +	 * Bits:
> +	 *      9: Single point access flow
> +	 *    0-3: Enable sensing point 0-3
> +	 */
> +	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> +}
> +
>   /*
>    * At this point the configuration register is the only place in the
>    * driver where we write multiple values. Per hardware constraint,
> @@ -1381,8 +1407,11 @@ static int lvts_suspend(struct device *dev)
>   
>   	lvts_td = dev_get_drvdata(dev);
>   
> -	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
> +	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
> +		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], false);
> +		usleep_range(100, 200);

 From where this delay is coming from ?

>   		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
> +	}
>   
>   	clk_disable_unprepare(lvts_td->clk);
>   
> @@ -1400,8 +1429,11 @@ static int lvts_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
> +	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
>   		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
> +		usleep_range(100, 200);
> +		lvts_ctrl_monitor_enable(dev, &lvts_td->lvts_ctrl[i], true);
> +	}
>   
>   	return 0;
>   }
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

