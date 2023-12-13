Return-Path: <linux-pm+bounces-1103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D3D81153D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9A282263
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870842EB04;
	Wed, 13 Dec 2023 14:51:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BBCB9;
	Wed, 13 Dec 2023 06:51:18 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d6f8485eso906004a34.0;
        Wed, 13 Dec 2023 06:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479078; x=1703083878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1EvFFVOH22ZV2tNYxK2mWh2NGGfr5HyRfUa9IlZAEo=;
        b=dq/TFdB1qFO8lj/isGjNWwlIceOXA5M1moFE3q1LFsNGA7IFwwUHEmcGkdn2QVgHBr
         GrPmOTg0z2jUJQQyeR5HC5nVcj15mLWaYRfFhFXagzrFjJzzg7KuX80uuJtny/0cLXBT
         2YegRrnbxo9eWGGZ3/ECiOv4+fMiZXKM0PvXPsj7zPpLxEGP/py0WTdV43s+JXZs+9+O
         gm1IVd+yRse1kxN7HwdCuFPAYoOYknK+s/qWlhYDmdbY6dJ1HAHo/oTNcxThjX6kaNJF
         jgArna9zvkWR8cnPRyTg5fBREexXcNlaUUoOTen1JnGqolu7G8pp+NrkIpDgHWWfvf20
         vF9Q==
X-Gm-Message-State: AOJu0YyXZ4KR+n5B0HMU6qSIo/P8GcUSNDjjMLrcuKuRGf/w4SEVU3+L
	hOB3ZBx5zX/nonQ4DxaScRoHXF3TYJV3EM7U31M=
X-Google-Smtp-Source: AGHT+IHEYcPehosER/urk1wqIxlCb5JbAyX2wXSph7zNSoXPzjo7wuYIgSSIYh7oqPg+JxPgtduVpIAEManu8NuJhJs=
X-Received: by 2002:a05:6871:e717:b0:1fa:df87:4eba with SMTP id
 qa23-20020a056871e71700b001fadf874ebamr16106757oac.5.1702479078142; Wed, 13
 Dec 2023 06:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com> <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com> <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 15:51:07 +0100
Message-ID: <CAJZ5v0iN6quW7c3B+e7eDcXFA7wjWkw3nJpxr6fV6SoVH6U_KA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 3:20=E2=80=AFPM Christian Marangi <ansuelsmth@gma=
il.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
> > > On 12/12/2023 23:13, Christian Marangi wrote:
> > > > Add initial support for cold and critical_cold trip point. Many if =
not
> > > > all hwmon and thermal device have normally trip point for hot
> > > > temperature and for cold temperature.
> > > >
> > > > Till now only hot temperature were supported. Add support for also =
cold
> > > > temperature to permit complete definition of cold trip point in DT.
> > > >
> > > > Thermal driver may use these additional trip point to correctly set
> > > > interrupt for cold temperature values and react based on that with
> > > > various measure like enabling attached heater, forcing higher volta=
ge
> > > > and other specialaized peripherals.
> > > >
> > > > For hwmon drivers this is needed as currently there is a problem wi=
th
> > > > setting the full operating range of the device for thermal devices
> > > > defined with hwmon. To better describe the problem, the following
> > > > example is needed:
> > > >
> > > > In the scenario of a simple hwmon with an active trip point declare=
d
> > > > and a cooling device attached, the hwmon subsystem currently set th=
e
> > > > min and max trip point based on the single active trip point.
> > > > Thermal subsystem parse all the trip points and calculate the lowes=
t and
> > > > the highest trip point and calls the .set_trip of hwmon to setup th=
e
> > > > trip points.
> > > >
> > > > The fact that we currently don't have a way to declare the cold/min
> > > > temperature values, makes the thermal subsystem to set the low valu=
e as
> > > > -INT_MAX.
> > > > For hwmon drivers that doesn't use clamp_value and actually reject
> > > > invalid values for the trip point, this results in the hwmon settin=
gs to
> > > > be rejected.
> > > >
> > > > To permit to pass the correct range of trip point, permit to set in=
 DT
> > > > also cold and critical_cold trip point.
> > > >
> > > > Thermal driver may also define .cold and .critical_cold to act on t=
hese
> > > > trip point tripped and apply the required measure.
> > >
> > > Agree with the feature but we need to clarify the semantic of the tri=
p
> > > points first. What actions do we expect for them in order to have lik=
e a
> > > mirror reflection of the existing hot trip points.
> > >
> > > What action do you expect with:
> > >
> > >  - 'cold' ?
> > >
> > >  - 'critical_cold' ?
> > >
> > >
> >
> > This is more of a sensible topic but I think it's the thermal driver
> > that needs to implement these. As said in the commit description,
> > examples are setting higher voltage from the attached regulator,
> > enabling some hardware heater.
>
> So how is it different from an active trip point?  There are heating
> rather than cooling devices associated with it, but other than this??

And, of course, the mitigation would trigger when crossed on the way
down and the hysteresis value would be added to the temperature.

So it all looks like a "reverse" active trip point.

> > Maybe with critical cold bigger measure can be applied. Currently for
> > critical trip point we shutdown the system (if the critical ops is not
> > declared) but with critical_cold condition I think it won't work... I
> > expect a system in -40=C2=B0C would just lock up/glitch so rebooting in=
 that
> > condition won't change a thing...
> >
> > Anyway yes we can define a shutdown by default for that but IMHO it
> > wouldn't make much sense.
>
> So why do you want to add it at all?

