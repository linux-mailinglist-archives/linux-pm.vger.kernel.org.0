Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300C91C363
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENGnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 02:43:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40179 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfENGnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 02:43:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id h13so10914567lfc.7
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IOwZgY53uo9afNXAbNOCrN584Khryn8hDev82i6sR+E=;
        b=oYzeg0BqozEIMz4LqVVGXYfy+5nRClDTJ5TH9aMzNZxq0k7PgL47WgV0b/j0UFfoiY
         SGb/8Wh9wb9bD97KwVndEUwLmsbN0yW0UTavW6oMbPOXa6jw9JamktHALZSINF2df8Kj
         INIBuvgZr3DB89IcLkf+ujbBxZcfkKcXGs5IYGaTrKlzlhzx8as+610BJbAI57hZULGa
         R4tZJuaGZkEx7YYh9Nad8Y40AEvWGnXWwPUjzvQkTl0VEowH8PL70KHowiAJIfNZMZMl
         MSN7n88YQ3ipB93iZyjAX+wDb7EOp0JDscNpuLN884RAhETUvAwW2thaSAc5UU9C/VEr
         KmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IOwZgY53uo9afNXAbNOCrN584Khryn8hDev82i6sR+E=;
        b=NJSu2JQDqqkXn5Rz4nRbsCyzcfRH4CQlCtHxPVp7BeZkZGqw0DRpLqMkYkb1sAlhrf
         v9AyIrta/dg8lUEiIUkLdq82wj/3B9LAh30ovSnpfvj2B4t67cpm4rPRq5c9d6fYeghv
         UjutBIdavx6CxoaJ7BB8VPKqLAPsbbI4EhJLlQgCZlp3N7mR6bOzrChzmtBYvXbYyAO6
         7MTTTrRPSzk4bYMblmLbdl/FDb5qUYX3ITWdyLi3ynFVAV3NjLJabTYWNws4p3H9PPcS
         AlHkbWzrUzi4SJ7v4uJ9nTcizhTFDqNZNlGqLhi7Hx1GBnZsov5bgFGDmcYGrwCGS4hr
         sRNw==
X-Gm-Message-State: APjAAAWG9icaGoZmkw31qxCB1kFRaCdruzkrAEp2G/8NdwF06gh1m08s
        +KW1zl0aS+O2KBObr0eo6oyOwuUqwwA=
X-Google-Smtp-Source: APXvYqw0qQMTauij/Oo/ropk6BAlzxAgoBgwtfrwjlTkx5VWmps+w3jDb8BBy/DMVTtPFVWV3FhbFg==
X-Received: by 2002:ac2:5612:: with SMTP id v18mr1119673lfd.15.1557816219258;
        Mon, 13 May 2019 23:43:39 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o7sm3478877lfl.13.2019.05.13.23.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 23:43:38 -0700 (PDT)
Subject: Re: [RFC V2 10/11] interconnect: mediatek: Add mt8183 interconnect
 provider driver
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
 <1556614265-12745-11-git-send-email-henryc.chen@mediatek.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b8db4f70-4b95-5a98-38b4-9990bae023b4@linaro.org>
Date:   Tue, 14 May 2019 09:43:36 +0300
MIME-Version: 1.0
In-Reply-To: <1556614265-12745-11-git-send-email-henryc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Henry,

On 4/30/19 11:51, Henry Chen wrote:
> Introduce Mediatek MT8183 specific provider driver using the
> interconnect framework.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/interconnect/Kconfig           |   1 +
>  drivers/interconnect/Makefile          |   1 +
>  drivers/interconnect/mediatek/Kconfig  |  13 ++
>  drivers/interconnect/mediatek/Makefile |   5 +
>  drivers/interconnect/mediatek/mt8183.c | 223 +++++++++++++++++++++++++++++++++
>  5 files changed, 243 insertions(+)
>  create mode 100644 drivers/interconnect/mediatek/Kconfig
>  create mode 100644 drivers/interconnect/mediatek/Makefile
>  create mode 100644 drivers/interconnect/mediatek/mt8183.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 07a8276..ac41ea6 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -11,5 +11,6 @@ menuconfig INTERCONNECT
>  if INTERCONNECT
>  
>  source "drivers/interconnect/qcom/Kconfig"
> +source "drivers/interconnect/mediatek/Kconfig"
>  
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 28f2ab0..253f24a3 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -4,3 +4,4 @@ icc-core-objs				:= core.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_MTK)		+= mediatek/
> diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
> new file mode 100644
> index 0000000..0686494
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/Kconfig
> @@ -0,0 +1,13 @@
> +config INTERCONNECT_MTK
> +	bool "Mediatek Network-on-Chip interconnect drivers"
> +	depends on ARCH_MEDIATEK
> +	help
> +	  Support for Mediatek's Network-on-Chip interconnect hardware.
> +
> +config INTERCONNECT_MTK_MT8183
> +	tristate "Mediatek MT8183 interconnect driver"
> +	depends on INTERCONNECT_MTK
> +	depends on (MTK_DVFSRC && OF)
> +	help
> +	  This is a driver for the Mediatek Network-on-Chip on mt8183-based
> +	  platforms.
> diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
> new file mode 100644
> index 0000000..a39ceee
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +mtk-mt8183-objs			:= mt8183.o
> +
> +obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mtk-mt8183.o
> \ No newline at end of file
> diff --git a/drivers/interconnect/mediatek/mt8183.c b/drivers/interconnect/mediatek/mt8183.c
> new file mode 100644
> index 0000000..38ffe0b
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/mt8183.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/interconnect/mtk,mt8183.h>
> +#include <linux/device.h>
> +#include <linux/interconnect.h>

This is not needed.

> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <soc/mediatek/mtk_dvfsrc.h>
> +
> +#define MT8183_MAX_LINKS	6
> +
> +/**
> + * struct mtk_icc_node - Mediatek specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @ep: true if the node is an end point.
> + * @id: a unique node identifier
> + * @links: an array of nodes where we can go next while traversing
> + * @num_links: the total number of @links
> + * @buswidth: width of the interconnect between a node and the bus

Maybe mention the units?

> + * @sum_avg: current sum aggregate value of all avg bw requests
> + * @max_peak: current max aggregate value of all peak bw requests

units?

> + */
> +struct mtk_icc_node {
> +	unsigned char *name;
> +	bool ep;
> +	u16 id;
> +	u16 links[MT8183_MAX_LINKS];
> +	u16 num_links;
> +	u16 buswidth;
> +	u64 sum_avg;
> +	u64 max_peak;
> +};
> +
> +struct mtk_icc_desc {
> +	struct mtk_icc_node **nodes;
> +	size_t num_nodes;
> +};
> +
> +#define DEFINE_MNODE(_name, _id, _buswidth, _ep, _numlinks, ...)	\

We can drop the _numlinks and..

> +		static struct mtk_icc_node _name = {			\
> +		.name = #_name,						\
> +		.id = _id,						\
> +		.buswidth = _buswidth,					\
> +		.ep = _ep,						\
> +		.num_links = _numlinks,					\

..just use 	.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ }))

> +		.links = { __VA_ARGS__ },				\
> +}
> +
> +DEFINE_MNODE(ddr_emi, SLAVE_DDR_EMI, 1024, 1, 0, 0);
> +DEFINE_MNODE(mcusys, MASTER_MCUSYS, 256, 0, 1, SLAVE_DDR_EMI);
> +DEFINE_MNODE(gpu, MASTER_GPU, 256, 0, 1, SLAVE_DDR_EMI);
> +DEFINE_MNODE(mmsys, MASTER_MMSYS, 256, 0, 1, SLAVE_DDR_EMI);
> +DEFINE_MNODE(mm_vpu, MASTER_MM_VPU, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_disp, MASTER_MM_DISP, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_vdec, MASTER_MM_VDEC, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_venc, MASTER_MM_VENC, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_cam, MASTER_MM_CAM, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_img, MASTER_MM_IMG, 128, 0, 1, MASTER_MMSYS);
> +DEFINE_MNODE(mm_mdp, MASTER_MM_MDP, 128, 0, 1, MASTER_MMSYS);
> +
> +static struct mtk_icc_node *mt8183_icc_nodes[] = {
> +	&ddr_emi,
> +	&mcusys,
> +	&gpu,
> +	&mmsys,
> +	&mm_vpu,
> +	&mm_disp,
> +	&mm_vdec,
> +	&mm_venc,
> +	&mm_cam,
> +	&mm_img,
> +	&mm_mdp,
> +};
> +
> +static struct mtk_icc_desc mt8183_icc = {
> +	.nodes = mt8183_icc_nodes,
> +	.num_nodes = ARRAY_SIZE(mt8183_icc_nodes),
> +};
> +
> +static int mt8183_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	struct mtk_icc_node *in;
> +
> +	in = node->data;
> +
> +	*agg_avg += avg_bw;
> +	*agg_peak = max_t(u32, *agg_peak, peak_bw);
> +
> +	in->sum_avg = *agg_avg;
> +	in->max_peak = *agg_peak;
> +
> +	return 0;
> +}
> +
> +static int mt8183_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	int ret = 0;
> +	struct mtk_icc_node *node;
> +
> +	node = dst->data;
> +	if (node->ep) {
> +		pr_debug("sum_avg (%llu), max_peak (%llu)\n",
> +			node->sum_avg, node->max_peak);
> +		mtk_dvfsrc_send_request(src->provider->dev->parent,
> +					MTK_DVFSRC_CMD_BW_REQUEST,
> +					node->max_peak);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mt8183_icc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	const struct mtk_icc_desc *desc;
> +	struct icc_node *node;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct mtk_icc_node **mnodes;
> +	size_t num_nodes, i, j;
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	mnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	provider = devm_kzalloc(&pdev->dev, sizeof(*provider), GFP_KERNEL);
> +	if (!provider)
> +		return -ENOMEM;
> +
> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	provider->dev = &pdev->dev;
> +	provider->set = mt8183_icc_set;
> +	provider->aggregate = mt8183_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->data = data;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error adding interconnect provider\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		node = icc_node_create(mnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = mnodes[i]->name;
> +		node->data = mnodes[i];
> +		icc_node_add(node, provider);
> +
> +		dev_dbg(&pdev->dev, "registered node %s, num link: %d\n",
> +			mnodes[i]->name, mnodes[i]->num_links);
> +
> +		/* populate links */
> +		for (j = 0; j < mnodes[i]->num_links; j++)
> +			icc_link_create(node, mnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	platform_set_drvdata(pdev, provider);
> +
> +	return ret;

just return 0;

> +err:
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		icc_node_del(node);
> +		icc_node_destroy(node->id);
> +	}
> +
> +	icc_provider_del(provider);
> +	return ret;
> +}
> +
> +static int mt8183_icc_remove(struct platform_device *pdev)
> +{
> +	struct icc_provider *provider = platform_get_drvdata(pdev);
> +	struct icc_node *n;
> +
> +	list_for_each_entry(n, &provider->nodes, node_list) {
> +		icc_node_del(n);
> +		icc_node_destroy(n->id);
> +	}
> +
> +	return icc_provider_del(provider);
> +}
> +
> +static const struct of_device_id mt8183_icc_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-emi-icc", .data = &mt8183_icc },

A separate -icc compatible should not be needed.

Thanks,
Georgi
