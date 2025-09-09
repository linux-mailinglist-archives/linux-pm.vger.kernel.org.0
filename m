Return-Path: <linux-pm+bounces-34269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B166B4FDFA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C674A543BF0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240C35A2AA;
	Tue,  9 Sep 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNZWMIes"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BA356916;
	Tue,  9 Sep 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425284; cv=none; b=MgJ6iMRqyE5Qm3X2ZqMnxBVkJSc9AtjiNwURiHwOQM6jDYAr0kurD4wE5495nOa4FZCkpDKm53klBGtNzvxvSfh7bSyZE9HKbHIwNRL4p7Kfjf8YQ0iEA96QKSr82G+XjuYxyUTNtguAM6bhpbXUIY4oUFS31/Chj5kx/sp1OdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425284; c=relaxed/simple;
	bh=lo9NHiGSqKEW0mN8oI/sXpmmiJfjM2PTqORGcY+WGck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L88QIjL1qLDiA+JQ0F9vaTfyPt8M+7No+6QZGv1IJDT10utzSSTsWl9Q8lE6EzdiLQln2y4cXABKd35sEvKSs0IAVPiX25arNmycHahiRixASBROLLOwbix9YjTuA5llPRraWAgyVhG3VJdsHyd4OmPGpcwoYrBoA9Df+L4kNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNZWMIes; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LUdZ020161;
	Tue, 9 Sep 2025 13:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s1LyuEpdmFydOeAah98JccCD5Cw8ugc//6QQWx4P0TU=; b=GNZWMIes77NCl2qF
	ypnafp6JLwvoQGnI4106CklYFlIRPL27Ednbqtrvt4RmtBwFoKxfXNg9dZfUa8i/
	KQXjps5SkZ38RYF4ebuD1P4aAE64cPf/OIMVsCzvQxMIDXw9XgN3CWE+rVuwTBnh
	BH4ibjTUQZUwGW9B7Pxj+PgrwqbuM/p16Wv9OYQd9rM62LsngGYqlk7aMMf+aGgQ
	DM1tNDUfqbQwQuWWvP2b/AHGS82BEuadzrw2hVqwyAg0umKaFtFRvWmCURzz4UaX
	nkAmQcV6ymPM+w1lD56WfbDdg9Ubpv5cJsTgjc5lT6V/oIS7JtmnfxnduLvcyn/n
	STynyg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc24d6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:41:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589Df4Hm026246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 13:41:04 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 9 Sep 2025 06:40:10 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 9 Sep 2025 21:39:17 +0800
Subject: [PATCH v5 08/10] clk: qcom: Add NSS clock controller driver for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-qcom_ipq5424_nsscc-v5-8-332c49a8512b@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
In-Reply-To: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757425161; l=41995;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=lo9NHiGSqKEW0mN8oI/sXpmmiJfjM2PTqORGcY+WGck=;
 b=QrPjBro9NzdjvM9gO2gQcZ0PJ7LqYe0LRnJ1jVSEPyyF5mK78UjztsiIR142q44OBnj6ZKDgy
 5gvyVRw+DC0DA847c45Kb12ny5L/N8caVq6Sfl499GT+L3BolaCKr4d
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c02e71 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Sasp3eNXiZpz1bw--mwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jaGKaPmX75uEjZEo8IsMCGNfj2qHtsUm
X-Proofpoint-GUID: jaGKaPmX75uEjZEo8IsMCGNfj2qHtsUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX9GNeVm9EeCLN
 1rROHLeCX17jKLCETMc0mdsSkWc+VZGrJgsTt+pcccAKu+/hqQZyq47luOwTInzAOvfXmjM14Z+
 q4mtXqtQEpwpTdw19/GdTDOESolsg+p23cwieVZMc74aR/GE9NblHJnPQmDtfRzl1VTDb/qQheN
 RDX6t2q9yFCYgG00sJ30LHW69cXOrS0uEFegraMAtWu/CxLdw5irQqDe3O1CXArD+Wxt9BR88NN
 k0i8tEc8kH5hXWJ6tPs55boHqE3kdpAYt3hgBIKCQBFrIL/hykKZxZ8xgMpcufvMYuGCGp0gAJy
 FIeWl9FCphX0ucfD+qglefMOuP0X6gFHFSCZb7gjPbjq7LN3X7+LhEaN9ohdrLwj2VdF9uhDHtC
 Kwc8TL1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

NSS (Network Subsystem) clock controller provides the clocks and resets
to the networking hardware blocks of the IPQ5424 SoC.

The icc-clk framework is used to enable NoC related clocks to create
paths so that the networking blocks can connect to these NoCs.

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/Kconfig         |   11 +
 drivers/clk/qcom/Makefile        |    1 +
 drivers/clk/qcom/nsscc-ipq5424.c | 1340 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1352 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index aeb6197d7c90..f6bd73613ebd 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -290,6 +290,17 @@ config IPQ_GCC_9574
 	  i2c, USB, SD/eMMC, etc. Select this for the root clock
 	  of ipq9574.
 
+config IPQ_NSSCC_5424
+	tristate "IPQ5424 NSS Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	depends on IPQ_GCC_5424
+	help
+	  Support for NSS clock controller on ipq5424 devices.
+	  NSSCC receives the clock sources from GCC, CMN PLL and UNIPHY (PCS).
+	  It in turn supplies the clocks and resets to the networking hardware.
+	  Say Y or M if you want to enable networking function on the
+	  IPQ5424 devices.
+
 config IPQ_NSSCC_9574
         tristate "IPQ9574 NSS Clock Controller"
         depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 98de55eb6402..8ee3d92a020d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
 obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
 obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
 obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
+obj-$(CONFIG_IPQ_NSSCC_5424) += nsscc-ipq5424.o
 obj-$(CONFIG_IPQ_NSSCC_9574)	+= nsscc-ipq9574.o
 obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
 obj-$(CONFIG_IPQ_NSSCC_QCA8K) += nsscc-qca8k.o
diff --git a/drivers/clk/qcom/nsscc-ipq5424.c b/drivers/clk/qcom/nsscc-ipq5424.c
new file mode 100644
index 000000000000..5893c7146180
--- /dev/null
+++ b/drivers/clk/qcom/nsscc-ipq5424.c
@@ -0,0 +1,1340 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/interconnect-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,ipq5424-nsscc.h>
+#include <dt-bindings/interconnect/qcom,ipq5424.h>
+#include <dt-bindings/reset/qcom,ipq5424-nsscc.h>
+
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "reset.h"
+
+/* Need to match the order of clocks in DT binding */
+enum {
+	DT_CMN_PLL_XO_CLK,
+	DT_CMN_PLL_NSS_300M_CLK,
+	DT_CMN_PLL_NSS_375M_CLK,
+	DT_GCC_GPLL0_OUT_AUX,
+	DT_UNIPHY0_NSS_RX_CLK,
+	DT_UNIPHY0_NSS_TX_CLK,
+	DT_UNIPHY1_NSS_RX_CLK,
+	DT_UNIPHY1_NSS_TX_CLK,
+	DT_UNIPHY2_NSS_RX_CLK,
+	DT_UNIPHY2_NSS_TX_CLK,
+};
+
+enum {
+	P_CMN_PLL_XO_CLK,
+	P_CMN_PLL_NSS_300M_CLK,
+	P_CMN_PLL_NSS_375M_CLK,
+	P_GCC_GPLL0_OUT_AUX,
+	P_UNIPHY0_NSS_RX_CLK,
+	P_UNIPHY0_NSS_TX_CLK,
+	P_UNIPHY1_NSS_RX_CLK,
+	P_UNIPHY1_NSS_TX_CLK,
+	P_UNIPHY2_NSS_RX_CLK,
+	P_UNIPHY2_NSS_TX_CLK,
+};
+
+static const struct parent_map nss_cc_parent_map_0[] = {
+	{ P_CMN_PLL_XO_CLK, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_CMN_PLL_NSS_300M_CLK, 5 },
+	{ P_CMN_PLL_NSS_375M_CLK, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_0[] = {
+	{ .index = DT_CMN_PLL_XO_CLK },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_CMN_PLL_NSS_300M_CLK },
+	{ .index = DT_CMN_PLL_NSS_375M_CLK },
+};
+
+static const struct parent_map nss_cc_parent_map_1[] = {
+	{ P_CMN_PLL_XO_CLK, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_UNIPHY0_NSS_RX_CLK, 3 },
+	{ P_UNIPHY0_NSS_TX_CLK, 4 },
+	{ P_CMN_PLL_NSS_300M_CLK, 5 },
+	{ P_CMN_PLL_NSS_375M_CLK, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_1[] = {
+	{ .index = DT_CMN_PLL_XO_CLK },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_UNIPHY0_NSS_RX_CLK },
+	{ .index = DT_UNIPHY0_NSS_TX_CLK },
+	{ .index = DT_CMN_PLL_NSS_300M_CLK },
+	{ .index = DT_CMN_PLL_NSS_375M_CLK },
+};
+
+static const struct parent_map nss_cc_parent_map_2[] = {
+	{ P_CMN_PLL_XO_CLK, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_UNIPHY1_NSS_RX_CLK, 3 },
+	{ P_UNIPHY1_NSS_TX_CLK, 4 },
+	{ P_CMN_PLL_NSS_300M_CLK, 5 },
+	{ P_CMN_PLL_NSS_375M_CLK, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_2[] = {
+	{ .index = DT_CMN_PLL_XO_CLK },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_UNIPHY1_NSS_RX_CLK },
+	{ .index = DT_UNIPHY1_NSS_TX_CLK },
+	{ .index = DT_CMN_PLL_NSS_300M_CLK },
+	{ .index = DT_CMN_PLL_NSS_375M_CLK },
+};
+
+static const struct parent_map nss_cc_parent_map_3[] = {
+	{ P_CMN_PLL_XO_CLK, 0 },
+	{ P_GCC_GPLL0_OUT_AUX, 2 },
+	{ P_UNIPHY2_NSS_RX_CLK, 3 },
+	{ P_UNIPHY2_NSS_TX_CLK, 4 },
+	{ P_CMN_PLL_NSS_300M_CLK, 5 },
+	{ P_CMN_PLL_NSS_375M_CLK, 6 },
+};
+
+static const struct clk_parent_data nss_cc_parent_data_3[] = {
+	{ .index = DT_CMN_PLL_XO_CLK },
+	{ .index = DT_GCC_GPLL0_OUT_AUX },
+	{ .index = DT_UNIPHY2_NSS_RX_CLK },
+	{ .index = DT_UNIPHY2_NSS_TX_CLK },
+	{ .index = DT_CMN_PLL_NSS_300M_CLK },
+	{ .index = DT_CMN_PLL_NSS_375M_CLK },
+};
+
+static const struct freq_tbl ftbl_nss_cc_ce_clk_src[] = {
+	F(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	F(375000000, P_CMN_PLL_NSS_375M_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_ce_clk_src = {
+	.cmd_rcgr = 0x5e0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_ce_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_ce_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_nss_cc_cfg_clk_src[] = {
+	F(100000000, P_GCC_GPLL0_OUT_AUX, 8, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_cfg_clk_src = {
+	.cmd_rcgr = 0x6a8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_cfg_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_cfg_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_nss_cc_eip_bfdcd_clk_src[] = {
+	F(300000000, P_CMN_PLL_NSS_300M_CLK, 1, 0, 0),
+	F(375000000, P_CMN_PLL_NSS_375M_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_eip_bfdcd_clk_src = {
+	.cmd_rcgr = 0x644,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_eip_bfdcd_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_eip_bfdcd_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
+	FMS(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port1_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY0_NSS_RX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port1_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port1_rx_clk_src = {
+	.cmd_rcgr = 0x4b4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_1,
+	.freq_multi_tbl = ftbl_nss_cc_port1_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port1_rx_clk_src",
+		.parent_data = nss_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_1),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port1_tx_clk_src[] = {
+	FMS(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port1_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY0_NSS_TX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port1_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port1_tx_clk_src = {
+	.cmd_rcgr = 0x4c0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_1,
+	.freq_multi_tbl = ftbl_nss_cc_port1_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port1_tx_clk_src",
+		.parent_data = nss_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_1),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_rx_clk_src_25[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY1_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_rx_clk_src_125[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY1_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port2_rx_clk_src[] = {
+	FMS(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port2_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_NSS_RX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port2_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port2_rx_clk_src = {
+	.cmd_rcgr = 0x4cc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_2,
+	.freq_multi_tbl = ftbl_nss_cc_port2_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port2_rx_clk_src",
+		.parent_data = nss_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_2),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_tx_clk_src_25[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY1_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port2_tx_clk_src_125[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY1_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port2_tx_clk_src[] = {
+	FMS(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port2_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY1_NSS_TX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port2_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY1_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port2_tx_clk_src = {
+	.cmd_rcgr = 0x4d8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_2,
+	.freq_multi_tbl = ftbl_nss_cc_port2_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port2_tx_clk_src",
+		.parent_data = nss_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_2),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port3_rx_clk_src_25[] = {
+	C(P_UNIPHY2_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY2_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port3_rx_clk_src_125[] = {
+	C(P_UNIPHY2_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY2_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port3_rx_clk_src[] = {
+	FMS(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port3_rx_clk_src_25),
+	FMS(78125000, P_UNIPHY2_NSS_RX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port3_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port3_rx_clk_src = {
+	.cmd_rcgr = 0x4e4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_3,
+	.freq_multi_tbl = ftbl_nss_cc_port3_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port3_rx_clk_src",
+		.parent_data = nss_cc_parent_data_3,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_3),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port3_tx_clk_src_25[] = {
+	C(P_UNIPHY2_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY2_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port3_tx_clk_src_125[] = {
+	C(P_UNIPHY2_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY2_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port3_tx_clk_src[] = {
+	FMS(24000000, P_CMN_PLL_XO_CLK, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port3_tx_clk_src_25),
+	FMS(78125000, P_UNIPHY2_NSS_TX_CLK, 4, 0, 0),
+	FM(125000000, ftbl_nss_cc_port3_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port3_tx_clk_src = {
+	.cmd_rcgr = 0x4f0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_3,
+	.freq_multi_tbl = ftbl_nss_cc_port3_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port3_tx_clk_src",
+		.parent_data = nss_cc_parent_data_3,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_3),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_rcg2 nss_cc_ppe_clk_src = {
+	.cmd_rcgr = 0x3ec,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_0,
+	.freq_tbl = ftbl_nss_cc_ce_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_ppe_clk_src",
+		.parent_data = nss_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(nss_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port1_rx_div_clk_src = {
+	.reg = 0x4bc,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port1_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port1_tx_div_clk_src = {
+	.reg = 0x4c8,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port1_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port2_rx_div_clk_src = {
+	.reg = 0x4d4,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port2_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port2_tx_div_clk_src = {
+	.reg = 0x4e0,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port2_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port3_rx_div_clk_src = {
+	.reg = 0x4ec,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port3_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port3_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port3_tx_div_clk_src = {
+	.reg = 0x4f8,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port3_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port3_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac0_ptp_ref_div_clk_src = {
+	.reg = 0x3f4,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac0_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac1_ptp_ref_div_clk_src = {
+	.reg = 0x3f8,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac1_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac2_ptp_ref_div_clk_src = {
+	.reg = 0x3fc,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac2_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch nss_cc_ce_apb_clk = {
+	.halt_reg = 0x5e8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ce_apb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ce_axi_clk = {
+	.halt_reg = 0x5ec,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5ec,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ce_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_debug_clk = {
+	.halt_reg = 0x70c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x70c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_debug_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_eip_clk = {
+	.halt_reg = 0x658,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x658,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_eip_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_eip_bfdcd_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nss_csr_clk = {
+	.halt_reg = 0x6b0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6b0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nss_csr_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_cfg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ce_apb_clk = {
+	.halt_reg = 0x5f4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5f4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_ce_apb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ce_axi_clk = {
+	.halt_reg = 0x5f8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5f8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_ce_axi_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ce_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_eip_clk = {
+	.halt_reg = 0x660,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x660,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_eip_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_eip_bfdcd_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_nss_csr_clk = {
+	.halt_reg = 0x6b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_nss_csr_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_cfg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ppe_cfg_clk = {
+	.halt_reg = 0x444,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x444,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_ppe_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ppe_clk = {
+	.halt_reg = 0x440,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x440,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_ppe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_mac_clk = {
+	.halt_reg = 0x428,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x428,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port1_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_rx_clk = {
+	.halt_reg = 0x4fc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4fc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port1_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_tx_clk = {
+	.halt_reg = 0x504,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x504,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port1_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_mac_clk = {
+	.halt_reg = 0x430,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x430,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port2_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_rx_clk = {
+	.halt_reg = 0x50c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x50c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port2_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_tx_clk = {
+	.halt_reg = 0x514,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x514,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port2_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port3_mac_clk = {
+	.halt_reg = 0x438,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x438,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port3_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port3_rx_clk = {
+	.halt_reg = 0x51c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x51c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port3_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port3_tx_clk = {
+	.halt_reg = 0x524,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x524,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port3_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_edma_cfg_clk = {
+	.halt_reg = 0x424,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x424,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_edma_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_edma_clk = {
+	.halt_reg = 0x41c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x41c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_edma_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_btq_clk = {
+	.halt_reg = 0x408,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x408,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_btq_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_cfg_clk = {
+	.halt_reg = 0x418,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x418,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_clk = {
+	.halt_reg = 0x410,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x410,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_ipe_clk = {
+	.halt_reg = 0x400,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x400,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_ipe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_rx_clk = {
+	.halt_reg = 0x57c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x57c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port1_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_tx_clk = {
+	.halt_reg = 0x580,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x580,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port1_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_rx_clk = {
+	.halt_reg = 0x584,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x584,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port2_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_tx_clk = {
+	.halt_reg = 0x588,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x588,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port2_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port3_rx_clk = {
+	.halt_reg = 0x58c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x58c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port3_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port3_tx_clk = {
+	.halt_reg = 0x590,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x590,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port3_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac0_ptp_ref_clk = {
+	.halt_reg = 0x448,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x448,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_xgmac0_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_xgmac0_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac1_ptp_ref_clk = {
+	.halt_reg = 0x44c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x44c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_xgmac1_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_xgmac1_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac2_ptp_ref_clk = {
+	.halt_reg = 0x450,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x450,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_xgmac2_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_xgmac2_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *nss_cc_ipq5424_clocks[] = {
+	[NSS_CC_CE_APB_CLK] = &nss_cc_ce_apb_clk.clkr,
+	[NSS_CC_CE_AXI_CLK] = &nss_cc_ce_axi_clk.clkr,
+	[NSS_CC_CE_CLK_SRC] = &nss_cc_ce_clk_src.clkr,
+	[NSS_CC_CFG_CLK_SRC] = &nss_cc_cfg_clk_src.clkr,
+	[NSS_CC_DEBUG_CLK] = &nss_cc_debug_clk.clkr,
+	[NSS_CC_EIP_BFDCD_CLK_SRC] = &nss_cc_eip_bfdcd_clk_src.clkr,
+	[NSS_CC_EIP_CLK] = &nss_cc_eip_clk.clkr,
+	[NSS_CC_NSS_CSR_CLK] = &nss_cc_nss_csr_clk.clkr,
+	[NSS_CC_NSSNOC_CE_APB_CLK] = &nss_cc_nssnoc_ce_apb_clk.clkr,
+	[NSS_CC_NSSNOC_CE_AXI_CLK] = &nss_cc_nssnoc_ce_axi_clk.clkr,
+	[NSS_CC_NSSNOC_EIP_CLK] = &nss_cc_nssnoc_eip_clk.clkr,
+	[NSS_CC_NSSNOC_NSS_CSR_CLK] = &nss_cc_nssnoc_nss_csr_clk.clkr,
+	[NSS_CC_NSSNOC_PPE_CFG_CLK] = &nss_cc_nssnoc_ppe_cfg_clk.clkr,
+	[NSS_CC_NSSNOC_PPE_CLK] = &nss_cc_nssnoc_ppe_clk.clkr,
+	[NSS_CC_PORT1_MAC_CLK] = &nss_cc_port1_mac_clk.clkr,
+	[NSS_CC_PORT1_RX_CLK] = &nss_cc_port1_rx_clk.clkr,
+	[NSS_CC_PORT1_RX_CLK_SRC] = &nss_cc_port1_rx_clk_src.clkr,
+	[NSS_CC_PORT1_RX_DIV_CLK_SRC] = &nss_cc_port1_rx_div_clk_src.clkr,
+	[NSS_CC_PORT1_TX_CLK] = &nss_cc_port1_tx_clk.clkr,
+	[NSS_CC_PORT1_TX_CLK_SRC] = &nss_cc_port1_tx_clk_src.clkr,
+	[NSS_CC_PORT1_TX_DIV_CLK_SRC] = &nss_cc_port1_tx_div_clk_src.clkr,
+	[NSS_CC_PORT2_MAC_CLK] = &nss_cc_port2_mac_clk.clkr,
+	[NSS_CC_PORT2_RX_CLK] = &nss_cc_port2_rx_clk.clkr,
+	[NSS_CC_PORT2_RX_CLK_SRC] = &nss_cc_port2_rx_clk_src.clkr,
+	[NSS_CC_PORT2_RX_DIV_CLK_SRC] = &nss_cc_port2_rx_div_clk_src.clkr,
+	[NSS_CC_PORT2_TX_CLK] = &nss_cc_port2_tx_clk.clkr,
+	[NSS_CC_PORT2_TX_CLK_SRC] = &nss_cc_port2_tx_clk_src.clkr,
+	[NSS_CC_PORT2_TX_DIV_CLK_SRC] = &nss_cc_port2_tx_div_clk_src.clkr,
+	[NSS_CC_PORT3_MAC_CLK] = &nss_cc_port3_mac_clk.clkr,
+	[NSS_CC_PORT3_RX_CLK] = &nss_cc_port3_rx_clk.clkr,
+	[NSS_CC_PORT3_RX_CLK_SRC] = &nss_cc_port3_rx_clk_src.clkr,
+	[NSS_CC_PORT3_RX_DIV_CLK_SRC] = &nss_cc_port3_rx_div_clk_src.clkr,
+	[NSS_CC_PORT3_TX_CLK] = &nss_cc_port3_tx_clk.clkr,
+	[NSS_CC_PORT3_TX_CLK_SRC] = &nss_cc_port3_tx_clk_src.clkr,
+	[NSS_CC_PORT3_TX_DIV_CLK_SRC] = &nss_cc_port3_tx_div_clk_src.clkr,
+	[NSS_CC_PPE_CLK_SRC] = &nss_cc_ppe_clk_src.clkr,
+	[NSS_CC_PPE_EDMA_CFG_CLK] = &nss_cc_ppe_edma_cfg_clk.clkr,
+	[NSS_CC_PPE_EDMA_CLK] = &nss_cc_ppe_edma_clk.clkr,
+	[NSS_CC_PPE_SWITCH_BTQ_CLK] = &nss_cc_ppe_switch_btq_clk.clkr,
+	[NSS_CC_PPE_SWITCH_CFG_CLK] = &nss_cc_ppe_switch_cfg_clk.clkr,
+	[NSS_CC_PPE_SWITCH_CLK] = &nss_cc_ppe_switch_clk.clkr,
+	[NSS_CC_PPE_SWITCH_IPE_CLK] = &nss_cc_ppe_switch_ipe_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_RX_CLK] = &nss_cc_uniphy_port1_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_TX_CLK] = &nss_cc_uniphy_port1_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_RX_CLK] = &nss_cc_uniphy_port2_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_TX_CLK] = &nss_cc_uniphy_port2_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT3_RX_CLK] = &nss_cc_uniphy_port3_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT3_TX_CLK] = &nss_cc_uniphy_port3_tx_clk.clkr,
+	[NSS_CC_XGMAC0_PTP_REF_CLK] = &nss_cc_xgmac0_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac0_ptp_ref_div_clk_src.clkr,
+	[NSS_CC_XGMAC1_PTP_REF_CLK] = &nss_cc_xgmac1_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac1_ptp_ref_div_clk_src.clkr,
+	[NSS_CC_XGMAC2_PTP_REF_CLK] = &nss_cc_xgmac2_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac2_ptp_ref_div_clk_src.clkr,
+};
+
+static const struct qcom_reset_map nss_cc_ipq5424_resets[] = {
+	[NSS_CC_CE_APB_CLK_ARES] = { 0x5e8, 2 },
+	[NSS_CC_CE_AXI_CLK_ARES] = { 0x5ec, 2 },
+	[NSS_CC_DEBUG_CLK_ARES] = { 0x70c, 2 },
+	[NSS_CC_EIP_CLK_ARES] = { 0x658, 2 },
+	[NSS_CC_NSS_CSR_CLK_ARES] = { 0x6b0, 2 },
+	[NSS_CC_NSSNOC_CE_APB_CLK_ARES] = { 0x5f4, 2 },
+	[NSS_CC_NSSNOC_CE_AXI_CLK_ARES] = { 0x5f8, 2 },
+	[NSS_CC_NSSNOC_EIP_CLK_ARES] = { 0x660, 2 },
+	[NSS_CC_NSSNOC_NSS_CSR_CLK_ARES] = { 0x6b4, 2 },
+	[NSS_CC_NSSNOC_PPE_CLK_ARES] = { 0x440, 2 },
+	[NSS_CC_NSSNOC_PPE_CFG_CLK_ARES] = { 0x444, 2 },
+	[NSS_CC_PORT1_MAC_CLK_ARES] = { 0x428, 2 },
+	[NSS_CC_PORT1_RX_CLK_ARES] = { 0x4fc, 2 },
+	[NSS_CC_PORT1_TX_CLK_ARES] = { 0x504, 2 },
+	[NSS_CC_PORT2_MAC_CLK_ARES] = { 0x430, 2 },
+	[NSS_CC_PORT2_RX_CLK_ARES] = { 0x50c, 2 },
+	[NSS_CC_PORT2_TX_CLK_ARES] = { 0x514, 2 },
+	[NSS_CC_PORT3_MAC_CLK_ARES] = { 0x438, 2 },
+	[NSS_CC_PORT3_RX_CLK_ARES] = { 0x51c, 2 },
+	[NSS_CC_PORT3_TX_CLK_ARES] = { 0x524, 2 },
+	[NSS_CC_PPE_BCR] = { 0x3e8 },
+	[NSS_CC_PPE_EDMA_CLK_ARES] = { 0x41c, 2 },
+	[NSS_CC_PPE_EDMA_CFG_CLK_ARES] = { 0x424, 2 },
+	[NSS_CC_PPE_SWITCH_BTQ_CLK_ARES] = { 0x408, 2 },
+	[NSS_CC_PPE_SWITCH_CLK_ARES] = { 0x410, 2 },
+	[NSS_CC_PPE_SWITCH_CFG_CLK_ARES] = { 0x418, 2 },
+	[NSS_CC_PPE_SWITCH_IPE_CLK_ARES] = { 0x400, 2 },
+	[NSS_CC_UNIPHY_PORT1_RX_CLK_ARES] = { 0x57c, 2 },
+	[NSS_CC_UNIPHY_PORT1_TX_CLK_ARES] = { 0x580, 2 },
+	[NSS_CC_UNIPHY_PORT2_RX_CLK_ARES] = { 0x584, 2 },
+	[NSS_CC_UNIPHY_PORT2_TX_CLK_ARES] = { 0x588, 2 },
+	[NSS_CC_UNIPHY_PORT3_RX_CLK_ARES] = { 0x58c, 2 },
+	[NSS_CC_UNIPHY_PORT3_TX_CLK_ARES] = { 0x590, 2 },
+	[NSS_CC_XGMAC0_PTP_REF_CLK_ARES] = { 0x448, 2 },
+	[NSS_CC_XGMAC1_PTP_REF_CLK_ARES] = { 0x44c, 2 },
+	[NSS_CC_XGMAC2_PTP_REF_CLK_ARES] = { 0x450, 2 },
+};
+
+static const struct regmap_config nss_cc_ipq5424_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x800,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_hws_data icc_ipq5424_nss_hws[] = {
+	{ MASTER_NSSNOC_PPE, SLAVE_NSSNOC_PPE, NSS_CC_NSSNOC_PPE_CLK },
+	{ MASTER_NSSNOC_PPE_CFG, SLAVE_NSSNOC_PPE_CFG, NSS_CC_NSSNOC_PPE_CFG_CLK },
+	{ MASTER_NSSNOC_NSS_CSR, SLAVE_NSSNOC_NSS_CSR, NSS_CC_NSSNOC_NSS_CSR_CLK },
+	{ MASTER_NSSNOC_CE_AXI, SLAVE_NSSNOC_CE_AXI, NSS_CC_NSSNOC_CE_AXI_CLK},
+	{ MASTER_NSSNOC_CE_APB, SLAVE_NSSNOC_CE_APB, NSS_CC_NSSNOC_CE_APB_CLK},
+	{ MASTER_NSSNOC_EIP, SLAVE_NSSNOC_EIP, NSS_CC_NSSNOC_EIP_CLK},
+};
+
+#define IPQ_NSSCC_ID	(5424 * 2) /* some unique value */
+
+static const struct qcom_cc_desc nss_cc_ipq5424_desc = {
+	.config = &nss_cc_ipq5424_regmap_config,
+	.clks = nss_cc_ipq5424_clocks,
+	.num_clks = ARRAY_SIZE(nss_cc_ipq5424_clocks),
+	.resets = nss_cc_ipq5424_resets,
+	.num_resets = ARRAY_SIZE(nss_cc_ipq5424_resets),
+	.icc_hws = icc_ipq5424_nss_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5424_nss_hws),
+	.icc_first_node_id = IPQ_NSSCC_ID,
+};
+
+static const struct dev_pm_ops nss_cc_ipq5424_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+};
+
+static const struct of_device_id nss_cc_ipq5424_match_table[] = {
+	{ .compatible = "qcom,ipq5424-nsscc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nss_cc_ipq5424_match_table);
+
+static int nss_cc_ipq5424_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to enable runtime PM\n");
+
+	ret = devm_pm_clk_create(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to create PM clock\n");
+
+	ret = pm_clk_add(&pdev->dev, "bus");
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to add bus clock\n");
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to resume\n");
+
+	ret = qcom_cc_probe(pdev, &nss_cc_ipq5424_desc);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
+}
+
+static struct platform_driver nss_cc_ipq5424_driver = {
+	.probe = nss_cc_ipq5424_probe,
+	.driver = {
+		.name = "qcom,ipq5424-nsscc",
+		.of_match_table = nss_cc_ipq5424_match_table,
+		.pm = &nss_cc_ipq5424_pm_ops,
+		.sync_state = icc_sync_state,
+	},
+};
+module_platform_driver(nss_cc_ipq5424_driver);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. NSSCC IPQ5424 Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


