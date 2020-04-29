Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420D11BDB5A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2MFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 08:05:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbgD2MFJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 08:05:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F6BC89CE57ACD6552F0;
        Wed, 29 Apr 2020 20:05:06 +0800 (CST)
Received: from [10.166.212.221] (10.166.212.221) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 29 Apr
 2020 20:04:55 +0800
Subject: Re: [PATCH 1/1] interconnect: qcom: Move the static keyword to the
 front of declaration
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200429101904.5771-1-georgi.djakov@linaro.org>
 <20200429101904.5771-2-georgi.djakov@linaro.org>
From:   "chentao (AS)" <chentao107@huawei.com>
Message-ID: <f3b632b7-3a96-5f61-170f-5bff62582e38@huawei.com>
Date:   Wed, 29 Apr 2020 20:04:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200429101904.5771-2-georgi.djakov@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.166.212.221]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you for your review and modification!

On 2020/4/29 18:19, Georgi Djakov wrote:
> From: ChenTao <chentao107@huawei.com>
>
> Fix the following warning:
>
> Move the static keyword to the front of declaration of sdm845_icc_osm_l3
> sdm845_aggre1_noc sc7180_icc_osm_l3 sdm845_aggre2_noc sdm845_config_noc
> sdm845_dc_noc sdm845_gladiator_noc sdm845_mem_noc sdm845_mmss_noc and
> sdm845_system_noc, resolve the following compiler warning that can be
> when building with warnings enabled (W=1):
>
> drivers/interconnect/qcom/osm-l3.c:81:1: warning:
>   const static struct qcom_icc_desc sdm845_icc_osm_l3 = {
> drivers/interconnect/qcom/osm-l3.c:94:1: warning:
>   const static struct qcom_icc_desc sc7180_icc_osm_l3 = {
> drivers/interconnect/qcom/sdm845.c:195:1: warning:
>   const static struct qcom_icc_desc sdm845_aggre1_noc = {
> drivers/interconnect/qcom/sdm845.c:223:1: warning:
>   const static struct qcom_icc_desc sdm845_aggre2_noc = {
> drivers/interconnect/qcom/sdm845.c:284:1: warning:
>   const static struct qcom_icc_desc sdm845_config_noc = {
> drivers/interconnect/qcom/sdm845.c:300:1: warning:
>   const static struct qcom_icc_desc sdm845_dc_noc = {
> drivers/interconnect/qcom/sdm845.c:318:1: warning:
>   const static struct qcom_icc_desc sdm845_gladiator_noc = {
> drivers/interconnect/qcom/sdm845.c:353:1: warning:
>   const static struct qcom_icc_desc sdm845_mem_noc = {
> drivers/interconnect/qcom/sdm845.c:387:1: warning:
>   const static struct qcom_icc_desc sdm845_mmss_noc = {
> drivers/interconnect/qcom/sdm845.c:433:1: warning:
>   const static struct qcom_icc_desc sdm845_system_noc = {
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>
> Link: https://lore.kernel.org/r/20200423132142.45174-1-chentao107@huawei.com
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/qcom/osm-l3.c |  4 ++--
>   drivers/interconnect/qcom/sdm845.c | 16 ++++++++--------
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index a03c6d6833df..96fb9ff5ff2e 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -78,7 +78,7 @@ static struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
>   	[SLAVE_OSM_L3] = &sdm845_osm_l3,
>   };
>   
> -const static struct qcom_icc_desc sdm845_icc_osm_l3 = {
> +static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
>   	.nodes = sdm845_osm_l3_nodes,
>   	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
>   };
> @@ -91,7 +91,7 @@ static struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
>   	[SLAVE_OSM_L3] = &sc7180_osm_l3,
>   };
>   
> -const static struct qcom_icc_desc sc7180_icc_osm_l3 = {
> +static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
>   	.nodes = sc7180_osm_l3_nodes,
>   	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
>   };
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index b013b80caa45..f6c7b969520d 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -192,7 +192,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
>   	[SLAVE_ANOC_PCIE_A1NOC_SNOC] = &qns_pcie_a1noc_snoc,
>   };
>   
> -const static struct qcom_icc_desc sdm845_aggre1_noc = {
> +static const struct qcom_icc_desc sdm845_aggre1_noc = {
>   	.nodes = aggre1_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
>   	.bcms = aggre1_noc_bcms,
> @@ -220,7 +220,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
>   	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
>   };
>   
> -const static struct qcom_icc_desc sdm845_aggre2_noc = {
> +static const struct qcom_icc_desc sdm845_aggre2_noc = {
>   	.nodes = aggre2_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
>   	.bcms = aggre2_noc_bcms,
> @@ -281,7 +281,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
>   	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
>   };
>   
> -const static struct qcom_icc_desc sdm845_config_noc = {
> +static const struct qcom_icc_desc sdm845_config_noc = {
>   	.nodes = config_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(config_noc_nodes),
>   	.bcms = config_noc_bcms,
> @@ -297,7 +297,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
>   	[SLAVE_MEM_NOC_CFG] = &qhs_memnoc,
>   };
>   
> -const static struct qcom_icc_desc sdm845_dc_noc = {
> +static const struct qcom_icc_desc sdm845_dc_noc = {
>   	.nodes = dc_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
>   	.bcms = dc_noc_bcms,
> @@ -315,7 +315,7 @@ static struct qcom_icc_node *gladiator_noc_nodes[] = {
>   	[SLAVE_SERVICE_GNOC] = &srvc_gnoc,
>   };
>   
> -const static struct qcom_icc_desc sdm845_gladiator_noc = {
> +static const struct qcom_icc_desc sdm845_gladiator_noc = {
>   	.nodes = gladiator_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
>   	.bcms = gladiator_noc_bcms,
> @@ -350,7 +350,7 @@ static struct qcom_icc_node *mem_noc_nodes[] = {
>   	[SLAVE_EBI1] = &ebi,
>   };
>   
> -const static struct qcom_icc_desc sdm845_mem_noc = {
> +static const struct qcom_icc_desc sdm845_mem_noc = {
>   	.nodes = mem_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
>   	.bcms = mem_noc_bcms,
> @@ -384,7 +384,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
>   	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
>   };
>   
> -const static struct qcom_icc_desc sdm845_mmss_noc = {
> +static const struct qcom_icc_desc sdm845_mmss_noc = {
>   	.nodes = mmss_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
>   	.bcms = mmss_noc_bcms,
> @@ -430,7 +430,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
>   	[SLAVE_TCU] = &xs_sys_tcu_cfg,
>   };
>   
> -const static struct qcom_icc_desc sdm845_system_noc = {
> +static const struct qcom_icc_desc sdm845_system_noc = {
>   	.nodes = system_noc_nodes,
>   	.num_nodes = ARRAY_SIZE(system_noc_nodes),
>   	.bcms = system_noc_bcms,
> .
