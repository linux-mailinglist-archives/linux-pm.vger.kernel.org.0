Return-Path: <linux-pm+bounces-9750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FB912124
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 11:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D0628151C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637116F844;
	Fri, 21 Jun 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puF0MuRs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3316E877;
	Fri, 21 Jun 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963320; cv=none; b=l+K7jLpPopSZdbFB52RzhMgPihuqqiL1yW0Eow6Ku7jy9sPlYt05oqSU33sf94/EWgJXffnd9a8W4TraDDVv7j9BX807SFMrZn9l6mBy7uL+ZqqXcJmXcrCmBmKP7bwSCzh33aB+KPFr3hhtMFv/IYBhzHTZu9ht0bFApZB0zDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963320; c=relaxed/simple;
	bh=onZ+VAkSkQEvuSxs+3CRIaEY0toplQO06bUb83fiUMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEX3aaDVFzF+AAKRRP2IsmAZ9dZuKL8vcpIR54PD5z5duPor02ZHnLMvoPfi1Q81uUJRZeWTvIYlTqDYwHIMWGtJK85mnwl2Vit73nHkqLihwGQwZETZqI0P0ykXRDAp2EBPlpzvIMfjNPbzPVmQLIULS+tr2SQxnOeRoBCnZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puF0MuRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBFC4AF09;
	Fri, 21 Jun 2024 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963320;
	bh=onZ+VAkSkQEvuSxs+3CRIaEY0toplQO06bUb83fiUMM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=puF0MuRsIWM1VTAjGjGsMsEOaBrw3CEQBCQYsJtP2A4RSJPE7I97w5RX4RE0aUxYb
	 /SAaQCILkys95T64WNIVrHaWITcjRhlABIAgf/JT4LBwwQSZFt+WB6tdBKhyw1zhkc
	 GhjM4JqbedXytGqJ2vu23xplA8vVw5XmcTx7pNRi8gDOgeSw7VDUIutjmD4YIc2wlm
	 8bwkk/bPFXlmVb4zF9j8eEKtrsjeHNVLcL+ggFWsCYak2lir+XpT1EBu6K5s9Oq1ds
	 6qlA1y3rDg7/AkRp1tLBOQPxqkuOVRiEteaQp/iIZRK8wIdUzAIfyed1S+Ag4Ab0jx
	 5kZx2ft3Hj5fw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d331cc9feso352322a12.2;
        Fri, 21 Jun 2024 02:48:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLz+f0lk5VVa6c9ZdTwbtSOc6FpOI699YrVDOV6NC6fbgGlDXlwogb2R2+wVpkG+IJe62rxZVo64/3FqC7erbj7cRG9XfiEyuZ+YtgqArMnEQfEZM7dmSBdI0oTSV+h0PmXdpc8b0=
X-Gm-Message-State: AOJu0Yw6XpmTBjf/0jBiqVSP0zOdX3b/H6pWXOAGhZ3/cr9mqOP5FLdX
	9drxCWnSy9uA6gplomJCCAY2jXY8CsDT2gtiPSEjIfilgPf+eWJrunBPSHS2W7O98e3ykS4y55k
	JyN0czEo+uqhxm+PTkLvFf3MAJ2g=
X-Google-Smtp-Source: AGHT+IEMHDzbHmF/Les/XRmiwfozy074qwYaQLoQuO/LCI+nKEuvTCPshov6ix5be2c1itQSQk+RH3rU1K4n2+5Ee1Q=
X-Received: by 2002:a50:9b15:0:b0:57c:6861:d735 with SMTP id
 4fb4d7f45d1cf-57d07e6b560mr4917842a12.19.1718963318619; Fri, 21 Jun 2024
 02:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064205.2041548-1-chenhuacai@loongson.cn> <20240612064205.2041548-3-chenhuacai@loongson.cn>
In-Reply-To: <20240612064205.2041548-3-chenhuacai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 21 Jun 2024 17:48:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7QRoCxjKb+1zWq-rpGe-76BUiAZ7iYR-aEqK62eM2WLQ@mail.gmail.com>
Message-ID: <CAAhV-H7QRoCxjKb+1zWq-rpGe-76BUiAZ7iYR-aEqK62eM2WLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	loongarch@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Rafael and Viresh,

Could you please take some time to review this patch? Thank you.

Huacai

On Wed, Jun 12, 2024 at 2:42=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Some of LoongArch processors (Loongson-3 series) support DVFS, their
> IOCSR.FEATURES has IOCSRF_FREQSCALE set. And they has a micro-core in
> the package called SMC (System Management Controller), which can be
> used to detect temperature, control fans, scale frequency and voltage,
> etc.
>
> The Loongson-3 CPUFreq driver is very simple now, it communicate with
> SMC, get DVFS info, set target frequency from CPUFreq core, and so on.
>
> There is a command list to interact with SMC, widely-used commands in
> the CPUFreq driver include:
>
> CMD_GET_VERSION: Get SMC firmware version.
>
> CMD_GET_FEATURE: Get enabled SMC features.
>
> CMD_SET_FEATURE: Enable SMC features, such as basic DVFS, BOOST.
>
> CMD_GET_FREQ_LEVEL_NUM: Get the number of normal frequency levels.
>
> CMD_GET_FREQ_BOOST_NUM: Get the number of boost frequency levels.
>
> CMD_GET_FREQ_LEVEL_INFO: Get the detail info of a frequency level.
>
> CMD_GET_FREQ_INFO: Get the current frequency.
>
> CMD_SET_FREQ_INFO: Set the target frequency.
>
> In future we will add automatic frequency scaling, which is similar to
> Intel's HWP (HardWare P-State).
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/cpufreq/Kconfig             |  12 +
>  drivers/cpufreq/Makefile            |   1 +
>  drivers/cpufreq/loongson3_cpufreq.c | 442 ++++++++++++++++++++++++++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..f2e47ec28d77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12968,6 +12968,7 @@ F:      Documentation/arch/loongarch/
>  F:     Documentation/translations/zh_CN/arch/loongarch/
>  F:     arch/loongarch/
>  F:     drivers/*/*loongarch*
> +F:     drivers/cpufreq/loongson3_cpufreq.c
>
>  LOONGSON GPIO DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 94e55c40970a..10cda6f2fe1d 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -262,6 +262,18 @@ config LOONGSON2_CPUFREQ
>           If in doubt, say N.
>  endif
>
> +if LOONGARCH
> +config LOONGSON3_CPUFREQ
> +       tristate "Loongson3 CPUFreq Driver"
> +       help
> +         This option adds a CPUFreq driver for Loongson processors which
> +         support software configurable cpu frequency.
> +
> +         Loongson-3 family processors support this feature.
> +
> +         If in doubt, say N.
> +endif
> +
>  if SPARC64
>  config SPARC_US3_CPUFREQ
>         tristate "UltraSPARC-III CPU Frequency driver"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d141c71b016..0f184031dd12 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)               +=3D powe=
rnv-cpufreq.o
>  # Other platform drivers
>  obj-$(CONFIG_BMIPS_CPUFREQ)            +=3D bmips-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)                +=3D loongson2_cpufreq.o
> +obj-$(CONFIG_LOONGSON3_CPUFREQ)                +=3D loongson3_cpufreq.o
>  obj-$(CONFIG_SH_CPU_FREQ)              +=3D sh-cpufreq.o
>  obj-$(CONFIG_SPARC_US2E_CPUFREQ)       +=3D sparc-us2e-cpufreq.o
>  obj-$(CONFIG_SPARC_US3_CPUFREQ)                +=3D sparc-us3-cpufreq.o
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongs=
on3_cpufreq.c
> new file mode 100644
> index 000000000000..5dbac0d55a32
> --- /dev/null
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -0,0 +1,442 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CPUFreq driver for the loongson-3 processors
> + *
> + * All revisions of Loongson-3 processor support this feature.
> + *
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
> + */
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +
> +#include <asm/idle.h>
> +#include <asm/loongarch.h>
> +#include <asm/loongson.h>
> +
> +/* Message */
> +union smc_message {
> +       u32 value;
> +       struct {
> +               u32 id          : 4;
> +               u32 info        : 4;
> +               u32 val         : 16;
> +               u32 cmd         : 6;
> +               u32 extra       : 1;
> +               u32 complete    : 1;
> +       };
> +};
> +
> +/* Command return values */
> +#define CMD_OK                         0  /* No error */
> +#define CMD_ERROR                      1  /* Regular error */
> +#define CMD_NOCMD                      2  /* Command does not support */
> +#define CMD_INVAL                      3  /* Invalid Parameter */
> +
> +/* Version commands */
> +/*
> + * CMD_GET_VERSION - Get interface version
> + * Input: none
> + * Output: version
> + */
> +#define CMD_GET_VERSION                        0x1
> +
> +/* Feature commands */
> +/*
> + * CMD_GET_FEATURE - Get feature state
> + * Input: feature ID
> + * Output: feature flag
> + */
> +#define CMD_GET_FEATURE                        0x2
> +
> +/*
> + * CMD_SET_FEATURE - Set feature state
> + * Input: feature ID, feature flag
> + * output: none
> + */
> +#define CMD_SET_FEATURE                        0x3
> +
> +/* Feature IDs */
> +#define FEATURE_SENSOR                 0
> +#define FEATURE_FAN                    1
> +#define FEATURE_DVFS                   2
> +
> +/* Sensor feature flags */
> +#define FEATURE_SENSOR_ENABLE          BIT(0)
> +#define FEATURE_SENSOR_SAMPLE          BIT(1)
> +
> +/* Fan feature flags */
> +#define FEATURE_FAN_ENABLE             BIT(0)
> +#define FEATURE_FAN_AUTO               BIT(1)
> +
> +/* DVFS feature flags */
> +#define FEATURE_DVFS_ENABLE            BIT(0)
> +#define FEATURE_DVFS_BOOST             BIT(1)
> +#define FEATURE_DVFS_AUTO              BIT(2)
> +#define FEATURE_DVFS_SINGLE_BOOST      BIT(3)
> +
> +/* Sensor commands */
> +/*
> + * CMD_GET_SENSOR_NUM - Get number of sensors
> + * Input: none
> + * Output: number
> + */
> +#define CMD_GET_SENSOR_NUM             0x4
> +
> +/*
> + * CMD_GET_SENSOR_STATUS - Get sensor status
> + * Input: sensor ID, type
> + * Output: sensor status
> + */
> +#define CMD_GET_SENSOR_STATUS          0x5
> +
> +/* Sensor types */
> +#define SENSOR_INFO_TYPE               0
> +#define SENSOR_INFO_TYPE_TEMP          1
> +
> +/* Fan commands */
> +/*
> + * CMD_GET_FAN_NUM - Get number of fans
> + * Input: none
> + * Output: number
> + */
> +#define CMD_GET_FAN_NUM                        0x6
> +
> +/*
> + * CMD_GET_FAN_INFO - Get fan status
> + * Input: fan ID, type
> + * Output: fan info
> + */
> +#define CMD_GET_FAN_INFO               0x7
> +
> +/*
> + * CMD_SET_FAN_INFO - Set fan status
> + * Input: fan ID, type, value
> + * Output: none
> + */
> +#define CMD_SET_FAN_INFO               0x8
> +
> +/* Fan types */
> +#define FAN_INFO_TYPE_LEVEL            0
> +
> +/* DVFS commands */
> +/*
> + * CMD_GET_FREQ_LEVEL_NUM - Get number of freq levels
> + * Input: CPU ID
> + * Output: number
> + */
> +#define CMD_GET_FREQ_LEVEL_NUM         0x9
> +
> +/*
> + * CMD_GET_FREQ_BOOST_LEVEL - Get number of boost levels
> + * Input: CPU ID
> + * Output: number
> + */
> +#define CMD_GET_FREQ_BOOST_LEVEL       0x10
> +
> +/*
> + * CMD_GET_FREQ_LEVEL_INFO - Get freq level info
> + * Input: CPU ID, level ID
> + * Output: level info
> + */
> +#define CMD_GET_FREQ_LEVEL_INFO                0x11
> +
> +/*
> + * CMD_GET_FREQ_INFO - Get freq info
> + * Input: CPU ID, type
> + * Output: freq info
> + */
> +#define CMD_GET_FREQ_INFO              0x12
> +
> +/*
> + * CMD_SET_FREQ_INFO - Set freq info
> + * Input: CPU ID, type, value
> + * Output: none
> + */
> +#define CMD_SET_FREQ_INFO              0x13
> +
> +/* Freq types */
> +#define FREQ_INFO_TYPE_FREQ            0
> +#define FREQ_INFO_TYPE_LEVEL           1
> +
> +#define FREQ_MAX_LEVEL                 (16 + 1)
> +
> +enum freq {
> +       FREQ_LEV0, /* Reserved */
> +       FREQ_LEV1, FREQ_LEV2, FREQ_LEV3, FREQ_LEV4,
> +       FREQ_LEV5, FREQ_LEV6, FREQ_LEV7, FREQ_LEV8,
> +       FREQ_LEV9, FREQ_LEV10, FREQ_LEV11, FREQ_LEV12,
> +       FREQ_LEV13, FREQ_LEV14, FREQ_LEV15, FREQ_LEV16,
> +       FREQ_RESV
> +};
> +
> +struct loongson3_freq_data {
> +       unsigned int cur_cpu_freq;
> +       struct cpufreq_frequency_table table[];
> +};
> +
> +static struct mutex cpufreq_mutex[MAX_PACKAGES];
> +static struct cpufreq_driver loongson3_cpufreq_driver;
> +static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
> +
> +static inline int do_service_request(union smc_message *msg)
> +{
> +       int retries;
> +       union smc_message last;
> +
> +       last.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +       if (!last.complete)
> +               return -EPERM;
> +
> +       iocsr_write32(msg->value, LOONGARCH_IOCSR_SMCMBX);
> +       iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MIS=
C_FUNC_SOFT_INT,
> +                     LOONGARCH_IOCSR_MISC_FUNC);
> +
> +       for (retries =3D 0; retries < 10000; retries++) {
> +               msg->value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +               if (msg->complete)
> +                       break;
> +
> +               usleep_range(8, 12);
> +       }
> +
> +       if (!msg->complete || msg->cmd !=3D CMD_OK)
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +static unsigned int loongson3_cpufreq_get(unsigned int cpu)
> +{
> +       union smc_message msg;
> +
> +       msg.id          =3D cpu;
> +       msg.info        =3D FREQ_INFO_TYPE_FREQ;
> +       msg.cmd         =3D CMD_GET_FREQ_INFO;
> +       msg.extra       =3D 0;
> +       msg.complete    =3D 0;
> +       do_service_request(&msg);
> +
> +       per_cpu(freq_data, cpu)->cur_cpu_freq =3D msg.val * KILO;
> +
> +       return per_cpu(freq_data, cpu)->cur_cpu_freq;
> +}
> +
> +static int loongson3_cpufreq_set(struct cpufreq_policy *policy, int freq=
_level)
> +{
> +       union smc_message msg;
> +
> +       msg.id          =3D cpu_data[policy->cpu].core;
> +       msg.info        =3D FREQ_INFO_TYPE_LEVEL;
> +       msg.val         =3D freq_level;
> +       msg.cmd         =3D CMD_SET_FREQ_INFO;
> +       msg.extra       =3D 0;
> +       msg.complete    =3D 0;
> +       do_service_request(&msg);
> +
> +       return 0;
> +}
> +
> +/*
> + * Here we notify other drivers of the proposed change and the final cha=
nge.
> + */
> +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsig=
ned int index)
> +{
> +       unsigned int cpu =3D policy->cpu;
> +       unsigned int package =3D cpu_data[cpu].package;
> +
> +       if (!cpu_online(cpu))
> +               return -ENODEV;
> +
> +       /* setting the cpu frequency */
> +       mutex_lock(&cpufreq_mutex[package]);
> +       loongson3_cpufreq_set(policy, index);
> +       mutex_unlock(&cpufreq_mutex[package]);
> +
> +       return 0;
> +}
> +
> +static int loongson3_cpufreq_get_freq_table(int cpu)
> +{
> +       union smc_message msg;
> +       int i, ret, boost_level, max_level, freq_level;
> +       struct loongson3_freq_data *data;
> +
> +       if (per_cpu(freq_data, cpu))
> +               return 0;
> +
> +       msg.id          =3D cpu;
> +       msg.cmd         =3D CMD_GET_FREQ_LEVEL_NUM;
> +       msg.extra       =3D 0;
> +       msg.complete    =3D 0;
> +       ret =3D do_service_request(&msg);
> +       if (ret < 0)
> +               return ret;
> +       max_level =3D msg.val;
> +
> +       msg.id          =3D cpu;
> +       msg.cmd         =3D CMD_GET_FREQ_BOOST_LEVEL;
> +       msg.extra       =3D 0;
> +       msg.complete    =3D 0;
> +       ret =3D do_service_request(&msg);
> +       if (ret < 0)
> +               return ret;
> +       boost_level =3D msg.val;
> +
> +       freq_level =3D min(max_level, FREQ_MAX_LEVEL);
> +       data =3D kzalloc(struct_size(data, table, freq_level + 1), GFP_KE=
RNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < freq_level; i++) {
> +               msg.id          =3D cpu;
> +               msg.info        =3D FREQ_INFO_TYPE_FREQ;
> +               msg.cmd         =3D CMD_GET_FREQ_LEVEL_INFO;
> +               msg.val         =3D i;
> +               msg.complete    =3D 0;
> +
> +               ret =3D do_service_request(&msg);
> +               if (ret < 0) {
> +                       kfree(data);
> +                       return ret;
> +               }
> +
> +               data->table[i].frequency =3D msg.val * KILO;
> +               data->table[i].driver_data =3D FREQ_LEV0 + i;
> +               data->table[i].flags =3D (i >=3D boost_level) ? CPUFREQ_B=
OOST_FREQ : 0;
> +       }
> +
> +       data->table[freq_level].frequency =3D CPUFREQ_TABLE_END;
> +       data->table[freq_level].driver_data =3D FREQ_RESV;
> +       data->table[freq_level].flags =3D 0;
> +
> +       per_cpu(freq_data, cpu) =3D data;
> +
> +       return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       int ret;
> +
> +       if (!cpu_online(policy->cpu))
> +               return -ENODEV;
> +
> +       ret =3D loongson3_cpufreq_get_freq_table(policy->cpu);
> +       if (ret < 0)
> +               return ret;
> +
> +       policy->cur =3D loongson3_cpufreq_get(policy->cpu);
> +       policy->cpuinfo.transition_latency =3D 10000;
> +       policy->freq_table =3D per_cpu(freq_data, policy->cpu)->table;
> +       cpumask_copy(policy->cpus, topology_sibling_cpumask(policy->cpu))=
;
> +
> +       if (policy_has_boost_freq(policy)) {
> +               ret =3D cpufreq_enable_boost_support();
> +               if (ret < 0) {
> +                       pr_warn("cpufreq: Failed to enable boost: %d\n", =
ret);
> +                       return ret;
> +               }
> +               loongson3_cpufreq_driver.boost_enabled =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       return 0;
> +}
> +
> +static struct cpufreq_driver loongson3_cpufreq_driver =3D {
> +       .name =3D "loongson3",
> +       .flags =3D CPUFREQ_CONST_LOOPS,
> +       .init =3D loongson3_cpufreq_cpu_init,
> +       .exit =3D loongson3_cpufreq_cpu_exit,
> +       .verify =3D cpufreq_generic_frequency_table_verify,
> +       .target_index =3D loongson3_cpufreq_target,
> +       .get =3D loongson3_cpufreq_get,
> +       .attr =3D cpufreq_generic_attr,
> +};
> +
> +static struct platform_device_id cpufreq_id_table[] =3D {
> +       { "loongson3_cpufreq", },
> +       { /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(platform, cpufreq_id_table);
> +
> +static struct platform_driver loongson3_platform_driver =3D {
> +       .driver =3D {
> +               .name =3D "loongson3_cpufreq",
> +       },
> +       .id_table =3D cpufreq_id_table,
> +};
> +
> +static int configure_cpufreq_info(void)
> +{
> +       int ret;
> +       union smc_message msg;
> +
> +       msg.cmd         =3D CMD_GET_VERSION;
> +       msg.extra       =3D 0;
> +       msg.complete    =3D 0;
> +       ret =3D do_service_request(&msg);
> +       if (ret < 0 || msg.val < 0x1)
> +               return -EPERM;
> +
> +       msg.id          =3D FEATURE_DVFS;
> +       msg.cmd         =3D CMD_SET_FEATURE;
> +       msg.val         =3D FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST;
> +       msg.extra       =3D 0;
> +       msg.complete    =3D 0;
> +       ret =3D do_service_request(&msg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int __init cpufreq_init(void)
> +{
> +       int i, ret;
> +
> +       ret =3D platform_driver_register(&loongson3_platform_driver);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D configure_cpufreq_info();
> +       if (ret)
> +               goto err;
> +
> +       for (i =3D 0; i < MAX_PACKAGES; i++)
> +               mutex_init(&cpufreq_mutex[i]);
> +
> +       ret =3D cpufreq_register_driver(&loongson3_cpufreq_driver);
> +       if (ret)
> +               goto err;
> +
> +       pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
> +
> +       return 0;
> +
> +err:
> +       platform_driver_unregister(&loongson3_platform_driver);
> +       return ret;
> +}
> +
> +static void __exit cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&loongson3_cpufreq_driver);
> +       platform_driver_unregister(&loongson3_platform_driver);
> +}
> +
> +module_init(cpufreq_init);
> +module_exit(cpufreq_exit);
> +
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION("CPUFreq driver for Loongson-3 processors");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>

