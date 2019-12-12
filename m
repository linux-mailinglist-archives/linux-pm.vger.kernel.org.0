Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFB11C664
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 08:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfLLH3O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 02:29:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36187 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfLLH3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 02:29:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so1549223wru.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 23:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=brI+4IufuruMkMfwAJIkYSNuk48oYROgkBkVJlhkW/o=;
        b=lOJQREGKnp2geXVH3y7iphkPqm/y2TtHyA+SZ5OC2lYGffPqeZHK6kmxlryhMK5CQ3
         69fIjjmDgtM0YyMzI4Lu2GQ740PxKKKZj/P2W//zHd/GpzjMGtY2dcbBm1SrbgbR3Wfi
         flv9HbL44RWXfDDaY7MhtXV6go16yrANSMezPkXI/vTwo+vYJn2ECY8W+Y8a2KG1u6l4
         X1bbp0ee9scfCjY2Z7ztePo+5ULOvZShN9kPg/O+bg2kAUGOm3ljKBm2/mELSdLySZbp
         fTFJ8eqXoLy8F8X6rVWlwp/q4iAXi6soLlCI1sQBdBznY3h/OBOc1EtyS85Nt9AazALL
         3Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brI+4IufuruMkMfwAJIkYSNuk48oYROgkBkVJlhkW/o=;
        b=MD5z4zAjv7WrDrqqFq583fvN9b+s00SGNsdivXW1PuyEICisokLRBE8HeT5D6y72Aa
         2EN48SzdQAYAEaUMU+ilvq4EXHsblbOJ5GtiViftimvjz8wuBarjXrA/05p6lpki5Kwq
         Xs/SLuOW1k4yOAfJNe84iX8eNKHTDRtN+/hUXymSgdulEVNr7JefT3HeTkH2wTXlwZZo
         IgPeBzBuaVsbwd8aiyYlvxkhNDTwMOzmFEnqXtey7jGo9AQQDSUbV5lscOmaQxlfvao4
         3l4Sr8AkqDs/8/V+vw5zFzB9fsaGUlqle8XY7NNJHfFdYYYQs3yDwDfv7WrzVVNvEwiF
         Biog==
X-Gm-Message-State: APjAAAXq9r8dXuyqTpDXG0eXOrJX/fwzJEMjc6oM8kIvDMsOLliD5K3Q
        vZhkTYaLKznz8SoEMOJKa9/UnQ==
X-Google-Smtp-Source: APXvYqyTtfpB3GkyHBIz36pIKXXEP0Z8wEYbyZKMrsagiB4X3i8r2XVlDY6rj3XKKd/rPTjHzUfu5w==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr4278391wrx.90.1576135750944;
        Wed, 11 Dec 2019 23:29:10 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b10sm4989163wrt.90.2019.12.11.23.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 23:29:10 -0800 (PST)
Subject: Re: [PATCH RFC v6 4/9] interconnect: Add imx core driver
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <ddfa004340787f8b138c54d89af486d9232dfff9.1573761527.git.leonard.crestez@nxp.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <48136159-21ba-c3b7-52c9-1d9d711644f7@linaro.org>
Date:   Thu, 12 Dec 2019 09:29:07 +0200
MIME-Version: 1.0
In-Reply-To: <ddfa004340787f8b138c54d89af486d9232dfff9.1573761527.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Thank you for your continuous work on the patches and sorry for not reviewing
this earlier.

On 11/14/19 22:09, Leonard Crestez wrote:
> This adds support for i.MX SoC family to interconnect framework.
> 
> Platform drivers can describe the interconnect graph and several
> adjustment knobs where icc node bandwidth is converted to a
> DEV_PM_QOS_MIN_FREQUENCY request.
> 
> The interconnect provider is probed through the main NOC device and
> other adjustable nodes on the same graph are found from a
> fsl,scalable-nodes phandle array property.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/interconnect/Kconfig      |   1 +
>  drivers/interconnect/Makefile     |   1 +
>  drivers/interconnect/imx/Kconfig  |   5 +
>  drivers/interconnect/imx/Makefile |   1 +
>  drivers/interconnect/imx/imx.c    | 301 ++++++++++++++++++++++++++++++
>  drivers/interconnect/imx/imx.h    |  60 ++++++
>  6 files changed, 369 insertions(+)
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
> index 000000000000..d08e64c239cd
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx.c
> @@ -0,0 +1,301 @@
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
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +
> +#include "imx.h"
> +
> +/* private icc_node data */
> +struct imx_icc_node {
> +	const struct imx_icc_node_desc *desc;
> +	struct device *qos_dev;
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
> +static int imx_icc_node_set(struct icc_node *node)
> +{
> +	struct device *dev = node->provider->dev;
> +	struct imx_icc_node *node_data = node->data;
> +	u64 freq;
> +
> +	if (!node_data->qos_dev)
> +		return 0;
> +
> +	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;
> +	do_div(freq, node_data->desc->adj->bw_div);
> +	dev_dbg(dev, "node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq %llukHz\n",
> +			node->name, dev_name(node_data->qos_dev),
> +			node->avg_bw, node->peak_bw, freq);

Nit: Please align all dev_dbg/dev_err to the open parenthesis.

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
> +/* imx_icc_node_destroy() - Destroy an imx icc_node, including private data */
> +static void imx_icc_node_destroy(struct icc_node *node)
> +{
> +	struct imx_icc_node *node_data = node->data;
> +
> +	if (dev_pm_qos_request_active(&node_data->qos_req))
> +		dev_pm_qos_remove_request(&node_data->qos_req);
> +	put_device(node_data->qos_dev);
> +	icc_node_del(node);
> +	icc_node_destroy(node->id);
> +}
> +
> +static int imx_icc_node_init_qos(struct icc_provider *provider,
> +				 struct icc_node *node)
> +{
> +	struct imx_icc_node *node_data = node->data;
> +	struct device *dev = provider->dev;
> +	struct device_node *dn = NULL;
> +	struct platform_device *pdev;
> +	int i, count;
> +	u32 node_id;
> +	int ret;
> +
> +	count = of_property_count_u32_elems(dev->of_node,
> +					    "fsl,scalable-node-ids");
> +	if (count < 0) {
> +		dev_err(dev, "Failed to parse fsl,scalable-node-ids: %d\n",
> +			count);
> +		return count;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		ret = of_property_read_u32_index(dev->of_node,
> +						 "fsl,scalable-node-ids",
> +						 i, &node_id);
> +
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to parse fsl,scalable-node-ids[%d]: %d\n",
> +				i, ret);
> +			return ret;
> +		}
> +		if (node_id != node->id)
> +			continue;
> +
> +		dn = of_parse_phandle(dev->of_node, "fsl,scalable-nodes", i);

Why is this needed? I would expect that the interconnect provider driver already
knows which nodes are scalable based on the platform compatible string.
Then maybe this driver should create devfreq devices for each node that is scalable?

> +		if (IS_ERR(dn)) {
> +			dev_err(dev, "Failed to parse fsl,scalable-nodes[%d]: %ld\n",
> +				i, PTR_ERR(dn));
> +			return PTR_ERR(dn);
> +		}
> +		break;
> +	}
> +
> +	/* Allow scaling to be disabled on a per-node basis */
> +	if (!dn || !of_device_is_available(dn))
> +		return 0;
> +
> +	pdev = of_find_device_by_node(dn);
> +	of_node_put(dn);
> +	if (!pdev) {
> +		dev_warn(dev, "node %s[%d] missing device for %pOF\n",
> +				node->name, node->id, dn);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	node_data->qos_dev = &pdev->dev;
> +	dev_info(dev, "node %s[%d] has device node %pOF\n",
> +		 node->name, node->id, dn);
> +	return dev_pm_qos_add_request(node_data->qos_dev,
> +				      &node_data->qos_req,
> +				      DEV_PM_QOS_MIN_FREQUENCY, 0);
> +}
> +
> +static struct icc_node *imx_icc_node_add(
> +		struct icc_provider *provider,

Nit: Move this after the open parenthesis on the line above and then align
the line below to the parenthesis and ignore the 80 cols rule.

> +		const struct imx_icc_node_desc *node_desc)
> +{
> +	struct device *dev = provider->dev;
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
> +	icc_node_add(node, provider);
> +
> +	if (node_desc->adj) {
> +		ret = imx_icc_node_init_qos(provider, node);
> +		if (ret < 0) {
> +			imx_icc_node_destroy(node);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	return node;
> +}
> +
> +static void imx_icc_unregister_nodes(struct icc_provider *provider)
> +{
> +	struct icc_node *node, *tmp;
> +
> +	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list)
> +		imx_icc_node_destroy(node);
> +}
> +
> +static int imx_icc_register_nodes(struct icc_provider *provider,
> +				  const struct imx_icc_node_desc *descs,
> +				  int count)
> +{
> +	struct icc_onecell_data *provider_data = provider->data;
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
> +					node_desc->name, ret);
> +			goto err;
> +		}
> +		provider_data->nodes[node->id] = node;
> +
> +		for (j = 0; j < node_desc->num_links; j++) {
> +			ret = icc_link_create(node, node_desc->links[j]);
> +			if (ret) {
> +				dev_err(provider->dev, "failed to link node %d to %d: %d\n",
> +					node->id, node_desc->links[j], ret);
> +				goto err;
> +			}
> +		}
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
> +static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_count)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < nodes_count; ++i)
> +		if (nodes[i].id > ret)
> +			ret = nodes[i].id;
> +
> +	return ret;
> +}
> +
> +int imx_icc_register(struct platform_device *pdev,
> +		     struct imx_icc_node_desc *nodes, int nodes_count)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	int max_node_id;
> +	int ret;
> +
> +	/* icc_onecell_data is indexed by node_id, unlike nodes param */
> +	max_node_id = get_max_node_id(nodes, nodes_count);
> +	data = devm_kzalloc(dev, struct_size(data, nodes, max_node_id),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->num_nodes = max_node_id;
> +
> +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
> +	if (!provider)
> +		return -ENOMEM;
> +	provider->set = imx_icc_set;
> +	provider->aggregate = imx_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	provider->data = data;
> +	provider->dev = dev->parent;
> +	platform_set_drvdata(pdev, provider);
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = imx_icc_register_nodes(provider, nodes, nodes_count);
> +	if (ret)
> +		goto provider_del;
> +
> +	pr_info("registered %s\n", pdev->name);
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
> index 000000000000..9f06c54ac2c8
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Interconnect framework driver for i.MX SoC
> + *
> + * Copyright (c) 2019, BayLibre
> + * Copyright (c) 2019, NXP
> + * Author: Alexandre Bailon <abailon@baylibre.com>
> + * Author: Leonard Crestez <leonard.crestez@nxp.com>
> + */
> +#ifndef __DRIVERS_INTERCONNECT_IMX_H
> +#define __DRIVERS_INTERCONNECT_IMX_H
> +
> +#include <linux/kernel.h>
> +
> +#define IMX_ICC_MAX_LINKS	4
> +
> +/*
> + * struct imx_icc_node_adj - Describe a dynamic adjustment knob
> + */
> +struct imx_icc_node_adj_desc {
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
> +#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
> +	{								\
> +		.id = _id,						\
> +		.name = _name,						\
> +		.adj = _adj,						\
> +		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
> +		.links = { __VA_ARGS__ },				\
> +	}
> +
> +#define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\
> +	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)
> +
> +#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\
> +	DEFINE_BUS_INTERCONNECT(_name, _id, _adj)
> +
> +int imx_icc_register(struct platform_device *pdev,
> +		     struct imx_icc_node_desc *nodes,
> +		     int nodes_count);
> +int imx_icc_unregister(struct platform_device *pdev);
> +
> +#endif /* __DRIVERS_INTERCONNECT_IMX_H */
> 

The rest look ok to me. We just need to figure out the scalable nodes thing.

Thanks,
Georgi
