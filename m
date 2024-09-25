Return-Path: <linux-pm+bounces-14666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB659985766
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A902284829
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1615C136;
	Wed, 25 Sep 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSibQZSz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192177107;
	Wed, 25 Sep 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261601; cv=none; b=rJxpTLqF9nB9XSnubpWaSSZrNiqz8vJLSpW+uC6GtmJUumi9jbARp/dD4fK5zYfsSjCRs3n37LzW22GsA1AybZrQ+K8xerQJ4i5sFDTRjyyor6zIvm89EBHgX1bvmbKJSwcrthW0iQ+juWk0uxSyqxMXfnVol/f8sk34fy6SIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261601; c=relaxed/simple;
	bh=UrggVek0lwhDuqSp26+4KJb/uG5YqBJR8jmgQcSwkr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2biOHkrAcZRMYREQsK65vcaAvpnv7XFpbt9IALoMrxo0alXVwSbzBTjc3RiiUrE3EBG2I6sDQdbfbP1k73lLGw3arh1kBq/0tEubNBoO1RtqkZC4FBKwcgdvylFMnu09z7ChfRtOBmG+J2gNA1T9d19vKBafn6IjcH8HpYMEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSibQZSz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727261600; x=1758797600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UrggVek0lwhDuqSp26+4KJb/uG5YqBJR8jmgQcSwkr0=;
  b=CSibQZSzRK4IAF2pnryeCYY9BqjUN+L7sIJ1HgpuA3PBBRrA+iXg6fT2
   C7K1kTpGeVjW5APXztyNZk9zP/7FaQzBQtqzf5BDY0e9ofqyAVu/AMptx
   b8ygCN6cTDuZzAIxOTjU0+uHr8m7hmS+O2txQUJrIKYyDaJDaYS1AAvC4
   iohCyWKj85Lg2Kf314MfvFkfAag2yYJdJjaTYSq7XqgJFeYD0nURRvWwY
   KKbxo0aXPo/JTc3KRYWUinTIPqY28IjKTiZJtUZZq+GCrpUdjV7mtarVw
   XIguB9QvUVxqYKUUhFkzVTFb/LgpvZlFMu2hQWVJRoTjKPUppx1Ru5sNb
   Q==;
X-CSE-ConnectionGUID: 5MH7jcIsQcOi3vklXOC5tQ==
X-CSE-MsgGUID: p4OxH3RbTM6jGg+/UBfeRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43778482"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="43778482"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 03:53:19 -0700
X-CSE-ConnectionGUID: tE8JEtRNTYaDYeepXkZmYg==
X-CSE-MsgGUID: F12ogL8UTO6fX6+00sK67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="102491039"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 03:53:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1stPdw-0000000Cmma-3y2V;
	Wed, 25 Sep 2024 13:53:12 +0300
Date: Wed, 25 Sep 2024 13:53:12 +0300
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
Subject: Re: [PATCH v8 1/3] regulator: Add of_regulator_get_optional() for
 pure DT regulator lookup
Message-ID: <ZvPrmJo5WWqAHrhb@smile.fi.intel.com>
References: <20240925093807.1026949-1-wenst@chromium.org>
 <20240925093807.1026949-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925093807.1026949-2-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 25, 2024 at 05:38:04PM +0800, Chen-Yu Tsai wrote:
> The to-be-introduced I2C component prober needs to enable regulator
> supplies (and toggle GPIO pins) for the various components it intends
> to probe. To support this, a new "pure DT lookup" method for getting
> regulator supplies is needed, since the device normally requesting
> the supply won't get created until after the component is probed to
> be available.
> 
> Add a new of_regulator_get_optional() function for this. This mirrors
> the existing regulator_get_optional() function, but is OF-specific.
> The underlying code that supports the existing regulator_get*()
> functions has been reworked in previous patches to support this
> specific case.
> 
> Also convert an existing usage of "dev && dev->of_node" to
> "dev_of_node(dev)".

I thought I gave a tag already...
Whatever, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



