Return-Path: <linux-pm+bounces-36464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A1BF1816
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 15:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBDD3E0C41
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BB25A655;
	Mon, 20 Oct 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwALX88j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C21B21BF
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966322; cv=none; b=gqbvnlMa7XiaiabQxYbwCZ3OYaNT3uZvptZ0Qg1DbOWj6MeiA0sOZnFjNL9sg5bQbW1P0OZDVeSrobA+l/yEant253XC/lorD4p7ZtgtLNWJy0id6p+hpqbFVnNJNDCpd9F5nkFEgchhia8dC48PWmW69ZEfVo9RFTDbO6tAzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966322; c=relaxed/simple;
	bh=T3ZbtjSKT8Lj7egPFjM6MiatDeaM7MGWw8l3RDf0DmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGGBx2prZ3x4jvPMoCHQIBvYW2cmxlSH3Kko9Zicj11Bw6leFzyHNpsE/rsNl+pTrqYaCSaWRiQdZ7mlkNPqx5DcDIc4SDKUmTzre0BDY2Sxw/TWobY55t+sxw86oqfl1KoJFJp7GemTe12HeKTxmvsA32B05euft1kX1x0T2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwALX88j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287BAC19421
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760966322;
	bh=T3ZbtjSKT8Lj7egPFjM6MiatDeaM7MGWw8l3RDf0DmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EwALX88jE+a5/SJm114LxzVAweK1Zqq8niclfsDsy3HZMBCxFYb4xDf43S6fM4xDy
	 996IjgH/1tA+OFM2usFAKN/taqUu3iklUOGYHfmBD0A8P3jd4Le9kEAdpVmIc/xt4M
	 w3IhGhetqU/KpOvXG7j2FvvGhbExSC2Yt1oLUA628wtDju8dPinLqOrKiTAE9eTRzl
	 QwGTKo6Z0OSKKB1X55Zrc3FkMw4J5ziEqaPaAh8uvXg5TPSH6YD5JFWq4K2RCj8YgO
	 aqBfx9D7UXhrQeNy6EiDft4Iysd08VDEHcBd6Ze/5pqEkLG4hNV5Npz/QJpUKKjw+G
	 z40F3nwPsMQQg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43f88d33872so1803065b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 06:18:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkesvb+rTcCU10PZOLbgG5W3WkiRsWAGoCxwiGm1cI6pmYae1zNeeG0cGhdmgQORdnx3Tm+n0UXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmpiWP2QAWIIARMIDN4SS+9Xx3XkU2sNu4yX6blfe2ar+BoCP
	OJ50bTn3DonSlX66wCf8+Nhi8QYoDSkoo2+nD3Rp2dpwcWXAJDJ+28enU5HHnu+Wd9lQRzQevvb
	zw0bTIqEGQHewy6GoxvFLkzWGR7SKc/o=
X-Google-Smtp-Source: AGHT+IF/IMbPwn3GU9n0xfrwMBAuzNb6Pn6kpxiIwhCKY05pivQFzdXOwTuxpU/TktIIh6PsdQ9Id4DfpO4//2n4z0w=
X-Received: by 2002:a05:6808:448d:b0:43f:57cb:7fa0 with SMTP id
 5614622812f47-443a313d2e4mr5097747b6e.46.1760966321405; Mon, 20 Oct 2025
 06:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com> <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net> <8ccf53bd-81cc-4c7b-88b5-5d7aeebf2c3f@arm.com>
In-Reply-To: <8ccf53bd-81cc-4c7b-88b5-5d7aeebf2c3f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 15:18:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ijNkUQdTGRUHRUQKKeEzCR354CGkf-L2oUsG51bnU5oA@mail.gmail.com>
X-Gm-Features: AS18NWATCzTLrtkVknl3eJY6FaRyejQGQJdzCQsbaYC0yK49S0qSAqlbZ709Yq0
Message-ID: <CAJZ5v0ijNkUQdTGRUHRUQKKeEzCR354CGkf-L2oUsG51bnU5oA@mail.gmail.com>
Subject: Re: RE: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
To: Christian Loehle <christian.loehle@arm.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 4:45=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/18/25 16:10, Doug Smythies wrote:
> > Hi all,
> >
> > I have been following and testing these menu.c changes over the last mo=
nths,
> > but never reported back on this email list because:
> > 1.) I never found anything significant to report.
> > 2.) I always seemed to be a week or more behind the conversations.
>
> Your input is always appreciated!

Indeed.

> >
> > On 2025.10.18 04:47 Rafael wrote:
> >> On Fri, Oct 17, 2025 at 8:37=E2=80=AFPM Christian Loehle wrote:
> >>> On 10/17/25 10:39, Rafael J. Wysocki wrote:
> >>>> On Fri, Oct 17, 2025 at 10:22=E2=80=AFAM Christian Loehle wrote:
> >>>>> On 10/16/25 17:25, Rafael J. Wysocki wrote:
> >>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>>
> >>>>>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid dis=
carding
> >>>>>> useful information") led to a performance regression on Intel Jasp=
er Lake
> >>>>>> systems because it reduced the time spent by CPUs in idle state C7=
 which
> >>>>>> is correlated to the maximum frequency the CPUs can get to because=
 of an
> >>>>>> average running power limit [1].
> >
> > I would like to understand Sergey's benchmark test better, and even try
> > to repeat the results on my test system. I would also like to try to
> > separate the variables in an attempt to isolate potential contributors.
> >
> > To eliminate the PL1 effect, limit the CPU frequency to 2300 MHz and re=
peat
> > the test. To eliminate potential CPU frequency scaling contributions, u=
se the
> > performance CPU frequency scaling governor. Both changes at once would
> > be an acceptable first step.
> >
> > Sergey: Would you be willing to do that test?
> > Sergey: Could you provide more details about your test?
>
> +1
> Depending on what the actual test does maybe offlining CPUs and comparing=
 would
> be interesting too (if this means that we never reach throttling on this =
system).

While it would be kind of interesting to know the test details, I
don't think that this is just one test.

Sergey mentioned several different symptoms in his initial message:

https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww=
4il3g3cv@cohflgdbpnq7/

which kind of indicates several different tests regressing, so this
appears to be a whole-platform issue.

> >>From the turbostat data of the other day, it seems that the system was
> > only power throttled for about 25 seconds for each test. What we don't =
know
> > is how long the test took overall or the magnitude of any contributions=
 from
> > the power limit throttling.
>
> If I didn't mess up it should be >800s, at least from the sum of idle tim=
e
> Sergey provided. (excludes active time)
> That makes the powerthrottling story less plausible IMO.

Quite evidently, there is a correlation between the max CPU ("busy")
frequency and the time spent in core C7 on that system.

The only explanation that I can offer is a firmware mechanism turning
spare power into a CPU boost.

RAPL is such a mechanism and it doesn't throttle strictly speaking,
but it prevents the CPU package (in the case of PL1) from using more
energy than it is allowed to use over a given time frame.  One way to
achieve that is to allow CPUs to run fast at the beginning of the
measurement window and then throttle them below a certain power level,
but it is not the only way and it is not likely to be used.  Moreover,
it is unlikely that the time spent in C7 will affect that because that
time is not known when the measurement window starts.

Another approach is to keep the package power on a "trajectory" to
meet the goal and adjust periodically given what all of the CPUs are
doing.  In that case, it will throttle sometimes when the direction of
changes is mispredicted, but overall it will set OPPs with certain
expectation regarding the trend.

Also, on some platforms high-turgo OPPs are "locked" when deep core
idle states (typically C6 and above) are not utilized, but I'm not
aware of that being done on Jasper Lake.

