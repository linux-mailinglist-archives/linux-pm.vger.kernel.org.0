Return-Path: <linux-pm+bounces-14824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EFB987389
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DC4B29576
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4F217799F;
	Thu, 26 Sep 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvOJGYXg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD329474;
	Thu, 26 Sep 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353588; cv=none; b=X+cXfRs2wrILXrYT3hfftLZnsybhEL9Q842rwsXS9diI3qvH6Y4ueMtv3m6tWuk0XgOjTY3HJEpKrDeB9xWnx6UaK3Z43e21B+5jUO06V242/IJrwd3QF7MvfKFtrrgkkqugYG11bwIvlv875fl0UOT+rdFk2Hj+qnUZfZBv58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353588; c=relaxed/simple;
	bh=rjxzLjusFV53fgrI0naeYMyM31w0t57thRWG/vxGG3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVgmZh0QDd/oHJbdQXQ755PL+VhAMrNwiQ1/xNWcmwjeTHyNcRsJgTFejlYyql7bVt8aYOVymiP+lG7GUG4/hXcQktKtW+4V2P44JFB6yOXLtpO5if5kDQLJsJgFWFXrTFVlXrf6iwmkAU2iCKilRI3nO5sz2B1PUt6x4wpPavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvOJGYXg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727353587; x=1758889587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rjxzLjusFV53fgrI0naeYMyM31w0t57thRWG/vxGG3Y=;
  b=bvOJGYXgsED5A4iL87jGy1PTqQdypaTxrs1jK5r24dqqHh3g60zuX81q
   a8h2UXR4HGV7c266LXa2+4/ZkcdL2g+t8Z27Z+BzsPweuiyPAX2MslDZ0
   yCjzA6zmtT6P/M/cBE2ig/RwMurzEnMd9OrsN2lfD8HWajBQpzH0b2lnw
   tSkRhkNvdlcCeCPb8x+niIdNtU2vPlTtBfHjqt2G6LFzdPvkRAlfWTcft
   vRKS1mufXySYeDZ77atNZYn8USIpaIHfh1S1zf0MtMal2gHHC5K4M6/GF
   CY/v5za1Orvr6CrcxXsd0T6+H0npLU45+9doMtwOwSidpWNM22PhdQA0S
   g==;
X-CSE-ConnectionGUID: ypqeeOLTRj+y/e3UcpkMQg==
X-CSE-MsgGUID: NGGSO8gnRDCKDULXwhgOOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26257347"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26257347"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:26:26 -0700
X-CSE-ConnectionGUID: IHjgVfp/QfGwRQ/D1hWGVg==
X-CSE-MsgGUID: hU7dHfB0Rr2PbmeyHeqmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72439183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:26:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1stnZc-0000000DC1D-1rRn;
	Thu, 26 Sep 2024 15:26:20 +0300
Date: Thu, 26 Sep 2024 15:26:20 +0300
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
Message-ID: <ZvVS7ITg2t-RIh8C@smile.fi.intel.com>
References: <20240925093807.1026949-1-wenst@chromium.org>
 <20240925093807.1026949-3-wenst@chromium.org>
 <ZvPscRdWlFPmtCyR@smile.fi.intel.com>
 <CAGXv+5Gf9+rc+vLcr-JFhO561G8dw38ksV3drat+DyCfWEVakQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Gf9+rc+vLcr-JFhO561G8dw38ksV3drat+DyCfWEVakQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 04:43:52PM +0800, Chen-Yu Tsai wrote:
> On Wed, Sep 25, 2024 at 6:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Sep 25, 2024 at 05:38:05PM +0800, Chen-Yu Tsai wrote:

...

> > > +#if IS_ENABLED(CONFIG_OF)
> >
> > Do we really need this?
> 
> What's the point of going through devres_* stuff if we already know
> _of_regulator_get() is going to fail anyway?

With devm_add_action*() this will be other way around and there are plenty of
APIs done this way. The ifdeffery is simply ugly in the code.

> Also, _of_regulator_get() does not have a stub version for !CONFIG_OF.

So, what prevents us from adding it?

> > > +static struct regulator *_devm_of_regulator_get(struct device *dev, struct device_node *node,
> > > +                                             const char *id, int get_type)
> > > +{
> > > +     struct regulator **ptr, *regulator;
> > > +
> > > +     ptr = devres_alloc(devm_regulator_release, sizeof(*ptr), GFP_KERNEL);
> > > +     if (!ptr)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     regulator = _of_regulator_get(dev, node, id, get_type);
> > > +     if (!IS_ERR(regulator)) {
> > > +             *ptr = regulator;
> > > +             devres_add(dev, ptr);
> > > +     } else {
> > > +             devres_free(ptr);
> > > +     }
> > > +
> > > +     return regulator;
> >
> > Why not using devm_add_action() / devm_add_action_or_reset()
> > (whichever suits better here)?
> 
> Cargo cult from _devm_regulator_get() in this file. However since this is
> meant to share the same release function, both functions need to use the
> same mechanism.
> 
> I could also argue that this is not an action, but an allocation, and so
> devres_alloc() seems to make more sense.

It's rather matter of the naming of the devm_add_action*() APIs, but again,
we have plenty of APIs using it when it's allocation and not strictly speaking
an action.

> > > +}
> >
> > > +#endif

...

> > > +static inline struct regulator *__must_check devm_of_regulator_get_optional(struct device *dev,
> > > +                                                                         struct device_node *node,
> > > +                                                                         const char *id)
> >
> > I don't know the conventions here, but I find better to have it as
> >
> > static inline __must_check struct regulator *
> > devm_of_regulator_get_optional(struct device *dev, struct device_node *node, const char *id)
> >
> > Similar to other stubs and declarations.
> 
> I don't think there are any conventions. This file already has three types:
> 
> 1. Wrap the line with the function name on the second line
> 2. Wrap the arguments; wrapped arguments aligned to the left parenthesis.
> 3. Wrap the arguments; wrapped arguments aligned with aribtrary number of
>    tabs.
> 
> I prefer the way I have put them.

The way you put it despite relaxed limit is slightly harder to read.
I don't remember many headers that do so-o indented parameters. Besides
your way defers the burden of resplit to the future in case one more parameter
needs to be added which will excess the 100 limit.

Also __must_check is somehow misplaced in my opinion (talking from my
experience and this can be simply checked by grepping other headers).

That said, I prefer the way I suggested or something alike.

-- 
With Best Regards,
Andy Shevchenko



