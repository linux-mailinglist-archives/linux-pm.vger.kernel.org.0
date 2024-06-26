Return-Path: <linux-pm+bounces-9992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8889C9176F2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136662839AF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF107404E;
	Wed, 26 Jun 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwPkJqbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA65336A;
	Wed, 26 Jun 2024 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719373909; cv=none; b=hQBRIF3WlN7PwXZnOnZJhhDTn09XEikGDrwMTNZAlrlzNv4MWUeGph3Whvs/maqSLdnuVC0XzDe2gVk0/B/SgHV5EMHpg7S1JmX/jFdkHDHwbl06WM0R/cutjaJBzXQ0UWalfExW2qmwg+hgSFnMLBNVz1So//H+mW2fisy+tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719373909; c=relaxed/simple;
	bh=isA2/HcLANBKHBlyGFkDHYj5iHNJIWkoC0dST0avnps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO6lLFX19+Ogb1Oc66YQhsOf0q49tOQjLnOE/+wrpsKT6df7ky1FSos6pLxBPk7YPUmNItQIjYuLLSoWnuGnVHag71AMtRsdjtJO6QLjtXP86dNdLxCd6fFTiGo9EvFnCInbsl7KhYoEi5S0i4ICWwajKnLfBQKsGbTyxnl4e8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwPkJqbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C37DC4AF0A;
	Wed, 26 Jun 2024 03:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719373908;
	bh=isA2/HcLANBKHBlyGFkDHYj5iHNJIWkoC0dST0avnps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nwPkJqbtJgMIetClU8bqYkDua8dyoIVdaM+c5KBMIWo7ZU5hjiRF8cfUzSoaDSLEF
	 b+qGkd/XG/aRWdKsWRNYF3A2o+KxpLFAmRn2lvAN94cd6/+R3qxPgkhsZelZbmUPTX
	 p+YA1PKEvQHmHmUzQuNOpaXjqjC6Yv86iZvr1veM2BYZb4n0/IEcdqwJ2a5zyJMqU3
	 EmJ+FvNjlUW8OSerpor+EKrWxZGak1+aWMpDW660Xir2kmHAiekPvIoH0VgveKH1by
	 Om+T8KWQqR5AysKFacP1v/hEBikZmTdBa9QjfagJcke9FFQOolERpKJXYtO746aFCd
	 JQbxl5Vx9ExUg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso7175851a12.2;
        Tue, 25 Jun 2024 20:51:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzQ0DPrXPvYhOawtW3lSlLrnyln0BrRP6Xfty8u97lXPdoCVJ3xPVK51pNhpGUxjbZ7LFS83+gIKsqG09Ydw7YUlS+KzLOQ4kTecrO1DWxxjkeSNxtqADQxkyrr4ZDHRmNn+fmKV0=
X-Gm-Message-State: AOJu0Ywv08W2mje3zJXAgmNjbvPVAxrUf3Zlki5t4GuUNws9SDV4uflp
	WhQdbz0nsIPmZSLdcSbnOtTMd7l8ENHKCKjAeQzLUh5a8bP9zeV7+jzBcuvRnok1VoYfGNc74oK
	pjWihILPr5Oknsw1qDckRCqz+U+g=
X-Google-Smtp-Source: AGHT+IHX6lBr/gceu/U3kNhSDzLUtOR2Sf6P24zH4cshM1/ZfwqHJU5e7zjXvrj9qeedOGr3znbI9WYv++0ZAY8Lo7w=
X-Received: by 2002:a17:906:3384:b0:a6f:309d:ec23 with SMTP id
 a640c23a62f3a-a7245cc4df0mr572611566b.72.1719373906765; Tue, 25 Jun 2024
 20:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064205.2041548-1-chenhuacai@loongson.cn>
 <20240612064205.2041548-3-chenhuacai@loongson.cn> <20240625075645.m372bpbe7m2dozil@vireshk-i7>
In-Reply-To: <20240625075645.m372bpbe7m2dozil@vireshk-i7>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Jun 2024 11:51:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5wSzhD373L61Mxvu-7ZUSGh9LmC4yBoaHm_5rAxsu-5w@mail.gmail.com>
Message-ID: <CAAhV-H5wSzhD373L61Mxvu-7ZUSGh9LmC4yBoaHm_5rAxsu-5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Viresh,

Thank you for your review.

On Tue, Jun 25, 2024 at 3:56=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 12-06-24, 14:42, Huacai Chen wrote:
> > Some of LoongArch processors (Loongson-3 series) support DVFS, their
> > IOCSR.FEATURES has IOCSRF_FREQSCALE set. And they has a micro-core in
> > the package called SMC (System Management Controller), which can be
> > used to detect temperature, control fans, scale frequency and voltage,
> > etc.
> >
> > The Loongson-3 CPUFreq driver is very simple now, it communicate with
> > SMC, get DVFS info, set target frequency from CPUFreq core, and so on.
> >
> > There is a command list to interact with SMC, widely-used commands in
> > the CPUFreq driver include:
> >
> > CMD_GET_VERSION: Get SMC firmware version.
> >
> > CMD_GET_FEATURE: Get enabled SMC features.
> >
> > CMD_SET_FEATURE: Enable SMC features, such as basic DVFS, BOOST.
> >
> > CMD_GET_FREQ_LEVEL_NUM: Get the number of normal frequency levels.
> >
> > CMD_GET_FREQ_BOOST_NUM: Get the number of boost frequency levels.
> >
> > CMD_GET_FREQ_LEVEL_INFO: Get the detail info of a frequency level.
> >
> > CMD_GET_FREQ_INFO: Get the current frequency.
> >
> > CMD_SET_FREQ_INFO: Set the target frequency.
> >
> > In future we will add automatic frequency scaling, which is similar to
> > Intel's HWP (HardWare P-State).
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/cpufreq/Kconfig             |  12 +
> >  drivers/cpufreq/Makefile            |   1 +
> >  drivers/cpufreq/loongson3_cpufreq.c | 442 ++++++++++++++++++++++++++++
> >  3 files changed, 455 insertions(+)
> >  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aacccb376c28..f2e47ec28d77 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12968,6 +12968,7 @@ F:    Documentation/arch/loongarch/
> >  F:   Documentation/translations/zh_CN/arch/loongarch/
> >  F:   arch/loongarch/
> >  F:   drivers/*/*loongarch*
> > +F:   drivers/cpufreq/loongson3_cpufreq.c
> >
> >  LOONGSON GPIO DRIVER
> >  M:   Yinbo Zhu <zhuyinbo@loongson.cn>
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 94e55c40970a..10cda6f2fe1d 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -262,6 +262,18 @@ config LOONGSON2_CPUFREQ
> >         If in doubt, say N.
> >  endif
> >
> > +if LOONGARCH
> > +config LOONGSON3_CPUFREQ
> > +     tristate "Loongson3 CPUFreq Driver"
> > +     help
> > +       This option adds a CPUFreq driver for Loongson processors which
> > +       support software configurable cpu frequency.
> > +
> > +       Loongson-3 family processors support this feature.
> > +
> > +       If in doubt, say N.
> > +endif
> > +
> >  if SPARC64
> >  config SPARC_US3_CPUFREQ
> >       tristate "UltraSPARC-III CPU Frequency driver"
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 8d141c71b016..0f184031dd12 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -103,6 +103,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)             +=3D powe=
rnv-cpufreq.o
> >  # Other platform drivers
> >  obj-$(CONFIG_BMIPS_CPUFREQ)          +=3D bmips-cpufreq.o
> >  obj-$(CONFIG_LOONGSON2_CPUFREQ)              +=3D loongson2_cpufreq.o
> > +obj-$(CONFIG_LOONGSON3_CPUFREQ)              +=3D loongson3_cpufreq.o
> >  obj-$(CONFIG_SH_CPU_FREQ)            +=3D sh-cpufreq.o
> >  obj-$(CONFIG_SPARC_US2E_CPUFREQ)     +=3D sparc-us2e-cpufreq.o
> >  obj-$(CONFIG_SPARC_US3_CPUFREQ)              +=3D sparc-us3-cpufreq.o
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loon=
gson3_cpufreq.c
> > new file mode 100644
> > index 000000000000..5dbac0d55a32
> > --- /dev/null
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -0,0 +1,442 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * CPUFreq driver for the loongson-3 processors
> > + *
> > + * All revisions of Loongson-3 processor support this feature.
> > + *
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/units.h>
> > +
> > +#include <asm/idle.h>
> > +#include <asm/loongarch.h>
> > +#include <asm/loongson.h>
> > +
> > +/* Message */
> > +union smc_message {
> > +     u32 value;
> > +     struct {
> > +             u32 id          : 4;
> > +             u32 info        : 4;
> > +             u32 val         : 16;
> > +             u32 cmd         : 6;
> > +             u32 extra       : 1;
> > +             u32 complete    : 1;
> > +     };
> > +};
> > +
> > +/* Command return values */
> > +#define CMD_OK                               0  /* No error */
> > +#define CMD_ERROR                    1  /* Regular error */
> > +#define CMD_NOCMD                    2  /* Command does not support */
> > +#define CMD_INVAL                    3  /* Invalid Parameter */
> > +
> > +/* Version commands */
> > +/*
> > + * CMD_GET_VERSION - Get interface version
> > + * Input: none
> > + * Output: version
> > + */
> > +#define CMD_GET_VERSION                      0x1
> > +
> > +/* Feature commands */
> > +/*
> > + * CMD_GET_FEATURE - Get feature state
> > + * Input: feature ID
> > + * Output: feature flag
> > + */
> > +#define CMD_GET_FEATURE                      0x2
> > +
> > +/*
> > + * CMD_SET_FEATURE - Set feature state
> > + * Input: feature ID, feature flag
> > + * output: none
> > + */
> > +#define CMD_SET_FEATURE                      0x3
> > +
> > +/* Feature IDs */
> > +#define FEATURE_SENSOR                       0
> > +#define FEATURE_FAN                  1
> > +#define FEATURE_DVFS                 2
> > +
> > +/* Sensor feature flags */
> > +#define FEATURE_SENSOR_ENABLE                BIT(0)
> > +#define FEATURE_SENSOR_SAMPLE                BIT(1)
> > +
> > +/* Fan feature flags */
> > +#define FEATURE_FAN_ENABLE           BIT(0)
> > +#define FEATURE_FAN_AUTO             BIT(1)
> > +
> > +/* DVFS feature flags */
> > +#define FEATURE_DVFS_ENABLE          BIT(0)
> > +#define FEATURE_DVFS_BOOST           BIT(1)
> > +#define FEATURE_DVFS_AUTO            BIT(2)
> > +#define FEATURE_DVFS_SINGLE_BOOST    BIT(3)
> > +
> > +/* Sensor commands */
> > +/*
> > + * CMD_GET_SENSOR_NUM - Get number of sensors
> > + * Input: none
> > + * Output: number
> > + */
> > +#define CMD_GET_SENSOR_NUM           0x4
> > +
> > +/*
> > + * CMD_GET_SENSOR_STATUS - Get sensor status
> > + * Input: sensor ID, type
> > + * Output: sensor status
> > + */
> > +#define CMD_GET_SENSOR_STATUS                0x5
> > +
> > +/* Sensor types */
> > +#define SENSOR_INFO_TYPE             0
> > +#define SENSOR_INFO_TYPE_TEMP                1
> > +
> > +/* Fan commands */
> > +/*
> > + * CMD_GET_FAN_NUM - Get number of fans
> > + * Input: none
> > + * Output: number
> > + */
> > +#define CMD_GET_FAN_NUM                      0x6
> > +
> > +/*
> > + * CMD_GET_FAN_INFO - Get fan status
> > + * Input: fan ID, type
> > + * Output: fan info
> > + */
> > +#define CMD_GET_FAN_INFO             0x7
> > +
> > +/*
> > + * CMD_SET_FAN_INFO - Set fan status
> > + * Input: fan ID, type, value
> > + * Output: none
> > + */
> > +#define CMD_SET_FAN_INFO             0x8
> > +
> > +/* Fan types */
> > +#define FAN_INFO_TYPE_LEVEL          0
> > +
> > +/* DVFS commands */
> > +/*
> > + * CMD_GET_FREQ_LEVEL_NUM - Get number of freq levels
> > + * Input: CPU ID
> > + * Output: number
> > + */
> > +#define CMD_GET_FREQ_LEVEL_NUM               0x9
> > +
> > +/*
> > + * CMD_GET_FREQ_BOOST_LEVEL - Get number of boost levels
> > + * Input: CPU ID
> > + * Output: number
> > + */
> > +#define CMD_GET_FREQ_BOOST_LEVEL     0x10
> > +
> > +/*
> > + * CMD_GET_FREQ_LEVEL_INFO - Get freq level info
> > + * Input: CPU ID, level ID
> > + * Output: level info
> > + */
> > +#define CMD_GET_FREQ_LEVEL_INFO              0x11
> > +
> > +/*
> > + * CMD_GET_FREQ_INFO - Get freq info
> > + * Input: CPU ID, type
> > + * Output: freq info
> > + */
> > +#define CMD_GET_FREQ_INFO            0x12
> > +
> > +/*
> > + * CMD_SET_FREQ_INFO - Set freq info
> > + * Input: CPU ID, type, value
> > + * Output: none
> > + */
> > +#define CMD_SET_FREQ_INFO            0x13
> > +
> > +/* Freq types */
> > +#define FREQ_INFO_TYPE_FREQ          0
> > +#define FREQ_INFO_TYPE_LEVEL         1
> > +
> > +#define FREQ_MAX_LEVEL                       (16 + 1)
> > +
> > +enum freq {
> > +     FREQ_LEV0, /* Reserved */
> > +     FREQ_LEV1, FREQ_LEV2, FREQ_LEV3, FREQ_LEV4,
> > +     FREQ_LEV5, FREQ_LEV6, FREQ_LEV7, FREQ_LEV8,
> > +     FREQ_LEV9, FREQ_LEV10, FREQ_LEV11, FREQ_LEV12,
> > +     FREQ_LEV13, FREQ_LEV14, FREQ_LEV15, FREQ_LEV16,
> > +     FREQ_RESV
> > +};
> > +
> > +struct loongson3_freq_data {
> > +     unsigned int cur_cpu_freq;
>
> You never use it. Remove it.
Emm, it is used in loongson3_cpufreq_get().

>
> > +     struct cpufreq_frequency_table table[];
> > +};
> > +
> > +static struct mutex cpufreq_mutex[MAX_PACKAGES];
> > +static struct cpufreq_driver loongson3_cpufreq_driver;
> > +static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
> > +
> > +static inline int do_service_request(union smc_message *msg)
> > +{
> > +     int retries;
> > +     union smc_message last;
> > +
> > +     last.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> > +     if (!last.complete)
> > +             return -EPERM;
> > +
> > +     iocsr_write32(msg->value, LOONGARCH_IOCSR_SMCMBX);
> > +     iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MIS=
C_FUNC_SOFT_INT,
> > +                   LOONGARCH_IOCSR_MISC_FUNC);
> > +
> > +     for (retries =3D 0; retries < 10000; retries++) {
> > +             msg->value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> > +             if (msg->complete)
> > +                     break;
> > +
> > +             usleep_range(8, 12);
> > +     }
> > +
> > +     if (!msg->complete || msg->cmd !=3D CMD_OK)
> > +             return -EPERM;
> > +
> > +     return 0;
> > +}
> > +
> > +static unsigned int loongson3_cpufreq_get(unsigned int cpu)
> > +{
> > +     union smc_message msg;
> > +
> > +     msg.id          =3D cpu;
> > +     msg.info        =3D FREQ_INFO_TYPE_FREQ;
> > +     msg.cmd         =3D CMD_GET_FREQ_INFO;
> > +     msg.extra       =3D 0;
> > +     msg.complete    =3D 0;
> > +     do_service_request(&msg);
> > +
> > +     per_cpu(freq_data, cpu)->cur_cpu_freq =3D msg.val * KILO;
> > +
> > +     return per_cpu(freq_data, cpu)->cur_cpu_freq;
> > +}
> > +
> > +static int loongson3_cpufreq_set(struct cpufreq_policy *policy, int fr=
eq_level)
> > +{
> > +     union smc_message msg;
> > +
> > +     msg.id          =3D cpu_data[policy->cpu].core;
> > +     msg.info        =3D FREQ_INFO_TYPE_LEVEL;
> > +     msg.val         =3D freq_level;
> > +     msg.cmd         =3D CMD_SET_FREQ_INFO;
> > +     msg.extra       =3D 0;
> > +     msg.complete    =3D 0;
> > +     do_service_request(&msg);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Here we notify other drivers of the proposed change and the final c=
hange.
> > + */
> > +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, uns=
igned int index)
> > +{
> > +     unsigned int cpu =3D policy->cpu;
> > +     unsigned int package =3D cpu_data[cpu].package;
> > +
> > +     if (!cpu_online(cpu))
>
> No need to check this.
OK, thanks.

>
> > +             return -ENODEV;
> > +
> > +     /* setting the cpu frequency */
> > +     mutex_lock(&cpufreq_mutex[package]);
>
> No locking required here. Core doesn't call them in parallel.
I'm a bit confused, I think different cores may call .target() in
parallel. Cores in the same package share the same
LOONGARCH_IOCSR_SMCMBX register, so I think the lock is required.

>
> > +     loongson3_cpufreq_set(policy, index);
> > +     mutex_unlock(&cpufreq_mutex[package]);
> > +
> > +     return 0;
> > +}
> > +
> > +static int loongson3_cpufreq_get_freq_table(int cpu)
> > +{
> > +     union smc_message msg;
> > +     int i, ret, boost_level, max_level, freq_level;
> > +     struct loongson3_freq_data *data;
> > +
> > +     if (per_cpu(freq_data, cpu))
> > +             return 0;
>
> Will this ever be true ?
Yes, loongson3_cpufreq_get_freq_table() is called multiple times while
CPU hotplug.

>
> > +
> > +     msg.id          =3D cpu;
> > +     msg.cmd         =3D CMD_GET_FREQ_LEVEL_NUM;
> > +     msg.extra       =3D 0;
> > +     msg.complete    =3D 0;
> > +     ret =3D do_service_request(&msg);
> > +     if (ret < 0)
> > +             return ret;
> > +     max_level =3D msg.val;
> > +
>
>
> > +     msg.id          =3D cpu;
> > +     msg.cmd         =3D CMD_GET_FREQ_BOOST_LEVEL;
> > +     msg.extra       =3D 0;
> > +     msg.complete    =3D 0;
> > +     ret =3D do_service_request(&msg);
> > +     if (ret < 0)
> > +             return ret;
> > +     boost_level =3D msg.val;
>
> This stuff is repeated a lot, maybe create a generic function for this
> ?
Do you means move the msg filling into do_service_request()?

>
> > +
> > +     freq_level =3D min(max_level, FREQ_MAX_LEVEL);
> > +     data =3D kzalloc(struct_size(data, table, freq_level + 1), GFP_KE=
RNEL);
>
> devm_kzalloc(pdev, ...) ?
OK, that seems better.

>
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < freq_level; i++) {
> > +             msg.id          =3D cpu;
> > +             msg.info        =3D FREQ_INFO_TYPE_FREQ;
> > +             msg.cmd         =3D CMD_GET_FREQ_LEVEL_INFO;
> > +             msg.val         =3D i;
> > +             msg.complete    =3D 0;
> > +
> > +             ret =3D do_service_request(&msg);
> > +             if (ret < 0) {
> > +                     kfree(data);
> > +                     return ret;
> > +             }
> > +
> > +             data->table[i].frequency =3D msg.val * KILO;
> > +             data->table[i].driver_data =3D FREQ_LEV0 + i;
> > +             data->table[i].flags =3D (i >=3D boost_level) ? CPUFREQ_B=
OOST_FREQ : 0;
> > +     }
> > +
> > +     data->table[freq_level].frequency =3D CPUFREQ_TABLE_END;
> > +     data->table[freq_level].driver_data =3D FREQ_RESV;
> > +     data->table[freq_level].flags =3D 0;
> > +
> > +     per_cpu(freq_data, cpu) =3D data;
> > +
> > +     return 0;
> > +}
> > +
> > +static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +     int ret;
> > +
> > +     if (!cpu_online(policy->cpu))
>
> No need to check this. Core takes care of this already.
OK, thanks.

>
> > +             return -ENODEV;
> > +
> > +     ret =3D loongson3_cpufreq_get_freq_table(policy->cpu);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     policy->cur =3D loongson3_cpufreq_get(policy->cpu);
> > +     policy->cpuinfo.transition_latency =3D 10000;
> > +     policy->freq_table =3D per_cpu(freq_data, policy->cpu)->table;
> > +     cpumask_copy(policy->cpus, topology_sibling_cpumask(policy->cpu))=
;
> > +
> > +     if (policy_has_boost_freq(policy)) {
> > +             ret =3D cpufreq_enable_boost_support();
> > +             if (ret < 0) {
> > +                     pr_warn("cpufreq: Failed to enable boost: %d\n", =
ret);
> > +                     return ret;
> > +             }
> > +             loongson3_cpufreq_driver.boost_enabled =3D true;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +     return 0;
> > +}
>
> Just drop the routine, it is optional.
OK, thanks.

>
> > +
> > +static struct cpufreq_driver loongson3_cpufreq_driver =3D {
> > +     .name =3D "loongson3",
> > +     .flags =3D CPUFREQ_CONST_LOOPS,
> > +     .init =3D loongson3_cpufreq_cpu_init,
> > +     .exit =3D loongson3_cpufreq_cpu_exit,
> > +     .verify =3D cpufreq_generic_frequency_table_verify,
> > +     .target_index =3D loongson3_cpufreq_target,
> > +     .get =3D loongson3_cpufreq_get,
> > +     .attr =3D cpufreq_generic_attr,
> > +};
> > +
> > +static struct platform_device_id cpufreq_id_table[] =3D {
> > +     { "loongson3_cpufreq", },
> > +     { /* sentinel */ }
> > +};
> > +
>
> Remove this blank line please.
OK, thanks.

>
> > +MODULE_DEVICE_TABLE(platform, cpufreq_id_table);
> > +
> > +static struct platform_driver loongson3_platform_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "loongson3_cpufreq",
> > +     },
> > +     .id_table =3D cpufreq_id_table,
> > +};
> > +
> > +static int configure_cpufreq_info(void)
> > +{
> > +     int ret;
> > +     union smc_message msg;
> > +
> > +     msg.cmd         =3D CMD_GET_VERSION;
> > +     msg.extra       =3D 0;
> > +     msg.complete    =3D 0;
> > +     ret =3D do_service_request(&msg);
> > +     if (ret < 0 || msg.val < 0x1)
> > +             return -EPERM;
> > +
> > +     msg.id          =3D FEATURE_DVFS;
> > +     msg.cmd         =3D CMD_SET_FEATURE;
> > +     msg.val         =3D FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST;
> > +     msg.extra       =3D 0;
> > +     msg.complete    =3D 0;
> > +     ret =3D do_service_request(&msg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init cpufreq_init(void)
> > +{
> > +     int i, ret;
> > +
> > +     ret =3D platform_driver_register(&loongson3_platform_driver);
> > +     if (ret)
> > +             return ret;
>
> What is the use of this platform driver ? I thought the whole purpose
> of the platform device/driver in your case was to probe this driver.
> In that case cpufreq_init() should only be doing above and not the
> below part. The rest should be handled in the probe() function of the
> driver.
This driver file is now a very basic version, in future it will be a
little like intel_pstate that has more than one cpufreq_drivers
(active/passive, hwp/nohwp, etc.), so it will register different
cpufreq_drivers depends on the result of configure_cpufreq_info().

>
> > +
> > +     ret =3D configure_cpufreq_info();
> > +     if (ret)
> > +             goto err;
> > +
> > +     for (i =3D 0; i < MAX_PACKAGES; i++)
> > +             mutex_init(&cpufreq_mutex[i]);
>
> You don't need this at all.
See above.

>
> > +
> > +     ret =3D cpufreq_register_driver(&loongson3_cpufreq_driver);
> > +     if (ret)
> > +             goto err;
> > +
> > +     pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
>
> Make this pr_debug if you want.. There is not much use of this for the
> user.
Emm, I just want to see a line in dmesg.


>
> > +
> > +     return 0;
> > +
> > +err:
> > +     platform_driver_unregister(&loongson3_platform_driver);
> > +     return ret;
> > +}
> > +
> > +static void __exit cpufreq_exit(void)
> > +{
> > +     cpufreq_unregister_driver(&loongson3_cpufreq_driver);
> > +     platform_driver_unregister(&loongson3_platform_driver);
> > +}
> > +
> > +module_init(cpufreq_init);
> > +module_exit(cpufreq_exit);
>
> You can just use: module_platform_driver() instead of above functions
> and declarations.
>
> > +
> > +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> > +MODULE_DESCRIPTION("CPUFreq driver for Loongson-3 processors");
> > +MODULE_LICENSE("GPL");
>
> --
> viresh
>

