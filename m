Return-Path: <linux-pm+bounces-7894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66C8C7371
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C32D1C2168F
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A9142E91;
	Thu, 16 May 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beLa1hUk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8A142E75;
	Thu, 16 May 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850278; cv=none; b=ixnuLNljvQtIeab/0OhPIPxEvfHc2dycs3pBKxTDrHeYCe5t1uYMvb8LNl/JVLOwa/Ei9oVMzej+JmVWVgCImcki44vBCO7ENCCktCJx0icBDyKGyP0HkSnivdhTVkfcOH8pyJTW/0HKhTl2R/tfgUKq3G1CW64h2MAI6sNxH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850278; c=relaxed/simple;
	bh=/7ZU5SWPryG28/JDJjQorPZqPib2O3IGB90+Qe8THyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Derdwr49QIyWwQwep+lmvS3CsE0oRyFH/1kwBidaHnRDDwzvCPgMoyxWO2rTMsZxqKcxIR4rrGnspniO/4KEIeSx7gFQ2WnYqNv5fZcLGlGi8Tt/8nuyNoUE36b+teRDRDtSfzstjNFOr4OHysHmKfCPd9UOVufl899DML3gv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beLa1hUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ABFC32789;
	Thu, 16 May 2024 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715850277;
	bh=/7ZU5SWPryG28/JDJjQorPZqPib2O3IGB90+Qe8THyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=beLa1hUkjo5E+6DNPm+9Cokg2HWoOeKFDfBE7O2zfs3H6V7HHghFIuQB5A7KR95z+
	 plHUe0bD8pUe7dR0WlMrIrrO/VM+WjRL/UbMWGcztFIbeVAQBc0E7PFnz/mKZMf+rs
	 Fe0K+WskqeAun5qWlTbe3yHN+cIeeUwwT3Bg7M4geuJVvkjH0P80LUNdtacG8D8epD
	 fczn5ZhQ8hr7e/LcUhyY4JZ5o6RDqLXODpcu+3HJ3LAbJ84cO8fwC+kukzeh929vyq
	 YrPhSGfkInHWeLlktaZ0Jia/UIXMLz/2cV+pWZ9ez/gf8aaH/F4TEdgq/yWAhzsAoe
	 iOTFsAdtC837g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b2e8d73bfcso382650eaf.1;
        Thu, 16 May 2024 02:04:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkCf77TNFTkdDNNr46FImmSQ9xWyYcSaj6YBA24aeT5N/kw4Qm5LZL0RR+bH/Dd9iAbS5JCSrEVq1mIiLMvzEyMNBVotpEUdVBBCPBrUVdfG0w0F05cqpNfr4GXJP0sIELiEAXs/4=
X-Gm-Message-State: AOJu0YyyQZPuhPyjaK0EPgA8Znza5wK7CIRKaMD7cQNU/ZwZLl+mM8FV
	aX2a6pVe+ZoXo9RgMS83bBRWBCZhbmnX6BZoBSC1ZD8ts6zaYMGIMXm6FQVEK1i2E/wYJGjInYy
	jXbErdB8xO6q8vgz5W22thQ8yATw=
X-Google-Smtp-Source: AGHT+IGVktTlkAlAt579AU1bpoblCiDv4Jhmu5uultBm9470EEpde8igEf9/i0o7iFtco8K170hIzVgrgMzS35qXRzg=
X-Received: by 2002:a05:6870:ff83:b0:241:9bee:b6fe with SMTP id
 586e51a60fabf-2419beec7d0mr17786411fac.2.1715850277022; Thu, 16 May 2024
 02:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13518388.uLZWGnKmhe@kreacher> <3304112.44csPzL39Z@kreacher> <39e15eef-f7fd-4e16-bc74-7f1c6820fe6a@arm.com>
In-Reply-To: <39e15eef-f7fd-4e16-bc74-7f1c6820fe6a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 11:04:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZJE6jfa8_9LgDdjYotY+crLH1JJXHdAWREPz4SJ305A@mail.gmail.com>
Message-ID: <CAJZ5v0gZJE6jfa8_9LgDdjYotY+crLH1JJXHdAWREPz4SJ305A@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] thermal: sysfs: Trigger zone temperature updates
 on sysfs reads
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, May 13, 2024 at 9:11=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 5/10/24 15:13, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Reading the zone temperature via sysfs causes the driver callback to
> > be invoked, but it does not cause the thermal zone object to be updated=
.
> >
> > This is problematic if the zone temperature read via sysfs differs from
> > the temperature value stored in the thermal zone object as it may cause
> > the kernel and user space to act against each other in some cases.
> >
> > For this reason, make temp_show() trigger a zone temperature update if
> > the temperature returned by thermal_zone_get_temp() is different from
> > the temperature value stored in the thermal zone object.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c  |    2 +-
> >   drivers/thermal/thermal_sysfs.c |    3 +++
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -42,6 +42,9 @@ temp_show(struct device *dev, struct dev
> >       if (ret)
> >               return ret;
> >
> > +     if (temperature !=3D READ_ONCE(tz->temperature))
> > +             thermal_zone_device_update(tz, THERMAL_EVENT_TEMP_SAMPLE)=
;
>
> That's a bit problematic because it will trigger
> governor->manage()
>
> In case of IPA governor we relay on constant polling
> period. We estimate the past power usage and current
> thermal budget, to derive the next period power budget
> for devices. I don't know if the internal PID algorithm
> will be resilient enough to compensate this asynchronous
> trigger caused from user-space.
>
> We choose the period to be at least 1 frame (e.g. ~16ms)
> to have good avg usage of CPUs and GPU. TBH I don't know
> what would happen if someone reads the temp after e.g. 1ms
> of last IPA trigger, but some devices (e.g. GPU) wasn't
> loaded in that last 1ms delta...
> I'm a bit more relaxed about CPUs because we use utilization
> signal from runqueues (like the TEO util gov). That's a moving
> avg signal which should keep some history, like low-pass
> filter, so information is more resilient in that case.
>
> Could we think about that IPA constant period usage?
> I think I understand the proposal of your patch.
> We might add a filter inside IPA to ignore such async
> triggers in the .manage() callback.
> What do you think?

Thanks for pointing this out.

Actually, the target audience for this change are thermal zones that
are not updated on a regular basis, so what about storing the last
zone temperature update time in the zone object and only running an
update from temp_show() if sufficient time has elapsed since the last
update (say 1 sec)?

