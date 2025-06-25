Return-Path: <linux-pm+bounces-29472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F52AE7C94
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2562D7B577F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164762E612D;
	Wed, 25 Jun 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+VgBATg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DA2BEFEE
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842943; cv=none; b=A+cObmjY3m52XPA4OcDvrirJP+HYN2EUkSTOo8or+l+DDhkyuryuncXWbk7mbEog7uVK+G3nrBjS7zbL5MJUw73FZ/XWgZWOoWbYHI09BGiYPNSrgZR4QU321HtTTwrhwoInRUqtNSzIynEcrig/HqaZX90shGBxEtXBj3ASu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842943; c=relaxed/simple;
	bh=iqOA4PT0ikDwgBLflatMHnrD6+ts87+3OmzVy9B9WLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFmPvJdtf/N69nGuX8ojGPFXPX5rJwWdK3b02NPiqO9PZEd9EtyL/G3C+oTpL/plLn2+SwD+OgVEIZlS+bnbablxYMKeBtiV01rNZtIVY9cn+e9zcDmWP7ItWIIwu6qgvaKurfdtn10Mrp7EMDhXBtFsQ2aGTkJGD3ckT+QZ3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+VgBATg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750842940; x=1782378940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iqOA4PT0ikDwgBLflatMHnrD6+ts87+3OmzVy9B9WLQ=;
  b=C+VgBATg8tq2Dg0L9P0cK/XKiTQ5auVPvsvdkSpbdRf5yBHXM/QblYW5
   YTdNWjXhHFpY4RjgKnoa19jyKaNumc7mCi5BAPvnfuCEbaOkUG4pyfXzf
   QJFPc78xe4m7cTjZwXhV+i9/gyEmZMJqwOJzaQetnIx/czN8UQ5kE7wVG
   /839b5P+QSFsBlqF2uo9Vv4XXqUS6dm34yOIKmgffbfsH/wHO6IZnst9J
   9q2BNImZ4qv7+/GdvWmB3xffsWHB1HSUfq6spEUpxQUzPtQ5ZbTB/QZ5u
   msLTDzA/kuYRixsQSosOyAmGOwVRfwfeJ/EC0GiXzYygKyGiKEsNmNS6p
   g==;
X-CSE-ConnectionGUID: w7tkufGmTh2ZTE3PiObMxA==
X-CSE-MsgGUID: e0nIxvo9QVKb97AhzqzGpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="75641588"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="75641588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 02:15:37 -0700
X-CSE-ConnectionGUID: /jyt3jsTT6OoeryfWdTkpg==
X-CSE-MsgGUID: 5QhQcS3yRumg2bPKh7loRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="183199740"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.155])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 02:15:36 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C256F11F742;
	Wed, 25 Jun 2025 12:15:32 +0300 (EEST)
Date: Wed, 25 Jun 2025 09:15:32 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
Message-ID: <aFu-NJc6-Li3Bnan@kekkonen.localdomain>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com>
 <aFBudUgU2TWyDgn8@kekkonen.localdomain>
 <CAJZ5v0iPBT6_zMRUW+=RGfp-baA5nXnj+2z+zWSdRj5SC5C4iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iPBT6_zMRUW+=RGfp-baA5nXnj+2z+zWSdRj5SC5C4iA@mail.gmail.com>

Hi Rafael,

On Wed, Jun 18, 2025 at 09:43:25PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 9:20 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Jun 16, 2025 at 01:21:02PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jun 16, 2025 at 8:12 AM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Folks,
> > > >
> > > > The original plan for adding pm_runtime_mark_last_busy() calls to
> > > > functions dealing with Runtime PM autosuspend originally included a few
> > > > intermediate steps of driver conversion, including the use of recently
> > > > added __pm_runtime_put_autosuspend(). The review of the set converting the
> > > > users first to __pm_runtime_put_autosuspend() concluded this wasn't
> > > > necessary. See
> > > > <URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus@linux.intel.com/>.
> > > >
> > > > This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> > > > the _autosuspend() variants of the Runtime PM functions dealing with
> > > > suspending devices, i.e. pm_runtime_put_autosuspend(),
> > > > pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> > > > pm_request_autosuspend(). This will introduce, for a brief amount of time,
> > > > unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> > > > an issue. Also, all users of these functions, including those that did not
> > > > call pm_runtime_mark_last_busy(), will now include that call. Presumably
> > > > in the vast majority of the cases a missing call would have been a bug.
> > > >
> > > > Once this set is merged, I'll post further patches to remove the extra
> > > > pm_runtime_mark_last_busy() calls. The current set of these patches is
> > > > here
> > > > <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm-direct-on-next>.
> > > >
> > > > It'd be best to have all merged within the same cycle.
> > > >
> > > > Rafael: any thoughts on the merging?
> > >
> > > I'm going to queue this up for 6.17.
> >
> > Thank you! :-)
> 
> Now applied.
> 
> > >
> > > > Would an immutable branch on top of rc1 be an option?
> > >
> > > I think so, but does anyone need it?
> >
> > I guess it's not mandatory but we'll have now a lot of redundant calls to
> > the pm_runtime_mark_last_busy(). It just doesn't look very elegant. In the
> > end it's all up to what the maintainers prefer.
> 
> I'll let you know when the branch is ready to pull from.

The branch is here
<URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux.git/log/?h=pm-mark-last-busy-v6.16-rc1>,
I guess you can use:

	ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sailus/linux.git	pm-mark-last-busy-v6.16-rc1

Let me know when you have pulled from there, I'll then post the updated set.

-- 
Kind regards,

Sakari Ailus

