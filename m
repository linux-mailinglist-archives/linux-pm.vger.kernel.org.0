Return-Path: <linux-pm+bounces-7906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935C8C744B
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 12:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6603286797
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E434143882;
	Thu, 16 May 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YONBDtCI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4F143754;
	Thu, 16 May 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853747; cv=none; b=FpEjS0yKxyBYOX/EFyx7UPdi8IDUutcba85jx4j8CTgAv0MP8IRO6e/bLiDSTb2hOFb2NUQRu8f6eCq1BIsWIsyouEUnSwtVgIYxCZwOUThtNtX68Bok029HtZ5mRQiGQGjX/jMFbHY/bnydITHR/oOo2a/IVL6jYPPqlrBjS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853747; c=relaxed/simple;
	bh=SAQDCGmxGUd6R/tVX/KPXbEtFjW4QRzWBC9l7pf3zJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgR+yxZ3DdZtYbaIiZNUKfyQ24MumjmUxDUIY4zZL4v3HtkuRMsQVuHZAYvVH5EdSZ9BGwYNzSWK5GFnEOVpHBlIEj9OanvsW5JkwUBa46wk+5QZIMG5Xgx1V7lRJGfeTlvhL5NXQVOd+0+bmj66KQmj9lbH7EC98goLh4J4nGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YONBDtCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FB6C32786;
	Thu, 16 May 2024 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715853746;
	bh=SAQDCGmxGUd6R/tVX/KPXbEtFjW4QRzWBC9l7pf3zJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YONBDtCIDrFMBs7TU7YVDTQDt25T1s5Hk/gtEaJaBk3I9AWXu99eP6HbNIlVDV63h
	 hP+VLI8g9t+EPLCabQGRg4JfBNA7/99+nw8Gr2vVbSiCBiefm8jT7K23Xxh16ItQ0N
	 o7bLMuSQ1A/GI5kCk1gPgSg1cddPTkMeAfSNAEq0TjNOEKZ3F+X4MznAs4VXfXWr4g
	 SavWht2Xc98qVYDAVD0BpCVQO3ele0WzcLeynyMC1zwSlPuvNc01lswffXozzfFWif
	 3kUcxte4mdhTLHlrHKoDREtMduEyX1aLava67IuKmQxQqdj3Prk08RSmnATdhxohDO
	 W7LUZ1MheuOow==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9b5776fbfso3853b6e.1;
        Thu, 16 May 2024 03:02:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXlR9I90kn+UlYL1Eq4e86pRGSgmE3VyZybpNTBaYKsVWS/bjbV1ZOOzht9+wbeMeUsuwtS0gY2Wie+21REBcNNZpKQttscZxpmITbWWRroL2M+fAve8QHEwwTkix7Ufp0h6vUWj4=
X-Gm-Message-State: AOJu0Yz65pm21tCRmR/QNkGppG1jpnITek6Ux3/FZCS/1xB4XrcFneoR
	9GBtQuYm5/q7RMiN4JzmvtE4slaewgD7GFhTgPGqNMae6nwY1Ee/KNnDmYpnGrj7V4bT57MNLem
	EVb41Yru6Q47VGL5JM75Hsx5BekM=
X-Google-Smtp-Source: AGHT+IESsEyInNJM6CnLZU5mDlBku3kQcG9Y0T4JzHPE8oxDGIYjz7SF3N4ca0RBkVPIBVaD38gMu0Wdk07+ROXUTb4=
X-Received: by 2002:a05:6870:ac23:b0:239:d0ff:f428 with SMTP id
 586e51a60fabf-241723001cemr21290071fac.0.1715853746092; Thu, 16 May 2024
 03:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13518388.uLZWGnKmhe@kreacher> <3304112.44csPzL39Z@kreacher>
 <39e15eef-f7fd-4e16-bc74-7f1c6820fe6a@arm.com> <CAJZ5v0gZJE6jfa8_9LgDdjYotY+crLH1JJXHdAWREPz4SJ305A@mail.gmail.com>
 <65a94273-7fa5-4352-a24b-a08a1f244f99@linaro.org>
In-Reply-To: <65a94273-7fa5-4352-a24b-a08a1f244f99@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 12:02:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5ejtjYQ9t1O3tW+akmu_pWav9L=-Th5f6LYac7EG3Lw@mail.gmail.com>
Message-ID: <CAJZ5v0g5ejtjYQ9t1O3tW+akmu_pWav9L=-Th5f6LYac7EG3Lw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] thermal: sysfs: Trigger zone temperature updates
 on sysfs reads
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, May 16, 2024 at 11:46=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 16/05/2024 11:04, Rafael J. Wysocki wrote:
> > Hi Lukasz,
> >
> > On Mon, May 13, 2024 at 9:11=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 5/10/24 15:13, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Reading the zone temperature via sysfs causes the driver callback to
> >>> be invoked, but it does not cause the thermal zone object to be updat=
ed.
> >>>
> >>> This is problematic if the zone temperature read via sysfs differs fr=
om
> >>> the temperature value stored in the thermal zone object as it may cau=
se
> >>> the kernel and user space to act against each other in some cases.
> >>>
> >>> For this reason, make temp_show() trigger a zone temperature update i=
f
> >>> the temperature returned by thermal_zone_get_temp() is different from
> >>> the temperature value stored in the thermal zone object.
>
>
> The hwmon system is doing something similar and I'm not sure we want to
> mimic the same behavior.
>
> Just to summarize:
>
> 1. There is a polling delay set
>
> This polling delay gives the sampling rate the thermal zone is
> monitored. The temperature is updated at each 'delay' tick
>
> 2. There is no polling delay set
>
> The system relies on the interrupts to tell when a temperature reaches a
> threshold.

So this is a bit of a problem if the interrupts are not coming.

At least from the debugfs perspective, there are "mitigation episodes"
that last forever if the zone temperature happens to be above a trip
at the system resume time, say, and is never updated afterward.

> On the other side, if the governor is in-kernel, then we should not read
> the temperature of the thermal zones because it is the job of the kernel
> to do that.
>
> Actually we can assume the temperature information exported to the
> userspace is a courtesy of the kernel when this one is managing the
> thermal zone.

It is not the case right now, though, as sysfs temperature reads
effectively bypass the whole in-kernel thermal management.

> If there is no governor associated to the thermal zone because there is
> no cooling device associated to the defined trip points, then we can
> assume it is up to the userspace to monitor the thermal zone.

Well, in that case trips should not be taken into account, but they are now=
.

> Furthermore, the hwmon gives the temperature information with the
> caching and because of that it is not possible for a thermal daemon to
> correctly handle a thermal zone.
>
> That said, I would say we don't want the userspace to influence the
> thermal zone monitoring in any manner.
>
>  From my POV, we should keep the code as it is.

Well, it is problematic as is.

> The description of the change says "it may cause the kernel and user
> space to act against each other in some cases". Is it possible to give
> the cases when that can happen ?

This is mostly theoretical, but if user space knows that the
temperature has fallen below a trip, but the kernel doesn't know that,
they may decide to put a cooling device into different states.

In any case, the issue at hand is that thermal_zone_device_update()
processes passive and active trip points without attached cooling
devices which doesn't make much sense, so this needs to be addressed
in the first place and the $subject patch may not make any difference
if that happens, so regard it as withdrawn.

Thanks!

