Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F914CAE3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfFTJco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 05:32:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37840 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfFTJco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 05:32:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so2556861qtk.4
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PwJ003H7aUrtwAsoi3i9ja/RIj0hylOJ7YOIpP2U/2I=;
        b=n/hX1hDU35QMp2kzjyGjyY66Ec0O8CJ+JLzftbmHJWC9bGdl/urcUxUz/aFGqccJUf
         XeryXP/PWl+lHCemJr8NZD0ALMfhrcziH+IwdY8babue3qbRpYjtHx/F0l4M//PGi2MO
         sHbgglF4iaMscji3TH0Sj6iV+4+y/UJDPjoR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PwJ003H7aUrtwAsoi3i9ja/RIj0hylOJ7YOIpP2U/2I=;
        b=VmeSvxgxAKsO9DCqXhri4HJcphIz/1IcSQTfsT3A5Q+uipWcvqEQGC2+c79OafzDCk
         6YsMZP6vPeSWoJRgjUZdJzV451qYmvjiTAX8fAemdTeHSHYia2fjP4gW/1fH3TX1qBEB
         Rive7R3l9hOiAW3R4d+tc9xHFz3ReDclhVpr3aEge+vG+EftsPkLM/7i0ZC2eUADgB/6
         RzkgvHE3ltnGRhljDvuKRl5aOA09DN3hTCUWTlNwTl8H8wy6OOvI0YRuVplHwY8DCOsf
         CEQTeIa3Oy5gUMa9EUF5u58o1nEwf2WhDjcnEDI6CHyNiqIJfPcXuyky9sYAiGU9El29
         HELg==
X-Gm-Message-State: APjAAAWxsBAL58Al7Ci6Gw5Mh9YUNEnLE2cd6NbNpK7vxBnG+Nm663cc
        q4JvEwAXhO8zFj+ze96fBsH3tUEbBROHNwOa7CDn4g==
X-Google-Smtp-Source: APXvYqz5BzLkmp9rKNxuO7uCSigPEQ7LDfQ3t3qedcbyU3XOxdCJ8EGkoYsxXBQbIJ7HjoBzvh1AiTE+gtRWh9aTw7Y=
X-Received: by 2002:ac8:381d:: with SMTP id q29mr110146545qtb.347.1561023162462;
 Thu, 20 Jun 2019 02:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190618041433.245629-1-hsinyi@chromium.org> <CGME20190618041513epcas5p1bc626114804cb68bbf857f0a826c7599@epcas5p1.samsung.com>
 <20190618041433.245629-2-hsinyi@chromium.org> <958b27ff-6e64-b4e2-44e6-bc342e3606bc@samsung.com>
In-Reply-To: <958b27ff-6e64-b4e2-44e6-bc342e3606bc@samsung.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 20 Jun 2019 17:32:16 +0800
Message-ID: <CAJMQK-jELbhCUb5LYOnGMsBHjhZHnXMYQYDxWyEmriJf8OSpSQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo Choi, Saravana Kannan and Sibi Sankar,

I've also tested Sibi Sankar's patch[1] locally with mt8183-cci, and
it works fine too!
It'd be great if Sibi Sankar or anyone who is familiar with the
original design can finish this implementation. But if no one has time
to do that, I think I can also help on address the comments. Thanks!


[1]
[RFC,2/9] OPP: Export a number of helpers to prevent code duplication
- https://patchwork.kernel.org/patch/10875199/
[RFC,3/9] PM / devfreq: Add cpu based scaling support to passive_governor
- https://patchwork.kernel.org/patch/10875195/

Hsin-Yi

On Thu, Jun 20, 2019 at 2:56 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> + Sibi Sankar
>
> Hi, Hsin-Yi Wang, Saravana Kannan and Sibi Sankar
>
> I summarized the history of the related patch about this title.
>
> Firstly,
> As I knew, Saravana sent the patch[1] which contains
> 'governor_cpufreq_map.c' last year. According to the Myungoo's comment,
>
> Secondly,
> Sibi Sankar modified the 'governor_passive.c'[2] in order to support
> the mapping between cpu frequency and device frequency.
> Unfortunately, Sibi Sankar stopped the development about this
> because he had found the other method to get his purpose as I knew.
>
> Thirdly,
> Hsin-Yi Wang send the original patch of Saravana without modification.
>
>
> Sincerely, I think that the mapping between cpu frequency and device
> frequency is necessary. And I prefer the Sibi's approach which implements
> stuff to the existing 'passive' governor.
>
> We need to discuss about how to implement them by whom.
>
>
> [1] [v3,1/2] PM / devfreq: Generic CPU frequency to device frequency mapp=
ing governor
> - https://patchwork.kernel.org/patch/10553171/
>
> [2]
> [PATCH RFC 0/9] Add CPU based scaling support to Passive governor
> - https://lore.kernel.org/lkml/08c3cff8c39e3d82e044db93e992da72@codeauror=
a.org/T/
> [PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to passive_go=
vernor
> - https://lore.kernel.org/lkml/08c3cff8c39e3d82e044db93e992da72@codeauror=
a.org/T/#m1cafb7baf687d2a680d39c85d3ec7d1b590b68fc
>
>
> Best Regards,
> Chanwoo Choi
>
> On 19. 6. 18. =EC=98=A4=ED=9B=84 1:14, Hsin-Yi Wang wrote:
> > From: Saravana Kannan <skannan@codeaurora.org>
> >
> > From: Saravana Kannan <skannan@codeaurora.org>
> >
> > Many CPU architectures have caches that can scale independent of the CP=
Us.
> > Frequency scaling of the caches is necessary to make sure the cache is =
not
> > a performance bottleneck that leads to poor performance and power. The =
same
> > idea applies for RAM/DDR.
> >
> > To achieve this, this patch adds a generic devfreq governor that takes =
the
> > current frequency of each CPU frequency domain and then adjusts the
> > frequency of the cache (or any devfreq device) based on the frequency o=
f
> > the CPUs. It listens to CPU frequency transition notifiers to keep itse=
lf
> > up to date on the current CPU frequency.
> >
> > To decide the frequency of the device, the governor does one of the
> > following:
> >
> > * Uses a CPU frequency to device frequency mapping table
> >   - Either one mapping table used for all CPU freq policies (typically =
used
> >     for system with homogeneous cores/clusters that have the same OPPs)=
.
> >   - One mapping table per CPU freq policy (typically used for ASMP syst=
ems
> >     with heterogeneous CPUs with different OPPs)
> >
> > OR
> >
> > * Scales the device frequency in proportion to the CPU frequency. So, i=
f
> >   the CPUs are running at their max frequency, the device runs at its m=
ax
> >   frequency.  If the CPUs are running at their min frequency, the devic=
e
> >   runs at its min frequency. And interpolated for frequencies in betwee=
n.
> >
> > Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  .../bindings/devfreq/devfreq-cpufreq-map.txt  |  53 ++
> >  drivers/devfreq/Kconfig                       |   8 +
> >  drivers/devfreq/Makefile                      |   1 +
> >  drivers/devfreq/governor_cpufreq_map.c        | 583 ++++++++++++++++++
> >  4 files changed, 645 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-c=
pufreq-map.txt
> >  create mode 100644 drivers/devfreq/governor_cpufreq_map.c
> >
> > diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-=
map.txt b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> > new file mode 100644
> > index 000000000000..982a30bcfc86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> > @@ -0,0 +1,53 @@
> > +Devfreq CPUfreq governor
> > +
> > +devfreq-cpufreq-map is a parent device that contains one or more child=
 devices.
> > +Each child device provides CPU frequency to device frequency mapping f=
or a
> > +specific device. Examples of devices that could use this are: DDR, cac=
he and
> > +CCI.
> > +
> > +Parent device name shall be "devfreq-cpufreq-map".
> > +
> > +Required child device properties:
> > +- cpu-to-dev-map, or cpu-to-dev-map-<X>:
> > +                     A list of tuples where each tuple consists of a
> > +                     CPU frequency (KHz) and the corresponding device
> > +                     frequency. CPU frequencies not listed in the tabl=
e
> > +                     will use the device frequency that corresponds to=
 the
> > +                     next rounded up CPU frequency.
> > +                     Use "cpu-to-dev-map" if all CPUs in the system sh=
ould
> > +                     share same mapping.
> > +                     Use cpu-to-dev-map-<cpuid> to describe different
> > +                     mappings for different CPUs. The property should =
be
> > +                     listed only for the first CPU if multiple CPUs ar=
e
> > +                     synchronous.
> > +- target-dev:                Phandle to device that this mapping appli=
es to.
> > +
> > +Example:
> > +     devfreq-cpufreq-map {
> > +             cpubw-cpufreq {
> > +                     target-dev =3D <&cpubw>;
> > +                     cpu-to-dev-map =3D
> > +                             <  300000  1144000 >,
> > +                             <  422400  2288000 >,
> > +                             <  652800  3051000 >,
> > +                             <  883200  5996000 >,
> > +                             < 1190400  8056000 >,
> > +                             < 1497600 10101000 >,
> > +                             < 1728000 12145000 >,
> > +                             < 2649600 16250000 >;
> > +             };
> > +
> > +             cache-cpufreq {
> > +                     target-dev =3D <&cache>;
> > +                     cpu-to-dev-map =3D
> > +                             <  300000  300000 >,
> > +                             <  422400  422400 >,
> > +                             <  652800  499200 >,
> > +                             <  883200  576000 >,
> > +                             <  960000  960000 >,
> > +                             < 1497600 1036800 >,
> > +                             < 1574400 1574400 >,
> > +                             < 1728000 1651200 >,
> > +                             < 2649600 1728000 >;
> > +             };
> > +     };
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 0c8204d6b78a..0303f5a400b6 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -74,6 +74,14 @@ config DEVFREQ_GOV_PASSIVE
> >         through sysfs entries. The passive governor recommends that
> >         devfreq device uses the OPP table to get the frequency/voltage.
> >
> > +config DEVFREQ_GOV_CPUFREQ_MAP
> > +     tristate "CPUfreq Map"
> > +     depends on CPU_FREQ
> > +     help
> > +       Chooses frequency based on the online CPUs' current frequency a=
nd a
> > +       CPU frequency to device frequency mapping table(s). This govern=
or
> > +       can be useful for controlling devices such as DDR, cache, CCI, =
etc.
> > +
> >  comment "DEVFREQ Drivers"
> >
> >  config ARM_EXYNOS_BUS_DEVFREQ
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 817dde779f16..81141e2c784f 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE) +=3D governor_per=
formance.o
> >  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)  +=3D governor_powersave.o
> >  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)  +=3D governor_userspace.o
> >  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)    +=3D governor_passive.o
> > +obj-$(CONFIG_DEVFREQ_GOV_CPUFREQ_MAP)        +=3D governor_cpufreq_map=
.o
> >
> >  # DEVFREQ Drivers
> >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ) +=3D exynos-bus.o
> > diff --git a/drivers/devfreq/governor_cpufreq_map.c b/drivers/devfreq/g=
overnor_cpufreq_map.c
> > new file mode 100644
> > index 000000000000..084a3ffb8f54
> > --- /dev/null
> > +++ b/drivers/devfreq/governor_cpufreq_map.c
> > @@ -0,0 +1,583 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights res=
erved.
> > + */
> > +
> > +#define pr_fmt(fmt) "dev-cpufreq-map: " fmt
> > +
> > +#include <linux/devfreq.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/slab.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of.h>
> > +#include <linux/module.h>
> > +#include "governor.h"
> > +
> > +struct cpu_state {
> > +     unsigned int freq;
> > +     unsigned int min_freq;
> > +     unsigned int max_freq;
> > +     unsigned int first_cpu;
> > +};
> > +static struct cpu_state *state[NR_CPUS];
> > +static int cpufreq_cnt;
> > +
> > +struct freq_map {
> > +     unsigned int cpu_khz;
> > +     unsigned int target_freq;
> > +};
> > +
> > +struct devfreq_node {
> > +     struct devfreq *df;
> > +     void *orig_data;
> > +     struct device *dev;
> > +     struct device_node *of_node;
> > +     struct list_head list;
> > +     struct freq_map **map;
> > +     struct freq_map *common_map;
> > +};
> > +static LIST_HEAD(devfreq_list);
> > +static DEFINE_MUTEX(state_lock);
> > +static DEFINE_MUTEX(cpufreq_reg_lock);
> > +
> > +static void update_all_devfreqs(void)
> > +{
> > +     struct devfreq_node *node;
> > +
> > +     list_for_each_entry(node, &devfreq_list, list) {
> > +             struct devfreq *df =3D node->df;
> > +
> > +             if (!node->df)
> > +                     continue;
> > +             mutex_lock(&df->lock);
> > +             update_devfreq(df);
> > +             mutex_unlock(&df->lock);
> > +
> > +     }
> > +}
> > +
> > +static struct devfreq_node *find_devfreq_node(struct device *dev)
> > +{
> > +     struct devfreq_node *node;
> > +
> > +     list_for_each_entry(node, &devfreq_list, list)
> > +             if (node->dev =3D=3D dev || node->of_node =3D=3D dev->of_=
node)
> > +                     return node;
> > +
> > +     return NULL;
> > +}
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cpufre=
q part =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +static struct cpu_state *add_policy(struct cpufreq_policy *policy)
> > +{
> > +     struct cpu_state *new_state;
> > +     unsigned int cpu, first_cpu;
> > +
> > +     new_state =3D kzalloc(sizeof(struct cpu_state), GFP_KERNEL);
> > +     if (!new_state)
> > +             return NULL;
> > +
> > +     first_cpu =3D cpumask_first(policy->related_cpus);
> > +     new_state->first_cpu =3D first_cpu;
> > +     new_state->freq =3D policy->cur;
> > +     new_state->min_freq =3D policy->cpuinfo.min_freq;
> > +     new_state->max_freq =3D policy->cpuinfo.max_freq;
> > +
> > +     for_each_cpu(cpu, policy->related_cpus)
> > +             state[cpu] =3D new_state;
> > +
> > +     return new_state;
> > +}
> > +
> > +static int cpufreq_trans_notifier(struct notifier_block *nb,
> > +             unsigned long event, void *data)
> > +{
> > +     struct cpufreq_freqs *freq =3D data;
> > +     struct cpu_state *s;
> > +     struct cpufreq_policy *policy =3D NULL;
> > +
> > +     if (event !=3D CPUFREQ_POSTCHANGE)
> > +             return 0;
> > +
> > +     mutex_lock(&state_lock);
> > +
> > +     s =3D state[freq->cpu];
> > +     if (!s) {
> > +             policy =3D cpufreq_cpu_get(freq->cpu);
> > +             if (policy) {
> > +                     s =3D add_policy(policy);
> > +                     cpufreq_cpu_put(policy);
> > +             }
> > +     }
> > +     if (!s)
> > +             goto out;
> > +
> > +     if (s->freq !=3D freq->new || policy) {
> > +             s->freq =3D freq->new;
> > +             update_all_devfreqs();
> > +     }
> > +
> > +out:
> > +     mutex_unlock(&state_lock);
> > +     return 0;
> > +}
> > +
> > +static struct notifier_block cpufreq_trans_nb =3D {
> > +     .notifier_call =3D cpufreq_trans_notifier
> > +};
> > +
> > +static int register_cpufreq(void)
> > +{
> > +     int ret =3D 0;
> > +     unsigned int cpu;
> > +     struct cpufreq_policy *policy;
> > +
> > +     mutex_lock(&cpufreq_reg_lock);
> > +
> > +     if (cpufreq_cnt)
> > +             goto cnt_not_zero;
> > +
> > +     get_online_cpus();
> > +     ret =3D cpufreq_register_notifier(&cpufreq_trans_nb,
> > +                             CPUFREQ_TRANSITION_NOTIFIER);
> > +     if (ret)
> > +             goto out;
> > +
> > +     for_each_online_cpu(cpu) {
> > +             policy =3D cpufreq_cpu_get(cpu);
> > +             if (policy) {
> > +                     add_policy(policy);
> > +                     cpufreq_cpu_put(policy);
> > +             }
> > +     }
> > +out:
> > +     put_online_cpus();
> > +cnt_not_zero:
> > +     if (!ret)
> > +             cpufreq_cnt++;
> > +     mutex_unlock(&cpufreq_reg_lock);
> > +     return ret;
> > +}
> > +
> > +static int unregister_cpufreq(void)
> > +{
> > +     int ret =3D 0;
> > +     int cpu;
> > +
> > +     mutex_lock(&cpufreq_reg_lock);
> > +
> > +     if (cpufreq_cnt > 1)
> > +             goto out;
> > +
> > +     cpufreq_unregister_notifier(&cpufreq_trans_nb,
> > +                             CPUFREQ_TRANSITION_NOTIFIER);
> > +
> > +     for (cpu =3D ARRAY_SIZE(state) - 1; cpu >=3D 0; cpu--) {
> > +             if (!state[cpu])
> > +                     continue;
> > +             if (state[cpu]->first_cpu =3D=3D cpu)
> > +                     kfree(state[cpu]);
> > +             state[cpu] =3D NULL;
> > +     }
> > +
> > +out:
> > +     cpufreq_cnt--;
> > +     mutex_unlock(&cpufreq_reg_lock);
> > +     return ret;
> > +}
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D devfre=
q part =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +
> > +static unsigned int interpolate_freq(struct devfreq *df, unsigned int =
cpu)
> > +{
> > +     unsigned long *freq_table =3D df->profile->freq_table;
> > +     unsigned int cpu_min =3D state[cpu]->min_freq;
> > +     unsigned int cpu_max =3D state[cpu]->max_freq;
> > +     unsigned int cpu_freq =3D state[cpu]->freq;
> > +     unsigned int dev_min, dev_max, cpu_percent;
> > +
> > +     if (freq_table) {
> > +             dev_min =3D freq_table[0];
> > +             dev_max =3D freq_table[df->profile->max_state - 1];
> > +     } else {
> > +             if (df->max_freq <=3D df->min_freq)
> > +                     return 0;
> > +             dev_min =3D df->min_freq;
> > +             dev_max =3D df->max_freq;
> > +     }
> > +
> > +     cpu_percent =3D ((cpu_freq - cpu_min) * 100) / (cpu_max - cpu_min=
);
> > +     return dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
> > +}
> > +
> > +static unsigned int cpu_to_dev_freq(struct devfreq *df, unsigned int c=
pu)
> > +{
> > +     struct freq_map *map =3D NULL;
> > +     unsigned int cpu_khz =3D 0, freq;
> > +     struct devfreq_node *n =3D df->data;
> > +
> > +     if (!state[cpu] || state[cpu]->first_cpu !=3D cpu) {
> > +             freq =3D 0;
> > +             goto out;
> > +     }
> > +
> > +     if (n->common_map)
> > +             map =3D n->common_map;
> > +     else if (n->map)
> > +             map =3D n->map[cpu];
> > +
> > +     cpu_khz =3D state[cpu]->freq;
> > +
> > +     if (!map) {
> > +             freq =3D interpolate_freq(df, cpu);
> > +             goto out;
> > +     }
> > +
> > +     while (map->cpu_khz && map->cpu_khz < cpu_khz)
> > +             map++;
> > +     if (!map->cpu_khz)
> > +             map--;
> > +     freq =3D map->target_freq;
> > +
> > +out:
> > +     dev_dbg(df->dev.parent, "CPU%u: %d -> dev: %u\n", cpu, cpu_khz, f=
req);
> > +     return freq;
> > +}
> > +
> > +static int devfreq_cpufreq_get_freq(struct devfreq *df,
> > +                                     unsigned long *freq)
> > +{
> > +     unsigned int cpu, tgt_freq =3D 0;
> > +     struct devfreq_node *node;
> > +
> > +     node =3D df->data;
> > +     if (!node) {
> > +             pr_err("Unable to find devfreq node!\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     for_each_possible_cpu(cpu)
> > +             tgt_freq =3D max(tgt_freq, cpu_to_dev_freq(df, cpu));
> > +
> > +     *freq =3D tgt_freq;
> > +     return 0;
> > +}
> > +
> > +static unsigned int show_table(char *buf, unsigned int len,
> > +                             struct freq_map *map)
> > +{
> > +     unsigned int cnt =3D 0;
> > +
> > +     cnt +=3D snprintf(buf + cnt, len - cnt, "CPU freq\tDevice freq\n"=
);
> > +
> > +     while (map->cpu_khz && cnt < len) {
> > +             cnt +=3D snprintf(buf + cnt, len - cnt, "%8u\t%11u\n",
> > +                             map->cpu_khz, map->target_freq);
> > +             map++;
> > +     }
> > +     if (cnt < len)
> > +             cnt +=3D snprintf(buf + cnt, len - cnt, "\n");
> > +
> > +     return cnt;
> > +}
> > +
> > +static ssize_t freq_map_show(struct device *dev, struct device_attribu=
te *attr,
> > +                     char *buf)
> > +{
> > +     struct devfreq *df =3D to_devfreq(dev);
> > +     struct devfreq_node *n =3D df->data;
> > +     struct freq_map *map;
> > +     unsigned int cnt =3D 0, cpu;
> > +
> > +     mutex_lock(&state_lock);
> > +     if (n->common_map) {
> > +             map =3D n->common_map;
> > +             cnt +=3D snprintf(buf + cnt, PAGE_SIZE - cnt,
> > +                             "Common table for all CPUs:\n");
> > +             cnt +=3D show_table(buf + cnt, PAGE_SIZE - cnt, map);
> > +     } else if (n->map) {
> > +             for_each_possible_cpu(cpu) {
> > +                     map =3D n->map[cpu];
> > +                     if (!map)
> > +                             continue;
> > +                     cnt +=3D snprintf(buf + cnt, PAGE_SIZE - cnt,
> > +                                     "CPU %u:\n", cpu);
> > +                     if (cnt >=3D PAGE_SIZE)
> > +                             break;
> > +                     cnt +=3D show_table(buf + cnt, PAGE_SIZE - cnt, m=
ap);
> > +                     if (cnt >=3D PAGE_SIZE)
> > +                             break;
> > +             }
> > +     } else {
> > +             cnt +=3D snprintf(buf + cnt, PAGE_SIZE - cnt,
> > +                             "Device freq interpolated based on CPU fr=
eq\n");
> > +     }
> > +     mutex_unlock(&state_lock);
> > +
> > +     return cnt;
> > +}
> > +
> > +static DEVICE_ATTR_RO(freq_map);
> > +static struct attribute *dev_attr[] =3D {
> > +     &dev_attr_freq_map.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group dev_attr_group =3D {
> > +     .name =3D "cpufreq-map",
> > +     .attrs =3D dev_attr,
> > +};
> > +
> > +static int devfreq_cpufreq_gov_start(struct devfreq *devfreq)
> > +{
> > +     int ret =3D 0;
> > +     struct devfreq_node *node;
> > +     bool alloc =3D false;
> > +
> > +     ret =3D register_cpufreq();
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> > +     if (ret) {
> > +             unregister_cpufreq();
> > +             return ret;
> > +     }
> > +
> > +     mutex_lock(&state_lock);
> > +
> > +     node =3D find_devfreq_node(devfreq->dev.parent);
> > +     if (node =3D=3D NULL) {
> > +             node =3D kzalloc(sizeof(struct devfreq_node), GFP_KERNEL)=
;
> > +             if (!node) {
> > +                     ret =3D -ENOMEM;
> > +                     goto alloc_fail;
> > +             }
> > +             alloc =3D true;
> > +             node->dev =3D devfreq->dev.parent;
> > +             list_add_tail(&node->list, &devfreq_list);
> > +     }
> > +     node->df =3D devfreq;
> > +     node->orig_data =3D devfreq->data;
> > +     devfreq->data =3D node;
> > +
> > +     mutex_lock(&devfreq->lock);
> > +     ret =3D update_devfreq(devfreq);
> > +     mutex_unlock(&devfreq->lock);
> > +     if (ret) {
> > +             pr_err("Freq update failed!\n");
> > +             goto update_fail;
> > +     }
> > +
> > +     mutex_unlock(&state_lock);
> > +     return 0;
> > +
> > +update_fail:
> > +     devfreq->data =3D node->orig_data;
> > +     if (alloc) {
> > +             list_del(&node->list);
> > +             kfree(node);
> > +     }
> > +alloc_fail:
> > +     mutex_unlock(&state_lock);
> > +     sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
> > +     unregister_cpufreq();
> > +     return ret;
> > +}
> > +
> > +static void devfreq_cpufreq_gov_stop(struct devfreq *devfreq)
> > +{
> > +     struct devfreq_node *node =3D devfreq->data;
> > +
> > +     mutex_lock(&state_lock);
> > +     devfreq->data =3D node->orig_data;
> > +     if (node->map || node->common_map) {
> > +             node->df =3D NULL;
> > +     } else {
> > +             list_del(&node->list);
> > +             kfree(node);
> > +     }
> > +     mutex_unlock(&state_lock);
> > +
> > +     sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
> > +     unregister_cpufreq();
> > +}
> > +
> > +static int devfreq_cpufreq_ev_handler(struct devfreq *devfreq,
> > +                                     unsigned int event, void *data)
> > +{
> > +     int ret;
> > +
> > +     switch (event) {
> > +     case DEVFREQ_GOV_START:
> > +
> > +             ret =3D devfreq_cpufreq_gov_start(devfreq);
> > +             if (ret) {
> > +                     pr_err("Governor start failed!\n");
> > +                     return ret;
> > +             }
> > +             pr_debug("Enabled CPUfreq-map governor\n");
> > +             break;
> > +
> > +     case DEVFREQ_GOV_STOP:
> > +
> > +             devfreq_cpufreq_gov_stop(devfreq);
> > +             pr_debug("Disabled dev CPUfreq-map governor\n");
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct devfreq_governor devfreq_cpufreq =3D {
> > +     .name =3D "cpufreq-map",
> > +     .get_target_freq =3D devfreq_cpufreq_get_freq,
> > +     .event_handler =3D devfreq_cpufreq_ev_handler,
> > +};
> > +
> > +#define NUM_COLS     2
> > +static struct freq_map *read_tbl(struct device_node *of_node, char *pr=
op_name)
> > +{
> > +     int len, nf, i, j;
> > +     u32 data;
> > +     struct freq_map *tbl;
> > +
> > +     if (!of_find_property(of_node, prop_name, &len))
> > +             return NULL;
> > +     len /=3D sizeof(data);
> > +
> > +     if (len % NUM_COLS || len =3D=3D 0)
> > +             return NULL;
> > +     nf =3D len / NUM_COLS;
> > +
> > +     tbl =3D kzalloc((nf + 1) * sizeof(*tbl), GFP_KERNEL);
> > +     if (!tbl)
> > +             return NULL;
> > +
> > +     for (i =3D 0, j =3D 0; i < nf; i++, j +=3D 2) {
> > +             of_property_read_u32_index(of_node, prop_name, j, &data);
> > +             tbl[i].cpu_khz =3D data;
> > +
> > +             of_property_read_u32_index(of_node, prop_name, j + 1, &da=
ta);
> > +             tbl[i].target_freq =3D data;
> > +     }
> > +     tbl[i].cpu_khz =3D 0;
> > +
> > +     return tbl;
> > +}
> > +
> > +#define PROP_TARGET "target-dev"
> > +#define PROP_TABLE "cpu-to-dev-map"
> > +static int add_table_from_of(struct device_node *of_node)
> > +{
> > +     struct device_node *target_of_node;
> > +     struct devfreq_node *node;
> > +     struct freq_map *common_tbl;
> > +     struct freq_map **tbl_list =3D NULL;
> > +     static char prop_name[] =3D PROP_TABLE "-999999";
> > +     int cpu, ret, cnt =3D 0, prop_sz =3D ARRAY_SIZE(prop_name);
> > +
> > +     target_of_node =3D of_parse_phandle(of_node, PROP_TARGET, 0);
> > +     if (!target_of_node)
> > +             return -EINVAL;
> > +
> > +     node =3D kzalloc(sizeof(struct devfreq_node), GFP_KERNEL);
> > +     if (!node)
> > +             return -ENOMEM;
> > +
> > +     common_tbl =3D read_tbl(of_node, PROP_TABLE);
> > +     if (!common_tbl) {
> > +             tbl_list =3D kzalloc(sizeof(*tbl_list) * NR_CPUS, GFP_KER=
NEL);
> > +             if (!tbl_list) {
> > +                     ret =3D -ENOMEM;
> > +                     goto err_list;
> > +             }
> > +
> > +             for_each_possible_cpu(cpu) {
> > +                     ret =3D snprintf(prop_name, prop_sz, "%s-%d",
> > +                                     PROP_TABLE, cpu);
> > +                     if (ret >=3D prop_sz) {
> > +                             pr_warn("More CPUs than I can handle!\n")=
;
> > +                             pr_warn("Skipping rest of the tables!\n")=
;
> > +                             break;
> > +                     }
> > +                     tbl_list[cpu] =3D read_tbl(of_node, prop_name);
> > +                     if (tbl_list[cpu])
> > +                             cnt++;
> > +             }
> > +     }
> > +     if (!common_tbl && !cnt) {
> > +             ret =3D -EINVAL;
> > +             goto err_tbl;
> > +     }
> > +
> > +     mutex_lock(&state_lock);
> > +     node->of_node =3D target_of_node;
> > +     node->map =3D tbl_list;
> > +     node->common_map =3D common_tbl;
> > +     list_add_tail(&node->list, &devfreq_list);
> > +     mutex_unlock(&state_lock);
> > +
> > +     return 0;
> > +err_tbl:
> > +     kfree(tbl_list);
> > +err_list:
> > +     kfree(node);
> > +     return ret;
> > +}
> > +
> > +static int __init devfreq_cpufreq_init(void)
> > +{
> > +     int ret;
> > +     struct device_node *of_par, *of_child;
> > +
> > +     of_par =3D of_find_node_by_name(NULL, "devfreq-cpufreq-map");
> > +     if (of_par) {
> > +             for_each_child_of_node(of_par, of_child) {
> > +                     ret =3D add_table_from_of(of_child);
> > +                     if (ret)
> > +                             pr_err("Parsing %s failed!\n", of_child->=
name);
> > +                     else
> > +                             pr_debug("Parsed %s.\n", of_child->name);
> > +             }
> > +             of_node_put(of_par);
> > +     } else {
> > +             pr_info("No tables parsed from DT.\n");
> > +     }
> > +
> > +     ret =3D devfreq_add_governor(&devfreq_cpufreq);
> > +     if (ret) {
> > +             pr_err("cpufreq-map governor add failed!\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +subsys_initcall(devfreq_cpufreq_init);
> > +
> > +static void __exit devfreq_cpufreq_exit(void)
> > +{
> > +     int ret, cpu;
> > +     struct devfreq_node *node, *tmp;
> > +
> > +     ret =3D devfreq_remove_governor(&devfreq_cpufreq);
> > +     if (ret)
> > +             pr_err("cpufreq-map governor remove failed!\n");
> > +
> > +     mutex_lock(&state_lock);
> > +     list_for_each_entry_safe(node, tmp, &devfreq_list, list) {
> > +             kfree(node->common_map);
> > +             for_each_possible_cpu(cpu)
> > +                     kfree(node->map[cpu]);
> > +             kfree(node->map);
> > +             list_del(&node->list);
> > +             kfree(node);
> > +     }
> > +     mutex_unlock(&state_lock);
> > +}
> > +module_exit(devfreq_cpufreq_exit);
> > +
> > +MODULE_DESCRIPTION("devfreq gov that sets dev freq based on current CP=
U freq");
> > +MODULE_LICENSE("GPL v2");
> >
