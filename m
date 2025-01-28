Return-Path: <linux-pm+bounces-20995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7BAA2052A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 08:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1611883363
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E41DA116;
	Tue, 28 Jan 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gCdNh9Lm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B02AD2D;
	Tue, 28 Jan 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738050532; cv=none; b=cJcX/iwME5IM1OwvI+b47uzuz6sGSXHmWpIigjmUZAA1PHm6sGO76usMtdqOlMQx9pHM+fofo3NC1xV7aDRd3DCZzn1BUJIdgLsFsJVI9aWL7rku98oSs5/RgLPs31Qa5OxWaBA1FljyEfnDe9EnLeSWR1PbxRByjbFgCmQQngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738050532; c=relaxed/simple;
	bh=nUsTPbSDCyusoGvI3Bg8Azv9QcjrBFaFCmRYLm4mDvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVVtpugEiuuSAZPfMZaYA71Fc5ef1DhTMjQQ4GHYOEZ902uF9iBTHhSKEob+r+CxyaNq4B57BJ9gNggfOKz0GxDYiDiLIML0acI+jv2VVb87ZPS1kAdS6jAkbIA9jBcC3LdhYI2KQCEc45cLCCRZX/EgBZPLOUR9w90fwlJk1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gCdNh9Lm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S0Vf9V002698;
	Tue, 28 Jan 2025 07:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4s+SJUaGUDkO5ABlta4Jojct
	rfP/Q2Dd5HccoK2RIM4=; b=gCdNh9LmKPAFKGYL9oI8otcf6WM7UlV/OLkcBxK2
	/gfAXut3Qe7sDn0RfMj/qYxnm/1FRv9RDRB3AjIxJUJqiuhd3DfAkvk0L9ho9zqW
	b4ymsrt497SAuuOddJywSoRQxn516WxMiAj7UOzhRmBZ6jzVnmdD4T7UQXK39SEA
	s7xmHLsw6az5JF95nY2rvtdthyzn6576Of4LOKIXwD8DHDWUEKMgq8TS16GlaD6w
	qfD3U2/nnVGzKDUp/o0fgSwutay2099xG5iaYGR26StnApfcrIgsk9myka3giN08
	NqUyWsUZ4uxYF7iU1LE8gFYJEDg7OzS8JZMDqM9BCyubKA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44emry0qey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:48:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S7mh2f020707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:48:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 23:48:38 -0800
Date: Tue, 28 Jan 2025 13:18:34 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Sricharan R <quic_srichara@quicinc.com>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
Message-ID: <Z5iL0p6AaY2G9s1v@hu-varada-blr.qualcomm.com>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
 <20250127093128.2611247-3-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250127093128.2611247-3-quic_srichara@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OWIFAp6WvZHedOy-GZ9ULBHZkGhmuL1T
X-Proofpoint-GUID: OWIFAp6WvZHedOy-GZ9ULBHZkGhmuL1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280058

On Mon, Jan 27, 2025 at 03:01:26PM +0530, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
> Add support for the APSS PLL, RCG and clock enable for ipq5424.
> The PLL, RCG register space are clubbed. Hence adding new APSS driver
> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
> and needs to be scaled along with the CPU.
>
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |   7 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/apss-ipq5424.c | 373 ++++++++++++++++++++++++++++++++
>  3 files changed, 381 insertions(+)
>  create mode 100644 drivers/clk/qcom/apss-ipq5424.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ef89d686cbc4..9a03257d67e0 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -190,6 +190,13 @@ config IPQ_APSS_6018
>  	  Say Y if you want to support CPU frequency scaling on
>  	  ipq based devices.
>
> +config IPQ_APSS_5424
> +	tristate "IPQ APSS Clock Controller"
> +	help
> +	  Support for APSS Clock controller on Qualcom IPQ5424 platform.
> +	  Say Y if you want to support CPU frequency scaling on ipq based
> +	  devices.
> +
>  config IPQ_GCC_4019
>  	tristate "IPQ4019 Global Clock Controller"
>  	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index b09dbdc210eb..db15514e7367 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_CLK_X1E80100_GPUCC) += gpucc-x1e80100.o
>  obj-$(CONFIG_CLK_X1E80100_TCSRCC) += tcsrcc-x1e80100.o
>  obj-$(CONFIG_CLK_QCM2290_GPUCC) += gpucc-qcm2290.o
>  obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
> +obj-$(CONFIG_IPQ_APSS_5424) += apss-ipq5424.o
>  obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_5018) += gcc-ipq5018.o
> diff --git a/drivers/clk/qcom/apss-ipq5424.c b/drivers/clk/qcom/apss-ipq5424.c
> new file mode 100644
> index 000000000000..2bd6ee7575dc
> --- /dev/null
> +++ b/drivers/clk/qcom/apss-ipq5424.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.

2025

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
> +#include <dt-bindings/arm/qcom,ids.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +
> +#define GPLL0_CLK_RATE		800000000
> +#define CPU_NOM_CLK_RATE	1416000000
> +#define CPU_TURBO_CLK_RATE	1800000000
> +#define L3_NOM_CLK_RATE		984000000
> +#define L3_TURBO_CLK_RATE	1272000000
> +
> +enum {
> +	P_XO,
> +	P_GPLL0,
> +	P_APSS_PLL_EARLY,
> +	P_L3_PLL,
> +};
> +
> +struct apss_clk {
> +	struct notifier_block cpu_clk_notifier;
> +	struct clk_hw *hw;
> +	struct device *dev;
> +	struct clk *l3_clk;
> +};
> +
> +/*
> + * IPQ5424 Huayra PLL offsets are different from the one mentioned in the
> + * clk-alpha-pll.c, hence define the IPQ5424 offsets here
> + */

This seems to be same as clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290]
in clk-alpha-pll.c. Please see if that can be used here.

> +static const u8 ipq5424_pll_offsets[][PLL_OFF_MAX_REGS] = {
> +	[CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
> +		[PLL_OFF_L_VAL] = 0x04,
> +		[PLL_OFF_ALPHA_VAL] = 0x08,
> +		[PLL_OFF_USER_CTL] = 0x0c,
> +		[PLL_OFF_CONFIG_CTL] = 0x10,
> +		[PLL_OFF_CONFIG_CTL_U] = 0x14,
> +		[PLL_OFF_CONFIG_CTL_U1] = 0x18,
> +		[PLL_OFF_TEST_CTL] = 0x1c,
> +		[PLL_OFF_TEST_CTL_U] = 0x20,
> +		[PLL_OFF_TEST_CTL_U1] = 0x24,
> +		[PLL_OFF_STATUS] = 0x38,
> +	},
> +};
> +
> +static struct clk_alpha_pll ipq5424_apss_pll = {
> +	.offset = 0x0,
> +	.regs = ipq5424_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apss_pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo-board-clk",
> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_apss_silver_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "gpll0" },
> +	{ .hw = &ipq5424_apss_pll.clkr.hw },
> +};
> +
> +static const struct parent_map parents_apss_silver_clk_src_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 4 },
> +	{ P_APSS_PLL_EARLY, 5 },
> +};
> +
> +static const struct freq_tbl ftbl_apss_clk_src[] = {
> +	F(GPLL0_CLK_RATE, P_GPLL0, 1, 0, 0),
> +	F(CPU_NOM_CLK_RATE, P_APSS_PLL_EARLY, 1, 0, 0),
> +	F(CPU_TURBO_CLK_RATE, P_APSS_PLL_EARLY, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 apss_silver_clk_src = {
> +	.cmd_rcgr = 0x0080,
> +	.freq_tbl = ftbl_apss_clk_src,
> +	.hid_width = 5,
> +	.parent_map = parents_apss_silver_clk_src_map,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "apss_silver_clk_src",
> +		.parent_data = parents_apss_silver_clk_src,
> +		.num_parents = ARRAY_SIZE(parents_apss_silver_clk_src),
> +		.ops = &clk_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_branch apss_silver_core_clk = {
> +	.halt_reg = 0x008c,
> +	.clkr = {
> +		.enable_reg = 0x008c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "apss_silver_core_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&apss_silver_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll ipq5424_l3_pll = {
> +	.offset = 0x10000,
> +	.regs = ipq5424_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "l3_pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo-board-clk",
> +			},
> +			.parent_names = (const char *[]){ "xo-board-clk"},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_huayra_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_parent_data parents_l3_clk_src[] = {
> +	{ .fw_name = "xo-board-clk" },
> +	{ .fw_name = "gpll0" },
> +	{ .hw = &ipq5424_l3_pll.clkr.hw },
> +};
> +
> +static const struct parent_map parents_l3_clk_src_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 4 },
> +	{ P_L3_PLL, 5 },
> +};
> +
> +static const struct freq_tbl ftbl_l3_clk_src[] = {
> +	F(GPLL0_CLK_RATE, P_GPLL0, 1, 0, 0),
> +	F(L3_NOM_CLK_RATE, P_L3_PLL, 1, 0, 0),
> +	F(L3_TURBO_CLK_RATE, P_L3_PLL, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 l3_clk_src = {
> +	.cmd_rcgr = 0x10080,
> +	.freq_tbl = ftbl_l3_clk_src,
> +	.hid_width = 5,
> +	.parent_map = parents_l3_clk_src_map,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "l3_clk_src",
> +		.parent_data = parents_l3_clk_src,
> +		.num_parents = ARRAY_SIZE(parents_l3_clk_src),
> +		.ops = &clk_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_branch l3_core_clk = {
> +	.halt_reg = 0x1008c,
> +	.clkr = {
> +		.enable_reg = 0x1008c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "l3_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&l3_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static const struct regmap_config apss_ipq5424_regmap_config = {
> +	.reg_bits       = 32,
> +	.reg_stride     = 4,
> +	.val_bits       = 32,
> +	.max_register   = 0x20000,
> +	.fast_io        = true,
> +};
> +
> +static struct clk_regmap *apss_ipq5424_clks[] = {
> +	[APSS_PLL_EARLY] = &ipq5424_apss_pll.clkr,
> +	[APSS_SILVER_CLK_SRC] = &apss_silver_clk_src.clkr,
> +	[APSS_SILVER_CORE_CLK] = &apss_silver_core_clk.clkr,
> +	[L3_PLL] = &ipq5424_l3_pll.clkr,
> +	[L3_CLK_SRC] = &l3_clk_src.clkr,
> +	[L3_CORE_CLK] = &l3_core_clk.clkr,
> +
> +};
> +
> +static const struct qcom_cc_desc apss_ipq5424_desc = {
> +	.config = &apss_ipq5424_regmap_config,
> +	.clks = apss_ipq5424_clks,
> +	.num_clks = ARRAY_SIZE(apss_ipq5424_clks),
> +};
> +
> +static const struct alpha_pll_config apss_pll_config = {
> +	.l = 0x3b,
> +	.config_ctl_val = 0x08200920,
> +	.config_ctl_hi_val = 0x05008001,
> +	.config_ctl_hi1_val = 0x04000000,
> +	.test_ctl_val = 0x0,
> +	.test_ctl_hi_val = 0x0,
> +	.test_ctl_hi1_val = 0x0,
> +	.user_ctl_val = 0x1,
> +	.early_output_mask = BIT(3),
> +	.aux2_output_mask = BIT(2),
> +	.aux_output_mask = BIT(1),
> +	.main_output_mask = BIT(0),
> +};
> +
> +static const struct alpha_pll_config l3_pll_config = {
> +	.l = 0x29,
> +	.config_ctl_val = 0x08200920,
> +	.config_ctl_hi_val = 0x05008001,
> +	.config_ctl_hi1_val = 0x04000000,
> +	.test_ctl_val = 0x0,
> +	.test_ctl_hi_val = 0x0,
> +	.test_ctl_hi1_val = 0x0,
> +	.user_ctl_val = 0x1,
> +	.early_output_mask = BIT(3),
> +	.aux2_output_mask = BIT(2),
> +	.aux_output_mask = BIT(1),
> +	.main_output_mask = BIT(0),
> +};
> +
> +static unsigned long get_l3_clk_from_tbl(unsigned long rate)
> +{
> +	struct clk_rcg2 *l3_rcg2 = container_of(&l3_clk_src.clkr, struct clk_rcg2, clkr);
> +	u8 max_clk = sizeof(ftbl_apss_clk_src) / sizeof(struct freq_tbl);
> +	u8 loop;
> +
> +	for (loop = 0; loop < max_clk; loop++)
> +		if (ftbl_apss_clk_src[loop].freq == rate)
> +			return l3_rcg2->freq_tbl[loop].freq;
> +	return 0;
> +}
> +
> +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> +			       void *data)
> +{
> +	struct apss_clk *apss_ipq5424_cfg = container_of(nb, struct apss_clk, cpu_clk_notifier);
> +	struct clk_notifier_data *cnd = (struct clk_notifier_data *)data;
> +	struct device *dev = apss_ipq5424_cfg->dev;
> +	unsigned long rate = 0, l3_rate;
> +	int err = 0;

No need to init 'err' here.

> +
> +	dev_dbg(dev, "action:%ld old_rate:%ld new_rate:%ld\n", action,
> +		cnd->old_rate, cnd->new_rate);
> +
> +	switch (action) {
> +	case PRE_RATE_CHANGE:
> +		if (cnd->old_rate < cnd->new_rate)
> +			rate = cnd->new_rate;
> +	break;
> +	case POST_RATE_CHANGE:
> +		if (cnd->old_rate > cnd->new_rate)
> +			rate = cnd->new_rate;
> +	break;
> +	};
> +
> +	if (!rate)
> +		goto notif_ret;
> +
> +	l3_rate = get_l3_clk_from_tbl(rate);
> +	if (!l3_rate) {
> +		dev_err(dev, "Failed to get l3 clock rate from l3_tbl\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	err = clk_set_rate(apss_ipq5424_cfg->l3_clk, l3_rate);
> +	if (err) {
> +		dev_err(dev, "Failed to set l3 clock rate(%ld) err(%d)\n", l3_rate, err);
> +		return NOTIFY_BAD;
> +	}
> +
> +notif_ret:
> +	return NOTIFY_OK;
> +}
> +
> +static int apss_ipq5424_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct apss_clk *apss_ipq5424_cfg;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int ret;
> +
> +	apss_ipq5424_cfg = devm_kzalloc(&pdev->dev, sizeof(struct apss_clk), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(apss_ipq5424_cfg))
> +		return PTR_ERR(apss_ipq5424_cfg);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &apss_ipq5424_regmap_config);
> +	if (!regmap)
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&ipq5424_l3_pll, regmap, &l3_pll_config);
> +
> +	clk_alpha_pll_configure(&ipq5424_apss_pll, regmap, &apss_pll_config);
> +
> +	ret = qcom_cc_really_probe(dev, &apss_ipq5424_desc, regmap);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&pdev->dev, "Registered APSS & L3 clock provider\n");
> +
> +	apss_ipq5424_cfg->dev = dev;
> +	apss_ipq5424_cfg->hw = &apss_silver_clk_src.clkr.hw;
> +	apss_ipq5424_cfg->cpu_clk_notifier.notifier_call = cpu_clk_notifier_fn;
> +
> +	apss_ipq5424_cfg->l3_clk = clk_hw_get_clk(&l3_core_clk.clkr.hw, "l3_clk");
> +	if (IS_ERR(apss_ipq5424_cfg->l3_clk)) {
> +		dev_err(&pdev->dev, "Failed to get L3 clk, %ld\n",
> +			PTR_ERR(apss_ipq5424_cfg->l3_clk));
> +		return PTR_ERR(apss_ipq5424_cfg->l3_clk);
> +	}
> +
> +	ret = devm_clk_notifier_register(&pdev->dev, apss_ipq5424_cfg->hw->clk,
> +					 &apss_ipq5424_cfg->cpu_clk_notifier);

Use return devm_clk_notifier_register(...) and below lines can be skipped.

Thanks
Varada

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id apss_ipq5424_match_table[] = {
> +	{ .compatible = "qcom,ipq5424-apss-clk" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, apss_ipq5424_match_table);
> +
> +static struct platform_driver apss_ipq5424_driver = {
> +	.probe = apss_ipq5424_probe,
> +	.driver = {
> +		.name   = "apss-ipq5424-clk",
> +		.of_match_table = apss_ipq5424_match_table,
> +	},
> +};
> +
> +module_platform_driver(apss_ipq5424_driver);
> +
> +MODULE_DESCRIPTION("QCOM APSS IPQ5424 CLK Driver");
> +MODULE_LICENSE("GPL v2");
>
> --
> 2.34.1
>

