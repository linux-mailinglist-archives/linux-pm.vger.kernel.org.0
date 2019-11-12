Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B205F93A3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLPIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 10:08:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40988 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfKLPIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 10:08:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id a21so15172139edj.8
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kOStVigV/ao9Pr/GeN1G2ZcF7mW8l2LQik/N+UCJ45s=;
        b=T3+x6Hj/TiGsag6Iwv5Naomkx/gSIg7a2tErPavcNyw8w4Q5tLV+fq49S+xc+FaE0n
         4uXnEuW8PthxCFusicrrkE6jp05NoEArp2URtaSknD/cfVJKjp3Mr/Klk8fiRUIGk3LU
         j9hFSSmF0w9KVX8FZKq6LDVe9uwtuY1cAO2Wcbh+k/SOVhyDtJOxHAUuKGNouw8OeUfb
         W1poc0OuS/f+Tf0P6ohQ906PWFkq4VOvYBHRUORQ+uvV+f7ZP8zLTVkz6N2UZnnLt1C3
         oTAsLhC/NVp4moymSF2IDlRLumiUbNDCMgbE9+Bq6CfRh1ktD2LfUYJHlUAYuJnQ6Y0L
         S0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOStVigV/ao9Pr/GeN1G2ZcF7mW8l2LQik/N+UCJ45s=;
        b=bespavkNmAw8Z7rT36k7ptUz80y/9Pb8ZbN3nyE9wIN8498w3cf9LKI7PDhFVki9W8
         Lq2iDr9RhPHVLtBJNDYF7D3kGEqyeezRfb4VzcVp/dtZXcqK/M2H8Na23DLU3dR3E5T9
         OTAfGNw+B46CqDny62V6GYkmVKcN69d3vt6iDk8xQBwzJu8TN/uQY7q60fLErSuBBtZq
         sRnK6vqkpIr8dbO21WxLQfE/E96HccHVwTb/SXWZvXVugC42eyog956qRDwo4roN3uqp
         XO9+TKXNwpRztjM3t4L2u1WATbzHiTU3f+4f/K/E4zWvq0FqfjaVf3hlZVY4UBLk+aw1
         ek0g==
X-Gm-Message-State: APjAAAW6XgF6ebjn+C+k9oA3gDG+DG3PZ8qPIIQJWzHqwsck3FTwkZ65
        A88Szt2+spB5K4cJbcwdRbYk2g==
X-Google-Smtp-Source: APXvYqwSF5A1cDuRpzgijULpsjox+9qAbmclvLnSWDqTQfrWe2QPOPZMe370t3Q9fr9XVpl+78OzcA==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr28420476ejf.15.1573571278249;
        Tue, 12 Nov 2019 07:07:58 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id e13sm703823edm.29.2019.11.12.07.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:07:57 -0800 (PST)
Subject: Re: [PATCH RFC v5 05/10] interconnect: Add imx core driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1572562150.git.leonard.crestez@nxp.com>
 <3f8b65aa7a7eabaedeee27d5bcf8220982ac3597.1572562150.git.leonard.crestez@nxp.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4fa190b5-b040-b093-9313-e9ccbc9b1da5@linaro.org>
Date:   Tue, 12 Nov 2019 17:07:55 +0200
MIME-Version: 1.0
In-Reply-To: <3f8b65aa7a7eabaedeee27d5bcf8220982ac3597.1572562150.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Thanks for the patch!

On 1.11.19 г. 0:52 ч., Leonard Crestez wrote:
> This adds support for i.MX SoC family to interconnect framework.
> 
> Platform drivers can describe the interconnect graph and several
> adjustment knobs where icc node bandwidth is converted to a
> DEV_PM_QOS_MIN_FREQUENCY request.
> 
> The adjustable nodes are found based on an "interconnect-node-id"
> property by scanning the entire device tree.

Are the adjustable nodes SoC specific? Can we have them here in the driver
instead of scanning the entire device tree?

> The interconnect provider doesn't need an virtual OF node, instead those
> same adjustable nodes are registered as proxies which xlate to the
> platform-level provider.
> 
> The platform device for the interconnect needs to be registered from a
> SOC driver (similar to cpufreq).
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/interconnect/Kconfig      |   1 +
>  drivers/interconnect/Makefile     |   1 +
>  drivers/interconnect/imx/Kconfig  |   5 +
>  drivers/interconnect/imx/Makefile |   1 +
>  drivers/interconnect/imx/imx.c    | 273 ++++++++++++++++++++++++++++++
>  drivers/interconnect/imx/imx.h    |  60 +++++++
>  6 files changed, 341 insertions(+)
>  create mode 100644 drivers/interconnect/imx/Kconfig
>  create mode 100644 drivers/interconnect/imx/Makefile
>  create mode 100644 drivers/interconnect/imx/imx.c
>  create mode 100644 drivers/interconnect/imx/imx.h
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index b6ea8f0a6122..f57e77b8731c 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -10,7 +10,8 @@ menuconfig INTERCONNECT
>  	  If unsure, say no.
>  
>  if INTERCONNECT
>  
>  source "drivers/interconnect/qcom/Kconfig"
> +source "drivers/interconnect/imx/Kconfig"
>  
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 28f2ab0824d5..20a13b7eb37f 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -2,5 +2,6 @@
>  
>  icc-core-objs				:= core.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
> new file mode 100644
> index 000000000000..7d81d3c83a61
> --- /dev/null
> +++ b/drivers/interconnect/imx/Kconfig
> @@ -0,0 +1,5 @@
> +config INTERCONNECT_IMX
> +	bool "i.MX interconnect drivers"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	help
> +	  Generic interconnect driver for i.MX SOCs
> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
> new file mode 100644
> index 000000000000..bb92fd9fe4a5
> --- /dev/null
> +++ b/drivers/interconnect/imx/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_INTERCONNECT_IMX) += imx.o
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> new file mode 100644
> index 000000000000..7d248e01dcf0
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interconnect framework driver for i.MX SoC
> + *
> + * Copyright (c) 2019, BayLibre
> + * Copyright (c) 2019, NXP
> + * Author: Alexandre Bailon <abailon@baylibre.com>
> + * Author: Leonard Crestez <leonard.crestez@nxp.com>
> + */
> +
> +#include <linux/devfreq.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +
> +#include "imx.h"
> +
> +/* private icc_provider data */
> +struct imx_icc_provider {
> +	struct device *dev;

What device is this? There is already a *dev in struct icc_provider.
Please add kernel-doc.

> +};
> +
> +/* private icc_node data */
> +struct imx_icc_node {
> +	const struct imx_icc_node_desc *desc;
> +	struct devfreq *devfreq;
> +	struct dev_pm_qos_request qos_req;
> +};
> +
> +static int imx_icc_aggregate(struct icc_node *node, u32 tag,
> +			     u32 avg_bw, u32 peak_bw,
> +			     u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_avg += avg_bw;
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static struct icc_node *imx_icc_xlate(struct of_phandle_args *spec, void *data)
> +{
> +	struct imx_icc_provider *desc = data;
> +	struct icc_provider *provider = dev_get_drvdata(desc->dev);
> +	unsigned int id = spec->args[0];
> +	struct icc_node *node;
> +
> +	list_for_each_entry(node, &provider->nodes, node_list)
> +		if (node->id == id)
> +			return node;
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static int imx_icc_node_set(struct icc_node *node)
> +{
> +	struct device *dev = node->provider->dev;
> +	struct imx_icc_node *node_data = node->data;
> +	u64 freq;
> +
> +	if (!node_data->devfreq)
> +		return 0;
> +
> +	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;

Why the sum of average and peak bandwidth?

> +	do_div(freq, node_data->desc->adj->bw_div);
> +	dev_dbg(dev, "node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq %llukHz\n",
> +			node->name, dev_name(node_data->devfreq->dev.parent),
> +			node->avg_bw, node->peak_bw, freq);
> +
> +	if (freq > S32_MAX) {
> +		dev_err(dev, "%s can't request more than S32_MAX freq\n",
> +				node->name);
> +		return -ERANGE;
> +	}
> +
> +	dev_pm_qos_update_request(&node_data->qos_req, freq);
> +
> +	return 0;
> +}
> +
> +static int imx_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	return imx_icc_node_set(dst);
> +}
> +
> +static int imx_icc_node_init_devfreq(struct device *dev,
> +				     struct icc_node *node)
> +{
> +	struct imx_icc_node *node_data = node->data;
> +	struct device_node *dn;
> +	u32 node_id;
> +	int ret;
> +
> +	/* Find nodes based on interconnect-node-id property */
> +	for_each_node_with_property(dn, "interconnect-node-id") {
> +		ret = of_property_read_u32(dn, "interconnect-node-id",
> +					   &node_id);
> +		if (ret != 0)
> +			continue;
> +
> +		if (node_id == node->id) {
> +			of_node_get(dn);
> +			break;
> +		}
> +	}
> +
> +	if (!dn)
> +		return 0;
> +
> +	dev_info(dev, "node %s[%d] has device node %pOF\n",
> +			node->name, node->id, dn);
> +	node_data->devfreq = devfreq_get_devfreq_by_node(dn);

Ah, so you need to get the devfreq nodes? So looking at the next
patches it seems that noc and ddrc are the only adjustable nodes?

Maybe we should model them both as interconnect providers, as they
seem to be dealing with the bandwidth/frequency requirements and
changing the clock rates.

Thanks,
Georgi

> +	if (IS_ERR(node_data->devfreq)) {
> +		of_node_put(dn);
> +		ret = PTR_ERR(node_data->devfreq);
> +		dev_err(dev, "failed to fetch devfreq for %s: %d\n",
> +				node->name, ret);
> +		return ret;
> +	}
> +
> +	of_node_put(dn);
> +
> +	return dev_pm_qos_add_request(node_data->devfreq->dev.parent,
> +				      &node_data->qos_req,
> +				      DEV_PM_QOS_MIN_FREQUENCY, 0);
> +}
> +
