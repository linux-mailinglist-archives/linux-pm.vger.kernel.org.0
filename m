Return-Path: <linux-pm+bounces-23645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C0A56EE1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06B03AE924
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4723ED5A;
	Fri,  7 Mar 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XID4B6m7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907618A92D;
	Fri,  7 Mar 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367857; cv=none; b=bdIC0kf3w/RJo11eMy88f4UcznnIO83YtMfzXh7CNMXsdUARcmgYbJEHCq/274cVb3XLdUZ6ztOWVUoj6c+uM6RcdyrYyuKgkojg0MdKFPg9SKZH3x+OdbLJFNHOmtBAlH+3IdmuDxsnz/UhPlkEuA//HHMFFZBjronay4hpiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367857; c=relaxed/simple;
	bh=ayzf6oEExh0PtPYBdOQ9otAoW9YyMP1K3uyxhu94de4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ21vrwfoye5sZiSvlp0LWYxLB9h5iDuiC2Fy4buo4GviPvRBgkucGPxq57qJPBYAfFK6o/nPP05qhaP+MmM5rO1A5GwAPVcRKYbq7mpDtUnrPF6xkHOkjJxUsuS9UuN8ALNUL/jwj9nXOf10qxsCHET6Ylo1GJl9N4T9VtNcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XID4B6m7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741367856; x=1772903856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ayzf6oEExh0PtPYBdOQ9otAoW9YyMP1K3uyxhu94de4=;
  b=XID4B6m7/p57qenkzi84NCW1cmVX4HOs2HWsPEB792VvcXhXb30JtZCh
   tIcwuV76F1V1Bg1YqRNdmEfzf9mJ/VBzgqrcwALdEed7EamIGNZ2a6M9r
   dZjM0HZLoIBNCru5SRsWrBlZf0FPmdR5SicSH8H1r+YUPV91jq+4MK3WM
   gYWMnZisCavS33mXNjRW6+/LZZws1tPsGpmGQ1PknR+3yZhM3eHk3hdRP
   XyJM5Ysu/2PI7xc2HIIRQaTl5bT6oUNgTqHUXJNCUJ03gbwCRaH2C7okA
   T8nZwniScknRLSdxKfYODr6U4J8SIclOd0Xnat0uwlNVpocE2x6wlxuKz
   Q==;
X-CSE-ConnectionGUID: +BECUutUSReoKZxEpt71Gg==
X-CSE-MsgGUID: hrT4S4GRR76dm+JFeeWwUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53414609"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53414609"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:17:35 -0800
X-CSE-ConnectionGUID: aQOK4EGdTBuEwbKEaJD8SQ==
X-CSE-MsgGUID: 9gRU9mptSOCxD63e8cCy+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124402684"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:17:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbKA-00000000T8j-2Fr2;
	Fri, 07 Mar 2025 19:17:26 +0200
Date: Fri, 7 Mar 2025 19:17:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Message-ID: <Z8sqJhbqEBla_Ch7@smile.fi.intel.com>
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
 <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-vsprintf-pcn-v1-2-df0b2ccf610f@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 12:19:08PM +0100, Luca Ceresoli wrote:
> %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> add %pC{,n,r} format specifiers for clocks") introducing them does not
> clarify any intended difference. It can be assumed %pC is a default for
> %pCn as some other specifiers do, but not all are consistent with this
> policy. Moreover there is now no other suffix other than 'n', which makes a
> default not really useful.
> 
> All users in the kernel were using %pC except for one which has been
> converted. So now remove %pCn and all the unnecessary extra code and
> documentation.

You seem forgot to update translation(s) of the documentation.

-- 
With Best Regards,
Andy Shevchenko



