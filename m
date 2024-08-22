Return-Path: <linux-pm+bounces-12710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA7295B21A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942BE1C23604
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DD188A00;
	Thu, 22 Aug 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk6XHOgG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB118452E
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319697; cv=none; b=OpPtlWjyt/+oqEIruZ+etAoJLA+5VbCzsS8dadsC/BOagRSolQxmREROiHgEDRrrcHnoTWfNUD+RBwpbRpfETcUik2dcsyF7V5JuTmn8F4Bk1NDvgkbY2V24HfljZCrdnCcw0zxa6vGcETZb2WZTjoMmkb0JChq0jPlbfB3iEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319697; c=relaxed/simple;
	bh=jWOodUxIWbH6irgL6dPN07YvwrDgI0LTes0qqfA4JgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcOVzkIb8TNJsziKkNea6SxFMz6Sy5zwIvkzV4KXqanuKW7P+grLk1s9HUDomFn2OYxhCb3uVHvbzs/yAyc406yxV7yAJLfI2DScyIkJmHCW1i9Ikv0KesiZJnA/Ul+sXqTmY4YWKVEF3O4jaSHrvy5RpbkqN/3iLYWMw4v6sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk6XHOgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B291C4AF10
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724319697;
	bh=jWOodUxIWbH6irgL6dPN07YvwrDgI0LTes0qqfA4JgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pk6XHOgGKuib7MJ3ZE1hDcHHgkMBVyzlgaxybsmJsWC8wRTkXywDKn2bm+/VdMTwK
	 x3FRHc51PnA3DeF1BKJK5/MskNjD1pFDjAZeLoP53G1Y59UjWibtxJmTgLOW5Z3rPc
	 KFkqXHmNehrH6bRjvjmRSVz4MnGQ0ezS7EuuV84hx3eZQLhvrsgniSaAU1SZ+TtUss
	 L9GBDBBD6NSxZq2qE1HJKxqZQxmMwG5PYr72a3fTya6BMoWYe/H7EXaaP2zbgjpq7k
	 jl6WiXm+t064R9HxDaP1YQM90fEQxZMZHQf6Y7WiEy9NTMlN7cGLzAEdbh37+Ob9zq
	 zMZigtAbttdeg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27046394c9bso342795fac.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 02:41:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5m51BtKoOoJOFksgtID/zbw9qLdCTHFKr4TYjiQ9ViVg3l/5f0bpKEJDYU1JAa36NGCo4EHc+og==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9gtat/izWr861DvqsOgPTq9x0L51wnnipArZnVOhkLDldzAM
	ZKoevWPkvPfQ7mfK0lqHh0e/FhoPL+bDeajoG8MtjifRBc/v6nmDJFuE5ZeJtWU4/PB8JziXCFo
	OXHxri3wMwn+c7DoPe2O1kzWWB8M=
X-Google-Smtp-Source: AGHT+IGeokZcVGODhSlCZ71lFX78fAkJoua7/yyvPiMGia/4ZPKez3ejlMm7BiIHIPM06zmsRrjDp3wjjPXesZ3HLYQ=
X-Received: by 2002:a05:6870:14cc:b0:26f:f1ea:6a4f with SMTP id
 586e51a60fabf-2737eec3d46mr5470222fac.1.1724319696304; Thu, 22 Aug 2024
 02:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com> <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
In-Reply-To: <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 11:41:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
Message-ID: <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"quic_manafm@quicinc.com" <quic_manafm@quicinc.com>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 12:16=E2=80=AFAM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> On Wed, 2024-08-21 at 22:20 +0200, Rafael J. Wysocki wrote:
> > Hi Srinivas,
> >
> > On Wed, Aug 21, 2024 at 10:04=E2=80=AFPM Pandruvada, Srinivas
> > <srinivas.pandruvada@intel.com> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On Fri, 2024-08-16 at 10:12 +0200, Daniel Lezcano wrote:
> > > > The trip points are a firmware description of the temperature
> > > > limits
> > > > of a specific thermal zone where we associate an action which is
> > > > done
> > > > by the kernel. The time resolution is low.
> > > >
> > > > The userspace has to deal with a more complex thermal management
> > > > based
> > > > on heuristics from different information coming from different
> > > > places. The logic is much more complex but based on a bigger time
> > > > resolution, usually one second based.
> > > >
> > > > The purpose of the userspace is to monitor the temperatures from
> > > > different places and take actions. However, it can not be
> > > > constantly
> > > > reading the temperature to detect when a temperature threshold
> > > > has
> > > > been reached. This is especially bad for mobile or embedded
> > > > system as
> > > > that will lead to an unacceptable number of wakeup to check the
> > > > temperature with nothing to do.
> > > >
> > > > On the other side, the sensors are now most of the time interrupt
> > > > driven. That means the thermal framework will use the temperature
> > > > trip
> > > > points to program the sensor to trigger an interrupt when a
> > > > temperature limit is crossed.
> > > >
> > > > Unfortunately, the userspace can not benefit this feature and
> > > > current
> > > > solutions found here and there, iow out-of-tree, are to add fake
> > > > trip
> > > > points in the firmware and enable the writable trip points.
> > > >
> > > > This is bad for different reasons, the trip points are for in-
> > > > kernel
> > > > actions, the semantic of their types is used by the thermal
> > > > framework
> > > > and by adding trip points in the device tree is a way to overcome
> > > > the
> > > > current limitation but tampering with how the thermal framework
> > > > is
> > > > supposed to work. The writable trip points is a way to adjust a
> > > > temperature limit given a specific platform if the firmware is
> > > > not
> > > > accurate enough and TBH it is more a debug feature from my POV.
> > > >
> > > > The thresholds mechanism is a way to have the userspace to tell
> > > > thermal framework to send a notification when a temperature limit
> > > > is
> > > > crossed. There is no id, no hysteresis, just the temperature and
> > > > the
> > > > direction of the limit crossing. That means we can be notified
> > > > when a
> > > > threshold is crossed the way up only, or the way down only or
> > > > both
> > > > ways. That allows to create hysteresis values if it is needed.
> > > >
> > > > A threshold can be added, deleted or flushed. The latter means
> > > > all
> > > > thresholds belonging to a thermal zone will be deleted.
> > > >
> > >
> > > So you are proposing to add threshold via netlink, not adding any
> > > new
> > > sysfs attribute? That is not clear here.
> > >
> > > I think you are adding"
> > > THERMAL_GENL_CMD_THRESHOLD_GET
> > > THERMAL_GENL_CMD_THRESHOLD_ADD
> > > THERMAL_GENL_CMD_THRESHOLD_DELETE
> > > THERMAL_GENL_CMD_THRESHOLD_FLUSH
> > >
> > > We need to document our netlink messages including old ones.
> > >
> > > Also we should add "MODIFY" as we tend to change them quite often.
> > >
> > > Also no hysteresis, that is practically we can't use.
> >
> > The direction thing is equivalent to hysteresis though.
> >
> > Instead of using one threshold with a given hysteresis value, use two
> > of them with different temperature values and different directions.
> >
> > > Temperature changes so much that that will flood user space. You
> > > will get 100s of
> > > events on CPU temperature if you set temperature threshold in CPU.
> >
> > Events only trigger when thresholds are crossed in a specific
> > direction, but overall you have a point.
>
> This is good enough for some sensor which changes slowly like skin.

Right, and I think that this is the driving use case.

> But some sensors like CPU and board are not like that.

Sure, so this interface will not be for them.

> We publish both raw and filtered event count in debugfs for x86 package t=
emp.
> For example, I just ran a sample on a client for one threshold.
>
> Total notification from hardware: 224
> Notified to user space: 16

So did you apply the Daniel's patches and run the test or did you do
something else?

> >
> > > We have a whole filtering in driver to avoid this.
> > > You need a rate limit here.
> > >
> > > There are multiple user processes can add threshold and there is no
> > > ownership. So one process can cause too much noise to others as it
> > > is
> > > multicast.
> > >
> > > We worked on a change to filer these as discussed during last LPC,
> > > but
> > > not posted yet. This will really need this as this will be too many
> > > messages.
> >
> > Unless there is a way to limit your subscription to events regarding
> > a
> > specific thermal zone, for instance.
> That's what this change does.
>
> >
> > Anyway, I have to admit ignorance regarding the user space usage
> > model
> > related to this.  For example, is it expected that there will be one
> > user space entity managing the thresholds or there can be many.
>
> Good question. That's why we didn't send this change. If there is one
> agent this is fine.

I think that the addition and deletion of a user threshold should be
privileged operations.

If that is the case, it all boils down to proper coordination in user space=
.

> But in embedded space, there may be more than one. Hence they needed
> netlink multicast instead of just one char device.

I see.

