Return-Path: <linux-pm+bounces-22821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA01A4236A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604F017B83F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89819258E;
	Mon, 24 Feb 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/UIet10"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708A1714CF;
	Mon, 24 Feb 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407379; cv=none; b=ehAYajX9cPuu6TQuHbjyud1LMV3cUvVueq0KmFOihy7xGzKWncwFDCRKIfsXisVhNUfH4xSJzVEInw5X+fAs4xlZkq7NqOxOywWkDstoRCdzbgg7f780LMzIz8cXvBtGAJLAPFfRdoKAzm6GN5zk6LRtBJXmkFWOhG2VNGNe5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407379; c=relaxed/simple;
	bh=dzZWpseyrev5OlunHDNaX/H3YV4k079RCauuuFOelKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlwKUPetKJA+Sj4yHddYiLMSMjTpbNV1Ty7ED6Jnmv5XQJtn5JxGUuU+PO7EqrW6cYvg+ki8HXaMkjnIwMmhcdIvxzZBwxe30gnkz0X2qeExThnA7HlODGxlKXEW87PXKFpedxYUdEBN2poXu2S/uwQiJ+WandTLmMCBT2sFerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/UIet10; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740407378; x=1771943378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dzZWpseyrev5OlunHDNaX/H3YV4k079RCauuuFOelKs=;
  b=P/UIet10gFvil3cezh3xGVeq8gLVBYl69ieg/0vShY5c6L9gzZL1bQbP
   /6eSe6kihsq9Q/pKC3eDTB9uAvLG8flbF/din4QKRlWPNsxoth72ycj/E
   vtCAs7M0LAomPyJEgPeNnKVY1/Z42sHOo322C3ZnrwRbzs8alEHRGSKL5
   EPzETr9WYWO1XcQlfHf3Pq8k7jhnSsRitIOdIXQmjhxl7hUSNRm8yLWHS
   tUoS0cPEs1Lfu6uF+Ye0OdkhyRfvJBXgVhTwdUEigCtQ2a9RK0xLMOj5F
   CYvVYkmqoGMHfeHnTdpJQ4CvkgJbbQQnD8s83HAD0VHvzy42ge6k4+kEX
   g==;
X-CSE-ConnectionGUID: Vi1ZG0tATFuM3h4I4baDuA==
X-CSE-MsgGUID: wYKMN0rKTpmput2ibhHzWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41179717"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41179717"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:29:37 -0800
X-CSE-ConnectionGUID: 1OsmfyM1ToGAN7Rk7KutlA==
X-CSE-MsgGUID: nrHSlI1ESqCvxmEiS39VoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116557596"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:29:34 -0800
Date: Mon, 24 Feb 2025 16:29:30 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, deller@gmx.de,
	andriy.shevchenko@linux.intel.com, sre@kernel.org,
	sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com,
	linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13] Convert to use devm_kmemdup_array()
Message-ID: <Z7yCStqIMZfuWcAJ@black.fi.intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
 <31f8302b-96be-41f1-9e58-c9f8cb2a9524@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f8302b-96be-41f1-9e58-c9f8cb2a9524@sirena.org.uk>

On Mon, Feb 24, 2025 at 01:46:29PM +0000, Mark Brown wrote:
> On Fri, Feb 21, 2025 at 10:23:20PM +0530, Raag Jadav wrote:
> > This series is the second wave of patches to add users of newly introduced
> > devm_kmemdup_array() helper. Original series on [1].
> > 
> > This depends on changes available on immutable tag[2]. Feel free to pick
> > your subsystem patches with it, or share your preferred way to route them.
> 
> Please don't combine patches for multiple subsystems into a single patch
> series, it just makes everything more complex to deal with - it creates
> cross tree issues that wouldn't otherwise exist.

Sure, will split v2 per subsystem.

Raag

