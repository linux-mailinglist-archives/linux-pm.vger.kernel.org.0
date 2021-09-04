Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ECB400B13
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351470AbhIDLBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 07:01:32 -0400
Received: from relay04.th.seeweb.it ([5.144.164.165]:49433 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351278AbhIDLBc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 07:01:32 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 144AC1F423;
        Sat,  4 Sep 2021 13:00:30 +0200 (CEST)
Subject: Re: [PATCH v2 09/11] interconnect: msm8939: add support for AP-owned
 nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-10-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <86e82a78-ac00-8099-ef45-80c39babcf3d@somainline.org>
Date:   Sat, 4 Sep 2021 13:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210903232421.1384199-10-dmitry.baryshkov@linaro.org>
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
>   drivers/interconnect/qcom/msm8939.c | 115 ++++++++++++++++++++++++++++
>   1 file changed, 115 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
> index 4671538c8994..16272a477bd8 100644
> --- a/drivers/interconnect/qcom/msm8939.c
> +++ b/drivers/interconnect/qcom/msm8939.c
> @@ -11,6 +11,7 @@
>   #include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/of_device.h>
>   
>   #include <dt-bindings/interconnect/qcom,msm8939.h>
> @@ -120,6 +121,8 @@ static struct qcom_icc_node bimc_snoc_mas = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(bimc_snoc_mas_links),
>   	.links = bimc_snoc_mas_links,
>   };
> @@ -151,6 +154,11 @@ static struct qcom_icc_node mas_apss = {
>   	.buswidth = 16,
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
> @@ -209,6 +217,11 @@ static struct qcom_icc_node mas_gfx = {
>   	.buswidth = 16,
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
> @@ -224,6 +237,11 @@ static struct qcom_icc_node mas_jpeg = {
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
> @@ -239,6 +257,11 @@ static struct qcom_icc_node mas_mdp0 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 7,
>   	.num_links = ARRAY_SIZE(mas_mdp0_links),
>   	.links = mas_mdp0_links,
>   };
> @@ -254,6 +277,11 @@ static struct qcom_icc_node mas_mdp1 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 13,
>   	.num_links = ARRAY_SIZE(mas_mdp1_links),
>   	.links = mas_mdp1_links,
>   };
> @@ -269,6 +297,11 @@ static struct qcom_icc_node mas_cpp = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> +	.qos.areq_prio = 0,
> +	.qos.prio_level = 0,
> +	.qos.qos_port = 12,
>   	.num_links = ARRAY_SIZE(mas_cpp_links),
>   	.links = mas_cpp_links,
>   };
> @@ -325,6 +358,11 @@ static struct qcom_icc_node mas_qdss_bam = {
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
> @@ -339,6 +377,11 @@ static struct qcom_icc_node mas_qdss_etr = {
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
> @@ -383,6 +426,11 @@ static struct qcom_icc_node mas_tcu0 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> +	.qos.areq_prio = 2,
> +	.qos.prio_level = 2,
> +	.qos.qos_port = 6,
>   	.num_links = ARRAY_SIZE(mas_tcu0_links),
>   	.links = mas_tcu0_links,
>   };
> @@ -426,6 +474,11 @@ static struct qcom_icc_node mas_vfe = {
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
> @@ -441,6 +494,11 @@ static struct qcom_icc_node mas_video = {
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
> @@ -455,6 +513,8 @@ static struct qcom_icc_node mm_int_0 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_0_links),
>   	.links = mm_int_0_links,
>   };
> @@ -469,6 +529,8 @@ static struct qcom_icc_node mm_int_1 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_1_links),
>   	.links = mm_int_1_links,
>   };
> @@ -483,6 +545,8 @@ static struct qcom_icc_node mm_int_2 = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(mm_int_2_links),
>   	.links = mm_int_2_links,
>   };
> @@ -711,6 +775,8 @@ static struct qcom_icc_node qdss_int = {
>   	.buswidth = 8,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(qdss_int_links),
>   	.links = qdss_int_links,
>   };
> @@ -1029,6 +1095,8 @@ static struct qcom_icc_node snoc_bimc_0_mas = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(snoc_bimc_0_mas_links),
>   	.links = snoc_bimc_0_mas_links,
>   };
> @@ -1043,6 +1111,8 @@ static struct qcom_icc_node snoc_bimc_0_slv = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(snoc_bimc_0_slv_links),
>   	.links = snoc_bimc_0_slv_links,
>   };
> @@ -1085,6 +1155,8 @@ static struct qcom_icc_node snoc_bimc_2_mas = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(snoc_bimc_2_mas_links),
>   	.links = snoc_bimc_2_mas_links,
>   };
> @@ -1099,6 +1171,8 @@ static struct qcom_icc_node snoc_bimc_2_slv = {
>   	.buswidth = 16,
>   	.mas_rpm_id = -1,
>   	.slv_rpm_id = -1,
> +	.qos.ap_owned = true,
> +	.qos.qos_mode = NOC_QOS_MODE_INVALID,
>   	.num_links = ARRAY_SIZE(snoc_bimc_2_slv_links),
>   	.links = snoc_bimc_2_slv_links,
>   };
> @@ -1199,9 +1273,19 @@ static struct qcom_icc_node *msm8939_snoc_nodes[] = {
>   	[SNOC_QDSS_INT] = &qdss_int,
>   };
>   
> +static const struct regmap_config msm8939_snoc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x14080,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8939_snoc = {
>   	.nodes = msm8939_snoc_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
> +	.regmap_cfg = &msm8939_snoc_regmap_config,
> +	.qos_offset = 0x7000,
>   };
>   
>   static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
> @@ -1216,9 +1300,19 @@ static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
>   	[SNOC_MM_INT_2] = &mm_int_2,
>   };
>   
> +static const struct regmap_config msm8939_snoc_mm_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x14080,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8939_snoc_mm = {
>   	.nodes = msm8939_snoc_mm_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
> +	.regmap_cfg = &msm8939_snoc_mm_regmap_config,
> +	.qos_offset = 0x7000,
>   };
>   
>   static struct qcom_icc_node *msm8939_bimc_nodes[] = {
> @@ -1233,9 +1327,20 @@ static struct qcom_icc_node *msm8939_bimc_nodes[] = {
>   	[SNOC_BIMC_2_SLV] = &snoc_bimc_2_slv,
>   };
>   
> +static const struct regmap_config msm8939_bimc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x62000,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8939_bimc = {
>   	.nodes = msm8939_bimc_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
> +	.is_bimc_node = true,
> +	.regmap_cfg = &msm8939_bimc_regmap_config,
> +	.qos_offset = 0x8000,
>   };
>   
>   static struct qcom_icc_node *msm8939_pcnoc_nodes[] = {
> @@ -1293,9 +1398,19 @@ static struct qcom_icc_node *msm8939_pcnoc_nodes[] = {
>   	[SNOC_PCNOC_SLV] = &snoc_pcnoc_slv,
>   };
>   
> +static const struct regmap_config msm8939_pcnoc_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x11000,
> +	.fast_io	= true,
> +};
> +
>   static struct qcom_icc_desc msm8939_pcnoc = {
>   	.nodes = msm8939_pcnoc_nodes,
>   	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
> +	.regmap_cfg = &msm8939_pcnoc_regmap_config,
> +	.qos_offset = 0x7000,
>   };
>   
>   static const struct of_device_id msm8939_noc_of_match[] = {
> 

