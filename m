Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B941400B09
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351268AbhIDLAb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 07:00:31 -0400
Received: from m-r1.th.seeweb.it ([5.144.164.170]:39963 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351237AbhIDLAa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 07:00:30 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A02FA1F423;
        Sat,  4 Sep 2021 12:59:27 +0200 (CEST)
Subject: Re: [PATCH v2 04/11] interconnect: sdm660: merge common code into
 icc-rpm
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-5-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <32a1b32d-ec5b-1dfa-b451-2d2e31502b17@somainline.org>
Date:   Sat, 4 Sep 2021 12:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210903232421.1384199-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 04/09/21 01:24, Dmitry Baryshkov ha scritto:
> Other RPM interconnect drivers might also use QoS support. Move AP-owned
> nodes support from SDM660 driver to common icc-rpm.c.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested on Sony Xperia XA2 (sdm630-pioneer)



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

> ---
>   drivers/interconnect/qcom/icc-rpm.c | 241 ++++++++++++--
>   drivers/interconnect/qcom/icc-rpm.h |  42 ++-
>   drivers/interconnect/qcom/sdm660.c  | 485 ++--------------------------
>   3 files changed, 274 insertions(+), 494 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 394f515cc88d..b8bac738c64f 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -11,60 +11,228 @@
>   #include <linux/of_device.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   #include "smd-rpm.h"
>   #include "icc-rpm.h"
>   
> -static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
> +/* NoC QoS */
> +#define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
> +#define NOC_QOS_PRIORITY_P1_MASK	0xc
> +#define NOC_QOS_PRIORITY_P0_MASK	0x3
> +#define NOC_QOS_PRIORITY_P1_SHIFT	0x2
> +
> +#define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
> +#define NOC_QOS_MODEn_MASK		0x3
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
> +static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
>   {
>   	struct qcom_icc_provider *qp;
>   	struct qcom_icc_node *qn;
>   	struct icc_provider *provider;
> -	struct icc_node *n;
> -	u64 sum_bw;
> -	u64 max_peak_bw;
> -	u64 rate;
> -	u32 agg_avg = 0;
> -	u32 agg_peak = 0;
> -	int ret, i;
> +	u32 mode = NOC_QOS_MODE_BYPASS;
> +	u32 val = 0;
> +	int i, rc = 0;
>   
>   	qn = src->data;
>   	provider = src->provider;
>   	qp = to_qcom_provider(provider);
>   
> -	list_for_each_entry(n, &provider->nodes, node_list)
> -		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> -				    &agg_avg, &agg_peak);
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
>   
> -	sum_bw = icc_units_to_bps(agg_avg);
> -	max_peak_bw = icc_units_to_bps(agg_peak);
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
> +				NOC_QOS_PRIORITY_P1_MASK, val);
> +	if (rc)
> +		return rc;
> +
> +	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> +				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
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
>   
> -	/* send bandwidth request message to the RPM processor */
> -	if (qn->mas_rpm_id != -1) {
> +static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
> +{
> +	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
> +	struct qcom_icc_node *qn = node->data;
> +
> +	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
> +
> +	if (qp->is_bimc_node)
> +		return qcom_icc_set_bimc_qos(node, sum_bw);
> +
> +	return qcom_icc_set_noc_qos(node, sum_bw);
> +}
> +
> +static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
> +{
> +	int ret = 0;
> +
> +	if (mas_rpm_id != -1) {
>   		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>   					    RPM_BUS_MASTER_REQ,
> -					    qn->mas_rpm_id,
> +					    mas_rpm_id,
>   					    sum_bw);
>   		if (ret) {
>   			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> -			       qn->mas_rpm_id, ret);
> +			       mas_rpm_id, ret);
>   			return ret;
>   		}
>   	}
>   
> -	if (qn->slv_rpm_id != -1) {
> +	if (slv_rpm_id != -1) {
>   		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>   					    RPM_BUS_SLAVE_REQ,
> -					    qn->slv_rpm_id,
> +					    slv_rpm_id,
>   					    sum_bw);
>   		if (ret) {
>   			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
> -			       qn->slv_rpm_id, ret);
> +			       slv_rpm_id, ret);
>   			return ret;
>   		}
>   	}
>   
> +	return ret;
> +}
> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
>   	rate = max(sum_bw, max_peak_bw);
>   
>   	do_div(rate, qn->buswidth);
> @@ -115,8 +283,13 @@ int qnoc_probe(struct platform_device *pdev)
>   	qnodes = desc->nodes;
>   	num_nodes = desc->num_nodes;
>   
> -	cds = bus_clocks;
> -	cd_num = ARRAY_SIZE(bus_clocks);
> +	if (desc->num_clocks) {
> +		cds = desc->clocks;
> +		cd_num = desc->num_clocks;
> +	} else {
> +		cds = bus_clocks;
> +		cd_num = ARRAY_SIZE(bus_clocks);
> +	}
>   
>   	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
>   	if (!qp)
> @@ -131,6 +304,30 @@ int qnoc_probe(struct platform_device *pdev)
>   		qp->bus_clks[i].id = cds[i];
>   	qp->num_clks = cd_num;
>   
> +	qp->is_bimc_node = desc->is_bimc_node;
> +
> +	if (desc->regmap_cfg) {
> +		struct resource *res;
> +		void __iomem *mmio;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res)
> +			return -ENODEV;
> +
> +		mmio = devm_ioremap_resource(dev, res);
> +
> +		if (IS_ERR(mmio)) {
> +			dev_err(dev, "Cannot ioremap interconnect bus resource\n");
> +			return PTR_ERR(mmio);
> +		}
> +
> +		qp->regmap = devm_regmap_init_mmio(dev, mmio, desc->regmap_cfg);
> +		if (IS_ERR(qp->regmap)) {
> +			dev_err(dev, "Cannot regmap interconnect bus resource\n");
> +			return PTR_ERR(qp->regmap);
> +		}
> +	}
> +
>   	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index f4b05c20c097..868585c80f38 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -9,8 +9,6 @@
>   #define RPM_BUS_MASTER_REQ	0x73616d62
>   #define RPM_BUS_SLAVE_REQ	0x766c7362
>   
> -#define QCOM_MAX_LINKS 12
> -
>   #define to_qcom_provider(_provider) \
>   	container_of(_provider, struct qcom_icc_provider, provider)
>   
> @@ -19,13 +17,35 @@
>    * @provider: generic interconnect provider
>    * @bus_clks: the clk_bulk_data table of bus clocks
>    * @num_clks: the total number of clk_bulk_data entries
> + * @is_bimc_node: indicates whether to use bimc specific setting
> + * @regmap: regmap for QoS registers read/write access
>    */
>   struct qcom_icc_provider {
>   	struct icc_provider provider;
>   	int num_clks;
> +	bool is_bimc_node;
> +	struct regmap *regmap;
>   	struct clk_bulk_data bus_clks[];
>   };
>   
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
>   /**
>    * struct qcom_icc_node - Qualcomm specific interconnect nodes
>    * @name: the node name used in debugfs
> @@ -35,36 +55,48 @@ struct qcom_icc_provider {
>    * @buswidth: width of the interconnect between a node and the bus (bytes)
>    * @mas_rpm_id:	RPM id for devices that are bus masters
>    * @slv_rpm_id:	RPM id for devices that are bus slaves
> + * @qos: NoC QoS setting parameters
>    * @rate: current bus clock rate in Hz
>    */
>   struct qcom_icc_node {
>   	unsigned char *name;
>   	u16 id;
> -	u16 links[QCOM_MAX_LINKS];
> +	const u16 *links;
>   	u16 num_links;
>   	u16 buswidth;
>   	int mas_rpm_id;
>   	int slv_rpm_id;
> +	struct qcom_icc_qos qos;
>   	u64 rate;
>   };
>   
>   struct qcom_icc_desc {
>   	struct qcom_icc_node **nodes;
>   	size_t num_nodes;
> +	const char ** clocks;
> +	size_t num_clocks;
> +	bool is_bimc_node;
> +	const struct regmap_config *regmap_cfg;
>   };
>   
>   #define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
>   		     ...)						\
> +		static const u16 _name ## _links[] = { __VA_ARGS__ };	\
> +		\
>   		static struct qcom_icc_node _name = {			\
>   		.name = #_name,						\
>   		.id = _id,						\
>   		.buswidth = _buswidth,					\
>   		.mas_rpm_id = _mas_rpm_id,				\
>   		.slv_rpm_id = _slv_rpm_id,				\
> -		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
> -		.links = { __VA_ARGS__ },				\
> +		.num_links = ARRAY_SIZE(_name ## _links),		\
> +		.links = _name ## _links,				\
>   	}
>   
> +/* Valid for both NoC and BIMC */
> +#define NOC_QOS_MODE_INVALID		-1
> +#define NOC_QOS_MODE_FIXED		0x0
> +#define NOC_QOS_MODE_BYPASS		0x2
>   
>   int qnoc_probe(struct platform_device *pdev);
>   int qnoc_remove(struct platform_device *pdev);
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index 4a72f9677d4e..384dd3661757 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -16,42 +16,9 @@
>   #include <linux/regmap.h>
>   #include <linux/slab.h>
>   
> +#include "icc-rpm.h"
>   #include "smd-rpm.h"
>   
> -#define RPM_BUS_MASTER_REQ	0x73616d62
> -#define RPM_BUS_SLAVE_REQ	0x766c7362
> -
> -/* BIMC QoS */
> -#define M_BKE_REG_BASE(n)		(0x300 + (0x4000 * n))
> -#define M_BKE_EN_ADDR(n)		(M_BKE_REG_BASE(n))
> -#define M_BKE_HEALTH_CFG_ADDR(i, n)	(M_BKE_REG_BASE(n) + 0x40 + (0x4 * i))
> -
> -#define M_BKE_HEALTH_CFG_LIMITCMDS_MASK	0x80000000
> -#define M_BKE_HEALTH_CFG_AREQPRIO_MASK	0x300
> -#define M_BKE_HEALTH_CFG_PRIOLVL_MASK	0x3
> -#define M_BKE_HEALTH_CFG_AREQPRIO_SHIFT	0x8
> -#define M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT 0x1f
> -
> -#define M_BKE_EN_EN_BMASK		0x1
> -
> -/* Valid for both NoC and BIMC */
> -#define NOC_QOS_MODE_INVALID		-1
> -#define NOC_QOS_MODE_FIXED		0x0
> -#define NOC_QOS_MODE_LIMITER		0x1
> -#define NOC_QOS_MODE_BYPASS		0x2
> -
> -/* NoC QoS */
> -#define NOC_PERM_MODE_FIXED		1
> -#define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
> -
> -#define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
> -#define NOC_QOS_PRIORITY_P1_MASK	0xc
> -#define NOC_QOS_PRIORITY_P0_MASK	0x3
> -#define NOC_QOS_PRIORITY_P1_SHIFT	0x2
> -
> -#define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
> -#define NOC_QOS_MODEn_MASK		0x3
> -
>   enum {
>   	SDM660_MASTER_IPA = 1,
>   	SDM660_MASTER_CNOC_A2NOC,
> @@ -160,94 +127,20 @@ enum {
>   	SDM660_SNOC,
>   };
>   
> -#define to_qcom_provider(_provider) \
> -	container_of(_provider, struct qcom_icc_provider, provider)
> -
> -static const struct clk_bulk_data bus_clocks[] = {
> -	{ .id = "bus" },
> -	{ .id = "bus_a" },
> +static const char * bus_mm_clocks[] = {
> +	"bus",
> +	"bus_a",
> +	"iface",
>   };
>   
> -static const struct clk_bulk_data bus_mm_clocks[] = {
> -	{ .id = "bus" },
> -	{ .id = "bus_a" },
> -	{ .id = "iface" },
> -};
> -
> -static const struct clk_bulk_data bus_a2noc_clocks[] = {
> -	{ .id = "bus" },
> -	{ .id = "bus_a" },
> -	{ .id = "ipa" },
> -	{ .id = "ufs_axi" },
> -	{ .id = "aggre2_ufs_axi" },
> -	{ .id = "aggre2_usb3_axi" },
> -	{ .id = "cfg_noc_usb2_axi" },
> -};
> -
> -/**
> - * struct qcom_icc_provider - Qualcomm specific interconnect provider
> - * @provider: generic interconnect provider
> - * @bus_clks: the clk_bulk_data table of bus clocks
> - * @num_clks: the total number of clk_bulk_data entries
> - * @is_bimc_node: indicates whether to use bimc specific setting
> - * @regmap: regmap for QoS registers read/write access
> - * @mmio: NoC base iospace
> - */
> -struct qcom_icc_provider {
> -	struct icc_provider provider;
> -	struct clk_bulk_data *bus_clks;
> -	int num_clks;
> -	bool is_bimc_node;
> -	struct regmap *regmap;
> -	void __iomem *mmio;
> -};
> -
> -/**
> - * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
> - * @areq_prio: node requests priority
> - * @prio_level: priority level for bus communication
> - * @limit_commands: activate/deactivate limiter mode during runtime
> - * @ap_owned: indicates if the node is owned by the AP or by the RPM
> - * @qos_mode: default qos mode for this node
> - * @qos_port: qos port number for finding qos registers of this node
> - */
> -struct qcom_icc_qos {
> -	u32 areq_prio;
> -	u32 prio_level;
> -	bool limit_commands;
> -	bool ap_owned;
> -	int qos_mode;
> -	int qos_port;
> -};
> -
> -/**
> - * struct qcom_icc_node - Qualcomm specific interconnect nodes
> - * @name: the node name used in debugfs
> - * @id: a unique node identifier
> - * @links: an array of nodes where we can go next while traversing
> - * @num_links: the total number of @links
> - * @buswidth: width of the interconnect between a node and the bus (bytes)
> - * @mas_rpm_id: RPM id for devices that are bus masters
> - * @slv_rpm_id: RPM id for devices that are bus slaves
> - * @qos: NoC QoS setting parameters
> - * @rate: current bus clock rate in Hz
> - */
> -struct qcom_icc_node {
> -	unsigned char *name;
> -	u16 id;
> -	const u16 *links;
> -	u16 num_links;
> -	u16 buswidth;
> -	int mas_rpm_id;
> -	int slv_rpm_id;
> -	struct qcom_icc_qos qos;
> -	u64 rate;
> -};
> -
> -struct qcom_icc_desc {
> -	struct qcom_icc_node **nodes;
> -	size_t num_nodes;
> -	const struct regmap_config *regmap_cfg;
> +static const char * bus_a2noc_clocks[] = {
> +	"bus",
> +	"bus_a",
> +	"ipa",
> +	"ufs_axi",
> +	"aggre2_ufs_axi",
> +	"aggre2_usb3_axi",
> +	"cfg_noc_usb2_axi",
>   };
>   
>   static const u16 mas_ipa_links[] = {
> @@ -1622,6 +1515,8 @@ static const struct regmap_config sdm660_a2noc_regmap_config = {
>   static struct qcom_icc_desc sdm660_a2noc = {
>   	.nodes = sdm660_a2noc_nodes,
>   	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
> +	.clocks = bus_a2noc_clocks,
> +	.num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
>   	.regmap_cfg = &sdm660_a2noc_regmap_config,
>   };
>   
> @@ -1647,6 +1542,7 @@ static const struct regmap_config sdm660_bimc_regmap_config = {
>   static struct qcom_icc_desc sdm660_bimc = {
>   	.nodes = sdm660_bimc_nodes,
>   	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
> +	.is_bimc_node = true,
>   	.regmap_cfg = &sdm660_bimc_regmap_config,
>   };
>   
> @@ -1759,6 +1655,8 @@ static const struct regmap_config sdm660_mnoc_regmap_config = {
>   static struct qcom_icc_desc sdm660_mnoc = {
>   	.nodes = sdm660_mnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
> +	.clocks = bus_mm_clocks,
> +	.num_clocks = ARRAY_SIZE(bus_mm_clocks),
>   	.regmap_cfg = &sdm660_mnoc_regmap_config,
>   };
>   
> @@ -1796,353 +1694,6 @@ static struct qcom_icc_desc sdm660_snoc = {
>   	.regmap_cfg = &sdm660_snoc_regmap_config,
>   };
>   
> -static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
> -					struct qcom_icc_qos *qos,
> -					int regnum)
> -{
> -	u32 val;
> -	u32 mask;
> -
> -	val = qos->prio_level;
> -	mask = M_BKE_HEALTH_CFG_PRIOLVL_MASK;
> -
> -	val |= qos->areq_prio << M_BKE_HEALTH_CFG_AREQPRIO_SHIFT;
> -	mask |= M_BKE_HEALTH_CFG_AREQPRIO_MASK;
> -
> -	/* LIMITCMDS is not present on M_BKE_HEALTH_3 */
> -	if (regnum != 3) {
> -		val |= qos->limit_commands << M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT;
> -		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
> -	}
> -
> -	return regmap_update_bits(rmap,
> -				  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
> -				  mask, val);
> -}
> -
> -static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
> -				 bool bypass_mode)
> -{
> -	struct qcom_icc_provider *qp;
> -	struct qcom_icc_node *qn;
> -	struct icc_provider *provider;
> -	u32 mode = NOC_QOS_MODE_BYPASS;
> -	u32 val = 0;
> -	int i, rc = 0;
> -
> -	qn = src->data;
> -	provider = src->provider;
> -	qp = to_qcom_provider(provider);
> -
> -	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
> -		mode = qn->qos.qos_mode;
> -
> -	/* QoS Priority: The QoS Health parameters are getting considered
> -	 * only if we are NOT in Bypass Mode.
> -	 */
> -	if (mode != NOC_QOS_MODE_BYPASS) {
> -		for (i = 3; i >= 0; i--) {
> -			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
> -							  &qn->qos, i);
> -			if (rc)
> -				return rc;
> -		}
> -
> -		/* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode */
> -		val = 1;
> -	}
> -
> -	return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_port),
> -				  M_BKE_EN_EN_BMASK, val);
> -}
> -
> -static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
> -					 struct qcom_icc_qos *qos)
> -{
> -	u32 val;
> -	int rc;
> -
> -	/* Must be updated one at a time, P1 first, P0 last */
> -	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
> -	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> -				NOC_QOS_PRIORITY_P1_MASK, val);
> -	if (rc)
> -		return rc;
> -
> -	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> -				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
> -}
> -
> -static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
> -{
> -	struct qcom_icc_provider *qp;
> -	struct qcom_icc_node *qn;
> -	struct icc_provider *provider;
> -	u32 mode = NOC_QOS_MODE_BYPASS;
> -	int rc = 0;
> -
> -	qn = src->data;
> -	provider = src->provider;
> -	qp = to_qcom_provider(provider);
> -
> -	if (qn->qos.qos_port < 0) {
> -		dev_dbg(src->provider->dev,
> -			"NoC QoS: Skipping %s: vote aggregated on parent.\n",
> -			qn->name);
> -		return 0;
> -	}
> -
> -	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
> -		mode = qn->qos.qos_mode;
> -
> -	if (mode == NOC_QOS_MODE_FIXED) {
> -		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
> -			qn->name);
> -		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
> -		if (rc)
> -			return rc;
> -	} else if (mode == NOC_QOS_MODE_BYPASS) {
> -		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n",
> -			qn->name);
> -	}
> -
> -	return regmap_update_bits(qp->regmap,
> -				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
> -				  NOC_QOS_MODEn_MASK, mode);
> -}
> -
> -static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
> -{
> -	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
> -	struct qcom_icc_node *qn = node->data;
> -
> -	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
> -
> -	if (qp->is_bimc_node)
> -		return qcom_icc_set_bimc_qos(node, sum_bw,
> -				(qn->qos.qos_mode == NOC_QOS_MODE_BYPASS));
> -
> -	return qcom_icc_set_noc_qos(node, sum_bw);
> -}
> -
> -static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
> -{
> -	int ret = 0;
> -
> -	if (mas_rpm_id != -1) {
> -		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> -					    RPM_BUS_MASTER_REQ,
> -					    mas_rpm_id,
> -					    sum_bw);
> -		if (ret) {
> -			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
> -			       mas_rpm_id, ret);
> -			return ret;
> -		}
> -	}
> -
> -	if (slv_rpm_id != -1) {
> -		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
> -					    RPM_BUS_SLAVE_REQ,
> -					    slv_rpm_id,
> -					    sum_bw);
> -		if (ret) {
> -			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
> -			       slv_rpm_id, ret);
> -			return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> -{
> -	struct qcom_icc_provider *qp;
> -	struct qcom_icc_node *qn;
> -	struct icc_provider *provider;
> -	struct icc_node *n;
> -	u64 sum_bw;
> -	u64 max_peak_bw;
> -	u64 rate;
> -	u32 agg_avg = 0;
> -	u32 agg_peak = 0;
> -	int ret, i;
> -
> -	qn = src->data;
> -	provider = src->provider;
> -	qp = to_qcom_provider(provider);
> -
> -	list_for_each_entry(n, &provider->nodes, node_list)
> -		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> -				    &agg_avg, &agg_peak);
> -
> -	sum_bw = icc_units_to_bps(agg_avg);
> -	max_peak_bw = icc_units_to_bps(agg_peak);
> -
> -	if (!qn->qos.ap_owned) {
> -		/* send bandwidth request message to the RPM processor */
> -		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
> -		if (ret)
> -			return ret;
> -	} else if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
> -		/* set bandwidth directly from the AP */
> -		ret = qcom_icc_qos_set(src, sum_bw);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	rate = max(sum_bw, max_peak_bw);
> -
> -	do_div(rate, qn->buswidth);
> -
> -	if (qn->rate == rate)
> -		return 0;
> -
> -	for (i = 0; i < qp->num_clks; i++) {
> -		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
> -		if (ret) {
> -			pr_err("%s clk_set_rate error: %d\n",
> -			       qp->bus_clks[i].id, ret);
> -			return ret;
> -		}
> -	}
> -
> -	qn->rate = rate;
> -
> -	return 0;
> -}
> -
> -static int qnoc_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	const struct qcom_icc_desc *desc;
> -	struct icc_onecell_data *data;
> -	struct icc_provider *provider;
> -	struct qcom_icc_node **qnodes;
> -	struct qcom_icc_provider *qp;
> -	struct icc_node *node;
> -	struct resource *res;
> -	size_t num_nodes, i;
> -	int ret;
> -
> -	/* wait for the RPM proxy */
> -	if (!qcom_icc_rpm_smd_available())
> -		return -EPROBE_DEFER;
> -
> -	desc = of_device_get_match_data(dev);
> -	if (!desc)
> -		return -EINVAL;
> -
> -	qnodes = desc->nodes;
> -	num_nodes = desc->num_nodes;
> -
> -	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
> -	if (!qp)
> -		return -ENOMEM;
> -
> -	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
> -			    GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	if (of_device_is_compatible(dev->of_node, "qcom,sdm660-mnoc")) {
> -		qp->bus_clks = devm_kmemdup(dev, bus_mm_clocks,
> -					    sizeof(bus_mm_clocks), GFP_KERNEL);
> -		qp->num_clks = ARRAY_SIZE(bus_mm_clocks);
> -	} else if (of_device_is_compatible(dev->of_node, "qcom,sdm660-a2noc")) {
> -		qp->bus_clks = devm_kmemdup(dev, bus_a2noc_clocks,
> -					    sizeof(bus_a2noc_clocks), GFP_KERNEL);
> -		qp->num_clks = ARRAY_SIZE(bus_a2noc_clocks);
> -	} else {
> -		if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bimc"))
> -			qp->is_bimc_node = true;
> -
> -		qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
> -					    GFP_KERNEL);
> -		qp->num_clks = ARRAY_SIZE(bus_clocks);
> -	}
> -	if (!qp->bus_clks)
> -		return -ENOMEM;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
> -	qp->mmio = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(qp->mmio)) {
> -		dev_err(dev, "Cannot ioremap interconnect bus resource\n");
> -		return PTR_ERR(qp->mmio);
> -	}
> -
> -	qp->regmap = devm_regmap_init_mmio(dev, qp->mmio, desc->regmap_cfg);
> -	if (IS_ERR(qp->regmap)) {
> -		dev_err(dev, "Cannot regmap interconnect bus resource\n");
> -		return PTR_ERR(qp->regmap);
> -	}
> -
> -	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
> -	if (ret)
> -		return ret;
> -
> -	provider = &qp->provider;
> -	INIT_LIST_HEAD(&provider->nodes);
> -	provider->dev = dev;
> -	provider->set = qcom_icc_set;
> -	provider->aggregate = icc_std_aggregate;
> -	provider->xlate = of_icc_xlate_onecell;
> -	provider->data = data;
> -
> -	ret = icc_provider_add(provider);
> -	if (ret) {
> -		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> -		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -		return ret;
> -	}
> -
> -	for (i = 0; i < num_nodes; i++) {
> -		size_t j;
> -
> -		node = icc_node_create(qnodes[i]->id);
> -		if (IS_ERR(node)) {
> -			ret = PTR_ERR(node);
> -			goto err;
> -		}
> -
> -		node->name = qnodes[i]->name;
> -		node->data = qnodes[i];
> -		icc_node_add(node, provider);
> -
> -		for (j = 0; j < qnodes[i]->num_links; j++)
> -			icc_link_create(node, qnodes[i]->links[j]);
> -
> -		data->nodes[i] = node;
> -	}
> -	data->num_nodes = num_nodes;
> -	platform_set_drvdata(pdev, qp);
> -
> -	return 0;
> -err:
> -	icc_nodes_remove(provider);
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -	icc_provider_del(provider);
> -
> -	return ret;
> -}
> -
> -static int qnoc_remove(struct platform_device *pdev)
> -{
> -	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> -
> -	icc_nodes_remove(&qp->provider);
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -	return icc_provider_del(&qp->provider);
> -}
> -
>   static const struct of_device_id sdm660_noc_of_match[] = {
>   	{ .compatible = "qcom,sdm660-a2noc", .data = &sdm660_a2noc },
>   	{ .compatible = "qcom,sdm660-bimc", .data = &sdm660_bimc },
> 

