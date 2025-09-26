Return-Path: <linux-pm+bounces-35461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22386BA3996
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D717A625954
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312632EACF2;
	Fri, 26 Sep 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCjcM4+H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E910E3;
	Fri, 26 Sep 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889538; cv=none; b=aRDDSqRqAq0HuJaaJb5J1I5ndDgNkDsRlwxSAy7ALvPzEOumwuqZaih0DbVcQ/BVQoevgwXwXGqFokOIs48IjqvLCDd0Wrtxn4fvC/DMt31CeOXr/XiqNBTVoWnCntiZNkSxIVnBsWSBN1Rd5JKiU+Fl5ucBxAKpF/MvDxBBAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889538; c=relaxed/simple;
	bh=Mymc06sNKj3cKZ4fq/fmbuZLW0+P4uQ8+npbuGxYEFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le6Qpm4Od/lUr4naCLmhw38UBsPSYuLZGP2PihbnARNgPEbVQGw11d4ZUGNcjAAp61bXRkNTdyKIq32ggXGPYURnumRmYBBBYiQRaNBFDk6LaJ/Xgk3Cj/dAzPYzA4ap69ISEyyoDcKkH4C/Ith/GenYUdKBUvgBbVUATihbHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCjcM4+H; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758889536; x=1790425536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mymc06sNKj3cKZ4fq/fmbuZLW0+P4uQ8+npbuGxYEFA=;
  b=bCjcM4+HTDZRnuQaZuFcRebzoxZKKWjPUbmsIcZqH5MXRWf1cr5cQfWc
   ZtsxHmk4CeVCCPpjj9b0uBf3wjJOb936kbfPEHG9QkefBgm46+yJGOPyC
   TU5n/XHwdy9V8/Szgozr2NHShsCWw4x/5kXWHFd907IuzLIXMmrW/eL1R
   B3fO80AhIMFF2xot5tuYgn/Dksm+cEmnK9LD34OmCFY/oIT/EoFXc/hsL
   KN9U+O8qpVrINZq++OQBRrPwKd6XSLTz9WF8YTpM4i1qplj4ff6tdiLUk
   c+KrnAOM09pAh2DyHdIXIpZBfy5ZUcTOP91rZ5YU/11Cz2mVvWPcsxsV4
   A==;
X-CSE-ConnectionGUID: /BV+KRssRliIuoMyIs5mRw==
X-CSE-MsgGUID: DMxTJiqmS8qYVhG0KTMBpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="86663893"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="86663893"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:25:36 -0700
X-CSE-ConnectionGUID: SWPVjAKlTdyvdSHFP1XSWQ==
X-CSE-MsgGUID: /KXBxMY1TF65t98KzcKY1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="214733880"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:25:34 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 771DA1202BC;
	Fri, 26 Sep 2025 15:25:30 +0300 (EEST)
Date: Fri, 26 Sep 2025 15:25:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pm@vger.kernel.org,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v2 2/3] PM: runtime: Make put{,_sync}() return 1 when
 already suspended
Message-ID: <aNaGOgGm7QRWEJ1m@kekkonen.localdomain>
References: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
 <20250925124216.v2.2.I2cdc7d58d89da55bfd53d78f81c7e08e4b10eb80@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925124216.v2.2.I2cdc7d58d89da55bfd53d78f81c7e08e4b10eb80@changeid>

Hi Brian,

Thanks for the update.

On Thu, Sep 25, 2025 at 12:42:15PM -0700, Brian Norris wrote:
> The pm_runtime.h docs say pm_runtime_put() and pm_runtime_put_sync()
> return 1 when already suspended, but this is not true -- they return
> -EAGAIN. On the other hand, pm_runtime_put_sync_suspend() and
> pm_runtime_put_sync_autosuspend() *do* return 1.
> 
> This is an artifact of the fact that the former are built on rpm_idle(),
> whereas the latter are built on rpm_suspend().
> 
> There are precious few pm_runtime_put()/pm_runtime_put_sync() callers
> that check the return code at all, but most of them only log errors, and
> usually only for negative error codes. None of them should be treating
> this as an error, so:
> 
>  * at best, this may fix some case where a driver treats this condition
>    as an error, when it shouldn't;
> 
>  * at worst, this should make no effect; and
> 
>  * somewhere in between, we could potentially clear up non-fatal log
>    messages.
> 
> Fix the pm_runtime_already_suspended_test() while tweaking the behavior.
> The test makes a lot more sense when these all return 1 when the device
> is already suspended:
> 
>     pm_runtime_put_sync(dev);
>     pm_runtime_suspend(dev);
>     pm_runtime_autosuspend(dev);
>     pm_request_autosuspend(dev);
>     pm_runtime_put_sync_autosuspend(dev);
> 
> Notably, I've avoided testing the return codes for these, since they
> really should be ignored by callers, and we may make them 'void'
> altogether:
> 
>     pm_runtime_put(dev);
>     pm_runtime_put_autosuspend(dev);
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

