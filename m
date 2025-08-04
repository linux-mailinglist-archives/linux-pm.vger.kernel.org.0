Return-Path: <linux-pm+bounces-31872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7CFB1A075
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6877E3BE5B9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E74253F00;
	Mon,  4 Aug 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WvA3rES1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFD238C36;
	Mon,  4 Aug 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306483; cv=none; b=GtmbS+nbfaDgNyyC0Xb4GfetRVZSEOWI7hSwCVMZjuIsu9wVo91AlusVbd69j0zcdnadcb9JWvCm+73+8FCK1QcW74WoMje0lpZetueK3Jey88uz4wcr+B9MyAkSFWdCPpSts09RlIgxm86ulRDvThp5pB1+WYfsnqA9dyuA/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306483; c=relaxed/simple;
	bh=0dleGB36V5IBIZguBmYgmV32+n1pS/rMXCHsDlMq9Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2zWg7Pf6rnbifzH0H+ITOR4HknBB7VHYMuepPHngWG9b4TxbiEyrD6fjmB6EInALWtVoaeIdUB09DOrRdlZoIcDjdWSI95xyNn5wNu3R0fwpp5Nn9+IL4lAmc9Nl6nPay9RI0TpCHAWjHCOexafv4p4XFhDWSrDEwFLMF8l4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WvA3rES1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748js4U029566;
	Mon, 4 Aug 2025 11:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IdJ++2A16ch8OaFMyH+WDKzKr+RXTAaBCnyJSU3AzjM=; b=WvA3rES14QQxlaCE
	O3H7AzHbekTDTk08/e6G5VqAQdV22WSOmbnhV5sLzv1pbD+ay3xHwb8bDT1EKM5t
	79Od55U/CrdvY1OZLCzUJaGpihGD1pS3nu/062RMXPZb9SEJgvxH8E48LC5EnEwL
	0AVMSxD0KWX1gU9tRcudhbMMjHEEOzAQEHeVh2pWjX+m98RgszHl5N/wggYlMyd0
	NaBqlmZ/nYndrxEwI8vbGGY6rKDR+t3Boqvky5g7hNinWCL7YyWsArwMbhiOEM8S
	53DZAGkT/PaVKp5wqT0Hwej7tTsgGwUvxjpzQ+gFf2NeN4cpHOZkC+g0eLqf2GmW
	wum3QQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqmnwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:21:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 574BLDVr030663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 11:21:13 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 4 Aug 2025 04:21:07 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam
	<quic_mdalam@quicinc.com>
Subject: [PATCH v5 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
Date: Mon, 4 Aug 2025 16:50:39 +0530
Message-ID: <20250804112041.845135-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112041.845135-1-quic_varada@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SzqpRHu_JhJOjy4C3RJnXDZxMEn8VfwG
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=689097a9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=4qVBXBCilfBDfP_PjJQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2MiBTYWx0ZWRfX1Z/ZUVrMCPoW
 X3awe3/+uX46TyrWC8usUxp8FHVZvL6IGmQBVtZjgs3MmnP7lZZlx1LJTVSVHtnbNL+lFawANZY
 wSIgnmbhy0WtjTftAedWHWqE+43sV6liSEWUojqqNBIlsdnSHqo9+pc2JGdqMx76AGvhU5+nmv0
 pfOlzMoXI2rtiaMC31bnsKD1JEIHFKtMZ/Vmg6rr3zRyCxBKPDywylEVuyEUBEJyNUGe4QQn3Wq
 Jn3njQLqbLL6TNi/wAsbpBHauheNy0cSABZwk3R0r5f2yIgy0hjdf2vTezI92TJooBIytwJhkIU
 /k1xyfsuNdT2oqsBHuLMgX+D67u95G2CsIQZQVpIp1P0oBKJ5FygfQTOdHfmQPpBgmhwgekOCnO
 ceqHpg/GGfvRm/grJlThvUz8AgFJvS/LZGGax/D8gYxaFS9CcLaKdGixLjRN5U0gsPhqiF8x
X-Proofpoint-ORIG-GUID: SzqpRHu_JhJOjy4C3RJnXDZxMEn8VfwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040062

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
and needs to be scaled along with the CPU and is modeled as an ICC clock.

Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Removed clock notifier, moved L3 pll to icc-clk, used existing
alpha pll structure ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Use enums instead of clock names in clock struct
    Add 'sync_state = icc_sync_state'

v4: s/gpll0/clk_ref/g

v3: Use the qcom_cc_driver_data framework to trim down apss_ipq5424_probe
    Rearrange structures to use in other structures

v2: Model L3 pll as ICC clock and add relevant structures
    Use CLK_ALPHA_PLL_TYPE_HUAYRA_2290 register offsets instead
    of duplicate ipq5424_pll_offsets definition.
    Inline clock rates.
    Fix MODULE_LICENSE
---
 drivers/clk/qcom/Kconfig        |   7 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/apss-ipq5424.c | 267 ++++++++++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6cb6cd3e1778..dae89599a40e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -208,6 +208,13 @@ config IPQ_CMN_PLL
 	  Say Y or M if you want to support CMN PLL clock on the IPQ
 	  based devices.
 
+config IPQ_APSS_5424
+	tristate "IPQ APSS Clock Controller"
+	help
+	  Support for APSS Clock controller on Qualcom IPQ5424 platform.
+	  Say Y if you want to support CPU frequency scaling on ipq based
+	  devices.
+
 config IPQ_GCC_4019
 	tristate "IPQ4019 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ddb7e06fae40..98de55eb6402 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_CLK_X1E80100_TCSRCC) += tcsrcc-x1e80100.o
 obj-$(CONFIG_CLK_X1P42100_GPUCC) += gpucc-x1p42100.o
 obj-$(CONFIG_CLK_QCM2290_GPUCC) += gpucc-qcm2290.o
 obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
+obj-$(CONFIG_IPQ_APSS_5424) += apss-ipq5424.o
 obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
 obj-$(CONFIG_IPQ_CMN_PLL) += ipq-cmn-pll.o
 obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
diff --git a/drivers/clk/qcom/apss-ipq5424.c b/drivers/clk/qcom/apss-ipq5424.c
new file mode 100644
index 000000000000..e5674a884f46
--- /dev/null
+++ b/drivers/clk/qcom/apss-ipq5424.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/interconnect-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/clock/qcom,apss-ipq.h>
+#include <dt-bindings/interconnect/qcom,ipq5424.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "common.h"
+
+enum {
+	DT_XO,
+	DT_CLK_REF,
+};
+
+enum {
+	P_XO,
+	P_GPLL0,
+	P_APSS_PLL_EARLY,
+	P_L3_PLL,
+};
+
+struct apss_clk {
+	struct notifier_block cpu_clk_notifier;
+	struct clk_hw *hw;
+	struct device *dev;
+	struct clk *l3_clk;
+};
+
+static const struct alpha_pll_config apss_pll_config = {
+	.l = 0x3b,
+	.config_ctl_val = 0x08200920,
+	.config_ctl_hi_val = 0x05008001,
+	.config_ctl_hi1_val = 0x04000000,
+	.user_ctl_val = 0xf,
+};
+
+static struct clk_alpha_pll ipq5424_apss_pll = {
+	.offset = 0x0,
+	.config = &apss_pll_config,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "apss_pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_XO,
+			},
+			.parent_names = (const char *[]){ "xo-board-clk"},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_huayra_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data parents_apss_silver_clk_src[] = {
+	{ .index = DT_XO },
+	{ .index = DT_CLK_REF },
+	{ .hw = &ipq5424_apss_pll.clkr.hw },
+};
+
+static const struct parent_map parents_apss_silver_clk_src_map[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 4 },
+	{ P_APSS_PLL_EARLY, 5 },
+};
+
+static const struct freq_tbl ftbl_apss_clk_src[] = {
+	F(816000000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1416000000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1800000000, P_APSS_PLL_EARLY, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 apss_silver_clk_src = {
+	.cmd_rcgr = 0x0080,
+	.freq_tbl = ftbl_apss_clk_src,
+	.hid_width = 5,
+	.parent_map = parents_apss_silver_clk_src_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "apss_silver_clk_src",
+		.parent_data = parents_apss_silver_clk_src,
+		.num_parents = ARRAY_SIZE(parents_apss_silver_clk_src),
+		.ops = &clk_rcg2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_branch apss_silver_core_clk = {
+	.halt_reg = 0x008c,
+	.clkr = {
+		.enable_reg = 0x008c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "apss_silver_core_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&apss_silver_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config l3_pll_config = {
+	.l = 0x29,
+	.config_ctl_val = 0x08200920,
+	.config_ctl_hi_val = 0x05008001,
+	.config_ctl_hi1_val = 0x04000000,
+	.user_ctl_val = 0xf,
+};
+
+static struct clk_alpha_pll ipq5424_l3_pll = {
+	.offset = 0x10000,
+	.config = &l3_pll_config,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_2290],
+	.flags = SUPPORTS_DYNAMIC_UPDATE,
+	.clkr = {
+		.enable_reg = 0x0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "l3_pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "xo-board-clk",
+			},
+			.parent_names = (const char *[]){ "xo-board-clk"},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_huayra_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data parents_l3_clk_src[] = {
+	{ .fw_name = "xo-board-clk" },
+	{ .fw_name = "clk_ref" },
+	{ .hw = &ipq5424_l3_pll.clkr.hw },
+};
+
+static const struct parent_map parents_l3_clk_src_map[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 4 },
+	{ P_L3_PLL, 5 },
+};
+
+static const struct freq_tbl ftbl_l3_clk_src[] = {
+	F(816000000, P_L3_PLL, 1, 0, 0),
+	F(984000000, P_L3_PLL, 1, 0, 0),
+	F(1272000000, P_L3_PLL, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 l3_clk_src = {
+	.cmd_rcgr = 0x10080,
+	.freq_tbl = ftbl_l3_clk_src,
+	.hid_width = 5,
+	.parent_map = parents_l3_clk_src_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "l3_clk_src",
+		.parent_data = parents_l3_clk_src,
+		.num_parents = ARRAY_SIZE(parents_l3_clk_src),
+		.ops = &clk_rcg2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_branch l3_core_clk = {
+	.halt_reg = 0x1008c,
+	.clkr = {
+		.enable_reg = 0x1008c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "l3_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&l3_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct regmap_config apss_ipq5424_regmap_config = {
+	.reg_bits       = 32,
+	.reg_stride     = 4,
+	.val_bits       = 32,
+	.max_register   = 0x20000,
+	.fast_io        = true,
+};
+
+static struct clk_regmap *apss_ipq5424_clks[] = {
+	[APSS_PLL_EARLY] = &ipq5424_apss_pll.clkr,
+	[APSS_SILVER_CLK_SRC] = &apss_silver_clk_src.clkr,
+	[APSS_SILVER_CORE_CLK] = &apss_silver_core_clk.clkr,
+	[L3_PLL] = &ipq5424_l3_pll.clkr,
+	[L3_CLK_SRC] = &l3_clk_src.clkr,
+	[L3_CORE_CLK] = &l3_core_clk.clkr,
+
+};
+
+static struct clk_alpha_pll *ipa5424_apss_plls[] = {
+	&ipq5424_l3_pll,
+	&ipq5424_apss_pll,
+};
+
+static struct qcom_cc_driver_data ipa5424_apss_driver_data = {
+	.alpha_plls = ipa5424_apss_plls,
+	.num_alpha_plls = ARRAY_SIZE(ipa5424_apss_plls),
+};
+
+#define IPQ_APPS_PLL_ID			(5424 * 3)	/* some unique value */
+
+static const struct qcom_icc_hws_data icc_ipq5424_cpu_l3[] = {
+	{ MASTER_CPU, SLAVE_L3, L3_CORE_CLK },
+};
+
+static const struct qcom_cc_desc apss_ipq5424_desc = {
+	.config = &apss_ipq5424_regmap_config,
+	.clks = apss_ipq5424_clks,
+	.num_clks = ARRAY_SIZE(apss_ipq5424_clks),
+	.icc_hws = icc_ipq5424_cpu_l3,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_cpu_l3),
+	.icc_first_node_id = IPQ_APPS_PLL_ID,
+	.driver_data = &ipa5424_apss_driver_data,
+};
+
+static int apss_ipq5424_probe(struct platform_device *pdev)
+{
+	return qcom_cc_probe(pdev, &apss_ipq5424_desc);
+}
+
+static const struct of_device_id apss_ipq5424_match_table[] = {
+	{ .compatible = "qcom,ipq5424-apss-clk" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apss_ipq5424_match_table);
+
+static struct platform_driver apss_ipq5424_driver = {
+	.probe = apss_ipq5424_probe,
+	.driver = {
+		.name   = "apss-ipq5424-clk",
+		.of_match_table = apss_ipq5424_match_table,
+		.sync_state = icc_sync_state,
+	},
+};
+
+module_platform_driver(apss_ipq5424_driver);
+
+MODULE_DESCRIPTION("QCOM APSS IPQ5424 CLK Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


