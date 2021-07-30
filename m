Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C773DB96F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 15:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhG3NkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhG3Njw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 09:39:52 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B2C0617B9
        for <linux-pm@vger.kernel.org>; Fri, 30 Jul 2021 06:39:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E408020134;
        Fri, 30 Jul 2021 15:39:31 +0200 (CEST)
Subject: Re: [PATCH 1/5] interconnect: qcom: sdm660: Commonize RPM-QoS
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <tBji8z2BZb2uc4O2OP7PyUJqbxLiWwoKnR7Ybshs@cp3-web-050.plabs.ch>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <d65fa810-403f-29f3-ec18-16bcdfb68a85@somainline.org>
Date:   Fri, 30 Jul 2021 15:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <tBji8z2BZb2uc4O2OP7PyUJqbxLiWwoKnR7Ybshs@cp3-web-050.plabs.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 30/07/21 14:06, Yassine Oudjana ha scritto:
> SoCs such as MSM8996 also control bus QoS in a similar fashion to SDM660,
> with some paths being controlled by RPM and others directly by the AP.
> Move relevant functions and defines to a new object so that they can be used
> in multiple drivers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Hello Yassine,
thanks for the patch! However, I think there are a few things to improve:

> ---
>   drivers/interconnect/qcom/Kconfig       |   5 +-
>   drivers/interconnect/qcom/Makefile      |   2 +
>   drivers/interconnect/qcom/icc-rpm-qos.c | 237 ++++++++++++++++
>   drivers/interconnect/qcom/icc-rpm-qos.h | 133 +++++++++
>   drivers/interconnect/qcom/icc-rpmh.c    |   6 +-
>   drivers/interconnect/qcom/icc-rpmh.h    |   2 +-
>   drivers/interconnect/qcom/sc7180.c      |   2 +-
>   drivers/interconnect/qcom/sc7280.c      |   2 +-
>   drivers/interconnect/qcom/sdm660.c      | 346 +-----------------------
>   drivers/interconnect/qcom/sdm845.c      |   2 +-
>   drivers/interconnect/qcom/sdx55.c       |   2 +-
>   drivers/interconnect/qcom/sm8150.c      |   2 +-
>   drivers/interconnect/qcom/sm8250.c      |   2 +-
>   drivers/interconnect/qcom/sm8350.c      |   2 +-
>   14 files changed, 391 insertions(+), 354 deletions(-)
>   create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.c
>   create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 0d7a2500d0b8..ad16224f1720 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -87,7 +87,7 @@ config INTERCONNECT_QCOM_SDM660
>   	tristate "Qualcomm SDM660 interconnect driver"
>   	depends on INTERCONNECT_QCOM
>   	depends on QCOM_SMD_RPM
> -	select INTERCONNECT_QCOM_SMD_RPM
> +	select INTERCONNECT_QCOM_SMD_RPM_QOS
>   	help
>   	  This is a driver for the Qualcomm Network-on-Chip on sdm660-based
>   	  platforms.
> @@ -139,3 +139,6 @@ config INTERCONNECT_QCOM_SM8350
>   
>   config INTERCONNECT_QCOM_SMD_RPM
>   	tristate
> +
> +config INTERCONNECT_QCOM_SMD_RPM_QOS	
> +	tristate
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 2880129a6fe4..2d04d024f46e 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -16,6 +16,7 @@ qnoc-sm8150-objs			:= sm8150.o
>   qnoc-sm8250-objs			:= sm8250.o
>   qnoc-sm8350-objs			:= sm8350.o
>   icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
> +icc-smd-rpm-qos-objs			:= smd-rpm.o icc-rpm-qos.o
>   
>   obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
> @@ -33,3 +34,4 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM_QOS) += icc-smd-rpm-qos.o
> diff --git a/drivers/interconnect/qcom/icc-rpm-qos.c b/drivers/interconnect/qcom/icc-rpm-qos.c
> new file mode 100644
> index 000000000000..678b347375d8
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpm-qos.c
> @@ -0,0 +1,237 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
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
> +#include <linux/slab.h>
> +
> +#include "smd-rpm.h"
> +#include "icc-rpm-qos.h"
> +
> +static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
> +					struct qcom_icc_qos *qos,
> +					int regnum)
> +{
> +	u32 val;
> +	u32 mask;
> +
> +	val = qos->prio_level;
> +	mask = M_BKE_HEALTH_CFG_PRIOLVL_MASK;
> +
> +	val |= qos->areq_prio << M_BKE_HEALTH_CFG_AREQPRIO_SHIFT;
> +	mask |= M_BKE_HEALTH_CFG_AREQPRIO_MASK;
> +
> +	/* LIMITCMDS is not present on M_BKE_HEALTH_3 */
> +	if (regnum != 3) {
> +		val |= qos->limit_commands << M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT;
> +		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
> +	}
> +
> +	return regmap_update_bits(rmap,
> +				  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
> +				  mask, val);
> +}
> +
> +static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
> +				 bool bypass_mode)
> +{
> +	struct qcom_icc_provider *qp;
> +	struct qcom_icc_node *qn;
> +	struct icc_provider *provider;
> +	u32 mode = NOC_QOS_MODE_BYPASS;
> +	u32 val = 0;
> +	int i, rc = 0;
> +
> +	qn = src->data;
> +	provider = src->provider;
> +	qp = to_qcom_provider(provider);
> +
> +	if (qn->qos.qos_mode != -1)
> +		mode = qn->qos.qos_mode;
> +
> +	/* QoS Priority: The QoS Health parameters are getting considered
> +	 * only if we are NOT in Bypass Mode.
> +	 */
> +	if (mode != NOC_QOS_MODE_BYPASS) {
> +		for (i = 3; i >= 0; i--) {
> +			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
> +							  &qn->qos, i);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		/* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode */
> +		val = 1;
> +	}
> +
> +	return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_port),
> +				  M_BKE_EN_EN_BMASK, val);
> +}
> +
> +static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
> +					 struct qcom_icc_qos *qos)
> +{
> +	u32 val;
> +	int rc;
> +
> +	/* Must be updated one at a time, P1 first, P0 last */
> +	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
> +	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> +				NOC_QOS_PRIORITY_MASK, val);
> +	if (rc)
> +		return rc;
> +
> +	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
> +	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> +				  NOC_QOS_PRIORITY_MASK, val);
> +}
> +
> +static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
> +{
> +	struct qcom_icc_provider *qp;
> +	struct qcom_icc_node *qn;
> +	struct icc_provider *provider;
> +	u32 mode = NOC_QOS_MODE_BYPASS;
> +	int rc = 0;
> +
> +	qn = src->data;
> +	provider = src->provider;
> +	qp = to_qcom_provider(provider);
> +
> +	if (qn->qos.qos_port < 0) {
> +		dev_dbg(src->provider->dev,
> +			"NoC QoS: Skipping %s: vote aggregated on parent.\n",
> +			qn->name);
> +		return 0;
> +	}
> +
> +	if (qn->qos.qos_mode != -1)
> +		mode = qn->qos.qos_mode;
> +
> +	if (mode == NOC_QOS_MODE_FIXED) {
> +		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
> +			qn->name);
> +		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
> +		if (rc)
> +			return rc;
> +	} else if (mode == NOC_QOS_MODE_BYPASS) {
> +		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n",
> +			qn->name);
> +	}
> +
> +	return regmap_update_bits(qp->regmap,
> +				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
> +				  NOC_QOS_MODEn_MASK, mode);
> +}
> +
> +static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
> +{
> +	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
> +	struct qcom_icc_node *qn = node->data;
> +
> +	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
> +
> +	if (qp->is_bimc_node)
> +		return qcom_icc_set_bimc_qos(node, sum_bw,
> +				(qn->qos.qos_mode == NOC_QOS_MODE_BYPASS));
> +
> +	return qcom_icc_set_noc_qos(node, sum_bw);
> +}
> +
> +static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
> +{
> +	int ret = 0;
> +
> +	if (mas_rpm_id != -1) {
> +		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> +					    RPM_BUS_MASTER_REQ,
> +					    mas_rpm_id,
> +					    sum_bw);
> +		if (ret) {
> +			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> +			       mas_rpm_id, ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (slv_rpm_id != -1) {
> +		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> +					    RPM_BUS_SLAVE_REQ,
> +					    slv_rpm_id,
> +					    sum_bw);
> +		if (ret) {
> +			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
> +			       slv_rpm_id, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +int qcom_icc_rpm_qos_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct qcom_icc_provider *qp;
> +	struct qcom_icc_node *qn;
> +	struct icc_provider *provider;
> +	struct icc_node *n;
> +	u64 sum_bw;
> +	u64 max_peak_bw;
> +	u64 rate;
> +	u32 agg_avg = 0;
> +	u32 agg_peak = 0;
> +	int ret, i;
> +
> +	qn = src->data;
> +	provider = src->provider;
> +	qp = to_qcom_provider(provider);
> +
> +	list_for_each_entry(n, &provider->nodes, node_list)
> +		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> +				    &agg_avg, &agg_peak);
> +
> +	sum_bw = icc_units_to_bps(agg_avg);
> +	max_peak_bw = icc_units_to_bps(agg_peak);
> +
> +	if (!qn->qos.ap_owned) {
> +		/* send bandwidth request message to the RPM processor */
> +		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
> +		if (ret)
> +			return ret;
> +	} else if (qn->qos.qos_mode != -1) {
> +		/* set bandwidth directly from the AP */
> +		ret = qcom_icc_qos_set(src, sum_bw);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	rate = max(sum_bw, max_peak_bw);
> +
> +	do_div(rate, qn->buswidth);
> +
> +	if (qn->rate == rate)
> +		return 0;
> +
> +	for (i = 0; i < qp->num_clks; i++) {
> +		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
> +		if (ret) {
> +			pr_err("%s clk_set_rate error: %d\n",
> +			       qp->bus_clks[i].id, ret);
> +			return ret;
> +		}
> +	}
> +
> +	qn->rate = rate;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_qos_set);
> diff --git a/drivers/interconnect/qcom/icc-rpm-qos.h b/drivers/interconnect/qcom/icc-rpm-qos.h
> new file mode 100644
> index 000000000000..625ac5f84ebc
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-rpm-qos.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_QOS_H__
> +#define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_QOS_H__
> +
> +#define RPM_BUS_MASTER_REQ	0x73616d62
> +#define RPM_BUS_SLAVE_REQ	0x766c7362
> +
> +/* BIMC QoS */
> +#define M_BKE_REG_BASE(n)		(0x300 + (0x4000 * n))
> +#define M_BKE_EN_ADDR(n)		(M_BKE_REG_BASE(n))
> +#define M_BKE_HEALTH_CFG_ADDR(i, n)	(M_BKE_REG_BASE(n) + 0x40 + (0x4 * i))
> +
> +#define M_BKE_HEALTH_CFG_LIMITCMDS_MASK	0x80000000
> +#define M_BKE_HEALTH_CFG_AREQPRIO_MASK	0x300
> +#define M_BKE_HEALTH_CFG_PRIOLVL_MASK	0x3
> +#define M_BKE_HEALTH_CFG_AREQPRIO_SHIFT	0x8
> +#define M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT 0x1f
> +
> +#define M_BKE_EN_EN_BMASK		0x1
> +
> +/* Valid for both NoC and BIMC */
> +#define NOC_QOS_MODE_FIXED		0x0
> +#define NOC_QOS_MODE_LIMITER		0x1
> +#define NOC_QOS_MODE_BYPASS		0x2
> +
> +/* NoC QoS */
> +#define NOC_PERM_MODE_FIXED		1
> +#define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
> +
> +#define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
> +#define NOC_QOS_PRIORITY_MASK		0xf
> +#define NOC_QOS_PRIORITY_P1_SHIFT	0x2
> +#define NOC_QOS_PRIORITY_P0_SHIFT	0x3
> +
> +#define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
> +#define NOC_QOS_MODEn_MASK		0x3
> +
> +#define to_qcom_provider(_provider) \
> +	container_of(_provider, struct qcom_icc_provider, provider)
> +
> +/**
> + * struct qcom_icc_provider - Qualcomm specific interconnect provider
> + * @provider: generic interconnect provider
> + * @bus_clks: the clk_bulk_data table of bus clocks
> + * @num_clks: the total number of clk_bulk_data entries
> + * @is_bimc_node: indicates whether to use bimc specific setting
> + * @regmap: regmap for QoS registers read/write access
> + * @mmio: NoC base iospace
> + */
> +struct qcom_icc_provider {
> +	struct icc_provider provider;
> +	struct clk_bulk_data *bus_clks;
> +	int num_clks;
> +	bool is_bimc_node;
> +	struct regmap *regmap;
> +	void __iomem *mmio;
> +};
> +
> +/**
> + * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
> + * @areq_prio: node requests priority
> + * @prio_level: priority level for bus communication
> + * @limit_commands: activate/deactivate limiter mode during runtime
> + * @ap_owned: indicates if the node is owned by the AP or by the RPM
> + * @qos_mode: default qos mode for this node
> + * @qos_port: qos port number for finding qos registers of this node
> + */
> +struct qcom_icc_qos {
> +	u32 areq_prio;
> +	u32 prio_level;
> +	bool limit_commands;
> +	bool ap_owned;
> +	int qos_mode;
> +	int qos_port;
> +};
> +
> +/**
> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @id: a unique node identifier
> + * @links: an array of nodes where we can go next while traversing
> + * @num_links: the total number of @links
> + * @buswidth: width of the interconnect between a node and the bus (bytes)
> + * @mas_rpm_id: RPM id for devices that are bus masters
> + * @slv_rpm_id: RPM id for devices that are bus slaves
> + * @qos: NoC QoS setting parameters
> + * @rate: current bus clock rate in Hz
> + */
> +
> +#define MAX_LINKS	38
> +
> +struct qcom_icc_node {
> +	unsigned char *name;
> +	u16 id;
> +	u16 links[MAX_LINKS];
> +	u16 num_links;
> +	u16 buswidth;
> +	int mas_rpm_id;
> +	int slv_rpm_id;
> +	struct qcom_icc_qos qos;
> +	u64 rate;
> +};
> +
> +struct qcom_icc_desc {
> +	struct qcom_icc_node **nodes;
> +	size_t num_nodes;
> +	const struct regmap_config *regmap_cfg;
> +};
> +
> +#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
> +		     _ap_owned, _qos_mode, _qos_prio, _qos_port, ...)	\
> +		static struct qcom_icc_node _name = {			\
> +		.name = #_name,						\
> +		.id = _id,						\
> +		.buswidth = _buswidth,					\
> +		.mas_rpm_id = _mas_rpm_id,				\
> +		.slv_rpm_id = _slv_rpm_id,				\
> +		.qos.ap_owned = _ap_owned,				\
> +		.qos.qos_mode = _qos_mode,				\
> +		.qos.areq_prio = _qos_prio,				\
> +		.qos.prio_level = _qos_prio,				\
> +		.qos.qos_port = _qos_port,				\
> +		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
> +		.links = { __VA_ARGS__ },				\
> +	}
> +
> +int qcom_icc_rpm_qos_set(struct icc_node *src, struct icc_node *dst);
> +
> +#endif
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index bf01d09dba6c..6f93273109a3 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -70,13 +70,13 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
>   
>   /**
> - * qcom_icc_set - set the constraints based on path
> + * qcom_icc_rpmh_set - set the constraints based on path
>    * @src: source node for the path to set constraints on
>    * @dst: destination node for the path to set constraints on
>    *
>    * Return: 0 on success, or an error code otherwise
>    */
> -int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> +int qcom_icc_rpmh_set(struct icc_node *src, struct icc_node *dst)

This change should be splitted to a different commit, as it is not part of any
commonization of the RPM QoS functions. This is a "global" rename, so you should
create a preparation commit for this change.

>   {
>   	struct qcom_icc_provider *qp;
>   	struct qcom_icc_node *qn;
> @@ -99,7 +99,7 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(qcom_icc_set);
> +EXPORT_SYMBOL_GPL(qcom_icc_rpmh_set);
>   
>   struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
>   {
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index e5f61ab989e7..5dc1049dc065 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -130,7 +130,7 @@ struct qcom_icc_desc {
>   
>   int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
> -int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
> +int qcom_icc_rpmh_set(struct icc_node *src, struct icc_node *dst);

Same for this.

>   struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
>   int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
>   void qcom_icc_pre_aggregate(struct icc_node *node);
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
> index 8d9044ed18ab..40232b41c080 100644
> --- a/drivers/interconnect/qcom/sc7180.c
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -532,7 +532,7 @@ static int qnoc_probe(struct platform_device *pdev)
>   
>   	provider = &qp->provider;
>   	provider->dev = &pdev->dev;
> -	provider->set = qcom_icc_set;
> +	provider->set = qcom_icc_rpmh_set;

And for this ... etc :))

>   	provider->pre_aggregate = qcom_icc_pre_aggregate;
>   	provider->aggregate = qcom_icc_aggregate;
>   	provider->xlate_extended = qcom_icc_xlate_extended;
> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
> index 8d1b55c3705c..b84742debc13 100644
> --- a/drivers/interconnect/qcom/sc7280.c
> +++ b/drivers/interconnect/qcom/sc7280.c
> @@ -1830,7 +1830,7 @@ static int qnoc_probe(struct platform_device *pdev)
>   
>   	provider = &qp->provider;
>   	provider->dev = &pdev->dev;
> -	provider->set = qcom_icc_set;
> +	provider->set = qcom_icc_rpmh_set;
>   	provider->pre_aggregate = qcom_icc_pre_aggregate;
>   	provider->aggregate = qcom_icc_aggregate;
>   	provider->xlate_extended = qcom_icc_xlate_extended;
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index 632dbdd21915..acd026ecd17f 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -4,7 +4,6 @@
>    * Copyright (C) 2020, AngeloGioacchino Del Regno <kholk11@gmail.com>
>    */
>   
> -#include <dt-bindings/interconnect/qcom,sdm660.h>

Why did you move this header down?
If you have a reason, this is also not part of the RPM-QoS commonization.

Thanks!
- Angelo
