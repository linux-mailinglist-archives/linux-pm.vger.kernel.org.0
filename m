Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA786420A6B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 13:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJDL41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 07:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJDL40 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Oct 2021 07:56:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A83476139F;
        Mon,  4 Oct 2021 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633348477;
        bh=QSadxtOKAC+4NsP858i15gHiZmLZ/HKdHVt8QjLX9m4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NHAXAaqXhpBSTQhHTW48oCFwtFEl75cqbqmwNAEXLM/eQBlEhFlKvCnTbQsI6u8pf
         KXDjJCCt1e9gaGmP3R2NjaAtie/6+zIgBh7ZH668MuL1KQduHZ8C2Ix8aKPWfc7HXy
         mylpa1cxcbwKJtGLKWc3rLlPYh/fer8BuoI+M3aIN+FP7OjSUo2YBsszmJzV6wGcMl
         mpLPqiQRGm82CiBsWO40DQK37r890HIf/Tz9RL2RewwSw9NUW5+YyZMKnomHa9Ct16
         gg+H9xKYFZZV7erFp83PufeN1sz0z5S+naNgsS4ArnBRLPF8cDzWXcpN91wnQaMXXM
         pHNNrTZg4Tu2w==
Message-ID: <2eb2a06c-4edc-517c-f860-40079b12dd01@kernel.org>
Date:   Mon, 4 Oct 2021 14:54:33 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 04/11] interconnect: sdm660: merge common code into
 icc-rpm
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-5-dmitry.baryshkov@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20210903232421.1384199-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Dmitry,

On 4.09.21 2:24, Dmitry Baryshkov wrote:
> Other RPM interconnect drivers might also use QoS support. Move AP-owned
> nodes support from SDM660 driver to common icc-rpm.c.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 241 ++++++++++++--
>   drivers/interconnect/qcom/icc-rpm.h |  42 ++-
>   drivers/interconnect/qcom/sdm660.c  | 485 ++--------------------------
>   3 files changed, 274 insertions(+), 494 deletions(-)
> 
[..]>   /**
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

To match with what you have in patch [1/11], this should be
	const char * const *clocks;

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

Should be:
	static const char * const bus_mm_clocks[] = {

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
[..]
> -
> -struct qcom_icc_desc {
> -	struct qcom_icc_node **nodes;
> -	size_t num_nodes;
> -	const struct regmap_config *regmap_cfg;
> +static const char * bus_a2noc_clocks[] = {

Again:
	static const char * const bus_a2noc_clocks[] = {

> +	"bus",
> +	"bus_a",
> +	"ipa",
> +	"ufs_axi",
> +	"aggre2_ufs_axi",
> +	"aggre2_usb3_axi",
> +	"cfg_noc_usb2_axi",
>   };
>   

The rest looks good to me!

Thanks,
Georgi
