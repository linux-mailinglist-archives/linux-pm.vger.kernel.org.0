Return-Path: <linux-pm+bounces-7484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D758BB03B
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C534F1C22695
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82945154455;
	Fri,  3 May 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rPaxwx6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291B6FDC
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751154; cv=none; b=RFgogDOA24rZtNOFKXEwITGCo5UtlW/Y378nn0CUeFMVN1I7ogN+/LhLOg1jUfv/AVNazAmSmL05Lt8kZfH2FQ9oDsg/OqtYyAlC43pownm7H6m8oik9oowiYNkHw9PP6SldPqWJHuoRuRn4zUu57WoDVKuNWPsahWMTqmRxlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751154; c=relaxed/simple;
	bh=fUaq/OER+1YjX7jh3aDlC30fid4qNUAszsmop75G2ys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ks66u0B1KhQodPmqwluwLllUu26d146YCnAkbjGgnehnHkbKiVfAD6W8bUuEFi/+l4jTLDXELPYfq7NWLfFNdyhXJdE8/85O0h4Pw7dDCSGMyq9eF1p5Zcvuaqc5OkDmXUaYilygn/dF2Huwkx7EC0Uz77QjGMNqLIv1STPDhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rPaxwx6D; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee55714625so1736276a34.0
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714751150; x=1715355950; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhI9yrOs8CfZH6O0uthOl9q2oyvn0I4hgTlooPx6s7Q=;
        b=rPaxwx6DJCEo6CUA20OMZUF35MjlOl+EFkK5300JgUFzLIVGq4EFjQPa4LVOsZu7gG
         x0CRgZIkRgvxYmEYkTj1a/Hy1zETcHn3XJQXNCLrlIjwuPFygzerJTi0Y0qKxS2a5BWQ
         16anriBIRu+FBTyeBMIdZ297P8ZKbG4jZd5Bbt7PxCc/jpT0ae5pAoeazuum8wSJGhdW
         9Wpgq8doFsIoIUYpnkcNsELgQAO7blmD2Rc9bJLy+nG+iPADj1s9COHB4StC7+TxDeLR
         hmrECD1W/ovaITlgFufLWrUhMX8g2ASAN4rAaS1gVCFpBZlX2GgE90+fv+8WxUtKJUMj
         3Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751150; x=1715355950;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhI9yrOs8CfZH6O0uthOl9q2oyvn0I4hgTlooPx6s7Q=;
        b=e9eyXX0rDUS5RpTZIaYWeKnLvogMZRwZ69gOmURSW426/zgW8lQzIieRVL6B2k5yQs
         mo6oultINNqf1KbIvTXO28Fsk4s+afB6t2Y9qYqXwZlTttOrIYuUKrR2ejVy2POEhNqr
         at+rR+rJVIfde5bA1lvDtiQ0YgWsEsXupJPaxZ/H4X76jcydofaWKcT39DMKIP77A7Ap
         T4pMCPLmCVbA8amHag0t4aFbLho9GS2/0Vnk8/2eKpAMDeX9fGU6qipDY0kIMwHS+Jqu
         gCXeH4+oFbtppZDTdRZv6/b0Dlkm0yYSpsXJB7p8tc0NJ8XOgKigcauve3d9ScGe1+L3
         Fs0g==
X-Forwarded-Encrypted: i=1; AJvYcCXlbjhO1BnhVFgb74/hat/q1fe+9j79Ks/sSeA7twetFaHmJrfJ4ovqUVCdOLaTQ0/2lV1ZTFB/x+DlW60gmjGLXb9PROOco84=
X-Gm-Message-State: AOJu0YxSDXuwgG1WWeD+XT6pdr6UNsDvk9Q5QQf2CnXvLrryGpE15xhr
	d893SztoSGAUcMDkbj7Q5E2AxX/aonqDdZ2iZFKvxZLf4SZq17GY4S4dMp+Rn9Q=
X-Google-Smtp-Source: AGHT+IG+DHh8GvHSrOBGw3RTRskRbLb5djVyMax1LElsUz89VQIsBT1Casz2tEAHJdHp4BCTsvIuZw==
X-Received: by 2002:a05:6830:1212:b0:6eb:c365:e68e with SMTP id r18-20020a056830121200b006ebc365e68emr3519049otp.25.1714751149969;
        Fri, 03 May 2024 08:45:49 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a10ac00b0079285113b99sm23092qkk.50.2024.05.03.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:45:49 -0700 (PDT)
Date: Fri, 3 May 2024 11:45:48 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Fix wrong
 lvts_ctrl index
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
Message-ID: <qppo2o23-40r4-956p-9n35-p0556sp32spq@onlyvoer.pbz>
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com> <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 May 2024, Julien Panis wrote:

> In 'lvts_should_update_thresh()' and 'lvts_ctrl_start()' functions,
> the parameter passed to 'lvts_for_each_valid_sensor()' macro is always
> 'lvts_ctrl->lvts_data->lvts_ctrl'. In other words, the array index 0
> is systematically passed as 'struct lvts_ctrl_data' type item, even
> when another item should be consumed instead.
> 
> Hence, the 'valid_sensor_mask' value which is selected can be wrong
> because unrelated to the 'struct lvts_ctrl_data' type item that should
> be used. Hence, some thermal zone can be registered for a sensor 'i'
> that does not actually exist. Because of the invalid address used
> as 'lvts_sensor[i].msr', this situation ends up with a crash in
> 'lvts_get_temp()' function, where this 'msr' pointer is passed to
> 'readl_poll_timeout()' function. The following message is output:
> "Unable to handle kernel NULL pointer dereference at virtual
> address <msr>", with <msr> = 0.
> 
> This patch fixes the issue.
> 
> Fixes: 11e6f4c31447 ("thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 18a796386cd0..d7df6f09938b 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -116,9 +116,9 @@ struct lvts_ctrl_data {
>  			      ((s2) ? BIT(2) : 0) | \
>  			      ((s3) ? BIT(3) : 0))
>  
> -#define lvts_for_each_valid_sensor(i, lvts_ctrl_data) \
> +#define lvts_for_each_valid_sensor(i, lvts_ctrl) \
>  	for ((i) = 0; (i) < LVTS_SENSOR_MAX; (i)++) \
> -		if (!((lvts_ctrl_data)->valid_sensor_mask & BIT(i))) \
> +		if (!((lvts_ctrl)->valid_sensor_mask & BIT(i))) \
>  			continue; \
>  		else
>  
> @@ -145,6 +145,7 @@ struct lvts_ctrl {
>  	const struct lvts_data *lvts_data;
>  	u32 calibration[LVTS_SENSOR_MAX];
>  	u32 hw_tshut_raw_temp;
> +	u8 valid_sensor_mask;
>  	int mode;
>  	void __iomem *base;
>  	int low_thresh;
> @@ -356,7 +357,7 @@ static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
>  	if (high > lvts_ctrl->high_thresh)
>  		return true;
>  
> -	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl)
> +	lvts_for_each_valid_sensor(i, lvts_ctrl)
>  		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
>  		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
>  			return false;
> @@ -617,6 +618,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
>  		lvts_sensor[i].high_thresh = INT_MIN;
>  	};
>  
> +	lvts_ctrl->valid_sensor_mask = lvts_ctrl_data->valid_sensor_mask;
> +
>  	return 0;
>  }
>  
> @@ -1112,7 +1115,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>  	u32 *sensor_bitmap = lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE ?
>  			     sensor_imm_bitmap : sensor_filt_bitmap;
>  
> -	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl) {
> +	lvts_for_each_valid_sensor(i, lvts_ctrl) {
>  
>  		int dt_id = lvts_sensors[i].dt_id;
>  
> 
> -- 
> 2.37.3
> 
> 

