Return-Path: <linux-pm+bounces-14617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3869847D8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CA5284EDF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6661AB6D1;
	Tue, 24 Sep 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RLSZMn9Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CA1AB519;
	Tue, 24 Sep 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188843; cv=none; b=kOww4ueJQ4iH3G4S4gelgRBBpm4tEMMj8g5dXP8dX8Dg5oseZUWynqENqMtOjfON/JUsZf7ckz8qoRbRnsRli0B2tspk2JwCeYwtAaVVMKjV8/Zfn2raS+L+iQAjRBquOKvhl3rxhLP15cIkQKk2h1Rwheg6xIR7v7zaUSOl5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188843; c=relaxed/simple;
	bh=rDwv/8M2cUqvwpnkL6B67KVCcLP8GDMCpG68Bz4gzKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=id6t4kZavrq6fWXEHX6yFbWTZ1CD+ApAGxLOo0M48emkOJv1EvaIr9M3FfIyW4y9c8D3zuyUWIr9W5E/m10u2xK4o3RUv4tMGxVwY8Wj7PSOhvBGPsVYwgVh0W3glC4t1WpPZvQuwzRtun/VH0OJIYQiH8LwSwdhM/voOPXKFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RLSZMn9Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8rdd6001943;
	Tue, 24 Sep 2024 14:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	70s9U/8GTss5uWEgYvHTZh6tCpzfYaADx5Evezat1z0=; b=RLSZMn9YpuPlJw1c
	uOvaKsNuLslN0RoG5KuwrjQ16MdRuJ7j7G+5gCcAhxxl/ay0YiGGdYLjKKOocEFd
	LwqQ9Ck+p/MpdYhONxmArlfOriGUj0J4LobYgz4lL8Ffwc1gVl78HME/zkRH5XfM
	lUMfcerjt81N1QoG2lDKdXhT8kOu3xSWWwsln+HjSjMUAYiZMyB63CWB55rXk4iK
	hnTt/LkLKtrdjGcZOcwmCbYMAZDbxXrVM0IwxrFadLMOtMnn8ra5KCRbARoZTtqM
	mq2BUShaswPrNqzlXQdP+QP3SdaqdF5MgTRzBmHYtSWzG6vTfmivsZuMuP3QYnhF
	ym7y4w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuervfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 14:40:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OEeTiC001755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 14:40:29 GMT
Received: from e20994d1867b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 07:40:23 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Adam Skladowski
	<a39.skl@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] interconnect: qcom: add QCS615 interconnect provider driver
Date: Tue, 24 Sep 2024 14:39:58 +0000
Message-ID: <20240924143958.25-3-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240924143958.25-1-quic_rlaggysh@quicinc.com>
References: <20240924143958.25-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DiTCHZjoQfMeJlbKMYC4m_29NBWDOnFv
X-Proofpoint-ORIG-GUID: DiTCHZjoQfMeJlbKMYC4m_29NBWDOnFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240104

Add driver for the Qualcomm interconnect buses found in QCS615
based platforms. The topology consists of several NoCs that are
controlled by a remote processor that collects the aggregated
bandwidth for each master-slave pairs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/qcs615.c | 1563 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/qcs615.h |  128 +++
 4 files changed, 1702 insertions(+)
 create mode 100644 drivers/interconnect/qcom/qcs615.c
 create mode 100644 drivers/interconnect/qcom/qcs615.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index de96d4661340..0f25ca4f77bf 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -105,6 +105,15 @@ config INTERCONNECT_QCOM_QCS404
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
 
+config INTERCONNECT_QCOM_QCS615
+	tristate "Qualcomm QCS615 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on qcs615-based
+	  platforms.
+
 config INTERCONNECT_QCOM_QDU1000
 	tristate "Qualcomm QDU1000/QRU1000 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index bfeea8416fcf..d3849265d45c 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -15,6 +15,7 @@ qnoc-msm8996-objs			:= msm8996.o
 icc-osm-l3-objs				:= osm-l3.o
 qnoc-qcm2290-objs			:= qcm2290.o
 qnoc-qcs404-objs			:= qcs404.o
+qnoc-qcs615-objs			:= qcs615.o
 qnoc-qdu1000-objs			:= qdu1000.o
 icc-rpmh-obj				:= icc-rpmh.o
 qnoc-sa8775p-objs			:= sa8775p.o
@@ -52,6 +53,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
 obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
+obj-$(CONFIG_INTERCONNECT_QCOM_QCS615) += qnoc-qcs615.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QDU1000) += qnoc-qdu1000.o
 obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SA8775P) += qnoc-sa8775p.o
diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
new file mode 100644
index 000000000000..7e59e91ce886
--- /dev/null
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -0,0 +1,1563 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "qcs615.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = QCS615_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = QCS615_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = QCS615_MASTER_QSPI,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = QCS615_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = QCS615_MASTER_BLSP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = QCS615_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = QCS615_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = QCS615_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_LPASS_SNOC },
+};
+
+static struct qcom_icc_node xm_emac_avb = {
+	.name = "xm_emac_avb",
+	.id = QCS615_MASTER_EMAC_EVB,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_pcie = {
+	.name = "xm_pcie",
+	.id = QCS615_MASTER_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_ANOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = QCS615_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = QCS615_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = QCS615_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = QCS615_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb2 = {
+	.name = "xm_usb2",
+	.id = QCS615_MASTER_USB2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = QCS615_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
+	.name = "qxm_camnoc_hf0_uncomp",
+	.id = QCS615_MASTER_CAMNOC_HF0_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
+	.name = "qxm_camnoc_hf1_uncomp",
+	.id = QCS615_MASTER_CAMNOC_HF1_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
+	.name = "qxm_camnoc_sf_uncomp",
+	.id = QCS615_MASTER_CAMNOC_SF_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+};
+
+static struct qcom_icc_node qhm_spdm = {
+	.name = "qhm_spdm",
+	.id = QCS615_MASTER_SPDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = QCS615_MASTER_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 39,
+	.links = { QCS615_SLAVE_A1NOC_CFG, QCS615_SLAVE_AHB2PHY_EAST,
+		   QCS615_SLAVE_AHB2PHY_WEST, QCS615_SLAVE_AOP,
+		   QCS615_SLAVE_AOSS, QCS615_SLAVE_CAMERA_CFG,
+		   QCS615_SLAVE_CLK_CTL, QCS615_SLAVE_RBCPR_CX_CFG,
+		   QCS615_SLAVE_RBCPR_MX_CFG, QCS615_SLAVE_CRYPTO_0_CFG,
+		   QCS615_SLAVE_CNOC_DDRSS, QCS615_SLAVE_DISPLAY_CFG,
+		   QCS615_SLAVE_EMAC_AVB_CFG, QCS615_SLAVE_GLM,
+		   QCS615_SLAVE_GFX3D_CFG, QCS615_SLAVE_IMEM_CFG,
+		   QCS615_SLAVE_IPA_CFG, QCS615_SLAVE_CNOC_MNOC_CFG,
+		   QCS615_SLAVE_PCIE_CFG, QCS615_SLAVE_PIMEM_CFG,
+		   QCS615_SLAVE_PRNG, QCS615_SLAVE_QDSS_CFG,
+		   QCS615_SLAVE_QSPI, QCS615_SLAVE_QUP_0,
+		   QCS615_SLAVE_QUP_1, QCS615_SLAVE_SDCC_1,
+		   QCS615_SLAVE_SDCC_2, QCS615_SLAVE_SNOC_CFG,
+		   QCS615_SLAVE_SPDM_WRAPPER, QCS615_SLAVE_TCSR,
+		   QCS615_SLAVE_TLMM_EAST, QCS615_SLAVE_TLMM_SOUTH,
+		   QCS615_SLAVE_TLMM_WEST, QCS615_SLAVE_UFS_MEM_CFG,
+		   QCS615_SLAVE_USB2, QCS615_SLAVE_USB3,
+		   QCS615_SLAVE_VENUS_CFG, QCS615_SLAVE_VSENSE_CTRL_CFG,
+		   QCS615_SLAVE_SERVICE_CNOC },
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = QCS615_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 40,
+	.links = { QCS615_SLAVE_A1NOC_CFG, QCS615_SLAVE_AHB2PHY_EAST,
+		   QCS615_SLAVE_AHB2PHY_WEST, QCS615_SLAVE_AOP,
+		   QCS615_SLAVE_AOSS, QCS615_SLAVE_CAMERA_CFG,
+		   QCS615_SLAVE_CLK_CTL, QCS615_SLAVE_RBCPR_CX_CFG,
+		   QCS615_SLAVE_RBCPR_MX_CFG, QCS615_SLAVE_CRYPTO_0_CFG,
+		   QCS615_SLAVE_CNOC_DDRSS, QCS615_SLAVE_DISPLAY_CFG,
+		   QCS615_SLAVE_EMAC_AVB_CFG, QCS615_SLAVE_GLM,
+		   QCS615_SLAVE_GFX3D_CFG, QCS615_SLAVE_IMEM_CFG,
+		   QCS615_SLAVE_IPA_CFG, QCS615_SLAVE_CNOC_MNOC_CFG,
+		   QCS615_SLAVE_PCIE_CFG, QCS615_SLAVE_PIMEM_CFG,
+		   QCS615_SLAVE_PRNG, QCS615_SLAVE_QDSS_CFG,
+		   QCS615_SLAVE_QSPI, QCS615_SLAVE_QUP_0,
+		   QCS615_SLAVE_QUP_1, QCS615_SLAVE_SDCC_1,
+		   QCS615_SLAVE_SDCC_2, QCS615_SLAVE_SNOC_CFG,
+		   QCS615_SLAVE_SPDM_WRAPPER, QCS615_SLAVE_TCSR,
+		   QCS615_SLAVE_TLMM_EAST, QCS615_SLAVE_TLMM_SOUTH,
+		   QCS615_SLAVE_TLMM_WEST, QCS615_SLAVE_UFS_MEM_CFG,
+		   QCS615_SLAVE_USB2, QCS615_SLAVE_USB3,
+		   QCS615_SLAVE_VENUS_CFG, QCS615_SLAVE_VSENSE_CTRL_CFG,
+		   QCS615_SLAVE_CNOC_A2NOC, QCS615_SLAVE_SERVICE_CNOC },
+};
+
+static struct qcom_icc_node qhm_cnoc = {
+	.name = "qhm_cnoc",
+	.id = QCS615_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_DC_NOC_GEMNOC, QCS615_SLAVE_LLCC_CFG },
+};
+
+static struct qcom_icc_node acm_apps = {
+	.name = "acm_apps",
+	.id = QCS615_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC,
+		   QCS615_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node acm_gpu_tcu = {
+	.name = "acm_gpu_tcu",
+	.id = QCS615_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node acm_sys_tcu = {
+	.name = "acm_sys_tcu",
+	.id = QCS615_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg = {
+	.name = "qhm_gemnoc_cfg",
+	.id = QCS615_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_MSS_PROC_MS_MPU_CFG, QCS615_SLAVE_SERVICE_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = QCS615_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = QCS615_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = QCS615_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = QCS615_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = QCS615_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node ipa_core_master = {
+	.name = "ipa_core_master",
+	.id = QCS615_MASTER_IPA_CORE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_IPA_CORE },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = QCS615_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = QCS615_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf0 = {
+	.name = "qxm_camnoc_hf0",
+	.id = QCS615_MASTER_CAMNOC_HF0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_hf1 = {
+	.name = "qxm_camnoc_hf1",
+	.id = QCS615_MASTER_CAMNOC_HF1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_camnoc_sf = {
+	.name = "qxm_camnoc_sf",
+	.id = QCS615_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = QCS615_MASTER_MDP0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = QCS615_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus0 = {
+	.name = "qxm_venus0",
+	.id = QCS615_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_venus_arm9 = {
+	.name = "qxm_venus_arm9",
+	.id = QCS615_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = QCS615_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = QCS615_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 8,
+	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
+		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
+		   QCS615_SLAVE_PIMEM, QCS615_SLAVE_PCIE_0,
+		   QCS615_SLAVE_QDSS_STM, QCS615_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc = {
+	.name = "qnm_gemnoc",
+	.id = QCS615_MASTER_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 6,
+	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
+		   QCS615_SLAVE_IMEM, QCS615_SLAVE_PIMEM,
+		   QCS615_SLAVE_QDSS_STM, QCS615_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = QCS615_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node qnm_lpass_anoc = {
+	.name = "qnm_lpass_anoc",
+	.id = QCS615_MASTER_LPASS_ANOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 7,
+	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
+		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
+		   QCS615_SLAVE_PIMEM, QCS615_SLAVE_PCIE_0,
+		   QCS615_SLAVE_QDSS_STM },
+};
+
+static struct qcom_icc_node qnm_pcie_anoc = {
+	.name = "qnm_pcie_anoc",
+	.id = QCS615_MASTER_ANOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 5,
+	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
+		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
+		   QCS615_SLAVE_QDSS_STM },
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = QCS615_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_SNOC_MEM_NOC_GC, QCS615_SLAVE_IMEM },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = QCS615_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { QCS615_SLAVE_SNOC_MEM_NOC_GC, QCS615_SLAVE_IMEM },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = QCS615_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS615_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_lpass_snoc = {
+	.name = "qns_lpass_snoc",
+	.id = QCS615_SLAVE_LPASS_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_LPASS_ANOC },
+};
+
+static struct qcom_icc_node qns_pcie_snoc = {
+	.name = "qns_pcie_snoc",
+	.id = QCS615_SLAVE_ANOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_ANOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = QCS615_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_camnoc_uncomp = {
+	.name = "qns_camnoc_uncomp",
+	.id = QCS615_SLAVE_CAMNOC_UNCOMP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = QCS615_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_ahb2phy_east = {
+	.name = "qhs_ahb2phy_east",
+	.id = QCS615_SLAVE_AHB2PHY_EAST,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy_west = {
+	.name = "qhs_ahb2phy_west",
+	.id = QCS615_SLAVE_AHB2PHY_WEST,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aop = {
+	.name = "qhs_aop",
+	.id = QCS615_SLAVE_AOP,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = QCS615_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = QCS615_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = QCS615_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = QCS615_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = QCS615_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = QCS615_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = QCS615_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = QCS615_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_emac_avb_cfg = {
+	.name = "qhs_emac_avb_cfg",
+	.id = QCS615_SLAVE_EMAC_AVB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_glm = {
+	.name = "qhs_glm",
+	.id = QCS615_SLAVE_GLM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = QCS615_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = QCS615_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = QCS615_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = QCS615_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_pcie_config = {
+	.name = "qhs_pcie_config",
+	.id = QCS615_SLAVE_PCIE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = QCS615_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = QCS615_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = QCS615_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = QCS615_SLAVE_QSPI,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = QCS615_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = QCS615_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = QCS615_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = QCS615_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = QCS615_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_spdm = {
+	.name = "qhs_spdm",
+	.id = QCS615_SLAVE_SPDM_WRAPPER,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = QCS615_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm_east = {
+	.name = "qhs_tlmm_east",
+	.id = QCS615_SLAVE_TLMM_EAST,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm_south = {
+	.name = "qhs_tlmm_south",
+	.id = QCS615_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm_west = {
+	.name = "qhs_tlmm_west",
+	.id = QCS615_SLAVE_TLMM_WEST,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = QCS615_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb2 = {
+	.name = "qhs_usb2",
+	.id = QCS615_SLAVE_USB2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.id = QCS615_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = QCS615_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = QCS615_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = QCS615_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = QCS615_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_dc_noc_gemnoc = {
+	.name = "qhs_dc_noc_gemnoc",
+	.id = QCS615_SLAVE_DC_NOC_GEMNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { QCS615_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = QCS615_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
+	.name = "qhs_mdsp_ms_mpu_cfg",
+	.id = QCS615_SLAVE_MSS_PROC_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc = {
+	.name = "qns_gem_noc_snoc",
+	.id = QCS615_SLAVE_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = QCS615_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS615_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_sys_pcie = {
+	.name = "qns_sys_pcie",
+	.id = QCS615_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_gemnoc = {
+	.name = "srvc_gemnoc",
+	.id = QCS615_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ipa_core_slave = {
+	.name = "ipa_core_slave",
+	.id = QCS615_SLAVE_IPA_CORE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = QCS615_SLAVE_EBI1,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns2_mem_noc = {
+	.name = "qns2_mem_noc",
+	.id = QCS615_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = QCS615_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { QCS615_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = QCS615_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = QCS615_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = QCS615_SLAVE_SNOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_SNOC_CNOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = QCS615_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { QCS615_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_memnoc_gc = {
+	.name = "qns_memnoc_gc",
+	.id = QCS615_SLAVE_SNOC_MEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { QCS615_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = QCS615_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = QCS615_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = QCS615_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie = {
+	.name = "xs_pcie",
+	.id = QCS615_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = QCS615_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = QCS615_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 37,
+	.nodes = { &qhm_spdm, &qnm_snoc,
+		   &qhs_a1_noc_cfg, &qhs_aop,
+		   &qhs_aoss, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_cpr_cx,
+		   &qhs_cpr_mx, &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg, &qhs_display_cfg,
+		   &qhs_emac_avb_cfg, &qhs_glm,
+		   &qhs_gpuss_cfg, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_mnoc_cfg,
+		   &qhs_pcie_config, &qhs_pimem_cfg,
+		   &qhs_prng, &qhs_qdss_cfg,
+		   &qhs_qup0, &qhs_qup1,
+		   &qhs_snoc_cfg, &qhs_spdm,
+		   &qhs_tcsr, &qhs_tlmm_east,
+		   &qhs_tlmm_south, &qhs_tlmm_west,
+		   &qhs_ufs_mem_cfg, &qhs_usb2,
+		   &qhs_usb3, &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc,
+		   &srvc_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 8,
+	.nodes = { &qhm_qspi, &xm_sdc1,
+		   &xm_sdc2, &qhs_ahb2phy_east,
+		   &qhs_ahb2phy_west, &qhs_qspi,
+		   &qhs_sdc1, &qhs_sdc2 },
+};
+
+static struct qcom_icc_bcm bcm_ip0 = {
+	.name = "IP0",
+	.num_nodes = 1,
+	.nodes = { &ipa_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.num_nodes = 7,
+	.nodes = { &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp,
+		   &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0,
+		   &qxm_camnoc_hf1, &qxm_mdp0,
+		   &qxm_rot },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.num_nodes = 2,
+	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.num_nodes = 2,
+	.nodes = { &qxm_venus0, &qxm_venus_arm9 },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 2,
+	.nodes = { &qhm_qup0, &qhm_qup1 },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.num_nodes = 1,
+	.nodes = { &acm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.num_nodes = 1,
+	.nodes = { &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qns_memnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 2,
+	.nodes = { &srvc_aggre2_noc, &qns_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.num_nodes = 2,
+	.nodes = { &qnm_gemnoc_pcie, &xs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.num_nodes = 2,
+	.nodes = { &qxm_pimem, &xm_gic },
+};
+
+static struct qcom_icc_bcm bcm_sn13 = {
+	.name = "SN13",
+	.num_nodes = 1,
+	.nodes = { &qnm_lpass_anoc },
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_snoc },
+};
+
+static struct qcom_icc_bcm bcm_sn15 = {
+	.name = "SN15",
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_cn1,
+	&bcm_qup0,
+	&bcm_sn3,
+	&bcm_sn14,
+	&bcm_ip0,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QSPI] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_BLSP_1] = &qhm_qup1,
+	[MASTER_CNOC_A2NOC] = &qnm_cnoc,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_EMAC_EVB] = &xm_emac_avb,
+	[MASTER_PCIE] = &xm_pcie,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB2] = &xm_usb2,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+	[SLAVE_LPASS_SNOC] = &qns_lpass_snoc,
+	[SLAVE_ANOC_PCIE_SNOC] = &qns_pcie_snoc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+};
+
+static const struct qcom_icc_desc qcs615_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const camnoc_virt_bcms[] = {
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const camnoc_virt_nodes[] = {
+	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
+	[MASTER_CAMNOC_HF1_UNCOMP] = &qxm_camnoc_hf1_uncomp,
+	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
+	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
+};
+
+static const struct qcom_icc_desc qcs615_camnoc_virt = {
+	.nodes = camnoc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
+	.bcms = camnoc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(camnoc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_SPDM] = &qhm_spdm,
+	[MASTER_SNOC_CNOC] = &qnm_snoc,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
+	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
+	[SLAVE_AHB2PHY_EAST] = &qhs_ahb2phy_east,
+	[SLAVE_AHB2PHY_WEST] = &qhs_ahb2phy_west,
+	[SLAVE_AOP] = &qhs_aop,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_EMAC_AVB_CFG] = &qhs_emac_avb_cfg,
+	[SLAVE_GLM] = &qhs_glm,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_CNOC_MNOC_CFG] = &qhs_mnoc_cfg,
+	[SLAVE_PCIE_CFG] = &qhs_pcie_config,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
+	[SLAVE_SPDM_WRAPPER] = &qhs_spdm,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM_EAST] = &qhs_tlmm_east,
+	[SLAVE_TLMM_SOUTH] = &qhs_tlmm_south,
+	[SLAVE_TLMM_WEST] = &qhs_tlmm_west,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB2] = &qhs_usb2,
+	[SLAVE_USB3] = &qhs_usb3,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_CNOC_A2NOC] = &qns_cnoc_a2noc,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
+};
+
+static const struct qcom_icc_desc qcs615_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_node * const dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qhm_cnoc,
+	[SLAVE_DC_NOC_GEMNOC] = &qhs_dc_noc_gemnoc,
+	[SLAVE_LLCC_CFG] = &qhs_llcc,
+};
+
+static const struct qcom_icc_desc qcs615_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh2,
+	&bcm_sh3,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_APPSS_PROC] = &acm_apps,
+	[MASTER_GPU_TCU] = &acm_gpu_tcu,
+	[MASTER_SYS_TCU] = &acm_sys_tcu,
+	[MASTER_GEM_NOC_CFG] = &qhm_gemnoc_cfg,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
+	[SLAVE_GEM_NOC_SNOC] = &qns_gem_noc_snoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_sys_pcie,
+	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
+};
+
+static const struct qcom_icc_desc qcs615_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
+	&bcm_ip0,
+};
+
+static struct qcom_icc_node * const ipa_virt_nodes[] = {
+	[MASTER_IPA_CORE] = &ipa_core_master,
+	[SLAVE_IPA_CORE] = &ipa_core_slave,
+};
+
+static const struct qcom_icc_desc qcs615_ipa_virt = {
+	.nodes = ipa_virt_nodes,
+	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
+	.bcms = ipa_virt_bcms,
+	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc qcs615_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm2,
+	&bcm_mm3,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
+	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
+	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
+	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
+	[MASTER_MDP0] = &qxm_mdp0,
+	[MASTER_ROTATOR] = &qxm_rot,
+	[MASTER_VIDEO_P0] = &qxm_venus0,
+	[MASTER_VIDEO_PROC] = &qxm_venus_arm9,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns2_mem_noc,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static const struct qcom_icc_desc qcs615_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+	&bcm_sn5,
+	&bcm_sn8,
+	&bcm_sn9,
+	&bcm_sn12,
+	&bcm_sn13,
+	&bcm_sn15,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_GEM_NOC_SNOC] = &qnm_gemnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[MASTER_LPASS_ANOC] = &qnm_lpass_anoc,
+	[MASTER_ANOC_PCIE_SNOC] = &qnm_pcie_anoc,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_SNOC_CNOC] = &qns_cnoc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_SNOC_MEM_NOC_GC] = &qns_memnoc_gc,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+	[SLAVE_PCIE_0] = &xs_pcie,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc qcs615_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,qcs615-aggre1-noc",
+	  .data = &qcs615_aggre1_noc},
+	{ .compatible = "qcom,qcs615-camnoc-virt",
+	  .data = &qcs615_camnoc_virt},
+	{ .compatible = "qcom,qcs615-config-noc",
+	  .data = &qcs615_config_noc},
+	{ .compatible = "qcom,qcs615-dc-noc",
+	  .data = &qcs615_dc_noc},
+	{ .compatible = "qcom,qcs615-gem-noc",
+	  .data = &qcs615_gem_noc},
+	{ .compatible = "qcom,qcs615-ipa-virt",
+	  .data = &qcs615_ipa_virt},
+	{ .compatible = "qcom,qcs615-mc-virt",
+	  .data = &qcs615_mc_virt},
+	{ .compatible = "qcom,qcs615-mmss-noc",
+	  .data = &qcs615_mmss_noc},
+	{ .compatible = "qcom,qcs615-system-noc",
+	  .data = &qcs615_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-qcs615",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("qcs615 NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/qcs615.h b/drivers/interconnect/qcom/qcs615.h
new file mode 100644
index 000000000000..66e66c7e23d4
--- /dev/null
+++ b/drivers/interconnect/qcom/qcs615.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS615_H
+#define __DRIVERS_INTERCONNECT_QCOM_QCS615_H
+
+#define QCS615_MASTER_A1NOC_CFG				1
+#define QCS615_MASTER_A1NOC_SNOC			2
+#define QCS615_MASTER_ANOC_PCIE_SNOC			3
+#define QCS615_MASTER_APPSS_PROC			4
+#define QCS615_MASTER_BLSP_1				5
+#define QCS615_MASTER_CAMNOC_HF0			6
+#define QCS615_MASTER_CAMNOC_HF0_UNCOMP			7
+#define QCS615_MASTER_CAMNOC_HF1			8
+#define QCS615_MASTER_CAMNOC_HF1_UNCOMP			9
+#define QCS615_MASTER_CAMNOC_SF				10
+#define QCS615_MASTER_CAMNOC_SF_UNCOMP			11
+#define QCS615_MASTER_CNOC_A2NOC			12
+#define QCS615_MASTER_CNOC_DC_NOC			13
+#define QCS615_MASTER_CNOC_MNOC_CFG			14
+#define QCS615_MASTER_CRYPTO				15
+#define QCS615_MASTER_EMAC_EVB				16
+#define QCS615_MASTER_GEM_NOC_CFG			17
+#define QCS615_MASTER_GEM_NOC_PCIE_SNOC			18
+#define QCS615_MASTER_GEM_NOC_SNOC			19
+#define QCS615_MASTER_GFX3D				20
+#define QCS615_MASTER_GIC				21
+#define QCS615_MASTER_GPU_TCU				22
+#define QCS615_MASTER_IPA				23
+#define QCS615_MASTER_IPA_CORE				24
+#define QCS615_MASTER_LLCC				25
+#define QCS615_MASTER_LPASS_ANOC			26
+#define QCS615_MASTER_MDP0				27
+#define QCS615_MASTER_MNOC_HF_MEM_NOC			28
+#define QCS615_MASTER_MNOC_SF_MEM_NOC			29
+#define QCS615_MASTER_PCIE				30
+#define QCS615_MASTER_PIMEM				31
+#define QCS615_MASTER_QDSS_BAM				32
+#define QCS615_MASTER_QDSS_DAP				33
+#define QCS615_MASTER_QDSS_ETR				34
+#define QCS615_MASTER_QSPI				35
+#define QCS615_MASTER_QUP_0				36
+#define QCS615_MASTER_ROTATOR				37
+#define QCS615_MASTER_SDCC_1				38
+#define QCS615_MASTER_SDCC_2				39
+#define QCS615_MASTER_SNOC_CFG				40
+#define QCS615_MASTER_SNOC_CNOC				41
+#define QCS615_MASTER_SNOC_GC_MEM_NOC			42
+#define QCS615_MASTER_SNOC_SF_MEM_NOC			43
+#define QCS615_MASTER_SPDM				44
+#define QCS615_MASTER_SYS_TCU				45
+#define QCS615_MASTER_UFS_MEM				46
+#define QCS615_MASTER_USB2				47
+#define QCS615_MASTER_USB3_0				48
+#define QCS615_MASTER_VIDEO_P0				49
+#define QCS615_MASTER_VIDEO_PROC			50
+#define QCS615_SLAVE_A1NOC_CFG				51
+#define QCS615_SLAVE_A1NOC_SNOC				52
+#define QCS615_SLAVE_AHB2PHY_EAST			53
+#define QCS615_SLAVE_AHB2PHY_WEST			54
+#define QCS615_SLAVE_ANOC_PCIE_SNOC			55
+#define QCS615_SLAVE_AOP				56
+#define QCS615_SLAVE_AOSS				57
+#define QCS615_SLAVE_APPSS				58
+#define QCS615_SLAVE_CAMERA_CFG				59
+#define QCS615_SLAVE_CAMNOC_UNCOMP			60
+#define QCS615_SLAVE_CLK_CTL				61
+#define QCS615_SLAVE_CNOC_A2NOC				62
+#define QCS615_SLAVE_CNOC_DDRSS				63
+#define QCS615_SLAVE_CNOC_MNOC_CFG			64
+#define QCS615_SLAVE_CRYPTO_0_CFG			65
+#define QCS615_SLAVE_DC_NOC_GEMNOC			66
+#define QCS615_SLAVE_DISPLAY_CFG			67
+#define QCS615_SLAVE_EBI1				68
+#define QCS615_SLAVE_EMAC_AVB_CFG			69
+#define QCS615_SLAVE_GEM_NOC_SNOC			70
+#define QCS615_SLAVE_GFX3D_CFG				71
+#define QCS615_SLAVE_GLM				72
+#define QCS615_SLAVE_IMEM				73
+#define QCS615_SLAVE_IMEM_CFG				74
+#define QCS615_SLAVE_IPA_CFG				75
+#define QCS615_SLAVE_IPA_CORE				76
+#define QCS615_SLAVE_LLCC				77
+#define QCS615_SLAVE_LLCC_CFG				78
+#define QCS615_SLAVE_LPASS_SNOC				79
+#define QCS615_SLAVE_MEM_NOC_PCIE_SNOC			80
+#define QCS615_SLAVE_MNOC_HF_MEM_NOC			81
+#define QCS615_SLAVE_MNOC_SF_MEM_NOC			82
+#define QCS615_SLAVE_MSS_PROC_MS_MPU_CFG		83
+#define QCS615_SLAVE_PCIE_0				84
+#define QCS615_SLAVE_PCIE_CFG				85
+#define QCS615_SLAVE_PIMEM				86
+#define QCS615_SLAVE_PIMEM_CFG				87
+#define QCS615_SLAVE_PRNG				88
+#define QCS615_SLAVE_QDSS_CFG				89
+#define QCS615_SLAVE_QDSS_STM				90
+#define QCS615_SLAVE_QSPI				91
+#define QCS615_SLAVE_QUP_0				92
+#define QCS615_SLAVE_QUP_1				93
+#define QCS615_SLAVE_RBCPR_CX_CFG			94
+#define QCS615_SLAVE_RBCPR_MX_CFG			95
+#define QCS615_SLAVE_SDCC_1				96
+#define QCS615_SLAVE_SDCC_2				97
+#define QCS615_SLAVE_SERVICE_A2NOC			98
+#define QCS615_SLAVE_SERVICE_CNOC			99
+#define QCS615_SLAVE_SERVICE_GEM_NOC			100
+#define QCS615_SLAVE_SERVICE_MNOC			101
+#define QCS615_SLAVE_SERVICE_SNOC			102
+#define QCS615_SLAVE_SNOC_CFG				103
+#define QCS615_SLAVE_SNOC_CNOC				104
+#define QCS615_SLAVE_SNOC_GEM_NOC_SF			105
+#define QCS615_SLAVE_SNOC_MEM_NOC_GC			106
+#define QCS615_SLAVE_SPDM_WRAPPER			107
+#define QCS615_SLAVE_TCSR				108
+#define QCS615_SLAVE_TCU				109
+#define QCS615_SLAVE_TLMM_EAST				110
+#define QCS615_SLAVE_TLMM_SOUTH				111
+#define QCS615_SLAVE_TLMM_WEST				112
+#define QCS615_SLAVE_UFS_MEM_CFG			113
+#define QCS615_SLAVE_USB2				114
+#define QCS615_SLAVE_USB3				115
+#define QCS615_SLAVE_VENUS_CFG				116
+#define QCS615_SLAVE_VSENSE_CTRL_CFG			117
+
+#endif
+
-- 
2.39.2


