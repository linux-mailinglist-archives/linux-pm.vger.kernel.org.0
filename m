Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD584F9B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfHGPQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 11:16:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46354 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGPQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 11:16:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so85999488ljg.13
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0jC0Zrd2C3l1OUCqGcvbE6uQGrAyHEbHVa+kPnt7OA=;
        b=d5fYUuF/H/CLBcIIYl+RIEmMaTMznWXMSIDghzkdBDRVTaqzIZFEkO3d6NxyT1B8ys
         FMg2394JZ3xvXAr+5iea6gYMByTyV/u/gURRrnq3l5elGGkIdwj9RUZdp9nyokwl6Oy7
         emCrEGsU345U6zGg7YrxIojP8E2DFPo65CXhmyNkSRd+WCRAHBPr0+J5KSbNNxprnVrA
         xFTaZxScUd0tGlXFbaL7L/6tpWGtCV864kkOmM547anxqEErZMEk5joqYbkxttV1+Hy8
         8zNwbU7ehnSOaK8BL8OBn/EXLWBjNWawBfTLcmibKh0DtXW1/G0x1UdYw6l2DfGj0/nm
         6M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0jC0Zrd2C3l1OUCqGcvbE6uQGrAyHEbHVa+kPnt7OA=;
        b=t3W/mDwWjOQzbMgUnM1kuHSnPYMXUPoKVhOBK2kJ2aPumswBOeB60URus8UE3hPWPC
         pIP7Y8o1B0twIwxjAJOhkBEkNJ0Nn3Oi6K72cx4rcmkVG4d0eBhzJMrP6nu019CSJMZ9
         NaiJq0exaPnlwePai98C6oO7IODeCd4baWt51nXxByU+fAP4E7rs2q5rK7+gEZeapdQ5
         8yfPqbF22gSUT7Lf+8OrcuR4nHiTiodSzgSszqIuieBvGRNPuvzWqSAeeRZrxAbBrr7M
         EOvKmS0hmlM2TOGfjLyVfrUfTd2J28kLHKS0W4I8UwMBgalZj0RUFJApxR2XkB7dE3a3
         OhyA==
X-Gm-Message-State: APjAAAUR/9ATi7AvPLKxgYUB+ARCXaRAWJH8YhaXshSceFMbObhO5sz3
        OsWr5acbmLIDNAfl2xgdOuKzFg==
X-Google-Smtp-Source: APXvYqzq9y51Z/KuusuDguZqva9vNKjR93Muts2AHmN7o97UxiZiYgV0BpDHqwj/yMT28HW+WMgJhg==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr5141202lji.159.1565191013200;
        Wed, 07 Aug 2019 08:16:53 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k4sm18293613ljg.59.2019.08.07.08.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 08:16:52 -0700 (PDT)
Subject: Re: [RFCv3 2/3] interconnect: Add imx core driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1565088423.git.leonard.crestez@nxp.com>
 <2b8905754d9a3fa6f4dc7b73b45649c85aa3e80a.1565088423.git.leonard.crestez@nxp.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ceac96cd-a6ab-ddfc-e080-1bab5d76eb2d@linaro.org>
Date:   Wed, 7 Aug 2019 18:16:50 +0300
MIME-Version: 1.0
In-Reply-To: <2b8905754d9a3fa6f4dc7b73b45649c85aa3e80a.1565088423.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 8/6/19 13:55, Leonard Crestez wrote:
> This adds support for i.MX SoC family to interconnect framework.
> 
> Platform drivers can describe their interconnect graph and
> several adjustment knobs where an icc node bandwith converted to a

s/bandwith/bandwidth/

> clk_min_rate request.
> 
> All adjustable nodes are assumed to be independent.
> 
> Based on an earlier work by Alexandre Bailon but greatly reduced to drop
> "platform opp" support.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Your Signed-off-by should be below Alexandre's.

> ---
>  drivers/interconnect/Kconfig      |   1 +
>  drivers/interconnect/Makefile     |   1 +
>  drivers/interconnect/imx/Kconfig  |   5 +
>  drivers/interconnect/imx/Makefile |   1 +
>  drivers/interconnect/imx/imx.c    | 258 ++++++++++++++++++++++++++++++
>  drivers/interconnect/imx/imx.h    |  62 +++++++
>  6 files changed, 328 insertions(+)
>  create mode 100644 drivers/interconnect/imx/Kconfig
>  create mode 100644 drivers/interconnect/imx/Makefile
>  create mode 100644 drivers/interconnect/imx/imx.c
>  create mode 100644 drivers/interconnect/imx/imx.h
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index bfa4ca3ab7a9..e61802230f90 100644
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
> index 000000000000..45fbae7007af
> --- /dev/null
> +++ b/drivers/interconnect/imx/Kconfig
> @@ -0,0 +1,5 @@
> +config INTERCONNECT_IMX
> +	bool "i.MX interconnect drivers"
> +	depends on ARCH_MXC || ARCH_MXC_ARM64 || COMPILE_TEST
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
> index 000000000000..cc838e40419e
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx.c
> @@ -0,0 +1,258 @@
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
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +#include <linux/devfreq.h>

Please sort alphabetically.

> +#include <linux/of.h>
> +
> +#include "imx.h"
> +
> +/* private icc_provider data */
> +struct imx_icc_provider {
> +	struct device *dev;
> +};
> +
> +/* private icc_node data */
> +struct imx_icc_node {
> +	const struct imx_icc_node_desc *desc;
> +	struct devfreq *devfreq;
> +	struct dev_pm_qos_request qos_req;
> +};
> +
> +static int imx_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +				  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_avg += avg_bw;
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static struct icc_node* imx_icc_xlate(struct of_phandle_args *spec, void *data)
> +{
> +	struct imx_icc_provider *desc = data;
> +	struct icc_provider *provider = dev_get_drvdata(desc->dev);
> +	unsigned int id = spec->args[0];
> +	struct icc_node *node;
> +
> +	list_for_each_entry (node, &provider->nodes, node_list)
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
> +	unsigned long freq;
> +
> +	if (!node_data->devfreq)
> +		return 0;
> +
> +	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;
> +	do_div(freq, node_data->desc->adj->bw_div);
> +	if (freq > INT_MAX) {
> +		dev_err(dev, "%s can't request more INT_MAX freq\n",
> +				node->name);
> +		return -ERANGE;
> +	}
> +
> +	dev_dbg(dev, "%s avg_bw %u peak_bw %u min_freq %lu\n",
> +			node->name, node->avg_bw, node->peak_bw, freq);
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
> +	const struct imx_icc_node_desc *node_desc = node_data->desc;
> +	int index;
> +	int ret;
> +
> +	index = of_property_match_string(dev->of_node,
> +			"devfreq-names", node_desc->adj->devfreq_name);
> +	if (index < 0) {
> +		dev_err(dev, "failed to match devfreq-names %s: %d\n",
> +				node_desc->adj->devfreq_name, index);
> +		return index;
> +	}
> +
> +	node_data->devfreq = devfreq_get_devfreq_by_phandle(dev, index);
> +	if (IS_ERR(node_data->devfreq)) {
> +		ret = PTR_ERR(node_data->devfreq);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to fetch devfreq %d %s: %d\n",
> +					index, node_desc->adj->devfreq_name, ret);
> +		return ret;
> +	}
> +
> +	return dev_pm_qos_add_request(node_data->devfreq->dev.parent,
> +			&node_data->qos_req,
> +			DEV_PM_QOS_MIN_FREQUENCY, 0);
> +}
> +
> +static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
> +					 const struct imx_icc_node_desc *node_desc)
> +{
> +	struct imx_icc_provider *provider_data = provider->data;
> +	struct device *dev = provider_data->dev;
> +	struct imx_icc_node *node_data;
> +	struct icc_node *node;
> +	int ret;
> +
> +	node = icc_node_create(node_desc->id);
> +	if (IS_ERR(node)) {
> +		dev_err(dev, "failed to create node %d\n", node_desc->id);
> +		return node;
> +	}
> +
> +	if (node->data) {
> +		dev_err(dev, "already created node %s id=%d\n",
> +				node_desc->name, node_desc->id);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	node_data = devm_kzalloc(dev, sizeof(*node_data), GFP_KERNEL);
> +	if (!node_data) {
> +		icc_node_destroy(node->id);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	node->name = node_desc->name;
> +	node->data = node_data;
> +	node_data->desc = node_desc;
> +	if (node_desc->adj) {
> +		ret = imx_icc_node_init_devfreq(dev, node);
> +		if (ret < 0) {
> +			icc_node_destroy(node->id);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	icc_node_add(node, provider);
> +
> +	return node;
> +}
> +
> +static void imx_icc_unregister_nodes(struct icc_provider *provider)
> +{
> +	struct icc_node *node, *tmp;
> +
> +	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
> +		struct imx_icc_node *node_data = node->data;
> +
> +		icc_node_del(node);
> +		icc_node_destroy(node->id);
> +		if (dev_pm_qos_request_active(&node_data->qos_req))
> +			dev_pm_qos_remove_request(&node_data->qos_req);
> +	}
> +}
> +
> +static int imx_icc_register_nodes(struct icc_provider *provider,
> +				  const struct imx_icc_node_desc *descs,
> +				  int count)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		struct icc_node *node;
> +		const struct imx_icc_node_desc *node_desc = &descs[i];
> +		size_t j;
> +
> +		node = imx_icc_node_add(provider, node_desc);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(provider->dev, "failed to add %s: %d\n",
> +						node_desc->name, ret);
> +			goto err;
> +		}
> +
> +		for (j = 0; j < node_desc->num_links; j++)
> +			icc_link_create(node, node_desc->links[j]);
> +	}
> +
> +	return 0;
> +
> +err:
> +	imx_icc_unregister_nodes(provider);
> +
> +	return ret;
> +}
> +
> +int imx_icc_register(struct platform_device *pdev,
> +		     struct imx_icc_node_desc *nodes, int nodes_count)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_icc_provider *desc;
> +	struct icc_provider *provider;
> +	int ret;
> +
> +	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +	desc->dev = dev;
> +
> +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
> +	if (!provider)
> +		return -ENOMEM;
> +	provider->set = imx_icc_set;
> +	provider->aggregate = imx_icc_aggregate;
> +	provider->xlate = imx_icc_xlate;
> +	provider->data = desc;
> +	provider->dev = dev;
> +	platform_set_drvdata(pdev, provider);
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(dev, "error adding interconnect provider\n");
> +		return ret;
> +	}
> +
> +	ret = imx_icc_register_nodes(provider, nodes, nodes_count);
> +	if (ret) {
> +		dev_err(dev, "error adding interconnect nodes\n");
> +		goto provider_del;
> +	}
> +
> +	return 0;
> +
> +provider_del:
> +	icc_provider_del(provider);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_icc_register);
> +
> +int imx_icc_unregister(struct platform_device *pdev)
> +{
> +	struct icc_provider *provider = platform_get_drvdata(pdev);
> +
> +	icc_provider_del(provider);
> +	imx_icc_unregister_nodes(provider);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(imx_icc_unregister);
> diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
> new file mode 100644
> index 000000000000..ab191eb89616
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Interconnect framework driver for i.MX SoC
> + *
> + * Copyright (c) 2019, BayLibre
> + * Copyright (c) 2019, NXP
> + * Author: Alexandre Bailon <abailon@baylibre.com>
> + * Author: Leonard Crestez <leonard.crestez@nxp.com>
> + */
> +#ifndef __BUSFREQ_H
> +#define __BUSFREQ_H

Maybe __DRIVERS_INTERCONNECT_IMX_IMX_H to match with the path and filename.

> +
> +#include <linux/kernel.h>
> +
> +#define IMX_ICC_MAX_LINKS	32

2 seems enough?

> +#define IMX_ICC_UNDEFINED_BW	0xffffffff

Is this used?

> +
> +/*
> + * struct imx_icc_node_adj - Describe an dynamic adjustment knob

s/an/a/

> + */
> +struct imx_icc_node_adj_desc {
> +	const char *devfreq_name;
> +	unsigned int bw_mul, bw_div;
> +};
> +
> +/*
> + * struct imx_icc_node - Describe an interconnect node
> + * @name: name of the node
> + * @id: an unique id to identify the node
> + * @links: an array of slaves' node id
> + * @num_links: number of id defined in links
> + */
> +struct imx_icc_node_desc {
> +	const char *name;
> +	u16 id;
> +	u16 links[IMX_ICC_MAX_LINKS];
> +	u16 num_links;
> +
> +	const struct imx_icc_node_adj_desc *adj;
> +};
> +
> +#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, _numlinks, ...)	\

You can remove the _numlinks...

> +	{								\
> +		.id = _id,						\
> +		.name = _name,						\
> +		.adj = _adj,						\
> +		.num_links = _numlinks,					\

...and calculate the number of links automatically with:
		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\

> +		.links = { __VA_ARGS__ },				\
> +	}
> +
> +#define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\
> +	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, 1, _dest_id)
> +
> +#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\
> +	DEFINE_BUS_INTERCONNECT(_name, _id, _adj, 0)
> +
> +int imx_icc_register(struct platform_device *pdev,
> +		     struct imx_icc_node_desc *nodes,
> +		     int nodes_count);
> +int imx_icc_unregister(struct platform_device *pdev);
> +
> +#endif /* __BUSFREQ_H */
Thanks,
Georgi


