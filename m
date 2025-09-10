Return-Path: <linux-pm+bounces-34369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C590EB518A9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3534E1B2621D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C0307AC8;
	Wed, 10 Sep 2025 13:59:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20E32145E;
	Wed, 10 Sep 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512778; cv=none; b=a7C+wJM2oeBcAReWfbyFPgJufrITMdUglNiY0iapGvEc/NFl071OANROqT5mqs+u/oa5SOrcA22/2cbcgQiXc3psbP5KTEL4qtAPH8PXJAU5bHsxvSuVQXEu2IEpL6eJJrno1tcMUeLoBZ7XaLhPJ2B1cBk4h7uCov+pE8utP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512778; c=relaxed/simple;
	bh=59bDAbI5f2Vldbh2lqwJDMzAsheAlxTdO3L5GcbmjhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsJeYLxhsFIeLOY9jV+lNopHHJ2BXb0jehH02kH3dLL//WoO6NHDHkPeUxe2BZ0owdNUtOs6oSXXxPRdea/nG+pID6ocQjTUPLw5nCmX9n+5Wup/o3AyJAfTM57AUd9Es+1GEi1FXSwwzIgKUuzoLBhHmWC+gryPgfZj5voVMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556841595;
	Wed, 10 Sep 2025 06:59:27 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54D863F694;
	Wed, 10 Sep 2025 06:59:30 -0700 (PDT)
Message-ID: <2489d50a-a075-42bc-92a3-7570581fe508@arm.com>
Date: Wed, 10 Sep 2025 14:59:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/10] drm/panthor: devfreq: expose get_dev_status and
 make it more generic
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-8-7b6c2d6be221@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250905-mt8196-gpufreq-v1-8-7b6c2d6be221@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 11:23, Nicolas Frattaroli wrote:
> The only device-specific part of panthor's get_dev_status devfreq
> callback is getting the clock frequency. All the other logic surrounding
> what it does may be useful for other devfreq implementations however.
> 
> Expose it in the panthor_devfreq.h header file, and make it call back
> into get_cur_freq instead of poking the common clock framework directly.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 29 +++++++++++++++++------------
>  drivers/gpu/drm/panthor/panthor_devfreq.h |  3 +++
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 02eb3ca15d1874e1cbafc6b614b196c5cc75b6a1..d495dd856299826c4bddc205087d8914d01d7fc4 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -43,6 +43,15 @@ static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
>  	return err;
>  }
>  
> +static int panthor_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct panthor_device *ptdev = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(ptdev->clks.core);
> +
> +	return 0;
> +}
> +

I don't see any reason why this was moved up here as part of this patch?
Otherwise this looks fine to me.

Thanks,
Steve

>  static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)
>  {
>  	pdevfreq->busy_time = 0;
> @@ -50,14 +59,18 @@ static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)
>  	pdevfreq->time_last_update = ktime_get();
>  }
>  
> -static int panthor_devfreq_get_dev_status(struct device *dev,
> -					  struct devfreq_dev_status *status)
> +int panthor_devfreq_get_dev_status(struct device *dev,
> +				   struct devfreq_dev_status *status)
>  {
>  	struct panthor_device *ptdev = dev_get_drvdata(dev);
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
> +	struct devfreq_dev_profile *p = pdevfreq->devfreq->profile;
>  	unsigned long irqflags;
> +	int ret;
>  
> -	status->current_frequency = clk_get_rate(ptdev->clks.core);
> +	ret = p->get_cur_freq(dev, &status->current_frequency);
> +	if (ret)
> +		return ret;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
>  
> @@ -79,15 +92,7 @@ static int panthor_devfreq_get_dev_status(struct device *dev,
>  
>  	return 0;
>  }
> -
> -static int panthor_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
> -{
> -	struct panthor_device *ptdev = dev_get_drvdata(dev);
> -
> -	*freq = clk_get_rate(ptdev->clks.core);
> -
> -	return 0;
> -}
> +EXPORT_SYMBOL(panthor_devfreq_get_dev_status);
>  
>  static struct devfreq_dev_profile panthor_devfreq_profile = {
>  	.timer = DEVFREQ_TIMER_DELAYED,
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
> index e8b5ccddd45c52ee3215e9c84c6ebd9109640282..a891cb5fdc34636444f141e10f5d45828fc35b51 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -52,6 +52,9 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev);
>  void panthor_devfreq_record_busy(struct panthor_device *ptdev);
>  void panthor_devfreq_record_idle(struct panthor_device *ptdev);
>  
> +int panthor_devfreq_get_dev_status(struct device *dev,
> +				   struct devfreq_dev_status *status);
> +
>  unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
>  
>  #endif /* __PANTHOR_DEVFREQ_H__ */
> 


