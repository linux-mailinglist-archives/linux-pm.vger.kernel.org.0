Return-Path: <linux-pm+bounces-13560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D096BC42
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184DA1F26552
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46951D88BC;
	Wed,  4 Sep 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMFUFQqK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7E1CDFB8;
	Wed,  4 Sep 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452919; cv=none; b=uZkRrT42hfqNtCxxogeaBZNzgZkfgbMUF9WiOdYr7bYgKcUWd5DpBWY5XHGl7V90KFzlzVSH2pwXCPo0afIfUY9s2DzHOVucK8yKmlG0fseoyeTn7hjcccN4ji9QdaiP5ioW9n6ejKENZieqHFUg5Pq2O4xnPpYx4FODmYQy2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452919; c=relaxed/simple;
	bh=2oH2weOsx5gz/t9BNwlSULeeoV/1AGI67RXLfT5l/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkXk0jEuPhntKY6ioJu6D4rOakBavshquRsutTFtkMns13L9Xxvt6DJIUUAQCm8l3QbmaIYlOG5ngAVG89FKKjP4fvl+F0bvOlhQlQtOywVATxODqRweHkVerOSgAE6ZviSd7Yrz1kQMNwFgD3kOb58v/49wHKWu7CiDgMIm52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMFUFQqK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725452918; x=1756988918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oH2weOsx5gz/t9BNwlSULeeoV/1AGI67RXLfT5l/Hw=;
  b=EMFUFQqKEn3Da8ZwrUb6TnGxLVvFNCpJhJSpOtQEIZH8ZGRtQ5Uv1XIz
   PPQSjGUif3B9fOgNm2QnVPgNFptcCv/4atrhpwg+FIQCycHccrtbGS9Tf
   +I+fVbnjXgp/iAcOvGTMTVUiryG3GLWRnF2Um8Hxp4iws2uzt0GP96ota
   PWHHN9nKAtvfMxzkj+MQdVed7otlPMNKfTgZsep8Q5QWZThAnBA+IO/MJ
   SGOr+wlMJucZoeq1e6tLZh4Ue3y+E922dnRUadGYddJFJwSqJ8FlOOhhR
   Vm4igsrlsA9UEN8DnGnbIzoY+59rQjZoh7n8qfptdI9V5OKbNpYBmEF7E
   w==;
X-CSE-ConnectionGUID: VoV0+aekRa+eviHo5C967Q==
X-CSE-MsgGUID: L/I0waAlQkCCIbF7uBg8CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24061360"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24061360"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:28:37 -0700
X-CSE-ConnectionGUID: qhJ8VaFeSuGVrQd6SYPwXQ==
X-CSE-MsgGUID: 8Bfzjk6MQyOtJHpJPkp5TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69884065"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 04 Sep 2024 05:28:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 329461BD; Wed, 04 Sep 2024 15:28:35 +0300 (EEST)
Date: Wed, 4 Sep 2024 15:28:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
Message-ID: <20240904122835.GG1532424@black.fi.intel.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de>
 <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>

Hi,

On Tue, Sep 03, 2024 at 11:10:41PM -0700, Kenneth Crudup wrote:
> 
> ... or, maybe not. Turns out that sometimes my system can't suspend (just
> hangs, spinning hard somewhere based on the heat and the fans) when plugged
> into a Thunderbolt dock at the time of suspend.

Can you create a bug in bugzilla.kernel.org and attach full dmesg so
that you enter suspend with dock connected (so that the issue
reproduces)? Please also add "thunderbolt.dyndbg=+p" in the kernel
command line so we can see what the driver is doing. Also probably good
to add the lspci dumps too as Lukas asked.

