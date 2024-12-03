Return-Path: <linux-pm+bounces-18476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90F9E1FFB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507AA165183
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8B51F7572;
	Tue,  3 Dec 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="g6agdCey"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10B1F6692
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237438; cv=none; b=IzN9JrQZ7XcNOjTx4oEwhqBHXrEG3Q9eVXh7JPtmnSvUzEywEqC9oTU/fj4UiVJRtJFvuw/gZtN96VFj+JXRtnxqRYxaONZilaPpGpsrLaGUsYD3NVxlIH7YysH4xqMhy0B/Y+tU0rp5BrxOJMbZaC9+v76UruWcswIAC//mq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237438; c=relaxed/simple;
	bh=GLJShMnF+WJ/9U3BIf/jN0zrGkdazQoeXPuNBDe8wpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5GXsdEdWLNvUudQlOcHK8GDRiIdmoSfyCpgvKLvL9aL0/f92TV2pguUSOPD1hlYe+V/dF07QKNsIVTkFMud69Ae1Yq4YhyMYrnH+TJdDdmatY+lU2+9bOS9r4fVMs10CHOCgKhZbMS5sIh3KL6Q9LOs7mcUzXiOpc6Iz7g9wkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=g6agdCey; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733237428;
	bh=GLJShMnF+WJ/9U3BIf/jN0zrGkdazQoeXPuNBDe8wpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6agdCeyTAF+1+1XUss3bdvPdZ2upt+fwHEbnV8LmTjT1eqOATXrbK9dxHj+XkGnn
	 +UusIpXF2vchuL03mJHb2/R+EK1nM5l271SKCHbLhLwfpIgroObcr7TXYtbdO9dFZR
	 VbFQg7P+4kcOrWLnpZAurDinTiZZcbi0rVkLgKXo=
Date: Tue, 3 Dec 2024 15:50:28 +0100
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
Message-ID: <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
 <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
 <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>

On 2024-12-03 15:33:21+0100, Rafael J. Wysocki wrote:
> On Tue, Dec 3, 2024 at 1:04 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > On 2024-12-03 12:54:54+0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 3, 2024 at 7:51 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > >
> > > > (+Cc Sebastian)
> > > >
> > > > Hi Chaitanya,
> > > >
> > > > On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> > > > > Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> > > > >
> > > > > This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> > > >
> > > > Thanks for the report.
> > > >
> > > > > Since the version next-20241120 [2], we are seeing the following regression
> > > > >
> > > > > `````````````````````````````````````````````````````````````````````````````````
> > > > > <4>[   19.990743] Oops: general protection fault, probably for non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> > > > > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> > > > > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> > > > > <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
> > > > > `````````````````````````````````````````````````````````````````````````````````
> > > > > Details log can be found in [3].
> > > > >
> > > > > After bisecting the tree, the following patch [4] seems to be the first "bad"
> > > > > commit
> > > > >
> > > > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
> > > > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > > > > Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
> > > > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > > > > Commit:     Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
> > > > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> > > > >     power: supply: core: add wakeup source inhibit by power_supply_config
> > > > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
> > > > >
> > > > > This is now seen in our drm-tip runs as well. [5]
> > > > >
> > > > > Could you please check why the patch causes this regression and provide a fix if necessary?
> > > >
> > > > I don't see how this patch can lead to this error.
> > >
> > > It looks like the cfg->no_wakeup_source access reaches beyond the
> > > struct boundary for some reason.
> >
> > But the access to this field is only done in __power_supply_register().
> > The error reports however don't show this function at all,
> > they come from power_supply_uevent() and power_supply_get_property() by
> > which time the call to __power_supply_register() is long over.
> >
> > FWIW there is an uninitialized 'struct power_supply_config' in
> > drivers/hid/hid-corsair-void.c. But I highly doubt the test machines are
> > using that. (I'll send a patch later for it)
> 
> So the only way I can think about in which the commit in question may
> lead to the reported issues is that changing the size of struct
> power_supply_config or its alignment makes an unexpected functional
> difference somewhere.

Indeed. I'd really like to see this issue reproduced with KASAN.

> AFAICS, this commit cannot be reverted by itself, so which commits on
> top of it need to be reverted in order to revert it cleanly?

All the other patches from this series:
https://lore.kernel.org/lkml/20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net/

Could you point me to the full boot log in the drm-tip CI?

