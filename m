Return-Path: <linux-pm+bounces-32143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A575B202DD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B8418886F0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520C2DFA5B;
	Mon, 11 Aug 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bzea65rA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826C2727F0;
	Mon, 11 Aug 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903428; cv=none; b=iMBRKhIfcO6vwbCyF8jyeciHIX2BTwAgJvSG6q9WswvIJAmOkNlyzQsOpeQaThNsxe8u1DGuK+yRP3CBSIbzkd0U9us+Kn5mLB9/M1VXiPXuCMX2mypXckjC7PnkAtV4Sekkq0hFd8FB+8bfv1HPFYfBOeudW0D7DKWx/5zRVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903428; c=relaxed/simple;
	bh=B2JEeA0vcOfx76r/CqnHy3ecfHY2HXFkM2KTgRWr4nY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjzHd8leMr+E6IcY/+XY4whTa7pmgRHIrEf9KoJ7yic6yd+mzBqlU4dBYSguxKnWA5tBbsLzljYhN5yShsa1taym9x/3BzVnphwz0fhzKigZOOPwc6ez62cXX+Uy07v7UpuiB2D/edS8nzScuV/6TE/q+wX+8sBpzoQGA4tR9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bzea65rA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ANpGah001291;
	Mon, 11 Aug 2025 09:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	geyy79TEZ/6FFFSgKGGgjB7jm5jHFM6jKkF8GGKl9Yc=; b=Bzea65rAXMPPkZAc
	jFW2hm3ryXF37ZaaaZqmQ/5jnLX2nBgHIRhIYCFaKOfdqKAc/Ui+tqyDYfzuMT0p
	wIwIyqwB3SDiUirpElJnyn6Il2PfSeMqOdfUkhC+TVqlKKeNxfuxdc/G7Ge2p8vG
	iCpnRKaCQiA/AqUSpm3XJRd7AaLZhkwjP6VeJdJBazN7/lMGYRS1aAyZ0JYHbXfl
	xPV5QE13c9oCY+GbAmquNtz+d/VB/2bcB32b4Esni0cOWu/oKdRW/s5YzqXgpLyL
	8zxuewhhALb5W0C8itI2ev7fnhxO46LfryrnEydwlwDzIra0CdyMA5OdObSudVBg
	DWBqdg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fkydv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:10:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57B9ALAY028703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:10:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 02:10:15 -0700
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
Subject: [PATCH v7 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
Date: Mon, 11 Aug 2025 14:39:52 +0530
Message-ID: <20250811090954.2854440-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811090954.2854440-1-quic_varada@quicinc.com>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: Qr61y-GPKUuzamaEYgpuQxvdfjp6xZUR
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899b37d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=3wzbhwVCPhbXVgx3a2MA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX0rWD0zOGg+sw
 R709px46HpUaah8njZnKMH+36TrjzgA/1/0tuWA86KtedANjXWVvKBS/hMc+Oe2x7KLt3QBnU5N
 ggVjqQngPHKWYPHBxUaX7UxvaYfcG2IeOX/Qsgm7M6bNUoJ0Oan9o8P/Ck099nrfQEX/WfcWPqs
 ykmlEaClFXOWaR4uDD7StUfCSbVTXP/KuvIac7E8jXPR9kEyZknhRWXJDgT8Nptj/rvukpo0sSc
 VYPg9BRm2Ob9E6y2Df3oEZMmqRMCGJ8IB9w8d90POYE9Hovb6ZXxWGFp9dhGawmDHt9qOwhujLP
 KaFDzoaJdkwEAXQciZYJepVHWIgKSU8FHve8a7wiwIA391C5bd4Pc1zSqjSMdXlvdimpxtoyUfs
 L//H4iYq
X-Proofpoint-ORIG-GUID: Qr61y-GPKUuzamaEYgpuQxvdfjp6xZUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

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
v7: Use index instead of clock-names in l3 pll
    Select IPQ_APSS_5424 if IPQ_GCC_5424 is enabled

v6: Drop all clock-names and use index instead
    Fix coding style issues

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
 drivers/clk/qcom/Kconfig        |   9 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/apss-ipq5424.c | 265 ++++++++++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6cb6cd3e1778..aeb6197d7c90 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -187,6 +187,15 @@ config IPQ_APSS_PLL
 	  Say Y if you want to support CPU frequency scaling on ipq based
 	  devices.
 
+config IPQ_APSS_5424
+	tristate "IPQ APSS Clock Controller"
+	select IPQ_APSS_PLL
+	default y if IPQ_GCC_5424
+	help
+	  Support for APSS Clock controller on Qualcom IPQ5424 platform.
+	  Say Y if you want to support CPU frequency scaling on ipq based
+	  devices.
+
 config IPQ_APSS_6018
 	tristate "IPQ APSS Clock Controller"
 	select IPQ_APSS_PLL
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
index 000000000000..4c67f722e009
--- /dev/null
+++ b/drivers/clk/qcom/apss-ipq5424.c
@@ -0,0 +1,265 @@
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
+	.clkr.hw.init = &(struct clk_init_data) {
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
+		.hw.init = &(struct clk_init_data) {
+			.name = "apss_silver_core_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&apss_silver_clk_src.clkr.hw
+			},
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
+		.hw.init = &(struct clk_init_data) {
+			.name = "l3_pll",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_XO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_huayra_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data parents_l3_clk_src[] = {
+	{ .index = DT_XO },
+	{ .index = DT_CLK_REF },
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
+	.clkr.hw.init = &(struct clk_init_data) {
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
+		.hw.init = &(struct clk_init_data) {
+			.name = "l3_clk",
+			.parent_hws = (const struct clk_hw *[]) {
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


