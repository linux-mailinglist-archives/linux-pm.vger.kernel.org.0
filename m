Return-Path: <linux-pm+bounces-10154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356391B17E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93EE1F27697
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7641A0717;
	Thu, 27 Jun 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcY94Syc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543A1A01D1
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523338; cv=none; b=COeQb8Y2rylw1ltVFyQDtLAYjHVxLvjyxgx5OO97kTyDhzUfasIVu4J5XORTNBBr+p3MLr2JYNKQ7gs5JOjnvtEvJJyvS6W2A3S0fOQOigt89C3rCVzjG4zM0v+FtJF0LnedEf/yk6nhtwfmLmyc1t1JL69DfG2aQx0KxwEECzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523338; c=relaxed/simple;
	bh=qhtJNUhzDoON9I6jaUH0r0PsFEv2E3VTs8TwiviBK5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idHewGEZWaluaiB/4WM6Vj7dB03DncFRvV/azL1zNJq1rRkW739qnQvrj5l4h9NhQ6QrzmM6yqMHNHEacnbemYawZmnympbYrKLR9KjUa/K7LyIPY2Ok1Rp3Nnp26zGNsA/NVQzV3PHm4IYa/8/iGutxMLm03XJjseyu/u0EtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcY94Syc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3672aec418cso1521855f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719523335; x=1720128135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRQZdxqpT6x5YpRkgnwCvTH3y2IWn5FDxDsgzvSaC18=;
        b=UcY94Syc9HNKfoV1xlXEPyWVHThrm6m5dWgZMjsrf/bFQFf8+GVnNG+o1fhRgU1xDz
         6DmhPJOBv5S89jmzAmlVFmUvkJg1YGDsMe4JqhwR9PrX44rGW2cbEeCUaTDg4JjOnN8s
         UEYEqinecyO75dr4TsLdtQQZCMxkobgs9CKVIP7Ydf0x6jbS1XA7ieu/59Gk/vs+ywGM
         4yu/1LbDAjA9BXMQZbg1Z5EHqfoTpvrZ/P5wGx6sc1H2SaNArKIdWkGo9njtGH4AI4Gt
         k0SHpbMFJI9DAfUTB4RJPXMThCNAANvUkzrIYrl/XYe51oGRgGQ9mQA7n84VAfBXtwus
         4EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719523335; x=1720128135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRQZdxqpT6x5YpRkgnwCvTH3y2IWn5FDxDsgzvSaC18=;
        b=vib9hqoVZvdOAdraKuTEwGjCs6DEKIoWOBrwih+F9boMDMLJky9Y/sOg76tm8ag0UR
         NsMi2Z0MOTf71qnbNAvYL0PqkjLUYy/mDsuDBh9JvHdeDL087+RObf3mgzv7S0Uay5F5
         CBltz1q99lFVYVaqoNFuXY+9X1JrGEPEg5xHbWTYNSwNh9fbfCVzbWLx5VDE4sKU/8W+
         nsZD0ZuRZvKniEW2kIdB1WCpq0oDA5pZ8zVkMXpK6/0oVPHDBxUv/fZKQQjYndYjBH0q
         g786ZWaXwf2wyKssBc7gM7Wf0XVjEte3SgjBhWUWqpxIKn1DDi8IfY55GdSwMhVHvTjY
         yGUw==
X-Forwarded-Encrypted: i=1; AJvYcCVD38qezUkrCgj5Fh3W9lnhgujaOcr91tJn7PrXPyYT8pFwi9IQgzATcDGgOQ/yUYg/X5oyum78fp5O/Au2EalYSDdgcwrUvSA=
X-Gm-Message-State: AOJu0YwAkOPmQhKw8V66Na2qTXUx0pzTHum9VRJLbe/MZpBDmePX57K1
	yjMVb3EERcrCQeX7G4W5s98ddzdNRFzuefL+qVJdIdnGgDnPtmnJ5v0OVr2EmWqFiyYnWmvD+S1
	DEiNyXOKBzHRc5zpitvHfWY10hvspxbqsEDgH
X-Google-Smtp-Source: AGHT+IFtToqmHA26slD6w71qcbxkHPK1BnScTMkqy7f6xNaC3JmrYokkOj7/EE2iPCrpyxax3GOxj2+k26WbktdKjSI=
X-Received: by 2002:a5d:59a5:0:b0:366:e685:d0cb with SMTP id
 ffacd0b85a97d-366e685d27dmr12970392f8f.6.1719523334823; Thu, 27 Jun 2024
 14:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521043102.2786284-1-davidai@google.com> <20240521043102.2786284-3-davidai@google.com>
In-Reply-To: <20240521043102.2786284-3-davidai@google.com>
From: David Dai <davidai@google.com>
Date: Thu, 27 Jun 2024 15:22:02 -0600
Message-ID: <CABN1KCKirjdVxF7Mc38tToB9OKH3n2kdN6k1tJbC-cyUtsVAFA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpufreq: add virtual-cpufreq driver
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

Gentle nudge on this patch to see if there's any remaining concerns?

Thanks,
David

On Mon, May 20, 2024 at 10:32=E2=80=AFPM David Dai <davidai@google.com> wro=
te:
>
> Introduce a virtualized cpufreq driver for guest kernels to improve
> performance and power of workloads within VMs.
>
> This driver does two main things:
>
> 1. Sends the frequency of vCPUs as a hint to the host. The host uses the
> hint to schedule the vCPU threads and decide physical CPU frequency.
>
> 2. If a VM does not support a virtualized FIE(like AMUs), it queries the
> host CPU frequency by reading a MMIO region of a virtual cpufreq device
> to update the guest's frequency scaling factor periodically. This enables
> accurate Per-Entity Load Tracking for tasks running in the guest.
>
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>  drivers/cpufreq/Kconfig           |  14 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/virtual-cpufreq.c | 335 ++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h     |   1 +
>  4 files changed, 351 insertions(+)
>  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 94e55c40970a..9aa86bec5793 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -217,6 +217,20 @@ config CPUFREQ_DT
>
>           If in doubt, say N.
>
> +config CPUFREQ_VIRT
> +       tristate "Virtual cpufreq driver"
> +       depends on OF && GENERIC_ARCH_TOPOLOGY
> +       help
> +         This adds a virtualized cpufreq driver for guest kernels that
> +         read/writes to a MMIO region for a virtualized cpufreq device t=
o
> +         communicate with the host. It sends performance requests to the=
 host
> +         which gets used as a hint to schedule vCPU threads and select C=
PU
> +         frequency. If a VM does not support a virtualized FIE such as A=
MUs,
> +         it updates the frequency scaling factor by polling host CPU fre=
quency
> +         to enable accurate Per-Entity Load Tracking for tasks running i=
n the guest.
> +
> +         If in doubt, say N.
> +
>  config CPUFREQ_DT_PLATDEV
>         tristate "Generic DT based cpufreq platdev driver"
>         depends on OF
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d141c71b016..eb72ecdc24db 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)   +=3D cpufreq_gove=
rnor_attr_set.o
>
>  obj-$(CONFIG_CPUFREQ_DT)               +=3D cpufreq-dt.o
>  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       +=3D cpufreq-dt-platdev.o
> +obj-$(CONFIG_CPUFREQ_VIRT)             +=3D virtual-cpufreq.o
>
>  # Traces
>  CFLAGS_amd-pstate-trace.o               :=3D -I$(src)
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-=
cpufreq.c
> new file mode 100644
> index 000000000000..59ce2bda3913
> --- /dev/null
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Google LLC
> + */
> +
> +#include <linux/arch_topology.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/*
> + * CPU0..CPUn
> + * +-------------+-------------------------------+--------+-------+
> + * | Register    | Description                   | Offset |   Len |
> + * +-------------+-------------------------------+--------+-------+
> + * | cur_perf    | read this register to get     |    0x0 |   0x4 |
> + * |             | the current perf (integer val |        |       |
> + * |             | representing perf relative to |        |       |
> + * |             | max performance)              |        |       |
> + * |             | that vCPU is running at       |        |       |
> + * +-------------+-------------------------------+--------+-------+
> + * | set_perf    | write to this register to set |    0x4 |   0x4 |
> + * |             | perf value of the vCPU        |        |       |
> + * +-------------+-------------------------------+--------+-------+
> + * | perftbl_len | number of entries in perf     |    0x8 |   0x4 |
> + * |             | table. A single entry in the  |        |       |
> + * |             | perf table denotes no table   |        |       |
> + * |             | and the entry contains        |        |       |
> + * |             | the maximum perf value        |        |       |
> + * |             | that this vCPU supports.      |        |       |
> + * |             | The guest can request any     |        |       |
> + * |             | value between 1 and max perf  |        |       |
> + * |             | when perftbls are not used.   |        |       |
> + * +---------------------------------------------+--------+-------+
> + * | perftbl_sel | write to this register to     |    0xc |   0x4 |
> + * |             | select perf table entry to    |        |       |
> + * |             | read from                     |        |       |
> + * +---------------------------------------------+--------+-------+
> + * | perftbl_rd  | read this register to get     |   0x10 |   0x4 |
> + * |             | perf value of the selected    |        |       |
> + * |             | entry based on perftbl_sel    |        |       |
> + * +---------------------------------------------+--------+-------+
> + * | perf_domain | performance domain number     |   0x14 |   0x4 |
> + * |             | that this vCPU belongs to.    |        |       |
> + * |             | vCPUs sharing the same perf   |        |       |
> + * |             | domain number are part of the |        |       |
> + * |             | same performance domain.      |        |       |
> + * +-------------+-------------------------------+--------+-------+
> + */
> +
> +#define REG_CUR_PERF_STATE_OFFSET 0x0
> +#define REG_SET_PERF_STATE_OFFSET 0x4
> +#define REG_PERFTBL_LEN_OFFSET 0x8
> +#define REG_PERFTBL_SEL_OFFSET 0xc
> +#define REG_PERFTBL_RD_OFFSET 0x10
> +#define REG_PERF_DOMAIN_OFFSET 0x14
> +#define PER_CPU_OFFSET 0x1000
> +
> +#define PERFTBL_MAX_ENTRIES 64U
> +
> +static void __iomem *base;
> +static DEFINE_PER_CPU(u32, perftbl_num_entries);
> +
> +static void virt_scale_freq_tick(void)
> +{
> +       int cpu =3D smp_processor_id();
> +       u32 max_freq =3D (u32)cpufreq_get_hw_max_freq(cpu);
> +       u64 cur_freq;
> +       unsigned long scale;
> +
> +       cur_freq =3D (u64)readl_relaxed(base + cpu * PER_CPU_OFFSET
> +                       + REG_CUR_PERF_STATE_OFFSET);
> +
> +       cur_freq <<=3D SCHED_CAPACITY_SHIFT;
> +       scale =3D (unsigned long)div_u64(cur_freq, max_freq);
> +       scale =3D min(scale, SCHED_CAPACITY_SCALE);
> +
> +       this_cpu_write(arch_freq_scale, scale);
> +}
> +
> +static struct scale_freq_data virt_sfd =3D {
> +       .source =3D SCALE_FREQ_SOURCE_VIRT,
> +       .set_freq_scale =3D virt_scale_freq_tick,
> +};
> +
> +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy,
> +                                         unsigned int target_freq)
> +{
> +       writel_relaxed(target_freq,
> +                      base + policy->cpu * PER_CPU_OFFSET + REG_SET_PERF=
_STATE_OFFSET);
> +       return 0;
> +}
> +
> +static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *poli=
cy,
> +                                            unsigned int target_freq)
> +{
> +       virt_cpufreq_set_perf(policy, target_freq);
> +       return target_freq;
> +}
> +
> +static u32 virt_cpufreq_get_perftbl_entry(int cpu, u32 idx)
> +{
> +       writel_relaxed(idx, base + cpu * PER_CPU_OFFSET +
> +                      REG_PERFTBL_SEL_OFFSET);
> +       return readl_relaxed(base + cpu * PER_CPU_OFFSET +
> +                            REG_PERFTBL_RD_OFFSET);
> +}
> +
> +static int virt_cpufreq_target(struct cpufreq_policy *policy,
> +                              unsigned int target_freq,
> +                              unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       int ret =3D 0;
> +
> +       freqs.old =3D policy->cur;
> +       freqs.new =3D target_freq;
> +
> +       cpufreq_freq_transition_begin(policy, &freqs);
> +       ret =3D virt_cpufreq_set_perf(policy, target_freq);
> +       cpufreq_freq_transition_end(policy, &freqs, ret !=3D 0);
> +
> +       return ret;
> +}
> +
> +static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy)
> +{
> +       u32 cur_perf_domain, perf_domain;
> +       struct device *cpu_dev;
> +       int cpu;
> +
> +       cur_perf_domain =3D readl_relaxed(base + policy->cpu *
> +                                       PER_CPU_OFFSET + REG_PERF_DOMAIN_=
OFFSET);
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_dev =3D get_cpu_device(cpu);
> +               if (!cpu_dev)
> +                       continue;
> +
> +               perf_domain =3D readl_relaxed(base + cpu *
> +                                           PER_CPU_OFFSET + REG_PERF_DOM=
AIN_OFFSET);
> +
> +               if (perf_domain =3D=3D cur_perf_domain)
> +                       cpumask_set_cpu(cpu, policy->cpus);
> +       }
> +
> +       return 0;
> +}
> +
> +static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *table;
> +       u32 num_perftbl_entries, idx;
> +
> +       num_perftbl_entries =3D per_cpu(perftbl_num_entries, policy->cpu)=
;
> +
> +       if (num_perftbl_entries =3D=3D 1) {
> +               policy->cpuinfo.min_freq =3D 1;
> +               policy->cpuinfo.max_freq =3D virt_cpufreq_get_perftbl_ent=
ry(policy->cpu, 0);
> +
> +               policy->min =3D policy->cpuinfo.min_freq;
> +               policy->max =3D policy->cpuinfo.max_freq;
> +
> +               policy->cur =3D policy->max;
> +               return 0;
> +       }
> +
> +       table =3D kcalloc(num_perftbl_entries + 1, sizeof(*table), GFP_KE=
RNEL);
> +       if (!table)
> +               return -ENOMEM;
> +
> +       for (idx =3D 0; idx < num_perftbl_entries; idx++)
> +               table[idx].frequency =3D virt_cpufreq_get_perftbl_entry(p=
olicy->cpu, idx);
> +
> +       table[idx].frequency =3D CPUFREQ_TABLE_END;
> +       policy->freq_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct device *cpu_dev;
> +       int ret;
> +
> +       cpu_dev =3D get_cpu_device(policy->cpu);
> +       if (!cpu_dev)
> +               return -ENODEV;
> +
> +       ret =3D virt_cpufreq_get_freq_info(policy);
> +       if (ret) {
> +               dev_warn(cpu_dev, "failed to get cpufreq info\n");
> +               return ret;
> +       }
> +
> +       ret =3D virt_cpufreq_get_sharing_cpus(policy);
> +       if (ret) {
> +               dev_warn(cpu_dev, "failed to get sharing cpumask\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * To simplify and improve latency of handling frequency requests=
 on
> +        * the host side, this ensures that the vCPU thread triggering th=
e MMIO
> +        * abort is the same thread whose performance constraints (Ex. uc=
lamp
> +        * settings) need to be updated. This simplifies the VMM (Virtual
> +        * Machine Manager) having to find the correct vCPU thread and/or
> +        * facing permission issues when configuring other threads.
> +        */
> +       policy->dvfs_possible_from_any_cpu =3D false;
> +       policy->fast_switch_possible =3D true;
> +
> +       /*
> +        * Using the default SCALE_FREQ_SOURCE_CPUFREQ is insufficient si=
nce
> +        * the actual physical CPU frequency may not match requested freq=
uency
> +        * from the vCPU thread due to frequency update latencies or othe=
r
> +        * inputs to the physical CPU frequency selection. This additiona=
l FIE
> +        * source allows for more accurate freq_scale updates and only ta=
kes
> +        * effect if another FIE source such as AMUs have not been regist=
ered.
> +        */
> +       topology_set_scale_freq_source(&virt_sfd, policy->cpus);
> +
> +       return 0;
> +}
> +
> +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->=
related_cpus);
> +       kfree(policy->freq_table);
> +       return 0;
> +}
> +
> +static int virt_cpufreq_online(struct cpufreq_policy *policy)
> +{
> +       /* Nothing to restore. */
> +       return 0;
> +}
> +
> +static int virt_cpufreq_offline(struct cpufreq_policy *policy)
> +{
> +       /* Dummy offline() to avoid exit() being called and freeing resou=
rces. */
> +       return 0;
> +}
> +
> +static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy=
)
> +{
> +       if (policy->freq_table)
> +               return cpufreq_frequency_table_verify(policy, policy->fre=
q_table);
> +
> +       cpufreq_verify_within_cpu_limits(policy);
> +       return 0;
> +}
> +
> +static struct cpufreq_driver cpufreq_virt_driver =3D {
> +       .name           =3D "virt-cpufreq",
> +       .init           =3D virt_cpufreq_cpu_init,
> +       .exit           =3D virt_cpufreq_cpu_exit,
> +       .online         =3D virt_cpufreq_online,
> +       .offline        =3D virt_cpufreq_offline,
> +       .verify         =3D virt_cpufreq_verify_policy,
> +       .target         =3D virt_cpufreq_target,
> +       .fast_switch    =3D virt_cpufreq_fast_switch,
> +       .attr           =3D cpufreq_generic_attr,
> +};
> +
> +static int virt_cpufreq_driver_probe(struct platform_device *pdev)
> +{
> +       u32 num_perftbl_entries;
> +       int ret, cpu;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       for_each_possible_cpu(cpu) {
> +               num_perftbl_entries =3D readl_relaxed(base + cpu * PER_CP=
U_OFFSET +
> +                                                   REG_PERFTBL_LEN_OFFSE=
T);
> +
> +               if (!num_perftbl_entries || num_perftbl_entries > PERFTBL=
_MAX_ENTRIES)
> +                       return -ENODEV;
> +
> +               per_cpu(perftbl_num_entries, cpu) =3D num_perftbl_entries=
;
> +       }
> +
> +       ret =3D cpufreq_register_driver(&cpufreq_virt_driver);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Virtual CPUFreq driver failed to reg=
ister: %d\n", ret);
> +               return ret;
> +       }
> +
> +       dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n");
> +       return 0;
> +}
> +
> +static int virt_cpufreq_driver_remove(struct platform_device *pdev)
> +{
> +       cpufreq_unregister_driver(&cpufreq_virt_driver);
> +       return 0;
> +}
> +
> +static const struct of_device_id virt_cpufreq_match[] =3D {
> +       { .compatible =3D "qemu,virtual-cpufreq", .data =3D NULL},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
> +
> +static struct platform_driver virt_cpufreq_driver =3D {
> +       .probe =3D virt_cpufreq_driver_probe,
> +       .remove =3D virt_cpufreq_driver_remove,
> +       .driver =3D {
> +               .name =3D "virt-cpufreq",
> +               .of_match_table =3D virt_cpufreq_match,
> +       },
> +};
> +
> +static int __init virt_cpufreq_init(void)
> +{
> +       return platform_driver_register(&virt_cpufreq_driver);
> +}
> +postcore_initcall(virt_cpufreq_init);
> +
> +static void __exit virt_cpufreq_exit(void)
> +{
> +       platform_driver_unregister(&virt_cpufreq_driver);
> +}
> +module_exit(virt_cpufreq_exit);
> +
> +MODULE_DESCRIPTION("Virtual cpufreq driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.=
h
> index b721f360d759..d5d848849408 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -49,6 +49,7 @@ enum scale_freq_source {
>         SCALE_FREQ_SOURCE_CPUFREQ =3D 0,
>         SCALE_FREQ_SOURCE_ARCH,
>         SCALE_FREQ_SOURCE_CPPC,
> +       SCALE_FREQ_SOURCE_VIRT,
>  };
>
>  struct scale_freq_data {
> --
> 2.45.0.215.g3402c0e53f-goog
>

