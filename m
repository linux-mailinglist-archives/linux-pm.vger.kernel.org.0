Return-Path: <linux-pm+bounces-14861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BB89881C8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 11:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FEF1C21F46
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0337C186616;
	Fri, 27 Sep 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4igTBc7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA5185B70;
	Fri, 27 Sep 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430545; cv=none; b=IVuIcHFqPbrAHZf2Kdwcxro+TnWm6wqieTuY9GtivxibTFDmUmJtVK75pZS4eTpgohDvYOW0N+yko6TCVJBEPaWNN//PJgYldq6iH3z6FMI/cc8UuntsWcp1MFVqInNxp9hYm6iJl+d2srTE5H+x87pp1V9rVuJEVK6NT/rJsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430545; c=relaxed/simple;
	bh=6Pe2Go0yn1c7MxwBdsnnPYOewixVQPGWJ9HMIvscZ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9amcuF0jwjdhwNOc6bItwwvFSmSvatbAq+6xD/rY1vwAp9ttZcm3/8n7TweGC2rFtGxPNMTT1B7NEXpFPBGGJAXbB9vDx33wereSAVmZEymPcZ+kqOniwWFbexBscL3lROmHoa5SddAvnOI5QU3KyWI0W4tK0ZX77In/SiFpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4igTBc7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727430544; x=1758966544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6Pe2Go0yn1c7MxwBdsnnPYOewixVQPGWJ9HMIvscZ8o=;
  b=R4igTBc786M0teC4uj1GxHHcPFlv3GismbVIEZCryg3gcAR4Aab9nfBA
   waVly8mGfPTUh4QkJUd+5K3RAfg9fJKCmbOJB36kyY8ehppahmqPoO6/R
   9+bOgV8gp5129ISQJoqcBt9HeHM/CYhjIXuFTq8Slx5PQzUKGHPYimeT8
   Pyt0GSuDSsGsUAKOuhi49T3CaU76yow8jxpqX9w1KZeSZNHcVQWc27V7+
   eiGrRsZTyWR6gcp2SFm0cc9CTc8ZwFNx/OvIy7o1LFjv8oULBxwq910w3
   x/cQBFfnxYI8dQvjmb11j8cWS7oUf0bKf0Y4+ptw5RwgQoLrKKd9M/ErC
   Q==;
X-CSE-ConnectionGUID: 7jqagqY/RzSCR0juaw+oFg==
X-CSE-MsgGUID: W0W4m2Q5RPujaiYUrZ2m7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37149841"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="37149841"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 02:49:04 -0700
X-CSE-ConnectionGUID: 9aWBSpURTpuXHkrgFTdtBg==
X-CSE-MsgGUID: Q19sk9QDS2ab/YNt173aOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72143095"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 02:49:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1su7ar-0000000DWcI-29Th;
	Fri, 27 Sep 2024 12:48:57 +0300
Date: Fri, 27 Sep 2024 12:48:57 +0300
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
Message-ID: <ZvZ_idJsmuzNhFMc@smile.fi.intel.com>
References: <20240925093807.1026949-1-wenst@chromium.org>
 <20240925093807.1026949-3-wenst@chromium.org>
 <ZvPscRdWlFPmtCyR@smile.fi.intel.com>
 <CAGXv+5Gf9+rc+vLcr-JFhO561G8dw38ksV3drat+DyCfWEVakQ@mail.gmail.com>
 <ZvVS7ITg2t-RIh8C@smile.fi.intel.com>
 <CAGXv+5EV4nNiAneajqr4VBkX4TO3zV76yqBM_u81ZMNjU52Bvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EV4nNiAneajqr4VBkX4TO3zV76yqBM_u81ZMNjU52Bvw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 27, 2024 at 12:38:35PM +0800, Chen-Yu Tsai wrote:
> On Thu, Sep 26, 2024 at 8:26 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Sep 26, 2024 at 04:43:52PM +0800, Chen-Yu Tsai wrote:
> > > On Wed, Sep 25, 2024 at 6:56 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Sep 25, 2024 at 05:38:05PM +0800, Chen-Yu Tsai wrote:

...

> > > > > +#if IS_ENABLED(CONFIG_OF)
> > > >
> > > > Do we really need this?
> > >
> > > What's the point of going through devres_* stuff if we already know
> > > _of_regulator_get() is going to fail anyway?
> >
> > With devm_add_action*() this will be other way around and there are plenty of
> > APIs done this way. The ifdeffery is simply ugly in the code.
> 
> It's still extra code that doesn't get compiled out.

Are you sure? In case of the stub the compiler should go with a "dead code
elimination" optimisation and get rid of most of it (yes, I admit that it might
be the overhead for the exporting a function which returns a constant).

> > > Also, _of_regulator_get() does not have a stub version for !CONFIG_OF.
> >
> > So, what prevents us from adding it?
> 
> Because there's no need if the only internal user isn't using it.
> 
> I could also move them over to of_regulator.c.
> 
> _of_regulator_get() stays internal to that file, and devm_regulator_release()
> gets exposed instead.
> 
> Does that sound better?

This sounds good to me!

...

> > > > > +static inline struct regulator *__must_check devm_of_regulator_get_optional(struct device *dev,
> > > > > +                                                                         struct device_node *node,
> > > > > +                                                                         const char *id)
> > > >
> > > > I don't know the conventions here, but I find better to have it as
> > > >
> > > > static inline __must_check struct regulator *
> > > > devm_of_regulator_get_optional(struct device *dev, struct device_node *node, const char *id)
> > > >
> > > > Similar to other stubs and declarations.
> > >
> > > I don't think there are any conventions. This file already has three types:
> > >
> > > 1. Wrap the line with the function name on the second line
> > > 2. Wrap the arguments; wrapped arguments aligned to the left parenthesis.
> > > 3. Wrap the arguments; wrapped arguments aligned with aribtrary number of
> > >    tabs.
> > >
> > > I prefer the way I have put them.
> >
> > The way you put it despite relaxed limit is slightly harder to read.
> > I don't remember many headers that do so-o indented parameters. Besides
> > your way defers the burden of resplit to the future in case one more parameter
> > needs to be added which will excess the 100 limit.
> >
> > Also __must_check is somehow misplaced in my opinion (talking from my
> > experience and this can be simply checked by grepping other headers).
> 
> Seems correct to me. It's between the return type and the function name.
> From the coding style doc:
> 
>  __init void * __must_check action(enum magic value, size_t size, u8 count,
>                                    char *fmt, ...) __printf(4, 5) __malloc;
> 
> The preferred order of elements for a function prototype is:
> 
> - storage class (below, ``static __always_inline``, noting that
> ``__always_inline``
>   is technically an attribute but is treated like ``inline``)
> - storage class attributes (here, ``__init`` -- i.e. section
> declarations, but also
>   things like ``__cold``)
> - return type (here, ``void *``)
> - return type attributes (here, ``__must_check``)
> - function name (here, ``action``)
> - function parameters (here, ``(enum magic value, size_t size, u8
> count, char *fmt, ...)``,
>   noting that parameter names should always be included)
> - function parameter attributes (here, ``__printf(4, 5)``)
> - function behavior attributes (here, ``__malloc``)
> 
> > That said, I prefer the way I suggested or something alike.
> 
> Two people arguing over style that is not clearly specified in the coding
> style doc is probably wasting time. I'll use what `clang-format` gave:
> 
> static inline struct regulator *__must_check of_regulator_get_optional(
>        struct device *dev, struct device_node *node, const char *id)
> static inline struct regulator *__must_check devm_of_regulator_get_optional(
>        struct device *dev, struct device_node *node, const char *id)

With all my hatred towards this clang-format "feature", i.e. open ended
parenthesis, this looks better than your original variant.

-- 
With Best Regards,
Andy Shevchenko



