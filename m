Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11ED0234D5
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbfETMbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 08:31:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390275AbfETMbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 08:31:12 -0400
Received: from [192.168.178.167] ([109.104.33.162]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVMuN-1h3E3m0KCl-00SRFw; Mon, 20 May 2019 14:30:53 +0200
Subject: Re: [RFC v2 5/5] cpufreq: add driver for Raspbery Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mbrugger@suse.de, sboyd@kernel.org, eric@anholt.net,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        ptesarik@suse.com, linux-rpi-kernel@lists.infradead.org,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-6-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <b23de4a1-e156-e458-d294-4206d87aa394@i2se.com>
Date:   Mon, 20 May 2019 14:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520104708.11980-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:8EPy0TEJACtLRM++yjvBbmbVCw2iG8lr+b2JXdcGP7gvIcA4EEF
 56n5p7w6xmP6ibp3AyK5HtXHzKAv9Bq8BsS2bg2iccrymCgCiJAjQ4TkTr7vGZecgfh5pVx
 hFT+McXrzs0zuDaAwa4gcZC2IHmf/QjzYzdSV0nE1ZKWOFCxpfSuORzsoNbnkSWwGgwXnAk
 9AUB7HqT/Rv21BjVmbEKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oYIxwR3Gy8w=:WYzhHcJaMcyZ+BIqULb+5H
 ci6BYAOtjHdDZOMuqgG/ejVx61x9vJMvtKwcYw3PhVtnxd8ZA9wBsdxOkUlpPK27+z915WKKa
 3eeBGNa82w2KtxWzBhfLqeP+xdcmQjau0I+c2cWaqVL+wBntXBwbzM8rfvLfQdXv3FUYsH9j8
 eYr26BuKzVpPA/pYl9KbZVC47cfubAtziM5tnxwSwPRlWrgHP39RrxVyuB2ecxHH49Ge/Rt6K
 dJA7T/91PuYfMtxRzz+5gZ3aZf6nnpT9NhQbbtCAhtg6YRGx6SL/H36Tdt2emsnD1GlhXlcij
 OQFyYDLP6lJHTb8iStv6FAzGDTHdNxKETDeTsG9Pmdih9bc29n8mhFYvsIsA/9YsmsffEN4jT
 SHdd0HPsTrTW4tCcgfbVgTMq+Phfkl+SiAIA0kmNOthusgaDyeyKwvq67+tJpzaxyAmg6ZQIV
 YfkNYqPQ0hFY6DI1BE54Hpu27Mlh+xltQQdXzzB5yjljibFYwuJNYV3OcR/hV34EOdrlrV6rF
 wPliF0seMgDjg0NVDBwLfDMmSmPCNMzFh+heKtdH0eeVbq3Riw5LzNbYtmrP0WdeP3/yecUtr
 1p5nwjAdlxXQaFI/0Q/TYr8wCFrCHHze2e7j1Afeiwmbk9Kg6TkF/VuJuMlAB+/yr94rbDOGe
 0mgpn/IN1+gnN3rGeWR/P/lM5tdgqnXu8jNWrK2ta1i5fmzql4gRS8odH5lc/3GQ6fpsfuQGc
 CCcxFE/fS+qf0Ojx1BpdZ6fT2n7XQT/vgR/Z9EJx0JWHtmNpQ7Ln9jK/xtg=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
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
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/cpufreq/Kconfig.arm           |  8 +++
>  drivers/cpufreq/Makefile              |  1 +
>  drivers/cpufreq/raspberrypi-cpufreq.c | 83 +++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d302f48..f6eba7ae50d0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -308,3 +308,11 @@ config ARM_PXA2xx_CPUFREQ
>  	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
>  
>  	  If in doubt, say N.
> +
> +config ARM_RASPBERRYPI_CPUFREQ
> +	tristate "Raspberry Pi cpufreq support"
> +	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST

The driver doesn't really require the firmware driver to compile, how about:

select RASPBERRYPI_FIRMWARE

> +	help
> +	  This adds the CPUFreq driver for Raspberry Pi
> +
> +	  If in doubt, say N.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c6f949..02678e9b2ff5 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
>  
>  
>  ##################################################################################
> diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
> new file mode 100644
> index 000000000000..a85988867d56
> --- /dev/null
> +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Raspberry Pi cpufreq driver
> + *
> + * Copyright (C) 2019, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/pm_opp.h>
> +#include <linux/cpufreq.h>
> +#include <linux/platform_device.h>
> +
> +static const struct of_device_id machines[] __initconst = {
> +	{ .compatible = "raspberrypi,3-model-b-plus" },
> +	{ .compatible = "raspberrypi,3-model-b" },
> +	{ /* sentinel */ }
> +};
> +
> +static int __init raspberrypi_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	struct device *cpu_dev;
> +	struct clk *clk;
> +	long min, max;
> +	long rate;
> +	int ret;
> +
> +	if (!of_match_node(machines, of_root))
> +		return -ENODEV;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev) {
> +		pr_err("Cannot get CPU for cpufreq driver\n");
> +		return -ENODEV;
> +	}
> +
> +	clk = clk_get(cpu_dev, 0);

I suggest use the expected clock ID.

