Return-Path: <linux-pm+bounces-18118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371D99D94CB
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E297E282651
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB41BD517;
	Tue, 26 Nov 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EzEvnnbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383011BD9DC;
	Tue, 26 Nov 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614240; cv=none; b=LRO1s+AcanAFDwrZOc+wZxjcwVB14Mp/YicKkojHVRvUhOmxNileGRgvWU5f7z9xRkgX0+QFdjvMGGQiUYEMfu98vixysLCPNwlobUaiaIfENs9IkwoV5YZyC3qyxt3y7gHS7HaARGxShlMLFOvqgrigs/rmdCbyS4li1CAWWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614240; c=relaxed/simple;
	bh=rYvgffP7WJsxBoyO5PEpR5F9aHAYnGMAwwh2irwZ6Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKUW5tdB1eGgr6hhOZa426m71cZnF4hCYpKXmIvTgeVq1cY+GxWTTEl78gqR1gHMX5Qb5V0LtUnVlbI7kb6IxJsOB8G1OUJpbECnVShUpc+Ifu4cAvtdk6Xo9uodr1jMXO9zPtrsiXJis/vC0YL5LyCUm694tA3y5/e695ewsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EzEvnnbu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732614236;
	bh=rYvgffP7WJsxBoyO5PEpR5F9aHAYnGMAwwh2irwZ6Ts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EzEvnnbuupFz6kFdVUF7t3YOGdGh8XlfBbdmD590tYE07dgB0LmqHSHUf54V39Cmr
	 SVK9+hS61HsXwPfQz4QGWucQGG+bLKHkOUrbDyM69VtdrO6XFC8rMc+NRzzNWzg75t
	 BuwcZjPdZHCVuDS65Y0FeYvOEGSHCCYVeZqVcee2WC8+XkrU3h4zAottyZvpj+im4z
	 2fZx49YLYmLDhKceEjRCie09NgwCaXB/wiulZLNKkZVjQLcwJYdY5Y9bK2UVrBeqOt
	 juAoUh+K6nenpke6UjUcjHBgn9+qx2sTdLX8Nkb9fTdOD9t7SfTxxt5wGpXYeeUUnO
	 kFgBSumoPxPcg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97A8017E1524;
	Tue, 26 Nov 2024 10:43:55 +0100 (CET)
Message-ID: <600f9d78-bdc8-4133-bb43-06d798bcd543@collabora.com>
Date: Tue, 26 Nov 2024 10:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
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
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1997e91bb3be94a3059db619238aa5787edc7675..a92ff2325c40704adc537af6995b34f93c3b0650 100644
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
> +	u32 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
> +	u32 sensor_map = 0;
> +	int i;
> +
> +	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
> +		return;
> +

That's easier and shorter:

static void lvts_ctrl_monitor_enable( .... )
{
	/* Bitmap to enable each sensor on filtered mode in the MONCTL0 register */
	const u32 sensor_map = GENMASK(3, 0);

	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
		return;

	/* Bits 0-3: Sensing points - Bit 9: Single point access flow */
	if (enable)
		writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
	else
		writel(BIT(9), LVTS_MONCTL0 ....
}


Cheers,
Angelo

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


