Return-Path: <linux-pm+bounces-28858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FDADB976
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 21:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074193B292B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F681F473A;
	Mon, 16 Jun 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZFhs0hc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CA1C700D
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101630; cv=none; b=gWsZeIHcl5cOev9vqSGtKd9EAxSvqofE72vTpulHhz8MyE2zcXYzM6vWafX7F79Q+F4OXVH7ozSIKHVTeCXNBoqR6+lIjbRLnELQP3weHd5j7jY3ENi2nMYQRL7oP3evI/9qHnxKX4tH40nKhmpauMdEseeitbZz3fLevmTjnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101630; c=relaxed/simple;
	bh=oTjZaCkA+1T6JDMrGCZtNG0ObPcn3dVAPplPo8dsg7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fid77fbYKTMjyKcZf87U/294vgNAKl+vgCF8UDh1NJ80+DqUsNi0fgIc3xFjx4vxCXFyqfPpkFookoXBbTeEBvt92yMbP4Xziu0SXueqU9gNN1gikVyxa05IgBv2n8k6IFepqbJA0mOUjZg7T1z8YCW7tvI6MaqqBpJA7wAQNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZFhs0hc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750101629; x=1781637629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oTjZaCkA+1T6JDMrGCZtNG0ObPcn3dVAPplPo8dsg7k=;
  b=jZFhs0hcu4zgQQ5gzPWBw506462Bh0mQjMmYcecEfRKo+RtfzpomEGE3
   nx5qIceGlwQ09Du8xBWqNeU+DuXIbybvszcyAz4TNMJNZLOO2QFu69d6Z
   J7MOG4XxriVelxoW+yvysLaj15MCvGuN890f8IhGRElpRoAGf1oOJ/gLM
   kvVEl11t/mbUsCEw1LxyMQ4hJmiGt4GSZ5HI4FzKdvp5+AiBUMuxhJW7V
   GIhIn7z5qXDxLvWmD8ay6yw/rzXg0apzOUl9QKfPjTgrzz8Bj5zxxw92Y
   qMV3LhcPvKba59fUO5e4+vaN+KLQCdiAiqbJKqehnMeuYVrqlp5qXSFu+
   Q==;
X-CSE-ConnectionGUID: WDkLJCa+RNi2jFvW9kjGWg==
X-CSE-MsgGUID: 6Op+c6iVR5WDq0A0/xDwng==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52123903"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="52123903"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 12:20:27 -0700
X-CSE-ConnectionGUID: yfQISjyLQWqa9U3mnFlo0A==
X-CSE-MsgGUID: zAzcEkvaT02mtaKxqMsEEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="152393583"
Received: from moleksy-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.81.92])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 12:20:24 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6FB3711FC1A;
	Mon, 16 Jun 2025 22:20:21 +0300 (EEST)
Date: Mon, 16 Jun 2025 19:20:21 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
Message-ID: <aFBudUgU2TWyDgn8@kekkonen.localdomain>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com>

Hi Rafael,

On Mon, Jun 16, 2025 at 01:21:02PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 8:12 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Folks,
> >
> > The original plan for adding pm_runtime_mark_last_busy() calls to
> > functions dealing with Runtime PM autosuspend originally included a few
> > intermediate steps of driver conversion, including the use of recently
> > added __pm_runtime_put_autosuspend(). The review of the set converting the
> > users first to __pm_runtime_put_autosuspend() concluded this wasn't
> > necessary. See
> > <URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus@linux.intel.com/>.
> >
> > This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> > the _autosuspend() variants of the Runtime PM functions dealing with
> > suspending devices, i.e. pm_runtime_put_autosuspend(),
> > pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> > pm_request_autosuspend(). This will introduce, for a brief amount of time,
> > unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> > an issue. Also, all users of these functions, including those that did not
> > call pm_runtime_mark_last_busy(), will now include that call. Presumably
> > in the vast majority of the cases a missing call would have been a bug.
> >
> > Once this set is merged, I'll post further patches to remove the extra
> > pm_runtime_mark_last_busy() calls. The current set of these patches is
> > here
> > <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm-direct-on-next>.
> >
> > It'd be best to have all merged within the same cycle.
> >
> > Rafael: any thoughts on the merging?
> 
> I'm going to queue this up for 6.17.

Thank you! :-)

> 
> > Would an immutable branch on top of rc1 be an option?
> 
> I think so, but does anyone need it?

I guess it's not mandatory but we'll have now a lot of redundant calls to
the pm_runtime_mark_last_busy(). It just doesn't look very elegant. In the
end it's all up to what the maintainers prefer.

-- 
Regards,

Sakari Ailus

