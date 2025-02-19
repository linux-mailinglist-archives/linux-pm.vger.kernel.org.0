Return-Path: <linux-pm+bounces-22419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2329BA3BDBF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DA016D643
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A41DF730;
	Wed, 19 Feb 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyqfM8y7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EF1DE3BC;
	Wed, 19 Feb 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966811; cv=none; b=rJqQcQHs2yKNXJ0aT01sKH5IjP8cd2e+HTn1TZnxj5RxxAYsUUiR+qfueKCp9dFA+iegzjM9M3XjwD8AFDtFAzDpfaEx3VXSxEe5bakOyugann6vB241V8wC0wtptj1OsHyhAQLnkGcVdmoQTxTf630wp2VYdwJG0iGB3sU1rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966811; c=relaxed/simple;
	bh=3leVD2Jra0HEjBLVr5CDODaOvCvlardfx+fWdZ/2/8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho8hgVSLF1Es/34hKuAVXZ3IMOez9y/t6ZOeFHLSOOobkR8mO/5vO89zPsba7cl5bQKhFZqvDqH1L0HxjJMoAgHBfZViRXPyk4296UTWRst77bvV56jsdaW87r8cbKdgBNKJ2wqO/WM4p6kVSnziHfEvjBiJHeJmeRC6qMgbxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyqfM8y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B394AC4CEDD;
	Wed, 19 Feb 2025 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739966809;
	bh=3leVD2Jra0HEjBLVr5CDODaOvCvlardfx+fWdZ/2/8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oyqfM8y7hmD4cl06hs+Pol8cy/RorjWFZvWQWxAZCU1hw5lU37+kft7wmRuuuJjHU
	 XePBusVHf6lMDTZoVsoNkJQPG7VCRMhfEDt7RQZhbyod3XKhmP75bUSr9u0oeV4vvj
	 XfI9h8JLiVcDmj6fsPpD42DHzHI6d/UeHevHYKXtw+D0Jk1qGK98yihY22fh8gSLJ8
	 Ys6FuIBQMZgrlk5eRzDaQiFcHQm+6VS+ECv3l1iS8yCPYimOtx/v67wVZlNAuPB9vA
	 99bZSBGHP6iX4mqZtJ/3/h4GYu++Rnd0hNtBBS+mYSn5LDToRXXFZxK7V7gPZ2FQKw
	 UaaPaHZVH0aOA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fcd7d306f3so2538373eaf.3;
        Wed, 19 Feb 2025 04:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7QEFd3SV5umxa63XFMPuLlsJ/Uqk+gJCVaL3cLT+OISOqHiwCygQimT3CysmlVz9jucZ4A/FGSQU=@vger.kernel.org, AJvYcCUfj9rRpDuDS+HYHaWqHnkDspKe7ee80jfel2LsFUc2NN+yuCFouMSALZG7KnVxt3BVJw7MEAWGsnDLNkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOPpUOYBwCxpF5ojB9VYjEBvvCIfdO68/sujeXXkGP1owtJfY
	Zun9/b1ptVfkAaZmS617XkzZFbWMJfJ68LD4Zj/oe1QFCj/DRgG6vnZWnNINiU/xL/YORB5PH8g
	6IwhEcPGs3gC4EaNvvIBRKV+g3Lk=
X-Google-Smtp-Source: AGHT+IFusff6tAPJPBUpuNz7dqQd7iVOX/oujqEVrMmyNx+Il1q7a5ci2DmYSAwLl+siU8IeDDsHwQkyL/DM3rhUnEA=
X-Received: by 2002:a05:6820:504:b0:5fc:f9b4:7f48 with SMTP id
 006d021491bc7-5fcfe43f209mr1702442eaf.1.1739966808962; Wed, 19 Feb 2025
 04:06:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <bd69d9dc-0494-4975-bebd-881f3560e659@arm.com>
 <1d713fe5-485b-4aeb-a279-13fce93692fc@arm.com>
In-Reply-To: <1d713fe5-485b-4aeb-a279-13fce93692fc@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Feb 2025 13:06:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hob-+gv5UjXCaS1fQ2kn5u_WU_x+kkMiEXiisnt91bZQ@mail.gmail.com>
X-Gm-Features: AWEUYZm0B48DvczHRUSzQ0jpscsXWPCPswzyzV6BiXz_Ormnpgo4VcmOd-p9ttk
Message-ID: <CAJZ5v0hob-+gv5UjXCaS1fQ2kn5u_WU_x+kkMiEXiisnt91bZQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, dsmythies@telus.net, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:17=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/10/25 14:15, Christian Loehle wrote:
> > On 2/6/25 14:21, Rafael J. Wysocki wrote:
> >> Hi Everyone,
> >>
> >> This work had been triggered by a report that commit 0611a640e60a ("ev=
entpoll:
> >> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS met=
ric of
> >> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it ge=
nerally
> >> reduced kernel overhead.  Indeed, it was found during further investig=
ation
> >> that the total interrupt rate while running the SPECjbb workload had f=
allen as
> >> a result of that commit by 55% and the local timer interrupt rate had =
fallen by
> >> almost 80%.
> >>
> >> That turned out to cause the menu cpuidle governor to select the deepe=
st idle
> >> state supplied by the cpuidle driver (intel_idle) much more often whic=
h added
> >> significantly more idle state latency to the workload and that led to =
the
> >> decrease of the critical-jOPS score.
> >>
> >> Interestingly enough, this problem was not visible when the teo cpuidl=
e
> >> governor was used instead of menu, so it appeared to be specific to th=
e
> >> latter.  CPU wakeup event statistics collected while running the workl=
oad
> >> indicated that the menu governor was effectively ignoring non-timer wa=
keup
> >> information and all of its idle state selection decisions appeared to =
be
> >> based on timer wakeups only.  Thus, it appeared that the reduction of =
the
> >> local timer interrupt rate caused the governor to predict a idle durat=
ion
> >> much more often while running the workload and the deepest idle state =
was
> >> selected significantly more often as a result of that.
> >>
> >> A subsequent inspection of the get_typical_interval() function in the =
menu
> >> governor indicated that it might return UINT_MAX too often which then =
caused
> >> the governor's decisions to be based entirely on information related t=
o timers.
> >>
> >> Generally speaking, UINT_MAX is returned by get_typical_interval() if =
it
> >> cannot make a prediction based on the most recent idle intervals data =
with
> >> sufficiently high confidence, but at least in some cases this means th=
at
> >> useful information is not taken into account at all which may lead to
> >> significant idle state selection mistakes.  Moreover, this is not real=
ly
> >> unlikely to happen.
> >>
> >> One issue with get_typical_interval() is that, when it eliminates outl=
iers from
> >> the sample set in an attempt to reduce the standard deviation (and so =
improve
> >> the prediction confidence), it does that by dropping high-end samples =
only,
> >> while samples at the low end of the set are retained.  However, the sa=
mples
> >> at the low end very well may be the outliers and they should be elimin=
ated
> >> from the sample set instead of the high-end samples.  Accordingly, the
> >> likelihood of making a meaningful idle duration prediction can be impr=
oved
> >> by making it also eliminate low-end samples if they are farther from t=
he
> >> average than high-end samples.  This is done in patch [4/5].
> >>
> >> Another issue is that get_typical_interval() gives up after eliminatin=
g 1/4
> >> of the samples if the standard deviation is still not as low as desire=
d (within
> >> 1/6 of the average or within 20 us if the average is close to 0), but =
the
> >> remaining samples in the set still represent useful information at tha=
t point
> >> and discarding them altogether may lead to suboptimal idle state selec=
tion.
> >>
> >> For instance, the largest idle duration value in the get_typical_inter=
val()
> >> data set is the maximum idle duration observed recently and it is like=
ly that
> >> the upcoming idle duration will not exceed it.  Therefore, in the abse=
nce of
> >> a better choice, this value can be used as an upper bound on the targe=
t
> >> residency of the idle state to select.  Patch [5/5] works along these =
lines,
> >> but it takes the maximum data point remaining after the elimination of
> >> outliers.
> >>
> >> The first two patches in the series are straightforward cleanups (in f=
act,
> >> the first patch is kind of reversed by patch [4/5], but it is there be=
cause
> >> it can be applied without the latter) and patch [3/5] is a cosmetic ch=
ange
> >> made in preparation for the subsequent ones.
> >>
> >> This series turns out to restore the SPECjbb critical-jOPS metric on a=
ffected
> >> systems to the level from before commit 0611a640e60a and it also happe=
ns to
> >> increase its max-jOPS metric by around 3%.
> >>
> >> For easier reference/testing it is present in the git branch at
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/lo=
g/?h=3Dexperimental/menu
> >>
> >> based on the cpuidle material that went into 6.14-rc1.
> >>
> >> If possible, please let me know if it works for you.
> >>
> >> Thanks!
> >>
> >>
> >> [1] Link: https://www.spec.org/jbb2015/
>
> Another dump for x86 idle this time, tldr: no worrying idle/power numbers

[cut]

> Significantly improving idle miss belows.
>
> I'll do the Android tests, but that is very unlikely to show something th=
is
> doesn't (there's only one non-WFI idle state and most workloads are inter=
cept
> heavy, so if anything menu-5 should improve the overall situation.)
> Feel free to already add:
> Tested-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

