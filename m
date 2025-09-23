Return-Path: <linux-pm+bounces-35204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B9B954BD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 11:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A062166A9B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42DB320A1B;
	Tue, 23 Sep 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLb4qUz1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5655320A30
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620562; cv=none; b=aDnuFDtQR+o8CoG/QCPcl+GZfHKB3SPY7F0VkqPOvhTCKh+i6BdsFEVc5mMtwsco+1IY4L/WqUF1R42CCRFEXjQn+xWW9AF0P4AejtZ674xMVjjJ/AchS97KPW5V7NwvxXLtYxuUx1P1cE20qkVvY/tsi+fTAjKlZixeKEePDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620562; c=relaxed/simple;
	bh=LJh2If2MchdmxGnd8rAzRTloWNZErUv1X/OtUMsKCbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlC40/2JCTRiEgqOE8j4fEcjrCWEw5BAvQrvb5ByfOMNA99rftCg+Cb0K49SOWEDDAhwQEXr7KLUPRH7iesGZ9Bb2L1LkK+9OAGuHeHdOpUSwvEGzEs5e/kCvX8b7kJYWjpuQ3IrlANgk0qLtKqa+ho3Mt5Jf5i111Fw9lMpYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dLb4qUz1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6051aeafso39478607b3.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758620560; x=1759225360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBf5dPAZ1k95rbY/wT/m6RJuOqwkl+3i015BswbjsMM=;
        b=dLb4qUz1G6CpAuIeBmsoOK8CYTvyL2T6jxnj2yTZgIR3kHAZHSztqFuB7J2/d0onlT
         8To2CBxTG7c72/64Y8bm6rP3YLcNCXSsghvI6+h/N9k1nE+6MjBDwqZwRoLZ/JNhOi/u
         qSEghrRVvaEK2Lw0cvnipqupMbvzUOtVVryfIpxY7SmyULb76hjAimbooFGsPuzGp59Y
         BTDdyqlkKyvB9526wjTi/6jWuzaEalP6BxA7P6j1EmG1laTVGanH6xV/t11qpXZ8MGYZ
         MHzpnzMCZ2T/Mk0HzIdq2HXoEA/G8b+pTHirsv5uyaEjAm3yoZ5BLhBSYM6PSugwQFLr
         sHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620560; x=1759225360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBf5dPAZ1k95rbY/wT/m6RJuOqwkl+3i015BswbjsMM=;
        b=D5U5iFNXsu6bzNkX65GrMfXQI5OKTgT8UCg8hF4HDOHhJSfRJuJzHHziqiJ3/z0O3+
         En+4ryB1xuHYMbIfz2OdjnkN6iLeH6p7Litk0WoaHngWfAULKVnk7KRVcQdA9UWlrFhT
         7z8+WOI+acy83q11pkWGmoVTz4qDJBdDsvdWWFiTYhOmAikJ07+xbXUhXyTpjb+2VHIS
         mOOgceEGqwHI9LfHAy/t1jQ+9pE/RFv49QD/rSQI3WBfUcDRosd8ub8XFVUF4CJJ8CUB
         nTvYNWn++owsHeGtIk14SrYcFA9YPdKS69Sip5zYT5YIABRLmNm0nohVQuVxugFU5NhO
         qErQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnyE4tpE6k7dZXxeGSiklXhUs97DPyuNZuclkWlUW8PqTZf/AJje0dmErQZ9isJWqqZiQFMtUUgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJzR9eivP/uwQCt5eevjcySBS9bU9zN3o/ijnvsoseiVYuPK6
	nLoregh7VqGeOYYOIuq4M7FTiHhm7n4ilby6eRPApzfvsQBZJslp7cXxiQAjbZOCexmrdj311P6
	BZIxPVerrm7DRLT7XFMbkLny9ByFe+rfpympumCNKfw==
X-Gm-Gg: ASbGncs8nAnW4F+6fLF2T5ObXC8L0cD1SprrItlI3IKZej02O8BAKGxB9tZVEJFDOrO
	1vm03ShLzhxgv3kBqpdchpCWsDsMwwtrgqyRF80DrEF0FGCpurtJSIDL9qW49+55tkAxfn7vhRX
	VP0dByTxH5Tzo0n+hAA2wVENVhgr0WH2LF5OVoq770CSMUI0usF2vjidzRkyJXfbwMZ/SoTn79W
	avfILW3
X-Google-Smtp-Source: AGHT+IGy593JemuMM1I70KsGFXsfGAGV1EfuzKSIj9FL9JT27HHuI0dWec+BvgRAJZFgUw4mOcu8TmvMufj8Lq9uJM4=
X-Received: by 2002:a05:690c:6c91:b0:725:1bc6:7cae with SMTP id
 00721157ae682-758a43264a8mr16591947b3.41.1758620559630; Tue, 23 Sep 2025
 02:42:39 -0700 (PDT)
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
 <CAPDyKFqG=bFSP2rJ3PXt5=6_nLdpJ+ir80krU1DrRCCMhwKQng@mail.gmail.com> <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hYN5G_WpA6KDpeDgowc2i9AvrUBCq-egS==8RNVb6N=w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 11:42:03 +0200
X-Gm-Features: AS18NWCNpnsclJ3h9JzbEU8K86EvApkR4GFpCQmgzmDXuhk39USXLKZzr5dFQac
Message-ID: <CAPDyKFr0-yh8wt169QanAo3AmuXBq_9p3xiiqeFmmWz-ntNQsw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Sept 2025 at 20:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 18, 2025 at 5:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 17 Sept 2025 at 21:24, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > >
> > > Hi,
> > >
> > > Sorry for the delay.
> > >
> > > On Fri, Sep 12, 2025 at 3:58=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Tue, 12 Aug 2025 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
> > > > >
> > > > > On Mon, 11 Aug 2025 at 21:16, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Mon, Aug 11, 2025 at 7:16=E2=80=AFPM Kevin Hilman <khilman@b=
aylibre.com> wrote:
> > > > > > >
> > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > > > > > >
> > > > > > > > On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.ha=
nsson@linaro.org> wrote:
> > > > > > > >>
> > > > > > > >> Some platforms and devices supports multiple low-power-sta=
tes than can be
> > > > > > > >> used for system-wide suspend. Today these states are selec=
ted on per
> > > > > > > >> subsystem basis and in most cases it's the deepest possibl=
e state that
> > > > > > > >> becomes selected.
> > > > > > > >>
> > > > > > > >> For some use-cases this is a problem as it isn't suitable =
or even breaks
> > > > > > > >> the system-wakeup latency constraint, when we decide to en=
ter these deeper
> > > > > > > >> states during system-wide suspend.
> > > > > > > >>
> > > > > > > >> Therefore, let's introduce an interface for user-space, al=
lowing us to
> > > > > > > >> specify the system-wakeup QoS limit. Subsequent changes wi=
ll start taking
> > > > > > > >> into account the QoS limit.
> > > > > > > >
> > > > > > > > Well, this is not really a system-wakeup limit, but a CPU i=
dle state
> > > > > > > > latency limit for states entered in the last step of suspen=
d-to-idle.
> > > > > > > >
> > > > > > > > It looks like the problem is that the existing CPU latency =
QoS is not
> > > > > > > > taken into account by suspend-to-idle, so instead of adding=
 an
> > > > > > > > entirely new interface to overcome this, would it make sens=
e to add an
> > > > > > > > ioctl() to the existing one that would allow the user of it=
 to
> > > > > > > > indicate that the given request should also be respected by
> > > > > > > > suspend-to-idle?
> > > > > > > >
> > > > > > > > There are two basic reasons why I think so:
> > > > > > > > (1) The requests that you want to be respected by suspend-t=
o-idle
> > > > > > > > should also be respected by the regular "runtime" idle, or =
at least I
> > > > > > > > don't see a reason why it wouldn't be the case.
> > > > > > > > (2) The new interface introduced by this patch basically du=
plicates
> > > > > > > > the existing one.
> > > > > > >
> > > > > > > I also think that just using the existing /dev/cpu_dma_latenc=
y is the
> > > > > > > right approach here, and simply teaching s2idle to respect th=
is value.
> > > > > > >
> > > > > > > I'm curious about the need for a new ioctl() though.  Under w=
hat
> > > > > > > conditions do you want normal/runtime CPUidle to respect this=
 value and
> > > > > > > s2idle to not respect this value?
> > > > > >
> > > > > > In a typical PC environment s2idle is a replacement for ACPI S3=
 which
> > > > > > does not take any QoS constraints into account, so users may wa=
nt to
> > > > > > set QoS limits for run-time and then suspend with the expectati=
on that
> > > > > > QoS will not affect it.
> > > > >
> > > > > Yes, I agree. To me, these are orthogonal use-cases which could h=
ave
> > > > > different wakeup latency constraints.
> > > > >
> > > > > Adding an ioctl for /dev/cpu_dma_latency, as suggested by Rafael =
would
> > > > > allow this to be managed, I think.
> > > > >
> > > > > Although, I am not fully convinced yet that re-using
> > > > > /dev/cpu_dma_latency is the right path. The main reason is that I
> > > > > don't want us to limit the use-case to CPU latencies, but rather =
allow
> > > > > the QoS constraint to be system-wide for any type of device. For
> > > > > example, it could be used by storage drivers too (like NVMe, UFS,
> > > > > eMMC), as a way to understand what low power state to pick as sys=
tem
> > > > > wide suspend. If you have a closer look at patch2 [1] , I suggest=
 we
> > > > > extend the genpd-governor for *both* CPU-cluster-PM-domains and f=
or
> > > > > other PM-domains too.
> > > > >
> > > > > Interested to hear your thoughts around this.
> > > >
> > > > Hey, just wanted to see if you have managed to digest this and have
> > > > any possible further comment?
> > >
> > > The reason why I thought about reusing /dev/cpu_dma_latency is becaus=
e
> > > I think that the s2idle limit should also apply to cpuidle.  Of
> > > course, cpuidle may be limited further, but IMV it should observe the
> > > limit set on system suspend (it would be kind of inconsistent to allo=
w
> > > cpuidle to use deeper idle states than can be used by s2idle).
> >
> > Agreed!
> >
> > >
> > > I also don't think that having a per-CPU s2idle limit would be
> > > particularly useful (and it might be problematic).
> > >
> > > Now, it is not as straightforward as I thought because someone may
> > > want to set a more restrictive limit on cpuidle, in which case they
> > > would need to open the same special device file twice etc and that
> > > would be quite cumbersome.
> > >
> > > So in the end I think that what you did in the $subject patch is
> > > better, but I still would like it to also affect cpuidle.
> >
> > Okay. I will update the patches according to your suggestions!
> >
> > >
> > > And it needs to be made clear that this is a limit on the resume
> > > latency of one device.  Worst case, the system wakeup latency may be =
a
> > > sum of those limits if the devices in question are resumed
> > > sequentially, so in fact this is a limit on the contribution of a
> > > given device to the system wakeup latency.
> >
> > Indeed, that's a very good point! I will keep this in mind when
> > working on adding the documentation part.
>
> Well, this also means that using one limit for all of the different
> devices is not likely to be very practical because the goal is to save
> as much energy as reasonably possible in system suspend while
> respecting a global resume latency constraint at the same time.
>
> Using the same limit on a local contribution from each device to the
> combined latency is not likely to be effective here.  Rather, I'd
> expect that the best results can be achieved by setting different
> resume latency limits on different devices, depending on how much
> power they draw in each of their idle states and what the exit latency
> values for all of those states are.  In other words, this appears to
> be an optimization problem in which the resume latency limits for
> individual devices need to be chosen to satisfy the global resume
> latency constraint and minimize the total system power.

I am following your reasoning and I agree!

Perhaps we should start with extending the cpu_dma_latency with an
ioctl after all? This would allow userspace to specify constraints to
be applicable for system-wide-suspend (s2idle), but it would still be
limited for CPUs/CPU-clusters.

For other devices, we should probably explore the per device PM QoS
(pm_qos_latency_tolerance_us) instead. Currently the
pm_qos_latency_tolerance_us is used for "runtime_suspend", so perhaps
adding another per device sysfs file, like
"pm_qos_system_wakeup_latency_us",  that we can use for the
system-wide-wakeup latency constraint?

Would this make better sense, you think?

Kind regards
Uffe

