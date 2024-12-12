Return-Path: <linux-pm+bounces-19109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF39EE15E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 09:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C8F164A68
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8B20C012;
	Thu, 12 Dec 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmFykiwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941F20E02C
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992509; cv=none; b=hHhVUO4ugqxIpn6IZsRPopCnxNhF9QcfG0SyJxdEDEg2QiMS1ath+BoENpKZVAub7sN3pzC+1iHrvhw+IJbk3wRil4ISE+MwurI+GD4tF8c3hI7CgW3EvMvCfnTcKd2v7IaEQyX+EISueatcP879B5Zm78whl9VqAK+ZqsbQ/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992509; c=relaxed/simple;
	bh=+QYQvIoAwA/03emDflI9RZkFrv6j8VhTC0DAInPMlgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbEloij6BrC/85si+0JnasYsdps7XsCoOe2VHyQ3oQ3Bx2x/T1GVf/43Rn5SFTtJ7hHG3Z0RSdIGLFhJX+fIIVvAzbaWezcJBM/tjclk+l+vifV3fiRyB6f1ZARSx8cNuUEq1M5IIHCzwiPs2YUGuBba0nqUz81KC1oaCizQfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmFykiwE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728eccf836bso309032b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733992507; x=1734597307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6/vSaKZY5pwG8kUY2GoEQ9MVjh6P3T7KUtdgv4p5mc=;
        b=OmFykiwEu+rZDg6eXHPS97yzu5DqxPOqKybRz9sDY1L15oxACbehoyGuZBEwpBpzHa
         Xsc+SwXK5YISXpaOuOwOE7YOCVd/sNVC3FbK2/y/EUGpH+dmYbsFThVT1KZm4vM0y3HU
         +QY/FtPqfujUWNdP2OjV3u0yMUybMhUEXNKvq/sPo65YIMo6sZs59LHAuh7Yu71u2jQV
         UqyeXQ57o/gTUyCYIRHo1X/4QRivgUc82j7L5vDmRvWQMSvlF9ZBgvCK0XrEXD2ZGsvC
         t2nvUHwOoyQZOE7iQ2KxNQSo/YXRJkMv92FY9GKzwwCigA80B33lAwSf65FRlbR0qwPf
         88kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992507; x=1734597307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6/vSaKZY5pwG8kUY2GoEQ9MVjh6P3T7KUtdgv4p5mc=;
        b=szMt6/QyZtl7NKj8DS0i/fgL1paUgFs0s1KcaWjSWpqxQONdpnrRTA67W348Wfdc8q
         ysSkKzvwyCCbZQeFIDO9VRb75YL1vVlfuhefpfBCeQiT84vPdsycxWpwMgIJuwe6OSfV
         yk1Ilc8dzXH1ug83kL8K6cmBVgEzs66OLp2VBj9OOFqlWqn00QXW9gD8jUo1OQiEHdQx
         LP6YD4SYmXmwf/rajIzei8DBIqtlW6rKL8npzQDa2Q1riSNgnx9VmSlQVa1FtZz2iJld
         VJ6LQroQ/knMnNKrKu1N0jcnsYGQggxarkGERFMZ6QYoXcRrB8OKJ2XD7SHuXXbCHbdS
         gnvg==
X-Forwarded-Encrypted: i=1; AJvYcCXdsaIt8gPa3sf+2Fz9hgVe7KQuTOhhqxnh6kbHziWGdWS1Ep7l8HifnPLDsC10eZQjGEy2GzFqsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEn6QkW0O+PrnZSMv4gO3PeUyRw+p1kVP9lrfvmDXkXgsGCy6
	3jJIdpF6AVI15t6pJdQG1VndL7ZNuS+jMmwHHMdFI+9sQPnpyDxmvFMvwleJKnTP2gnaVoVd/DS
	HR+udnORCIsIA4O9EnsKTPVUeNvhZzFAGajOlNA==
X-Gm-Gg: ASbGnctDmMduIJd43q5K1sUi9fTVCzndMQ5/V1X+8xr0OsIWMHWafZ3NhbKm7FbqzmS
	jDHqrVhcoomu015OMHQs2/bGYzKxsoX0j0KF35heIo+7tg95skVKo0NhnLuS3JminWQo=
X-Google-Smtp-Source: AGHT+IGIP1QyEXC52z6coVr8oeuwx35jICI5SfYsscchRGRr2f8qVzHqI5hZN/zB3bkzJpDD0e8BRBfaFPrva3fh7xo=
X-Received: by 2002:a05:6a00:10c7:b0:725:e957:1dd1 with SMTP id
 d2e1a72fcca58-728faaac98amr3279648b3a.17.1733992507041; Thu, 12 Dec 2024
 00:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com> <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
 <CAKfTPtAdo7OADEFuMeg1PpO=rk=bXmiw1Avj7frsoNWZuceewA@mail.gmail.com>
 <CAJZ5v0h5yt5z=dHLJjQhQQChsnr+krcxzBdb6VXj9W4gMY_PSA@mail.gmail.com>
 <CAKfTPtBJsDPGeRdqk0Ag8dPFxYn0r0ow_xb4s+=Y=QzLWiX9uQ@mail.gmail.com> <CAJZ5v0j-o=03hWrSkk2nx9uWctKaRSJmRNXY6d=e0b46_+fNzA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-o=03hWrSkk2nx9uWctKaRSJmRNXY6d=e0b46_+fNzA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Dec 2024 09:34:55 +0100
Message-ID: <CAKfTPtDXCxOovMNeJ5UuCqMa42PRtFPgTahxy+F--Qojkh7OXg@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Dec 2024 at 18:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 6:08=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 11 Dec 2024 at 17:38, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Dec 11, 2024 at 2:25=E2=80=AFPM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Dec 2024 at 12:29, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
> > > > > <christian.loehle@arm.com> wrote:
> > > > > >
> > > > > > On 11/29/24 16:00, Rafael J. Wysocki wrote:
> > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > >
> > > > > > > Make it possible to use EAS with cpufreq drivers that impleme=
nt the
> > > > > > > :setpolicy() callback instead of using generic cpufreq govern=
ors.
> > > > > > >
> > > > > > > This is going to be necessary for using EAS with intel_pstate=
 in its
> > > > > > > default configuration.
> > > > > > >
> > > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > ---
> > > > > > >
> > > > > > > This is the minimum of what's needed, but I'd really prefer t=
o move
> > > > > > > the cpufreq vs EAS checks into cpufreq because messing around=
 cpufreq
> > > > > > > internals in topology.c feels like a butcher shop kind of exe=
rcise.
> > > > > >
> > > > > > Makes sense, something like cpufreq_eas_capable().
> > > > > >
> > > > > > >
> > > > > > > Besides, as I said before, I remain unconvinced about the use=
fulness
> > > > > > > of these checks at all.  Yes, one is supposed to get the best=
 results
> > > > > > > from EAS when running schedutil, but what if they just want t=
o try
> > > > > > > something else with EAS?  What if they can get better results=
 with
> > > > > > > that other thing, surprisingly enough?
> > > > > >
> > > > > > How do you imagine this to work then?
> > > > > > I assume we don't make any 'resulting-OPP-guesses' like
> > > > > > sugov_effective_cpu_perf() for any of the setpolicy governors.
> > > > > > Neither for dbs and I guess userspace.
> > > > > > What about standard powersave and performance?
> > > > > > Do we just have a cpufreq callback to ask which OPP to use for
> > > > > > the energy calculation? Assume lowest/highest?
> > > > > > (I don't think there is hardware where lowest/highest makes a
> > > > > > difference, so maybe not bothering with the complexity could
> > > > > > be an option, too.)
> > > > >
> > > > > In the "setpolicy" case there is no way to reliably predict the O=
PP
> > > > > that is going to be used, so why bother?
> > > > >
> > > > > In the other cases, and if the OPPs are actually known, EAS may s=
till
> > > > > make assumptions regarding which of them will be used that will m=
atch
> > > > > the schedutil selection rules, but if the cpufreq governor happen=
s to
> > > > > choose a different OPP, this is not the end of the world.
> > > >
> > > > Should we add a new cpufreq governor fops to return the guest estim=
ate
> > > > of the compute capacity selection ? something like
> > > > cpufreq_effective_cpu_perf(cpu, actual, min, max)
> > > > EAS needs to estimate what would be the next OPP; schedutil uses
> > > > sugov_effective_cpu_perf() and other governor could provide their o=
wn
> > >
> > > Generally, yes.  And documented for that matter.
> > >
> > > But it doesn't really tell you the OPP, but the performance level tha=
t
> > > is going to be set for the given list of arguments IIUC.  An energy
> >
> > Yes, the governor return what performance level it will select and asl
> > to the cpufreq driver so EAS can directly map it to an OPP and a cost
> >
> > > model is needed to find an OPP for the given perf level.  Or generall=
y
> > > the cost of it for that matter.
> > >
> > > > > Yes, you could have been more energy-efficient had you chosen to =
use
> > > > > schedutil, but you chose otherwise and that's what you get.
> > > >
> > > > Calling sugov_effective_cpu_perf() for another governor than schedu=
til
> > > > doesn't make sense.
> > >
> > > It will work for intel_pstate in the "setpolicy" mode to a reasonable
> > > approximation AFAICS.
> > >
> > > > and do we handle the case when
> > > > CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not selected
> > >
> > > I don't think it's necessary to handle it.
> >
> > I don't think that CI and others will be happy to possibly get an
> > undeclared function. Or you put a dependency of other governors with
> > CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
>
> Do you mean CONFIG_CPU_FREQ_GOV_SCHEDUTIL?  Because
> CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is only about whether or not schedutil
> is the default governor.

Yes, I mean CONFIG_CPU_FREQ_GOV_SCHEDUTIL

>
> I think that it is fine to require CONFIG_CPU_FREQ_GOV_SCHEDUTIL for EAS.

