Return-Path: <linux-pm+bounces-12658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26695A5C0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FD21C21D99
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444516F0E7;
	Wed, 21 Aug 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnB7xBPO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8C28DCB
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271626; cv=none; b=QwAPeiwQfhiVt+x14+fmutcbgEGt4AKNTVJ1yITwH4uzZSzTKVL6TpEcNa7iJBCTrUusLt7WY5jcPGUS+0LQkDm1xC3iP9sbXAK25tE4FHshD8G3T0ramZ02v24BqoO0KCsDaIPECQHDjCuTdXuhmYrGkHe9xCHJ0wEvjM+YL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271626; c=relaxed/simple;
	bh=XbMOfiBhVVzAsV5+5/PEs3l0gQBWC4ZGEctmyMkMBuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8t2atE3UWrg7L2GYwBQtXnlRzp8WiVKMjd11kdve7FPoCtas5/tSkrEBcUNhjM6Ivz/vsF4n5uxtMIGv2DufzxQQsnQb5iZtGL6/iGP+hF+cjh7lGlSfspNhDW3bbzAzvupGTudEP55ZqEDOxG53bcPIVsxqZd3/A/dKDyMZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnB7xBPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFFC4AF09
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724271624;
	bh=XbMOfiBhVVzAsV5+5/PEs3l0gQBWC4ZGEctmyMkMBuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fnB7xBPOYiHJBoAxpPGd/RFzD3quJ1CIwCIEMXUDXoWZdstYBgDJaSmGoLodMsRNv
	 cNq6BruhM/yIPdEoPaMd9pO8Uka3i07sfNBzWFuXUKVZdvoXwJ9FN0EdvavzuPk071
	 kazsN/i8Df1EL9v/k5AnH9sPStZkaOmz6uP37aC2OSppVZPw1u8VVOY+0txxOfMMeS
	 bl6PiGB9NYs8t/qaTj7GRdREb9UwMccsP+SNqSBPM3pJdzjAZB2ZGokEZparhJQxsW
	 abT8Zfty752x2lnI7Zv7xGvbPE35tK5si3NOPg9cvGSSZIqGEKOwu8zeKPIP8j7Jn2
	 fWSvhOZ51/96g==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70930972e19so59393a34.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:20:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHlEzo/NrJU1k8ihl6wFoyZVNf8Mymp34p01HTMgkWFoc4muAIpYUVSFCtfa9Px+6mj17CUfOSyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqkUXbntUJ8oMSZbzsNokPm8RUAoCkS6aIpCb2xvRDFszJWZxp
	LHrF2IzR8vc23hb7cAJQ2YUamrMrDFzKLbzYVF6ruomiFPqvDyqm3+YAottDOHEx09qPE+BN/f1
	NwnSDvcB0E3D6xuF0oo3jVv5NZuQ=
X-Google-Smtp-Source: AGHT+IGEr3BrHMF3HSpwCHH/Dc69nhf0Cn2Ur6MSJHrTkS3wfG4IQB6ptReTwph+DL0GKPc7mAnUCYWGYBCGEhDRE8o=
X-Received: by 2002:a05:6870:9450:b0:270:10af:3938 with SMTP id
 586e51a60fabf-2737ef54c66mr3838200fac.23.1724271623631; Wed, 21 Aug 2024
 13:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org> <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
In-Reply-To: <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 22:20:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
Message-ID: <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"quic_manafm@quicinc.com" <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Srinivas,

On Wed, Aug 21, 2024 at 10:04=E2=80=AFPM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> Hi Daniel,
>
> On Fri, 2024-08-16 at 10:12 +0200, Daniel Lezcano wrote:
> > The trip points are a firmware description of the temperature limits
> > of a specific thermal zone where we associate an action which is done
> > by the kernel. The time resolution is low.
> >
> > The userspace has to deal with a more complex thermal management
> > based
> > on heuristics from different information coming from different
> > places. The logic is much more complex but based on a bigger time
> > resolution, usually one second based.
> >
> > The purpose of the userspace is to monitor the temperatures from
> > different places and take actions. However, it can not be constantly
> > reading the temperature to detect when a temperature threshold has
> > been reached. This is especially bad for mobile or embedded system as
> > that will lead to an unacceptable number of wakeup to check the
> > temperature with nothing to do.
> >
> > On the other side, the sensors are now most of the time interrupt
> > driven. That means the thermal framework will use the temperature
> > trip
> > points to program the sensor to trigger an interrupt when a
> > temperature limit is crossed.
> >
> > Unfortunately, the userspace can not benefit this feature and current
> > solutions found here and there, iow out-of-tree, are to add fake trip
> > points in the firmware and enable the writable trip points.
> >
> > This is bad for different reasons, the trip points are for in-kernel
> > actions, the semantic of their types is used by the thermal framework
> > and by adding trip points in the device tree is a way to overcome the
> > current limitation but tampering with how the thermal framework is
> > supposed to work. The writable trip points is a way to adjust a
> > temperature limit given a specific platform if the firmware is not
> > accurate enough and TBH it is more a debug feature from my POV.
> >
> > The thresholds mechanism is a way to have the userspace to tell
> > thermal framework to send a notification when a temperature limit is
> > crossed. There is no id, no hysteresis, just the temperature and the
> > direction of the limit crossing. That means we can be notified when a
> > threshold is crossed the way up only, or the way down only or both
> > ways. That allows to create hysteresis values if it is needed.
> >
> > A threshold can be added, deleted or flushed. The latter means all
> > thresholds belonging to a thermal zone will be deleted.
> >
>
> So you are proposing to add threshold via netlink, not adding any new
> sysfs attribute? That is not clear here.
>
> I think you are adding"
> THERMAL_GENL_CMD_THRESHOLD_GET
> THERMAL_GENL_CMD_THRESHOLD_ADD
> THERMAL_GENL_CMD_THRESHOLD_DELETE
> THERMAL_GENL_CMD_THRESHOLD_FLUSH
>
> We need to document our netlink messages including old ones.
>
> Also we should add "MODIFY" as we tend to change them quite often.
>
> Also no hysteresis, that is practically we can't use.

The direction thing is equivalent to hysteresis though.

Instead of using one threshold with a given hysteresis value, use two
of them with different temperature values and different directions.

> Temperature changes so much that that will flood user space. You will get=
 100s of
> events on CPU temperature if you set temperature threshold in CPU.

Events only trigger when thresholds are crossed in a specific
direction, but overall you have a point.

> We have a whole filtering in driver to avoid this.
> You need a rate limit here.
>
> There are multiple user processes can add threshold and there is no
> ownership. So one process can cause too much noise to others as it is
> multicast.
>
> We worked on a change to filer these as discussed during last LPC, but
> not posted yet. This will really need this as this will be too many
> messages.

Unless there is a way to limit your subscription to events regarding a
specific thermal zone, for instance.

Anyway, I have to admit ignorance regarding the user space usage model
related to this.  For example, is it expected that there will be one
user space entity managing the thresholds or there can be many.

