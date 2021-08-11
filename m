Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E643E8F26
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhHKK4b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 06:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237233AbhHKK4a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 06:56:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07FFA60EB9;
        Wed, 11 Aug 2021 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628679367;
        bh=MNWTZ/70weNbDnunlQZ0i4+2qg5+X3dKvya4CSdq02k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A7vSGYZnGXQafdFrBZGL2cv8fjYl7sLZ8ONA8ZIkV7IQrz1futdxY4vFxKfVSVBIK
         UMLyYUu6JG49GAOg2ftkojsKdIWY1FMnAIDD8NyNMifn1oK1MaWbDEe/Gf9eeH0cax
         tJeY+D6d03mTosw1MWLUvEIYKwi9iE1xIRsngfRZUA5XTBn/gk+DTwXNdQPeWTrhOB
         JsOeY8iGeCmPgIM52fXt4iHPGOia4uLkXvzmViqOkHys5PkKq7mRcxHrDpfEaS1qt1
         +roiY/a/wHheVXFUChO6MSu+87TToU8VOoWHMWpzNGJrWau5mGytp704hOXFJpXDLJ
         xDsiGDBJO9Zgg==
Subject: Re: [PATCH v3 5/6] interconnect: qcom: Add MSM8996 interconnect
 provider driver
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        okukatla@codeaurora.org, mdtipton@codeaurora.org
References: <20210811043451.189776-1-y.oudjana@protonmail.com>
 <20210811043451.189776-6-y.oudjana@protonmail.com>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <a520d353-f291-4596-e21b-6bdd27fdc965@kernel.org>
Date:   Wed, 11 Aug 2021 13:56:01 +0300
MIME-Version: 1.0
In-Reply-To: <20210811043451.189776-6-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yassine,

Thank you for working on this!

On 11.08.21 7:37, Yassine Oudjana wrote:
> Add a driver for the MSM8996 NoCs. This chip is similar to SDM660 where
> some busses are controlled by RPM, while others directly by the AP with
> writes to QoS registers.
> 
> This driver currently supports all NoCs except a0noc.

Just curious what's the issue with a0noc. Do we need to enable some GDSC
or clock in order to write to the QoS registers?

> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/interconnect/qcom/Kconfig   |   9 +
>   drivers/interconnect/qcom/Makefile  |   2 +
>   drivers/interconnect/qcom/msm8996.c | 574 ++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/msm8996.h | 149 ++++++++
>   4 files changed, 734 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/msm8996.c
>   create mode 100644 drivers/interconnect/qcom/msm8996.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index ad16224f1720..e30ad95e5584 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -35,6 +35,15 @@ config INTERCONNECT_QCOM_MSM8974
>   	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
>   	 platforms.
>   
> +config INTERCONNECT_QCOM_MSM8996
> +	tristate "Qualcomm MSM8996 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on QCOM_SMD_RPM
> +	select INTERCONNECT_QCOM_SMD_RPM_QOS
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
> +	  platforms.
> +
>   config INTERCONNECT_QCOM_OSM_L3
>   	tristate "Qualcomm OSM L3 interconnect driver"
>   	depends on INTERCONNECT_QCOM || COMPILE_TEST
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 2d04d024f46e..8a198b8b7a45 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -4,6 +4,7 @@ icc-bcm-voter-objs			:= bcm-voter.o
>   qnoc-msm8916-objs			:= msm8916.o
>   qnoc-msm8939-objs			:= msm8939.o
>   qnoc-msm8974-objs			:= msm8974.o
> +qnoc-msm8996-objs			:= msm8996.o
>   icc-osm-l3-objs				:= osm-l3.o
>   qnoc-qcs404-objs			:= qcs404.o
>   icc-rpmh-obj				:= icc-rpmh.o
> @@ -22,6 +23,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) += qnoc-msm8939.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> new file mode 100644
> index 000000000000..0cb93d743f35
> --- /dev/null
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -0,0 +1,574 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

The // style is preferred for .c files.

> +/*
> + * Qualcomm MSM8996 Network-on-Chip (NoC) QoS driver
> + *
> + * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/interconnect/qcom,msm8996.h>
> +
> +#include "icc-rpm-qos.h"
> +#include "smd-rpm.h"
> +#include "msm8996.h"
> +
[..]
> +DEFINE_QNODE(mas_mdp_p0, MSM8996_MASTER_MDP_PORT0, 32, 8, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, MSM8996_SLAVE_MNOC_BIMC);
> +DEFINE_QNODE(mas_mdp_p1, MSM8996_MASTER_MDP_PORT1, 32, 61, -1, true, NOC_QOS_MODE_BYPASS, 0, 2, MSM8996_SLAVE_MNOC_BIMC);
> +DEFINE_QNODE(mas_rotator, MSM8996_MASTER_ROTATOR, 32, 120, -1, true, NOC_QOS_MODE_BYPASS, 0, 0, MSM8996_SLAVE_MNOC_BIMC);
> +DEFINE_QNODE(mas_venus, MSM8996_MASTER_VIDEO_P0, 32, 9, -1, true, NOC_QOS_MODE_BYPASS, 0, 3 /* TODO: 3 4 ?? */, MSM8996_SLAVE_MNOC_BIMC);

Is the TODO for multiple QoS ports?

[..]

> +static const struct regmap_config msm8996_mnoc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x20000,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_icc_desc msm8996_mnoc = {
> +	.nodes = mnoc_nodes,
> +	.num_nodes = ARRAY_SIZE(mnoc_nodes),
> +	.regmap_cfg = &msm8996_mnoc_regmap_config,
> +};
> +
> +

Nit: No multiple blank lines, please.

> +static struct qcom_icc_node *pnoc_nodes[] = {
> +	[MASTER_SNOC_PNOC] = &mas_snoc_pnoc,
> +	[MASTER_SDCC_1] = &mas_sdcc_1,
> +	[MASTER_SDCC_2] = &mas_sdcc_2,
> +	[MASTER_SDCC_4] = &mas_sdcc_4,
> +	[MASTER_USB_HS] = &mas_usb_hs,
> +	[MASTER_BLSP_1] = &mas_blsp_1,
> +	[MASTER_BLSP_2] = &mas_blsp_2,
> +	[MASTER_TSIF] = &mas_tsif,
> +	[SLAVE_PNOC_A1NOC] = &slv_pnoc_a1noc,
> +	[SLAVE_USB_HS] = &slv_usb_hs,
> +	[SLAVE_SDCC_2] = &slv_sdcc_2,
> +	[SLAVE_SDCC_4] = &slv_sdcc_4,
> +	[SLAVE_TSIF] = &slv_tsif,
> +	[SLAVE_BLSP_2] = &slv_blsp_2,
> +	[SLAVE_SDCC_1] = &slv_sdcc_1,
> +	[SLAVE_BLSP_1] = &slv_blsp_1,
> +	[SLAVE_PDM] = &slv_pdm,
> +	[SLAVE_AHB2PHY] = &slv_ahb2phy,
> +};
> +
> +static const struct regmap_config msm8996_pnoc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x3000,
> +	.fast_io	= true,
> +};
> +
[..]
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		node = icc_node_create(qnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = qnodes[i]->name;
> +		node->data = qnodes[i];
> +		icc_node_add(node, provider);
> +
> +		for (j = 0; j < qnodes[i]->num_links; j++) {
> +			icc_link_create(node, qnodes[i]->links[j]);
> +		}

Nit: No need for braces.

Also please rebase all patches onto linux-next.

Thanks,
Georgi
