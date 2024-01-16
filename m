Return-Path: <linux-pm+bounces-2261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75F82FDD4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA511F26EDA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85367C6B;
	Tue, 16 Jan 2024 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdYqvvKN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CE67C5E
	for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448916; cv=none; b=M+p3KEZ7BmNj9Il3A20OYz8kiqW/QtzQCGdIF0BTfSl3JP6roNfoPWCh3oxkqDzggUykIIe1Vr6M0Ccs4uTl4FvpG7NGni29MhHek9+xO1DckGpJlG2Hx3LIt1j0x89DAtEImV1/FVYFs1Jw/KjsUZdNX3D+cbWjVpaWEMgP3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448916; c=relaxed/simple;
	bh=O8Kq4uPVWRZlnIMs1LFsvejHjua+7vRBykNcj6Vhcqo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=olP4eZQKECsu+zFdlV/mtNkN7NNY0UOpJpDE+f+Pb+b0hi9Q8NoZuB4JH5qq+d6CWmSRupp/RxvAgPGOUW3/78l89iTuULp+na1pxY9KP5ETJRCRX18uNAKeLpzVeTC0oHj/iqAiDjyDf/HkF+YD7zEBD4G9uqEgqcmrmTYlzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdYqvvKN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4298fa85baeso53871cf.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2024 15:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705448914; x=1706053714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcX6td37QRw3Q78lq9NLHvuhZmpzzW+P43xh6D/Stls=;
        b=YdYqvvKNHRTH0X/2vu0U5CkdwRnoWjDeDO9Evet+PiaE7PQPnh0lEIkDgbTwc41OkM
         al+iwravePihA9SjBZPRJ/9TsmgDORoA4vJbCLz36bNS2GBFkVKHWkE4D0I7T88yECc4
         Mnxq1ZVxhpm3EIdis0d74KuKXCW08AagpCwL/PQ3kvqqK+triz0vVLWR6ttY+Dm01WQ/
         WkBux7YfV9U718Cxx1Sywpa/glejtvh+hVIOdR9CCHwIZSYKyKge5lc4g0rnL18Lxc9Y
         9pflwdwI+ZH2TYR+JT4gmm8tLlgr7xHfoVMJiPo9NVPG31Qz4IoQkP40jBvmP4P1R+jR
         guLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705448914; x=1706053714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcX6td37QRw3Q78lq9NLHvuhZmpzzW+P43xh6D/Stls=;
        b=BojuohkXokNlEGMy9MY3AYXBSIsAHUyAHgtyMaNd2gDQTHDTS8xltvHtRJ3H/bdD63
         WquItdcaOLsb67eGqryZBuYR5Wk6Hy+m+R4wmrFGLotOtIHvova7qAkPRZN1gMVoOJEW
         3oBfNTyYYvCMDCsYdwDGp6B4VCO+gGTCklfAuZPpzLEbsVAQAAQBNSmBROBSTjQke0sB
         nAQlObvwtJer5YnNonYw9agIwHoNTALD5GsckTTov0lP3uKDdkeowC8L085Z+cdFPIGI
         r5kIsxhAOKJRFJ2LpuhSoGA++8/OEPmFLis5bb+y0B4adaBiMOAXiQFcMenIhxPNYxf5
         lUxA==
X-Gm-Message-State: AOJu0YwmAdT+BkXuNfTRpVA1UMYWjrWrM3El4McJBIyT2TFTHCBvmePx
	IpPgFgrDzQaZiPfTNOXrfkVgOoC7LFkuGTifbGWsQwHYcTv/XmfSe10OQkc3XH5NpnNcxavpCUf
	Vrn3N64swlR5wF3C8gjL9zEava2DIRFMhGxpb
X-Google-Smtp-Source: AGHT+IF175+Y4Kli2T3zqhJiGB1qrctLtKv0qPENb4TsBh8AoPaduA173aWAazUv/IITNOQLJimNwyj4KFTx/iHL+2o=
X-Received: by 2002:a05:622a:1dc6:b0:429:b532:5075 with SMTP id
 bn6-20020a05622a1dc600b00429b5325075mr51787qtb.22.1705448913924; Tue, 16 Jan
 2024 15:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-2-davidai@google.com>
 <865y231jvj.wl-maz@kernel.org> <CAGETcx9-n0z5buWgtLZ+6VxW2jEko1GWzkGtGhFiZEq-x_G4nw@mail.gmail.com>
 <867clpaxel.wl-maz@kernel.org> <CAGETcx_8x4p7WTwqQiVGdtHftVjFUJruXsOXwJXgDi0GdEtLNA@mail.gmail.com>
 <86zfx98tgi.wl-maz@kernel.org>
In-Reply-To: <86zfx98tgi.wl-maz@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 16 Jan 2024 15:47:57 -0800
Message-ID: <CAGETcx-sYUAE-Pgnf20ZXR_9WJOZ5FqksL=8i8+9PCLLazy54w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: Marc Zyngier <maz@kernel.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 1:37=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 12 Jan 2024 22:02:39 +0000,
> Saravana Kannan <saravanak@google.com> wrote:
> >
> > Sorry for the delay in response. Was very busy for a while and then
> > holidays started.
> >
> > On Fri, Dec 8, 2023 at 12:52=E2=80=AFAM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > On Thu, 07 Dec 2023 22:44:36 +0000,
> > > Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Wed, Nov 15, 2023 at 12:49=E2=80=AFAM Marc Zyngier <maz@kernel.o=
rg> wrote:
> > > > >
> > > > > On Sat, 11 Nov 2023 01:49:29 +0000,
> > > > > David Dai <davidai@google.com> wrote:
> > > > > >
> > > > > > Adding bindings to represent a virtual cpufreq device.
> > > > > >
> > > > > > Virtual machines may expose MMIO regions for a virtual cpufreq =
device
> > > > > > for guests to read frequency information or to request frequenc=
y
> > > > > > selection. The virtual cpufreq device has an individual control=
ler for
> > > > > > each frequency domain.
> > > > >
> > > > > I would really refrain form having absolute frequencies here. A
> > > > > virtual machine can be migrated, and there are *zero* guarantees =
that
> > > > > the target system has the same clock range as the source.
> > > > >
> > > > > This really should be a relative number, much like the capacity. =
That,
> > > > > at least, can be migrated across systems.
> > > >
> > > > There's nothing in this patch that mandates absolute frequency.
> > > > In true KVM philosophy, we leave it to the VMM to decide.
> > >
> > > This has nothing to do with KVM. It would apply to any execution
> > > environment, including QEMU in TCG mode.
> > >
> > > To quote the original patch:
> > >
> > > +    description:
> > > +      Address and size of region containing frequency controls for e=
ach of the
> > > +      frequency domains. Regions for each frequency domain is placed
> > > +      contiugously and contain registers for controlling DVFS(Dynami=
c Frequency
> > > +      and Voltage) characteristics. The size of the region is propor=
tional to
> > > +      total number of frequency domains.
> > >
> > > What part of that indicates that *relative* frequencies are
> > > acceptable? The example explicitly uses the opp-v2 binding, which
> > > clearly is about absolute frequency.
> >
> > We can update the doc to make that clearer and update the example too.
> >
> > > To reiterate: absolute frequencies are not the right tool for the job=
,
> > > and they should explicitly be described as relative in the spec. Not
> > > left as a "whatev'" option for the execution environment to interpret=
.
> >
> > I think it depends on the use case. If there's no plan to migrate the
> > VM across different devices, there's no need to do the unnecessary
> > normalization back and forth.
>
> VM migration is a given, specially when QEMU is involved. Designing
> something that doesn't support it is a bug, plain and simple.

I'm not saying this patch series doesn't allow migrating. I'm just
pointing out that normalization might not always be worth it for a VMM
to do.

We'll update the example and documentation to used normalize values.
CPUfreq itself used KHz for the tables and we can't really change that
when we are emulating CPU freq scaling. Same goes for OPP table DT
property names.

But the values we use can be 0 to 1024 Hz and be normalized.

> > And if we can translate between pCPU frequency and a normalized
> > frequency, we can do the same for whatever made up frequencies too. In
> > fact, we plan to do exactly that in our internal use cases for this.
> > There's nothing here that prevents the VMM from doing that.
> >
> > Also, if there are hardware virtualized performance counters (AMU,
> > CPPC, etc) that are used for frequency normalization, then we have to
> > use the real frequencies in those devices otherwise the "current
> > frequency" can be 2 GHz while the max normalized frequency is 1024
> > KHz. That'll mess up load tracking.
>
> And that's exactly why this shouldn't be a *frequency*, but a
> performance scale or some other unit-less coefficient. Just like the
> big-little capacity.

Sorry I wasn't cleared in my explanation. Let me explain it better.
When performance counters are available, the scheduler uses them to
compute the current average CPU frequency over a scheduler tick. It
looks at the performance counters to figure out how many CPU cycles
have gone by and how much time has gone by and does (delta cycles /
delta seconds) to compute current CPU freq in Hz. So, when a HW
virtualized performance counter is available, and the scheduler inside
the VM uses it to compute the average CPU frequency, the resulting
frequency is going to be the real physical CPU frequency. And the CPU
frequency value the scheduler used to compute the PELT load will be
completely different from the normalized values and the load tracking
will be completely wrong.

Using their performance counters inside the VM reduces a lot of MMIO
access exits to the host or memory accesses. So it makes sense a VM
might want to use that. I was just trying to say that in that
situation, a VMM might have a good reason to just use the real
frequencies inside the VM too.

In any case, we can update the doc to use normalized values/examples
and call out this caveat.

Thanks,
Saravana

