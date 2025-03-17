Return-Path: <linux-pm+bounces-24170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22392A651CF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F601751D7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17CE243955;
	Mon, 17 Mar 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FYjesMUe"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C952405E4;
	Mon, 17 Mar 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219470; cv=none; b=PzRUUW66L6wlzNW7X1Hklr3KOqxt6qEWoSzy9+EW9td2UDuR+WotxZ2q2UjeKIqfOvLT3V8rHRT9GcpoMfCSrkEtZZQaNPmrBgKhRO7PX3X+2mmGtduyXicRxpt51y6ag6zSH72D1Eo2rAqNvRzYZor0aijCDBCDrqSVav54sRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219470; c=relaxed/simple;
	bh=xZxsNPccztyFB0O0ukCfdDkB/F+MCZw+Ajrf6NTEblk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmNBL65oz3F/MZDmQ0rZbXRdxIgvMH5iSxrLMx3xq4xj83f1QyZQ6+Rlie4VE/Cl+HjJMHGdJFiOSeEKFeZMlvUSlmIPSTQvlzWDeHgIH3eymmKEvCxxeYyU7626XVMmtzXIXZz6flNUX1T3Rlg8/IDQvwUoHO4Nc9BclCLG85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FYjesMUe; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0330A2E08E9E;
	Mon, 17 Mar 2025 15:51:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742219462;
	bh=bSiXBmw1am1d5mYaRu0CkOuVLXJqETe9fSTZXOUGz0A=;
	h=Received:From:Subject:To;
	b=FYjesMUeJTKrFZHClJrxhBoDtYWdrAH/pMeegSdewD5LP/7N14Fk/JhZC9xqQSOiQ
	 dU1MwOqS96FBRt0DD2ES3L1oZXXmGAvBJxaps6XieclkGWd5keb5aUYM+fwt2ROBJA
	 TvKuqpAEPefDleqDjIUA32tId6bwnh0We3IKUQKw=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-30bf1d48843so42642831fa.2;
        Mon, 17 Mar 2025 06:51:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVLyJdlDtPfdcd+oSZ1/sBTMWDgyDHjS2f3VGLkah9Z3NO0x1olRfqLP/2sD5sFA5AcS1WAgkSl4hc=@vger.kernel.org,
 AJvYcCVikoJYHdgTiaREFKoogzKvmjX621PLguU6RTA8La/JhZrgv5dJ15Hcjh8RAIv8ngVaI5056IJdHHE=@vger.kernel.org,
 AJvYcCXuUe3oWzzjAHRDbnBkTDsUcqm4iojMgFfu1l6VRKw/eRaVVsx9olrYM57kmhFXSD8TLykJHQYXRwfr79w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkdV07fMEsFh3KQIX0N60FED0tZdqCSesPM7uQCwZ1kWC25jPT
	Ovo+8goRP0LfW5n0LDdDieaPy7SYug3zHEPPwzvoJtBDw0+jUH49giJr/NysWBwt3gh5rObdpO4
	TBVFsqEGgsJxVTIVNykdpEELuAJA=
X-Google-Smtp-Source: 
 AGHT+IEnx41lAYo5Mhe/AxEHi3UnRhRKWxV5VUp61bK28mpE5XINXyZSouO6LRLvzrM76t8W9JoxWquwmSyCHdaj1dE=
X-Received: by 2002:a05:651c:503:b0:309:bc3:3a71 with SMTP id
 38308e7fff4ca-30c4a8e503bmr53622481fa.31.1742219460118; Mon, 17 Mar 2025
 06:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
 <b1ac8a33-06ed-482a-b5f6-ca88eb3802a1@redhat.com>
 <CAGwozwGESTw2DJsqr3uAhEymXxH4O5EXDw6O91i8CzCT0=yC1Q@mail.gmail.com>
 <82e27f38-f951-4e6f-babd-81890d590a04@redhat.com>
In-Reply-To: <82e27f38-f951-4e6f-babd-81890d590a04@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 17 Mar 2025 14:50:48 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFCOqhyNTZPfq2nmDoAYwzrUGoDGWzvqmJf8zK2_5Hk6A@mail.gmail.com>
X-Gm-Features: AQ5f1JpUXUMWy8daFCWyprPiJWFP1Wot8aQ0ggnLh3qeFkrQhHFrqnXOb8ZBC-k
Message-ID: 
 <CAGwozwFCOqhyNTZPfq2nmDoAYwzrUGoDGWzvqmJf8zK2_5Hk6A@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] power: supply: add inhibit-charge-s0 to
 charge_behaviour
To: Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174221946140.8263.8791408111338328318@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 17 Mar 2025 at 14:31, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 17-Mar-25 13:38, Antheas Kapenekakis wrote:
> > On Mon, 17 Mar 2025 at 13:27, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Antheas,
> >>
> >> On 11-Mar-25 17:53, Antheas Kapenekakis wrote:
> >>> OneXPlayer devices have a charge bypass
> >>
> >> The term "charge bypass" is typically used for the case where the
> >> external charger gets directly connected to the battery cells,
> >> bypassing the charge-IC inside the device, in making
> >> the external charger directly responsible for battery/charge
> >> management.
> >>
> >> Yet you name the feature inhibit charge, so I guess it simply
> >> disables charging of the battery rather then doing an actual
> >> chaerger-IC bypass ?
> >>
> >> Assuming I have this correct, please stop using the term
> >> charge-bypass as that has a specific (different) meaning.
> >
> > Unfortunately, this is how the feature is called in Windows. On both
> > OneXPlayer and Ayaneo. Manufacturers are centralizing around that
> > term.
>
> Ok, so I just did a quick duckduckgo for this and it looks like
> you are right.
>
> > Under the hood, it should be bypassing the charger circuitry, but it
> > is not obvious during use.
>
> Ack reading up on this it seems the idea is not to connect the external
> charger directly to the battery to allow fast-charging without
> the charge-IC inside the device adding heat, which is the traditional
> bypass mode.
>
> Instead the whole battery + charging-IC are cut out of the circuit
> (so bypassed) and the charger is now directly powering the device
> without the battery acting as a buffer if the power-draw superseeds
> what the external charger can deliver.
>
> > The user behavior mirrors `inhibit-charge`,
> > as the battery just stops charging, so the endpoint is appropriate.
>
> Hmm this new bypass mode indeed does seem to mirror inhibit charge
> from a user pov, but it does more. It reminds me of the battery disconnect
> option which some charge-ICs have which just puts the battery FET in
> high impedance mode effectively disconnecting the battery. Now that
> feature is intended for long term storage of devices with a builtin
> battery and it typically also immediately powers off the device ...
>
> Still I wonder if it would make sense to add a new "disconnect"
> charge_behaviour or charge_types enum value for this ?
>

The battery is not disconnected. It still provides backup. Unplugging
the charger does not turn off the device. So it is more murky.

From a userspace perspective it is inhibit-charge 1-1.

>
>
> <snip>
>
> >>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> >>> index 2a5c1a09a28f..4a187ca11f92 100644
> >>> --- a/Documentation/ABI/testing/sysfs-class-power
> >>> +++ b/Documentation/ABI/testing/sysfs-class-power
> >>> @@ -508,11 +508,12 @@ Description:
> >>>               Access: Read, Write
> >>>
> >>>               Valid values:
> >>> -                     ================ ====================================
> >>> -                     auto:            Charge normally, respect thresholds
> >>> -                     inhibit-charge:  Do not charge while AC is attached
> >>> -                     force-discharge: Force discharge while AC is attached
> >>> -                     ================ ====================================
> >>> +                     ================== =====================================
> >>> +                     auto:              Charge normally, respect thresholds
> >>> +                     inhibit-charge:    Do not charge while AC is attached
> >>> +                     inhibit-charge-s0: same as inhibit-charge but only in S0
> >>
> >> Only in S0 suggests that charging gets disabled when the device is on / in-use,
> >> I guess this is intended to avoid generating extra heat while the device is on?
> >>
> >> What about when the device is suspended, should the battery charge then ?
> >>
> >> On x86 we've 2 sorts of suspends S3, and the current name suggests that the
> >> device will charge (no inhibit) then. But modern hw almost always uses
> >> s0i3 / suspend to idle suspend and the name suggests charging would then
> >> still be inhibited?
> >>
> >> Also s0 is an ACPI specific term, so basically 2 remarks here:
> >>
> >> 1. The name should probably be "inhibit-charge-when-on" since the power_supply
> >>    calls is platform agnositic and "S0" is not.
> >
> > I tried to be minimal. If we want to make the name longer, I vote for
> > "inhibit-charge-awake". I can spin a v5 with that.
> >
> > The device does not charge while asleep. Only when it is off.
>
> Is suspend awake though ?

Sorry I mispoke. When inhibit-charge-awake, the device only charges
while in s0i0. When inhibit-charge, it never charges. This includes
s0i3, S4, and S5. The devices that support this only support modern
standby.

I just verified this.

> >> 2. We need to clearly define what happens when the device is suspended and then
> >>    make sure that the driver matches this (e.g. if we want to *not* inhibit during
> >>    suspend we may need to turn this feature off during suspend).
> >
> > This is handled by the device when it comes to OneXPlayer. No driver
> > changes are needed.
>
> Well you say no charging is done when suspended, the question also is what
> behavior do we want here?  I'm fine with the default behaviour, but a case
> could be made that charging while suspended might be desirable (dependent on
> the use case) in which case we would need to disable the inhibit when
> suspending to get the desired behavior.
>
> Also what if other firmware interfaces with a bypass^W inhibit option work
> differently and do charge during suspend ?
>
> It is important that we clearly define the expected behavior now so that
> future devices can be made to behave the same.

Sorry I mispoke. Charging happens under modern standby under -awake.

So -awake would mean awake (s0i0) here.

If other devices charge during sleep and awake, another option could be added.

> Regards,
>
> Hans
>
>

