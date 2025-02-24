Return-Path: <linux-pm+bounces-22801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E9FA41F4B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3361E18859B3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F0233723;
	Mon, 24 Feb 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGbUDI3j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249571DDE9;
	Mon, 24 Feb 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400758; cv=none; b=b2HBVERB/xrS2e+sd7Y2dVTNHe71CY9t9BD04tGepin5tUUXDWqeYWmUZcVCSZSwbh+PH2lYE39AWTA8ZjIV80qxe1yvQXryxdHEwlHZHjxNBaeckPgrJ8bPouDAS6ybHbtZMelDd5nkhzxjH8hnhqIawySLSYcrz9J69Cn8SUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400758; c=relaxed/simple;
	bh=I4zwzRfgVjDsqL3gEcvnfx+MpbnW+WUPLHL5AHyvtfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+ck0SEvXsQnet4VV/hqn1ubG0e/9TjPJUthNhbtwtHKWjOc/66s7+Z3FsP0+LyrZINYEChVg7qLHSPJlKcZOZsVOlMvvj0hk1XPlPsdxRhODiGigAuvbQ8y57yhjVwTyI8qP5PYAX8yEWax4IrYQufQmY+WkZaNZemw0ekCCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGbUDI3j; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740400757; x=1771936757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4zwzRfgVjDsqL3gEcvnfx+MpbnW+WUPLHL5AHyvtfs=;
  b=bGbUDI3jU+8G0lMyD1MaN7WzggW3cGswR8plSEdS/kZ8yF9QiO1ZnmB7
   iyyT2ga7XWIV3kEWS/Vkb0lUMmkyJhFIb2JrhRd5byH+otMfq5qWjZgXG
   nb5lVB9Jz04qFA+0az7KgybuKoAQJEl+QbFxcz0SFpFhbAtfltyOOWTap
   J/wQQ+IGnkHly0fgkmXjstjI/xdXO99yE4SNcerwDwnBn/ToCJ9LE/HzN
   REzR33rcpPF71omBNrUSbrcTjzLoi9MGsv9S4E2En44+HIUd2Y0ZCjEwH
   +fPZkeJZY3PPOOd6vyMK8yZucKxqrhrCy8p1i6fdW9T1Kw0gn5o8hHELx
   w==;
X-CSE-ConnectionGUID: xr1416diTaKv3HKJZr8+XA==
X-CSE-MsgGUID: E/dN3DWHQ/O9NQ+c8Fs2eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44804206"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44804206"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:39:16 -0800
X-CSE-ConnectionGUID: TOwLHXo3SgmVXIMwNmb0vQ==
X-CSE-MsgGUID: z2UkMDxrQkWgeU8zvFf0YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121321317"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:39:10 -0800
Date: Mon, 24 Feb 2025 14:39:07 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
	deller@gmx.de, andriy.shevchenko@linux.intel.com, sre@kernel.org,
	sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13] Convert to use devm_kmemdup_array()
Message-ID: <Z7xoa9FbuvIaTJFt@black.fi.intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>

On Fri, Feb 21, 2025 at 10:23:20PM +0530, Raag Jadav wrote:
> This series is the second wave of patches to add users of newly introduced
> devm_kmemdup_array() helper. Original series on [1].
> 
> This depends on changes available on immutable tag[2]. Feel free to pick
> your subsystem patches with it, or share your preferred way to route them.
> 
> [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> [2] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com

Update: Anyone wishing to pull from this series, please use the updated
tag[3]. I'll wait for a few days for review comments and send out a v2
with fbdev fix.

[3] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com

Apologies for the inconvenience.

Raag

