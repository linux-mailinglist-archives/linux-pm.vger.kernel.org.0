Return-Path: <linux-pm+bounces-18452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990649E1C26
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC42B28F85
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C441E47CA;
	Tue,  3 Dec 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jk72wZPL"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6431E0493
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227453; cv=none; b=bKP5pqOa0f/QNgwEJDr1qLJFhIqUHEYsOO6FUAEuL2GCTzDz6EQkVjolskF/3JosWc/Ccl3fKPR0hnpB01evsmPcQY2rDe9EYSsMrneoQp7os4z4YQfYj+5WOmNy9gXwJjjeWCjTD2lHP+xdAqmwYTHfH9ev34HRIHalfDve9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227453; c=relaxed/simple;
	bh=FogJV94VnnrNh403Rpk/Fao6/f4bwrpAHCEDVGU5rLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqKqOnYqBU5qnZJ8UsrPxadHiJA3hO0v1ItOAM/GDj+aPMQa2E9stbP1EgdP6wNBVSNhzWm/RqaG9nKa1Kw6g+bFA9xTBJ4nW+PHUD5D6+kE1Rw6DAdH1tXrmOn5Lb5sh/yV+tdGcYW0FJBqTiZXAUVC9iCJyt18ehKSckR6/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jk72wZPL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733227447;
	bh=FogJV94VnnrNh403Rpk/Fao6/f4bwrpAHCEDVGU5rLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jk72wZPLZLeUJCguNzSIYC0XBBFS6mBvFNNieygQwHsDb1XnfScQ+SSMPRfniqrWx
	 KFTQ4aoOdqPxVbsOGPUrjITBR6I1RZhl3sZTXCByp3ZyTNnlizXhReZeaaKgN3G7j3
	 ogAXHaeOYuH4rodIqXoA6/ztxszkSmbKBlvQvzzk=
Date: Tue, 3 Dec 2024 13:04:06 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>

On 2024-12-03 12:54:54+0100, Rafael J. Wysocki wrote:
> On Tue, Dec 3, 2024 at 7:51 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > (+Cc Sebastian)
> >
> > Hi Chaitanya,
> >
> > On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> > > Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> > >
> > > This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> >
> > Thanks for the report.
> >
> > > Since the version next-20241120 [2], we are seeing the following regression
> > >
> > > `````````````````````````````````````````````````````````````````````````````````
> > > <4>[   19.990743] Oops: general protection fault, probably for non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> > > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> > > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> > > <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
> > > `````````````````````````````````````````````````````````````````````````````````
> > > Details log can be found in [3].
> > >
> > > After bisecting the tree, the following patch [4] seems to be the first "bad"
> > > commit
> > >
> > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
> > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > > Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
> > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > > Commit:     Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
> > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> > >     power: supply: core: add wakeup source inhibit by power_supply_config
> > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
> > >
> > > This is now seen in our drm-tip runs as well. [5]
> > >
> > > Could you please check why the patch causes this regression and provide a fix if necessary?
> >
> > I don't see how this patch can lead to this error.
> 
> It looks like the cfg->no_wakeup_source access reaches beyond the
> struct boundary for some reason.

But the access to this field is only done in __power_supply_register().
The error reports however don't show this function at all,
they come from power_supply_uevent() and power_supply_get_property() by
which time the call to __power_supply_register() is long over.

FWIW there is an uninitialized 'struct power_supply_config' in
drivers/hid/hid-corsair-void.c. But I highly doubt the test machines are
using that. (I'll send a patch later for it)

> > Could you doublecheck the bisect?
> >
> > Note: Having line numbers in the trace would be very useful.
> >
> > > Thank you.
> > >
> > > Regards
> > >
> > > Chaitanya
> >
> > Thanks,
> > Thomas
> >
> >
> > >
> > > P.S. We could not revert the patch cleanly and therefore we are yet to verify the bisect but we are currently working on it.
> > >
> > >
> > > [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> > > [2]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20241120
> > > [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241120/bat-arls-6/boot0.txt
> > > [4] https://cgit.freedesktop.org/drm-tip/commit/?id=49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > > [5] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?
> >

