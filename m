Return-Path: <linux-pm+bounces-36456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A14BF0ECB
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C4E188C737
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAB73019C1;
	Mon, 20 Oct 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PaL/OAYl"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD012192F5;
	Mon, 20 Oct 2025 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961091; cv=pass; b=pLA0dM3pIEyqx9t1mQduThddAYRD6l7BEQDTN/NFfwai0HYJ1j1Ksr9Zbl/n3XrLqmIjusZBzynYTWiStgf2dA2Fg2kz/l+nKLpfnaX8YF4BtYlL6CuA/Vz5Uufh2DqCdXZCYehSGXHuNhXkuok8/ghBCX/KrptzptfTETbuHDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961091; c=relaxed/simple;
	bh=6ynyZRXd+tVSkitkXZRJParXJVETR9hXhC8hUwlemlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mafqbWr82DngRFCb7DTlAGeCxDWJAFM7WoikNw7eeIIOgG7cG2BMHbe9TyK0u8IjwU8R1moLaBeBG8A/AISEmden72W5RDOc/ZExj7C3iIP/SamRDaYdZeGQHQBiW///jPd61VHbHSUE/g012J5d1BQ381L7P0kFzdB5VGZXh2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PaL/OAYl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760961056; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C6s9lTyHmYNGClzUwi70t4LJADX3+pHHK1XyNHdHK8pkqZ0ewDbfJbwIXWji+uiKKcmUeuBW6l+zGWUuO+03pxUuW4fSbebuqG/S8KLJ5DCvdHU667ISmBHyMLGiEhevq79+UUaFc7vwqAm5S5mMXdCMvSHVgcf314a5waiB5NI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760961056; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A/c/4oL8Z03NjnVaEgMnJiauD1mgyw2BMdnR11SbtOU=; 
	b=iW82Q/ZctwRGQX/L9mOKuaimgoLOz0fVBR1M3TyCll3uEAfcdqH7w9UXuCqxDvtaM0ZJWtujTQtrBMFIsHz79mKsGlZlxVJUxxPgaOPiETDnmLnSSlwiQ6TTLdJq4ZGBBnB7YHbpk1mKNlRkRjCJStTnqRl8T1J3jkhSJ2wQsK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760961056;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=A/c/4oL8Z03NjnVaEgMnJiauD1mgyw2BMdnR11SbtOU=;
	b=PaL/OAYlpW7pCWoX/nW8/r5Ars7ZMGegZ6sORd7Ra52eVXY8qtIgTV84a6OuCiti
	f1QFLSFukxd6rYxUkCCtp1sRRNyjyBoz59JCtIF/7UUcfAFVo1cFMZUeeejGOl4n1WW
	oo+B23a8e3D8+ZHnwIQTPwmfqEktI30JqVK/GOy4=
Received: by mx.zohomail.com with SMTPS id 1760961055618931.097867690532;
	Mon, 20 Oct 2025 04:50:55 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Karunika Choo <karunika.choo@arm.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v8 4/5] drm/panthor: Use existing OPP table if present
Date: Mon, 20 Oct 2025 13:50:47 +0200
Message-ID: <12781303.O9o76ZdvQC@workhorse>
In-Reply-To: <386ca96d-34b6-4aab-844d-ea720099cf6b@arm.com>
References:
 <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
 <20251017-mt8196-gpufreq-v8-4-98fc1cc566a1@collabora.com>
 <386ca96d-34b6-4aab-844d-ea720099cf6b@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 20 October 2025 10:35:04 Central European Summer Time Karunika Choo wrote:
> On 17/10/2025 16:31, Nicolas Frattaroli wrote:
> > On SoCs where the GPU's power-domain is in charge of setting performance
> > levels, the OPP table of the GPU node will have already been populated
> > during said power-domain's attach_dev operation.
> > 
> > To avoid initialising an OPP table twice, only set the OPP regulator and
> > the OPPs from DT if there's no OPP table present.
> > 
> > Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_devfreq.c | 32 ++++++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> > index a6dca599f0a5..ec63e27f4883 100644
> > --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> > +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> > @@ -141,6 +141,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
> >  	struct thermal_cooling_device *cooling;
> >  	struct device *dev = ptdev->base.dev;
> >  	struct panthor_devfreq *pdevfreq;
> > +	struct opp_table *table;
> >  	struct dev_pm_opp *opp;
> >  	unsigned long cur_freq;
> >  	unsigned long freq = ULONG_MAX;
> > @@ -152,17 +153,30 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
> >  
> >  	ptdev->devfreq = pdevfreq;
> >  
> > -	ret = devm_pm_opp_set_regulators(dev, reg_names);
> > -	if (ret && ret != -ENODEV) {
> > -		if (ret != -EPROBE_DEFER)
> > -			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> > -		return ret;
> > +	/*
> > +	 * The power domain associated with the GPU may have already added an
> > +	 * OPP table, complete with OPPs, as part of the platform bus
> > +	 * initialization. If this is the case, the power domain is in charge of
> > +	 * also controlling the performance, with a set_performance callback.
> > +	 * Only add a new OPP table from DT if there isn't such a table present
> > +	 * already.
> > +	 */
> > +	table = dev_pm_opp_get_opp_table(dev);
> > +	if (IS_ERR_OR_NULL(table)) {
> > +		ret = devm_pm_opp_set_regulators(dev, reg_names);
> > +		if (ret && ret != -ENODEV) {
> 
> Is there a reason to not fail on -ENODEV? I would assume it is a valid 
> failure path. 

Hi,

the -ENODEV logic wasn't added by me, it was added in
Commit: a8cb5ca53690 ("drm/panthor: skip regulator setup if no such prop")

with the justification

  The regulator is optional, skip the setup instead of returning an
  error if it is not present

I will not be changing anything about this logic in this patch set,
as it is not in scope for MT8196 enablement, since MT8196 does not
use this code path at all.

Kind regards,
Nicolas Frattaroli

> 
> Kind regards,
> Karunika Choo
> 
> > +			if (ret != -EPROBE_DEFER)
> > +				DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> > +			return ret;
> > +		}
> > +
> > +		ret = devm_pm_opp_of_add_table(dev);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		dev_pm_opp_put_opp_table(table);
> >  	}
> >  
> > -	ret = devm_pm_opp_of_add_table(dev);
> > -	if (ret)
> > -		return ret;
> > -
> >  	spin_lock_init(&pdevfreq->lock);
> >  
> >  	panthor_devfreq_reset(pdevfreq);
> > 
> 
> 





