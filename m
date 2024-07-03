Return-Path: <linux-pm+bounces-10537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE854925D82
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134CA29AFFB
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4318411C;
	Wed,  3 Jul 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfSHDm2a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86C1741DD;
	Wed,  3 Jul 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005623; cv=none; b=WuR8hJNvJjrxM9UPLdS+PAkGvzxc489WvNPJocUGzY1yxqgAF8QlrZNUUOCiAGuJaSsKeZ86QtdlO+KhGbwthQSl1kVwoHMCr9ACfPO64dNnhd4PZYKRjty94COdCbtNyqntUUgEjYXsUmfjUiddRb97e4tarE0cI5u6GMg/2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005623; c=relaxed/simple;
	bh=PGbYsiidIYg7xX4GxB6BGNHCk649bpmnZF5Vui1wulQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O//nPrUbVxbmmTMN2vB4b8Utdrr0WhxmCtLk38N9sbmCrHO/oj/gSeMIHpW4V/FgmVlRC7QspgrMEUriyk5fOihyeCi6oMglnuer8W5ahBDmt2IT8wwbbTPQ9xgdlxpSBYfz2hHZ6hJJede6DiAvyDs5v+W1CXTMwMUncVOugsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfSHDm2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89FEC2BD10;
	Wed,  3 Jul 2024 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720005622;
	bh=PGbYsiidIYg7xX4GxB6BGNHCk649bpmnZF5Vui1wulQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HfSHDm2a/+3h5+WPYfYCIEmALuPEq+MGDGviR1T+Rkowyb7V8VeheTBk50lboxkXX
	 X2cAFcgoWwrhWPnTxYfErktC+Q85DFm8MYAi2nrmxZ8r6Zp3yYkYXU3FAPKB3qo90d
	 uQSUXSmSyDA8JV85SovtQmWgpYGYk04lpaymwuCv0QMnSkT3V8cXZa9WjcxaZtBCUq
	 z/ac8bOo8hD90oMN1CZOHWw3OWuOI6P5H3eRubwf7XOperKW091J3F8bG0Hrx6usV3
	 CgZFpkeSj9UIYt95KM+oDNhmTIYuP3r2V4vytEkhnBUzdZoCunFGPpdC8Fo3CkxisH
	 7hPxaIAbd0Y5g==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c582673a5so704743fac.2;
        Wed, 03 Jul 2024 04:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIyjvfCQRY4czuPCUKCLXpbCw9lWTSGbtofocNnyWqVxCYHjVZLysczTreZYAQTn52Mf+dVvuvJHXEHIOOFKz3BzdTL5sf9umS+Arech1ryAtbkhkEcyYmwPbo0kKLKDUePhnDbJ1b2E2oY3D4dVTHtAF+tybrpLh0Rgg8DOknncsi
X-Gm-Message-State: AOJu0Yy3vl/jj/oHeQIf1FFc0MR2MyFydLKtFimDOHLPcO+Zeh/LcQMh
	+K/koG7bkm2MdaBkyjVNarPfB339G3axMCLBx/P8V4vInI9pRrzJi3gAAQyQGrWXLoWITShQVJP
	Hi+Fh+d+mo/dy/bytLTgqG774bzY=
X-Google-Smtp-Source: AGHT+IEk/mRnNFgfavjQn/WU8Bn31esoNFDwHpmPdBvRbybQ2NTdUvIO9E1k9XKwPEYD62NxP33NuTBu8UVaG7XeWtw=
X-Received: by 2002:a05:6870:3c0d:b0:254:7e18:7e1a with SMTP id
 586e51a60fabf-25db36bd873mr11763946fac.5.1720005621961; Wed, 03 Jul 2024
 04:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org> <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
 <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org> <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
 <2a8f5b5f-b67a-4bd0-afe9-f09473aea2d5@linaro.org> <CAJZ5v0g4A1FYZ+7Cb5ocw78y=1Kdg=HSuza2FpYSAiT2c_ZzaQ@mail.gmail.com>
 <c5931c93-248a-43cf-bcaa-d9bfdac9916a@linaro.org>
In-Reply-To: <c5931c93-248a-43cf-bcaa-d9bfdac9916a@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2024 13:20:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3m5LTFW=xn79bcAve3rzNoNCaaub6OFQLQ8YMV_tZ5w@mail.gmail.com>
Message-ID: <CAJZ5v0h3m5LTFW=xn79bcAve3rzNoNCaaub6OFQLQ8YMV_tZ5w@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:49=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 02/07/2024 19:15, Rafael J. Wysocki wrote:
> > On Tue, Jul 2, 2024 at 6:31=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >> On 02/07/2024 13:03, Rafael J. Wysocki wrote:
> >>
> >> [ ... ]
> >>
> >>>>> Trips cannot be created on the fly ATM.
> >>>>>
> >>>>> What can be done is to create trips that are invalid to start with =
and
> >>>>> then set their temperature via sysfs.  This has been done already f=
or
> >>>>> quite a while AFAICS.
> >>>>
> >>>> Yes, I remember that.
> >>>>
> >>>> I would like to avoid introducing more weirdness in the thermal
> >>>> framework which deserve a clear ABI.
> >>>>
> >>>> What is missing to create new trip points on the fly ?
> >>>
> >>> A different data structure to store them (essentially, a list instead
> >>> of an array).
> >>>
> >>> I doubt it's worth the hassle.
> >>>
> >>> What's wrong with the current approach mentioned above?  It will need
> >>> to be supported going forward anyway.
> >>
> >> So when the "user trip point" option will be set, a thermal zone will
> >> have ~ten(?) user trip points initialized to an invalid temperature ?
> >
> > If a thermal zone is registered with 10 invalid trip points, htat can
> > happen already today.
>
> IINW, this is the case for a particular driver (int340x_thermal_zone?),
> may be for a thermal zone. But in the general case where we can have
> more the 50 thermal zones it is not adequate as we will end up with more
> than 500 trip points overall.
>
> Assuming it is the int340x_thermal_zone driver, it is active trip
> points, so that assumes the associated cooling device will be active.
> TBH, it is fuzzy regarding a notification mechanism

The trip points that are invalid to start with are passive IIRC, but
the point I wanted to make was that the number of trip points, their
type and whether or not they were invalid to start with depended on
the driver registering a thermal zone.  Drivers put whatever they like
into the trips table today.

> > Let's talk about the usage model, though.
>
> Sure
>
> > IIUC, this would be something like "triggers" I mentioned before: If a
> > certain temperature level is reached, a notification is sent to user
> > space, and there are multiple (possibly many) levels like this.  They
> > can be added and deleted at any time.
>
> Yes, except I don't think the usage will be to often creating trip
> points. More likely, depending on the kind of sensors and the associated
> logic, a number of trip points will created for a specific profile and
> then modified on the fly.

So I gather that you'd like the initial set to come from DT.

> > There can be an interface for this, as simple as a pair of sysfs
> > attributes under a thermal zone: add_trigger and remove_trigger.  If
> > root (or equivalent) writes a (valid) temperature value to
> > add_trigger, a new trigger is added (up to a limit and provided that
> > enough memory can be allocated).  Conversely, if a temperature value
> > is written to remove_trigger and there is a trigger with that
> > temperature, it will be deleted.
>
> A hysteresis would be needed too. IMO, netlinks are more adequate for
> this purpose.

That depends.

One way to implement hysteresis is to add a new trigger when an
existing one is crossed, either below (on the way up) or above (on the
way down) it, and remove it.  Then you don't need an additional
hysteresis value.

> > Internally, the triggers can be stored in a sorted list (with some
> > optimizations, so it need not be walked every time the zone
> > temperature changes) or a tree, independent of the trips table (if
> > any).  Every time the zone temperature changes, the triggers list is
> > consulted (in addition to the trips table) and if any of them have
> > been crossed, notifications are sent to user space.
>
> So basically, thermal_zone_device_update() will browse two lists,
> triggers + trip points, right ?

Right.

> > If polling is used, this would just work, but without polling the
> > driver needs to support setting a pair (at least) of temperature
> > levels causing an interrupt to occur.
>
> I'm missing this point, can you elaborate ?

Polling guarantees that __thermal_zone_device_update() will be
executed periodically and so it guarantees detection of crossing trip
points (or trigger temperature levels).

If there is no polling, interrupts (or equivalent) need to be used to
invoke __thermal_zone_device_update() when trips are crossed.
Basically, if any of them is crossed, you need an interrupt.

Usually, however, hardware supports a limited number of temperature
levels that can trigger interrupts and I wanted to make the point that
it was sufficient for it to support two of them for the usage model in
question.

> > If a specific callback, say
> > .set_triggers(), is provided by the driver, it can be used for setting
> > those temperature levels to the triggers right above and right below
> > the current zone temperature, in analogy with .set_trips().
> >
> > Does this reflect what you are after?
>
> At the first glance I would say yes, but I don't get why it is more
> complicate to just add 'triggers' with the trip points (formerly 'user'
> trip points)

The most problematic part is the requirement to be able to add and
remove "triggers" on the fly from user space.  This requires two
things: (a) a user space interface for that and (b) a data structure
suitable for adding and removing entries (ideally, a sorted one).
None of these things exist for trip points today and the trip points
in use today don't require any of them either.  Adding more complexity
to the already complex trip point implementation doesn't look
particularly attractive to me.

