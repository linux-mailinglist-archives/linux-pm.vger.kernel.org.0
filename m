Return-Path: <linux-pm+bounces-1107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9F8115EF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF841C20E11
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1730CEC;
	Wed, 13 Dec 2023 15:16:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D8F4;
	Wed, 13 Dec 2023 07:16:40 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58dd5193db4so375863eaf.1;
        Wed, 13 Dec 2023 07:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480600; x=1703085400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iccEYbDvVyN9pgc0//TtmMVBDajem1Jz5v1zpzG1EA=;
        b=dhrsHBf19NrqrbQBDRXZ2Q8+DGmLl7MYv6yT/6fMF93x0BVrkvXuhyTafO3M9Eo9m6
         X1EOd36CAa7zg5yiVyxAEnj7pMgdysSLAWays1tt1RBgkIbE0kPsmqHT6KWrBahCsy0t
         zZwKgFZHTyjmAQZo5mjckKhhR+u/aj3ymZRaj1MQp0oDAT3XUPtdazr/e1R3N+KEPjQF
         a5CzkFd26Y4VAL9FJlvPhXQtBE71PsJLpgJUYKH0EcQgf6TTxtnMJJrJQGUTePH8R0M3
         ej4WKnxwJwXr4FEFgkZWKyJ0L8v9dUrwjEijrVTb23y7dEMBW8RF0vaMpMSmGPkRSGQT
         br9w==
X-Gm-Message-State: AOJu0YxJOFVR6KHjaYarWPOHwaTcod6qrlwCMj3p4pBI3R34+jbw64ae
	nDN+veGhT51gNKqF9z2V1s2xag2yUB7sIR8TOEQ=
X-Google-Smtp-Source: AGHT+IE2ETE46dqDQ6JKz6VLoeKTvI19yXQTVCEhxSJl1SYkxr2CBvdQ1IgSntlBXqYcyjH7H3kk5KMEv7d99MSzDhE=
X-Received: by 2002:a05:6871:892:b0:203:1727:c6b with SMTP id
 r18-20020a056871089200b0020317270c6bmr3244904oaq.5.1702480599618; Wed, 13 Dec
 2023 07:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com> <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com> <1788318a-2f65-451e-8d02-4de1bb93df3c@linaro.org>
In-Reply-To: <1788318a-2f65-451e-8d02-4de1bb93df3c@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 16:16:28 +0100
Message-ID: <CAJZ5v0gC0-tN6wAqxiZZLxspYm8TbjXVVZSW=50UY3nFs1qcdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 4:10=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/12/2023 15:20, Christian Marangi wrote:
> > On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
> >> On 12/12/2023 23:13, Christian Marangi wrote:
> >>> Add initial support for cold and critical_cold trip point. Many if no=
t
> >>> all hwmon and thermal device have normally trip point for hot
> >>> temperature and for cold temperature.
> >>>
> >>> Till now only hot temperature were supported. Add support for also co=
ld
> >>> temperature to permit complete definition of cold trip point in DT.
> >>>
> >>> Thermal driver may use these additional trip point to correctly set
> >>> interrupt for cold temperature values and react based on that with
> >>> various measure like enabling attached heater, forcing higher voltage
> >>> and other specialaized peripherals.
> >>>
> >>> For hwmon drivers this is needed as currently there is a problem with
> >>> setting the full operating range of the device for thermal devices
> >>> defined with hwmon. To better describe the problem, the following
> >>> example is needed:
> >>>
> >>> In the scenario of a simple hwmon with an active trip point declared
> >>> and a cooling device attached, the hwmon subsystem currently set the
> >>> min and max trip point based on the single active trip point.
> >>> Thermal subsystem parse all the trip points and calculate the lowest =
and
> >>> the highest trip point and calls the .set_trip of hwmon to setup the
> >>> trip points.
> >>>
> >>> The fact that we currently don't have a way to declare the cold/min
> >>> temperature values, makes the thermal subsystem to set the low value =
as
> >>> -INT_MAX.
> >>> For hwmon drivers that doesn't use clamp_value and actually reject
> >>> invalid values for the trip point, this results in the hwmon settings=
 to
> >>> be rejected.
> >>>
> >>> To permit to pass the correct range of trip point, permit to set in D=
T
> >>> also cold and critical_cold trip point.
> >>>
> >>> Thermal driver may also define .cold and .critical_cold to act on the=
se
> >>> trip point tripped and apply the required measure.
> >>
> >> Agree with the feature but we need to clarify the semantic of the trip
> >> points first. What actions do we expect for them in order to have like=
 a
> >> mirror reflection of the existing hot trip points.
> >>
> >> What action do you expect with:
> >>
> >>   - 'cold' ?
> >>
> >>   - 'critical_cold' ?
> >>
> >>
> >
> > This is more of a sensible topic but I think it's the thermal driver
> > that needs to implement these. As said in the commit description,
> > examples are setting higher voltage from the attached regulator,
> > enabling some hardware heater.
>
> That is a warming device. In the thermal framework design it is part of
> the mitigation device actors like a cooling device. The driver does not
> have to deal with that.
>
> > Maybe with critical cold bigger measure can be applied. Currently for
> > critical trip point we shutdown the system (if the critical ops is not
> > declared) but with critical_cold condition I think it won't work... I
> > expect a system in -40=C2=B0C would just lock up/glitch so rebooting in=
 that
> > condition won't change a thing...
>
>  From my POV, a critical trip point is for a too hot or too cold trip
> point. The temperature should be set before the system will be
> malfunctioning, so a halt (or reboot if set) should work.
>
> I'm not in favor of adding more callbacks if we can avoid them. Passing
> the trip point to the critical callback makes more sense to me.
>
> > Anyway yes we can define a shutdown by default for that but IMHO it
> > wouldn't make much sense.
>
> Why? If the device is about to go to out of the functioning range, then
> it makes sense to shut it down. IIRC, electric signals lose their
> stability below the lower bound temperature.
>
> There is the point about the mitigation to stay above a certain
> temperature. If the devices do not have any kind a 'warming' device,
> then an alternative would be to have a generic warming device mirroring
> the cooling device with a duty cycles at different performance states.
> With this case, we may need another trip point type for a governor which
> should handle that.
>
> So we end up with the question: shall we add trip point types or trip
> point properties?
>
> 1. Trip point types
>
>   - active / passive : mitigate
>   - hot : notify userspace
>   - critical : halt by default
>   - cold : do something
>   - cold_crit : do something else with a callback
>
> 2. Trip point types + property
>
>   - active / passive : mitigate
>     - hot : cool down
>     - cold : warm up
>
>   - hot : notify userspace
>   - cold : notify userspace
>
>   - critical:
>    - hot : shutdown (or callback + trip)
>    - cold : shutdown (or callback + trip)
>
> That implies there are two models:
>
> 1. We assume cold / hot trip points are symmetric features of the
> thermal management. So we do mitigation using governors, if that
> mitigation fails then we end up with critical actions. A consistent
> behavior between temperature increase or decrease. From my POV, I prefer
> this approach because it reflects nicely the functioning range temperatur=
e.

I agree here, FWIW.

> 2. We handle the cold situation differently by doing a on/off action on
> a specific device. That is an asymmetric approach.

