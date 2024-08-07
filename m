Return-Path: <linux-pm+bounces-11979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5694B24F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 23:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0612F1C20BCD
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 21:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057FB1514F8;
	Wed,  7 Aug 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuSFKxe6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858014EC47;
	Wed,  7 Aug 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067057; cv=none; b=KsJSb4OfNaA64+ULkodvQ5dS5+/ieE2x35kgTKicRPivO/nJcwL8RkbSnx6H/ALxw4ngaZITGsHE6fnhZ3hNv14JDdKO36mJFZ6L3X/d/yoJTb2cp5LFg90fhLwyW6JIypAjIFzbsVnFzHPT9LSpHIchKzS0iXPSsynRCA94zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067057; c=relaxed/simple;
	bh=/2KsbupSe3qqG1Mk7Xs+Lpekc+kZqx3AKmNla20IMdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phvZlGSpLf3puIF9ocuVJY/aiiNnLCVZFr8Q0xfbLZoqxGkz0kVVTlH+syDcn1+LxAh+X7mJnUpWkhfrU6Uilg+WJYTEYTFQxBZUkzx4yr37uS9dpLpvTF9IhvLIgFS04zFagBK/slIzFCQBdWC6XHUavGP66Y7SfK2o9SHUg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuSFKxe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229AC32781;
	Wed,  7 Aug 2024 21:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723067057;
	bh=/2KsbupSe3qqG1Mk7Xs+Lpekc+kZqx3AKmNla20IMdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuSFKxe6TU63BcXwfKsKbws2gVrFrxNkJTDakmNqRr5CD7eKNc6Bvpyx/d/5LOAQD
	 ZaugVADUW6FH4uqc8x+zN44ZEExq4UChKQ6rL8Gf76Z6oSCBCuGRPlylsyewt61Ju4
	 WgIxMutvnrV+mHyQyFc2UaqhM2lGV5pM3nAU5NAaqQ8++UQi54Niw4LvQ5ZlHGux17
	 Pl46zf5ZdDNGdB4noUR1ODF61rR17Rtt47p7HfncDvUA6Te7aw9PCJiKT5TX5VG709
	 LC/7LKCzjj2TYlC+RtMG6KrfPPDxwZUfmEKeVePzbP1iyARt888qZ/ly3V615cF+NT
	 9Hq24UJlUujdw==
Received: by pali.im (Postfix)
	id 3E8F2787; Wed,  7 Aug 2024 23:44:13 +0200 (CEST)
Date: Wed, 7 Aug 2024 23:44:13 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240807214413.emwpxferfbcp7vlp@pali>
References: <20240724182318.66578a48@5400>
 <20240724230158.nsmxdgagfpanjtzi@pali>
 <20240725162457.34b480e1@5400>
 <20240725221511.mqb4tlam2r7yheoi@pali>
 <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
 <20240726000409.ejnvqkzco664q3zb@pali>
 <20240726002538.558a4a97@5400>
 <8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
 <5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de>
 <20240807172832.09040123@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807172832.09040123@5400>
User-Agent: NeoMutt/20180716

On Wednesday 07 August 2024 17:28:32 Andres Salomon wrote:
> On Fri, 26 Jul 2024 20:46:22 +0200
> Armin Wolf <W_Armin@gmx.de> wrote:
> 
> > Am 26.07.24 um 20:42 schrieb Armin Wolf:
> > 
> > > Am 26.07.24 um 06:25 schrieb Andres Salomon:
> > >  
> > >> On Fri, 26 Jul 2024 02:04:09 +0200
> > >> Pali Rohár <pali@kernel.org> wrote:
> > >>  
> > >>> On Friday 26 July 2024 01:48:50 Armin Wolf wrote:  
> > >>>> Am 26.07.24 um 00:15 schrieb Pali Rohár:
> > >>>>  
> > >>>>> On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:  
> > >>>>>> On Thu, 25 Jul 2024 01:01:58 +0200
> > >>>>>> Pali Rohár <pali@kernel.org> wrote:
> > >>>>>>  
> > >>>>>>> On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:  
> > >> [...]  
> > >>>>>>> The issue here is: how to tell kernel that the particular
> > >>>>>>> dell_battery_hook has to be bound with the primary battery?
> > >>>>>>>  
> > >>>>>> So from userspace, we've got the expectation that multiple batteries
> > >>>>>> would show up as /sys/class/power_supply/BAT0,
> > >>>>>> /sys/class/power_supply/BAT1,
> > >>>>>> and so on.  
> > >>>>> Yes, I hope so.
> > >>>>>  
> > >>>>>> The current BAT0 entry shows things like 'capacity' even without
> > >>>>>> this
> > >>>>>> patch, and we're just piggybacking off of that to add charge_type
> > >>>>>> and
> > >>>>>> other entries. So there shouldn't be any confusion there, agreed?  
> > >>>>> I have not looked at the battery_hook_register() code yet (seems
> > >>>>> that I
> > >>>>> would have to properly read it and understand it). But does it
> > >>>>> mean that
> > >>>>> battery_hook_register() is adding hook just for "BAT0"?
> > >>>>>
> > >>>>> What I mean: cannot that hook be registered to "BAT1" too? Because if
> > >>>>> yes then we should prevent it. Otherwise this hook which is for "Dell
> > >>>>> Primary Battery" could be registered also for secondary battery
> > >>>>> "BAT1".
> > >>>>> (I hope that now it is more clear what I mean).  
> > >>>> Hi,
> > >>>>
> > >>>> the battery hook is being registered to all ACPI batteries present
> > >>>> on a given system,
> > >>>> so you need to do some manual filtering when .add_battery() is called.  
> > >>> Ok. So it means that the filtering based on the primary battery in
> > >>> add_battery callback is needed.
> > >>>  
> > >> Thanks for the explanations. Seems simple enough to fix that, as some of
> > >> the other drivers are checking battery->desc->name for "BAT0".
> > >>
> > >>
> > >> One thing that I keep coming back to, and was reinforced as I looked at
> > >> include/linux/power_supply.h; the generic power supply charge_type has
> > >> values that are very close to Dells, but with different names. I could
> > >> shoehorn them in, though, with the following mappings:
> > >>
> > >> POWER_SUPPLY_CHARGE_TYPE_FAST,         => "express" (aka ExpressCharge)
> > >> POWER_SUPPLY_CHARGE_TYPE_STANDARD,     => "standard"
> > >> POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,     => "adaptive"
> > >> POWER_SUPPLY_CHARGE_TYPE_CUSTOM,       => "custom"
> > >> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,     => "primarily_ac"
> > >>
> > >> The main difference is that Primarily AC is described and documented as
> > >> slightly different than Long Life, but I suspect the result is roughly
> > >> the same thing. And the naming "Fast" and "Long Life" wouldn't match the
> > >> BIOS naming of "ExpressCharge" and "Primarily AC".
> > >>
> > >> Until now I've opted to match the BIOS naming, but I'm curious what
> > >> others
> > >> think before I send V3 of the patches.  
> > >
> > > I agree that POWER_SUPPLY_CHARGE_TYPE_FAST should be mapped the
> > > ExpressCharge,
> > > but i think that "primarily_ac" should become a official power supply
> > > charging mode.
> > >
> > > The reason is that for example the wilco-charger driver also supports
> > > such a charging mode
> > > (currently reported as POWER_SUPPLY_CHARGE_TYPE_TRICKLE) and the
> > > charging mode seems to be
> > > both sufficiently different from
> > > POWER_SUPPLY_CHARGE_TYPE_LONGLIFE/POWER_SUPPLY_CHARGE_TYPE_TRICKLE
> > > and sufficiently generic to be supported by a wide array of devices.
> > >
> > > Thanks,
> > > Armin Wolf
> > >  
> > I just read the documentation regarding the charge_type sysfs attribute and it states that:
> > 
> > Trickle:
> > 	Extends battery lifespan, intended for users who
> > 	primarily use their Chromebook while connected to AC.
> > 
> > So i think that "primarily_ac" should be mapped to POWER_SUPPLY_CHARGE_TYPE_TRICKLE.
> 
> Do you think it's worth keeping around the sysfs-class-power-dell
> file? At this point it's basically just documenting the slight naming
> differences:
> 
> 
>                 Standard:
>                         Fully charge the battery at a moderate rate.
>                 Fast:
>                         Quickly charge the battery using fast-charge
>                         technology. This is harder on the battery than
>                         standard charging and may lower its lifespan.
>                         The Dell BIOS calls this ExpressCharge™.
>                 Trickle:
>                         Users who primarily operate the system while
>                         plugged into an external power source can extend
>                         battery life with this mode. The Dell BIOS calls
>                         this "Primarily AC Use".
>                 Adaptive:
>                         Automatically optimize battery charge rate based
>                         on typical usage pattern.
>                 Custom:
>                         Use the charge_control_* properties to determine
>                         when to start and stop charging. Advanced users
>                         can use this to drastically extend battery life.
> 
>                 Access: Read, Write
>                 Valid values:
>                               "Standard", "Fast", "Trickle",
>                               "Adaptive", "Custom"

Another option could be to extend the description in sysfs-class-power
file that "Trickle" covers "Dell's Primarily AC Use" and "Fast" covers
"Dell's ExpressCharge".

So if somebody is going to implement charge_type for some other Laptop
vendor then this information can help.

