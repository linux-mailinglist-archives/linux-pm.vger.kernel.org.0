Return-Path: <linux-pm+bounces-34913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82222B819A0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 21:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA6A165EF9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1C2FCBF3;
	Wed, 17 Sep 2025 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5VU0dxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AA2FC894
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137097; cv=none; b=INBk55ML01eMUb7xrqOjhuwYnlGujFdudVIN6syQ8ssJMI2zC3lKJCxKNv1FifVwev2SFNhtD38/nLiRF5y21Lv4mx7W+MCxR6f0GlzhPz74OHuFDA2jrMxf0+iwQzJKMuPXafKy/HPGZeDzNxb5GCwwBXrquSYYIRLHgljgMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137097; c=relaxed/simple;
	bh=MkXdp5H1QizaH7xbpVpdsbU78Mw7LqyxRZxu3pFlAHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk1RAyzqGVn6DKnKNu1Rpj1f6CXFxSUGdUKLBLLUML9CrKbFmr2rvKU3Z2YasWmIjh8OD3Hn/z2UYqA1udzCAlbSvfjpCDKufuEaHQK7MOZs7R4RXc4l2vMPdosxvROlyEtGa2/JZwHgqP/mWGWkvLzZds/tfxuJs4jrMBj+0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5VU0dxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB92C4CEFF
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137097;
	bh=MkXdp5H1QizaH7xbpVpdsbU78Mw7LqyxRZxu3pFlAHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T5VU0dxOFrWrfxNgJWgMV4FGBsKbQ9U3SvtJriDRYLf9wnjO+kawn5JvOIg3CoMwC
	 fBjR1fBjfaRJPbSmqoKlUci5+g02vaI2xBfRDASP0dbil9s9qix+J3O2Mf4fxML3l6
	 vmPFZVUvr+WYUjDVs+L81L96vyFhr5KyxFa1+8baaoFwQa0/OFgJJFjDdw7qYVBe26
	 eRzkdY5QsV6fGq7BovNtrBSXtb9TEnjaGrDLJfpPQYeY8/kSP2AlfycYKuulP1wAjP
	 l5L7VzpNBeNMJXoOUHahF2eT4HOghjfIZ4nlRM02tffhJAEWzMPOIJgZ7MLH0ArtuR
	 cqJKVgA20kAeQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-621132816c8so103449eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 12:24:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfCpkrfog9Z7Dx66o9NrcCNISc3Jr/xdIOhGQluZM7r8nOI44Ej0n/5slzix68zXlfEp2j19oHWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1beXXGx6nGHDCkWcC/c59JMO124aVUa4XqDhPnoyo9wBxgbf
	7pBkczVeYgXyMw+rDSqzlWORNodmcuRmpT6rj5XfVVuaAmP4cKK4rMk1/B463Hq76EvdUyj3WYC
	47lsLCdhkdrp0x01ULo8R1QyISUWBZUg=
X-Google-Smtp-Source: AGHT+IETE6XaTQ10uIZrWGowaqdYF0YKB6mD5x4nZTrZAEKpPxRu7UPLchElkP0/N7Qt6VAMt9vHa2laz1aT4trGBaA=
X-Received: by 2002:a05:6808:4f60:b0:437:eb1d:cddb with SMTP id
 5614622812f47-43d50a810e7mr1695229b6e.1.1758137096275; Wed, 17 Sep 2025
 12:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org> <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
 <7hldnp6apf.fsf@baylibre.com> <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
 <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com> <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com>
In-Reply-To: <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Sep 2025 21:24:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
X-Gm-Features: AS18NWDYb399cWlUNG8aNGGu8-I0YDNj2FcRr7Wo8J3qWzgzNb67RsnHzjNVCYM
Message-ID: <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay.

On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@baylibr=
e.com> wrote:
> > > >
> > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > >
> > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > >>
> > > > >> Some platforms and devices supports multiple low-power-states th=
an can be
> > > > >> used for system-wide suspend. Today these states are selected on=
 per
> > > > >> subsystem basis and in most cases it's the deepest possible stat=
e that
> > > > >> becomes selected.
> > > > >>
> > > > >> For some use-cases this is a problem as it isn't suitable or eve=
n breaks
> > > > >> the system-wakeup latency constraint, when we decide to enter th=
ese deeper
> > > > >> states during system-wide suspend.
> > > > >>
> > > > >> Therefore, let's introduce an interface for user-space, allowing=
 us to
> > > > >> specify the system-wakeup QoS limit. Subsequent changes will sta=
rt taking
> > > > >> into account the QoS limit.
> > > > >
> > > > > Well, this is not really a system-wakeup limit, but a CPU idle st=
ate
> > > > > latency limit for states entered in the last step of suspend-to-i=
dle.
> > > > >
> > > > > It looks like the problem is that the existing CPU latency QoS is=
 not
> > > > > taken into account by suspend-to-idle, so instead of adding an
> > > > > entirely new interface to overcome this, would it make sense to a=
dd an
> > > > > ioctl() to the existing one that would allow the user of it to
> > > > > indicate that the given request should also be respected by
> > > > > suspend-to-idle?
> > > > >
> > > > > There are two basic reasons why I think so:
> > > > > (1) The requests that you want to be respected by suspend-to-idle
> > > > > should also be respected by the regular "runtime" idle, or at lea=
st I
> > > > > don't see a reason why it wouldn't be the case.
> > > > > (2) The new interface introduced by this patch basically duplicat=
es
> > > > > the existing one.
> > > >
> > > > I also think that just using the existing /dev/cpu_dma_latency is t=
he
> > > > right approach here, and simply teaching s2idle to respect this val=
ue.
> > > >
> > > > I'm curious about the need for a new ioctl() though.  Under what
> > > > conditions do you want normal/runtime CPUidle to respect this value=
 and
> > > > s2idle to not respect this value?
> > >
> > > In a typical PC environment s2idle is a replacement for ACPI S3 which
> > > does not take any QoS constraints into account, so users may want to
> > > set QoS limits for run-time and then suspend with the expectation tha=
t
> > > QoS will not affect it.
> >
> > Yes, I agree. To me, these are orthogonal use-cases which could have
> > different wakeup latency constraints.
> >
> > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael would
> > allow this to be managed, I think.
> >
> > Although, I am not fully convinced yet that re-using
> > /dev/cpu_dma_latency is the right path. The main reason is that I
> > don't want us to limit the use-case to CPU latencies, but rather allow
> > the QoS constraint to be system-wide for any type of device. For
> > example, it could be used by storage drivers too (like NVMe, UFS,
> > eMMC), as a way to understand what low power state to pick as system
> > wide suspend. If you have a closer look at patch2 [1] , I suggest we
> > extend the genpd-governor for *both* CPU-cluster-PM-domains and for
> > other PM-domains too.
> >
> > Interested to hear your thoughts around this.
>
> Hey, just wanted to see if you have managed to digest this and have
> any possible further comment?

The reason why I thought about reusing /dev/cpu_dma_latency is because
I think that the s2idle limit should also apply to cpuidle.  Of
course, cpuidle may be limited further, but IMV it should observe the
limit set on system suspend (it would be kind of inconsistent to allow
cpuidle to use deeper idle states than can be used by s2idle).

I also don't think that having a per-CPU s2idle limit would be
particularly useful (and it might be problematic).

Now, it is not as straightforward as I thought because someone may
want to set a more restrictive limit on cpuidle, in which case they
would need to open the same special device file twice etc and that
would be quite cumbersome.

So in the end I think that what you did in the $subject patch is
better, but I still would like it to also affect cpuidle.

And it needs to be made clear that this is a limit on the resume
latency of one device.  Worst case, the system wakeup latency may be a
sum of those limits if the devices in question are resumed
sequentially, so in fact this is a limit on the contribution of a
given device to the system wakeup latency.

