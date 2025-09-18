Return-Path: <linux-pm+bounces-34973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F635B85AD4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B05E3A438C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF230CB22;
	Thu, 18 Sep 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="se7FEJ9P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597521B9D2
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209655; cv=none; b=rZ3Cj/f2RMSW0ufhgGn5hyi9JcoRyBumUi65eubBppvvsdZWtBbhY9RRINRqAsNbUiAcb19iKf8u9P9op7N8G2Tdz57gGg1cgK+wQPuFHokLh23KhRnEM6ANyTKWXlxEZx4Lk69SMkX7Fs9F6autfz2sLg9uCOKfkjvhwin3GsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209655; c=relaxed/simple;
	bh=HhJhrf90L28wa74pdl1F4jFPVstYvBIwJvD/uW5OlPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVh9lVmuFSEfom9ETTpthQqXWiFa/79gIro8k14Cbgrd/vMvpFDzsURDhAJIoLB5c1u/gaU8c5FSjlMee7UiJCmd5pz4/d8iqWNBcBT8DhGlqf6PWCcRKOxfvi4gwN5NGBn5NSC1I/hsPfR07fNZyTMf8E/mRA/lce1w+LTMdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=se7FEJ9P; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60504bf8so11636617b3.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758209653; x=1758814453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vk5OzhmzjQyEyUwesG5AV+nLCa2F2V1S0oZe6mof9Q=;
        b=se7FEJ9Pxjpq6bhuHknAbO7nhrexe5lhupqx9e6y2QJTHYzZFntzVtYmcFQU57hNyW
         snLkVyBI3ORcWd1E/j2rUbp7YQ/FbIugsNrxtNx2zX/HYboIuQgBDTAWEbz9dYHiiaHU
         FgioBa5+tzVXOCdd9Xi09UQNXwJXRyfn0tKvkiXmMhxD9gG71pZ4lR6QFD/161i/tIyv
         FLcpYqKeEbRcZsfgCY1wirj61FRRy88P9M9QG+gQFlt4qaOEAY4ST8kR+ZUdplsh49t0
         D9y+79KiFuwnMjBX9ULeEs9hhn90v+vhwdi5XvoBc8HAH5FgbKPHLJkBQWROqyT+2sKb
         vAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209653; x=1758814453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Vk5OzhmzjQyEyUwesG5AV+nLCa2F2V1S0oZe6mof9Q=;
        b=Y+1FXwqHPEwyiqZ4jPUR5rUc0zgH+aaDQHFirzlPSWBd67EXJxXjfXwS6L6SGx0G0R
         vRY9Odwo7tWQvAcIjdzOfd/94x2VM0vc9QsfRzEw+vO5BEK6wWCtnxjRIDmXfoqiFSBV
         Ol/6+7RpXiBDky61jtGw8A5b0TcB7FkBbbn6mUixiSaZVj85FWUVm3tp65Nw+1KFP+9L
         Y1E2Pd/QzjivyAVXiZjkWP5eo6+SyHwHhqrKOCseqywATeK/6r0KhT7SLh3WzN33W9hL
         ciKnLKD+UT6XVntZdbsudXLhWSKIr4WeAjAC6Wpp8j3O1go7epq8ClcJg3QZuAhz07ER
         lNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMGrlakzP1K/TvMfWgPUhNEJrZsjQCueAYFLBUazJctF/GqmmXul8U5Nca5rnxCp/n4zkZU70RFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPkj2Ie2g3kElwv84N8HC2u24sXPBfftTG/5BQDD2Y9uPVOFX
	W6OqpSdimsVacBGwZSBXofCWGYik/fbbFWFgAG6BLEytdzxpNxKuFbLUiCDUwRi/1Ot/slE0QiE
	fUqRug21ynz4+8dyjLKcrMT2ceUwOTuOZOURuWqHDOA==
X-Gm-Gg: ASbGncuoNt/ge32eLmBNpwVOOaWEGlYUYHVOdm9seVaoYFs0xp9ufttO+UUjwgvE8iT
	Vdcd+IgEgt7YXqThHsjSlpYIMEwWbry0FkQV+1HbeLzI+z4OdrYMZ+8mm04k3l97BIWIG0Pd1+a
	nqB9id2BQDm/YtefE1C65GarAvmR1OCMKftuPAPXzSo/5rknG6sUuXAkOKYHT03K38jLtLFfXGe
	nWNsNNVIF2ZNpj8bZofIfz6I+f83pLwZTSfdQ==
X-Google-Smtp-Source: AGHT+IGa0RA/E833vhE2XgwToDc/b4w+5n2jV9ffCYdAghAwqJL3MsnBQ6fNuuH8VSHrQU7cl/A2Q5pxUvEgD81+h0I=
X-Received: by 2002:a53:d603:0:b0:625:2f9:475e with SMTP id
 956f58d0204a3-633b064c7d5mr4436729d50.13.1758209652773; Thu, 18 Sep 2025
 08:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org> <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
 <7hldnp6apf.fsf@baylibre.com> <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
 <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
 <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com> <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:33:36 +0200
X-Gm-Features: AS18NWBAhRhBnrK1Wvs4hJmM1vScVNz_Nd4F3UZ7ZOmwsgUk5SQAfL930OHxaL0
Message-ID: <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi,
>
> Sorry for the delay.
>
> On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> > >
> > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@bayli=
bre.com> wrote:
> > > > >
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > >
> > > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansso=
n@linaro.org> wrote:
> > > > > >>
> > > > > >> Some platforms and devices supports multiple low-power-states =
than can be
> > > > > >> used for system-wide suspend. Today these states are selected =
on per
> > > > > >> subsystem basis and in most cases it's the deepest possible st=
ate that
> > > > > >> becomes selected.
> > > > > >>
> > > > > >> For some use-cases this is a problem as it isn't suitable or e=
ven breaks
> > > > > >> the system-wakeup latency constraint, when we decide to enter =
these deeper
> > > > > >> states during system-wide suspend.
> > > > > >>
> > > > > >> Therefore, let's introduce an interface for user-space, allowi=
ng us to
> > > > > >> specify the system-wakeup QoS limit. Subsequent changes will s=
tart taking
> > > > > >> into account the QoS limit.
> > > > > >
> > > > > > Well, this is not really a system-wakeup limit, but a CPU idle =
state
> > > > > > latency limit for states entered in the last step of suspend-to=
-idle.
> > > > > >
> > > > > > It looks like the problem is that the existing CPU latency QoS =
is not
> > > > > > taken into account by suspend-to-idle, so instead of adding an
> > > > > > entirely new interface to overcome this, would it make sense to=
 add an
> > > > > > ioctl() to the existing one that would allow the user of it to
> > > > > > indicate that the given request should also be respected by
> > > > > > suspend-to-idle?
> > > > > >
> > > > > > There are two basic reasons why I think so:
> > > > > > (1) The requests that you want to be respected by suspend-to-id=
le
> > > > > > should also be respected by the regular "runtime" idle, or at l=
east I
> > > > > > don't see a reason why it wouldn't be the case.
> > > > > > (2) The new interface introduced by this patch basically duplic=
ates
> > > > > > the existing one.
> > > > >
> > > > > I also think that just using the existing /dev/cpu_dma_latency is=
 the
> > > > > right approach here, and simply teaching s2idle to respect this v=
alue.
> > > > >
> > > > > I'm curious about the need for a new ioctl() though.  Under what
> > > > > conditions do you want normal/runtime CPUidle to respect this val=
ue and
> > > > > s2idle to not respect this value?
> > > >
> > > > In a typical PC environment s2idle is a replacement for ACPI S3 whi=
ch
> > > > does not take any QoS constraints into account, so users may want t=
o
> > > > set QoS limits for run-time and then suspend with the expectation t=
hat
> > > > QoS will not affect it.
> > >
> > > Yes, I agree. To me, these are orthogonal use-cases which could have
> > > different wakeup latency constraints.
> > >
> > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael woul=
d
> > > allow this to be managed, I think.
> > >
> > > Although, I am not fully convinced yet that re-using
> > > /dev/cpu_dma_latency is the right path. The main reason is that I
> > > don't want us to limit the use-case to CPU latencies, but rather allo=
w
> > > the QoS constraint to be system-wide for any type of device. For
> > > example, it could be used by storage drivers too (like NVMe, UFS,
> > > eMMC), as a way to understand what low power state to pick as system
> > > wide suspend. If you have a closer look at patch2 [1] , I suggest we
> > > extend the genpd-governor for *both* CPU-cluster-PM-domains and for
> > > other PM-domains too.
> > >
> > > Interested to hear your thoughts around this.
> >
> > Hey, just wanted to see if you have managed to digest this and have
> > any possible further comment?
>
> The reason why I thought about reusing /dev/cpu_dma_latency is because
> I think that the s2idle limit should also apply to cpuidle.  Of
> course, cpuidle may be limited further, but IMV it should observe the
> limit set on system suspend (it would be kind of inconsistent to allow
> cpuidle to use deeper idle states than can be used by s2idle).

Agreed!

>
> I also don't think that having a per-CPU s2idle limit would be
> particularly useful (and it might be problematic).
>
> Now, it is not as straightforward as I thought because someone may
> want to set a more restrictive limit on cpuidle, in which case they
> would need to open the same special device file twice etc and that
> would be quite cumbersome.
>
> So in the end I think that what you did in the $subject patch is
> better, but I still would like it to also affect cpuidle.

Okay. I will update the patches according to your suggestions!

>
> And it needs to be made clear that this is a limit on the resume
> latency of one device.  Worst case, the system wakeup latency may be a
> sum of those limits if the devices in question are resumed
> sequentially, so in fact this is a limit on the contribution of a
> given device to the system wakeup latency.

Indeed, that's a very good point! I will keep this in mind when
working on adding the documentation part.

Again, thanks a lot for your feedback!

Kind regards
Uffe

