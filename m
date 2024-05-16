Return-Path: <linux-pm+bounces-7911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F428C76F1
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4138D1C21B41
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E708146018;
	Thu, 16 May 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T28cPLYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F7145FF9;
	Thu, 16 May 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864214; cv=none; b=Pc+EeNU6FR3HLzCsZcuxD7bdl5l11wSDaQYeJ5WRFzAj0HvuMfkv+kCrzdx4prxDAqD8q8dUPWxOG5FNhFlwdFYdUeEpO9ea3bLQREDMfvin+avKr8iNr3wncvynIagjpv2EzJCizXbbyjn5xnjy5kXtfTKsxrR1DIMKYVtefAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864214; c=relaxed/simple;
	bh=/yLPfI7mbEHwDzLhz+Nf7UUcyTKCIhrbHMaNZgA2hyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmkIyoaXLABhL7Sl/ulIoF70NlsMAviVqV6pt+SkQJEaaBaArBE1/SWQOjfec/YwtF3+OkIaWxUh/c9Y6DG8+dSB4yWwT7JyV7FH9avJ/16YmYQ/YsC5CerC/G5UyhOWqrhPIvw4/P+eVMfD+INeXFT6OlT8AFCdmzvtTQUhpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T28cPLYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0623DC4AF08;
	Thu, 16 May 2024 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715864214;
	bh=/yLPfI7mbEHwDzLhz+Nf7UUcyTKCIhrbHMaNZgA2hyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T28cPLYI1afhksw1uALFMKWyLsVJ7U7GI/1SAXClzgA8+Rna71l/jFkbIQ9CaC+RB
	 hyPcKarpM2SfoQJkpJUu9UF6e7TkpJ4CGqnvrXVxzKsEToDOrSfPLTFA3g/imNzavo
	 VHtBVVJskk8hAIGqilTzeW6oDX8plICo882++2glkeJu78KEJoNKxJ+YIonC6hsB56
	 Dguz/2JikGMjocC/hF8gR08dCfcEZ3HZLRtoJY31ukMoiyVdNkawDwpqyJU1arKsJH
	 28atDNvqX3OnXChcCYS3M7l5JYRv2kjxmtAaiJX1RIrmD2pa+u0UyFX8mF6kDBFLTS
	 +XG18SAM7Mh0g==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9bcd57524so40432b6e.3;
        Thu, 16 May 2024 05:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc76wnPi5vbGVgKAKcc1da4Ri7TL3pTGHVnhzlZdE53m1XM0J9q3bEyAcjX36wV7rYAyrT1CI0BpEv/DaL/Y0dtWcQQyIPFbhI5SWljaPyQYFZbvuSAM5gODFEvUy2cwADJAVSg6M=
X-Gm-Message-State: AOJu0YyeOpJyK//0Rwx95B0faupJFtJDn/sbMSLq9zc/7rhLDWMgdO0o
	t+oT1QPzYWjlEhNL0TQosQELMrRsSVffS7y6EVA2/dLDQAeqUjZFMRe59gibcRLOqDuX38xuM4Z
	qkAP2R6JC0DqX1/DJlb78s4Bq04k=
X-Google-Smtp-Source: AGHT+IFiaoSyd28mKG2dn5+WVYPeWD4D4Jm2o+HpZo1vMtBFQ8BAGcBHHQqm6SlvV5SxjGgnt0I4ZeuhJjzth0Pztpg=
X-Received: by 2002:a05:6870:5246:b0:23c:350c:f157 with SMTP id
 586e51a60fabf-24172fc1a06mr24795650fac.4.1715864213216; Thu, 16 May 2024
 05:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13518388.uLZWGnKmhe@kreacher> <3304112.44csPzL39Z@kreacher>
 <39e15eef-f7fd-4e16-bc74-7f1c6820fe6a@arm.com> <CAJZ5v0gZJE6jfa8_9LgDdjYotY+crLH1JJXHdAWREPz4SJ305A@mail.gmail.com>
 <65a94273-7fa5-4352-a24b-a08a1f244f99@linaro.org> <CAJZ5v0g5ejtjYQ9t1O3tW+akmu_pWav9L=-Th5f6LYac7EG3Lw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g5ejtjYQ9t1O3tW+akmu_pWav9L=-Th5f6LYac7EG3Lw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 14:56:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUW2ToCS7ZGjPFPnvTKHPLEw+4=FURDoBGzw0R51DgNA@mail.gmail.com>
Message-ID: <CAJZ5v0jUW2ToCS7ZGjPFPnvTKHPLEw+4=FURDoBGzw0R51DgNA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] thermal: sysfs: Trigger zone temperature updates
 on sysfs reads
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:02=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> Hi Daniel,
>
> On Thu, May 16, 2024 at 11:46=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > On 16/05/2024 11:04, Rafael J. Wysocki wrote:
> > > Hi Lukasz,
> > >
> > > On Mon, May 13, 2024 at 9:11=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> On 5/10/24 15:13, Rafael J. Wysocki wrote:
> > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>
> > >>> Reading the zone temperature via sysfs causes the driver callback t=
o
> > >>> be invoked, but it does not cause the thermal zone object to be upd=
ated.
> > >>>
> > >>> This is problematic if the zone temperature read via sysfs differs =
from
> > >>> the temperature value stored in the thermal zone object as it may c=
ause
> > >>> the kernel and user space to act against each other in some cases.
> > >>>
> > >>> For this reason, make temp_show() trigger a zone temperature update=
 if
> > >>> the temperature returned by thermal_zone_get_temp() is different fr=
om
> > >>> the temperature value stored in the thermal zone object.
> >
> >
> > The hwmon system is doing something similar and I'm not sure we want to
> > mimic the same behavior.
> >
> > Just to summarize:
> >
> > 1. There is a polling delay set
> >
> > This polling delay gives the sampling rate the thermal zone is
> > monitored. The temperature is updated at each 'delay' tick
> >
> > 2. There is no polling delay set
> >
> > The system relies on the interrupts to tell when a temperature reaches =
a
> > threshold.
>
> So this is a bit of a problem if the interrupts are not coming.
>
> At least from the debugfs perspective, there are "mitigation episodes"
> that last forever if the zone temperature happens to be above a trip
> at the system resume time, say, and is never updated afterward.
>
> > On the other side, if the governor is in-kernel, then we should not rea=
d
> > the temperature of the thermal zones because it is the job of the kerne=
l
> > to do that.
> >
> > Actually we can assume the temperature information exported to the
> > userspace is a courtesy of the kernel when this one is managing the
> > thermal zone.
>
> It is not the case right now, though, as sysfs temperature reads
> effectively bypass the whole in-kernel thermal management.
>
> > If there is no governor associated to the thermal zone because there is
> > no cooling device associated to the defined trip points, then we can
> > assume it is up to the userspace to monitor the thermal zone.
>
> Well, in that case trips should not be taken into account, but they are n=
ow.

Actually, there is always a governor associated with a thermal zone
AFAICS.  It is set before binding any cooling devices to the thermal
zone.

However, there are thermal zones without any cooling devices bound to
them and they have the governor set to user_space, so it appears that
they want to receive trip crossing notifications, but then they don't
have a way to trigger zone temperature updates which is inconsistent.

IMO at least for these thermal zones temp_store() should trigger a
zone temperature update.

