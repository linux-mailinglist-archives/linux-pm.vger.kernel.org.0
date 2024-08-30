Return-Path: <linux-pm+bounces-13271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A881B966CBB
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 00:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8761C2201C
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F918C91F;
	Fri, 30 Aug 2024 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+JOF9gW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FA165F0B
	for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058334; cv=none; b=q+wKxs7Vk0+GfEaQW3Xx9y9KTrp8HuWavRAZMId+NFe3os/E+rj8lmhfufxWyB6k+o+4J9rrieXS83GWWdssruI3Kr2L0Gui3k+T43Z/zSmgCbdF6hWATEHu37we1QM+vnUO7/lz8bOz2CUKQ5sUPUhw+ya/lUE7O4H1CH4+Xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058334; c=relaxed/simple;
	bh=gxOxhYBDbajQXeDcm4+m410j7vqMfY9SlJyavj7ERpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HppoM6HkmKtpHYlD4Z/71JiaIsykST/q5Qt8yllkbvCan+LUBPIeApAGu8xe356xc2+BeRSj1zAZrDs/9qII7NR5pa7FgjYTPOQFxpdJ27VEUqb29yLJR7yh0aVYKh2atXL/aVlrKC6m8Si1L81J0MvLslqKeIUT08WyqsoyX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+JOF9gW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c2443b2581so2134a12.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725058329; x=1725663129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH9IXkuD7yeaJ2XxyqB5qRHFsRijGF7vwxcwESC9IPc=;
        b=t+JOF9gWayqvsa7RY/nLmJLqTSFW2bED9JGrDP+ol0XF/5hZ87kC8Fw+55Sv5g0c66
         BJMZhBiSfWtuxo3Qv2wIgKHgpAyK49qzbC52a1IQnoObwXf5FhzSMTWsmponCnk20oeW
         Q9VrOk8L0PhBae6F29P53cqGdnCuN+rycqEYpsjlp7SzcA+kAkHB837iDu2SQzS/vP4C
         KWJ+/HVUcbCkuiK7fqzw/E2A7KZBOeYegBJ3NkiUnCvJHT8VXGovoSbwSfdnLF7+TUsF
         Nh1d5OonCMy30uSrW2K2KIcFNZEN/DIRodusqX1zc2fuaj2kj/VfrwvDc0pyaFj4pt5u
         1ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725058329; x=1725663129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH9IXkuD7yeaJ2XxyqB5qRHFsRijGF7vwxcwESC9IPc=;
        b=dU4JFmcH+BbbV7hngHifQ0t1htvDgVpnIegYYKzAuf/Ea5eaRYnEgluTWckPAdSNkp
         KpZdtqRcSC8FXBhcUC8IW7sNAGR+SacunYc1Y+v6i4MVHQRfRqAf4KkAjvphBDu6P4Ks
         w+LNHYj0J+7OZl4YXg0KJ7fVnCXG2s6mqryI9eeCjp2djCP2SlIeDVULmwRC0Q0xSfCL
         8U4v1MPRikAi5nFcI8cx/Y9yWnhUEax1IebAOPMiULKT2ANOqKRav78jMfSz/vVf1UB4
         0649XLIRqK5Z27FPkFrtHpjMEmjLvFrBfOGNxPRAoZ/VE4exrmZlMPhq6KgyauA1rkUq
         e5vw==
X-Forwarded-Encrypted: i=1; AJvYcCVOXMMcqFFKdwnkN2F4bQSUl2I5PkDmqXzqOLwPrRqgWzC8BzKfDfyy0uogF6qijunRscNWIMr6kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKAy5s6fQdDOOYNe4VEObA97m1AQrFY+yhD6zgHu1SoIl4435
	mt2jZC+OQ0ohf+yevzmjWqiBQpqyjMZatt7eCougYZyI/M3udJG/J1eCoKuNuO9CeJDQUk6wsfK
	D+NdqpsVhRAQzaDLtoPs5oq/r4s4rHB3poWTI
X-Google-Smtp-Source: AGHT+IGopOqpvD2/VK6IZTdKr8pK7dF9i94/MKTfilLc6SgVH38AqvTz0xg5bG+cxlriW0ez3Ui9ngIcmvDO2Jgaf58=
X-Received: by 2002:a05:6402:2113:b0:5be:c28a:97cf with SMTP id
 4fb4d7f45d1cf-5c245b707camr26940a12.5.1725058328465; Fri, 30 Aug 2024
 15:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521043102.2786284-1-davidai@google.com> <20240521043102.2786284-3-davidai@google.com>
 <CABN1KCKirjdVxF7Mc38tToB9OKH3n2kdN6k1tJbC-cyUtsVAFA@mail.gmail.com>
 <CAJZ5v0jcZW92zm916VAD2a9_CMusuG-K968hWBS+tS1BL-Lspw@mail.gmail.com> <CAGETcx9jDaTcTu38s2WEmgWQaj=RSUvHMRQJLApa4b8z1_8vfQ@mail.gmail.com>
In-Reply-To: <CAGETcx9jDaTcTu38s2WEmgWQaj=RSUvHMRQJLApa4b8z1_8vfQ@mail.gmail.com>
From: David Dai <davidai@google.com>
Date: Fri, 30 Aug 2024 15:51:57 -0700
Message-ID: <CABN1KC+L=ag088FO5HxdbR4a_S5XNt3ipJ_0hq19jVPHw+fM6w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpufreq: add virtual-cpufreq driver
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:08=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Fri, Jun 28, 2024 at 5:01=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > Hi,
> >
> > On Thu, Jun 27, 2024 at 11:22=E2=80=AFPM David Dai <davidai@google.com>=
 wrote:
> > >
> > > Hi folks,
> > >
> > > Gentle nudge on this patch to see if there's any remaining concerns?
> >
> > Yes, there are.
> >
> > The dependency of OF is pretty much a no-go from my perspective.
>
> If you are talking about the "depends on OF" I think that can and
> should be dropped.
>
> There's nothing really OF specific about this driver except the probe
> function being for a platform device/driver. We can easily write an
> ACPI driver variant of the probe function and have the same driver
> work for both OF and ACPI versions of the device. We don't have any
> ACPI experience or a test set up to test the ACPI variant. That's why
> we haven't added it. We are more than happy to accept tested patches
> on top of this that'll enable this for ACPI variants too.
>
> If we drop the "depends on OF", will you accept this patch? If not,
> can you give some guidance on what you are looking for?

Hi Rafael,

Just wanted to follow up and see what your thoughts are on this?

Thanks,
David

>
> Thanks,
> Saravana
>
>
>
>
> >
> > Thanks!
> >
> >
> > > On Mon, May 20, 2024 at 10:32=E2=80=AFPM David Dai <davidai@google.co=
m> wrote:
> > > >
> > > > Introduce a virtualized cpufreq driver for guest kernels to improve
> > > > performance and power of workloads within VMs.
> > > >
> > > > This driver does two main things:
> > > >
> > > > 1. Sends the frequency of vCPUs as a hint to the host. The host use=
s the
> > > > hint to schedule the vCPU threads and decide physical CPU frequency=
.
> > > >
> > > > 2. If a VM does not support a virtualized FIE(like AMUs), it querie=
s the
> > > > host CPU frequency by reading a MMIO region of a virtual cpufreq de=
vice
> > > > to update the guest's frequency scaling factor periodically. This e=
nables
> > > > accurate Per-Entity Load Tracking for tasks running in the guest.
> > > >
> > > > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: David Dai <davidai@google.com>
> > > > ---
> > > >  drivers/cpufreq/Kconfig           |  14 ++
> > > >  drivers/cpufreq/Makefile          |   1 +
> > > >  drivers/cpufreq/virtual-cpufreq.c | 335 ++++++++++++++++++++++++++=
++++
> > > >  include/linux/arch_topology.h     |   1 +
> > > >  4 files changed, 351 insertions(+)
> > > >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
> > > >
> > > > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > > > index 94e55c40970a..9aa86bec5793 100644
> > > > --- a/drivers/cpufreq/Kconfig
> > > > +++ b/drivers/cpufreq/Kconfig
> > > > @@ -217,6 +217,20 @@ config CPUFREQ_DT
> > > >
> > > >           If in doubt, say N.
> > > >
> > > > +config CPUFREQ_VIRT
> > > > +       tristate "Virtual cpufreq driver"
> > > > +       depends on OF && GENERIC_ARCH_TOPOLOGY
> > > > +       help
> > > > +         This adds a virtualized cpufreq driver for guest kernels =
that
> > > > +         read/writes to a MMIO region for a virtualized cpufreq de=
vice to
> > > > +         communicate with the host. It sends performance requests =
to the host
> > > > +         which gets used as a hint to schedule vCPU threads and se=
lect CPU
> > > > +         frequency. If a VM does not support a virtualized FIE suc=
h as AMUs,
> > > > +         it updates the frequency scaling factor by polling host C=
PU frequency
> > > > +         to enable accurate Per-Entity Load Tracking for tasks run=
ning in the guest.
> > > > +
> > > > +         If in doubt, say N.
> > > > +
> > > >  config CPUFREQ_DT_PLATDEV
> > > >         tristate "Generic DT based cpufreq platdev driver"
> > > >         depends on OF
> > > > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > > > index 8d141c71b016..eb72ecdc24db 100644
> > > > --- a/drivers/cpufreq/Makefile
> > > > +++ b/drivers/cpufreq/Makefile
> > > > @@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)   +=3D cpufre=
q_governor_attr_set.o
> > > >
> > > >  obj-$(CONFIG_CPUFREQ_DT)               +=3D cpufreq-dt.o
> > > >  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       +=3D cpufreq-dt-platdev.o
> > > > +obj-$(CONFIG_CPUFREQ_VIRT)             +=3D virtual-cpufreq.o
> > > >
> > > >  # Traces
> > > >  CFLAGS_amd-pstate-trace.o               :=3D -I$(src)
> > > > diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/vi=
rtual-cpufreq.c
> > > > new file mode 100644
> > > > index 000000000000..59ce2bda3913
> > > > --- /dev/null
> > > > +++ b/drivers/cpufreq/virtual-cpufreq.c
> > > > @@ -0,0 +1,335 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (C) 2024 Google LLC
> > > > + */
> > > > +
> > > > +#include <linux/arch_topology.h>
> > > > +#include <linux/cpufreq.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/sched.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +/*
> > > > + * CPU0..CPUn
> > > > + * +-------------+-------------------------------+--------+-------=
+
> > > > + * | Register    | Description                   | Offset |   Len =
|
> > > > + * +-------------+-------------------------------+--------+-------=
+
> > > > + * | cur_perf    | read this register to get     |    0x0 |   0x4 =
|
> > > > + * |             | the current perf (integer val |        |       =
|
> > > > + * |             | representing perf relative to |        |       =
|
> > > > + * |             | max performance)              |        |       =
|
> > > > + * |             | that vCPU is running at       |        |       =
|
> > > > + * +-------------+-------------------------------+--------+-------=
+
> > > > + * | set_perf    | write to this register to set |    0x4 |   0x4 =
|
> > > > + * |             | perf value of the vCPU        |        |       =
|
> > > > + * +-------------+-------------------------------+--------+-------=
+
> > > > + * | perftbl_len | number of entries in perf     |    0x8 |   0x4 =
|
> > > > + * |             | table. A single entry in the  |        |       =
|
> > > > + * |             | perf table denotes no table   |        |       =
|
> > > > + * |             | and the entry contains        |        |       =
|
> > > > + * |             | the maximum perf value        |        |       =
|
> > > > + * |             | that this vCPU supports.      |        |       =
|
> > > > + * |             | The guest can request any     |        |       =
|
> > > > + * |             | value between 1 and max perf  |        |       =
|
> > > > + * |             | when perftbls are not used.   |        |       =
|
> > > > + * +---------------------------------------------+--------+-------=
+
> > > > + * | perftbl_sel | write to this register to     |    0xc |   0x4 =
|
> > > > + * |             | select perf table entry to    |        |       =
|
> > > > + * |             | read from                     |        |       =
|
> > > > + * +---------------------------------------------+--------+-------=
+
> > > > + * | perftbl_rd  | read this register to get     |   0x10 |   0x4 =
|
> > > > + * |             | perf value of the selected    |        |       =
|
> > > > + * |             | entry based on perftbl_sel    |        |       =
|
> > > > + * +---------------------------------------------+--------+-------=
+
> > > > + * | perf_domain | performance domain number     |   0x14 |   0x4 =
|
> > > > + * |             | that this vCPU belongs to.    |        |       =
|
> > > > + * |             | vCPUs sharing the same perf   |        |       =
|
> > > > + * |             | domain number are part of the |        |       =
|
> > > > + * |             | same performance domain.      |        |       =
|
> > > > + * +-------------+-------------------------------+--------+-------=
+
> > > > + */
> > > > +
> > > > +#define REG_CUR_PERF_STATE_OFFSET 0x0
> > > > +#define REG_SET_PERF_STATE_OFFSET 0x4
> > > > +#define REG_PERFTBL_LEN_OFFSET 0x8
> > > > +#define REG_PERFTBL_SEL_OFFSET 0xc
> > > > +#define REG_PERFTBL_RD_OFFSET 0x10
> > > > +#define REG_PERF_DOMAIN_OFFSET 0x14
> > > > +#define PER_CPU_OFFSET 0x1000
> > > > +
> > > > +#define PERFTBL_MAX_ENTRIES 64U
> > > > +
> > > > +static void __iomem *base;
> > > > +static DEFINE_PER_CPU(u32, perftbl_num_entries);
> > > > +
> > > > +static void virt_scale_freq_tick(void)
> > > > +{
> > > > +       int cpu =3D smp_processor_id();
> > > > +       u32 max_freq =3D (u32)cpufreq_get_hw_max_freq(cpu);
> > > > +       u64 cur_freq;
> > > > +       unsigned long scale;
> > > > +
> > > > +       cur_freq =3D (u64)readl_relaxed(base + cpu * PER_CPU_OFFSET
> > > > +                       + REG_CUR_PERF_STATE_OFFSET);
> > > > +
> > > > +       cur_freq <<=3D SCHED_CAPACITY_SHIFT;
> > > > +       scale =3D (unsigned long)div_u64(cur_freq, max_freq);
> > > > +       scale =3D min(scale, SCHED_CAPACITY_SCALE);
> > > > +
> > > > +       this_cpu_write(arch_freq_scale, scale);
> > > > +}
> > > > +
> > > > +static struct scale_freq_data virt_sfd =3D {
> > > > +       .source =3D SCALE_FREQ_SOURCE_VIRT,
> > > > +       .set_freq_scale =3D virt_scale_freq_tick,
> > > > +};
> > > > +
> > > > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *p=
olicy,
> > > > +                                         unsigned int target_freq)
> > > > +{
> > > > +       writel_relaxed(target_freq,
> > > > +                      base + policy->cpu * PER_CPU_OFFSET + REG_SE=
T_PERF_STATE_OFFSET);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy=
 *policy,
> > > > +                                            unsigned int target_fr=
eq)
> > > > +{
> > > > +       virt_cpufreq_set_perf(policy, target_freq);
> > > > +       return target_freq;
> > > > +}
> > > > +
> > > > +static u32 virt_cpufreq_get_perftbl_entry(int cpu, u32 idx)
> > > > +{
> > > > +       writel_relaxed(idx, base + cpu * PER_CPU_OFFSET +
> > > > +                      REG_PERFTBL_SEL_OFFSET);
> > > > +       return readl_relaxed(base + cpu * PER_CPU_OFFSET +
> > > > +                            REG_PERFTBL_RD_OFFSET);
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_target(struct cpufreq_policy *policy,
> > > > +                              unsigned int target_freq,
> > > > +                              unsigned int relation)
> > > > +{
> > > > +       struct cpufreq_freqs freqs;
> > > > +       int ret =3D 0;
> > > > +
> > > > +       freqs.old =3D policy->cur;
> > > > +       freqs.new =3D target_freq;
> > > > +
> > > > +       cpufreq_freq_transition_begin(policy, &freqs);
> > > > +       ret =3D virt_cpufreq_set_perf(policy, target_freq);
> > > > +       cpufreq_freq_transition_end(policy, &freqs, ret !=3D 0);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *po=
licy)
> > > > +{
> > > > +       u32 cur_perf_domain, perf_domain;
> > > > +       struct device *cpu_dev;
> > > > +       int cpu;
> > > > +
> > > > +       cur_perf_domain =3D readl_relaxed(base + policy->cpu *
> > > > +                                       PER_CPU_OFFSET + REG_PERF_D=
OMAIN_OFFSET);
> > > > +
> > > > +       for_each_possible_cpu(cpu) {
> > > > +               cpu_dev =3D get_cpu_device(cpu);
> > > > +               if (!cpu_dev)
> > > > +                       continue;
> > > > +
> > > > +               perf_domain =3D readl_relaxed(base + cpu *
> > > > +                                           PER_CPU_OFFSET + REG_PE=
RF_DOMAIN_OFFSET);
> > > > +
> > > > +               if (perf_domain =3D=3D cur_perf_domain)
> > > > +                       cpumask_set_cpu(cpu, policy->cpus);
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_get_freq_info(struct cpufreq_policy *polic=
y)
> > > > +{
> > > > +       struct cpufreq_frequency_table *table;
> > > > +       u32 num_perftbl_entries, idx;
> > > > +
> > > > +       num_perftbl_entries =3D per_cpu(perftbl_num_entries, policy=
->cpu);
> > > > +
> > > > +       if (num_perftbl_entries =3D=3D 1) {
> > > > +               policy->cpuinfo.min_freq =3D 1;
> > > > +               policy->cpuinfo.max_freq =3D virt_cpufreq_get_perft=
bl_entry(policy->cpu, 0);
> > > > +
> > > > +               policy->min =3D policy->cpuinfo.min_freq;
> > > > +               policy->max =3D policy->cpuinfo.max_freq;
> > > > +
> > > > +               policy->cur =3D policy->max;
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       table =3D kcalloc(num_perftbl_entries + 1, sizeof(*table), =
GFP_KERNEL);
> > > > +       if (!table)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       for (idx =3D 0; idx < num_perftbl_entries; idx++)
> > > > +               table[idx].frequency =3D virt_cpufreq_get_perftbl_e=
ntry(policy->cpu, idx);
> > > > +
> > > > +       table[idx].frequency =3D CPUFREQ_TABLE_END;
> > > > +       policy->freq_table =3D table;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > > +{
> > > > +       struct device *cpu_dev;
> > > > +       int ret;
> > > > +
> > > > +       cpu_dev =3D get_cpu_device(policy->cpu);
> > > > +       if (!cpu_dev)
> > > > +               return -ENODEV;
> > > > +
> > > > +       ret =3D virt_cpufreq_get_freq_info(policy);
> > > > +       if (ret) {
> > > > +               dev_warn(cpu_dev, "failed to get cpufreq info\n");
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       ret =3D virt_cpufreq_get_sharing_cpus(policy);
> > > > +       if (ret) {
> > > > +               dev_warn(cpu_dev, "failed to get sharing cpumask\n"=
);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * To simplify and improve latency of handling frequency re=
quests on
> > > > +        * the host side, this ensures that the vCPU thread trigger=
ing the MMIO
> > > > +        * abort is the same thread whose performance constraints (=
Ex. uclamp
> > > > +        * settings) need to be updated. This simplifies the VMM (V=
irtual
> > > > +        * Machine Manager) having to find the correct vCPU thread =
and/or
> > > > +        * facing permission issues when configuring other threads.
> > > > +        */
> > > > +       policy->dvfs_possible_from_any_cpu =3D false;
> > > > +       policy->fast_switch_possible =3D true;
> > > > +
> > > > +       /*
> > > > +        * Using the default SCALE_FREQ_SOURCE_CPUFREQ is insuffici=
ent since
> > > > +        * the actual physical CPU frequency may not match requeste=
d frequency
> > > > +        * from the vCPU thread due to frequency update latencies o=
r other
> > > > +        * inputs to the physical CPU frequency selection. This add=
itional FIE
> > > > +        * source allows for more accurate freq_scale updates and o=
nly takes
> > > > +        * effect if another FIE source such as AMUs have not been =
registered.
> > > > +        */
> > > > +       topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > > > +{
> > > > +       topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, po=
licy->related_cpus);
> > > > +       kfree(policy->freq_table);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_online(struct cpufreq_policy *policy)
> > > > +{
> > > > +       /* Nothing to restore. */
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_offline(struct cpufreq_policy *policy)
> > > > +{
> > > > +       /* Dummy offline() to avoid exit() being called and freeing=
 resources. */
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *=
policy)
> > > > +{
> > > > +       if (policy->freq_table)
> > > > +               return cpufreq_frequency_table_verify(policy, polic=
y->freq_table);
> > > > +
> > > > +       cpufreq_verify_within_cpu_limits(policy);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static struct cpufreq_driver cpufreq_virt_driver =3D {
> > > > +       .name           =3D "virt-cpufreq",
> > > > +       .init           =3D virt_cpufreq_cpu_init,
> > > > +       .exit           =3D virt_cpufreq_cpu_exit,
> > > > +       .online         =3D virt_cpufreq_online,
> > > > +       .offline        =3D virt_cpufreq_offline,
> > > > +       .verify         =3D virt_cpufreq_verify_policy,
> > > > +       .target         =3D virt_cpufreq_target,
> > > > +       .fast_switch    =3D virt_cpufreq_fast_switch,
> > > > +       .attr           =3D cpufreq_generic_attr,
> > > > +};
> > > > +
> > > > +static int virt_cpufreq_driver_probe(struct platform_device *pdev)
> > > > +{
> > > > +       u32 num_perftbl_entries;
> > > > +       int ret, cpu;
> > > > +
> > > > +       base =3D devm_platform_ioremap_resource(pdev, 0);
> > > > +       if (IS_ERR(base))
> > > > +               return PTR_ERR(base);
> > > > +
> > > > +       for_each_possible_cpu(cpu) {
> > > > +               num_perftbl_entries =3D readl_relaxed(base + cpu * =
PER_CPU_OFFSET +
> > > > +                                                   REG_PERFTBL_LEN=
_OFFSET);
> > > > +
> > > > +               if (!num_perftbl_entries || num_perftbl_entries > P=
ERFTBL_MAX_ENTRIES)
> > > > +                       return -ENODEV;
> > > > +
> > > > +               per_cpu(perftbl_num_entries, cpu) =3D num_perftbl_e=
ntries;
> > > > +       }
> > > > +
> > > > +       ret =3D cpufreq_register_driver(&cpufreq_virt_driver);
> > > > +       if (ret) {
> > > > +               dev_err(&pdev->dev, "Virtual CPUFreq driver failed =
to register: %d\n", ret);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n")=
;
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virt_cpufreq_driver_remove(struct platform_device *pdev=
)
> > > > +{
> > > > +       cpufreq_unregister_driver(&cpufreq_virt_driver);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id virt_cpufreq_match[] =3D {
> > > > +       { .compatible =3D "qemu,virtual-cpufreq", .data =3D NULL},
> > > > +       {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
> > > > +
> > > > +static struct platform_driver virt_cpufreq_driver =3D {
> > > > +       .probe =3D virt_cpufreq_driver_probe,
> > > > +       .remove =3D virt_cpufreq_driver_remove,
> > > > +       .driver =3D {
> > > > +               .name =3D "virt-cpufreq",
> > > > +               .of_match_table =3D virt_cpufreq_match,
> > > > +       },
> > > > +};
> > > > +
> > > > +static int __init virt_cpufreq_init(void)
> > > > +{
> > > > +       return platform_driver_register(&virt_cpufreq_driver);
> > > > +}
> > > > +postcore_initcall(virt_cpufreq_init);
> > > > +
> > > > +static void __exit virt_cpufreq_exit(void)
> > > > +{
> > > > +       platform_driver_unregister(&virt_cpufreq_driver);
> > > > +}
> > > > +module_exit(virt_cpufreq_exit);
> > > > +
> > > > +MODULE_DESCRIPTION("Virtual cpufreq driver");
> > > > +MODULE_LICENSE("GPL");
> > > > diff --git a/include/linux/arch_topology.h b/include/linux/arch_top=
ology.h
> > > > index b721f360d759..d5d848849408 100644
> > > > --- a/include/linux/arch_topology.h
> > > > +++ b/include/linux/arch_topology.h
> > > > @@ -49,6 +49,7 @@ enum scale_freq_source {
> > > >         SCALE_FREQ_SOURCE_CPUFREQ =3D 0,
> > > >         SCALE_FREQ_SOURCE_ARCH,
> > > >         SCALE_FREQ_SOURCE_CPPC,
> > > > +       SCALE_FREQ_SOURCE_VIRT,
> > > >  };
> > > >
> > > >  struct scale_freq_data {
> > > > --
> > > > 2.45.0.215.g3402c0e53f-goog
> > > >
> > >

