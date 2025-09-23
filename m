Return-Path: <linux-pm+bounces-35224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33219B95DB4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D84167E52
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC6322C7F;
	Tue, 23 Sep 2025 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbLgoEoL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4973218DA
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631052; cv=none; b=GlJVbznTtdnoNMoSBq9PzbBAOIkXD/9DEfT7cSEb4rDbWWSxrwmiT/9tlB/Df4nNIasjVhZs/8Atg/irTBTKN6savWbgPxBBqgMFookXumxOJqSXve8MKqtaCT0DPLV3Q0eLogwF8BXkjRSF5SadsLbNc4apdYTN5E5kbtRMQMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631052; c=relaxed/simple;
	bh=+QmtAQOVwpxlpSTVPwVX5yVKeytEpt+CoKE095FD3gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkU2hpiHuyAy7oaGUL6KR3Kz+s/xPUFP3UZM9EJD+6KDUWqdNmeQsLHrEsed1Lr4f2FALUEzsEs9RWVgnsrkUjnzJFfOvC+XXTKec/aEEW6sMb1VSRoJLQc8c71qLSHHq3vOj1cI2eLQC/qyh5dxW+vCMBepGovL6/aPhsU4SsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbLgoEoL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d5fe46572so56814887b3.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758631050; x=1759235850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvUwN9Vr9BKGSGisn6QzEhOZxHxE878oCjeyu30Gbsg=;
        b=pbLgoEoLecEPVdRu2yfk3XwfUZ0s2lcyFSZg+Sg88KTLpKaDkaTq0mizeJUJ4ivr5h
         tiGh4bN3Qsf4fD/UdkTFKfBO5JwZ7Mr00KBsXCyAOr4EqENKO0wZv85e9LI0Z5IAW/2E
         SLVsSYGOQtqMBFJ6Guyw5JhFo6avmrldAwHw/oaKqEtNMvYnLN1lRplP/cuK/FVYkpCO
         ycfmmg5Qu/8O38u4yA+KZ3fA7TFB73uYxGmw+mptgbwbhDRaKXkvSf4EZEvsHs/PJhxe
         vjPdsOJeivC/jPLmvHxSxbDa2qv7eWVc0l6GB+0cryrkGYgVdxhiAwWysoqDubLHqrNX
         CNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631050; x=1759235850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvUwN9Vr9BKGSGisn6QzEhOZxHxE878oCjeyu30Gbsg=;
        b=BG3LIvpQhhmaYWJxqimoQPkHZj+HKeP8Wv6rTfZEdQeT5bfSVUTxxavLqQy4TxbOd5
         A/GHgeCsAfDJYvuD+87chkCpMu17nlxZnPSWyuwAuX0FKq/khOBWGjEdeJn0tKye8mXz
         jLwMaJthfkUSD2Q6kj388WG9oJqsaIyJn+mRs3bDh4gJqZbbEjC/1jDXakTv781TsuBQ
         oXfdlRKH/gnAaeynEBMMkfyivPa2RFUK883vRJQOhMe3xEzTUvXavMQ//64aSTsN1xlH
         uzC2d7KGWxnhvaI/NuamMij6cPj1nUofn8nYCTaVE4OkRWnHpqAvVSl35R8CWXiuR4YD
         Eysg==
X-Forwarded-Encrypted: i=1; AJvYcCV5qirlhgJ5hzKuXTlpd7LwcyOXC23kB9Pu4zWoH8X/hqtJjANHxRjzKuLRv5N+mal5vuBbtJj7hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDA5Uu3eGykQmAWrC+n6jhGLA0MTW5gdDEhRd6TRsv+c4MCIeI
	gcsK0hybmxxmM9z2g19jjEm8zoPRmAb11k/mDlrep7WOtrVJuk2+Z30QT3DscMD+ADe1Ku0NwF2
	WmNa7h+SEUmURoKfdNGpy1FH/wBB4fbLNjxRWZnS2fw==
X-Gm-Gg: ASbGncuGTDQzk4UIBOfMQygd7GX7HcrUqDk922L51UzFKfkfDj3VW+wrOqIiYarIe1Q
	m00DMQPRLScpxY3AJsay/fpuNJLztfe2Mjhdb1U/IE7JoDMy6234lQs7jiiuBjR80wkwEpTjsYK
	AuBauSn5E05WWVPDIShXkGOBfIAN5SVm/pCVhW7/qDH6j9473VXYyLqaA1hcsIW8Xc8zu0XVGpZ
	/a60VYZ
X-Google-Smtp-Source: AGHT+IHeB26D69gWYTNMT81JsyBb8j/6IpIJwLFyZe+h7iEpIJbeuVXfVhF5NDonGCkXKOQaFRnbcwFnhwo7/vnbCpY=
X-Received: by 2002:a05:690c:700c:b0:729:e448:5005 with SMTP id
 00721157ae682-7589174476fmr18123057b3.7.1758631049666; Tue, 23 Sep 2025
 05:37:29 -0700 (PDT)
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
 <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
 <CAPDyKFr0-yh8wt169QanAo3AmuXBq_9p3xiiqeFmmWz-ntNQsw@mail.gmail.com> <CAJZ5v0h4nS7fm347ue0Kj_eGwAi=o1vzyJm25_Q67dWzyoXR+Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4nS7fm347ue0Kj_eGwAi=o1vzyJm25_Q67dWzyoXR+Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 14:36:53 +0200
X-Gm-Features: AS18NWDnPOAVdcWOXRUED9DoyrDaLAhsSSqCkfpsN6z7uIuZCk4j3YcyswbX_9I
Message-ID: <CAPDyKFos=rM6Y-6tFbifpFp8XxwA=t_aya-nWhz=6ME1FaBEoA@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Sept 2025 at 13:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Sep 23, 2025 at 11:42=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Mon, 22 Sept 2025 at 20:55, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > >
> > > On Thu, Sep 18, 2025 at 5:34=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Sorry for the delay.
> > > > >
> > > > > On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > > > > > >
> > > > > > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilm=
an@baylibre.com> wrote:
> > > > > > > > >
> > > > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > > > > > >
> > > > > > > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ul=
f.hansson@linaro.org> wrote:
> > > > > > > > > >>
> > > > > > > > > >> Some platforms and devices supports multiple low-power=
-states than can be
> > > > > > > > > >> used for system-wide suspend. Today these states are s=
elected on per
> > > > > > > > > >> subsystem basis and in most cases it's the deepest pos=
sible state that
> > > > > > > > > >> becomes selected.
> > > > > > > > > >>
> > > > > > > > > >> For some use-cases this is a problem as it isn't suita=
ble or even breaks
> > > > > > > > > >> the system-wakeup latency constraint, when we decide t=
o enter these deeper
> > > > > > > > > >> states during system-wide suspend.
> > > > > > > > > >>
> > > > > > > > > >> Therefore, let's introduce an interface for user-space=
, allowing us to
> > > > > > > > > >> specify the system-wakeup QoS limit. Subsequent change=
s will start taking
> > > > > > > > > >> into account the QoS limit.
> > > > > > > > > >
> > > > > > > > > > Well, this is not really a system-wakeup limit, but a C=
PU idle state
> > > > > > > > > > latency limit for states entered in the last step of su=
spend-to-idle.
> > > > > > > > > >
> > > > > > > > > > It looks like the problem is that the existing CPU late=
ncy QoS is not
> > > > > > > > > > taken into account by suspend-to-idle, so instead of ad=
ding an
> > > > > > > > > > entirely new interface to overcome this, would it make =
sense to add an
> > > > > > > > > > ioctl() to the existing one that would allow the user o=
f it to
> > > > > > > > > > indicate that the given request should also be respecte=
d by
> > > > > > > > > > suspend-to-idle?
> > > > > > > > > >
> > > > > > > > > > There are two basic reasons why I think so:
> > > > > > > > > > (1) The requests that you want to be respected by suspe=
nd-to-idle
> > > > > > > > > > should also be respected by the regular "runtime" idle,=
 or at least I
> > > > > > > > > > don't see a reason why it wouldn't be the case.
> > > > > > > > > > (2) The new interface introduced by this patch basicall=
y duplicates
> > > > > > > > > > the existing one.
> > > > > > > > >
> > > > > > > > > I also think that just using the existing /dev/cpu_dma_la=
tency is the
> > > > > > > > > right approach here, and simply teaching s2idle to respec=
t this value.
> > > > > > > > >
> > > > > > > > > I'm curious about the need for a new ioctl() though.  Und=
er what
> > > > > > > > > conditions do you want normal/runtime CPUidle to respect =
this value and
> > > > > > > > > s2idle to not respect this value?
> > > > > > > >
> > > > > > > > In a typical PC environment s2idle is a replacement for ACP=
I S3 which
> > > > > > > > does not take any QoS constraints into account, so users ma=
y want to
> > > > > > > > set QoS limits for run-time and then suspend with the expec=
tation that
> > > > > > > > QoS will not affect it.
> > > > > > >
> > > > > > > Yes, I agree. To me, these are orthogonal use-cases which cou=
ld have
> > > > > > > different wakeup latency constraints.
> > > > > > >
> > > > > > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Raf=
ael would
> > > > > > > allow this to be managed, I think.
> > > > > > >
> > > > > > > Although, I am not fully convinced yet that re-using
> > > > > > > /dev/cpu_dma_latency is the right path. The main reason is th=
at I
> > > > > > > don't want us to limit the use-case to CPU latencies, but rat=
her allow
> > > > > > > the QoS constraint to be system-wide for any type of device. =
For
> > > > > > > example, it could be used by storage drivers too (like NVMe, =
UFS,
> > > > > > > eMMC), as a way to understand what low power state to pick as=
 system
> > > > > > > wide suspend. If you have a closer look at patch2 [1] , I sug=
gest we
> > > > > > > extend the genpd-governor for *both* CPU-cluster-PM-domains a=
nd for
> > > > > > > other PM-domains too.
> > > > > > >
> > > > > > > Interested to hear your thoughts around this.
> > > > > >
> > > > > > Hey, just wanted to see if you have managed to digest this and =
have
> > > > > > any possible further comment?
> > > > >
> > > > > The reason why I thought about reusing /dev/cpu_dma_latency is be=
cause
> > > > > I think that the s2idle limit should also apply to cpuidle.  Of
> > > > > course, cpuidle may be limited further, but IMV it should observe=
 the
> > > > > limit set on system suspend (it would be kind of inconsistent to =
allow
> > > > > cpuidle to use deeper idle states than can be used by s2idle).
> > > >
> > > > Agreed!
> > > >
> > > > >
> > > > > I also don't think that having a per-CPU s2idle limit would be
> > > > > particularly useful (and it might be problematic).
> > > > >
> > > > > Now, it is not as straightforward as I thought because someone ma=
y
> > > > > want to set a more restrictive limit on cpuidle, in which case th=
ey
> > > > > would need to open the same special device file twice etc and tha=
t
> > > > > would be quite cumbersome.
> > > > >
> > > > > So in the end I think that what you did in the $subject patch is
> > > > > better, but I still would like it to also affect cpuidle.
> > > >
> > > > Okay. I will update the patches according to your suggestions!
> > > >
> > > > >
> > > > > And it needs to be made clear that this is a limit on the resume
> > > > > latency of one device.  Worst case, the system wakeup latency may=
 be a
> > > > > sum of those limits if the devices in question are resumed
> > > > > sequentially, so in fact this is a limit on the contribution of a
> > > > > given device to the system wakeup latency.
> > > >
> > > > Indeed, that's a very good point! I will keep this in mind when
> > > > working on adding the documentation part.
> > >
> > > Well, this also means that using one limit for all of the different
> > > devices is not likely to be very practical because the goal is to sav=
e
> > > as much energy as reasonably possible in system suspend while
> > > respecting a global resume latency constraint at the same time.
> > >
> > > Using the same limit on a local contribution from each device to the
> > > combined latency is not likely to be effective here.  Rather, I'd
> > > expect that the best results can be achieved by setting different
> > > resume latency limits on different devices, depending on how much
> > > power they draw in each of their idle states and what the exit latenc=
y
> > > values for all of those states are.  In other words, this appears to
> > > be an optimization problem in which the resume latency limits for
> > > individual devices need to be chosen to satisfy the global resume
> > > latency constraint and minimize the total system power.
> >
> > I am following your reasoning and I agree!
> >
> > Perhaps we should start with extending the cpu_dma_latency with an
> > ioctl after all? This would allow userspace to specify constraints to
> > be applicable for system-wide-suspend (s2idle), but it would still be
> > limited for CPUs/CPU-clusters.
>
> Right.
>
> Adding a separate device special file to represent the limit affecting
> s2idle may be somewhat cleaner though as mentioned before.

Okay, sounds good to me too!

>
> > For other devices, we should probably explore the per device PM QoS
> > (pm_qos_latency_tolerance_us) instead. Currently the
> > pm_qos_latency_tolerance_us is used for "runtime_suspend", so perhaps
> > adding another per device sysfs file, like
> > "pm_qos_system_wakeup_latency_us",  that we can use for the
> > system-wide-wakeup latency constraint?
> >
> > Would this make better sense, you think?
>
> I think that this can be made work.

Okay, I will explore this approach.

Thanks for your feedback!

Kind regards
Uffe

