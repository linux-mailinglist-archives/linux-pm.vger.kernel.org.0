Return-Path: <linux-pm+bounces-24156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D07A64F3C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2652D7A5874
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FBA23BCE6;
	Mon, 17 Mar 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="4TO/FHL4"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01423372E;
	Mon, 17 Mar 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215127; cv=none; b=ekNn4Rfz3g9UZRBX0vy6bkSLAF3TLCo0e4lsbGsvz54HAFhsx/e+kkh5ggqkDIxGOmwfr2oCJlLdx067Ui39/aNgu6w67AKZ2oITMcXz4slpAJeeiSMGk8IG4K5roB+Jt4IdJHtpRI//R0IW2FJKBkRTqy9hL0zUHeyM1Nfzcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215127; c=relaxed/simple;
	bh=AQEJreR+HpMnlY5XVhrt+inEb603QFUYZeMHk/NHdDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWtkJMXFq5f4RGEBJCfF46X/ZuuMGBFVdg1zOtFzOigkJg590aGo9jO6EiLl4mlZHCc1nTbB31tjbxt+TvVXP2E1+c7hquTRWpjMTEAaU5MrirCbrHnxUK1rSljV00dn/w/bNx99yI/Qh1ugjIU5hK3tCgMg7DRgI/j7ALxO/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=4TO/FHL4; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5D2452E08D40;
	Mon, 17 Mar 2025 14:38:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742215115;
	bh=FwRCpfyRsrF1tWgFmI20Yd/eKeOHE6LqNTtrvvTogcQ=;
	h=Received:From:Subject:To;
	b=4TO/FHL4IUNGJw56oqsveUWHCEPRHPj2p8HoSZPSJIQwQfLuafMKqU6gXrYOeSIJz
	 dOpLS0gSq26XU1KqcL+cC4ErxakbldNtbsjUxqKPoYF2pptURcdYxuiYQq4QNJYrvw
	 ejxq++42y0l38THv2FqSSsTrVcJGAMYDmW/XMZ5Y=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-30c461a45f8so36053341fa.1;
        Mon, 17 Mar 2025 05:38:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV9pgfPV3SsY37ZSW2zRalaM856fudGzl6jRQg/fmDRVDFB/3drZhY3b8Twb+ItURtTuwxFK2bOq8M=@vger.kernel.org,
 AJvYcCWjYhoM2Zq59GyhtK/tiQ9nY7kDc4ASR7713gPvmuLHfFX0O5lwbSze58JlgnOQdFWBlIB+PZGbvRZsRV4=@vger.kernel.org,
 AJvYcCXAiebBYn9Q7KrdC6FP+vjjItrGOVM9sqBnQsJsp/oC7R57ncRsY9TvaD/ti5SWjQZCgnRguJKMjCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1kaSJwp4InzLnFQbFMP9a9XyC55z76kOvpVIxDSs967GXO89
	TxBtHX0rlhE/I8Th6PEsACTRT91No4/tak8zOf5hFTQwWYpGXqY5vAQ6XCFbEWOlL/e8wV+loNf
	Pk6hYpw9RiVPr5a93nO1zbK/3jVE=
X-Google-Smtp-Source: 
 AGHT+IEIezv+PIHUtppMYnuoUnKd7GAg9NKlBB+wmc6HkrBS/Q8jywVZmhR+JbT1AV+f/fMNNoK8hMQE5tv4rkFUS1w=
X-Received: by 2002:a2e:a78a:0:b0:30b:b7c3:ea4d with SMTP id
 38308e7fff4ca-30c4a867269mr59774571fa.12.1742215113249; Mon, 17 Mar 2025
 05:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-6-lkml@antheas.dev>
 <b1ac8a33-06ed-482a-b5f6-ca88eb3802a1@redhat.com>
In-Reply-To: <b1ac8a33-06ed-482a-b5f6-ca88eb3802a1@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 17 Mar 2025 13:38:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGESTw2DJsqr3uAhEymXxH4O5EXDw6O91i8CzCT0=yC1Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpPCqtHwXAfa_-RILhCUiH2n6SwZQscQ4ulRdJ1skNsV59wcKyJ9DulKAg
Message-ID: 
 <CAGwozwGESTw2DJsqr3uAhEymXxH4O5EXDw6O91i8CzCT0=yC1Q@mail.gmail.com>
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
 <174221511473.23089.8392968151053453134@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 17 Mar 2025 at 13:27, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Antheas,
>
> On 11-Mar-25 17:53, Antheas Kapenekakis wrote:
> > OneXPlayer devices have a charge bypass
>
> The term "charge bypass" is typically used for the case where the
> external charger gets directly connected to the battery cells,
> bypassing the charge-IC inside the device, in making
> the external charger directly responsible for battery/charge
> management.
>
> Yet you name the feature inhibit charge, so I guess it simply
> disables charging of the battery rather then doing an actual
> chaerger-IC bypass ?
>
> Assuming I have this correct, please stop using the term
> charge-bypass as that has a specific (different) meaning.

Unfortunately, this is how the feature is called in Windows. On both
OneXPlayer and Ayaneo. Manufacturers are centralizing around that
term.

Under the hood, it should be bypassing the charger circuitry, but it
is not obvious during use. The user behavior mirrors `inhibit-charge`,
as the battery just stops charging, so the endpoint is appropriate.

The previous versions of this patch used the charge_type endpoint.
However, it does not have autodetection, so it needs to be hardcoded
[1].

There is also an ayaneo-platform out-of-tree driver with a PR for that
endpoint, which is where I found out about it [2]. So I thought it
would be more appropriate.

I can rewrite the commit message to not include the word bypass.

[1] https://github.com/hhd-dev/adjustor/blob/6a4a192898c4f9d8495e6554d1f0bc41fef550c7/src/adjustor/drivers/battery/__init__.py#L141-L156
[2] https://github.com/ShadowBlip/ayaneo-platform

> > feature
> > that allows the user to select between it being
> > active always or only when the device is on.
> >
> > Therefore, add attribute inhibit-charge-s0 to
> > charge_behaviour to allow the user to select
> > that bypass should only be on when the device is
>
> Also don't use bypass here please.
>
> > in the s0 state.
> >
> > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
> >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> >  drivers/power/supply/test_power.c           |  1 +
> >  include/linux/power_supply.h                |  1 +
> >  4 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index 2a5c1a09a28f..4a187ca11f92 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -508,11 +508,12 @@ Description:
> >               Access: Read, Write
> >
> >               Valid values:
> > -                     ================ ====================================
> > -                     auto:            Charge normally, respect thresholds
> > -                     inhibit-charge:  Do not charge while AC is attached
> > -                     force-discharge: Force discharge while AC is attached
> > -                     ================ ====================================
> > +                     ================== =====================================
> > +                     auto:              Charge normally, respect thresholds
> > +                     inhibit-charge:    Do not charge while AC is attached
> > +                     inhibit-charge-s0: same as inhibit-charge but only in S0
>
> Only in S0 suggests that charging gets disabled when the device is on / in-use,
> I guess this is intended to avoid generating extra heat while the device is on?
>
> What about when the device is suspended, should the battery charge then ?
>
> On x86 we've 2 sorts of suspends S3, and the current name suggests that the
> device will charge (no inhibit) then. But modern hw almost always uses
> s0i3 / suspend to idle suspend and the name suggests charging would then
> still be inhibited?
>
> Also s0 is an ACPI specific term, so basically 2 remarks here:
>
> 1. The name should probably be "inhibit-charge-when-on" since the power_supply
>    calls is platform agnositic and "S0" is not.

I tried to be minimal. If we want to make the name longer, I vote for
"inhibit-charge-awake". I can spin a v5 with that.

The device does not charge while asleep. Only when it is off.

> 2. We need to clearly define what happens when the device is suspended and then
>    make sure that the driver matches this (e.g. if we want to *not* inhibit during
>    suspend we may need to turn this feature off during suspend).

This is handled by the device when it comes to OneXPlayer. No driver
changes are needed.

> Regards,
>
> Hans
>
>
> snip
> >
>

Best,
Antheas

