Return-Path: <linux-pm+bounces-22754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C177A40F93
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03571897E64
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3220AF8D;
	Sun, 23 Feb 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5szSUvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8F1C84B7;
	Sun, 23 Feb 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325359; cv=none; b=E1cxURl+xUVgAFnjxVm0FwWfOqXjaqFJAG0syZtsUtsjnvoDbkr/R1XaTgNX34oiZjUYSord4nXj8u60FdFFTG0p1cp3+75RoV+4bleUeTCCrnz1QapEEdxbAsiiJO/L6y4Om33CbkkouGuWxwzDjhdcAUsas4nALhog/2LkEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325359; c=relaxed/simple;
	bh=8+pwvoCO29+tN6SmiHDXBT+PJZXfOEBCeBttdnD66aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qusKH8HuVgt47TbxVBM993QO/NF3oRGF9XMB32seWhJpU+rakoEb92RiDE/vL25mCPrs3GzToBe+FYHBpqjLojNLKfpza3lu2UNVfUPNHv+EnxpdQyuI9bg894y0d49mVF1x5FjLIu6EMNq2exgs75ziMlPtFunRaGtHLq98k90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5szSUvM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740325357; x=1771861357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8+pwvoCO29+tN6SmiHDXBT+PJZXfOEBCeBttdnD66aQ=;
  b=E5szSUvMhpVBBwUn1JaaxOrvaHoYfD0p6YBzVlx+MQcmO39785A3LJys
   fj9KMr9sucZjf/PuRewPUUcwxTggTTt0wVJdtfunckRNLAot1pl3WM5UY
   1lLJkdcpLW86WQGf2kGx8e6q6SX+AcbTm8vDsv44nIeFsnoWDV9RUhAjf
   7AYsi4wvXxnFdNZQyTq4gVwtAgyduDxqI8HD8oSTwct/gt14IYnBLx2Rv
   Huqt7LquwX3n08ltfCzT637/FQsQP3kDNQr4JL7xyawIwcyjqXaBRMLE8
   elX5dxMdTq8Loj2EyXbgb/p1wToFp7+nu4uCxoHtO9cfO2lNqrqZGDQ3/
   Q==;
X-CSE-ConnectionGUID: vDLGwwB1Q4u2dCA4EN3dcQ==
X-CSE-MsgGUID: LCyubUPpQ86Uk1m3+7vHmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40322634"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40322634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 07:42:36 -0800
X-CSE-ConnectionGUID: ie024MwDQfKjNN6NhjokKg==
X-CSE-MsgGUID: ZEeRozSKRYqk9l320S6kTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120934044"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 07:42:34 -0800
Date: Sun, 23 Feb 2025 17:42:31 +0200
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
Message-ID: <Z7tB5wshbGtO6LGg@black.fi.intel.com>
References: <1922654.tdWV9SEqCh@rjwysocki.net>
 <Z7rPOt0x5hWncjhr@black.fi.intel.com>
 <CAJZ5v0jwn0e4HF1SsAG1OXr59tHzh=E2rcGkTdj1FOQdK2Uisw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jwn0e4HF1SsAG1OXr59tHzh=E2rcGkTdj1FOQdK2Uisw@mail.gmail.com>

On Sun, Feb 23, 2025 at 01:56:07PM +0100, Rafael J. Wysocki wrote:
> On Sun, Feb 23, 2025 at 8:33 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 09:18:23PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There is a confusing difference in error handling between rpm_suspend()
> > > and rpm_resume() related to the special way in which the -EAGAIN and
> > > -EBUSY error values are treated by the former.  Also, converting
> > > -EACCES coming from the callback to an I/O error, which it quite likely
> > > is not, may confuse runtime PM users a bit.
> > >
> > > To address the above, modify rpm_callback() to convert -EACCES coming
> > > from the driver to -EAGAIN and to set power.runtime_error only if the
> > > return value is not -EAGAIN or -EBUSY.
> > >
> > > This will cause the error handling in rpm_resume() and rpm_suspend() to
> > > work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> > > special case from the latter and make it retry autosuspend if
> > > power.runtime_error is unset.
> > >
> > > Link: https://lore.kernel.org/linux-pm/20220620144231.GA23345@axis.com/
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   34 ++++++++++++++++++----------------
> > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > >
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -448,8 +448,13 @@
> > >               retval = __rpm_callback(cb, dev);
> > >       }
> > >
> > > -     dev->power.runtime_error = retval;
> > > -     return retval != -EACCES ? retval : -EIO;
> > > +     if (retval == -EACCES)
> > > +             retval = -EAGAIN;
> >
> > While this is one way to address the problem, are we opening the door
> > to changing error codes when convenient? This might lead to different
> > kind of confusion from user standpoint.
> 
> Are you saying that if a mistake was made sufficiently long ago, it
> can't be fixed any more because someone may be confused?

Nothing against the fix but "sufficiently long ago" is why we might
have users that rely on it. As long as we don't break anything I don't
see a problem.

Messing with error codes is usually received with mixed feelings and
coming across such a code raises more questions than answers. Perhaps a
small explanation might do the trick?

Raag

