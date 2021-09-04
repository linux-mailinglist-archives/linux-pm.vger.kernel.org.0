Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF8400B0C
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351397AbhIDLAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 07:00:44 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:56631 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351307AbhIDLAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 07:00:43 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id F24931F423;
        Sat,  4 Sep 2021 12:59:40 +0200 (CEST)
Subject: Re: [PATCH v2 05/11] interconnect: icc-rpm: add support for QoS reg
 offset
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-6-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <1ed29d4b-e239-36d0-d98c-6a460fcb4566@somainline.org>
Date:   Sat, 4 Sep 2021 12:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210903232421.1384199-6-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 04/09/21 01:24, Dmitry Baryshkov ha scritto:
> SDM660 driver expects to have QoS registers at the beginning of NoC
> address space (sdm660 platform shifts NoC base address). Add support for
> using QoS register offset, so that other platforms do not have to change
> existing device trees.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested on Sony Xperia XA2 (sdm630-pioneer)



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

> ---
>   drivers/interconnect/qcom/icc-rpm.c | 24 ++++++++++++++----------
>   drivers/interconnect/qcom/icc-rpm.h |  3 +++
>   2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b8bac738c64f..384b571fffec 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -39,7 +39,7 @@
>   #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
>   #define NOC_QOS_MODEn_MASK		0x3
>   
> -static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
> +static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
>   					struct qcom_icc_qos *qos,
>   					int regnum)
>   {
> @@ -58,8 +58,8 @@ static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
>   		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
>   	}
>   
> -	return regmap_update_bits(rmap,
> -				  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
> +	return regmap_update_bits(qp->regmap,
> +				  qp->qos_offset + M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
>   				  mask, val);
>   }
>   
> @@ -84,7 +84,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
>   	 */
>   	if (mode != NOC_QOS_MODE_BYPASS) {
>   		for (i = 3; i >= 0; i--) {
> -			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
> +			rc = qcom_icc_bimc_set_qos_health(qp,
>   							  &qn->qos, i);
>   			if (rc)
>   				return rc;
> @@ -94,11 +94,12 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
>   		val = 1;
>   	}
>   
> -	return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_port),
> +	return regmap_update_bits(qp->regmap,
> +				  qp->qos_offset + M_BKE_EN_ADDR(qn->qos.qos_port),
>   				  M_BKE_EN_EN_BMASK, val);
>   }
>   
> -static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
> +static int qcom_icc_noc_set_qos_priority(struct qcom_icc_provider *qp,
>   					 struct qcom_icc_qos *qos)
>   {
>   	u32 val;
> @@ -106,12 +107,14 @@ static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
>   
>   	/* Must be updated one at a time, P1 first, P0 last */
>   	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
> -	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> +	rc = regmap_update_bits(qp->regmap,
> +				qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
>   				NOC_QOS_PRIORITY_P1_MASK, val);
>   	if (rc)
>   		return rc;
>   
> -	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> +	return regmap_update_bits(qp->regmap,
> +				  qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
>   				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
>   }
>   
> @@ -140,7 +143,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
>   	if (mode == NOC_QOS_MODE_FIXED) {
>   		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
>   			qn->name);
> -		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
> +		rc = qcom_icc_noc_set_qos_priority(qp, &qn->qos);
>   		if (rc)
>   			return rc;
>   	} else if (mode == NOC_QOS_MODE_BYPASS) {
> @@ -149,7 +152,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
>   	}
>   
>   	return regmap_update_bits(qp->regmap,
> -				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
> +				  qp->qos_offset + NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
>   				  NOC_QOS_MODEn_MASK, mode);
>   }
>   
> @@ -305,6 +308,7 @@ int qnoc_probe(struct platform_device *pdev)
>   	qp->num_clks = cd_num;
>   
>   	qp->is_bimc_node = desc->is_bimc_node;
> +	qp->qos_offset = desc->qos_offset;
>   
>   	if (desc->regmap_cfg) {
>   		struct resource *res;
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 868585c80f38..f6746dabdf28 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -18,6 +18,7 @@
>    * @bus_clks: the clk_bulk_data table of bus clocks
>    * @num_clks: the total number of clk_bulk_data entries
>    * @is_bimc_node: indicates whether to use bimc specific setting
> + * @qos_offset: offset to QoS registers
>    * @regmap: regmap for QoS registers read/write access
>    */
>   struct qcom_icc_provider {
> @@ -25,6 +26,7 @@ struct qcom_icc_provider {
>   	int num_clks;
>   	bool is_bimc_node;
>   	struct regmap *regmap;
> +	unsigned int qos_offset;
>   	struct clk_bulk_data bus_clks[];
>   };
>   
> @@ -77,6 +79,7 @@ struct qcom_icc_desc {
>   	size_t num_clocks;
>   	bool is_bimc_node;
>   	const struct regmap_config *regmap_cfg;
> +	unsigned int qos_offset;
>   };
>   
>   #define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
> 

