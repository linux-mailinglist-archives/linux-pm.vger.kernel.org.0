Return-Path: <linux-pm+bounces-35210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A863B95AE3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89D817790A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2037321430;
	Tue, 23 Sep 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/lHqbzg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DA2F7ABE
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627545; cv=none; b=NKr1zKHpI09FtqOOaTYB6nkzHIAnoRwME0jQmhkAVBUqvyGdJxKB75cG+WJCa8frLxabOqByVLzqwGhzQw5Ku1+or9j7jXNG9inH+h5EzfIDUwvwwaUdUxY/xEtuDrtxtVGn6yGtdPVZzJ4ltaKXHKooPH5zdqS2g4UNWiHxQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627545; c=relaxed/simple;
	bh=HaG2QTpWYEBdR5SAqtzfvuPRazBsarp9FyRmv/elK+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMaeq4WGL7m5UWEs/uzyMrlEPKKbp11DKNhvOpO+3mEy4Q6yoYOCqYt+JXQEe9JZG9Qldc0TBUf0axlD2EeUk8wlrJ1jKNAMCaWF0p/Ra01qXTK2DnZNlONwQLHbjcUMeZjQQkQ9gDnzMy9u4WwIQyy9m+32a/rZL6Ml5rxW4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/lHqbzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA1C116D0
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758627545;
	bh=HaG2QTpWYEBdR5SAqtzfvuPRazBsarp9FyRmv/elK+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D/lHqbzgNj1/SQ7cYcIkdgVYWcY3H1K3pjEQ+QQSn+W4TyGdZBODZSRcdTup2MBqp
	 VmjjmAph0/5zkeQxWkO+UGDI5Tdk/qJfnkagb48MMg/4wGc9lwckVlc8jHcYNyH/3V
	 S9g/6tsM63k54u3A5oC5DEdr+AIhilmhlsu95p0MLTK4IjckWeSbzTX07L/zhrYlX/
	 L+XvmzAhkyr8SV549pdQxYfesXcDPN0f8VkZeUgRzOsA8mwPbhHYF9Z9W3X0wRXovg
	 V1i/R4B4mJkj5tpoDBp0gqW9Qq8sHncSyKMXbvE1dVNq5UQwj/HxC3DXfcRuLuqwMa
	 8o/3DOgiWbLUA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-62f5f5cfc58so825479eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 04:39:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoryw2EEYMfos8a4Bk2o/ywlxNPcrFEOf2b+CP5IZFl0SM44idZ5TAHYb8IY6VlM5Ie4qvrkRekg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIdXNE1/9k3hTfQ2lbdr9gw7H1RHo8+wP6HyXJHalPg4Dnti/
	YhdHdfxbcSEcYIYIrUIYoF+pg/rzm1yGAQeXEGNqKlG5ihXtvoEXx1oTO0DHt35szFz80UHwvf/
	vjwFQ+0YNKjRgKiOFJQiWRChKeYYYfxQ=
X-Google-Smtp-Source: AGHT+IHTMU7UcMjiRqQoRbjRHpypKyIyk+PnEgVPOMtXKGoGxFK9e3q8fnCmgnY0ci0NL7uNHCXGUSfr9XjxXjtCATA=
X-Received: by 2002:a05:6808:10d6:b0:439:b82f:ce with SMTP id
 5614622812f47-43f2d414ddemr1093199b6e.31.1758627544383; Tue, 23 Sep 2025
 04:39:04 -0700 (PDT)
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
 <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
 <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com>
 <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com> <CAPDyKFr0-yh8wt169QanAo3AmuXBq_9p3xiiqeFmmWz-ntNQsw@mail.gmail.com>
In-Reply-To: <CAPDyKFr0-yh8wt169QanAo3AmuXBq_9p3xiiqeFmmWz-ntNQsw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 13:38:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4nS7fm347ue0Kj_eGwAi=o1vzyJm25_Q67dWzyoXR+Q@mail.gmail.com>
X-Gm-Features: AS18NWAFg0M4HXZSspPlYTt5txJHvU0nRsvR1u-3VTw55C1oUUoQ-Bnr5qDvO5k
Message-ID: <CAJZ5v0h4nS7fm347ue0Kj_eGwAi=o1vzyJm25_Q67dWzyoXR+Q@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:42=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Mon, 22 Sept 2025 at 20:55, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
> >
> > On Thu, Sep 18, 2025 at 5:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel.org> =
wrote:
> > > >
> > > > Hi,
> > > >
> > > > Sorry for the delay.
> > > >
> > > > On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> > > > > >
> > > > > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman=
@baylibre.com> wrote:
> > > > > > > >
> > > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > > > > >
> > > > > > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.=
hansson@linaro.org> wrote:
> > > > > > > > >>
> > > > > > > > >> Some platforms and devices supports multiple low-power-s=
tates than can be
> > > > > > > > >> used for system-wide suspend. Today these states are sel=
ected on per
> > > > > > > > >> subsystem basis and in most cases it's the deepest possi=
ble state that
> > > > > > > > >> becomes selected.
> > > > > > > > >>
> > > > > > > > >> For some use-cases this is a problem as it isn't suitabl=
e or even breaks
> > > > > > > > >> the system-wakeup latency constraint, when we decide to =
enter these deeper
> > > > > > > > >> states during system-wide suspend.
> > > > > > > > >>
> > > > > > > > >> Therefore, let's introduce an interface for user-space, =
allowing us to
> > > > > > > > >> specify the system-wakeup QoS limit. Subsequent changes =
will start taking
> > > > > > > > >> into account the QoS limit.
> > > > > > > > >
> > > > > > > > > Well, this is not really a system-wakeup limit, but a CPU=
 idle state
> > > > > > > > > latency limit for states entered in the last step of susp=
end-to-idle.
> > > > > > > > >
> > > > > > > > > It looks like the problem is that the existing CPU latenc=
y QoS is not
> > > > > > > > > taken into account by suspend-to-idle, so instead of addi=
ng an
> > > > > > > > > entirely new interface to overcome this, would it make se=
nse to add an
> > > > > > > > > ioctl() to the existing one that would allow the user of =
it to
> > > > > > > > > indicate that the given request should also be respected =
by
> > > > > > > > > suspend-to-idle?
> > > > > > > > >
> > > > > > > > > There are two basic reasons why I think so:
> > > > > > > > > (1) The requests that you want to be respected by suspend=
-to-idle
> > > > > > > > > should also be respected by the regular "runtime" idle, o=
r at least I
> > > > > > > > > don't see a reason why it wouldn't be the case.
> > > > > > > > > (2) The new interface introduced by this patch basically =
duplicates
> > > > > > > > > the existing one.
> > > > > > > >
> > > > > > > > I also think that just using the existing /dev/cpu_dma_late=
ncy is the
> > > > > > > > right approach here, and simply teaching s2idle to respect =
this value.
> > > > > > > >
> > > > > > > > I'm curious about the need for a new ioctl() though.  Under=
 what
> > > > > > > > conditions do you want normal/runtime CPUidle to respect th=
is value and
> > > > > > > > s2idle to not respect this value?
> > > > > > >
> > > > > > > In a typical PC environment s2idle is a replacement for ACPI =
S3 which
> > > > > > > does not take any QoS constraints into account, so users may =
want to
> > > > > > > set QoS limits for run-time and then suspend with the expecta=
tion that
> > > > > > > QoS will not affect it.
> > > > > >
> > > > > > Yes, I agree. To me, these are orthogonal use-cases which could=
 have
> > > > > > different wakeup latency constraints.
> > > > > >
> > > > > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafae=
l would
> > > > > > allow this to be managed, I think.
> > > > > >
> > > > > > Although, I am not fully convinced yet that re-using
> > > > > > /dev/cpu_dma_latency is the right path. The main reason is that=
 I
> > > > > > don't want us to limit the use-case to CPU latencies, but rathe=
r allow
> > > > > > the QoS constraint to be system-wide for any type of device. Fo=
r
> > > > > > example, it could be used by storage drivers too (like NVMe, UF=
S,
> > > > > > eMMC), as a way to understand what low power state to pick as s=
ystem
> > > > > > wide suspend. If you have a closer look at patch2 [1] , I sugge=
st we
> > > > > > extend the genpd-governor for *both* CPU-cluster-PM-domains and=
 for
> > > > > > other PM-domains too.
> > > > > >
> > > > > > Interested to hear your thoughts around this.
> > > > >
> > > > > Hey, just wanted to see if you have managed to digest this and ha=
ve
> > > > > any possible further comment?
> > > >
> > > > The reason why I thought about reusing /dev/cpu_dma_latency is beca=
use
> > > > I think that the s2idle limit should also apply to cpuidle.  Of
> > > > course, cpuidle may be limited further, but IMV it should observe t=
he
> > > > limit set on system suspend (it would be kind of inconsistent to al=
low
> > > > cpuidle to use deeper idle states than can be used by s2idle).
> > >
> > > Agreed!
> > >
> > > >
> > > > I also don't think that having a per-CPU s2idle limit would be
> > > > particularly useful (and it might be problematic).
> > > >
> > > > Now, it is not as straightforward as I thought because someone may
> > > > want to set a more restrictive limit on cpuidle, in which case they
> > > > would need to open the same special device file twice etc and that
> > > > would be quite cumbersome.
> > > >
> > > > So in the end I think that what you did in the $subject patch is
> > > > better, but I still would like it to also affect cpuidle.
> > >
> > > Okay. I will update the patches according to your suggestions!
> > >
> > > >
> > > > And it needs to be made clear that this is a limit on the resume
> > > > latency of one device.  Worst case, the system wakeup latency may b=
e a
> > > > sum of those limits if the devices in question are resumed
> > > > sequentially, so in fact this is a limit on the contribution of a
> > > > given device to the system wakeup latency.
> > >
> > > Indeed, that's a very good point! I will keep this in mind when
> > > working on adding the documentation part.
> >
> > Well, this also means that using one limit for all of the different
> > devices is not likely to be very practical because the goal is to save
> > as much energy as reasonably possible in system suspend while
> > respecting a global resume latency constraint at the same time.
> >
> > Using the same limit on a local contribution from each device to the
> > combined latency is not likely to be effective here.  Rather, I'd
> > expect that the best results can be achieved by setting different
> > resume latency limits on different devices, depending on how much
> > power they draw in each of their idle states and what the exit latency
> > values for all of those states are.  In other words, this appears to
> > be an optimization problem in which the resume latency limits for
> > individual devices need to be chosen to satisfy the global resume
> > latency constraint and minimize the total system power.
>
> I am following your reasoning and I agree!
>
> Perhaps we should start with extending the cpu_dma_latency with an
> ioctl after all? This would allow userspace to specify constraints to
> be applicable for system-wide-suspend (s2idle), but it would still be
> limited for CPUs/CPU-clusters.

Right.

Adding a separate device special file to represent the limit affecting
s2idle may be somewhat cleaner though as mentioned before.

> For other devices, we should probably explore the per device PM QoS
> (pm_qos_latency_tolerance_us) instead. Currently the
> pm_qos_latency_tolerance_us is used for "runtime_suspend", so perhaps
> adding another per device sysfs file, like
> "pm_qos_system_wakeup_latency_us",  that we can use for the
> system-wide-wakeup latency constraint?
>
> Would this make better sense, you think?

I think that this can be made work.

