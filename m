Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A7E19BFD3
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbgDBLGD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 07:06:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37068 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgDBLGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 07:06:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so3704925wrm.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R45Ko3a7iVto5zEmiZKt8W3X4kvp5DkCum6wtFk44j0=;
        b=J9Y9udU1dffZFbYvYOmvAZ5/9+ekGcUS/ZJkDDqKJgZQvjNgcF8CDJ9DwZIk4mxTOf
         K1EBXcbU9sxIh+Y86bpaa1sz2igurtKQgrtXnwO8p7VsfJswVgxLImzn/yDNA85k8039
         OvE3GhpnDLoFZayhjP3Upt6GTxo8OPie0OlCWYmzqbktszJDJDwVgZzhcGL3K42hNEM8
         IZYJ5pNaIwE03YPmoP2gIcymmGyf4Tw96mstCtZ0fQHncqgUBN1jHmo373B5cmKKwcak
         tNFrhy1xkhdOCSyWhgN45t3oVLenS2exR62T0JttDrBA1MP+7HohbDmUhzBcAaPmUvLR
         xSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R45Ko3a7iVto5zEmiZKt8W3X4kvp5DkCum6wtFk44j0=;
        b=PRw0OLDi5yLi3mnbGE9YAgPWI5kEPEQ+sgSbBkIFsgsb+SqHu1vaMT1eH1gHdU3szg
         6FdJzdE79m/Hqx8VD0DMTVI5+zCtIZmexKzZQp1Is+tPjpCpBBM3pF/NVKwyXGTjUdDP
         Vsj5Btm9ixgqNtdBQZr1ZlSpwIB1TXNFR1+tYypbEDGQ8zb7UhbRLBciX3Rllg6D/OcS
         a4tKnBaaWjy9UnF6APVbOU/xjy+7+vS/gieQUdvEU8/bvVT1bZR6u5hTeQAf2LNR+src
         ia3g2ySDUmU7AVDXBBXIDQ3nxiljpZzkFtkbAZUauL6/vvq+RdTSFRB4qIMRQi2HMolc
         yj+g==
X-Gm-Message-State: AGi0PubPaQ/73GY06jNdtZVfhoVaiqd2w1NPfyfIv3V40YELqnCpniED
        doeHo2/fjzeXTq5e7pi4g8KiSg==
X-Google-Smtp-Source: APiQypKNixO3zXkQmll/p9ILzKAugzDkdZDEZZyIhJ+YV9b+WiMm+IA5B5PHNHEZPdbwF8H/AlRaWQ==
X-Received: by 2002:adf:afc3:: with SMTP id y3mr1483357wrd.144.1585825557675;
        Thu, 02 Apr 2020 04:05:57 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id b7sm7086743wrn.67.2020.04.02.04.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 04:05:57 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v2 4/8] interconnect: Add imx core driver
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
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
References: <cover.1585751281.git.leonard.crestez@nxp.com>
 <50e6bdb1aab7d8f73cb10d11a4ea1e55056448fc.1585751281.git.leonard.crestez@nxp.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <4464d011-5948-61ef-97bb-173f428021ad@linaro.org>
Date:   Thu, 2 Apr 2020 14:05:54 +0300
MIME-Version: 1.0
In-Reply-To: <50e6bdb1aab7d8f73cb10d11a4ea1e55056448fc.1585751281.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Thank you for updating the patches!

On 4/1/20 17:33, Leonard Crestez wrote:
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
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/interconnect/Kconfig      |   1 +
>  drivers/interconnect/Makefile     |   1 +
>  drivers/interconnect/imx/Kconfig  |   5 +
>  drivers/interconnect/imx/Makefile |   3 +
>  drivers/interconnect/imx/imx.c    | 298 ++++++++++++++++++++++++++++++
>  drivers/interconnect/imx/imx.h    |  62 +++++++
>  6 files changed, 370 insertions(+)
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

Nit: Please move it up to make it sorted.

>  
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 725029ae7a2c..6998288a7d98 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -3,5 +3,6 @@
>  CFLAGS_core.o				:= -I$(src)
>  icc-core-objs				:= core.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/

Ditto.

> diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
> new file mode 100644
> index 000000000000..f39336f8d603
> --- /dev/null
> +++ b/drivers/interconnect/imx/Kconfig
> @@ -0,0 +1,5 @@
> +config INTERCONNECT_IMX
> +	tristate "i.MX interconnect drivers"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	help
> +	  Generic interconnect drivers for i.MX SOCs
> diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
> new file mode 100644
> index 000000000000..86ae0bd28d8c
> --- /dev/null
> +++ b/drivers/interconnect/imx/Makefile
> @@ -0,0 +1,3 @@
> +imx-interconnect-objs			:= imx.o
> +
> +obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> new file mode 100644
> index 000000000000..527b1de1c41a
> --- /dev/null
> +++ b/drivers/interconnect/imx/imx.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interconnect framework driver for i.MX SoC
> + *
> + * Copyright (c) 2019, BayLibre
> + * Copyright (c) 2019, NXP

Maybe update it to 2020.

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

Please remove and use the common library function:
icc_std_aggregate().

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
> +		node->name, dev_name(node_data->qos_dev),
> +		node->avg_bw, node->peak_bw, freq);
> +
> +	if (freq > S32_MAX) {
> +		dev_err(dev, "%s can't request more than S32_MAX freq\n",
> +				node->name);

Please align with the open parenthesis.

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
> +	int ret;
> +
> +	if (dev_pm_qos_request_active(&node_data->qos_req)) {
> +		ret = dev_pm_qos_remove_request(&node_data->qos_req);
> +		if (ret)
> +			dev_warn(node->provider->dev, "failed to remove qos request for %s\n",
> +				 dev_name(node_data->qos_dev));
> +	}
> +
> +	put_device(node_data->qos_dev);
> +	icc_node_del(node);
> +	icc_node_destroy(node->id);
> +}
> +
> +static int imx_icc_node_init_qos(struct icc_provider *provider,
> +				 struct icc_node *node)
> +{
> +	struct imx_icc_node *node_data = node->data;
> +	const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
> +	struct device *dev = provider->dev;
> +	struct device_node *dn = NULL;
> +	struct platform_device *pdev;
> +
> +	if (adj->main_noc) {
> +		node_data->qos_dev = dev;
> +		dev_info(dev, "icc node %s[%d] is main noc itself\n",
> +			 node->name, node->id);

Should this be dev_dbg()?

> +	} else {
> +		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
> +		if (IS_ERR(dn)) {
> +			dev_warn(dev, "Failed to parse %s: %ld\n",
> +					adj->phandle_name, PTR_ERR(dn));

Please align with the open parenthesis.

> +			return PTR_ERR(dn);
> +		}
> +		/* Allow scaling to be disabled on a per-node basis */
> +		if (!dn || !of_device_is_available(dn)) {
> +			dev_warn(dev, "Missing property %s, skip scaling %s\n",
> +					adj->phandle_name, node->name);

Please align with the open parenthesis.

> +			return 0;
> +		}
> +
> +		pdev = of_find_device_by_node(dn);
> +		of_node_put(dn);
> +		if (!pdev) {
> +			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
> +					node->name, node->id, dn);

Please align with the open parenthesis.

> +			return -EPROBE_DEFER;
> +		}
> +		node_data->qos_dev = &pdev->dev;
> +		dev_info(dev, "node %s[%d] has device node %pOF\n",
> +			 node->name, node->id, dn);

dev_dbg() again maybe? Unless you think that it make sense to print this
information to the user?

> +	}
> +
> +	return dev_pm_qos_add_request(node_data->qos_dev,
> +				      &node_data->qos_req,
> +				      DEV_PM_QOS_MIN_FREQUENCY, 0);
> +}
> +
> +static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
> +					 const struct imx_icc_node_desc *node_desc)
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

Please align with the open parenthesis.

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

provider->aggregate = icc_std_aggregate;

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
> +	int ret;
> +
> +	if (provider->users) {
> +		dev_warn(&pdev->dev, "interconnect provider still has %d users\n",
> +			provider->users);
> +		return -EBUSY;
> +	}

The above check already exists in icc_provider_del(). But i assume you don't
want to delete any nodes from the provider if it still has users. Maybe it will
be sensible to add this check into icc_nodes_remove() instead, so that such
cases are handled on a framework level.

> +	imx_icc_unregister_nodes(provider);
> +
> +	ret = icc_provider_del(provider);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(imx_icc_unregister);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
> new file mode 100644
> index 000000000000..aa811e4ebb7e
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
> +#ifndef __DRIVERS_INTERCONNECT_IMX_H
> +#define __DRIVERS_INTERCONNECT_IMX_H
> +
> +#include <linux/kernel.h>
> +
> +#define IMX_ICC_MAX_LINKS	4
> +
> +/*
> + * struct imx_icc_node_adj - Describe a dynamic adjustable node
> + */
> +struct imx_icc_node_adj_desc {
> +	unsigned int bw_mul, bw_div;
> +	const char *phandle_name;
> +	bool main_noc;
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

Why the blank line?

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
Thanks,
Georgi

