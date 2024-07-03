Return-Path: <linux-pm+bounces-10549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59993926390
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD4128090A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0D17BB13;
	Wed,  3 Jul 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtnegB6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A818C08;
	Wed,  3 Jul 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017481; cv=none; b=sf1mKAs8GpPjaN2oAf93sIcuUf9/1ZI736S7DZxiaKpBnv/a1dvT4KBtbuV0+FX6Nyfgh+zJQ4SsFbjmebRsXDW2g4x5RHsJitF5HyzhCNPxlgQbkh4jfBxBirfZN2c2aTBxLZfceEvuWYGp3li5uxjznOotP61Cr1yUCaI+eu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017481; c=relaxed/simple;
	bh=9fQrsdABjkrH4cRRS6+W8rK2EpChjZXbqbmbLXoomlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG56tM4bat45vvUNKQFr5ugprcHosR3z/yeXzVxjzGPTMfd80ry7ITOJLjyKHH8cWmFyY1Yg+NQ8xWdsjMqK0iFQBpj2weA8F6E1ZuMiabxn43u5jLorGSMcesJm9s8Rm5hiCYRdY4I7zl7mkbmtLiZya1T0Qts0hL59lbcRhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtnegB6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41BFC32781;
	Wed,  3 Jul 2024 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720017480;
	bh=9fQrsdABjkrH4cRRS6+W8rK2EpChjZXbqbmbLXoomlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qtnegB6MSGcwkcgnGs37nsWSTXLOQRU0YFLGIPNOsDES6ppE5jT472rgkIT8FpPuC
	 fF2g+G/5sEbZ73+t2G9rG0NScdFgCwxJ399PNxVidD4XCSPtCtXku7sg4VUexZOm6i
	 Nua53s7ZotK4q0b0Y7085FRL4uOCd5/rhB1EUwO+EMFf7gJMLIisAt78RxRgrnzL41
	 g7G7SaoNJhquvAFaoED6xaJZZwWyEnj1NF/sVRKjDqjD5H5G3PKXsHBlv8XZLAXNG7
	 fFGkVgnR3LQwLkZZ+d+JDRdhoMYyUVpMceEy4agkujDvWucYO7IBGMp4fjiZpXIQpY
	 AoLjd/JLzr6Uw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so635110366b.2;
        Wed, 03 Jul 2024 07:38:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXd3z7iT/jmdULDxpbNsCS9k/jT+UO/rmvR34lMwuIk5vy+HVC8K8HIV0o4b5wM/o9+97u8JYYEWS1AVQbaMZgLlVQuRn9D5+zFbtSNQYOxVYW5NW6URAACS3kcgvouWYczb6OzJlI=
X-Gm-Message-State: AOJu0Yy0B9u0POEJkgSTDzOaELLrGCWHusfSOa6gbWc5t+LaGr3VQX0P
	n8ouDpPfMHiouiHtho5kWT8K0NPjvV2nEfcz6J3mJvKmr+pyyW65rcFDuT9svlFUnpw4SQtdCGM
	1roSCZoKGbgw9yZlPyx08dUhu9kQ=
X-Google-Smtp-Source: AGHT+IE50KLf3lFNcX0ULPBaHHXUH0kvHS5HaRTgxw3Pa1cLetXWbvf5gxw5XjU8VDIHmFCAjsJixPQvrJAlKzQk10s=
X-Received: by 2002:a17:906:27c9:b0:a6f:6ae6:8ae8 with SMTP id
 a640c23a62f3a-a751445fa34mr766551966b.74.1720017479233; Wed, 03 Jul 2024
 07:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702152737.1184244-1-chenhuacai@loongson.cn>
 <20240702152737.1184244-3-chenhuacai@loongson.cn> <20240703101850.dtck223pleiiwfxp@vireshk-i7>
In-Reply-To: <20240703101850.dtck223pleiiwfxp@vireshk-i7>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Jul 2024 22:37:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74HJr0=8g0GtHj=zZH5nJijRpc90zLLRY_sXJfKFVtHA@mail.gmail.com>
Message-ID: <CAAhV-H74HJr0=8g0GtHj=zZH5nJijRpc90zLLRY_sXJfKFVtHA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Viresh,

On Wed, Jul 3, 2024 at 6:18=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 02-07-24, 23:27, Huacai Chen wrote:
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
> >  MAINTAINERS                         |   1 +
> >  drivers/cpufreq/Kconfig             |  12 +
> >  drivers/cpufreq/Makefile            |   1 +
> >  drivers/cpufreq/loongson3_cpufreq.c | 399 ++++++++++++++++++++++++++++
> >  4 files changed, 413 insertions(+)
> >  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd2ca0c3158e..2af33319f1ff 100644
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
> > index 000000000000..6d7da2238542
> > --- /dev/null
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -0,0 +1,399 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * CPUFreq driver for the loongson-3 processors
>
> A full stop at the end please.
OK, thanks.

>
> > + *
> > + * All revisions of Loongson-3 processor support this feature.
>
> What do you mean by `feature` here ?
Means "cpu_has_freqscale", will modify in next version.

>
> > + *
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
>
> Can't really use 2020 here. We are adding the driver for the first
> time in 2024 only.
OK, thanks.

>
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/units.h>
>
> Please keep them in alphabetical order.  And you are missing few other
> headers (which are getting included indirectly for now). Like for
> mutex. Please cross check all types you are using and include their
> headers directly.
OK, thanks.

>
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
> > +static struct mutex cpufreq_mutex[MAX_PACKAGES];
> > +static struct cpufreq_driver loongson3_cpufreq_driver;
> > +static DEFINE_PER_CPU(struct cpufreq_frequency_table *, freq_table);
> > +
> > +static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 va=
l, u32 extra)
> > +{
> > +     int retries;
> > +     unsigned int cpu =3D smp_processor_id();
> > +     unsigned int package =3D cpu_data[cpu].package;
> > +     union smc_message msg, last;
> > +
> > +     mutex_lock(&cpufreq_mutex[package]);
> > +
> > +     last.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> > +     if (!last.complete) {
> > +             mutex_unlock(&cpufreq_mutex[package]);
> > +             return -EPERM;
> > +     }
> > +
> > +     msg.id          =3D id;
> > +     msg.info        =3D info;
> > +     msg.cmd         =3D cmd;
> > +     msg.val         =3D val;
> > +     msg.extra       =3D extra;
> > +     msg.complete    =3D 0;
> > +
> > +     iocsr_write32(msg.value, LOONGARCH_IOCSR_SMCMBX);
> > +     iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MIS=
C_FUNC_SOFT_INT,
> > +                   LOONGARCH_IOCSR_MISC_FUNC);
> > +
> > +     for (retries =3D 0; retries < 10000; retries++) {
> > +             msg.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> > +             if (msg.complete)
> > +                     break;
> > +
> > +             usleep_range(8, 12);
> > +     }
> > +
> > +     if (!msg.complete || msg.cmd !=3D CMD_OK) {
> > +             mutex_unlock(&cpufreq_mutex[package]);
> > +             return -EPERM;
> > +     }
> > +
> > +     mutex_unlock(&cpufreq_mutex[package]);
> > +
> > +     return msg.val;
>
> Thanks, this looks much better now.
>
> > +}
> > +
> > +static unsigned int loongson3_cpufreq_get(unsigned int cpu)
> > +{
> > +     int ret;
> > +
> > +     ret =3D do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ=
_INFO, 0, 0);
> > +
> > +     return ret * KILO;
> > +}
> > +
> > +static int loongson3_cpufreq_set(struct cpufreq_policy *policy, int fr=
eq_level)
> > +{
> > +     return do_service_request(cpu_data[policy->cpu].core, FREQ_INFO_T=
YPE_LEVEL, CMD_SET_FREQ_INFO, freq_level, 0);
> > +}
> > +
> > +/*
> > + * Here we notify other drivers of the proposed change and the final c=
hange.
>
> What do you mean by other drivers here ? I would just drop the
> comment.
OK, it will be dropped.

>
> > + */
> > +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, uns=
igned int index)
> > +{
> > +     /* setting the cpu frequency */
>
> The obvious comments can be dropped.
OK, it will be dropped.

>
> > +     return loongson3_cpufreq_set(policy, index);
>
> Why use a separate function for calling do_service_request() ? Just
> open code it here.
Hmm, there is a loongson3_cpufreq_get() function, so I make a
loongson3_cpufreq_set() function, too.

>
> > +}
> > +
> > +static int loongson3_cpufreq_get_freq_table(int cpu)
>
> If you want to simplify the naming a bit, you can just call all
> internal routines without `loongson3_cpufreq_` prefix. Just
> create_freq_table() would be appropriate here.
OK, I will rename this function.

>
> For all routines passed to core, via the cpufreq_driver pointers, you
> can keep using the prefix.
>
> > +{
> > +     int i, ret, boost_level, max_level, freq_level;
> > +     struct cpufreq_frequency_table *table;
> > +
> > +     if (per_cpu(freq_table, cpu))
> > +             return 0;
> > +
> > +     ret =3D do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
> > +     if (ret < 0)
> > +             return ret;
> > +     max_level =3D ret;
> > +
> > +     ret =3D do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0=
);
> > +     if (ret < 0)
> > +             return ret;
> > +     boost_level =3D ret;
> > +
> > +     freq_level =3D min(max_level, FREQ_MAX_LEVEL);
> > +     table =3D kzalloc(sizeof(struct cpufreq_frequency_table) * (freq_=
level + 1), GFP_KERNEL);
>
> devm_kcalloc(pdev, ...) instead ?
I remember you told me this in V1, but devm_kalloc() needs a pdev
instance, which doesn't exist here, so I keep kzalloc().

>
> sizeof(*table) instead.
OK, thanks.

>
> Also please run `scripts/checkpatch.pl --strict` on your patches to
> find out general formatting issues.
OK, I will run checkpatch.pl.

>
> > +     if (!table)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < freq_level; i++) {
> > +             ret =3D do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_=
GET_FREQ_LEVEL_INFO, i, 0);
> > +             if (ret < 0) {
> > +                     kfree(table);
> > +                     return ret;
> > +             }
> > +
> > +             table[i].frequency =3D ret * KILO;
>
> > +             table[i].driver_data =3D FREQ_LEV0 + i;
>
> I don't think you are using this, you don't have to fill it at all.
OK, I will drop it.

>
> > +             table[i].flags =3D (i >=3D boost_level) ? CPUFREQ_BOOST_F=
REQ : 0;
> > +     }
> > +
> > +     table[freq_level].frequency =3D CPUFREQ_TABLE_END;
> > +     table[freq_level].driver_data =3D FREQ_RESV;
> > +     table[freq_level].flags =3D 0;
> > +
> > +     per_cpu(freq_table, cpu) =3D table;
> > +
> > +     return 0;
> > +}
> > +
> > +static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +     int ret;
> > +
> > +     ret =3D loongson3_cpufreq_get_freq_table(policy->cpu);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     policy->cur =3D loongson3_cpufreq_get(policy->cpu);
>
> cpufreq core does this during initialization. The drivers don't need
> to do it.
OK, I will drop it.

>
> > +     policy->cpuinfo.transition_latency =3D 10000;
> > +     policy->freq_table =3D per_cpu(freq_table, policy->cpu);
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
> > +     kfree(policy->freq_table);
> > +     return 0;
> > +}
> > +
> > +static int loongson3_cpufreq_cpu_online(struct cpufreq_policy *policy)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int loongson3_cpufreq_cpu_offline(struct cpufreq_policy *policy=
)
> > +{
> > +     return 0;
> > +}
> > +
> > +static struct cpufreq_driver loongson3_cpufreq_driver =3D {
> > +     .name =3D "loongson3",
> > +     .flags =3D CPUFREQ_CONST_LOOPS,
> > +     .init =3D loongson3_cpufreq_cpu_init,
> > +     .exit =3D loongson3_cpufreq_cpu_exit,
> > +     .online =3D loongson3_cpufreq_cpu_online,
> > +     .offline =3D loongson3_cpufreq_cpu_offline,
> > +     .verify =3D cpufreq_generic_frequency_table_verify,
> > +     .target_index =3D loongson3_cpufreq_target,
> > +     .get =3D loongson3_cpufreq_get,
> > +     .attr =3D cpufreq_generic_attr,
> > +};
> > +
> > +static int configure_cpufreq_info(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
> > +     if (ret <=3D 0)
> > +             return -EPERM;
> > +
> > +     return do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE, FEATU=
RE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
> > +}
> > +
> > +static int loongson3_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +     int i, ret;
> > +
> > +     ret =3D configure_cpufreq_info();
>
> Maybe just open code the function here.. It is just two function calls
> which are quite straight forward.
OK, thanks.

>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < MAX_PACKAGES; i++)
> > +             mutex_init(&cpufreq_mutex[i]);
>
> This must be initialized before calling configure_cpufreq_info() as
> you end up using them there.
OK, thanks.

Huacai
>
> > +     ret =3D cpufreq_register_driver(&loongson3_cpufreq_driver);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static void loongson3_cpufreq_remove(struct platform_device *pdev)
> > +{
> > +     cpufreq_unregister_driver(&loongson3_cpufreq_driver);
> > +}
> > +
> > +static struct platform_device_id cpufreq_id_table[] =3D {
> > +     { "loongson3_cpufreq", },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, cpufreq_id_table);
> > +
> > +static struct platform_driver loongson3_platform_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "loongson3_cpufreq",
> > +     },
> > +     .id_table =3D cpufreq_id_table,
> > +     .probe =3D loongson3_cpufreq_probe,
> > +     .remove_new =3D loongson3_cpufreq_remove,
> > +};
> > +module_platform_driver(loongson3_platform_driver);
> > +
> > +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> > +MODULE_DESCRIPTION("CPUFreq driver for Loongson-3 processors");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.0
>
> --
> viresh

