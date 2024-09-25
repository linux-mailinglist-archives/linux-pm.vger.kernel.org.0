Return-Path: <linux-pm+bounces-14667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E36098576E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 12:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF102853E6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED015E5CC;
	Wed, 25 Sep 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj/iaYoN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE477107;
	Wed, 25 Sep 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261818; cv=none; b=j6qNL7c7wD8so+Qo2yiCcVAR9qOXOTBQOhJAHUe9IIobS3IImX0R4a9StIDEDzKZ5A6vwtGn8W3X3LaRSW7VsqjIZSd1lr4p8O2XgrpnqruqT/PuNl0RGBDB4m3Uqy15EA38UBekofMbm1DGH9G2tNM7qUxHYqMne4XMxVURs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261818; c=relaxed/simple;
	bh=S48zw2Thvj9X/sYDLC/eM5MCODm3HulyKneN0EYbB5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUdvl6lFw9n/xfCexMFNM4LVmUC8dcXfSbjyibhIC8l5xZ24ilSuR0Z8xHMzKE8S5eBNzK6oapERdAzXnT32mCJXmhvOvrSqZiBMTfLKKbM307h9TR8T6sKLJnFNY5fXzv9gucK5zVTUwwuIzmx505Fbcs+FrEMZb6Mbr/HaBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj/iaYoN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727261816; x=1758797816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S48zw2Thvj9X/sYDLC/eM5MCODm3HulyKneN0EYbB5w=;
  b=Nj/iaYoNAhGEia5UvU14Lfq/RUv2ZBO4z+ouzpDZanrCxMn/22CUclJp
   fEkgmr+skgEJLtZobenc4T67+KcfxKSuokh+0RkGwGY48csWGLImBN8Lu
   XD+YM1q/L3HzLPAZveHk5+qGjuYLE2xOIapkZFS18sfcNbCMaPiqbO4r6
   5uQLDn4K5Hw2YoK8XKWExH7Xr5di5Ctgd9CVcVwVFc4QVdyhP7BfXx8tE
   GAQMWZQbfmwU4j1fDvRzujwjVOmZ+auT0aEeNIt6EuQhaB3CgCzUrDxWZ
   ciy6O6uQn2g3M1I5eq3pu7+GD/MRCwcri+C2XfQexGwro+ihTXqfqT/vi
   w==;
X-CSE-ConnectionGUID: mUCd2YzeTsqOVhcOf/UH+g==
X-CSE-MsgGUID: ssVWWP2QQ5eRktCyaF/s0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36966629"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="36966629"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 03:56:56 -0700
X-CSE-ConnectionGUID: kgu1xSJ6TYKBTwpGW5WPQg==
X-CSE-MsgGUID: tZk4416rRMmvd+xhYjxAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="76237879"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 03:56:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1stPhR-0000000CmpQ-3nEN;
	Wed, 25 Sep 2024 13:56:49 +0300
Date: Wed, 25 Sep 2024 13:56:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v8 2/3] regulator: Add devres version of
 of_regulator_get_optional()
Message-ID: <ZvPscRdWlFPmtCyR@smile.fi.intel.com>
References: <20240925093807.1026949-1-wenst@chromium.org>
 <20240925093807.1026949-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925093807.1026949-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 25, 2024 at 05:38:05PM +0800, Chen-Yu Tsai wrote:
> There are existing uses for a devres version of of_regulator_get_optional()
> in power domain drivers. On MediaTek platforms, power domains may have
> regulator supplies tied to them. The driver currently tries to use
> devm_regulator_get() to not have to manage the lifecycle, but ends up
> doing it in a very hacky way by replacing the device node of the power
> domain controller device to the device node of the power domain that is
> currently being registered, getting the supply, and reverting the device
> node.
> 
> Provide a better API so that the hack can be replaced.

...

> +#if IS_ENABLED(CONFIG_OF)

Do we really need this?

> +static struct regulator *_devm_of_regulator_get(struct device *dev, struct device_node *node,
> +						const char *id, int get_type)
> +{
> +	struct regulator **ptr, *regulator;
> +
> +	ptr = devres_alloc(devm_regulator_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	regulator = _of_regulator_get(dev, node, id, get_type);
> +	if (!IS_ERR(regulator)) {
> +		*ptr = regulator;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return regulator;

Why not using devm_add_action() / devm_add_action_or_reset()
(whichever suits better here)?

> +}

> +#endif

...

> +static inline struct regulator *__must_check devm_of_regulator_get_optional(struct device *dev,
> +									    struct device_node *node,
> +									    const char *id)

I don't know the conventions here, but I find better to have it as

static inline __must_check struct regulator *
devm_of_regulator_get_optional(struct device *dev, struct device_node *node, const char *id)

Similar to other stubs and declarations.

-- 
With Best Regards,
Andy Shevchenko



