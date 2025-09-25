Return-Path: <linux-pm+bounces-35332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C444AB9E9E0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 12:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E631BC5268
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04292EAB6D;
	Thu, 25 Sep 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVYRgIv7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C612EA736
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795924; cv=none; b=rsmB5xMXXNfbRUr8E3XaFrmCfrSWDKVen24SlKGfqK7PV+/RUIPZGGnvnCn9bleq2h8lVkh9UawQ4EXxMiDSVClg7RdrP8HpAo3riypPqZq1T0/C3X4Q0Q2OQLPXRlzpGhUATiGq8ymNMSfw+n/nGiOz5qCgedjNbKrGjS620O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795924; c=relaxed/simple;
	bh=XtVkM+2G1gsdVgHt/CWQpbqSQkoB9y5NcQzWL4Ho8rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3wtkZxjRwPn1dEtW5ShOikYF96oOSlPc3OEyueRtSIIWW2UN+TLf27GYWF/vuyv5hoQWKuXkEVMAefvzuq+1xKM9jduKiMAgcZ4CeY6xLiBdWpba5RgkWushJ5khheF5f78d7Ge8q3YBK+jQt6rhFq0gSoDJ8LMN6Y2j3M/XG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVYRgIv7; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ea5bcc26849so634087276.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758795922; x=1759400722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xKL//qDf/bHFwOcVaHIl5QOFV73BHh6RluSbqnRvZ0=;
        b=aVYRgIv7FZOdUR/B+syQLPe4G1TI9ffAuu3pX2HmvoFBhwAdJabOKLZ4ZQ8kgi9Zzz
         UPfjLkEq4bTO8XMuBZrC0gcDKCID80MfyLjYFd0TVxprIk/tUG4TnZaB4RevFTHJGx0N
         PlCzRbuHpU4wkTkfXsqhKA8orY+5TQtvHHzB7Tnhgjj/5FvNZi0MJOQ/aSZpJNugafN4
         W1QXYWMgvZzRYgykS53018hPJbDy+nCzPDQKD0O/eqKbjPb5nHoIWNAcFdebbIhImkIo
         r4P0sX2FwWIVqU51qSssvEZXUDTVBNm7bIXanYwfp4Nfbn3NEv910hiRcx6gFare7uo4
         4Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795922; x=1759400722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xKL//qDf/bHFwOcVaHIl5QOFV73BHh6RluSbqnRvZ0=;
        b=ihcfehJqCC/XldIuiEiKk1usJjAxbPtVcfJMVRleADcCSrpIS5UicR23CFdFHnY+2i
         icP1W5hexPqsH+UjIi+aloyuRJmJI5nUFtWIxol4TYJ4kljN4oGLAO06ePf00n2QHuSw
         E9lrTzVFPlr3lcsHnFehNSkE2asWQMEF27frA4sr5VqQhAQhHHF9xFUH0TbOtUqDK+BY
         cL6iQBYkw66+d/ibZYXqiunJ2LDcidADefkMz/NOYE9RzE49SdgCAz7gYUU8kMoxWkGd
         GsySgy9JIiVS2ok1q6YYHgBL7atUbZ1H2MVj8ZKW9AJCK5CU5UR/7AGtZ+4NY+MTptVd
         1WjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrIJ89XSYAgbn0k1eN+FyCYrrYq0jYtsI61K10IIWBHz9GcL3WLHjpPFj64AtZPCtSMN2ZjO7IHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQMbALBx6RyanCDPjpZLkq1DJoAz5UQeIrqKvidIb2W4rGHji
	f7smHP1dzxBlABBcbH+J0hZvgIyo26A8QyhrfIJMVH7gcJle5VoYH398N4FcYOl6mKXzxvgm/Hs
	avux1hahqDMHKLnP5hlwqpceZzXxs+JSBGrk82b3wbg==
X-Gm-Gg: ASbGncvep1mLKyZUXfTk3gGz2Kr0UAmtHnatFhQgXi3HW0vBxIRw0NOvzH+CD6OBCjt
	aC1INuNI/zJffvbgfI8UaaGjszfYmzequ6h5xUZqzpY1xNLUO4FAWDXdDR3XjbsPfATRyn4m2Rl
	9LyCSp9utjuUiMgq8uD/zAuhxVcTaANmU/xVvKYA==
X-Google-Smtp-Source: AGHT+IG8V3Q7p5Vt1DR2luFePzsg0Km6CytZRwWd8W+sa6jlNcUbpUDNIrxaLDSPg7kCtzuqQEjpM1BofvJxOFFpdhA=
X-Received: by 2002:a05:690c:640c:b0:71f:f942:8467 with SMTP id
 00721157ae682-7640624f00amr25865727b3.51.1758795921561; Thu, 25 Sep 2025
 03:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7hldnp6apf.fsf@baylibre.com> <CAJZ5v0j=9RXHrcVEBp0yy1Ae4_kC1y-WFQyBf89r3NtoL-tYQw@mail.gmail.com>
 <CAPDyKFpeVF_EHJDQ9u=LDuJ56g7ykYUQWHXV2WXTYLa-mYahVA@mail.gmail.com>
 <CAPDyKFpc-PHC1QhoSrNt9KnaGov749H1AwFZUwnDDzG7RDYBRw@mail.gmail.com>
 <CAJZ5v0hC=sEcC-mU8jArwVN3EA6+U=EmCa2e7TKO0sg6LJiz7g@mail.gmail.com>
 <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com>
 <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
 <CAPDyKFr0-yh8wt169QanAo3AmuXBq_9p3xiiqeFmmWz-ntNQsw@mail.gmail.com>
 <CAJZ5v0h4nS7fm347ue0Kj_eGwAi=o1vzyJm25_Q67dWzyoXR+Q@mail.gmail.com>
 <CAPDyKFos=rM6Y-6tFbifpFp8XxwA=t_aya-nWhz=6ME1FaBEoA@mail.gmail.com> <20250923164324.mo6gkzlfb6y7spvo@lcpd911>
In-Reply-To: <20250923164324.mo6gkzlfb6y7spvo@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 12:24:45 +0200
X-Gm-Features: AS18NWCuDlHueGZETEUFNZPJuvza6u99iJRdJVkJ1uhEbwCZmVlEliOR9iZl3qA
Message-ID: <CAPDyKFowed5SdaCN6NRM_g1RtWBhu20SXUiZceBLqHrvmnQT3g@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Sept 2025 at 18:43, Dhruva Gole <d-gole@ti.com> wrote:
>
> Hi Ulf,
>
> On Sep 23, 2025 at 14:36:53 +0200, Ulf Hansson wrote:
> > On Tue, 23 Sept 2025 at 13:39, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > >
> > > On Tue, Sep 23, 2025 at 11:42=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Mon, 22 Sept 2025 at 20:55, Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 5:34=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Sorry for the delay.
> > > > > > >
> > > > > > > On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hans=
son@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <k=
hilman@baylibre.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson=
 <ulf.hansson@linaro.org> wrote:
> > > > > > > > > > > >>
> > > > > > > > > > > >> Some platforms and devices supports multiple low-p=
ower-states than can be
> > > > > > > > > > > >> used for system-wide suspend. Today these states a=
re selected on per
> > > > > > > > > > > >> subsystem basis and in most cases it's the deepest=
 possible state that
> > > > > > > > > > > >> becomes selected.
> > > > > > > > > > > >>
> > > > > > > > > > > >> For some use-cases this is a problem as it isn't s=
uitable or even breaks
> > > > > > > > > > > >> the system-wakeup latency constraint, when we deci=
de to enter these deeper
> > > > > > > > > > > >> states during system-wide suspend.
> > > > > > > > > > > >>
> > > > > > > > > > > >> Therefore, let's introduce an interface for user-s=
pace, allowing us to
> > > > > > > > > > > >> specify the system-wakeup QoS limit. Subsequent ch=
anges will start taking
> > > > > > > > > > > >> into account the QoS limit.
> > > > > > > > > > > >
> > > > > > > > > > > > Well, this is not really a system-wakeup limit, but=
 a CPU idle state
> > > > > > > > > > > > latency limit for states entered in the last step o=
f suspend-to-idle.
> > > > > > > > > > > >
> > > > > > > > > > > > It looks like the problem is that the existing CPU =
latency QoS is not
> > > > > > > > > > > > taken into account by suspend-to-idle, so instead o=
f adding an
> > > > > > > > > > > > entirely new interface to overcome this, would it m=
ake sense to add an
> > > > > > > > > > > > ioctl() to the existing one that would allow the us=
er of it to
> > > > > > > > > > > > indicate that the given request should also be resp=
ected by
> > > > > > > > > > > > suspend-to-idle?
> > > > > > > > > > > >
> > > > > > > > > > > > There are two basic reasons why I think so:
> > > > > > > > > > > > (1) The requests that you want to be respected by s=
uspend-to-idle
> > > > > > > > > > > > should also be respected by the regular "runtime" i=
dle, or at least I
> > > > > > > > > > > > don't see a reason why it wouldn't be the case.
> > > > > > > > > > > > (2) The new interface introduced by this patch basi=
cally duplicates
> > > > > > > > > > > > the existing one.
> > > > > > > > > > >
> > > > > > > > > > > I also think that just using the existing /dev/cpu_dm=
a_latency is the
> > > > > > > > > > > right approach here, and simply teaching s2idle to re=
spect this value.
> > > > > > > > > > >
> > > > > > > > > > > I'm curious about the need for a new ioctl() though. =
 Under what
> > > > > > > > > > > conditions do you want normal/runtime CPUidle to resp=
ect this value and
> > > > > > > > > > > s2idle to not respect this value?
> > > > > > > > > >
> > > > > > > > > > In a typical PC environment s2idle is a replacement for=
 ACPI S3 which
> > > > > > > > > > does not take any QoS constraints into account, so user=
s may want to
> > > > > > > > > > set QoS limits for run-time and then suspend with the e=
xpectation that
> > > > > > > > > > QoS will not affect it.
> > > > > > > > >
> > > > > > > > > Yes, I agree. To me, these are orthogonal use-cases which=
 could have
> > > > > > > > > different wakeup latency constraints.
> > > > > > > > >
> > > > > > > > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by=
 Rafael would
> > > > > > > > > allow this to be managed, I think.
> > > > > > > > >
> > > > > > > > > Although, I am not fully convinced yet that re-using
> > > > > > > > > /dev/cpu_dma_latency is the right path. The main reason i=
s that I
> > > > > > > > > don't want us to limit the use-case to CPU latencies, but=
 rather allow
> > > > > > > > > the QoS constraint to be system-wide for any type of devi=
ce. For
> > > > > > > > > example, it could be used by storage drivers too (like NV=
Me, UFS,
> > > > > > > > > eMMC), as a way to understand what low power state to pic=
k as system
> > > > > > > > > wide suspend. If you have a closer look at patch2 [1] , I=
 suggest we
> > > > > > > > > extend the genpd-governor for *both* CPU-cluster-PM-domai=
ns and for
> > > > > > > > > other PM-domains too.
> > > > > > > > >
> > > > > > > > > Interested to hear your thoughts around this.
> > > > > > > >
> > > > > > > > Hey, just wanted to see if you have managed to digest this =
and have
> > > > > > > > any possible further comment?
> > > > > > >
> > > > > > > The reason why I thought about reusing /dev/cpu_dma_latency i=
s because
> > > > > > > I think that the s2idle limit should also apply to cpuidle.  =
Of
> > > > > > > course, cpuidle may be limited further, but IMV it should obs=
erve the
> > > > > > > limit set on system suspend (it would be kind of inconsistent=
 to allow
> > > > > > > cpuidle to use deeper idle states than can be used by s2idle)=
.
> > > > > >
> > > > > > Agreed!
> > > > > >
> > > > > > >
> > > > > > > I also don't think that having a per-CPU s2idle limit would b=
e
> > > > > > > particularly useful (and it might be problematic).
> > > > > > >
> > > > > > > Now, it is not as straightforward as I thought because someon=
e may
> > > > > > > want to set a more restrictive limit on cpuidle, in which cas=
e they
> > > > > > > would need to open the same special device file twice etc and=
 that
> > > > > > > would be quite cumbersome.
> > > > > > >
> > > > > > > So in the end I think that what you did in the $subject patch=
 is
> > > > > > > better, but I still would like it to also affect cpuidle.
> > > > > >
> > > > > > Okay. I will update the patches according to your suggestions!
> > > > > >
> > > > > > >
> > > > > > > And it needs to be made clear that this is a limit on the res=
ume
> > > > > > > latency of one device.  Worst case, the system wakeup latency=
 may be a
> > > > > > > sum of those limits if the devices in question are resumed
> > > > > > > sequentially, so in fact this is a limit on the contribution =
of a
> > > > > > > given device to the system wakeup latency.
> > > > > >
> > > > > > Indeed, that's a very good point! I will keep this in mind when
> > > > > > working on adding the documentation part.
> > > > >
> > > > > Well, this also means that using one limit for all of the differe=
nt
> > > > > devices is not likely to be very practical because the goal is to=
 save
> > > > > as much energy as reasonably possible in system suspend while
> > > > > respecting a global resume latency constraint at the same time.
> > > > >
> > > > > Using the same limit on a local contribution from each device to =
the
> > > > > combined latency is not likely to be effective here.  Rather, I'd
> > > > > expect that the best results can be achieved by setting different
> > > > > resume latency limits on different devices, depending on how much
> > > > > power they draw in each of their idle states and what the exit la=
tency
> > > > > values for all of those states are.  In other words, this appears=
 to
> > > > > be an optimization problem in which the resume latency limits for
> > > > > individual devices need to be chosen to satisfy the global resume
> > > > > latency constraint and minimize the total system power.
> > > >
> > > > I am following your reasoning and I agree!
> > > >
> > > > Perhaps we should start with extending the cpu_dma_latency with an
> > > > ioctl after all? This would allow userspace to specify constraints =
to
> > > > be applicable for system-wide-suspend (s2idle), but it would still =
be
> > > > limited for CPUs/CPU-clusters.
> > >
> > > Right.
> > >
> > > Adding a separate device special file to represent the limit affectin=
g
> > > s2idle may be somewhat cleaner though as mentioned before.
> >
> > Okay, sounds good to me too!
> >
> > >
> > > > For other devices, we should probably explore the per device PM QoS
> > > > (pm_qos_latency_tolerance_us) instead. Currently the
> > > > pm_qos_latency_tolerance_us is used for "runtime_suspend", so perha=
ps
> > > > adding another per device sysfs file, like
> > > > "pm_qos_system_wakeup_latency_us",  that we can use for the
> > > > system-wide-wakeup latency constraint?
> > > >
> > > > Would this make better sense, you think?
> > >
> > > I think that this can be made work.
> >
> > Okay, I will explore this approach.
>
> I think this is kind of similar to how we did it for the TI SCI
> pmdomains driver for TI SoC. See Kevin's patch [1] where we read from
> dev_pm_qos_read_value and then based on that we set some constraints on
> the firmware entity based on which the firmware entity chose which low
> power mode to enter. It's nice to see that the logic is finally getting
> into a much more central part of the kernel PM.
>
> About this series itself, Kevin and I have been working to integrate a
> branch where we can have some platform specific support for the TI AM62L
> SoC along with this series applied on it on vendor kernel, but I think
> it should be good enough to test a proof of concept that we can finally
> do mode selection while using s2idle.
>
> So yeah - I was able to write some values into
> /dev/system_wakeup_latency and then see that before setting any value it
> picked the deepest idle-state in the DT. When I programmed some latency
> constraint into /dev/system_wakeup_latency then I could see that the
> cpuidle_enter_s2idle picked the shallower idle-state.
>
> These idle-states we had were modelling 2 different low power mode
> variants of suspend to RAM, and based on the different suspend-param
> that I recieved in the firmware (in this case TF-A via PSCI), I did the
> mode selection bits and switched between low power modes purely based on
> system_wakeup_latency. There's definitely more work to do, and I will
> continue to closely monitor the next revisions of this series as well,
> so please feel free to include me in To/CC.

Thanks a lot for sharing your feedback and for confirming your
test-results, great news!

I will certainly cc you when I post the next revision!

Kind regards
Uffe

>
> [1] https://lore.kernel.org/linux-pm/20241206-lpm-v6-10-constraints-pmdom=
ain-v6-1-833980158c68@baylibre.com/
>
> --
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated

