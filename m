Return-Path: <linux-pm+bounces-35808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76736BC518C
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B5F18830BB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D421256C;
	Wed,  8 Oct 2025 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HwvYeY7W"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3561FCF41;
	Wed,  8 Oct 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928564; cv=none; b=oWg+m8/vQvyUshjpA/0rQQqxPIZilESgtkuj5/IxxArI3Qfq2xVRZO5H/rGJyW8ZkvOYhouHzC/uGHC/ZXVRHmP6S2FSreHtLSk/rz1QYiYNoNkBI7gFnOGwGFxvHR9yMb3+9M7qz40EmiqvtM91IxR34zsVXtpCgn6V1fF3VWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928564; c=relaxed/simple;
	bh=l2qk4z9L+iU21NSBfZVsOIdiylyVOVcaDrpkHDQfGUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td+ijoUB4B2HLgPHZAJfmPLxEAO+c8o2ChPIB5NPdrFuERiliO3J/dSGYR+IskotJQns2gAs6M1dzBc1WeEkFWalA/+4DuBn//BzS35hPir4bk9Rr6AsnM+jbpAKiT/b/bGnyD9Ai1sqeVvcs+rRfZGZLFPayhKwis2C1SQszMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HwvYeY7W; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598D2b1H228169;
	Wed, 8 Oct 2025 08:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759928557;
	bh=r3wvk9iUuXHr5Zno4PahCAUcNP2fQFN/TvLsLi2w/Ec=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HwvYeY7WgqcjkgLmgTH6sbfRGxYvWwCjn7G6KpCHL9A3Sz01H5eBeEJVIyC1vN5g6
	 /+Xt1YmkN6QPC3kAscT55iq0BzogqiJi+5jKDLAwA1nUeBvGNv7DRoiY/B4Z/ieRuI
	 tkG5AJUHfUmRRc+HRZlc/OmBmpwX96HgsKCqorSk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598D2asA160553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 8 Oct 2025 08:02:37 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 08:02:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 08:02:36 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598D2ZQe2806490;
	Wed, 8 Oct 2025 08:02:36 -0500
Date: Wed, 8 Oct 2025 18:32:34 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Pavel Machek
	<pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Message-ID: <20251008130234.mw6k4k7fupxma2t5@lcpd911>
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
 <20251008101408.dj46r66gcfo26sgl@lcpd911>
 <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 08, 2025 at 13:23:33 +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 8, 2025 at 12:14 PM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > On Oct 07, 2025 at 15:35:40 +0900, Sergey Senozhatsky wrote:
> > > Add dpm_watchdog_all_cpu_backtrace module parameter which
> > > controls all CPU backtrace dump before DPM panics the system.
> > > This is expected to help understanding what might have caused
> > > device timeout.
> >
> > This will indeed be really helpful for debugging some nasty bugs!
> >
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  drivers/base/power/main.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index e83503bdc1fd..7a8807ec9a5d 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -34,6 +34,7 @@
> > >  #include <linux/cpufreq.h>
> > >  #include <linux/devfreq.h>
> > >  #include <linux/timer.h>
> > > +#include <linux/nmi.h>
> > >
> > >  #include "../base.h"
> > >  #include "power.h"
> > > @@ -515,6 +516,11 @@ struct dpm_watchdog {
> > >  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
> > >       struct dpm_watchdog wd
> > >
> > > +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> > > +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> > > +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > > +              "Backtrace all CPUs on DPM watchdog timeout");
> > > +
> >
> > Have you considered runtime configurability instead of a module param?
> 
> This one can be updated at run time AFAICS.

What I meant really was to consider another path instead of a mod param,
something like a /sys/kernel/ entry, but looking more into it I think this
is perfectly fine too.

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

