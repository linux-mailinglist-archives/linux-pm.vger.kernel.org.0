Return-Path: <linux-pm+bounces-30924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9130B07960
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FED565018
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618DB1A238C;
	Wed, 16 Jul 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgQqb0fk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0082F433C
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678960; cv=none; b=tcL1U5c/CBVAPF2TkIclfN0jTcYBPeg3lAsTfwEX1EkKU99Dv27oblDgOMjKZ9IhklRtxHuxrfoeD8yAAVZUk4NKK56xPiEtdZv/RFAUNR4let9ZhtIOh0hOIqZ2dHxamQu2d5HhT4n15a1/g+TGDeaJ0zwZh4ZYGzPVaFmonYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678960; c=relaxed/simple;
	bh=QoYcXDGdTs4jM1jqY8cQorpLMddLydjnaiX+XOS2uHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxvG2lflb8s9EGFLVdDEnmasjSTqYaOgPkx0SfySsspIkQ0mPc2b88gV32zL1V7I/873ZL0W8nk4PVhi12XCiHJlj3/FaRq+cmfhjipd5N7bDf1S5zoUp4xC6CiIIlHktKciODGLfiOnW7RWx9a5qDJg17iNkwOty3gZtHn91GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgQqb0fk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G9VuwC008481
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IR4nKImEzBo
	1+DJzveuaxs+49SV9thoeJd1oANAZQJ8=; b=hgQqb0fknRMTVNXcmCoTLXCRw6P
	14CdSgKYb2j1bZuHjzxiFNRYBNLAxTHrBIdUZaKL9p5lsOKfXDqztEsnHJZXyjG+
	VS2bAtzCzLaT3FIzxHyVtnHquSvHyM+wvWO1Qws2Pqb6XqGOdTCoJy30y2seJyAF
	aWJ0G3PigBXevvw880/jBJBOGKnaKTrhX99v+XJkUkVVwDAQk8BzbhzKa3HwajxK
	W6FDFQMaBa4KfWG2KQuQLET3truKdjvEBEKJPdQsrLFsGQ+o1M27fnYdIN/4H7H5
	R79unDOMaic3JqUdl4j3TWV3JSLVuC7Ff0QO6d/KQr00B7mrXO+oPTIneTg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpfdgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:15:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e3f93687so96066845ad.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 08:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678954; x=1753283754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR4nKImEzBo1+DJzveuaxs+49SV9thoeJd1oANAZQJ8=;
        b=q7GfCAfXmobYe3WSkB2VhJQzKuq+hORfAAVrxxTGDdJdQI4dgCjJeznRc4B1xO9Phs
         Pf/hl7YW8ynNi2U0GWYGQEU6l5QLYh+Um5F1RnAJ2OLLLcDJjG9GNgQaePGoP0XB2syP
         3N2nPmraWgLAxJjLlz/l0/6p+ZkR2GbPxkCrVewqyvtprfQp+2Qf/Wz4O0MQ9177UO8R
         1NCS2H3PQXdgfwOzATmDTMHxtJ5x08KlmbyxpXktd1SStW2JUDEPz7k3/Cuk2bEHK8aJ
         gRdGSHmB/kin/PFefQNQS6BTQwsf3V97fBjo7hstxmunrjohm314lIrZ2YL14zspx9Aj
         KUMw==
X-Forwarded-Encrypted: i=1; AJvYcCUFbR+iRbo5jZohPIXXGFlg9diz4WDBLQdICaK1d5X51C7N53de7zj2TTtVoQbUB06mZbMc4cgWiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNN1qeVWtPuXwSaseTgMBGr1mYsnkMLj+UX8z9IZfZ+9JY9t6T
	MQUIk+HqV7qhtnhnS8IBT2QfmtezDFAUwHFWf7Lmp7W9AwQmPyJj4R6GQvVmAInKCd8tOcSoZGZ
	bl68enH0ouCI4O0a9DpVkq6AfMbNlfRECLI3di8goaoOpWIrD8UxoXAzMHB+bZFtd1k6JJw==
X-Gm-Gg: ASbGnctJ+o6ZJ5DAdV/WrvxmRYpRem6FLrtAYo30GBYwis606dYPu1tL0u5b5OTmkb/
	aMk0DcdlTlBClj1s3MWCqH5GbTz1fwA8UNR+V81L1eHDrgUaORDsCj3W9esTPMMl9TomPD8V9fX
	Y7Oe0o22RacP4LkwsnNM4rl9pu7aBG8Y0GuDIPzBb+aDoFSBaToLq7THze/iz8Vgm6Ngx1LDd38
	GldB0kr1uwNJiZE5lj+qIKA951Xyu1RWMrgMkFYPF54bkEFCSzfvv491WDdpfO7h9/Wpe/xX0D+
	canPxJcUQHjkc8dzauAQGM+3qwUtQZJfL126Ub0FV/uNZ/HwFgJp/Ha4FDRHE+QKxEPr77ldvW0
	mN5j8rB3I+rgTRX+Hrh2fsHgFEwF8C4xXjly374lQWAKTEuXT3qEUS5wLx4G3
X-Received: by 2002:a17:903:228a:b0:235:e942:cb9c with SMTP id d9443c01a7336-23e2566aa35mr49621105ad.5.1752678952801;
        Wed, 16 Jul 2025 08:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/kBX2aNMcjcO5un4RJ7RyPH0f2aBeWYidiJc+Gec80HyD9PVz2UH4S9Mvm77ajmWA4haLCw==
X-Received: by 2002:a17:903:228a:b0:235:e942:cb9c with SMTP id d9443c01a7336-23e2566aa35mr49619785ad.5.1752678951632;
        Wed, 16 Jul 2025 08:15:51 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad9efsm132769455ad.58.2025.07.16.08.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:15:51 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: djakov@kernel.org, lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        raviteja.laggyshetty@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] interconnect: qcom: add glymur interconnect provider driver
Date: Wed, 16 Jul 2025 20:45:35 +0530
Message-Id: <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfXy2Sqk/5hZnPg
 O9+zEzs96CDOASpH8INr8RqdpIKsOijTCGefhkcUDWQJtduZrqKFKsXn1sz+kbqymoTjtRrCfHq
 YpD06Oh7cyJyxk8ZB1uaoyxzRpJ5qdMj1952nRXARA+HfTTXlnBhhRSMlm/cm3jG5EoPxywztKX
 dAVeNCDz0JyyDBKWH5V89Dv/A902fEhnaPz9diNod6QB/DqLgiDIuGiuPSXVw1ShNRKh2Exq7XZ
 LdW+tSw9le2kBsFTaMmDQU8hR4BdFDh5ZxK+W7IgD6G7rJScmDMC0J+6GWqyisSJ2xPePN2/XOO
 UraGFpcfSetNNpikhQNm1+W1edRJABjkKpSDcClqVWLYZF1FZ75PmFJee2//qPLCj8/s05cgwtj
 HC5axlfLnh7yKs2fpiQNCHNaYtfhEV3EwsbaNXn2z1+jvrp7WLTAaucrVnaPuBW68Hi4CK3a
X-Proofpoint-GUID: -frdMcIulROVOgdzpZ9cWHvnSTJKsvXV
X-Proofpoint-ORIG-GUID: -frdMcIulROVOgdzpZ9cWHvnSTJKsvXV
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877c22b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7Y5ZrCSegFD1MsWmRDAA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160138

From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

Add driver for the Qualcomm interconnect buses found in glymur
based platforms. The topology consists of several NoCs that are
controlled by a remote processor that collects the aggregated
bandwidth for each master-slave pairs.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/glymur.c | 2259 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/glymur.h |  185 +++
 4 files changed, 2455 insertions(+)
 create mode 100644 drivers/interconnect/qcom/glymur.c
 create mode 100644 drivers/interconnect/qcom/glymur.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 1219f4f23d40..18234110d4b3 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -8,6 +8,15 @@ config INTERCONNECT_QCOM
 config INTERCONNECT_QCOM_BCM_VOTER
 	tristate
 
+config INTERCONNECT_QCOM_GLYMUR
+	tristate "Qualcomm GLYMUR interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on glymur-based
+	  platforms.
+
 config INTERCONNECT_QCOM_MSM8909
 	tristate "Qualcomm MSM8909 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 7887b1e8d69b..e205f923f85a 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
 
 interconnect_qcom-y			:= icc-common.o
 icc-bcm-voter-objs			:= bcm-voter.o
+qnoc-glymur-objs			:= glymur.o
 qnoc-msm8909-objs			:= msm8909.o
 qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8937-objs			:= msm8937.o
@@ -45,6 +46,7 @@ qnoc-x1e80100-objs			:= x1e80100.o
 icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
+obj-$(CONFIG_INTERCONNECT_QCOM_GLYMUR) += qnoc-glymur.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8909) += qnoc-msm8909.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8937) += qnoc-msm8937.o
diff --git a/drivers/interconnect/qcom/glymur.c b/drivers/interconnect/qcom/glymur.c
new file mode 100644
index 000000000000..f4aa1b085b47
--- /dev/null
+++ b/drivers/interconnect/qcom/glymur.c
@@ -0,0 +1,2259 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "glymur.h"
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = GLYMUR_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_soccp = {
+	.name = "qxm_soccp",
+	.id = GLYMUR_MASTER_SOCCP_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.id = GLYMUR_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.id = GLYMUR_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = GLYMUR_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_2 = {
+	.name = "xm_usb3_2",
+	.id = GLYMUR_MASTER_USB3_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb4_2 = {
+	.name = "xm_usb4_2",
+	.id = GLYMUR_MASTER_USB4_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = GLYMUR_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = GLYMUR_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = GLYMUR_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = GLYMUR_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_sp = {
+	.name = "qxm_sp",
+	.id = GLYMUR_MASTER_SP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = GLYMUR_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = GLYMUR_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb2_0 = {
+	.name = "xm_usb2_0",
+	.id = GLYMUR_MASTER_USB2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_mp = {
+	.name = "xm_usb3_mp",
+	.id = GLYMUR_MASTER_USB3_MP,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = GLYMUR_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A4NOC_HSCNOC },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = GLYMUR_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A4NOC_HSCNOC },
+};
+
+static struct qcom_icc_node xm_usb4_0 = {
+	.name = "xm_usb4_0",
+	.id = GLYMUR_MASTER_USB4_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A4NOC_HSCNOC },
+};
+
+static struct qcom_icc_node xm_usb4_1 = {
+	.name = "xm_usb4_1",
+	.id = GLYMUR_MASTER_USB4_1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_A4NOC_HSCNOC },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = GLYMUR_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = GLYMUR_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.id = GLYMUR_MASTER_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_QUP_CORE_2 },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.id = GLYMUR_MASTER_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 51,
+	.links = { GLYMUR_SLAVE_AHB2PHY_SOUTH, GLYMUR_SLAVE_AHB2PHY_NORTH,
+			   GLYMUR_SLAVE_AHB2PHY_2, GLYMUR_SLAVE_AHB2PHY_3,
+			   GLYMUR_SLAVE_AV1_ENC_CFG, GLYMUR_SLAVE_CAMERA_CFG,
+			   GLYMUR_SLAVE_CLK_CTL, GLYMUR_SLAVE_CRYPTO_0_CFG,
+			   GLYMUR_SLAVE_DISPLAY_CFG, GLYMUR_SLAVE_GFX3D_CFG,
+			   GLYMUR_SLAVE_IMEM_CFG, GLYMUR_SLAVE_PCIE_0_CFG,
+			   GLYMUR_SLAVE_PCIE_1_CFG, GLYMUR_SLAVE_PCIE_2_CFG,
+			   GLYMUR_SLAVE_PCIE_3A_CFG, GLYMUR_SLAVE_PCIE_3B_CFG,
+			   GLYMUR_SLAVE_PCIE_4_CFG, GLYMUR_SLAVE_PCIE_5_CFG,
+			   GLYMUR_SLAVE_PCIE_6_CFG, GLYMUR_SLAVE_PCIE_RSCC,
+			   GLYMUR_SLAVE_PDM, GLYMUR_SLAVE_PRNG,
+			   GLYMUR_SLAVE_QDSS_CFG, GLYMUR_SLAVE_QSPI_0,
+			   GLYMUR_SLAVE_QUP_0, GLYMUR_SLAVE_QUP_1,
+			   GLYMUR_SLAVE_QUP_2, GLYMUR_SLAVE_SDCC_2,
+			   GLYMUR_SLAVE_SDCC_4, GLYMUR_SLAVE_SMMUV3_CFG,
+			   GLYMUR_SLAVE_TCSR, GLYMUR_SLAVE_TLMM,
+			   GLYMUR_SLAVE_UFS_MEM_CFG, GLYMUR_SLAVE_USB2,
+			   GLYMUR_SLAVE_USB3_0, GLYMUR_SLAVE_USB3_1,
+			   GLYMUR_SLAVE_USB3_2, GLYMUR_SLAVE_USB3_MP,
+			   GLYMUR_SLAVE_USB4_0, GLYMUR_SLAVE_USB4_1,
+			   GLYMUR_SLAVE_USB4_2, GLYMUR_SLAVE_VENUS_CFG,
+			   GLYMUR_SLAVE_CNOC_PCIE_SLAVE_EAST_CFG,
+			   GLYMUR_SLAVE_CNOC_PCIE_SLAVE_WEST_CFG,
+			   GLYMUR_SLAVE_LPASS_QTB_CFG, GLYMUR_SLAVE_CNOC_MNOC_CFG,
+			   GLYMUR_SLAVE_NSP_QTB_CFG, GLYMUR_SLAVE_PCIE_EAST_ANOC_CFG,
+			   GLYMUR_SLAVE_PCIE_WEST_ANOC_CFG, GLYMUR_SLAVE_QDSS_STM,
+			   GLYMUR_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_hscnoc_cnoc = {
+	.name = "qnm_hscnoc_cnoc",
+	.id = GLYMUR_MASTER_HSCNOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 8,
+	.links = { GLYMUR_SLAVE_AOSS, GLYMUR_SLAVE_IPC_ROUTER_CFG,
+			   GLYMUR_SLAVE_SOCCP, GLYMUR_SLAVE_TME_CFG,
+			   GLYMUR_SLAVE_APPSS, GLYMUR_SLAVE_CNOC_CFG,
+			   GLYMUR_SLAVE_BOOT_IMEM, GLYMUR_SLAVE_IMEM },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = GLYMUR_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_pcie_qtc = {
+	.name = "alm_pcie_qtc",
+	.id = GLYMUR_MASTER_PCIE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = GLYMUR_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = GLYMUR_MASTER_APPSS_PROC,
+	.channels = 6,
+	.buswidth = 32,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_aggre_noc_east = {
+	.name = "qnm_aggre_noc_east",
+	.id = GLYMUR_MASTER_AGGRE_NOC_EAST,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = GLYMUR_MASTER_GFX3D,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_lpass = {
+	.name = "qnm_lpass",
+	.id = GLYMUR_MASTER_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = GLYMUR_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = GLYMUR_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_nsp_noc = {
+	.name = "qnm_nsp_noc",
+	.id = GLYMUR_MASTER_COMPUTE_NOC,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_pcie_east = {
+	.name = "qnm_pcie_east",
+	.id = GLYMUR_MASTER_PCIE_EAST,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_pcie_west = {
+	.name = "qnm_pcie_west",
+	.id = GLYMUR_MASTER_PCIE_WEST,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = GLYMUR_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qxm_wlan_q6 = {
+	.name = "qxm_wlan_q6",
+	.id = GLYMUR_MASTER_WLAN_Q6,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 4,
+	.links = { GLYMUR_SLAVE_HSCNOC_CNOC, GLYMUR_SLAVE_LLCC,
+			   GLYMUR_SLAVE_PCIE_EAST, GLYMUR_SLAVE_PCIE_WEST },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = GLYMUR_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_lpiaon_noc = {
+	.name = "qnm_lpiaon_noc",
+	.id = GLYMUR_MASTER_LPIAON_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_lpass_lpinoc = {
+	.name = "qnm_lpass_lpinoc",
+	.id = GLYMUR_MASTER_LPASS_LPINOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qnm_lpinoc_dsp_qns4m = {
+	.name = "qnm_lpinoc_dsp_qns4m",
+	.id = GLYMUR_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_LPICX_NOC_LPIAON_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = GLYMUR_MASTER_LLCC,
+	.channels = 12,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_av1_enc = {
+	.name = "qnm_av1_enc",
+	.id = GLYMUR_MASTER_AV1_ENC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = GLYMUR_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = GLYMUR_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = GLYMUR_MASTER_CAMNOC_SF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_eva = {
+	.name = "qnm_eva",
+	.id = GLYMUR_MASTER_EVA,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.id = GLYMUR_MASTER_MDP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_vapss_hcp = {
+	.name = "qnm_vapss_hcp",
+	.id = GLYMUR_MASTER_CDSP_HCP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video = {
+	.name = "qnm_video",
+	.id = GLYMUR_MASTER_VIDEO,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cv_cpu = {
+	.name = "qnm_video_cv_cpu",
+	.id = GLYMUR_MASTER_VIDEO_CV_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.id = GLYMUR_MASTER_VIDEO_V_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qsm_mnoc_cfg = {
+	.name = "qsm_mnoc_cfg",
+	.id = GLYMUR_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node xm_cpucp = {
+	.name = "xm_cpucp",
+	.id = GLYMUR_MASTER_CPUCP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_NSINOC_SYSTEM_NOC, GLYMUR_SLAVE_SERVICE_NSINOC },
+};
+
+static struct qcom_icc_node qnm_nsp = {
+	.name = "qnm_nsp",
+	.id = GLYMUR_MASTER_CDSP_PROC,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_NSP0_HSC_NOC },
+};
+
+static struct qcom_icc_node xm_mem_sp = {
+	.name = "xm_mem_sp",
+	.id = GLYMUR_MASTER_OOBMSS_SP_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_OOBMSS_SNOC },
+};
+
+static struct qcom_icc_node qsm_pcie_east_anoc_cfg = {
+	.name = "qsm_pcie_east_anoc_cfg",
+	.id = GLYMUR_MASTER_PCIE_EAST_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SERVICE_PCIE_EAST_AGGRE_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_0 = {
+	.name = "xm_pcie_0",
+	.id = GLYMUR_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_EAST_MEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_1 = {
+	.name = "xm_pcie_1",
+	.id = GLYMUR_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_EAST_MEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_5 = {
+	.name = "xm_pcie_5",
+	.id = GLYMUR_MASTER_PCIE_5,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_EAST_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_hscnoc_pcie_east = {
+	.name = "qnm_hscnoc_pcie_east",
+	.id = GLYMUR_MASTER_HSCNOC_PCIE_EAST,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { GLYMUR_SLAVE_PCIE_0, GLYMUR_SLAVE_PCIE_1,
+			   GLYMUR_SLAVE_PCIE_5 },
+};
+
+static struct qcom_icc_node qsm_cnoc_pcie_east_slave_cfg = {
+	.name = "qsm_cnoc_pcie_east_slave_cfg",
+	.id = GLYMUR_MASTER_CNOC_PCIE_EAST_SLAVE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_PCIE_EAST_MS_MPU_CFG, GLYMUR_SLAVE_SERVICE_PCIE_EAST },
+};
+
+static struct qcom_icc_node qsm_pcie_west_anoc_cfg = {
+	.name = "qsm_pcie_west_anoc_cfg",
+	.id = GLYMUR_MASTER_PCIE_WEST_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_2 = {
+	.name = "xm_pcie_2",
+	.id = GLYMUR_MASTER_PCIE_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_WEST_MEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_3a = {
+	.name = "xm_pcie_3a",
+	.id = GLYMUR_MASTER_PCIE_3A,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_WEST_MEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_3b = {
+	.name = "xm_pcie_3b",
+	.id = GLYMUR_MASTER_PCIE_3B,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_WEST_MEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_4 = {
+	.name = "xm_pcie_4",
+	.id = GLYMUR_MASTER_PCIE_4,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_WEST_MEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie_6 = {
+	.name = "xm_pcie_6",
+	.id = GLYMUR_MASTER_PCIE_6,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_PCIE_WEST_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_hscnoc_pcie_west = {
+	.name = "qnm_hscnoc_pcie_west",
+	.id = GLYMUR_MASTER_HSCNOC_PCIE_WEST,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 5,
+	.links = { GLYMUR_SLAVE_PCIE_2, GLYMUR_SLAVE_PCIE_3A,
+			   GLYMUR_SLAVE_PCIE_3B, GLYMUR_SLAVE_PCIE_4,
+			   GLYMUR_SLAVE_PCIE_6 },
+};
+
+static struct qcom_icc_node qsm_cnoc_pcie_west_slave_cfg = {
+	.name = "qsm_cnoc_pcie_west_slave_cfg",
+	.id = GLYMUR_MASTER_CNOC_PCIE_WEST_SLAVE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { GLYMUR_SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG, GLYMUR_SLAVE_SERVICE_PCIE_WEST },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = GLYMUR_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = GLYMUR_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre3_noc = {
+	.name = "qnm_aggre3_noc",
+	.id = GLYMUR_MASTER_A3NOC_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_nsi_noc = {
+	.name = "qnm_nsi_noc",
+	.id = GLYMUR_MASTER_NSINOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_oobmss = {
+	.name = "qnm_oobmss",
+	.id = GLYMUR_MASTER_OOBMSS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = GLYMUR_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = GLYMUR_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a3noc_snoc = {
+	.name = "qns_a3noc_snoc",
+	.id = GLYMUR_SLAVE_A3NOC_SNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_A3NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a4noc_hscnoc = {
+	.name = "qns_a4noc_hscnoc",
+	.id = GLYMUR_SLAVE_A4NOC_HSCNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_AGGRE_NOC_EAST },
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = GLYMUR_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = GLYMUR_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.id = GLYMUR_SLAVE_QUP_CORE_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = GLYMUR_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = GLYMUR_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy2 = {
+	.name = "qhs_ahb2phy2",
+	.id = GLYMUR_SLAVE_AHB2PHY_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy3 = {
+	.name = "qhs_ahb2phy3",
+	.id = GLYMUR_SLAVE_AHB2PHY_3,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_av1_enc_cfg = {
+	.name = "qhs_av1_enc_cfg",
+	.id = GLYMUR_SLAVE_AV1_ENC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = GLYMUR_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = GLYMUR_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = GLYMUR_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = GLYMUR_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = GLYMUR_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = GLYMUR_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = GLYMUR_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = GLYMUR_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie2_cfg = {
+	.name = "qhs_pcie2_cfg",
+	.id = GLYMUR_SLAVE_PCIE_2_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie3a_cfg = {
+	.name = "qhs_pcie3a_cfg",
+	.id = GLYMUR_SLAVE_PCIE_3A_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie3b_cfg = {
+	.name = "qhs_pcie3b_cfg",
+	.id = GLYMUR_SLAVE_PCIE_3B_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie4_cfg = {
+	.name = "qhs_pcie4_cfg",
+	.id = GLYMUR_SLAVE_PCIE_4_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie5_cfg = {
+	.name = "qhs_pcie5_cfg",
+	.id = GLYMUR_SLAVE_PCIE_5_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie6_cfg = {
+	.name = "qhs_pcie6_cfg",
+	.id = GLYMUR_SLAVE_PCIE_6_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie_rscc = {
+	.name = "qhs_pcie_rscc",
+	.id = GLYMUR_SLAVE_PCIE_RSCC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = GLYMUR_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = GLYMUR_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = GLYMUR_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = GLYMUR_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = GLYMUR_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = GLYMUR_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.id = GLYMUR_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = GLYMUR_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = GLYMUR_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_smmuv3_cfg = {
+	.name = "qhs_smmuv3_cfg",
+	.id = GLYMUR_SLAVE_SMMUV3_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = GLYMUR_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = GLYMUR_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = GLYMUR_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb2_0_cfg = {
+	.name = "qhs_usb2_0_cfg",
+	.id = GLYMUR_SLAVE_USB2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0_cfg = {
+	.name = "qhs_usb3_0_cfg",
+	.id = GLYMUR_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_1_cfg = {
+	.name = "qhs_usb3_1_cfg",
+	.id = GLYMUR_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_2_cfg = {
+	.name = "qhs_usb3_2_cfg",
+	.id = GLYMUR_SLAVE_USB3_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_mp_cfg = {
+	.name = "qhs_usb3_mp_cfg",
+	.id = GLYMUR_SLAVE_USB3_MP,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb4_0_cfg = {
+	.name = "qhs_usb4_0_cfg",
+	.id = GLYMUR_SLAVE_USB4_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb4_1_cfg = {
+	.name = "qhs_usb4_1_cfg",
+	.id = GLYMUR_SLAVE_USB4_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb4_2_cfg = {
+	.name = "qhs_usb4_2_cfg",
+	.id = GLYMUR_SLAVE_USB4_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = GLYMUR_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_cnoc_pcie_slave_east_cfg = {
+	.name = "qss_cnoc_pcie_slave_east_cfg",
+	.id = GLYMUR_SLAVE_CNOC_PCIE_SLAVE_EAST_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_CNOC_PCIE_EAST_SLAVE_CFG },
+};
+
+static struct qcom_icc_node qss_cnoc_pcie_slave_west_cfg = {
+	.name = "qss_cnoc_pcie_slave_west_cfg",
+	.id = GLYMUR_SLAVE_CNOC_PCIE_SLAVE_WEST_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_CNOC_PCIE_WEST_SLAVE_CFG },
+};
+
+static struct qcom_icc_node qss_lpass_qtb_cfg = {
+	.name = "qss_lpass_qtb_cfg",
+	.id = GLYMUR_SLAVE_LPASS_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_mnoc_cfg = {
+	.name = "qss_mnoc_cfg",
+	.id = GLYMUR_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qss_nsp_qtb_cfg = {
+	.name = "qss_nsp_qtb_cfg",
+	.id = GLYMUR_SLAVE_NSP_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_pcie_east_anoc_cfg = {
+	.name = "qss_pcie_east_anoc_cfg",
+	.id = GLYMUR_SLAVE_PCIE_EAST_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_PCIE_EAST_ANOC_CFG },
+};
+
+static struct qcom_icc_node qss_pcie_west_anoc_cfg = {
+	.name = "qss_pcie_west_anoc_cfg",
+	.id = GLYMUR_SLAVE_PCIE_WEST_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_PCIE_WEST_ANOC_CFG },
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = GLYMUR_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = GLYMUR_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = GLYMUR_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = GLYMUR_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_soccp = {
+	.name = "qhs_soccp",
+	.id = GLYMUR_SLAVE_SOCCP,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.id = GLYMUR_SLAVE_TME_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_apss = {
+	.name = "qns_apss",
+	.id = GLYMUR_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.id = GLYMUR_SLAVE_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_CNOC_CFG },
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.id = GLYMUR_SLAVE_BOOT_IMEM,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = GLYMUR_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_hscnoc_cnoc = {
+	.name = "qns_hscnoc_cnoc",
+	.id = GLYMUR_SLAVE_HSCNOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_HSCNOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = GLYMUR_SLAVE_LLCC,
+	.channels = 12,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie_east = {
+	.name = "qns_pcie_east",
+	.id = GLYMUR_SLAVE_PCIE_EAST,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_HSCNOC_PCIE_EAST },
+};
+
+static struct qcom_icc_node qns_pcie_west = {
+	.name = "qns_pcie_west",
+	.id = GLYMUR_SLAVE_PCIE_WEST,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_HSCNOC_PCIE_WEST },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.id = GLYMUR_SLAVE_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node qns_lpass_aggnoc = {
+	.name = "qns_lpass_aggnoc",
+	.id = GLYMUR_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_LPIAON_NOC },
+};
+
+static struct qcom_icc_node qns_lpi_aon_noc = {
+	.name = "qns_lpi_aon_noc",
+	.id = GLYMUR_SLAVE_LPICX_NOC_LPIAON_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_LPASS_LPINOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = GLYMUR_SLAVE_EBI1,
+	.channels = 8,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = GLYMUR_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = GLYMUR_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = GLYMUR_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_system_noc = {
+	.name = "qns_system_noc",
+	.id = GLYMUR_SLAVE_NSINOC_SYSTEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_NSINOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_nsinoc = {
+	.name = "srvc_nsinoc",
+	.id = GLYMUR_SLAVE_SERVICE_NSINOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_nsp_hscnoc = {
+	.name = "qns_nsp_hscnoc",
+	.id = GLYMUR_SLAVE_NSP0_HSC_NOC,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qns_oobmss_snoc = {
+	.name = "qns_oobmss_snoc",
+	.id = GLYMUR_SLAVE_OOBMSS_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_OOBMSS },
+};
+
+static struct qcom_icc_node qns_pcie_east_mem_noc = {
+	.name = "qns_pcie_east_mem_noc",
+	.id = GLYMUR_SLAVE_PCIE_EAST_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_PCIE_EAST },
+};
+
+static struct qcom_icc_node srvc_pcie_east_aggre_noc = {
+	.name = "srvc_pcie_east_aggre_noc",
+	.id = GLYMUR_SLAVE_SERVICE_PCIE_EAST_AGGRE_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_hscnoc_pcie_east_ms_mpu_cfg = {
+	.name = "qhs_hscnoc_pcie_east_ms_mpu_cfg",
+	.id = GLYMUR_SLAVE_HSCNOC_PCIE_EAST_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_pcie_east = {
+	.name = "srvc_pcie_east",
+	.id = GLYMUR_SLAVE_SERVICE_PCIE_EAST,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = GLYMUR_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = GLYMUR_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_5 = {
+	.name = "xs_pcie_5",
+	.id = GLYMUR_SLAVE_PCIE_5,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_pcie_west_mem_noc = {
+	.name = "qns_pcie_west_mem_noc",
+	.id = GLYMUR_SLAVE_PCIE_WEST_MEM_NOC,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_PCIE_WEST },
+};
+
+static struct qcom_icc_node srvc_pcie_west_aggre_noc = {
+	.name = "srvc_pcie_west_aggre_noc",
+	.id = GLYMUR_SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_hscnoc_pcie_west_ms_mpu_cfg = {
+	.name = "qhs_hscnoc_pcie_west_ms_mpu_cfg",
+	.id = GLYMUR_SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_pcie_west = {
+	.name = "srvc_pcie_west",
+	.id = GLYMUR_SLAVE_SERVICE_PCIE_WEST,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_2 = {
+	.name = "xs_pcie_2",
+	.id = GLYMUR_SLAVE_PCIE_2,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_3a = {
+	.name = "xs_pcie_3a",
+	.id = GLYMUR_SLAVE_PCIE_3A,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_3b = {
+	.name = "xs_pcie_3b",
+	.id = GLYMUR_SLAVE_PCIE_3B,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_4 = {
+	.name = "xs_pcie_4",
+	.id = GLYMUR_SLAVE_PCIE_4,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_6 = {
+	.name = "xs_pcie_6",
+	.id = GLYMUR_SLAVE_PCIE_6,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = GLYMUR_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 64,
+	.num_links = 1,
+	.links = { GLYMUR_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(0),
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
+	.enable_mask = BIT(0),
+	.num_nodes = 60,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_ahb2phy2,
+		   &qhs_ahb2phy3, &qhs_av1_enc_cfg,
+		   &qhs_camera_cfg, &qhs_clk_ctl,
+		   &qhs_crypto0_cfg, &qhs_gpuss_cfg,
+		   &qhs_imem_cfg, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_pcie2_cfg,
+		   &qhs_pcie3a_cfg, &qhs_pcie3b_cfg,
+		   &qhs_pcie4_cfg, &qhs_pcie5_cfg,
+		   &qhs_pcie6_cfg, &qhs_pcie_rscc,
+		   &qhs_pdm, &qhs_prng,
+		   &qhs_qdss_cfg, &qhs_qspi,
+		   &qhs_qup0, &qhs_qup1,
+		   &qhs_qup2, &qhs_sdc2,
+		   &qhs_sdc4, &qhs_smmuv3_cfg,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb2_0_cfg,
+		   &qhs_usb3_0_cfg, &qhs_usb3_1_cfg,
+		   &qhs_usb3_2_cfg, &qhs_usb3_mp_cfg,
+		   &qhs_usb4_0_cfg, &qhs_usb4_1_cfg,
+		   &qhs_usb4_2_cfg, &qhs_venus_cfg,
+		   &qss_cnoc_pcie_slave_east_cfg, &qss_cnoc_pcie_slave_west_cfg,
+		   &qss_lpass_qtb_cfg, &qss_mnoc_cfg,
+		   &qss_nsp_qtb_cfg, &qss_pcie_east_anoc_cfg,
+		   &qss_pcie_west_anoc_cfg, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg, &qnm_hscnoc_cnoc,
+		   &qhs_aoss, &qhs_ipc_router,
+		   &qhs_soccp, &qhs_tme_cfg,
+		   &qns_apss, &qss_cfg,
+		   &qxs_boot_imem, &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 1,
+	.nodes = { &qhs_display_cfg },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.enable_mask = BIT(0),
+	.num_nodes = 2,
+	.nodes = { &qnm_nsp, &qns_nsp_hscnoc },
+};
+
+static struct qcom_icc_bcm bcm_lp0 = {
+	.name = "LP0",
+	.num_nodes = 2,
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
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
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.enable_mask = BIT(0),
+	.num_nodes = 11,
+	.nodes = { &qnm_av1_enc, &qnm_camnoc_hf,
+		   &qnm_camnoc_icp, &qnm_camnoc_sf,
+		   &qnm_eva, &qnm_mdp,
+		   &qnm_vapss_hcp, &qnm_video,
+		   &qnm_video_cv_cpu, &qnm_video_v_cpu,
+		   &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup2 = {
+	.name = "QUP2",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.enable_mask = BIT(0),
+	.num_nodes = 18,
+	.nodes = { &alm_gpu_tcu, &alm_pcie_qtc,
+		   &alm_sys_tcu, &chm_apps,
+		   &qnm_aggre_noc_east, &qnm_gpu,
+		   &qnm_lpass, &qnm_mnoc_hf,
+		   &qnm_mnoc_sf, &qnm_nsp_noc,
+		   &qnm_pcie_east, &qnm_pcie_west,
+		   &qnm_snoc_sf, &qxm_wlan_q6,
+		   &xm_gic, &qns_hscnoc_cnoc,
+		   &qns_pcie_east, &qns_pcie_west },
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
+	.enable_mask = BIT(0),
+	.num_nodes = 1,
+	.nodes = { &qnm_oobmss },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre3_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.num_nodes = 1,
+	.nodes = { &qns_a4noc_hscnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.num_nodes = 4,
+	.nodes = { &qns_pcie_east_mem_noc, &qnm_hscnoc_pcie_east,
+		   &qns_pcie_west_mem_noc, &qnm_hscnoc_pcie_west },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_SOCCP_PROC] = &qxm_soccp,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc glymur_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_2] = &xm_usb3_2,
+	[MASTER_USB4_2] = &xm_usb4_2,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct qcom_icc_desc glymur_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+};
+
+static struct qcom_icc_node * const aggre3_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_SP] = &qxm_sp,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_USB2] = &xm_usb2_0,
+	[MASTER_USB3_MP] = &xm_usb3_mp,
+	[SLAVE_A3NOC_SNOC] = &qns_a3noc_snoc,
+};
+
+static const struct qcom_icc_desc glymur_aggre3_noc = {
+	.nodes = aggre3_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre3_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const aggre4_noc_bcms[] = {
+	&bcm_sn5,
+};
+
+static struct qcom_icc_node * const aggre4_noc_nodes[] = {
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[MASTER_USB3_1] = &xm_usb3_1,
+	[MASTER_USB4_0] = &xm_usb4_0,
+	[MASTER_USB4_1] = &xm_usb4_1,
+	[SLAVE_A4NOC_HSCNOC] = &qns_a4noc_hscnoc,
+};
+
+static const struct qcom_icc_desc glymur_aggre4_noc = {
+	.nodes = aggre4_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre4_noc_nodes),
+	.bcms = aggre4_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre4_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+	&bcm_qup2,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+};
+
+static const struct qcom_icc_desc glymur_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_AHB2PHY_2] = &qhs_ahb2phy2,
+	[SLAVE_AHB2PHY_3] = &qhs_ahb2phy3,
+	[SLAVE_AV1_ENC_CFG] = &qhs_av1_enc_cfg,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PCIE_2_CFG] = &qhs_pcie2_cfg,
+	[SLAVE_PCIE_3A_CFG] = &qhs_pcie3a_cfg,
+	[SLAVE_PCIE_3B_CFG] = &qhs_pcie3b_cfg,
+	[SLAVE_PCIE_4_CFG] = &qhs_pcie4_cfg,
+	[SLAVE_PCIE_5_CFG] = &qhs_pcie5_cfg,
+	[SLAVE_PCIE_6_CFG] = &qhs_pcie6_cfg,
+	[SLAVE_PCIE_RSCC] = &qhs_pcie_rscc,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SMMUV3_CFG] = &qhs_smmuv3_cfg,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB2] = &qhs_usb2_0_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0_cfg,
+	[SLAVE_USB3_1] = &qhs_usb3_1_cfg,
+	[SLAVE_USB3_2] = &qhs_usb3_2_cfg,
+	[SLAVE_USB3_MP] = &qhs_usb3_mp_cfg,
+	[SLAVE_USB4_0] = &qhs_usb4_0_cfg,
+	[SLAVE_USB4_1] = &qhs_usb4_1_cfg,
+	[SLAVE_USB4_2] = &qhs_usb4_2_cfg,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_CNOC_PCIE_SLAVE_EAST_CFG] = &qss_cnoc_pcie_slave_east_cfg,
+	[SLAVE_CNOC_PCIE_SLAVE_WEST_CFG] = &qss_cnoc_pcie_slave_west_cfg,
+	[SLAVE_LPASS_QTB_CFG] = &qss_lpass_qtb_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
+	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
+	[SLAVE_PCIE_EAST_ANOC_CFG] = &qss_pcie_east_anoc_cfg,
+	[SLAVE_PCIE_WEST_ANOC_CFG] = &qss_pcie_west_anoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc glymur_cnoc_cfg = {
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_HSCNOC_CNOC] = &qnm_hscnoc_cnoc,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_SOCCP] = &qhs_soccp,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_APPSS] = &qns_apss,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+};
+
+static const struct qcom_icc_desc glymur_cnoc_main = {
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_bcm * const hscnoc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const hscnoc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_PCIE_TCU] = &alm_pcie_qtc,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_AGGRE_NOC_EAST] = &qnm_aggre_noc_east,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_noc,
+	[MASTER_PCIE_EAST] = &qnm_pcie_east,
+	[MASTER_PCIE_WEST] = &qnm_pcie_west,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_WLAN_Q6] = &qxm_wlan_q6,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_HSCNOC_CNOC] = &qns_hscnoc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_PCIE_EAST] = &qns_pcie_east,
+	[SLAVE_PCIE_WEST] = &qns_pcie_west,
+};
+
+static const struct qcom_icc_desc glymur_hscnoc = {
+	.nodes = hscnoc_nodes,
+	.num_nodes = ARRAY_SIZE(hscnoc_nodes),
+	.bcms = hscnoc_bcms,
+	.num_bcms = ARRAY_SIZE(hscnoc_bcms),
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct qcom_icc_desc glymur_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const lpass_lpiaon_noc_bcms[] = {
+	&bcm_lp0,
+};
+
+static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
+	[MASTER_LPASS_LPINOC] = &qnm_lpass_lpinoc,
+	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
+};
+
+static const struct qcom_icc_desc glymur_lpass_lpiaon_noc = {
+	.nodes = lpass_lpiaon_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
+	.bcms = lpass_lpiaon_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpiaon_noc_bcms),
+};
+
+static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qnm_lpinoc_dsp_qns4m,
+	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
+};
+
+static const struct qcom_icc_desc glymur_lpass_lpicx_noc = {
+	.nodes = lpass_lpicx_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
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
+static const struct qcom_icc_desc glymur_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_AV1_ENC] = &qnm_av1_enc,
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_EVA] = &qnm_eva,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_CDSP_HCP] = &qnm_vapss_hcp,
+	[MASTER_VIDEO] = &qnm_video,
+	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[MASTER_CNOC_MNOC_CFG] = &qsm_mnoc_cfg,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static const struct qcom_icc_desc glymur_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_node * const nsinoc_nodes[] = {
+	[MASTER_CPUCP] = &xm_cpucp,
+	[SLAVE_NSINOC_SYSTEM_NOC] = &qns_system_noc,
+	[SLAVE_SERVICE_NSINOC] = &srvc_nsinoc,
+};
+
+static const struct qcom_icc_desc glymur_nsinoc = {
+	.nodes = nsinoc_nodes,
+	.num_nodes = ARRAY_SIZE(nsinoc_nodes),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qnm_nsp,
+	[SLAVE_NSP0_HSC_NOC] = &qns_nsp_hscnoc,
+};
+
+static const struct qcom_icc_desc glymur_nsp_noc = {
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_node * const oobm_ss_noc_nodes[] = {
+	[MASTER_OOBMSS_SP_PROC] = &xm_mem_sp,
+	[SLAVE_OOBMSS_SNOC] = &qns_oobmss_snoc,
+};
+
+static const struct qcom_icc_desc glymur_oobm_ss_noc = {
+	.nodes = oobm_ss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(oobm_ss_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const pcie_east_anoc_bcms[] = {
+	&bcm_sn6,
+};
+
+static struct qcom_icc_node * const pcie_east_anoc_nodes[] = {
+	[MASTER_PCIE_EAST_ANOC_CFG] = &qsm_pcie_east_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie_0,
+	[MASTER_PCIE_1] = &xm_pcie_1,
+	[MASTER_PCIE_5] = &xm_pcie_5,
+	[SLAVE_PCIE_EAST_MEM_NOC] = &qns_pcie_east_mem_noc,
+	[SLAVE_SERVICE_PCIE_EAST_AGGRE_NOC] = &srvc_pcie_east_aggre_noc,
+};
+
+static const struct qcom_icc_desc glymur_pcie_east_anoc = {
+	.nodes = pcie_east_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_east_anoc_nodes),
+	.bcms = pcie_east_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_east_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_east_slv_noc_bcms[] = {
+	&bcm_sn6,
+};
+
+static struct qcom_icc_node * const pcie_east_slv_noc_nodes[] = {
+	[MASTER_HSCNOC_PCIE_EAST] = &qnm_hscnoc_pcie_east,
+	[MASTER_CNOC_PCIE_EAST_SLAVE_CFG] = &qsm_cnoc_pcie_east_slave_cfg,
+	[SLAVE_HSCNOC_PCIE_EAST_MS_MPU_CFG] = &qhs_hscnoc_pcie_east_ms_mpu_cfg,
+	[SLAVE_SERVICE_PCIE_EAST] = &srvc_pcie_east,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_PCIE_5] = &xs_pcie_5,
+};
+
+static const struct qcom_icc_desc glymur_pcie_east_slv_noc = {
+	.nodes = pcie_east_slv_noc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_east_slv_noc_nodes),
+	.bcms = pcie_east_slv_noc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_east_slv_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_west_anoc_bcms[] = {
+	&bcm_sn6,
+};
+
+static struct qcom_icc_node * const pcie_west_anoc_nodes[] = {
+	[MASTER_PCIE_WEST_ANOC_CFG] = &qsm_pcie_west_anoc_cfg,
+	[MASTER_PCIE_2] = &xm_pcie_2,
+	[MASTER_PCIE_3A] = &xm_pcie_3a,
+	[MASTER_PCIE_3B] = &xm_pcie_3b,
+	[MASTER_PCIE_4] = &xm_pcie_4,
+	[MASTER_PCIE_6] = &xm_pcie_6,
+	[SLAVE_PCIE_WEST_MEM_NOC] = &qns_pcie_west_mem_noc,
+	[SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC] = &srvc_pcie_west_aggre_noc,
+};
+
+static const struct qcom_icc_desc glymur_pcie_west_anoc = {
+	.nodes = pcie_west_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_west_anoc_nodes),
+	.bcms = pcie_west_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_west_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_west_slv_noc_bcms[] = {
+	&bcm_sn6,
+};
+
+static struct qcom_icc_node * const pcie_west_slv_noc_nodes[] = {
+	[MASTER_HSCNOC_PCIE_WEST] = &qnm_hscnoc_pcie_west,
+	[MASTER_CNOC_PCIE_WEST_SLAVE_CFG] = &qsm_cnoc_pcie_west_slave_cfg,
+	[SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG] = &qhs_hscnoc_pcie_west_ms_mpu_cfg,
+	[SLAVE_SERVICE_PCIE_WEST] = &srvc_pcie_west,
+	[SLAVE_PCIE_2] = &xs_pcie_2,
+	[SLAVE_PCIE_3A] = &xs_pcie_3a,
+	[SLAVE_PCIE_3B] = &xs_pcie_3b,
+	[SLAVE_PCIE_4] = &xs_pcie_4,
+	[SLAVE_PCIE_6] = &xs_pcie_6,
+};
+
+static const struct qcom_icc_desc glymur_pcie_west_slv_noc = {
+	.nodes = pcie_west_slv_noc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_west_slv_noc_nodes),
+	.bcms = pcie_west_slv_noc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_west_slv_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_A3NOC_SNOC] = &qnm_aggre3_noc,
+	[MASTER_NSINOC_SNOC] = &qnm_nsi_noc,
+	[MASTER_OOBMSS] = &qnm_oobmss,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc glymur_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,glymur-aggre1-noc",
+	  .data = &glymur_aggre1_noc},
+	{ .compatible = "qcom,glymur-aggre2-noc",
+	  .data = &glymur_aggre2_noc},
+	{ .compatible = "qcom,glymur-aggre3-noc",
+	  .data = &glymur_aggre3_noc},
+	{ .compatible = "qcom,glymur-aggre4-noc",
+	  .data = &glymur_aggre4_noc},
+	{ .compatible = "qcom,glymur-clk-virt",
+	  .data = &glymur_clk_virt},
+	{ .compatible = "qcom,glymur-cnoc-cfg",
+	  .data = &glymur_cnoc_cfg},
+	{ .compatible = "qcom,glymur-cnoc-main",
+	  .data = &glymur_cnoc_main},
+	{ .compatible = "qcom,glymur-hscnoc",
+	  .data = &glymur_hscnoc},
+	{ .compatible = "qcom,glymur-lpass-ag-noc",
+	  .data = &glymur_lpass_ag_noc},
+	{ .compatible = "qcom,glymur-lpass-lpiaon-noc",
+	  .data = &glymur_lpass_lpiaon_noc},
+	{ .compatible = "qcom,glymur-lpass-lpicx-noc",
+	  .data = &glymur_lpass_lpicx_noc},
+	{ .compatible = "qcom,glymur-mc-virt",
+	  .data = &glymur_mc_virt},
+	{ .compatible = "qcom,glymur-mmss-noc",
+	  .data = &glymur_mmss_noc},
+	{ .compatible = "qcom,glymur-nsinoc",
+	  .data = &glymur_nsinoc},
+	{ .compatible = "qcom,glymur-nsp-noc",
+	  .data = &glymur_nsp_noc},
+	{ .compatible = "qcom,glymur-oobm-ss-noc",
+	  .data = &glymur_oobm_ss_noc},
+	{ .compatible = "qcom,glymur-pcie-east-anoc",
+	  .data = &glymur_pcie_east_anoc},
+	{ .compatible = "qcom,glymur-pcie-east-slv-noc",
+	  .data = &glymur_pcie_east_slv_noc},
+	{ .compatible = "qcom,glymur-pcie-west-anoc",
+	  .data = &glymur_pcie_west_anoc},
+	{ .compatible = "qcom,glymur-pcie-west-slv-noc",
+	  .data = &glymur_pcie_west_slv_noc},
+	{ .compatible = "qcom,glymur-system-noc",
+	  .data = &glymur_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-glymur",
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
+MODULE_DESCRIPTION("GLYMUR NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/glymur.h b/drivers/interconnect/qcom/glymur.h
new file mode 100644
index 000000000000..cf0ec91775ce
--- /dev/null
+++ b/drivers/interconnect/qcom/glymur.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_GLYMUR_H
+#define __DRIVERS_INTERCONNECT_QCOM_GLYMUR_H
+
+#define GLYMUR_MASTER_GPU_TCU				0
+#define GLYMUR_MASTER_PCIE_TCU				1
+#define GLYMUR_MASTER_SYS_TCU				2
+#define GLYMUR_MASTER_APPSS_PROC			3
+#define GLYMUR_MASTER_LLCC				4
+#define GLYMUR_MASTER_QSPI_0				5
+#define GLYMUR_MASTER_QUP_0				6
+#define GLYMUR_MASTER_QUP_1				7
+#define GLYMUR_MASTER_QUP_2				8
+#define GLYMUR_MASTER_A1NOC_SNOC			9
+#define GLYMUR_MASTER_A2NOC_SNOC			10
+#define GLYMUR_MASTER_A3NOC_SNOC			11
+#define GLYMUR_MASTER_AGGRE_NOC_EAST			12
+#define GLYMUR_MASTER_AV1_ENC				13
+#define GLYMUR_MASTER_CAMNOC_HF				14
+#define GLYMUR_MASTER_CAMNOC_ICP			15
+#define GLYMUR_MASTER_CAMNOC_SF				16
+#define GLYMUR_MASTER_EVA				17
+#define GLYMUR_MASTER_GFX3D				18
+#define GLYMUR_MASTER_HSCNOC_CNOC			19
+#define GLYMUR_MASTER_HSCNOC_PCIE_EAST			20
+#define GLYMUR_MASTER_HSCNOC_PCIE_WEST			21
+#define GLYMUR_MASTER_LPASS_GEM_NOC			22
+#define GLYMUR_MASTER_LPASS_LPINOC			23
+#define GLYMUR_MASTER_LPIAON_NOC			24
+#define GLYMUR_MASTER_LPASS_PROC			25
+#define GLYMUR_MASTER_MDP				26
+#define GLYMUR_MASTER_MNOC_HF_MEM_NOC			27
+#define GLYMUR_MASTER_MNOC_SF_MEM_NOC			28
+#define GLYMUR_MASTER_NSINOC_SNOC			29
+#define GLYMUR_MASTER_CDSP_PROC				30
+#define GLYMUR_MASTER_COMPUTE_NOC			31
+#define GLYMUR_MASTER_OOBMSS				32
+#define GLYMUR_MASTER_PCIE_EAST				33
+#define GLYMUR_MASTER_PCIE_WEST				34
+#define GLYMUR_MASTER_SNOC_SF_MEM_NOC			35
+#define GLYMUR_MASTER_CDSP_HCP				36
+#define GLYMUR_MASTER_VIDEO				37
+#define GLYMUR_MASTER_VIDEO_CV_PROC			38
+#define GLYMUR_MASTER_VIDEO_V_PROC			39
+#define GLYMUR_MASTER_CNOC_CFG				40
+#define GLYMUR_MASTER_CNOC_PCIE_EAST_SLAVE_CFG		41
+#define GLYMUR_MASTER_CNOC_PCIE_WEST_SLAVE_CFG		42
+#define GLYMUR_MASTER_CNOC_MNOC_CFG			43
+#define GLYMUR_MASTER_PCIE_EAST_ANOC_CFG		44
+#define GLYMUR_MASTER_PCIE_WEST_ANOC_CFG		45
+#define GLYMUR_MASTER_QUP_CORE_0			46
+#define GLYMUR_MASTER_QUP_CORE_1			47
+#define GLYMUR_MASTER_QUP_CORE_2			48
+#define GLYMUR_MASTER_CRYPTO				49
+#define GLYMUR_MASTER_SOCCP_PROC			50
+#define GLYMUR_MASTER_SP				51
+#define GLYMUR_MASTER_WLAN_Q6				52
+#define GLYMUR_MASTER_CPUCP				53
+#define GLYMUR_MASTER_GIC				54
+#define GLYMUR_MASTER_OOBMSS_SP_PROC			55
+#define GLYMUR_MASTER_PCIE_0				56
+#define GLYMUR_MASTER_PCIE_1				57
+#define GLYMUR_MASTER_PCIE_2				58
+#define GLYMUR_MASTER_PCIE_3A				59
+#define GLYMUR_MASTER_PCIE_3B				60
+#define GLYMUR_MASTER_PCIE_4				61
+#define GLYMUR_MASTER_PCIE_5				62
+#define GLYMUR_MASTER_PCIE_6				63
+#define GLYMUR_MASTER_QDSS_ETR				64
+#define GLYMUR_MASTER_QDSS_ETR_1			65
+#define GLYMUR_MASTER_SDCC_2				66
+#define GLYMUR_MASTER_SDCC_4				67
+#define GLYMUR_MASTER_UFS_MEM				68
+#define GLYMUR_MASTER_USB2				69
+#define GLYMUR_MASTER_USB3_0				70
+#define GLYMUR_MASTER_USB3_1				71
+#define GLYMUR_MASTER_USB3_2				72
+#define GLYMUR_MASTER_USB3_MP				73
+#define GLYMUR_MASTER_USB4_0				74
+#define GLYMUR_MASTER_USB4_1				75
+#define GLYMUR_MASTER_USB4_2				76
+#define GLYMUR_SLAVE_EBI1				77
+#define GLYMUR_SLAVE_AHB2PHY_SOUTH			78
+#define GLYMUR_SLAVE_AHB2PHY_NORTH			79
+#define GLYMUR_SLAVE_AHB2PHY_2				80
+#define GLYMUR_SLAVE_AHB2PHY_3				81
+#define GLYMUR_SLAVE_AOSS				82
+#define GLYMUR_SLAVE_AV1_ENC_CFG			83
+#define GLYMUR_SLAVE_CAMERA_CFG				84
+#define GLYMUR_SLAVE_CLK_CTL				85
+#define GLYMUR_SLAVE_CRYPTO_0_CFG			86
+#define GLYMUR_SLAVE_DISPLAY_CFG			87
+#define GLYMUR_SLAVE_GFX3D_CFG				88
+#define GLYMUR_SLAVE_HSCNOC_PCIE_EAST_MS_MPU_CFG	89
+#define GLYMUR_SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG	90
+#define GLYMUR_SLAVE_IMEM_CFG				91
+#define GLYMUR_SLAVE_IPC_ROUTER_CFG			92
+#define GLYMUR_SLAVE_PCIE_0_CFG				93
+#define GLYMUR_SLAVE_PCIE_1_CFG				94
+#define GLYMUR_SLAVE_PCIE_2_CFG				95
+#define GLYMUR_SLAVE_PCIE_3A_CFG			96
+#define GLYMUR_SLAVE_PCIE_3B_CFG			97
+#define GLYMUR_SLAVE_PCIE_4_CFG				98
+#define GLYMUR_SLAVE_PCIE_5_CFG				99
+#define GLYMUR_SLAVE_PCIE_6_CFG				100
+#define GLYMUR_SLAVE_PCIE_RSCC				101
+#define GLYMUR_SLAVE_PDM				102
+#define GLYMUR_SLAVE_PRNG				103
+#define GLYMUR_SLAVE_QDSS_CFG				104
+#define GLYMUR_SLAVE_QSPI_0				105
+#define GLYMUR_SLAVE_QUP_0				106
+#define GLYMUR_SLAVE_QUP_1				107
+#define GLYMUR_SLAVE_QUP_2				108
+#define GLYMUR_SLAVE_SDCC_2				109
+#define GLYMUR_SLAVE_SDCC_4				110
+#define GLYMUR_SLAVE_SMMUV3_CFG				111
+#define GLYMUR_SLAVE_SOCCP				112
+#define GLYMUR_SLAVE_TCSR				113
+#define GLYMUR_SLAVE_TLMM				114
+#define GLYMUR_SLAVE_TME_CFG				115
+#define GLYMUR_SLAVE_UFS_MEM_CFG			116
+#define GLYMUR_SLAVE_USB2				117
+#define GLYMUR_SLAVE_USB3_0				118
+#define GLYMUR_SLAVE_USB3_1				119
+#define GLYMUR_SLAVE_USB3_2				120
+#define GLYMUR_SLAVE_USB3_MP				121
+#define GLYMUR_SLAVE_USB4_0				122
+#define GLYMUR_SLAVE_USB4_1				123
+#define GLYMUR_SLAVE_USB4_2				124
+#define GLYMUR_SLAVE_VENUS_CFG				125
+#define GLYMUR_SLAVE_A1NOC_SNOC				126
+#define GLYMUR_SLAVE_A2NOC_SNOC				127
+#define GLYMUR_SLAVE_A3NOC_SNOC				128
+#define GLYMUR_SLAVE_A4NOC_HSCNOC			129
+#define GLYMUR_SLAVE_APPSS				130
+#define GLYMUR_SLAVE_SNOC_GEM_NOC_SF			131
+#define GLYMUR_SLAVE_HSCNOC_CNOC			132
+#define GLYMUR_SLAVE_LLCC				133
+#define GLYMUR_SLAVE_LPASS_GEM_NOC			134
+#define GLYMUR_SLAVE_LPIAON_NOC_LPASS_AG_NOC		135
+#define GLYMUR_SLAVE_LPICX_NOC_LPIAON_NOC		136
+#define GLYMUR_SLAVE_MNOC_HF_MEM_NOC			137
+#define GLYMUR_SLAVE_MNOC_SF_MEM_NOC			138
+#define GLYMUR_SLAVE_NSP0_HSC_NOC			139
+#define GLYMUR_SLAVE_OOBMSS_SNOC			140
+#define GLYMUR_SLAVE_PCIE_EAST				141
+#define GLYMUR_SLAVE_PCIE_EAST_MEM_NOC			142
+#define GLYMUR_SLAVE_PCIE_WEST				143
+#define GLYMUR_SLAVE_PCIE_WEST_MEM_NOC			144
+#define GLYMUR_SLAVE_NSINOC_SYSTEM_NOC			145
+#define GLYMUR_SLAVE_CNOC_CFG				146
+#define GLYMUR_SLAVE_CNOC_PCIE_SLAVE_EAST_CFG		147
+#define GLYMUR_SLAVE_CNOC_PCIE_SLAVE_WEST_CFG		148
+#define GLYMUR_SLAVE_LPASS_QTB_CFG			149
+#define GLYMUR_SLAVE_CNOC_MNOC_CFG			150
+#define GLYMUR_SLAVE_NSP_QTB_CFG			151
+#define GLYMUR_SLAVE_PCIE_EAST_ANOC_CFG			152
+#define GLYMUR_SLAVE_PCIE_WEST_ANOC_CFG			153
+#define GLYMUR_SLAVE_QUP_CORE_0				154
+#define GLYMUR_SLAVE_QUP_CORE_1				155
+#define GLYMUR_SLAVE_QUP_CORE_2				156
+#define GLYMUR_SLAVE_BOOT_IMEM				157
+#define GLYMUR_SLAVE_IMEM				158
+#define GLYMUR_SLAVE_SERVICE_MNOC			159
+#define GLYMUR_SLAVE_SERVICE_NSINOC			160
+#define GLYMUR_SLAVE_SERVICE_PCIE_EAST			161
+#define GLYMUR_SLAVE_SERVICE_PCIE_EAST_AGGRE_NOC	162
+#define GLYMUR_SLAVE_SERVICE_PCIE_WEST			163
+#define GLYMUR_SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC	164
+#define GLYMUR_SLAVE_PCIE_0				165
+#define GLYMUR_SLAVE_PCIE_1				166
+#define GLYMUR_SLAVE_PCIE_2				167
+#define GLYMUR_SLAVE_PCIE_3A				168
+#define GLYMUR_SLAVE_PCIE_3B				169
+#define GLYMUR_SLAVE_PCIE_4				170
+#define GLYMUR_SLAVE_PCIE_5				171
+#define GLYMUR_SLAVE_PCIE_6				172
+#define GLYMUR_SLAVE_QDSS_STM				173
+#define GLYMUR_SLAVE_TCU				174
+
+#endif
-- 
2.34.1


