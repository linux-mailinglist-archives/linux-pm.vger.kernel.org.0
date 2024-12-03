Return-Path: <linux-pm+bounces-18425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE09E1593
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F162815E0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F81D279F;
	Tue,  3 Dec 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OcqWM21b"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF218FDC9
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214308; cv=none; b=UXBA8MUddN5KxNGwjl6eoMvSlM7AnSuaHo9NCeI/WIL9Rk3+4lcRoDpGtdGSXMha4FRx+wz0ZKiWoZ/oqZpN2u2DyeAm4iPPhfi/31Xl6BuwA+obwdqTxwGEk8ktVcMWtskzTlp3YWYx4H5MfKvdVPP5wZVq8/E+o4CnG0xTP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214308; c=relaxed/simple;
	bh=teX4mb1jPQ2CVPW1mtArPbbk7sHjrq60MC03+FzvSAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzIbNiFZxkRN5lnXondolxAsMK+aTXba5ljFWEI/0R2e0Gd1CIXGQ//k/DEoZeKFAgt6M+tr7SzORSOuJm1wknMl/4BrWyg5LGlBx4CKDrJ6rh1edcEz1idJSaJvY1a8VkSC9kWErOrZDskLgBy0sFNA6t2FTASQIviz++ut6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OcqWM21b; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733214301;
	bh=teX4mb1jPQ2CVPW1mtArPbbk7sHjrq60MC03+FzvSAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcqWM21bDQTqWp/lWSrqZBmsc3AdZWag5EgBmDRnR3lt/s3ufgUPU6axe3AwOlTc/
	 CUmvNV/DDf2MXlGtn8OBYcu+au/hLNXHqZ8fnUbwig6Etvp9NPWAgdRx7XWCGPGSjH
	 8/h2heoLpURJKUK+D5NZSol8kNxxfH0ig2RP2ozk=
Date: Tue, 3 Dec 2024 09:25:00 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luca Coelho <luca@coelho.fi>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <82f1c285-ae2c-4a41-af10-016b52c149c1@t-8ch.de>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <7a84d900879c555dab675605ba925bc91b02510d.camel@coelho.fi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a84d900879c555dab675605ba925bc91b02510d.camel@coelho.fi>

On 2024-12-03 09:50:05+0200, Luca Coelho wrote:
> On Tue, 2024-12-03 at 07:50 +0100, Thomas Weißschuh wrote:
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
> > > <4>[   19.990743] Oops: general protection fault, probably for non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> > > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> > > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> > > <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
> > > `````````````````````````````````````````````````````````````````````````````````
> > > Details log can be found in [3]. 
> > > 
> > > After bisecting the tree, the following patch [4] seems to be the first "bad"
> > > commit
> > > 
> > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
> > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > > Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
> > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > > Commit:     Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
> > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> > >     power: supply: core: add wakeup source inhibit by power_supply_config    
> > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
> > > 
> > > This is now seen in our drm-tip runs as well. [5]
> > > 
> > > Could you please check why the patch causes this regression and provide a fix if necessary?
> > 
> > I don't see how this patch can lead to this error.
> > Could you doublecheck the bisect?
> 
> FWIW I also bisected this and came to the same conclusion, this is the
> first bad commit.  My guess is that some component is not yet setting
> things up properly for the new feature.

The thing is that at this point nothing is using this feature.
And the new code runs during registration while the error happens later.

> This is very easily reproducible in our system, with vanila 6.13-rc1,
> so if there's anything you want to try, let us know.

Can you try the following diffs, each alone on top of
49000fee9e639f62ba1f965ed2ae4c5ad18d19e2?

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a2005e3c6f38..c6e7ca5b1283 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1411,7 +1411,7 @@ __power_supply_register(struct device *parent,
                goto device_add_failed;

        if (cfg && cfg->no_wakeup_source)
-               ws = false;
+               ;

        rc = device_init_wakeup(dev, ws);
        if (rc)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a2005e3c6f38..5aefba2ddcda 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1410,9 +1410,6 @@ __power_supply_register(struct device *parent,
        if (rc)
                goto device_add_failed;

-       if (cfg && cfg->no_wakeup_source)
-               ws = false;
-
        rc = device_init_wakeup(dev, ws);
        if (rc)
                goto wakeup_init_failed;


Could you also print the name of the device?


diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a2005e3c6f38..63e9e339cc01 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1356,6 +1356,8 @@ __power_supply_register(struct device *parent,
                pr_warn("%s: Expected proper parent device for '%s'\n",
                        __func__, desc->name);

+       pr_warn("PSY: name=%s\n", desc->name);
+
        psy = kzalloc(sizeof(*psy), GFP_KERNEL);
        if (!psy)
                return ERR_PTR(-ENOMEM);


Also line numbers would be useful.
Is this configuration running KASAN?


Thanks a lot,
Thomas

