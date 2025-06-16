Return-Path: <linux-pm+bounces-28776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33DADA7D6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C235816BBDD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 05:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B81C6FFD;
	Mon, 16 Jun 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8c3RbGM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C222E11CF
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750053110; cv=none; b=jYTisFzbWr8CjAJI21l/XUnqdai0xaveTifBF3X+EpuD4+zwiVTrvbKZvqzhUkpMF7MglAuC1RZNTMwopu6Cse9o9tIbsC/NQWu+tJJBXKjBaLnnu31gqm92zNsylYhsOiPFcIoJZZOTiWhEHzw/qfosmO3K6FU929rKpTsd+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750053110; c=relaxed/simple;
	bh=oWm0Y1FTYHGbIAy7nqP+X9pq1LKAxDFNAMkOmtIbRU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVeHo1AL15jme5OTegsr++x/VINbzGB0h1aO5BOq7PfaCw7Gt8xGRYtZzZUEuZyTCQJWHFxAzgAIU6fC+zhv3jSLq0o5njn2WrQ+CsbF0F1tk3uegcuYc/xYBrczkpaSSA2w4EgmNuMcHT+6pOrBq8ujwHgxFUJP0bGhqzybdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8c3RbGM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750053108; x=1781589108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWm0Y1FTYHGbIAy7nqP+X9pq1LKAxDFNAMkOmtIbRU0=;
  b=L8c3RbGMYOuUTftrhxdCCzN4VPaUPCgeCn4xT0oyBmqJOyUYccogHLJx
   6L6uH/pC93AcxMyN7CWXanIdT9DoWkd6NJVQUeLQLpmccQQMtBYmenBy7
   OP7okQ5Y6HL2RgZJeZDrO0UFeuHyekwXmOz9Wf/5fE0u5RXuQw+37pAtx
   YAM4k6qAiORUU6SmQLDYIm7rYyaYpwcYTQoaW4MRVsbcxkdjeYFxNTOvb
   ukztAEEEyhS4HMWzmZQMbHrP+F8B2UEQSLaj8GXmg9UOEy5beDCPvTjUp
   kGWxqLvx3QO3tcF14XRxoHeoXBY8MNH6ppkJqgW2guf2TnePbF9QWuHmV
   A==;
X-CSE-ConnectionGUID: s0PMMHxjTT6Udpz/0i9Xig==
X-CSE-MsgGUID: ybT77L4/RziWz7gJVOuiLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51898198"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="51898198"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:51:48 -0700
X-CSE-ConnectionGUID: z8rthcfySU6f3P70LmqoZA==
X-CSE-MsgGUID: bv4oB5/sQEWSVi20FmufYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="153339377"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:51:47 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C4A0511F94F;
	Mon, 16 Jun 2025 08:51:44 +0300 (EEST)
Date: Mon, 16 Jun 2025 05:51:44 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 4/7] pm: runtime: Mark last busy stamp in
 pm_runtime_put_sync_autosuspend()
Message-ID: <aE-w8Bq5EYwOdSzl@kekkonen.localdomain>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-5-sakari.ailus@linux.intel.com>
 <20250410202318.GC29836@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410202318.GC29836@pendragon.ideasonboard.com>

Hi Laurent,

On Thu, Apr 10, 2025 at 11:23:18PM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Thu, Apr 10, 2025 at 06:31:03PM +0300, Sakari Ailus wrote:
> > Set device's last busy timestamp to current time in
> > pm_runtime_put_sync_autosuspend().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I was a bit puzzled by why this function exists. Reading
> Documentation/power/runtime_pm.rst answered that question: if I
> understand it correctly, the function is meant to be used by code that
> doesn't know whether or not autosuspend has been enabled for a device,
> such as core code in subsystems.
> 
> I looked at usage patterns, and found the function being used in drivers
> as well, for instance in drivers/media/i2c/tc358746.c. Given that the
> driver unconditionally enabled autosuspend, is this incorrect usage of
> the API ?

The documentation (Documentation/power/runtime_pm.rst, section 9) appears
to say that functions should be used instead of pm_runtime_put_sync() if
the driver has enabled autosuspend. I wonder if the documentation should be
changed, to tell to use pm_runtime_put_sync() instead, for
pm_runtime_put_sync_autosuspend() indeed is effectively
pm_runtime_put_autosuspend() if autosuspend has been enabled.

I wonder what Rafael thinks.

-- 
Regards,

Sakari Ailus

