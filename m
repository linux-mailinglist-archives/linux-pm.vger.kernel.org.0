Return-Path: <linux-pm+bounces-29464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE1AE77A4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D2F163AA3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D91F4C8B;
	Wed, 25 Jun 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPC7SwqZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A81A3A8A
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834798; cv=none; b=MjuSH4G4wfBrFt92YzBvwJfb7+NFkviA1yYjOW9mw0pRz8jA2fHRb7TfOoBPzhDgPMbyAhOLNMhBktOndJuRTA7cFA7aosudklJg94yYa/416VT4ccGCx97zmViX6X3C2q09HIajEhjyQUmwT/+b6MllQYDVBjti/xYEWoemYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834798; c=relaxed/simple;
	bh=tPCXmqs2gokC/P6J7As2O+LeHBfUXGl9J2Pzz83/foQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXh71Cgasx4FtSG1JsiLsqI1gUYTHqGfT3OnsDDrEmn1BS99Az6NgWWT1xHM2UEW8vR/COSQPwfbCi8jVrHcsbHKNPET2fOcbYby2AvEfAXuxySO0rTsl+gytGeuIaZh5xLke3HchBnwH4qcGbM8+AkBjqF/rPnwI3ZbtGmpwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPC7SwqZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750834796; x=1782370796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPCXmqs2gokC/P6J7As2O+LeHBfUXGl9J2Pzz83/foQ=;
  b=DPC7SwqZzUN8CGmtNNj21op40Ocx2Pv7hZaPhTaQgT9A4r+iPAgCdofk
   nMmHVx1ds89JBU0A1IsBZjlXKxTxhXr1tQJaSZ0HLA8RTj6Yj+Ax3BKiM
   WfbWXHBmiadX27iEl18KVEUxuh5VQ2guGB+VRqJYO2PssvWZcpK4LMOdZ
   YkEt8mNxMpob0yyRjKJ4/t0p2Qa4a0i4PWzrt4eWA7n6ZWfJOInelpgay
   CN92k8zJjFJ4zc4fXpNlgZNGH8K9r9RqpDRIvmKN4uZ+LbKoCsCdyb8q/
   Ge49BzwUkpIY2AmZR67u2YtYVBTVFPo7+70uy71H31HQ+iUkbo9coR79M
   Q==;
X-CSE-ConnectionGUID: yvhOExqGSGmZEbyHn6Ug7A==
X-CSE-MsgGUID: u4XT7xOoR6u+cxmNsGsw9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53226878"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53226878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:59:56 -0700
X-CSE-ConnectionGUID: /hggyb17SMetQAYzbkgp9A==
X-CSE-MsgGUID: +Llqw73gSfiSvyKTrLQpvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="183168078"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.155])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:59:54 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 36DE311FB5F;
	Wed, 25 Jun 2025 09:59:51 +0300 (EEST)
Date: Wed, 25 Jun 2025 06:59:51 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
Message-ID: <aFueZ_xfnbrQO0Wx@kekkonen.localdomain>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <4433c6e5-44d4-49e7-a034-aefb9a0ff538@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4433c6e5-44d4-49e7-a034-aefb9a0ff538@suse.com>

Hi Oliver,

On Mon, Jun 23, 2025 at 03:28:45PM +0200, Oliver Neukum wrote:
> On 16.06.25 08:12, Sakari Ailus wrote:
> > Folks,
> 
> Hi,
> > This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> > the _autosuspend() variants of the Runtime PM functions dealing with
> > suspending devices, i.e. pm_runtime_put_autosuspend(),
> > pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> > pm_request_autosuspend(). This will introduce, for a brief amount of time,
> > unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> > an issue. Also, all users of these functions, including those that did not
> > call pm_runtime_mark_last_busy(), will now include that call. Presumably
> > in the vast majority of the cases a missing call would have been a bug.
> 
> Now that I think about this, I am not sure of the logic behind this.
> It seems to me that you are making marking a device busy and dropping
> the reference synonymous.
> 
> Is the time you use to derive the likelihood determined by the start
> of IO or the end of IO?

The purpose of autosuspend is to delay device suspend in case it might be
used again soon after the point of dropping Runtime PM usage_count. Are
there cases you're aware of where pm_runtime_mark_last_busy() isn't
directly followed pm_runtime_put_autosuspend() or one of its variants and
it is desirable? Just stamping the last busy timestamp is a trivial
operation so one or two extra in a few places isn't really a problem.

-- 
Kind regards,

Sakari Ailus

