Return-Path: <linux-pm+bounces-1101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919258114DF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6113A1F216B7
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B92EAE0;
	Wed, 13 Dec 2023 14:40:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76D6B0;
	Wed, 13 Dec 2023 06:40:06 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b9f11fee25so956151b6e.1;
        Wed, 13 Dec 2023 06:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478406; x=1703083206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4eH5b/kNXZStKUJz1yn8GPS9DlhIeI1Sb7ArxAFFJU=;
        b=rmnbOOuC3W/OH0jY8RkhyLCwFFP9hdi9aHLivIr8VijujsenKVCwpFyw3E6otXcacn
         GZ121dxNhAAxA+GY+K7DEGBKKuYS3MDLF70SSYPUhl+LVWv8SR7lP3vdFgMtXqAgMjCy
         jhFoLbyDvqE0UCAiOwdydEzgWRUUBIyzLynIjJ2UuzDgqV7G+cnJZTxr4nbQ0hzcPe5s
         ClAj6NwbK0nFnG17T4hd3ptT5/ERI04Y6icPV5qA7UMiSM+90/y+daDKdLr6G6NtPZwc
         wLNiy8wQx3MxP8iagDQjozWxTNmR1yMuC1WfbHnMGmB2uurHucVBx3N/+XidD6kaD980
         lu6Q==
X-Gm-Message-State: AOJu0YxRpLWo8oxNgRT169rIdUms44JwKvY/hROOByyuhxpAk/+5HkZh
	nvKL2I06Jqysw2ruZXdopVyS05fg/wB+kzzSovE=
X-Google-Smtp-Source: AGHT+IEWCL1swIbdKHuvU+v+B6tzQMhrEngFyp0/3LEj35AoUP93VH/Qv+B8zMUA0pRfKlqOP5f2KL+PwbKAyXxI3xQ=
X-Received: by 2002:a05:6870:79d:b0:1fa:60b0:9d9 with SMTP id
 en29-20020a056870079d00b001fa60b009d9mr13969984oab.1.1702478405945; Wed, 13
 Dec 2023 06:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com> <CAJZ5v0gTUSFeR=8ov_CgMzkPF7hJ4_MXYZNvsONC8wMxyhiu=A@mail.gmail.com>
 <65799e2f.5d0a0220.1213a.f035@mx.google.com>
In-Reply-To: <65799e2f.5d0a0220.1213a.f035@mx.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 15:39:54 +0100
Message-ID: <CAJZ5v0iBx3+BY8960C-GG2EdfUdt_E_o4KjKZ5gmx_f73BJGuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:06=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Wed, Dec 13, 2023 at 01:01:51PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 12, 2023 at 11:17=E2=80=AFPM Christian Marangi <ansuelsmth@=
gmail.com> wrote:
> > >
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
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >
> > Generally speaking, it is kind of late in the cycle for adding
> > significant new features like this.  We can get to it when 6.8-rc1 is
> > out, so please resend then.
> >
>
> Ok no problem.
>
> > Also it would be nice to define/document the cold and crtitical_cold
> > trip points somewhere and is there a better name for critical_cold?
> >
>
> Ehhh I think critical_cold is the only correct one.
> Thermal device normally have lowest low high and highest trip point. I
> think the lowest has to match what we use for highest (critical). Using
> coldest might be confusing and wouldn't display a critical condition of
> low temp where the device can't work and immediate actions has to be
> taken.

So at least make it shorter, like crit_cold?

