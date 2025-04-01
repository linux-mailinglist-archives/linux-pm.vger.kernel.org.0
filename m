Return-Path: <linux-pm+bounces-24709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C990A780B2
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927397A2524
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905020DD47;
	Tue,  1 Apr 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrhKYfji"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6F20D516;
	Tue,  1 Apr 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525675; cv=none; b=DW80NS65wsRy9SsFaKiznix2SH0ckhedX+QFilXqpPp4Do6TvpZPyr6KzwhvSGPjsZ7j6NtootLctgJdo4xidYW2zz/Zi0qggXpCLUksD/n4jlDDexq05Shrzt9pYVBRjqHb2d+dTWjoUmTy2PYio9dWAdLwInh30wxJTGn3Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525675; c=relaxed/simple;
	bh=1gLhTGr9l4B6cXOGLPFVG5q64lvtMbM6/m8pzagYpbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3WtJyWFicGOGbD+JtPcQKtoC6SSKU0QwUgHUcet1VZRr+cetUvfK6Z8KWHii4ieQ/cCBLgfZ18xsuM/wzj7IgCbyPNJRRxqCMzH2iy6kIyHAzEY0s27BP++5SPZEdDWHlXkrZmckwzFOUY+1XyzAnyHX5MtPRFIyrt9rhAvdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrhKYfji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E6BC4CEED;
	Tue,  1 Apr 2025 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743525675;
	bh=1gLhTGr9l4B6cXOGLPFVG5q64lvtMbM6/m8pzagYpbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XrhKYfji1O5VVc0m3pVmiek3wlBysahevwvD4uF0BAO1Pv80bs4rTS+CWURqeqpdu
	 aR1VnApBwaumrUWEEZjkl1xHck26LPPAjvtIhhOUL7EodlWBhhrDp1YnXaBpVUKoxy
	 vu66bfEZAkuMb5vMnb8EjZIbLqlQlouXEwlVl691oHdtDQL3NOauFY8b///y+isCqI
	 JlSZM/VgCrZiUWo8WUmVjVwAUkrWjgsl25sZDif/6ZGW4UnogWsN3FidYdczTdtKCr
	 vinfcwBuwjN/Y+aFPkKooassEGIngPDBkPSfq97DR5wxa2LJ2Of3C8jnyvh7iDnLdM
	 KeilThHGeg8eQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2504fa876so1490024fac.0;
        Tue, 01 Apr 2025 09:41:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU59z/o59f1NZS5OC07Ep7S0eIDYDMDkUcHmBw8Lgy+9KfjiNf/dYc+CO2CtcyYQaLk8pSmdhtQWzJfJw==@vger.kernel.org, AJvYcCVIlhZYN5yY64DjEipFdoWVaRgFKBKlHnWTwKoprPFimkSTlxN1oeNhnOcoD75i9uGzZqlG2hUWmZo=@vger.kernel.org, AJvYcCXQPoRB5jOtpyHAddWaO+rklUIqPEvhaTVKlGrc9aYSf3hYGDsJtMVeCM617qQCwFJQl3n25z4kp0CciuS+@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxt+LFVNWlh9jmsqi++x2q+d55oC32hNyX3MFmfv/MHBa7o2M
	XIPaENa+dSHiTQt6a6PuYE3bv3LDr7ahXkqwu5v+Ho6AwITwBzgmOIGZO30u82DA//JSw1tZzTn
	Oz2jX0d7foneXnD+BKdt4+NDSzbc=
X-Google-Smtp-Source: AGHT+IGVXZ+0BVDFKICSSMwrK67DZSsDNux/3FyKeJP2ZsYnODa6XRbFXoGvWozBU8NYZA0rltVFvYQzLnASEJnV66k=
X-Received: by 2002:a05:6808:6f88:b0:3fa:8bfd:7721 with SMTP id
 5614622812f47-3ff0f59b9efmr8000188b6e.27.1743525674482; Tue, 01 Apr 2025
 09:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com> <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org> <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com> <SJ2PR11MB7670E05E066CCC16AFEA16A18DAC2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <743b3472-e1a4-4fdc-ac2d-6e74c51022c4@arm.com>
In-Reply-To: <743b3472-e1a4-4fdc-ac2d-6e74c51022c4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Apr 2025 18:41:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gryQv8hQO0yp5Ssh2v6jvCtrF-g0xJhOrrxfrDeDeq=Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqFA7IwPhhQcfGCN8j-8gC1KfAULXjhN1fIy5y9GFpwTc_hCUHt5sJFE3U
Message-ID: <CAJZ5v0gryQv8hQO0yp5Ssh2v6jvCtrF-g0xJhOrrxfrDeDeq=Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: Christian Loehle <christian.loehle@arm.com>, "King, Colin" <colin.king@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 5:15=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/1/25 16:03, King, Colin wrote:
> > Hi,
> >
> > Reply at end..
> >
> >> -----Original Message-----
> >> From: Christian Loehle <christian.loehle@arm.com>
> >> Sent: 26 March 2025 16:27
> >> To: King, Colin <colin.king@intel.com>; Bart Van Assche
> >> <bvanassche@acm.org>; Jens Axboe <axboe@kernel.dk>; Rafael J. Wysocki
> >> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; linux=
-
> >> block@vger.kernel.org; linux-pm@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention=
 for
> >> fast I/O devices
> >>
> >> On 3/26/25 15:04, King, Colin wrote:
> >>> Hi,
> >>>
> >>>> -----Original Message-----
> >>>> From: Bart Van Assche <bvanassche@acm.org>
> >>>> Sent: 23 March 2025 12:36
> >>>> To: King, Colin <colin.king@intel.com>; Christian Loehle
> >>>> <christian.loehle@arm.com>; Jens Axboe <axboe@kernel.dk>; Rafael J.
> >>>> Wysocki <rafael@kernel.org>; Daniel Lezcano
> >>>> <daniel.lezcano@linaro.org>; linux-block@vger.kernel.org;
> >>>> linux-pm@vger.kernel.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion
> >>>> prevention for fast I/O devices
> >>>>
> >>>> On 3/17/25 3:03 AM, King, Colin wrote:
> >>>>> This code is optional, one can enable it or disable it via the
> >>>>> config option. Also, even when it is built-in one can disable it by
> >>>>> writing 0 to the
> >>>> sysfs file
> >>>>>    /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms
> >>>>
> >>>> I'm not sure we need even more configuration knobs in sysfs.
> >>>
> >>> It's useful for enabling / disabling the functionality, as well as so=
me form of
> >> tuning for slower I/O devices, so I think it is justifiable.
> >>>
> >>>> How are users
> >>>> expected to find this configuration option? How should they decide
> >>>> whether to enable or to disable it?
> >>>
> >>> I can send a V2 with some documentation if that's required.
> >>>
> >>>>
> >>>> Please take a look at this proposal and let me know whether this
> >>>> would solve the issue that you are looking into: "[LSF/MM/BPF Topic]
> >> Energy- Efficient I/O"
> >>>> (https://lore.kernel.org/linux-block/ad1018b6-7c0b-4d70-
> >>>> b845-c869287d3cf3@acm.org/). The only disadvantage of this approach
> >>>> compared to the cpuidle patch is that it requires RPM (runtime power
> >>>> management) to be enabled. Maybe I should look into modifying the
> >>>> approach such that it does not rely on RPM.
> >>>
> >>> I've had a look, the scope of my patch is a bit wider.  If my patch
> >>> gets accepted I'm going to also look at putting the psd call into
> >>> other devices (such as network devices) to also stop deep states whil=
e
> >>> these devices are busy.  Since the code is very lightweight I was hop=
ing this
> >> was going to be relatively easy and simple to use in various devices i=
n the
> >> future.
> >>
> >> IMO this needs to be a lot more fine-grained then, both in terms of wh=
ich
> >> devices or even IO is affected (Surely some IO is fine with at least *=
some*
> >> latency) but also how aggressive we are in blocking.
> >> Just looking at some common latency/residency of idle states out there=
 I don't
> >> think it's reasonable to force polling for a 3-10ms (rounding up with =
the jiffie)
> >> period.
> >
> > The current solution by a customer is that they are resorting to disabl=
ing C6/C6P and hence
> > all the CPUs are essentially in a non-low power state all the time.  Th=
e opt-in solution
> > provided in the patch provides nearly the same performance and will re-=
enable deeper
> > C-states once the I/O is completed.
> >
> > As I mentioned earlier, the jiffies are used because it's low-touch and=
 very fast with negligible
> > impact on the I/O paths. Using finer grained timing is far more an expe=
nsive operation and
> > is a huge overhead on very fast I/O devices.
> >
> > Also, this is a user config and tune-able choice. Users can opt-in to u=
sing this if they want
> > to pay for the extra CPU overhead for a bit more I/O performance. If th=
ey don't want it, they
> > don't need to enable it.
> >
> >> Playing devil's advocate if the system is under some thermal/power pre=
ssure
> >> we might actually reduce throughput by burning so much power on this.
> >> This seems like the stuff that is easily convincing because it improve=
s
> >> throughput and then taking care of power afterwards is really hard. :/
> >>
> >
> > The current solution is when the user is trying to get maximum bandwidt=
h and disabling C6/C6P
> > so they are already keeping the system busy. This solution at least wil=
l save power when I/O is idling.
> >
>
> No. They can set the pm qos latency constraint when they care about 'maxi=
mum bandwidth'
> and remove the constraint when they don't.
> If they just disable the idle states at boot and never enable them at lea=
st they have no
> grounds to complain to kernel people about, they should know what they're=
 doing is detrimental
> to power.

I think that they know about it, but they are complaining that there's
no alternative.

Well, this is not entirely true because of the PM QoS latency
constraints that can be used, but this requires admin access which
isn't popular.

Hence (I think) the idea to add an opt-in that will effectively
disable C6/C6P temporarily when I/O is pending (in progress, queued up
or whatever), but this may very well use the existing PM QoS latency
constraints framework under the hood instead of adding something new.

> Furthermore we might be better off disabling C6/C6P than staying in a pol=
ling state (whenever we've
> completed an IO in the last ~5 to 20ms, depending on the HZ setting).
> Again, the wastefulness of a polling state can hardly be overestimated, e=
specially given
> that it doesn't seem to be necessary at all here?

I don't think it is necessary or at least the need for it would need
to be demonstrated.  In fact, on x86, every time the poll state is
selected, it turns out to be overly shallow, at least in the results
I've seen so far.

Most likely, it would be sufficient to have a CPU latency PM QoS
request registered per I/O entity and set the limit for it slightly
above the C1 (or C1E) exit latency when there's I/O to process.  After
completing the I/O, the request can be update to the "don't care"
value.

