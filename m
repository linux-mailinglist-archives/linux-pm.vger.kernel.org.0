Return-Path: <linux-pm+bounces-24222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB616A66017
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FAE19A22C3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35BD204590;
	Mon, 17 Mar 2025 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JHiBK7F5"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35617A311;
	Mon, 17 Mar 2025 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245330; cv=none; b=iDnur/9A66sHlDN5NS1K3Lq5EjtLxsfk/fr+gUjHbfcTqFa004xUU8Z1tguqDpQYv8eY8fyPOt1EJcdECwu2A3M/lCeclCBzlbxUXv+jc+THS384X0bIFnZSpAg5W3eDtALaf3n7CnbY2/0E18xZr4kiE0ng7W42eUB1SYICHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245330; c=relaxed/simple;
	bh=tkddO0mXjCM4xUoDUByVjfHycXg5CLzqUgcE7sXXykY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw6skWRNDChOKxadfCyhPT4q3hDTqls022yHxbG1oJRqDnRg3vSNZue33acUg8qwQWFoq/AKVtrNw36z568wAD/Gjbh/h23tyknxAb7uO6p4QjS7D5bccoI8lVBxoQ0/S70SVr9bkCGe545jdsSWqF7cGv9jNqB2wZpXqAee8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JHiBK7F5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742245325;
	bh=tkddO0mXjCM4xUoDUByVjfHycXg5CLzqUgcE7sXXykY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHiBK7F5+DY/zWzWeY9LzMfbXq20oIZ0SP3VvbvLajirBaxN8mkCQEg92UD00OVn8
	 Ec6kX2X3mDJDQNEuFuPh4a4QOVlZEhKYSfygLklxl7vxayKEGWYRDQ3UmjaYKdsXgV
	 u3ow/Mj+HGiV65NIFA19dJIG0bEnh3lTFBUdv24U=
Date: Mon, 17 Mar 2025 22:02:04 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org
Subject: Re: [PATCH v5 13/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Message-ID: <a764ce58-27a8-44f1-b60e-c6a6d4233977@t-8ch.de>
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-14-lkml@antheas.dev>
 <ce0727b4-bf47-4dc7-9103-d87d88a0e213@t-8ch.de>
 <CAGwozwEqjoW-6J8rzm9HcJ0W1DVvzzPkPRzsKZE62gk3Q1ewSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGwozwEqjoW-6J8rzm9HcJ0W1DVvzzPkPRzsKZE62gk3Q1ewSA@mail.gmail.com>

On 2025-03-17 19:20:46+0100, Antheas Kapenekakis wrote:
> On Mon, 17 Mar 2025 at 19:13, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > On 2025-03-17 16:53:49+0100, Antheas Kapenekakis wrote:

> > > @@ -60,6 +61,7 @@ enum oxp_board {
> > >  };
> > >
> > >  static enum oxp_board board;
> > > +static struct device *oxp_dev;
> >
> > Using a global variable is ugly.
> > An explicit parameter passed through
> > battery_hook_register() -> add_battery()
> > would be nicer.
> > It would require changes to the core code and all its users, though.
> 
> I debated doing this. Unfortunately, this driver uses a global
> variable already (see board), so introducing a struct here seemed a
> bit excessive.
> 
> During a refactor, removing the board global variable would introduce
> a features struct, which can then be used for the battery hook.
> 
> So I think they should be done together in a future series.

Fine by me.

<snip>

> > > +static int oxp_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
> > > +{
> > > +     /* OneXPlayer devices only have one battery. */
> > > +     if (strcmp(battery->desc->name, "BAT0") != 0 &&
> > > +         strcmp(battery->desc->name, "BAT1") != 0 &&
> > > +         strcmp(battery->desc->name, "BATC") != 0 &&
> > > +         strcmp(battery->desc->name, "BATT") != 0)
> > > +             return -ENODEV;
> >
> > If they only have one battery, why is the check necessary?
> 
> Leftover from when I modelled the battery hook from asus-wmi. If the
> battery hook only runs for system batteries and not e.g., for
> peripherals, I will remove this.

The battery hook runs for all batteries discovered through ACPI.
These should only be system batteries.

> > > +
> > > +     return power_supply_register_extension(battery, &oxp_psy_ext, oxp_dev, NULL);
> > > +}
> > > +
> > > +static int oxp_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
> > > +{
> > > +     power_supply_unregister_extension(battery, &oxp_psy_ext);
> > > +     return 0;
> > > +}
> > > +
> > > +static struct acpi_battery_hook battery_hook = {
> > > +     .add_battery = oxp_add_battery,
> > > +     .remove_battery = oxp_remove_battery,
> > > +     .name = "OneXPlayer Battery",
> >
> > This struct can also be aligned.
> 
> Can you expand on that?

It is about lining up the "=" characters all in one vertical line.
Same as in oxp_psy_ext;

<snip>

