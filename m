Return-Path: <linux-pm+bounces-22805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A8A41FBC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BAB7AAB09
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592B23373E;
	Mon, 24 Feb 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4SGZ8yw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD517C61;
	Mon, 24 Feb 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401820; cv=none; b=KYWJ7AfWhLR0euOaHkAe0BDPN/Gfvv+GpoSOod4Cks70zFR6+DMWFmJNT6JKyrxHS785yQAL/NvYepYNiRj2V+gEb0jF0+RooWjY/prEMQUYX1NfJborJ4JbMXn5w5Ohz5A7IQfnqbxAIXvxoHXLQy+wvMXqijwA5Vi5BlT3k/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401820; c=relaxed/simple;
	bh=Gd8Lyf68GbHdn/9os+WED7XTbymWYF2+HIt1zvJdHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2ObH2KJZE0rNg6hz4ZnRJLF1/9NrwLu1zc6zYPxKWqniAkkgkTOOcJ873c7yU+t5Q8wGQu5Ske36IQJPW1vQaejqAKK56Y9VmlO13gWlLOmWdSf2n3ehga6byQP0Dp8S/kxT8o84lPuvRtP9cXh8XCoHH4/+HBcGge3n+q/A20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4SGZ8yw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740401818; x=1771937818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Gd8Lyf68GbHdn/9os+WED7XTbymWYF2+HIt1zvJdHNg=;
  b=n4SGZ8yw9KIgYaOOnIibPnkcEKomrUIzG9cPvy/znMsv15I+gDV/jZPN
   2aa7xCydNIBNBWmG4eZRBkJUY/3AHAeydQQcwU2LNHu65b55usLMvFHPa
   7KAXzfj3n8IzbYgwLMl8O+88gqwXgLl6gexjHJNWt0rO0zaQSlxKRCyQ9
   symIEbUAJJRVuN47eZ5PbkGRrrpCN2W0uuaVoMtSeP3G0hBhs771G3b2U
   /hY1/xkxh6Mbono93xz/3e5CQwIf8xyB1EPngQ0Zb8jmnb+lYl0rXiX8s
   zJNwJ8tTkHYe5QWv2NsQaIN7bpG5kt/rnUcqmtNkIzFmE+DguhWwgD0iA
   g==;
X-CSE-ConnectionGUID: bkP+bytjSZW85U92mXv0Dg==
X-CSE-MsgGUID: YrQyG5/UReW/7bE62RbyKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51791260"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51791260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:56:56 -0800
X-CSE-ConnectionGUID: rRZOZy3nRfS9dWBwyOsiBg==
X-CSE-MsgGUID: LuGIPAodQRqgsubJIsZVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116558289"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:56:54 -0800
Date: Mon, 24 Feb 2025 14:56:51 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Oliver Neukum <oneukum@suse.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Brian Norris <briannorris@google.com>
Subject: Re: [PATCH v1] PM: runtime: Unify error handling during suspend and
 resume
Message-ID: <Z7xsk72jQgBkfpwZ@black.fi.intel.com>
References: <1922654.tdWV9SEqCh@rjwysocki.net>
 <Z7rPOt0x5hWncjhr@black.fi.intel.com>
 <CAJZ5v0jwn0e4HF1SsAG1OXr59tHzh=E2rcGkTdj1FOQdK2Uisw@mail.gmail.com>
 <Z7tB5wshbGtO6LGg@black.fi.intel.com>
 <CAJZ5v0jmp4PFb6z+K9cGS83CmX=5Ms0F9HSgcpq-VXn=rTdXgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jmp4PFb6z+K9cGS83CmX=5Ms0F9HSgcpq-VXn=rTdXgg@mail.gmail.com>

On Mon, Feb 24, 2025 at 01:39:14PM +0100, Rafael J. Wysocki wrote:
> On Sun, Feb 23, 2025 at 4:42 PM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > On Sun, Feb 23, 2025 at 01:56:07PM +0100, Rafael J. Wysocki wrote:
> > > On Sun, Feb 23, 2025 at 8:33 AM Raag Jadav <raag.jadav@intel.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 09:18:23PM +0100, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > There is a confusing difference in error handling between rpm_suspend()
> > > > > and rpm_resume() related to the special way in which the -EAGAIN and
> > > > > -EBUSY error values are treated by the former.  Also, converting
> > > > > -EACCES coming from the callback to an I/O error, which it quite likely
> > > > > is not, may confuse runtime PM users a bit.
> > > > >
> > > > > To address the above, modify rpm_callback() to convert -EACCES coming
> > > > > from the driver to -EAGAIN and to set power.runtime_error only if the
> > > > > return value is not -EAGAIN or -EBUSY.
> > > > >
> > > > > This will cause the error handling in rpm_resume() and rpm_suspend() to
> > > > > work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> > > > > special case from the latter and make it retry autosuspend if
> > > > > power.runtime_error is unset.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-pm/20220620144231.GA23345@axis.com/
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/base/power/runtime.c |   34 ++++++++++++++++++----------------
> > > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > > >
> > > > > --- a/drivers/base/power/runtime.c
> > > > > +++ b/drivers/base/power/runtime.c
> > > > > @@ -448,8 +448,13 @@
> > > > >               retval = __rpm_callback(cb, dev);
> > > > >       }
> > > > >
> > > > > -     dev->power.runtime_error = retval;
> > > > > -     return retval != -EACCES ? retval : -EIO;
> > > > > +     if (retval == -EACCES)
> > > > > +             retval = -EAGAIN;
> > > >
> > > > While this is one way to address the problem, are we opening the door
> > > > to changing error codes when convenient? This might lead to different
> > > > kind of confusion from user standpoint.
> > >
> > > Are you saying that if a mistake was made sufficiently long ago, it
> > > can't be fixed any more because someone may be confused?
> >
> > Nothing against the fix but "sufficiently long ago" is why we might
> > have users that rely on it. As long as we don't break anything I don't
> > see a problem.
> >
> > Messing with error codes is usually received with mixed feelings and
> > coming across such a code raises more questions than answers. Perhaps a
> > small explanation might do the trick?
> 
> Do you mean an explanation why -EACCES needs to be converted to something else?
> 
> That's because -EACCES has a special meaning in runtime PM: it means
> that runtime PM is disabled for the given device.

I meant a small comment above for those who may not see it as an obvious
thing, but whatever you think is best.

Raag

