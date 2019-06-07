Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3430E38941
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfFGLnA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 7 Jun 2019 07:43:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfFGLm7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 07:42:59 -0400
Received: from [192.168.1.162] ([37.4.249.160]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIxmm-1hEn031Lb8-00KP1j; Fri, 07 Jun 2019 13:42:37 +0200
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mbrugger@suse.de, sboyd@kernel.org, eric@anholt.net,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        ptesarik@suse.com, linux-rpi-kernel@lists.infradead.org,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
 <20190606142255.29454-5-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <c967bbfd-ce83-7c89-7f18-98f2c66aa333@i2se.com>
Date:   Fri, 7 Jun 2019 13:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606142255.29454-5-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:zQmMGIJsWXCJobgvt7sXrqeZUC5F3ZdZlaHzUDkfl5pqlyVm2RF
 COW6iEVlLLOvUp4Hbe94SQqBSIf9lZq9BAe8HI3DpA46mkt1uZLBsn1L5M2bkLz5p+tgU3d
 muqfwmPjoxbkoxLcPtbPi5eIEiRa1aP9N5STciv0Yit8otC8rEItW1QbykS93SDH2NZOLsF
 hezAKvyhDX+eh84fqKnxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEYCk2fNbjA=:74OnHcHZqQe/vLKd+aiGIF
 5MkTYrAqRcj86wx3GMY5CTbo9mjk14c92UzAGDucl55NtA2TzlWmHWp2HytEsRJnIA+SbdpJH
 ILtwBvjdqY20tx1GA1QzjojJc3D7FtlRbiWmFqkCxdMXxhFjvWHKpThq2niUaXKzUM+h+MC5p
 ckhh7348cciQgSdfDGqCEc1J6CrYS1bnU7T/zhWzhp9kU0586NcmFrseYBtaSLzFaQ74FVbJ9
 2vhmmMlZVgAE0jzHKyvUx6N5KjiWkgA9hUNc5OCnt6+PzCrUcMyw6DeaGskKQ4z4nZ+rD4qyB
 Q5samanQ5nTgHRSorP3YB0rtrgtvRGUwHDJtOiRSU873wvy0TNY+dMA+rRtc2nypLBw5iBQn1
 I1LOrnZi7gwt5brWQ/q6Fsls2EXQyQdTjkiN4dUy8/n3PjWF2rCivLmez9K/zw33gX+tsZc5m
 QgWDrqZYk9ulB1GrYGIJF9PaMSEn6lF4qpW7xBlADjpHVBCwU4G0jNXxv5Pk6fDYzOnGR0IBo
 krSRYAheH2aSXKNVGihMaiyzDZKhk5T4DoyGzBC2jxuLungN1tiBPZXpbYGO4YZ381jo+5f5S
 1z4Q8Yw93u9huE1ml5zncOUr8LGqCtNsuv2y3lUwmwu9yqoy7EG2WNEadSYaIDetuA/Th6IzR
 63qjMAab57vE8skR3uuR8wDNsXDg+mDIwnZoewIx1xlbQB22ngglDu4qkG8rhNmQTTr/Vy/4g
 +PFU3ORhE2b8QbL5zIFc4A54392YZv2fwSeAIj+yvreurYgyNgeHKaDHwwo=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

Am 06.06.19 um 16:22 schrieb Nicolas Saenz Julienne:
> Raspberry Pi's firmware offers and interface though which update it's
> performance requirements. It allows us to request for specific runtime
> frequencies, which the firmware might or might not respect, depending on
> the firmware configuration and thermals.
>
> As the maximum and minimum frequencies are configurable in the firmware
> there is no way to know in advance their values. So the Raspberry Pi
> cpufreq driver queries them, builds an opp frequency table to then
> launch cpufreq-dt.
>
> Also, as the firmware interface might be configured as a module, making
> the cpu clock unavailable during init, this implements a full fledged
> driver, as opposed to most drivers registering cpufreq-dt, which only
> make use of an init routine.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
>
> ---
>
> Changes since v1:
>   - Remove compatible checks
>   - Add module support, now full fledged driver
>   - Use NULL in clk_get()
>
>  drivers/cpufreq/Kconfig.arm           |   8 +++
>  drivers/cpufreq/Makefile              |   1 +
>  drivers/cpufreq/raspberrypi-cpufreq.c | 100 ++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index f8129edc145e..5e9204d443ff 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -133,6 +133,14 @@ config ARM_QCOM_CPUFREQ_HW
>  	  The driver implements the cpufreq interface for this HW engine.
>  	  Say Y if you want to support CPUFreq HW.
>  
> +config ARM_RASPBERRYPI_CPUFREQ
> +	tristate "Raspberry Pi cpufreq support"
> +	depends on CLK_RASPBERRYPI || COMPILE_TEST
> +	help
> +	  This adds the CPUFreq driver for Raspberry Pi
> +
> +	  If in doubt, say N.
> +
>  config ARM_S3C_CPUFREQ
>  	bool
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c6f949..121c1acb66c0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
> +obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
> new file mode 100644
> index 000000000000..99b59d5a50aa
> --- /dev/null
> +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Raspberry Pi cpufreq driver
> + *
> + * Copyright (C) 2019, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +
> +static struct platform_device *cpufreq_dt;
> +
> +static int raspberrypi_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cpu_dev;
> +	unsigned long min, max;
> +	unsigned long rate;
> +	struct clk *clk;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev) {
> +		pr_err("Cannot get CPU for cpufreq driver\n");
> +		return -ENODEV;
> +	}
> +
> +	clk = clk_get(cpu_dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(cpu_dev, "Cannot get clock for CPU0\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	/*
> +	 * The max and min frequencies are configurable in the Raspberry Pi
> +	 * firmware, so we query them at runtime
> +	 */
> +	min = clk_round_rate(clk, 0);
> +	max = clk_round_rate(clk, ULONG_MAX);
> +	clk_put(clk);
> +
> +	for (rate = min; rate < max; rate += 100000000) {
> +		ret = dev_pm_opp_add(cpu_dev, rate, 0);
> +		if (ret)
> +			goto remove_opp;
> +	}

i played a little bit with my Raspberry Pi Zero W and this series. Looks
fine so far.

Sorry for this nitpicking, but i expect user questions about the
differences between sysfs and vcgencmd measure_clock.

scaling_available_frequencies gives

699999 799999 899999 999999

but vcgencmd measure_clock return the rounded up values.

I know we shouldn't fake anything, but adding the OPPs rounded up may
avoid confusion.

Stefan


