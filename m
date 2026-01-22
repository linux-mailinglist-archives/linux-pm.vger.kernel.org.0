Return-Path: <linux-pm+bounces-41324-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAo5COhucmlpkwAAu9opvQ
	(envelope-from <linux-pm+bounces-41324-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:39:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C366A6C8D0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1E6230101DB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307437BE7A;
	Thu, 22 Jan 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2ayD+hz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E33793AE
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106613; cv=none; b=FHKGLokybgOUhTsY+w0vPynNKdSE9brNF7u5hfHGKvTtdoxLS3d42gVltr4juLMa/GkVGqX0APOnm25KcDvcJYh69IbMJZk5YymdfieVO0dNABlbqaQDqc98pFyz7oFtO6PrngCsyn/is9RL9tGGdP0eTdR+tRgPzKXeXRv3iN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106613; c=relaxed/simple;
	bh=7QOJwHLne/dV9SIV19wXl0mTPvVG+qPY8FKek6bSPMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQcc8ByrWHGzKRFoRvz5aKjaeHAcQraG+oizEjHRHa6Ba2uhB5lBixhakjmKxbGZBQntQzY2O9PMx5g1Y9OwqXc0cvHB78l2P5FOuG9PUPplYrVbUE5RLIu0zNNfOqI4iDPmzUxuhunOPaxySBQlk9wwYHjOYZqZpXAIYmu+vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F2ayD+hz; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so1469438c88.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769106594; x=1769711394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Kw4pdgJSqE7pW6Rxr+02f8mkuU8o3ivJM5muB+egHA=;
        b=F2ayD+hzR6rDL3IyAXwmZToeaJpfCrA20RUfrimAko5ypzcSXl1PGXwZXqbVNKFDN0
         Xu1+QuLkbzFr7QnOwkrwFOxVI0x6FE2Bijs5rUleIN+zvc2mIrqyNuwRYUyeW+7PAZRY
         mFDqgrE5hOHlUUrrkXVCn8ISYWg2F6EN+QJxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106594; x=1769711394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kw4pdgJSqE7pW6Rxr+02f8mkuU8o3ivJM5muB+egHA=;
        b=cAcS67oPiHiVgxij+XbstScneKpPGYGnfMdeRe1qlA7BO9jw6OrAAtUKKMvX+kUuVP
         AsbWqlYqx5xrzrzkrPnoEjCgjSDF/gwa24e4Ct4ahMKUO+PiZAx8QCnWxAa2IM3d4TfR
         xL16KYyNaYv2eC6xc8YiW6h6H+2OVfmHMxi+nfuNZIEgGkJXCwFeSDUkexQtlgD5sMli
         WizBsYHO1v0jKfGfWdAUXAaJMHVBZywV3hnNIx6IcsS/VFnbGBEi0hHSYcqoquv9ssI6
         6O+X4ke/Y2zUB3nIcKCUGiGRw020nHT1Efi5uR6W6KOcXXV3HCMZCaAYnYfjwd49tuPA
         Eqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUNsSVsbSYIapaYp57QiYzcaaxnuepenbL4LFwPH27CEf9X3ER2KrL1yUR701l6IVp92H2EK8jXNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymoSMawQ/NbrCCtxl7acxgIOu0qhhfsXuioWRPSpwmZRUuO/Tt
	P2iJcQO2VCbzxieX+ZyrOt54mW8p//v6qPYQThXYgxdKyhagbAB41FJN46xpAMbiGQ==
X-Gm-Gg: AZuq6aKUZBxpeA5yHlfne5gLNx7Hw56DZ+n0aAXiJ3xaEP399i0LSnEVTThpRiyFvQ3
	DRMSSrv8/iYPLpObPeSqhoPt161b/uPZeIbv7+L1h1as11SUMqhOOTJ0gIWbIbETfaSVS+zwvx5
	x9fBg9oNaVn3kZ4/x6kjopW3B6VIuJT5HQK0NuKtEwULigthQe52oUlrP9X6ga1wQRQGyLUD7xb
	tswzM84LkVkJvl3YSwQYJXnP8JgxZd84FsxB7zoAlTdq21J5pwa86mVfmQdSqs+FaPbcxEXwwn3
	LWPFxbZ7F2TiJvDgULxAqts1h4mFNnSptenHeSc+BOH9iKJxVlz9CzWHOjm+B+ECBpOTBXIqVrV
	nDtz3P8xR16x4QCiKmOE6vIUC43qI4IxfIpNlVUQOdDFXBv85NT1O9v021dg+aJEJv2dZ84RMGq
	cCcOww/pyxN//sYIFPXdHCpebqArwBdQy9ZdCLSDwxRV8VEjvpsg==
X-Received: by 2002:a05:7022:6a1:b0:11f:3d55:ab9a with SMTP id a92af1059eb24-1247dbb1012mr161528c88.13.1769106593437;
        Thu, 22 Jan 2026 10:29:53 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:3a16:d323:e921:56db])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1247d91c52bsm396951c88.6.2026.01.22.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 10:29:52 -0800 (PST)
Date: Thu, 22 Jan 2026 10:29:50 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are
 fully initialized
Message-ID: <aXJsnh4HeiQ2oOBl@google.com>
References: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0iBNOmMtqfqEbrYyuK2u+2J2+zZ-iQd1FvyCPjdvU2TJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iBNOmMtqfqEbrYyuK2u+2J2+zZ-iQd1FvyCPjdvU2TJg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41324-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim]
X-Rspamd-Queue-Id: C366A6C8D0
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 07:17:21PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 6:49 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Previously, it was possible for a PCI device to be runtime-suspended before
> > it was fully initialized. When that happened, the suspend process could
> > save invalid device state, for example, before BAR assignment. Restoring
> > the invalid state during resume may leave the device non-functional.
> >
> > Prevent runtime suspend for PCI devices until they are fully initialized by
> > deferring pm_runtime_enable().
> >
> > More details on how exactly this may occur:
> >
> >   1. PCI device is created by pci_scan_slot() or similar
> >
> >   2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
> >      prevents runtime suspend prevented via pm_runtime_forbid()
> >
> >   3. pci_device_add() adds the underlying 'struct device' via device_add(),
> >      which means user space can allow runtime suspend, e.g.,
> >
> >        echo auto > /sys/bus/pci/devices/.../power/control
> >
> >   4. PCI device receives BAR configuration
> >      (pci_assign_unassigned_bus_resources(), etc.)
> >
> >   5. pci_bus_add_device() applies final fixups, saves device state, and
> >      tries to attach a driver
> >
> > The device may potentially be suspended between #3 and #5, so this is racy
> > with user space (udev or similar).
> >
> > Many PCI devices are enumerated at subsys_initcall time and so will not
> > race with user space, but devices created later by hotplug or modular
> > pwrctrl or host controller drivers are susceptible to this race.
> >
> > More runtime PM details at the first Link: below.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> > Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com/
> >
> > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> > Cc: <stable@vger.kernel.org>
> > ---
> >
> > Changes in v5:
> >  * Put pm_runtime_set_active() back where it was, to ensure our parent
> >    can't suspend before we're really ready. (See bug report in 2nd
> >    "Link:")
> >  * Add comments
> >  * Update commit description with Bjorn's rewrite
> >  * Add Marek's Tested-by
> >
> > Changes in v4:
> >  * Move pm_runtime_set_active() too
> >
> > Changes in v3:
> >  * Add Link to initial discussion
> >  * Add Rafael's Reviewed-by
> >  * Add lengthier footnotes about forbid vs allow vs sysfs
> >
> > Changes in v2:
> >  * Update CC list
> >  * Rework problem description
> >  * Update solution: defer pm_runtime_enable(), instead of trying to
> >    get()/put()
> >
> >  drivers/pci/bus.c | 7 +++++++
> >  drivers/pci/pci.c | 5 ++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 4383a36fd6ca..90954f81962b 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       /*
> > +        * Enable runtime PM (and potentially suspend) only after we've fully
> > +        * configured the PCI state.
> > +        */
> 
> I would make it a bit more precise, something like "Enable runtime PM,
> which potentially allows the device to suspend immediately, only after
> the PCI state has been configured completely."
> 
> Also, it is not particularly what "we" means in kernel code comments,
> so I generally avoid phrasing them this way.

Well, you may disagree with plenty of other people :)

$ git grep -ioh '\<we\>' ./drivers/pci | wc -w
943

Your suggestion also means using passive voice, which I sometimes
attempt to avoid.

But otherwise, looks fine to me.

> > +       pm_runtime_enable(&dev->dev);
> > +
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 13dbb405dc31..07b0d029aa51 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
> >  poweron:
> >         pci_pm_power_up_and_verify_state(dev);
> >         pm_runtime_forbid(&dev->dev);
> > +       /*
> > +        * Mark ourselves active now, to prevent our parent from suspending
> > +        * while we finish configuring the PCI device.
> > +        */
> 
> I would rephrase the comment this way:
> 
> "Runtime PM will be enabled for the device when it has been fully
> configured, but since its parent and suppliers may suspend in the
> meantime, prevent them from doing so by changing the device's runtime
> PM status to "active"."

Sure. That's going on the more verbose end, like I suggested a bit ago.
I'm fine with more verbose, if it helps people.

I see Bjorn already applied this, so it seems he's happy enough. He also
spent a lot of time on making earlier writing less verbose, so I'll
defer to his opinions. I can spin a v6, or Bjorn can squash in his own
update, or he can choose to leave it as-is.

Brian

> >         pm_runtime_set_active(&dev->dev);
> > -       pm_runtime_enable(&dev->dev);
> >  }
> >
> >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> > --

