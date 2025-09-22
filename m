Return-Path: <linux-pm+bounces-35186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BABB92AB0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 20:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0523B64F3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4FE31A07C;
	Mon, 22 Sep 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/okeDMI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96F2877DC
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567357; cv=none; b=OtzK90S2GA/HGJj5cmutppdWOyRTqjBcrSzzykkJt6bbMGF53mQT3qoNoWiD6ZIrXQCyyUdGZHT6J+GzUwOyuYrAjTO6UooOBNDN7bGRhB8XCVP5VZ6dVbYGbgR3gEaCsEKIIvz2RDhba3Yg62gNxVd8go3evPzZDFyXE1gnZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567357; c=relaxed/simple;
	bh=rpnKJoDnQ69EXyGOvfTeBYWhyP/tp6zNGqSbpMUrvKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atizORLpEc6g5gsbMfnWUhuM2AKy2ZB1T/BeHJApDWzFgXR60UOlBEFTB0E0c+zckPcg1xeA9VOQ6wWjxKGBLnZ2Gk+6CKjpFeqj+0ql8WS1NWxpvp084Xn6ObQ5n1VO7R4UtbagN6zTuM7UBXETiUx0fs7cKhT13qKMb2OR7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/okeDMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2690FC19421
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567357;
	bh=rpnKJoDnQ69EXyGOvfTeBYWhyP/tp6zNGqSbpMUrvKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d/okeDMIkVgGG0vArFIpDH9r3pQZ/zzvpSk6qYKIjz8ge25oja5YdQSaOiiR4jBQ9
	 Bx6Cwl90Zsq8Et7ss9h70bAtYy2qtxz8Rk1kndWIX7QmoXXH1SstHoUbkgoTkNR3L2
	 Ioy1Za7FJ2dqtg+Bylhazi3ycV+2dUEpk+RXIfyF3rBHGuLcLn1ebyE5sjwnza/OTT
	 hvj1NQbJW04L9JQsStG92S+LY3eYTUfsPcJesZ3hp0yFhS2xDn7QijevzPWE4QggmB
	 qeY6VbOtM2KSsJCBbTLja680GgRgHzQXOe8FSepqG2d+loCkRvS+i5u/gObsd8z6oR
	 10FNIbcNEx8ng==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bd4a3f39cso1141220eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 11:55:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqjLdJkaJ8edp046hD0UUumOSp56kIPJusWtyL5BGmUx5wkc3PW7P+ngPzn5wxdJ2HIxG7L098gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVS4LpMivl8P8q1x1BRmETAB88FCsnTA5QIC72a1zHeml87WR
	3Zpu3N5Kz6ltlRCifkS+YsONOA+SIR8wQoOABWaEL7GtbdakFZ9SVDelP6FH+HEQEofWaD9MS1A
	Bd0Ruw3zKuNPf/haelMs7jJdylvaFBdk=
X-Google-Smtp-Source: AGHT+IFuqFHAX1fywg4rX28McVqobPBk9c7dx9KK8JP7Mwu8ueN867r8mO/48JVQvtJrzihyGJD313+CTMDHl4ULaVI=
X-Received: by 2002:a05:6808:d50:b0:439:ae49:9157 with SMTP id
 5614622812f47-43d6c279229mr6200623b6e.34.1758567356303; Mon, 22 Sep 2025
 11:55:56 -0700 (PDT)
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
 <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com>
 <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com> <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com>
In-Reply-To: <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 20:55:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
X-Gm-Features: AS18NWAqpPudgPO9jCOlrdnlFpqqqtPd-tizRtXXuA2HtJo6NEEUaYVfGnJKui8
Message-ID: <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 5:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
> >
> > Hi,
> >
> > Sorry for the delay.
> >
> > On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> > > >
> > > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@bay=
libre.com> wrote:
> > > > > >
> > > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > > >
> > > > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hans=
son@linaro.org> wrote:
> > > > > > >>
> > > > > > >> Some platforms and devices supports multiple low-power-state=
s than can be
> > > > > > >> used for system-wide suspend. Today these states are selecte=
d on per
> > > > > > >> subsystem basis and in most cases it's the deepest possible =
state that
> > > > > > >> becomes selected.
> > > > > > >>
> > > > > > >> For some use-cases this is a problem as it isn't suitable or=
 even breaks
> > > > > > >> the system-wakeup latency constraint, when we decide to ente=
r these deeper
> > > > > > >> states during system-wide suspend.
> > > > > > >>
> > > > > > >> Therefore, let's introduce an interface for user-space, allo=
wing us to
> > > > > > >> specify the system-wakeup QoS limit. Subsequent changes will=
 start taking
> > > > > > >> into account the QoS limit.
> > > > > > >
> > > > > > > Well, this is not really a system-wakeup limit, but a CPU idl=
e state
> > > > > > > latency limit for states entered in the last step of suspend-=
to-idle.
> > > > > > >
> > > > > > > It looks like the problem is that the existing CPU latency Qo=
S is not
> > > > > > > taken into account by suspend-to-idle, so instead of adding a=
n
> > > > > > > entirely new interface to overcome this, would it make sense =
to add an
> > > > > > > ioctl() to the existing one that would allow the user of it t=
o
> > > > > > > indicate that the given request should also be respected by
> > > > > > > suspend-to-idle?
> > > > > > >
> > > > > > > There are two basic reasons why I think so:
> > > > > > > (1) The requests that you want to be respected by suspend-to-=
idle
> > > > > > > should also be respected by the regular "runtime" idle, or at=
 least I
> > > > > > > don't see a reason why it wouldn't be the case.
> > > > > > > (2) The new interface introduced by this patch basically dupl=
icates
> > > > > > > the existing one.
> > > > > >
> > > > > > I also think that just using the existing /dev/cpu_dma_latency =
is the
> > > > > > right approach here, and simply teaching s2idle to respect this=
 value.
> > > > > >
> > > > > > I'm curious about the need for a new ioctl() though.  Under wha=
t
> > > > > > conditions do you want normal/runtime CPUidle to respect this v=
alue and
> > > > > > s2idle to not respect this value?
> > > > >
> > > > > In a typical PC environment s2idle is a replacement for ACPI S3 w=
hich
> > > > > does not take any QoS constraints into account, so users may want=
 to
> > > > > set QoS limits for run-time and then suspend with the expectation=
 that
> > > > > QoS will not affect it.
> > > >
> > > > Yes, I agree. To me, these are orthogonal use-cases which could hav=
e
> > > > different wakeup latency constraints.
> > > >
> > > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael wo=
uld
> > > > allow this to be managed, I think.
> > > >
> > > > Although, I am not fully convinced yet that re-using
> > > > /dev/cpu_dma_latency is the right path. The main reason is that I
> > > > don't want us to limit the use-case to CPU latencies, but rather al=
low
> > > > the QoS constraint to be system-wide for any type of device. For
> > > > example, it could be used by storage drivers too (like NVMe, UFS,
> > > > eMMC), as a way to understand what low power state to pick as syste=
m
> > > > wide suspend. If you have a closer look at patch2 [1] , I suggest w=
e
> > > > extend the genpd-governor for *both* CPU-cluster-PM-domains and for
> > > > other PM-domains too.
> > > >
> > > > Interested to hear your thoughts around this.
> > >
> > > Hey, just wanted to see if you have managed to digest this and have
> > > any possible further comment?
> >
> > The reason why I thought about reusing /dev/cpu_dma_latency is because
> > I think that the s2idle limit should also apply to cpuidle.  Of
> > course, cpuidle may be limited further, but IMV it should observe the
> > limit set on system suspend (it would be kind of inconsistent to allow
> > cpuidle to use deeper idle states than can be used by s2idle).
>
> Agreed!
>
> >
> > I also don't think that having a per-CPU s2idle limit would be
> > particularly useful (and it might be problematic).
> >
> > Now, it is not as straightforward as I thought because someone may
> > want to set a more restrictive limit on cpuidle, in which case they
> > would need to open the same special device file twice etc and that
> > would be quite cumbersome.
> >
> > So in the end I think that what you did in the $subject patch is
> > better, but I still would like it to also affect cpuidle.
>
> Okay. I will update the patches according to your suggestions!
>
> >
> > And it needs to be made clear that this is a limit on the resume
> > latency of one device.  Worst case, the system wakeup latency may be a
> > sum of those limits if the devices in question are resumed
> > sequentially, so in fact this is a limit on the contribution of a
> > given device to the system wakeup latency.
>
> Indeed, that's a very good point! I will keep this in mind when
> working on adding the documentation part.

Well, this also means that using one limit for all of the different
devices is not likely to be very practical because the goal is to save
as much energy as reasonably possible in system suspend while
respecting a global resume latency constraint at the same time.

Using the same limit on a local contribution from each device to the
combined latency is not likely to be effective here.  Rather, I'd
expect that the best results can be achieved by setting different
resume latency limits on different devices, depending on how much
power they draw in each of their idle states and what the exit latency
values for all of those states are.  In other words, this appears to
be an optimization problem in which the resume latency limits for
individual devices need to be chosen to satisfy the global resume
latency constraint and minimize the total system power.

> Again, thanks a lot for your feedback!

Anytime!

