Return-Path: <linux-pm+bounces-19050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B129ED42C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07081610F8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DBB202F95;
	Wed, 11 Dec 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOMh91Nt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59024202F8B;
	Wed, 11 Dec 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939722; cv=none; b=p0Zwaxg10C+LmjzwhJE4Y5m7CxaqZ+YNH9iX6LpMg9Xwqb2r3xECQSrMoE6F3aUIzQRCStrCwUiU09cUeScIcqe3Aq+JtG7pG90Eyp0wO4zUX6+6XZMy4/U716FB22lgNvxjN7mf42BZvuXRZ+xDw6rGMe43ssALygEsAslEz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939722; c=relaxed/simple;
	bh=YXnChH557clDWDb3jcusaiok67MTcpiBTGjKwVBCGpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB1Zo5cLmH65VgF9W8/939V/5kGCULTZZN50dZBbDMMtEYnpZLgMa0ab9m3TxH3c2nXs7xpmr/+Stgc9lxoKrrNjlZjHtZFutN941HizGxGKANtlA6iqAsE0mdY7ZCm2aM8KE74tnodblzItmE0Hfb/33csPfsdJZ29thMNlkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOMh91Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA43EC4CED2;
	Wed, 11 Dec 2024 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733939721;
	bh=YXnChH557clDWDb3jcusaiok67MTcpiBTGjKwVBCGpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qOMh91NtnRCy/vn0Ez/Z9asD6xQ2FEYCi2+xvqN5mxtH5E8bY0gqcZMRsldfvx9o4
	 ZIZHOZAacDUhIMqOFByKZBDeX8yJVc/Gpvg4LN0CiB2gZXWWFTnXRWy4smOJ7iegs5
	 Tvt9fA6JvtIfDsjIMqJVaSpDcKyTpYwe6/pq1sHRsRN3gVG7KVNZJG/RBTriuFpdlt
	 hzFModzbStO+X6K5L/+NceQpoFWtkKYBy0WnQbwBwTVf/fzBcpYA+jAQYMuqkJyxgL
	 6SDnfn8t4dYMZERZrBOCjLdshK9lqtpmKJDmQNywhg2Uj2t7uRw3bvkO3i6fVHQX04
	 CtPCBTS9xnMhQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e10e6a1ceso461024a34.0;
        Wed, 11 Dec 2024 09:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/TX/A/VZTX2To6Sa6wbiOONjnjOEhgjzeGPQhS706bww+zFix0NSLQRtBPquyNZxVlT5cxUN3Elys05c=@vger.kernel.org, AJvYcCUi5HE97KH2OV/sRHD1B5d3zhRHlxofBY7+WeBqthw24/3AqRJEOQEGCQAkKH8xJtX2eGe34K21UA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EfRvBs7uJMt3POksI8CzUE2ZuOxHTYmsy1qCJxC3TwPvrk4H
	q6EZoFrhU/KKNqH+0mt38nV8g7lBw4UNFvoKfsrPEBudDqK8tmJWBiF1dZgBXcGsD1us1NawDYu
	EM5mFdl2mpkNyERSwAtof9LsHwk4=
X-Google-Smtp-Source: AGHT+IHgFpDok5Z9icu9THpfdFq4QAxY1inlJflsNV45n6IxLUiWiXPSHPcFm614cyU/XCwJazCjGTnHKOkSk8CvHMk=
X-Received: by 2002:a05:6830:903:b0:718:123e:922d with SMTP id
 46e09a7af769-71e29bf2cbbmr263539a34.18.1733939721083; Wed, 11 Dec 2024
 09:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com> <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
 <CAKfTPtAdo7OADEFuMeg1PpO=rk=bXmiw1Avj7frsoNWZuceewA@mail.gmail.com>
 <CAJZ5v0h5yt5z=dHLJjQhQQChsnr+krcxzBdb6VXj9W4gMY_PSA@mail.gmail.com> <CAKfTPtBJsDPGeRdqk0Ag8dPFxYn0r0ow_xb4s+=Y=QzLWiX9uQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBJsDPGeRdqk0Ag8dPFxYn0r0ow_xb4s+=Y=QzLWiX9uQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Dec 2024 18:55:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-o=03hWrSkk2nx9uWctKaRSJmRNXY6d=e0b46_+fNzA@mail.gmail.com>
Message-ID: <CAJZ5v0j-o=03hWrSkk2nx9uWctKaRSJmRNXY6d=e0b46_+fNzA@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 6:08=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 17:38, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Dec 11, 2024 at 2:25=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 11 Dec 2024 at 12:29, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
> > > > <christian.loehle@arm.com> wrote:
> > > > >
> > > > > On 11/29/24 16:00, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Make it possible to use EAS with cpufreq drivers that implement=
 the
> > > > > > :setpolicy() callback instead of using generic cpufreq governor=
s.
> > > > > >
> > > > > > This is going to be necessary for using EAS with intel_pstate i=
n its
> > > > > > default configuration.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > ---
> > > > > >
> > > > > > This is the minimum of what's needed, but I'd really prefer to =
move
> > > > > > the cpufreq vs EAS checks into cpufreq because messing around c=
pufreq
> > > > > > internals in topology.c feels like a butcher shop kind of exerc=
ise.
> > > > >
> > > > > Makes sense, something like cpufreq_eas_capable().
> > > > >
> > > > > >
> > > > > > Besides, as I said before, I remain unconvinced about the usefu=
lness
> > > > > > of these checks at all.  Yes, one is supposed to get the best r=
esults
> > > > > > from EAS when running schedutil, but what if they just want to =
try
> > > > > > something else with EAS?  What if they can get better results w=
ith
> > > > > > that other thing, surprisingly enough?
> > > > >
> > > > > How do you imagine this to work then?
> > > > > I assume we don't make any 'resulting-OPP-guesses' like
> > > > > sugov_effective_cpu_perf() for any of the setpolicy governors.
> > > > > Neither for dbs and I guess userspace.
> > > > > What about standard powersave and performance?
> > > > > Do we just have a cpufreq callback to ask which OPP to use for
> > > > > the energy calculation? Assume lowest/highest?
> > > > > (I don't think there is hardware where lowest/highest makes a
> > > > > difference, so maybe not bothering with the complexity could
> > > > > be an option, too.)
> > > >
> > > > In the "setpolicy" case there is no way to reliably predict the OPP
> > > > that is going to be used, so why bother?
> > > >
> > > > In the other cases, and if the OPPs are actually known, EAS may sti=
ll
> > > > make assumptions regarding which of them will be used that will mat=
ch
> > > > the schedutil selection rules, but if the cpufreq governor happens =
to
> > > > choose a different OPP, this is not the end of the world.
> > >
> > > Should we add a new cpufreq governor fops to return the guest estimat=
e
> > > of the compute capacity selection ? something like
> > > cpufreq_effective_cpu_perf(cpu, actual, min, max)
> > > EAS needs to estimate what would be the next OPP; schedutil uses
> > > sugov_effective_cpu_perf() and other governor could provide their own
> >
> > Generally, yes.  And documented for that matter.
> >
> > But it doesn't really tell you the OPP, but the performance level that
> > is going to be set for the given list of arguments IIUC.  An energy
>
> Yes, the governor return what performance level it will select and asl
> to the cpufreq driver so EAS can directly map it to an OPP and a cost
>
> > model is needed to find an OPP for the given perf level.  Or generally
> > the cost of it for that matter.
> >
> > > > Yes, you could have been more energy-efficient had you chosen to us=
e
> > > > schedutil, but you chose otherwise and that's what you get.
> > >
> > > Calling sugov_effective_cpu_perf() for another governor than scheduti=
l
> > > doesn't make sense.
> >
> > It will work for intel_pstate in the "setpolicy" mode to a reasonable
> > approximation AFAICS.
> >
> > > and do we handle the case when
> > > CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not selected
> >
> > I don't think it's necessary to handle it.
>
> I don't think that CI and others will be happy to possibly get an
> undeclared function. Or you put a dependency of other governors with
> CPU_FREQ_DEFAULT_GOV_SCHEDUTIL

Do you mean CONFIG_CPU_FREQ_GOV_SCHEDUTIL?  Because
CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is only about whether or not schedutil
is the default governor.

I think that it is fine to require CONFIG_CPU_FREQ_GOV_SCHEDUTIL for EAS.

