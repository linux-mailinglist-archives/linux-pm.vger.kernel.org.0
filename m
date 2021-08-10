Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE593E598A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhHJL7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 07:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238798AbhHJL7C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 07:59:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F29860EBD;
        Tue, 10 Aug 2021 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628596720;
        bh=mGS5Gc7W6N/iGmYXqSU1qGE5hU54bLGn93VwUvI393M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mDmTgYLnmU8OWwCJ34jbIcKcbUcImg9O9l2CFCwhn4Hn9VcORUrjPm8m/4/2xI+Ui
         U65jKpR/IHKgNxNShNniqoBzVh5Z5e0jSGz9s3LR/40JxJcZ37xi2tW91fGpzdy2bm
         hLOGv8r9QGMlrj5JKCAESuV5fuhPn79utX8f7l0Oc0P5ZiNsqZV8jlkV4ifVbpXggf
         4f4e5WWsfmYGaw4HmrZ7LzT1fFbYBblp/ZQTCsAZoWT7R8wMcV00iYJ1+fC4+Z7Nyx
         a4aUDCau7gb7TecEiUYbm3Ns7z53T3UFdGScMI2CSdCYLOhctZcVFjHB+h6NUb7n8/
         Lo4n2ZYxN0NaA==
Subject: Re: [v6 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
To:     Odelu Kukatla <okukatla@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-3-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <b2e74ff4-c15c-3df3-27d9-87cebbf9342d@kernel.org>
Date:   Tue, 10 Aug 2021 14:58:26 +0300
MIME-Version: 1.0
In-Reply-To: <1628577962-3995-3-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

On 10.08.21 9:46, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> SC7280 SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>   drivers/interconnect/qcom/osm-l3.c | 136 +++++++++++++++++++++++++++++++------
>   drivers/interconnect/qcom/sc7280.h |  10 +++
>   2 files changed, 125 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index c7af143..3b16e73 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -9,12 +9,14 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   
>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>   
>   #include "sc7180.h"
> +#include "sc7280.h"
>   #include "sc8180x.h"
>   #include "sdm845.h"
>   #include "sm8150.h"
> @@ -33,17 +35,33 @@
>   
>   /* EPSS Register offsets */
>   #define EPSS_LUT_ROW_SIZE		4
> +#define EPSS_REG_L3_VOTE		0x90
>   #define EPSS_REG_FREQ_LUT		0x100
>   #define EPSS_REG_PERF_STATE		0x320
> +#define EPSS_CORE_OFFSET		0x4
> +#define EPSS_L3_VOTE_REG(base, cpu)\
> +			(((base) + EPSS_REG_L3_VOTE) +\
> +			((cpu) * EPSS_CORE_OFFSET))
>   
> -#define OSM_L3_MAX_LINKS		1
> +#define L3_DOMAIN_CNT		4
> +#define L3_MAX_LINKS		9
>   
>   #define to_osm_l3_provider(_provider) \
>   	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
>   
> +/**
> + * @domain_base: an array of base address for each clock domain

This is not a valid kerneldoc. Please add a title for
	struct qcom_osm_l3_icc_provider

> + * @max_state: max supported frequency level
> + * @per_core_dcvs: flag used to indicate whether the frequency scaling
> + * for each core is enabled
> + * @reg_perf_state: requested frequency level
> + * @lut_tables: an array of supported frequency levels
> + * @provider: interconnect provider of this node
> + */
>   struct qcom_osm_l3_icc_provider {
> -	void __iomem *base;
> +	void __iomem *domain_base[L3_DOMAIN_CNT];
>   	unsigned int max_state;
> +	bool per_core_dcvs;
>   	unsigned int reg_perf_state;
>   	unsigned long lut_tables[LUT_MAX_ENTRIES];
>   	struct icc_provider provider;
> @@ -56,32 +74,44 @@ struct qcom_osm_l3_icc_provider {
>    * @id: a unique node identifier
>    * @num_links: the total number of @links
>    * @buswidth: width of the interconnect between a node and the bus
> + * @domain: clock domain of the cpu node
> + * @cpu: cpu instance within its clock domain
>    */
>   struct qcom_osm_l3_node {
>   	const char *name;
> -	u16 links[OSM_L3_MAX_LINKS];
> +	u16 links[L3_MAX_LINKS];
>   	u16 id;
>   	u16 num_links;
>   	u16 buswidth;
> +	u8 domain;
> +	u8 cpu;
>   };
>   
>   struct qcom_osm_l3_desc {
>   	const struct qcom_osm_l3_node **nodes;
>   	size_t num_nodes;
> +	bool per_core_dcvs;
>   	unsigned int lut_row_size;
>   	unsigned int reg_freq_lut;
>   	unsigned int reg_perf_state;
>   };
>   
> -#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
> +#define __DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, ...)	\
>   	static const struct qcom_osm_l3_node _name = {			\
>   		.name = #_name,						\
>   		.id = _id,						\
>   		.buswidth = _buswidth,					\
> +		.domain = _domain,					\
> +		.cpu = _cpu,						\
>   		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
>   		.links = { __VA_ARGS__ },				\
>   	}
>   
> +#define DEFINE_QNODE(_name, _id, _buswidth, ...)		\
> +		__DEFINE_QNODE(_name, _id, _buswidth, 0, 0, __VA_ARGS__ )

Nit: No space before the close parenthesis please.

> +#define DEFINE_DCVS_QNODE(_name, _id, _buswidth, _domain, _cpu, ...)		\
> +		__DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, __VA_ARGS__ )

Ditto

> +
>   DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
>   DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
>   
> @@ -162,26 +192,80 @@ static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
>   	.reg_perf_state = EPSS_REG_PERF_STATE,
>   };
>   
> +DEFINE_DCVS_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, 0, 0,
> +					SC7280_SLAVE_EPSS_L3_SHARED, SC7280_SLAVE_EPSS_L3_CPU0,
> +					SC7280_SLAVE_EPSS_L3_CPU1, SC7280_SLAVE_EPSS_L3_CPU2,
> +					SC7280_SLAVE_EPSS_L3_CPU3, SC7280_SLAVE_EPSS_L3_CPU4,
> +					SC7280_SLAVE_EPSS_L3_CPU5, SC7280_SLAVE_EPSS_L3_CPU6,
> +					SC7280_SLAVE_EPSS_L3_CPU7);

Nit: Please align these to the open parenthesis.

Thanks,
Georgi

