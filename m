Return-Path: <linux-pm+bounces-1102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031E811515
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732C1B2101F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7872EAF2;
	Wed, 13 Dec 2023 14:44:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D41A5;
	Wed, 13 Dec 2023 06:44:07 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6da09f8ce35so973953a34.0;
        Wed, 13 Dec 2023 06:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478646; x=1703083446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrMvvn49L6A1ecr+WgkAgMRVfZjFMImbqMy0wJWQpTA=;
        b=ppqeeUV/8DSgCao+IF4zcsyZji6TdNIRCFCYNO5w6cc65lMkFR/eOKczFpJ5n2NHRe
         zTjM7U4oxkcum8TcF+2bWUMvEKFFHIqr6XIH9jyZwvvIEEl7un742Sk733avTyVtnm9k
         EwD+W3CBXp3Yg9p2BDj686zPqisBGEnwFkXYYvDwGmpJYolQuvC71CzG8qPdr51/5Juh
         0xOgAZlx30N70q//7GePPDpGgmIzWT83WDiSRLkazOPlwRNoDstw9fzNoYM8F2bxX1ON
         QYionq8y2lIYMH6fD2ym4bMPLoawer/9VbZESZs0XMe6pNi2ZYJFT3bh3mqYPMlHuB6T
         lBPA==
X-Gm-Message-State: AOJu0YxeNsMMXD3qiWrY1bz2IRmDFqKPSDoOjvLlK5U2jBGTa10tx7YY
	8kh8OlsNWUSbVj/P/KR0j5Q98/T5jRKHPQf8g/s=
X-Google-Smtp-Source: AGHT+IGPX5+mGS38O4fRWmfbsDU7CQdzXQC4+Vn2QMG5Z6qnEERa5c1Wl/XCOERwmpUEJ8wRKvefIPoyGD1ZMoFh/Wk=
X-Received: by 2002:a05:6870:9607:b0:1fb:23ec:3318 with SMTP id
 d7-20020a056870960700b001fb23ec3318mr15061199oaq.0.1702478645569; Wed, 13 Dec
 2023 06:44:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com> <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
In-Reply-To: <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 15:43:54 +0100
Message-ID: <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:20=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
> > On 12/12/2023 23:13, Christian Marangi wrote:
> > > Add initial support for cold and critical_cold trip point. Many if no=
t
> > > all hwmon and thermal device have normally trip point for hot
> > > temperature and for cold temperature.
> > >
> > > Till now only hot temperature were supported. Add support for also co=
ld
> > > temperature to permit complete definition of cold trip point in DT.
> > >
> > > Thermal driver may use these additional trip point to correctly set
> > > interrupt for cold temperature values and react based on that with
> > > various measure like enabling attached heater, forcing higher voltage
> > > and other specialaized peripherals.
> > >
> > > For hwmon drivers this is needed as currently there is a problem with
> > > setting the full operating range of the device for thermal devices
> > > defined with hwmon. To better describe the problem, the following
> > > example is needed:
> > >
> > > In the scenario of a simple hwmon with an active trip point declared
> > > and a cooling device attached, the hwmon subsystem currently set the
> > > min and max trip point based on the single active trip point.
> > > Thermal subsystem parse all the trip points and calculate the lowest =
and
> > > the highest trip point and calls the .set_trip of hwmon to setup the
> > > trip points.
> > >
> > > The fact that we currently don't have a way to declare the cold/min
> > > temperature values, makes the thermal subsystem to set the low value =
as
> > > -INT_MAX.
> > > For hwmon drivers that doesn't use clamp_value and actually reject
> > > invalid values for the trip point, this results in the hwmon settings=
 to
> > > be rejected.
> > >
> > > To permit to pass the correct range of trip point, permit to set in D=
T
> > > also cold and critical_cold trip point.
> > >
> > > Thermal driver may also define .cold and .critical_cold to act on the=
se
> > > trip point tripped and apply the required measure.
> >
> > Agree with the feature but we need to clarify the semantic of the trip
> > points first. What actions do we expect for them in order to have like =
a
> > mirror reflection of the existing hot trip points.
> >
> > What action do you expect with:
> >
> >  - 'cold' ?
> >
> >  - 'critical_cold' ?
> >
> >
>
> This is more of a sensible topic but I think it's the thermal driver
> that needs to implement these. As said in the commit description,
> examples are setting higher voltage from the attached regulator,
> enabling some hardware heater.

So how is it different from an active trip point?  There are heating
rather than cooling devices associated with it, but other than this??

> Maybe with critical cold bigger measure can be applied. Currently for
> critical trip point we shutdown the system (if the critical ops is not
> declared) but with critical_cold condition I think it won't work... I
> expect a system in -40=C2=B0C would just lock up/glitch so rebooting in t=
hat
> condition won't change a thing...
>
> Anyway yes we can define a shutdown by default for that but IMHO it
> wouldn't make much sense.

So why do you want to add it at all?

