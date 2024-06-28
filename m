Return-Path: <linux-pm+bounces-10189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4891BE03
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A6A1C22E59
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C015688F;
	Fri, 28 Jun 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXrs8+YG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F3481A4;
	Fri, 28 Jun 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576090; cv=none; b=ruHqJBe1xEQEsbtcusuCO6hNC7DW9DucMjpjPJAaHuP3OIIa087b+7io6OVaRQBTHN1vSTeK1zjnbgrf9HthHgUmu2g7OhjUcRqttbjnMbZSDVEM76PIzasvGGjjgfRMyCYosygWOlaLI/88dJ8vdbsm6V3AhvuLjkbtEz1vQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576090; c=relaxed/simple;
	bh=VMyjQc9lKryMvC/ER78qHzHIcnmdWfJkcKWruIkpKXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hubaMpZ3BBuYy+XqPxOwXZVf46TCc8isifiTfhpGWB9BFRzf6NvuoVguX/dFroHCbI9hHsfghQUnJncQsuQ3cb7avs/ZqOGi+nWDAj7fdAqC41xRg+i7KYZz7Yb77eEp3Nkvqhs9vCpyAMCRsf7FUNqrJYDVCVNBPRaVlV4sLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXrs8+YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514DDC116B1;
	Fri, 28 Jun 2024 12:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719576089;
	bh=VMyjQc9lKryMvC/ER78qHzHIcnmdWfJkcKWruIkpKXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nXrs8+YGV1DSIyqZ9zRBoxbYlJ9QH+E8EhbJyg7pYADyRJXvd0iQSPuNb3mcmT9zm
	 STnWjjvjO2Bo/w+wpJsEmMz8doR4SEw8tpih3KJZsUoWyfFwJKDB53Aw/MANTcgXxk
	 aJ/lYnu25HYszrUm5W5ga9oOLHheZE001BHkmtw5/c5vEtlB8tUISnljWWbC3fXEcm
	 8ryjVJbKNUWZGxyaebuKYbzpqtPx/MNsCyTxMAPNNbRrqNCGUs0CVFceAQ6Qfg6uRE
	 IOxNIOCe0gRS5CG4h3DbcCsA8lyWzegSGPm1tCfGvdTKpA+b3uMEAz6+okDYqVSmma
	 FSMOGbCzSJ3Iw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25cd2b51fd3so63981fac.3;
        Fri, 28 Jun 2024 05:01:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW1XHHVtcSUSBdhPZfxLNNasV9eO3E1ur4ZIW0NebreZt6u+JnwKX5i78mxo6myU7KUKXz++Nae3aKTyw8EA3HrsEtQq9cbGb0bZnChplH56Db0+ZtDiqp9Lf2zltffGZq7I10EKcaZnnh/a/MqLp1gCjGK2jybZ+7szO9Cul/GdZR
X-Gm-Message-State: AOJu0YxrIpfvv15hd5HOjU9H54+/MGCbCYNENYPBF3zbOk74XSfMdbdb
	0buimPT8WofEJMHuMflISu7PDDWwQKm7hFRsUZPPmUpM579wmf3Ta4tS+0StFKDVgt6g8pBUHQu
	r20u2dOEeyBMIx0eglOjmjxmkRMg=
X-Google-Smtp-Source: AGHT+IH2CrKWflxwKdRBpyovQT+zWqXt3Wg+NVvCipmdXxWCJGbB8Go5ltCLkdr/Pq8LfODqfmsO3PDZZp95hesu0hE=
X-Received: by 2002:a05:6870:b623:b0:259:f03c:4e90 with SMTP id
 586e51a60fabf-25cf3fba001mr18044602fac.4.1719576088522; Fri, 28 Jun 2024
 05:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521043102.2786284-1-davidai@google.com> <20240521043102.2786284-3-davidai@google.com>
 <CABN1KCKirjdVxF7Mc38tToB9OKH3n2kdN6k1tJbC-cyUtsVAFA@mail.gmail.com>
In-Reply-To: <CABN1KCKirjdVxF7Mc38tToB9OKH3n2kdN6k1tJbC-cyUtsVAFA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 14:01:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcZW92zm916VAD2a9_CMusuG-K968hWBS+tS1BL-Lspw@mail.gmail.com>
Message-ID: <CAJZ5v0jcZW92zm916VAD2a9_CMusuG-K968hWBS+tS1BL-Lspw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpufreq: add virtual-cpufreq driver
To: David Dai <davidai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Saravana Kannan <saravanak@google.com>, 
	Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2024 at 11:22=E2=80=AFPM David Dai <davidai@google.com> wro=
te:
>
> Hi folks,
>
> Gentle nudge on this patch to see if there's any remaining concerns?

Yes, there are.

The dependency of OF is pretty much a no-go from my perspective.

Thanks!


> On Mon, May 20, 2024 at 10:32=E2=80=AFPM David Dai <davidai@google.com> w=
rote:
> >
> > Introduce a virtualized cpufreq driver for guest kernels to improve
> > performance and power of workloads within VMs.
> >
> > This driver does two main things:
> >
> > 1. Sends the frequency of vCPUs as a hint to the host. The host uses th=
e
> > hint to schedule the vCPU threads and decide physical CPU frequency.
> >
> > 2. If a VM does not support a virtualized FIE(like AMUs), it queries th=
e
> > host CPU frequency by reading a MMIO region of a virtual cpufreq device
> > to update the guest's frequency scaling factor periodically. This enabl=
es
> > accurate Per-Entity Load Tracking for tasks running in the guest.
> >
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: David Dai <davidai@google.com>
> > ---
> >  drivers/cpufreq/Kconfig           |  14 ++
> >  drivers/cpufreq/Makefile          |   1 +
> >  drivers/cpufreq/virtual-cpufreq.c | 335 ++++++++++++++++++++++++++++++
> >  include/linux/arch_topology.h     |   1 +
> >  4 files changed, 351 insertions(+)
> >  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
> >
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 94e55c40970a..9aa86bec5793 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -217,6 +217,20 @@ config CPUFREQ_DT
> >
> >           If in doubt, say N.
> >
> > +config CPUFREQ_VIRT
> > +       tristate "Virtual cpufreq driver"
> > +       depends on OF && GENERIC_ARCH_TOPOLOGY
> > +       help
> > +         This adds a virtualized cpufreq driver for guest kernels that
> > +         read/writes to a MMIO region for a virtualized cpufreq device=
 to
> > +         communicate with the host. It sends performance requests to t=
he host
> > +         which gets used as a hint to schedule vCPU threads and select=
 CPU
> > +         frequency. If a VM does not support a virtualized FIE such as=
 AMUs,
> > +         it updates the frequency scaling factor by polling host CPU f=
requency
> > +         to enable accurate Per-Entity Load Tracking for tasks running=
 in the guest.
> > +
> > +         If in doubt, say N.
> > +
> >  config CPUFREQ_DT_PLATDEV
> >         tristate "Generic DT based cpufreq platdev driver"
> >         depends on OF
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 8d141c71b016..eb72ecdc24db 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)   +=3D cpufreq_go=
vernor_attr_set.o
> >
> >  obj-$(CONFIG_CPUFREQ_DT)               +=3D cpufreq-dt.o
> >  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       +=3D cpufreq-dt-platdev.o
> > +obj-$(CONFIG_CPUFREQ_VIRT)             +=3D virtual-cpufreq.o
> >
> >  # Traces
> >  CFLAGS_amd-pstate-trace.o               :=3D -I$(src)
> > diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtua=
l-cpufreq.c
> > new file mode 100644
> > index 000000000000..59ce2bda3913
> > --- /dev/null
> > +++ b/drivers/cpufreq/virtual-cpufreq.c
> > @@ -0,0 +1,335 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2024 Google LLC
> > + */
> > +
> > +#include <linux/arch_topology.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/init.h>
> > +#include <linux/sched.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +/*
> > + * CPU0..CPUn
> > + * +-------------+-------------------------------+--------+-------+
> > + * | Register    | Description                   | Offset |   Len |
> > + * +-------------+-------------------------------+--------+-------+
> > + * | cur_perf    | read this register to get     |    0x0 |   0x4 |
> > + * |             | the current perf (integer val |        |       |
> > + * |             | representing perf relative to |        |       |
> > + * |             | max performance)              |        |       |
> > + * |             | that vCPU is running at       |        |       |
> > + * +-------------+-------------------------------+--------+-------+
> > + * | set_perf    | write to this register to set |    0x4 |   0x4 |
> > + * |             | perf value of the vCPU        |        |       |
> > + * +-------------+-------------------------------+--------+-------+
> > + * | perftbl_len | number of entries in perf     |    0x8 |   0x4 |
> > + * |             | table. A single entry in the  |        |       |
> > + * |             | perf table denotes no table   |        |       |
> > + * |             | and the entry contains        |        |       |
> > + * |             | the maximum perf value        |        |       |
> > + * |             | that this vCPU supports.      |        |       |
> > + * |             | The guest can request any     |        |       |
> > + * |             | value between 1 and max perf  |        |       |
> > + * |             | when perftbls are not used.   |        |       |
> > + * +---------------------------------------------+--------+-------+
> > + * | perftbl_sel | write to this register to     |    0xc |   0x4 |
> > + * |             | select perf table entry to    |        |       |
> > + * |             | read from                     |        |       |
> > + * +---------------------------------------------+--------+-------+
> > + * | perftbl_rd  | read this register to get     |   0x10 |   0x4 |
> > + * |             | perf value of the selected    |        |       |
> > + * |             | entry based on perftbl_sel    |        |       |
> > + * +---------------------------------------------+--------+-------+
> > + * | perf_domain | performance domain number     |   0x14 |   0x4 |
> > + * |             | that this vCPU belongs to.    |        |       |
> > + * |             | vCPUs sharing the same perf   |        |       |
> > + * |             | domain number are part of the |        |       |
> > + * |             | same performance domain.      |        |       |
> > + * +-------------+-------------------------------+--------+-------+
> > + */
> > +
> > +#define REG_CUR_PERF_STATE_OFFSET 0x0
> > +#define REG_SET_PERF_STATE_OFFSET 0x4
> > +#define REG_PERFTBL_LEN_OFFSET 0x8
> > +#define REG_PERFTBL_SEL_OFFSET 0xc
> > +#define REG_PERFTBL_RD_OFFSET 0x10
> > +#define REG_PERF_DOMAIN_OFFSET 0x14
> > +#define PER_CPU_OFFSET 0x1000
> > +
> > +#define PERFTBL_MAX_ENTRIES 64U
> > +
> > +static void __iomem *base;
> > +static DEFINE_PER_CPU(u32, perftbl_num_entries);
> > +
> > +static void virt_scale_freq_tick(void)
> > +{
> > +       int cpu =3D smp_processor_id();
> > +       u32 max_freq =3D (u32)cpufreq_get_hw_max_freq(cpu);
> > +       u64 cur_freq;
> > +       unsigned long scale;
> > +
> > +       cur_freq =3D (u64)readl_relaxed(base + cpu * PER_CPU_OFFSET
> > +                       + REG_CUR_PERF_STATE_OFFSET);
> > +
> > +       cur_freq <<=3D SCHED_CAPACITY_SHIFT;
> > +       scale =3D (unsigned long)div_u64(cur_freq, max_freq);
> > +       scale =3D min(scale, SCHED_CAPACITY_SCALE);
> > +
> > +       this_cpu_write(arch_freq_scale, scale);
> > +}
> > +
> > +static struct scale_freq_data virt_sfd =3D {
> > +       .source =3D SCALE_FREQ_SOURCE_VIRT,
> > +       .set_freq_scale =3D virt_scale_freq_tick,
> > +};
> > +
> > +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *polic=
y,
> > +                                         unsigned int target_freq)
> > +{
> > +       writel_relaxed(target_freq,
> > +                      base + policy->cpu * PER_CPU_OFFSET + REG_SET_PE=
RF_STATE_OFFSET);
> > +       return 0;
> > +}
> > +
> > +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *po=
licy,
> > +                                            unsigned int target_freq)
> > +{
> > +       virt_cpufreq_set_perf(policy, target_freq);
> > +       return target_freq;
> > +}
> > +
> > +static u32 virt_cpufreq_get_perftbl_entry(int cpu, u32 idx)
> > +{
> > +       writel_relaxed(idx, base + cpu * PER_CPU_OFFSET +
> > +                      REG_PERFTBL_SEL_OFFSET);
> > +       return readl_relaxed(base + cpu * PER_CPU_OFFSET +
> > +                            REG_PERFTBL_RD_OFFSET);
> > +}
> > +
> > +static int virt_cpufreq_target(struct cpufreq_policy *policy,
> > +                              unsigned int target_freq,
> > +                              unsigned int relation)
> > +{
> > +       struct cpufreq_freqs freqs;
> > +       int ret =3D 0;
> > +
> > +       freqs.old =3D policy->cur;
> > +       freqs.new =3D target_freq;
> > +
> > +       cpufreq_freq_transition_begin(policy, &freqs);
> > +       ret =3D virt_cpufreq_set_perf(policy, target_freq);
> > +       cpufreq_freq_transition_end(policy, &freqs, ret !=3D 0);
> > +
> > +       return ret;
> > +}
> > +
> > +static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy=
)
> > +{
> > +       u32 cur_perf_domain, perf_domain;
> > +       struct device *cpu_dev;
> > +       int cpu;
> > +
> > +       cur_perf_domain =3D readl_relaxed(base + policy->cpu *
> > +                                       PER_CPU_OFFSET + REG_PERF_DOMAI=
N_OFFSET);
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               cpu_dev =3D get_cpu_device(cpu);
> > +               if (!cpu_dev)
> > +                       continue;
> > +
> > +               perf_domain =3D readl_relaxed(base + cpu *
> > +                                           PER_CPU_OFFSET + REG_PERF_D=
OMAIN_OFFSET);
> > +
> > +               if (perf_domain =3D=3D cur_perf_domain)
> > +                       cpumask_set_cpu(cpu, policy->cpus);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
> > +{
> > +       struct cpufreq_frequency_table *table;
> > +       u32 num_perftbl_entries, idx;
> > +
> > +       num_perftbl_entries =3D per_cpu(perftbl_num_entries, policy->cp=
u);
> > +
> > +       if (num_perftbl_entries =3D=3D 1) {
> > +               policy->cpuinfo.min_freq =3D 1;
> > +               policy->cpuinfo.max_freq =3D virt_cpufreq_get_perftbl_e=
ntry(policy->cpu, 0);
> > +
> > +               policy->min =3D policy->cpuinfo.min_freq;
> > +               policy->max =3D policy->cpuinfo.max_freq;
> > +
> > +               policy->cur =3D policy->max;
> > +               return 0;
> > +       }
> > +
> > +       table =3D kcalloc(num_perftbl_entries + 1, sizeof(*table), GFP_=
KERNEL);
> > +       if (!table)
> > +               return -ENOMEM;
> > +
> > +       for (idx =3D 0; idx < num_perftbl_entries; idx++)
> > +               table[idx].frequency =3D virt_cpufreq_get_perftbl_entry=
(policy->cpu, idx);
> > +
> > +       table[idx].frequency =3D CPUFREQ_TABLE_END;
> > +       policy->freq_table =3D table;
> > +
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       struct device *cpu_dev;
> > +       int ret;
> > +
> > +       cpu_dev =3D get_cpu_device(policy->cpu);
> > +       if (!cpu_dev)
> > +               return -ENODEV;
> > +
> > +       ret =3D virt_cpufreq_get_freq_info(policy);
> > +       if (ret) {
> > +               dev_warn(cpu_dev, "failed to get cpufreq info\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D virt_cpufreq_get_sharing_cpus(policy);
> > +       if (ret) {
> > +               dev_warn(cpu_dev, "failed to get sharing cpumask\n");
> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * To simplify and improve latency of handling frequency reques=
ts on
> > +        * the host side, this ensures that the vCPU thread triggering =
the MMIO
> > +        * abort is the same thread whose performance constraints (Ex. =
uclamp
> > +        * settings) need to be updated. This simplifies the VMM (Virtu=
al
> > +        * Machine Manager) having to find the correct vCPU thread and/=
or
> > +        * facing permission issues when configuring other threads.
> > +        */
> > +       policy->dvfs_possible_from_any_cpu =3D false;
> > +       policy->fast_switch_possible =3D true;
> > +
> > +       /*
> > +        * Using the default SCALE_FREQ_SOURCE_CPUFREQ is insufficient =
since
> > +        * the actual physical CPU frequency may not match requested fr=
equency
> > +        * from the vCPU thread due to frequency update latencies or ot=
her
> > +        * inputs to the physical CPU frequency selection. This additio=
nal FIE
> > +        * source allows for more accurate freq_scale updates and only =
takes
> > +        * effect if another FIE source such as AMUs have not been regi=
stered.
> > +        */
> > +       topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> > +
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +       topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy=
->related_cpus);
> > +       kfree(policy->freq_table);
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_online(struct cpufreq_policy *policy)
> > +{
> > +       /* Nothing to restore. */
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_offline(struct cpufreq_policy *policy)
> > +{
> > +       /* Dummy offline() to avoid exit() being called and freeing res=
ources. */
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *poli=
cy)
> > +{
> > +       if (policy->freq_table)
> > +               return cpufreq_frequency_table_verify(policy, policy->f=
req_table);
> > +
> > +       cpufreq_verify_within_cpu_limits(policy);
> > +       return 0;
> > +}
> > +
> > +static struct cpufreq_driver cpufreq_virt_driver =3D {
> > +       .name           =3D "virt-cpufreq",
> > +       .init           =3D virt_cpufreq_cpu_init,
> > +       .exit           =3D virt_cpufreq_cpu_exit,
> > +       .online         =3D virt_cpufreq_online,
> > +       .offline        =3D virt_cpufreq_offline,
> > +       .verify         =3D virt_cpufreq_verify_policy,
> > +       .target         =3D virt_cpufreq_target,
> > +       .fast_switch    =3D virt_cpufreq_fast_switch,
> > +       .attr           =3D cpufreq_generic_attr,
> > +};
> > +
> > +static int virt_cpufreq_driver_probe(struct platform_device *pdev)
> > +{
> > +       u32 num_perftbl_entries;
> > +       int ret, cpu;
> > +
> > +       base =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               num_perftbl_entries =3D readl_relaxed(base + cpu * PER_=
CPU_OFFSET +
> > +                                                   REG_PERFTBL_LEN_OFF=
SET);
> > +
> > +               if (!num_perftbl_entries || num_perftbl_entries > PERFT=
BL_MAX_ENTRIES)
> > +                       return -ENODEV;
> > +
> > +               per_cpu(perftbl_num_entries, cpu) =3D num_perftbl_entri=
es;
> > +       }
> > +
> > +       ret =3D cpufreq_register_driver(&cpufreq_virt_driver);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Virtual CPUFreq driver failed to r=
egister: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n");
> > +       return 0;
> > +}
> > +
> > +static int virt_cpufreq_driver_remove(struct platform_device *pdev)
> > +{
> > +       cpufreq_unregister_driver(&cpufreq_virt_driver);
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id virt_cpufreq_match[] =3D {
> > +       { .compatible =3D "qemu,virtual-cpufreq", .data =3D NULL},
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
> > +
> > +static struct platform_driver virt_cpufreq_driver =3D {
> > +       .probe =3D virt_cpufreq_driver_probe,
> > +       .remove =3D virt_cpufreq_driver_remove,
> > +       .driver =3D {
> > +               .name =3D "virt-cpufreq",
> > +               .of_match_table =3D virt_cpufreq_match,
> > +       },
> > +};
> > +
> > +static int __init virt_cpufreq_init(void)
> > +{
> > +       return platform_driver_register(&virt_cpufreq_driver);
> > +}
> > +postcore_initcall(virt_cpufreq_init);
> > +
> > +static void __exit virt_cpufreq_exit(void)
> > +{
> > +       platform_driver_unregister(&virt_cpufreq_driver);
> > +}
> > +module_exit(virt_cpufreq_exit);
> > +
> > +MODULE_DESCRIPTION("Virtual cpufreq driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topolog=
y.h
> > index b721f360d759..d5d848849408 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -49,6 +49,7 @@ enum scale_freq_source {
> >         SCALE_FREQ_SOURCE_CPUFREQ =3D 0,
> >         SCALE_FREQ_SOURCE_ARCH,
> >         SCALE_FREQ_SOURCE_CPPC,
> > +       SCALE_FREQ_SOURCE_VIRT,
> >  };
> >
> >  struct scale_freq_data {
> > --
> > 2.45.0.215.g3402c0e53f-goog
> >
>

