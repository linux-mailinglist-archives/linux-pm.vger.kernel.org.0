Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4181400B10
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351467AbhIDLBH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 07:01:07 -0400
Received: from relay04.th.seeweb.it ([5.144.164.165]:49821 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351278AbhIDLBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 07:01:06 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 83E4C1F423;
        Sat,  4 Sep 2021 13:00:03 +0200 (CEST)
Subject: Re: [PATCH v2 07/11] interconnect: msm8916: add support for AP-owned
 nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-8-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <85002698-ad2f-71a8-8446-61227474e5bb@somainline.org>
Date:   Sat, 4 Sep 2021 13:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210903232421.1384199-8-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 04/09/21 01:24, Dmitry Baryshkov ha scritto:
> Port support for AP-owned nodes from the downstream device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested on Sony Xperia XA2 (sdm630-pioneer)



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

> ---
>   drivers/interconnect/qcom/msm8916.c | 100 ++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
> index b7d662875c89..e3c995b11357 100644
> --- a/drivers/interconnect/qcom/msm8916.c
> +++ b/drivers/interconnect/qcom/msm8916.c
> @@ -10,6 +10,7 @@
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/of_device.h>
>   
>   #include <dt-bindings/interconnect/qcom,msm8916.h>
> @@ -115,6 +116,8 @@ static struct qcom_icc_node bimc_snoc_mas = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(bimc_snoc_mas_links),
>   	.links = bimc_snoc_mas_links,
>   };
> @@ -130,6 +133,8 @@ static struct qcom_icc_node bimc_snoc_slv = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(bimc_snoc_slv_links),
>   	.links = bimc_snoc_slv_links,
>   };
> @@ -146,6 +151,11 @@ static struct qcom_icc_node mas_apss = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 0,
>   	.num_links = ARRAY_SIZE(mas_apss_links),
>   	.links = mas_apss_links,
>   };
> @@ -204,6 +214,11 @@ static struct qcom_icc_node mas_gfx = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 2,
>   	.num_links = ARRAY_SIZE(mas_gfx_links),
>   	.links = mas_gfx_links,
>   };
> @@ -219,6 +234,11 @@ static struct qcom_icc_node mas_jpeg = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 6,
>   	.num_links = ARRAY_SIZE(mas_jpeg_links),
>   	.links = mas_jpeg_links,
>   };
> @@ -234,6 +254,11 @@ static struct qcom_icc_node mas_mdp = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 7,
>   	.num_links = ARRAY_SIZE(mas_mdp_links),
>   	.links = mas_mdp_links,
>   };
> @@ -290,6 +315,11 @@ static struct qcom_icc_node mas_qdss_bam = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 1,
> +	.qos.prio_level = 1,
> +	.qos.qos_port = 11,
>   	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
>   	.links = mas_qdss_bam_links,
>   };
> @@ -304,6 +334,11 @@ static struct qcom_icc_node mas_qdss_etr = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 1,
> +	.qos.prio_level = 1,
> +	.qos.qos_port = 10,
>   	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
>   	.links = mas_qdss_etr_links,
>   };
> @@ -348,6 +383,11 @@ static struct qcom_icc_node mas_tcu0 = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 2,
> +	.qos.prio_level = 2,
> +	.qos.qos_port = 5,
>   	.num_links = ARRAY_SIZE(mas_tcu0_links),
>   	.links = mas_tcu0_links,
>   };
> @@ -364,6 +404,11 @@ static struct qcom_icc_node mas_tcu1 = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 2,
> +	.qos.prio_level = 2,
> +	.qos.qos_port = 6,
>   	.num_links = ARRAY_SIZE(mas_tcu1_links),
>   	.links = mas_tcu1_links,
>   };
> @@ -393,6 +438,11 @@ static struct qcom_icc_node mas_vfe = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 9,
>   	.num_links = ARRAY_SIZE(mas_vfe_links),
>   	.links = mas_vfe_links,
>   };
> @@ -408,6 +458,11 @@ static struct qcom_icc_node mas_video = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 8,
>   	.num_links = ARRAY_SIZE(mas_video_links),
>   	.links = mas_video_links,
>   };
> @@ -422,6 +477,8 @@ static struct qcom_icc_node mm_int_0 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_0_links),
>   	.links = mm_int_0_links,
>   };
> @@ -436,6 +493,8 @@ static struct qcom_icc_node mm_int_1 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_1_links),
>   	.links = mm_int_1_links,
>   };
> @@ -450,6 +509,8 @@ static struct qcom_icc_node mm_int_2 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_2_links),
>   	.links = mm_int_2_links,
>   };
> @@ -464,6 +525,8 @@ static struct qcom_icc_node mm_int_bimc = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_bimc_links),
>   	.links = mm_int_bimc_links,
>   };
> @@ -692,6 +755,8 @@ static struct qcom_icc_node qdss_int = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(qdss_int_links),
>   	.links = qdss_int_links,
>   };
> @@ -1030,6 +1095,8 @@ static struct qcom_icc_node snoc_bimc_1_mas = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(snoc_bimc_1_mas_links),
>   	.links = snoc_bimc_1_mas_links,
>   };
> @@ -1044,6 +1111,8 @@ static struct qcom_icc_node snoc_bimc_1_slv = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(snoc_bimc_1_slv_links),
>   	.links = snoc_bimc_1_slv_links,
>   };
> @@ -1151,9 +1220,19 @@ static struct qcom_icc_node *msm8916_snoc_nodes[] = {
>   	[SNOC_QDSS_INT] = &qdss_int,
>   };
>   
> +static const struct regmap_config msm8916_snoc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x14000,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8916_snoc = {
>   	.nodes = msm8916_snoc_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
> +	.regmap_cfg = &msm8916_snoc_regmap_config,
> +	.qos_offset = 0x7000,
>   };
>   
>   static struct qcom_icc_node *msm8916_bimc_nodes[] = {
> @@ -1168,9 +1247,20 @@ static struct qcom_icc_node *msm8916_bimc_nodes[] = {
>   	[SNOC_BIMC_1_SLV] = &snoc_bimc_1_slv,
>   };
>   
> +static const struct regmap_config msm8916_bimc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x62000,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8916_bimc = {
>   	.nodes = msm8916_bimc_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
> +	.is_bimc_node = true,
> +	.regmap_cfg = &msm8916_bimc_regmap_config,
> +	.qos_offset = 0x8000,
>   };
>   
>   static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
> @@ -1226,9 +1316,19 @@ static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
>   	[SNOC_PCNOC_SLV] = &snoc_pcnoc_slv,
>   };
>   
> +static const struct regmap_config msm8916_pcnoc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x11000,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8916_pcnoc = {
>   	.nodes = msm8916_pcnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
> +	.regmap_cfg = &msm8916_pcnoc_regmap_config,
> +	.qos_offset = 0x7000,
>   };
>   
>   static const struct of_device_id msm8916_noc_of_match[] = {
> 

