Return-Path: <linux-pm+bounces-12719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19B95B5D6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CADAB216B1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272A18452D;
	Thu, 22 Aug 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg4CQQnc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF123774
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331725; cv=none; b=jHrYOrLifPI0kGwkliXAUvX6uBO5M9xUhpOuGgE/wwk7P8dyeAZpH98tUMj81OKjmyNTsS0sjOK2s/tiHRqkJRIHQNA3nOfN5McSgb0azUAUaFvg8elOqGQbNUieQCxhDtQ7c+mmLlXNKKdKrBU5AaCOt1M5kteTABN8bB8UZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331725; c=relaxed/simple;
	bh=0uo3f3s8jRGupeeln2p9z8TXlW8fCJRPD0VWTU6/FWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDpz+u4Ytv1rn+9qbmWHit9CF4vmrbYWFVlfsc8JYMKslWvaA6NyBSqbMkBx3z6J4n9rF+TgogqqpJXRfZF6bqxeb8/zQLno9W9jqGV3CscsgEmW9Nvu8rDiRGPHPZkzQyqHTrIsU3s6nB5jBqTxQYMipcTTKe99T9S3ekQsylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg4CQQnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39002C32782
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331725;
	bh=0uo3f3s8jRGupeeln2p9z8TXlW8fCJRPD0VWTU6/FWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fg4CQQncu8acR7cS6FLiqiaNw/c9nG//eJtQjGxLL2Mehax8vW5Fim1AWoqPj6JG6
	 sYkWF+DEMHs+8kEBtNSaRvAMkknHYyUo3ez2dV8TFgonGb3gqcXyQuxsX5uQ6Ymjcn
	 wAYu7s6OLDKHvlC4I8vHNHF1WK8bfWSi4fUhk7xTxOAnTXJSfx22kmGCQBszQePesa
	 9rXI4cp4XqCIiAih1FjT4FmzV0JBVkEznLg89hVMFwxgX6I+H3vNLVHw0MClh7op8R
	 WMrmanKTACOy5qk4Ut3hYHWDs1+Htq62lc3Ns4jsZjMqL5NwsOACgvZpiWOqGSrWJy
	 1z2CrGIvSUO3g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2702ed1054fso488145fac.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 06:02:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlt6eJIOnHqAmkVn/AfKmsYFKoe2nCgarJxshK3KZ0Ez7oEymGH7k1Y+hyJcOL6udfjZGufsBmzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8q0pniDAVmdEj0JXb26VIWqxf+7I2vfAsdoK4EauFtfnYuBV
	Wl0AJDgJdXY7bGH15ITa3Ut5f4CU7qrPumxBDo9n6cYAyYsecM9smz5SjN+x4r5HyqgtEMXIUtn
	Hzq729RYVZcAL4fKYrWfZzhYceMg=
X-Google-Smtp-Source: AGHT+IEbgB9y0rWmufnEOAa5mhkP+qGpL1ZBGJZ8S8YUSZccZFRE8JoQKYgm53NoFrM5yTOPgydbVhmTMXc0g27P2s4=
X-Received: by 2002:a05:6870:8a1f:b0:268:acce:455f with SMTP id
 586e51a60fabf-273cff4852cmr2254820fac.32.1724331724484; Thu, 22 Aug 2024
 06:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
 <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
 <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
 <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com> <4e06ed4bfb3f6f03eaefb73763bf3021829502ce.camel@intel.com>
In-Reply-To: <4e06ed4bfb3f6f03eaefb73763bf3021829502ce.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 15:01:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i10DJwpVPz6re518-UAAEMHFp8bhkTenpKk8o-RCxYMA@mail.gmail.com>
Message-ID: <CAJZ5v0i10DJwpVPz6re518-UAAEMHFp8bhkTenpKk8o-RCxYMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"quic_manafm@quicinc.com" <quic_manafm@quicinc.com>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:52=E2=80=AFPM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> On Thu, 2024-08-22 at 12:11 +0000, Pandruvada, Srinivas wrote:
> > On Thu, 2024-08-22 at 11:41 +0200, Rafael J. Wysocki wrote:
> > > On Thu, Aug 22, 2024 at 12:16=E2=80=AFAM Pandruvada, Srinivas
> > > <srinivas.pandruvada@intel.com> wrote:
> > > >
> > > > On Wed, 2024-08-21 at 22:20 +0200, Rafael J. Wysocki wrote:
> > > > > Hi Srinivas,
> > > > >
> > > > > On Wed, Aug 21, 2024 at 10:04=E2=80=AFPM Pandruvada, Srinivas
> > > > > <srinivas.pandruvada@intel.com> wrote:
> > > > > >
> > > > > > Hi Daniel,
> > > > > >
> > > > > > On Fri, 2024-08-16 at 10:12 +0200, Daniel Lezcano wrote:
> > > > > > > The trip points are a firmware description of the
> > > > > > > temperature
> > > > > > > limits
> > > > > > > of a specific thermal zone where we associate an action
> > > > > > > whichcan't
> > > > > > > is
> > > > > > > done
> > > > > > > by the kernel. The time resolution is low.
> > > > > > >
> > > > > > > The userspace has to deal with a more complex thermal
> > > > > > > management
> > > > > > > based
> > > > > > > on heuristics from different information coming from
> > > > > > > different
> > > > > > > places. The logic is much more complex but based on a
> > > > > > > bigger
> > > > > > > time
> > > > > > > resolution, usually one second based.
> > > > > > >
> > > > > > > The purpose of the userspace is to monitor the temperatures
> > > > > > > from
> > > > > > > different places and take actions. However, it can not be
> > > > > > > constantly
> > > > > > > reading the temperature to detect when a temperature
> > > > > > > threshold
> > > > > > > has
> > > > > > > been reached. This is especially bad for mobile or embedded
> > > > > > > system as
> > > > > > > that will lead to an unacceptable number of wakeup to check
> > > > > > > the
> > > > > > > temperature with nothing to do.
> > > > > > >
> > > > > > > On the other side, the sensors are now most of the time
> > > > > > > interrupt
> > > > > > > driven. That means the thermal framework will use the
> > > > > > > temperature
> > > > > > > trip
> > > > > > > points to program the sensor to trigger an interrupt when a
> > > > > > > temperature limit is crossed.
> > > > > > >
> > > > > > > Unfortunately, the userspace can not benefit this feature
> > > > > > > and
> > > > > > > current
> > > > > > > solutions found here and there, iow out-of-tree, are to add
> > > > > > > fake
> > > > > > > trip
> > > > > > > points in the firmware and enable the writable trip points.
> > > > > > >
> > > > > > > This is bad for different reasons, the trip points are for
> > > > > > > in-
> > > > > > > kernel
> > > > > > > actions, the semantic of their types is used by the thermal
> > > > > > > framework
> > > > > > > and by adding trip points in the device tree is a way to
> > > > > > > overcome
> > > > > > > the
> > > > > > > current limitation but tampering with how the thermal
> > > > > > > framework
> > > > > > > is
> > > > > > > supposed to work. The writable trip points is a way to
> > > > > > > adjust
> > > > > > > a
> > > > > > > temperature limit given a specific platform if the firmware
> > > > > > > is
> > > > > > > not
> > > > > > > accurate enough and TBH it is more a debug feature from my
> > > > > > > POV.
> > > > > > >
> > > > > > > The thresholds mechanism is a way to have the userspace to
> > > > > > > tell
> > > > > > > thermal framework to send a notification when a temperature
> > > > > > > limit
> > > > > > > is
> > > > > > > crossed. There is no id, no hysteresis, just the
> > > > > > > temperature
> > > > > > > and
> > > > > > > the
> > > > > > > direction of the limit crossing. That means we can be
> > > > > > > notified
> > > > > > > when a
> > > > > > > threshold is crossed the way up only, or the way down only
> > > > > > > or
> > > > > > > both
> > > > > > > ways. That allows to create hysteresis values if it is
> > > > > > > needed.
> > > > > > >
> > > > > > > A threshold can be added, deleted or flushed. The latter
> > > > > > > means
> > > > > > > all
> > > > > > > thresholds belonging to a thermal zone will be deleted.
> > > > > > >
> > > > > >
> > > > > > So you are proposing to add threshold via netlink, not adding
> > > > > > any
> > > > > > new
> > > > > > sysfs attribute? That is not clear here.
> > > > > >
> > > > > > I think you are adding"
> > > > > > THERMAL_GENL_CMD_THRESHOLD_GET
> > > > > > THERMAL_GENL_CMD_THRESHOLD_ADD
> > > > > > THERMAL_GENL_CMD_THRESHOLD_DELETE
> > > > > > THERMAL_GENL_CMD_THRESHOLD_FLUSH
> > > > > >
> > > > > > We need to document our netlink messages including old ones.
> > > > > >
> > > > > > Also we should add "MODIFY" as we tend to change them quite
> > > > > > often.
> > > > > >
> > > > > > Also no hysteresis, that is practically we can't use.
> > > > >
> > > > > The direction thing is equivalent to hysteresis though.
> > > > >
> > > > > Instead of using one threshold with a given hysteresis value,
> > > > > use
> > > > > two
> > > > > of them with different temperature values and different
> > > > > directions.
> > > > >
> > > > > > Temperature changes so much that that will flood user space.
> > > > > > You
> > > > > > will get 100s of
> > > > > > events on CPU temperature if you set temperature threshold in
> > > > > > CPU.
> > > > >
> > > > > Events only trigger when thresholds are crossed in a specific
> > > > > direction, but overall you have a point.
> > > >
> > > > This is good enough for some sensor which changes slowly like
> > > > skin.
> > >
> > > Right, and I think that this is the driving use case.
> > >
> > > > But some sensors like CPU and board are not like that.
> > >
> > > Sure, so this interface will not be for them.
> > But when we design an interface, I think this shouldn't be sensor
> > dependent.
> >
> > >
> > > > We publish both raw and filtered event count in debugfs for x86
> > > > package temp.
> > > > For example, I just ran a sample on a client for one threshold.
> > > >
> > > > Total notification from hardware: 224
> > > > Notified to user space: 16
> > >
> > > So did you apply the Daniel's patches and run the test or did you
> > > do
> > > something else?
> > We already use netlink to send notification to user space via
> > writable
> > trip. So didn't apply any patches. I don't see these patches will do
> > any different.
>
> I mean without rate limit here all 224 notifications will be passed to
> user space (not 16). Temperature goes up and down over threshold for
> 100s of times before settling.

Yeah, that needs a real trip point with hysteresis.

Or the threshold could be removed once crossed and then added back
when the temperature falls down sufficiently.

> I can give  a try with this series to confirm.

That would be premature at this point.

