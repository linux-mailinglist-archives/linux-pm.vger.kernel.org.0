Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11B42E9D28
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 19:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhADSgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 13:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADSgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 13:36:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE89C061794
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 10:36:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q75so186327wme.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VcMfSSwNdSOxEd5dJy/2gbjQYKroue8Hj5qE0mEd/LI=;
        b=nLkvHP1hgzQdgENVXqsGNMFNdD1I9EHbRnziEi54DWLtNOZvie2eR4CU2sqag2LMwU
         YZgqOU3yQcSVVjAnjvBDuhRljq7ay80IJ6Rvf7/I1o4JAlpJowNI7kwqEJaSdbDEhgR8
         u9KFTfic/fAWKYzkLB26ypwxiq8MXhtY5UDeYlzSgts3Lw1/yJNkvuBJCstjrsWhSq1d
         nmn3MJiw/sJZfCZYeE112MpcSVhWKlaHuAwmx+GYPdir6b5ks19ciFX9tBRdnE3xSoGc
         GQlO6VBa1iFXwQu3Xa0eIz1yuLaIjyL7koGs8XUdZRUlrVQoeY/dcuEMZTqi//u2epx6
         b3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VcMfSSwNdSOxEd5dJy/2gbjQYKroue8Hj5qE0mEd/LI=;
        b=O2+0wMOLRwkxE8FGqMTVAYuMxKCFADmaHjrxk7tibSrq7SWHuTZybFpJVAWeRPvpbv
         U2jFaAjATsjaisi8is8iQFlyB0F2uXESQJK9CBOa0mQumus597MNNb8A4dKLs7W7HGLF
         4zEBia/ELY+NLBUp74pkGCI8IkDt8VWBMxW02mmpbAOE3tvHCggKT0bosz+cFkvjCAmx
         SK+sj+S1YIT0T2scn7Enj9flbPPxolGr5kpZ6j4MCv9B9X2Q+nC2iloTMupTKi/iDfv3
         ivRbSewcaFqTW3WzC6F+9f2wQuQvTFS58svLBq2QScsMn6DFL5SvqrnbbLNKdWPLejhi
         x2yw==
X-Gm-Message-State: AOAM533cHFNFznb1CdYClq1OLM5/xyKs+JC7rbvopzMjPY485axtJzEy
        LQpI0th3w6LuS6LIJRMDy3/7xCuPzX/lKQ==
X-Google-Smtp-Source: ABdhPJzELvss8TLuNgoP16gx9BnAupDOxbh0Wn4nAypeRpHgDOw6kAZ1sZnbdXYevsvWrmsQ3sVmJg==
X-Received: by 2002:a1c:9acb:: with SMTP id c194mr178273wme.43.1609785363181;
        Mon, 04 Jan 2021 10:36:03 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h184sm298255wmh.23.2021.01.04.10.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 10:36:02 -0800 (PST)
To:     Henry Chen <henryc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
 <1608790134-27425-9-git-send-email-henryc.chen@mediatek.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH V6 08/13] interconnect: mediatek: Add interconnect
 provider driver
Message-ID: <c8b951b0-6412-d905-99e1-6350283b57c1@linaro.org>
Date:   Mon, 4 Jan 2021 20:36:04 +0200
MIME-Version: 1.0
In-Reply-To: <1608790134-27425-9-git-send-email-henryc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/24/20 08:08, Henry Chen wrote:
> Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
> using the interconnect framework.
> 
>               ICC provider         ICC Nodes
>                                ----          ----
>               ---------       |CPU |   |--- |VPU |
>      -----   |         |-----  ----    |     ----
>     |DRAM |--|DRAM     |       ----    |     ----
>     |     |--|scheduler|----- |GPU |   |--- |DISP|
>     |     |--|(EMI)    |       ----    |     ----
>     |     |--|         |       -----   |     ----
>      -----   |         |----- |MMSYS|--|--- |VDEC|
>               ---------        -----   |     ----
>                 /|\                    |     ----
>                  |change DRAM freq     |--- |VENC|
>               ----------               |     ----
>              |  DVFSR   |              |
>              |          |              |     ----
>               ----------               |--- |IMG |
>                                        |     ----
>                                        |     ----
>                                        |--- |CAM |
>                                              ----
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>   drivers/interconnect/Kconfig            |   1 +
>   drivers/interconnect/Makefile           |   1 +
>   drivers/interconnect/mediatek/Kconfig   |  13 ++
>   drivers/interconnect/mediatek/Makefile  |   3 +
>   drivers/interconnect/mediatek/mtk-emi.c | 330 ++++++++++++++++++++++++++++++++
>   5 files changed, 348 insertions(+)
>   create mode 100644 drivers/interconnect/mediatek/Kconfig
>   create mode 100644 drivers/interconnect/mediatek/Makefile
>   create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5b7204e..e939f5a 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -13,5 +13,6 @@ if INTERCONNECT
>   
>   source "drivers/interconnect/imx/Kconfig"
>   source "drivers/interconnect/qcom/Kconfig"
> +source "drivers/interconnect/mediatek/Kconfig"

Sort alphabetically please.

>   
>   endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index d203520..0643a24 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -6,3 +6,4 @@ icc-core-objs				:= core.o bulk.o
>   obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>   obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
>   obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_MTK)		+= mediatek/

Ditto.

> diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
> new file mode 100644
> index 0000000..972d3bb
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/Kconfig
> @@ -0,0 +1,13 @@
> +config INTERCONNECT_MTK
> +	bool "Mediatek Network-on-Chip interconnect drivers"
> +	depends on ARCH_MEDIATEK
> +	help
> +	  Support for Mediatek's Network-on-Chip interconnect hardware.
> +
> +config INTERCONNECT_MTK_EMI
> +	tristate "Mediatek EMI interconnect driver"
> +	depends on INTERCONNECT_MTK
> +	depends on (MTK_DVFSRC && OF)

Would it be possible to enable COMPILE_TEST?

> +	help
> +	  This is a driver for the Mediatek Network-on-Chip on DVFSRC-based
> +	  platforms.
> diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
> new file mode 100644
> index 0000000..353842b
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_INTERCONNECT_MTK_EMI) += mtk-emi.o
> \ No newline at end of file
> diff --git a/drivers/interconnect/mediatek/mtk-emi.c b/drivers/interconnect/mediatek/mtk-emi.c
> new file mode 100644
> index 0000000..9670077
> --- /dev/null
> +++ b/drivers/interconnect/mediatek/mtk-emi.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.

Just a reminder that the year should be updated when you re-submit.

> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk_dvfsrc.h>
> +#include <dt-bindings/interconnect/mtk,mt8183-emi.h>
> +#include <dt-bindings/interconnect/mtk,mt6873-emi.h>

Nit: Alphanumeric order please.

[..]
> +static int emi_icc_remove(struct platform_device *pdev);
> +static int emi_icc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	const struct mtk_icc_desc *desc;
> +	struct device *dev = &pdev->dev;
> +	struct icc_node *node;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct mtk_icc_node **mnodes;
> +	size_t num_nodes, i, j;
> +	int ret;
> +
> +	match = of_match_node(emi_icc_of_match, dev->parent->of_node);
> +
> +	if (!match) {
> +		dev_err(dev, "invalid compatible string\n");
> +		return -ENODEV;
> +	}
> +
> +	desc = match->data;
> +	mnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
> +	if (!provider)
> +		return -ENOMEM;
> +
> +	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	provider->dev = pdev->dev.parent;
> +	provider->set = emi_icc_set;
> +	provider->aggregate = emi_icc_aggregate;
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
> +		for (j = 0; j < mnodes[i]->num_links; j++)
> +			icc_link_create(node, mnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	platform_set_drvdata(pdev, provider);
> +
> +	return 0;
> +err:
> +	icc_nodes_remove(provider);

Also call icc_provider_del() to restore the original state on error.

Thanks,
Georgi

> +	return ret;
> +}
> +
> +static int emi_icc_remove(struct platform_device *pdev)
> +{
> +	struct icc_provider *provider = platform_get_drvdata(pdev);
> +
> +	icc_nodes_remove(provider);
> +	return icc_provider_del(provider);
> +}
> +
