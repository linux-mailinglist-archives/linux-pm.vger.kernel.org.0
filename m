Return-Path: <linux-pm+bounces-1105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008481159D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3482810CB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26572F85E;
	Wed, 13 Dec 2023 15:03:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2782A0;
	Wed, 13 Dec 2023 07:03:51 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b9e0c3c2c8so946705b6e.0;
        Wed, 13 Dec 2023 07:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479831; x=1703084631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyiflUqSFGHntlf4UNzumPP+00Uc42t7yYwDrcWMbsg=;
        b=k08xJMdUOBjeLjEVsMoQrkx/qU1AKkZM66+1ZR0XmyGhnZO0RiE9xg5Eu99U9QfT00
         FTC+h/uhZUuUrpW0qR5tI5c75InqT1Fotmb9nOnuf746MSbbv3VFrkarVmrMTiixcoD1
         GUqPlekpmE0HzYhcpsBJKjDtz+63QXgo3OBUEjoUQkJXaO5jfxs7hNq7JTdtN5dMUbHs
         pdWAL+OXG0ZipeBK/GTcte8SxZ5vBd05H2Vc8EfFhTYlrr1Gvco2kw1IG+2npaCKRwtv
         eVnP9CpSvWgvi2+hFJwXBLOWPaPDeSMF2OS49hCz2ve9GZlTa3g+dXovE00uQ2fKMq9k
         1vtQ==
X-Gm-Message-State: AOJu0YxzXpwClXi+WglDJZzWWTA4iNz25hRZC9aV6Hz0IczvQ9MDFNj5
	GHPZWsmMCpFSPXvpqk2LnZwRzi0pnM61sfzb/To=
X-Google-Smtp-Source: AGHT+IHvT7JkrTY4AvYKjVr/3bgqpnxyRLqiLSNxb4ogSdv4HI+tmxqt/NeN7GpEzWFRU7K18bO5x6NjKq02fw7Q7NQ=
X-Received: by 2002:a05:6870:961d:b0:1fb:1576:ee66 with SMTP id
 d29-20020a056870961d00b001fb1576ee66mr14805884oaq.5.1702479831103; Wed, 13
 Dec 2023 07:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com> <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com> <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
 <6579c604.050a0220.8fe5c.d191@mx.google.com>
In-Reply-To: <6579c604.050a0220.8fe5c.d191@mx.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 16:03:40 +0100
Message-ID: <CAJZ5v0iyagOX-bL4XhfGd5H-ubK=HjaniDvYB_ZJhKSfqaS09g@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:56=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Wed, Dec 13, 2023 at 03:43:54PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 3:20=E2=80=AFPM Christian Marangi <ansuelsmth@g=
mail.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
> > > > On 12/12/2023 23:13, Christian Marangi wrote:
> > > > > Add initial support for cold and critical_cold trip point. Many i=
f not
> > > > > all hwmon and thermal device have normally trip point for hot
> > > > > temperature and for cold temperature.
> > > > >
> > > > > Till now only hot temperature were supported. Add support for als=
o cold
> > > > > temperature to permit complete definition of cold trip point in D=
T.
> > > > >
> > > > > Thermal driver may use these additional trip point to correctly s=
et
> > > > > interrupt for cold temperature values and react based on that wit=
h
> > > > > various measure like enabling attached heater, forcing higher vol=
tage
> > > > > and other specialaized peripherals.
> > > > >
> > > > > For hwmon drivers this is needed as currently there is a problem =
with
> > > > > setting the full operating range of the device for thermal device=
s
> > > > > defined with hwmon. To better describe the problem, the following
> > > > > example is needed:
> > > > >
> > > > > In the scenario of a simple hwmon with an active trip point decla=
red
> > > > > and a cooling device attached, the hwmon subsystem currently set =
the
> > > > > min and max trip point based on the single active trip point.
> > > > > Thermal subsystem parse all the trip points and calculate the low=
est and
> > > > > the highest trip point and calls the .set_trip of hwmon to setup =
the
> > > > > trip points.
> > > > >
> > > > > The fact that we currently don't have a way to declare the cold/m=
in
> > > > > temperature values, makes the thermal subsystem to set the low va=
lue as
> > > > > -INT_MAX.
> > > > > For hwmon drivers that doesn't use clamp_value and actually rejec=
t
> > > > > invalid values for the trip point, this results in the hwmon sett=
ings to
> > > > > be rejected.
> > > > >
> > > > > To permit to pass the correct range of trip point, permit to set =
in DT
> > > > > also cold and critical_cold trip point.
> > > > >
> > > > > Thermal driver may also define .cold and .critical_cold to act on=
 these
> > > > > trip point tripped and apply the required measure.
> > > >
> > > > Agree with the feature but we need to clarify the semantic of the t=
rip
> > > > points first. What actions do we expect for them in order to have l=
ike a
> > > > mirror reflection of the existing hot trip points.
> > > >
> > > > What action do you expect with:
> > > >
> > > >  - 'cold' ?
> > > >
> > > >  - 'critical_cold' ?
> > > >
> > > >
> > >
> > > This is more of a sensible topic but I think it's the thermal driver
> > > that needs to implement these. As said in the commit description,
> > > examples are setting higher voltage from the attached regulator,
> > > enabling some hardware heater.
> >
> > So how is it different from an active trip point?  There are heating
> > rather than cooling devices associated with it, but other than this??
> >
>
> From what I read from documentation, active trip point are used to
> trigger cooling-device. Cold (and crit_cold) are to setup trip point to
> the device. The device will normally trigger an interrupt

Well, that's how thermal sensors work in general IIUC.

> (or even internally with the correct register set autonomously apply some=
 measure
> to handle the problem)
>
> In theory it's possible to have passive trip point for cold condition
> but still we lack any definition of the lower spectrum of the trip
> point.

Such that it will increase power of some devices in order to warm the
system up?  Fair enough.

> > > Maybe with critical cold bigger measure can be applied. Currently for
> > > critical trip point we shutdown the system (if the critical ops is no=
t
> > > declared) but with critical_cold condition I think it won't work... I
> > > expect a system in -40=C2=B0C would just lock up/glitch so rebooting =
in that
> > > condition won't change a thing...
> > >
> > > Anyway yes we can define a shutdown by default for that but IMHO it
> > > wouldn't make much sense.
> >
> > So why do you want to add it at all?
>
> Again it's really to fill a hole we have from a long time... One example
> is the qcom tsens driver that have trip point for cold and crit_cold.
> Those in theory can be set in DT with the trip point but we lack any
> definition for them. (using passive trip point would be confusing IMHO)
>
> Another example is an Aquantia PHY that have register for the cold and
> critical_cold trip point.

My point is about the crit_cold trips in particular.  If there is no
common action to trigger when they are crossed, what are they actually
good for?

> Currently defining a critical trip point for the negative temp results
> in the system shutdown.

Sure.

