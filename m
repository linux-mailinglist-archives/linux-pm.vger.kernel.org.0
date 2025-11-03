Return-Path: <linux-pm+bounces-37288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66276C2AA53
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3396A4EFB7E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF92E7BB3;
	Mon,  3 Nov 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HvqaK77W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLGx/6V2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7B2C08C5
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159939; cv=none; b=JdYO+gqZgtF4lxyP/NUMR0mQv/s+pm4y5qr7hE63lwbqQEdVUiY/IYK7VLBP4eIEiWGqG5yzpDHfVnqKl0DBiJHtS3gRWe/pm/qLshg3Pb3wm4FNFI5BV5aZ0YFUA74as6wM8YGKRvp1s1/ni6jfR3c3skKbwUnuV9E3Yi0iiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159939; c=relaxed/simple;
	bh=sNmifG2/6t3g7m7Q5sAYygsSzhcnFyw6aUfyd6+lv8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrxnJPFUgTWex3EYuE2lgGr0hP2X0tnxPT17dYJBEfLqMK2+5mxfEKIA4sT4okvlSnFEHOQg0bX3oKLLKe1vaW2XL7Yyp7xSk0pCML4tdAhlf1qQcZ7RuSqw4efNmDFUyOJSilbD8ZgpViTlk4WIx18TsMXMDxU2V7Am1822bOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HvqaK77W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLGx/6V2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A33EPRh1959441
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 08:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8qpntALslbc+K+JNAlMK4H4GS6jt0GO5pbqDN9Ie/ks=; b=HvqaK77WG3idAd4x
	mNkdx1P7e91BjEfiazpn9sswHRFN1voa8Ogyh937c8cOv08JTCJWNIAAPgGoxP1Y
	awOn4teMrQ9+f27BQCI+rkpf4GqXJ1tWqlW8w44R95o12fQXVHdg7+pxXjnixvTS
	19DuXLMeX7Wrj0zW/NkWNz0XA+rkq8xrOPXz2c8iX2GvszXvJKoiQ7uJi/zH9GX5
	7H2JNaRwu4YT11ReS5LFl5Zx9/UIwXWjG336pdVZ3Q5TnlOw4hkGk4JZqmI6OuWs
	eOy1rvH8EZBh3Qe3GqvpyXhBukqn/NfzN3VSGo716nDveGAcF6wQI2VQccxQ8OJo
	PEO2VA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6ma8ruxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 08:52:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da21394adso4795895a91.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762159927; x=1762764727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qpntALslbc+K+JNAlMK4H4GS6jt0GO5pbqDN9Ie/ks=;
        b=MLGx/6V29+hP109SEwUBMRFnBQDnS6AMMz9vfapXSF1jWorI9Ft+WuzecQMeyOq2Wd
         7TE5qJ3LwnSkuMJRgqArjRfrd+ZS8addL6fqkiSOpuAUD+CPXLrX9CMcRaagyGIEwsGI
         /A9L7rGBA3zc6MeKWQLjFpo0RYc4WObE+WTn+HT2rvAEVxfwEhjVO/i28n0gu/B+vuoY
         Bz6lPu34itKl8pQooPeuInpKMDBP5bKOJHOzzKjDpahoty47nJDNTTUOLQtqyGQMPfPa
         fbq9QBPYAT2Fuku0vqwnHgwTSjhqq/FaRtsICG99WE/zXHYtyCDvYJfTGsWhZ6R9Ob1L
         h2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159927; x=1762764727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qpntALslbc+K+JNAlMK4H4GS6jt0GO5pbqDN9Ie/ks=;
        b=wNy6UBoiJsed0LzoSNKGdqdGw58KZUfVEzyoTbN+BwLyrIp44KwotSkDCMuktNMo99
         kdBneFihupclyf23gk6JcCTIPI2A9+KPliEhSB9Ip/J87u7EJvtiCAJPGxZpG/Wh9cd/
         ZkNsafJqaaHYL2J3CPoG0rncxkttI5b+iCmF+R6hDk/KMTs+PAeRhXqutPoKC5ocmch/
         q3FmdQZ4/hLIk2PvXAp+zf+C4mACDr5rZER5DjpN4u0iZO79zfx4m4/6UX/p8KFnI4y0
         6H7YOi/jf0AnVlnK/9YnZL73qLFubTMwvh7kOd0FRJV+2MFy/pqxkgqGSNeNnDWZSkDJ
         tdig==
X-Forwarded-Encrypted: i=1; AJvYcCWC2oxj6ToiP2ctCbIjQMk63m4W6/gfCR0Uw/MC7F+g86zkX/KUlRpk6saHSxf9itUZVmafefNEnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmRwvG+f5JEhE0OXdVs/zutg5W4tawhMWjZAK1ruXADeono+X
	3Bwh40G27YZVLjNMNttQ9urQWTBfnJPfMyNGxc7ibW1JFzjrxfJlEldpcdKqz48GWmq450iYid+
	ST9ah4iVk9oJMIH0BDlMnS6b5XqzrNK7Q7BoLzwKonB06bGZacO8KbZ1xvLhUhITUzgTq6Q==
X-Gm-Gg: ASbGncs1YvO2MqcOve9B9Kp9RTjvuuMOmE6ii0p8BaMKF9Gba1Un0flCEnxxKvUWMuv
	2lAsIKci4+MIJk1avJ6A5EKFkuudDrg0lhF7g2iTyBi54dhJ/at7fS6gTejOdZh/RpnL9FEeD/+
	LhkDlCeOPmKv+YlcB1qym22zirnrLHKZB8RAEB3pn46SraF/Jh1RuFe7CTnKbagBvQHFW3SaW/G
	WAvNWjeOsgiDgsMP18Anrfw3GffZpNtTNX5aPq/JloQXj2IaBnBqRfYwx0pd+Ir4/d2RRbWasM+
	pWYgNM5KaBZ9xpQkbiLwkKKiYuRRLcldvvn+98ynrvKSAHL1Ohnd3QBVePukB13h6O7GcQp9CDl
	DIoc00wdzD6MGc0XmB/Pz3A==
X-Received: by 2002:a17:90a:dfcc:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-340830897e6mr14512172a91.25.1762159926630;
        Mon, 03 Nov 2025 00:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmE8WbLRvmPb1ctZXl5d3UiG7zZPyHmcn8Yu1d11eWtCiAndAoBy1dz2Lsrm2BdA+BgbedcA==
X-Received: by 2002:a17:90a:dfcc:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-340830897e6mr14512128a91.25.1762159925434;
        Mon, 03 Nov 2025 00:52:05 -0800 (PST)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599676d6sm255142a91.9.2025.11.03.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:52:04 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 08:51:19 +0000
Subject: [PATCH v5 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-knp-interconnect-v5-2-f9929faddb66@oss.qualcomm.com>
References: <20251103-knp-interconnect-v5-0-f9929faddb66@oss.qualcomm.com>
In-Reply-To: <20251103-knp-interconnect-v5-0-f9929faddb66@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ofJMaMj724gSGWjFqp9mSktA2zXRBifZ
X-Authority-Analysis: v=2.4 cv=UJDQ3Sfy c=1 sm=1 tr=0 ts=69086d39 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yc08WvmUPKIktmOZTlgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: ofJMaMj724gSGWjFqp9mSktA2zXRBifZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4MSBTYWx0ZWRfXw7NzLpyin6LU
 VoVSuYjclqJIcR/dfalWkMXJGecSCrte8XXUMJvyKWn1GK4FdKlc62IalWYnnGzGXcMOxWZFIdi
 TMNuaon0QpW35jDCKIZ6cTQLQrtiDdtWDtlVibaLJRRSuitW46PfKMvnSeUjRo8B9xV+uLL3zu3
 CRP69Dbx4q6bBRcJpiO/5J4iUW6vC4j9ifC+oyE0hDlz2goDCwRbyCZDoLO0tFefeGnjgd+mtkF
 TQdiaOxx546gqcq+rIphCUTHs6ggo6v2mS70HnA6083sAlgKS8NYn/Qi4UfWI74N/eSElJTIcZ7
 eKSnH4YpIFqR/6Gd+BrgzPoJG9Z8HZgvLqxN23YwMpfA5jC+6IUIVKTBVHHYDlE1EO08nl91Ust
 /fKYYx1ChKQfTzOsiK9RPu1pYOMyCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030081

Add driver for the Qualcomm interconnect buses found in Kaanapali
based platforms. The topology consists of several NoCs that are
controlled by a remote processor that collects the aggregated
bandwidth for each master-slave pairs.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig     |    9 +
 drivers/interconnect/qcom/Makefile    |    2 +
 drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
 3 files changed, 1879 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 5b4bb9f1382b2fd3c14b6f1ea35c43ac9fddd803..bb1cb8a640c17be458fd0190f7773cf7fa280090 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -17,6 +17,15 @@ config INTERCONNECT_QCOM_GLYMUR
          This is a driver for the Qualcomm Network-on-Chip on glymur-based
          platforms.
 
+config INTERCONNECT_QCOM_KAANAPALI
+	tristate "Qualcomm KAANAPALI interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on kaanapali-based
+	  platforms.
+
 config INTERCONNECT_QCOM_MSM8909
 	tristate "Qualcomm MSM8909 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index cf8cba73ee3e61839180d0c0a7c127dce848bdf2..6eedff043b412a4a73fe7524b0161da097bf3a4c 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
 interconnect_qcom-y			:= icc-common.o
 icc-bcm-voter-objs			:= bcm-voter.o
 qnoc-glymur-objs			:= glymur.o
+qnoc-kaanapali-objs			:= kaanapali.o
 qnoc-milos-objs				:= milos.o
 qnoc-msm8909-objs			:= msm8909.o
 qnoc-msm8916-objs			:= msm8916.o
@@ -48,6 +49,7 @@ icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_GLYMUR) += qnoc-glymur.o
+obj-$(CONFIG_INTERCONNECT_QCOM_KAANAPALI) += qnoc-kaanapali.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MILOS) += qnoc-milos.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8909) += qnoc-msm8909.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
diff --git a/drivers/interconnect/qcom/kaanapali.c b/drivers/interconnect/qcom/kaanapali.c
new file mode 100644
index 0000000000000000000000000000000000000000..c6b4902e057f5f6c2a9db3ca018182c1cda156e9
--- /dev/null
+++ b/drivers/interconnect/qcom/kaanapali.c
@@ -0,0 +1,1868 @@
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
+#include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup3_core_slave = {
+	.name = "qup3_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup4_core_slave = {
+	.name = "qup4_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_eva_cfg = {
+	.name = "qhs_eva_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_i2c = {
+	.name = "qhs_i2c",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_i3c_ibi0_cfg = {
+	.name = "qhs_i3c_ibi0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_i3c_ibi1_cfg = {
+	.name = "qhs_i3c_ibi1_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_cfg = {
+	.name = "qhs_pcie_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup3 = {
+	.name = "qhs_qup3",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup4 = {
+	.name = "qhs_qup4",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_spss_cfg = {
+	.name = "qhs_spss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router_fence = {
+	.name = "qhs_ipc_router_fence",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_soccp = {
+	.name = "qhs_soccp",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_apss = {
+	.name = "qns_apss",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qss_ddrss_cfg = {
+	.name = "qss_ddrss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie = {
+	.name = "xs_pcie",
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_pcie_aggre_noc = {
+	.name = "srvc_pcie_aggre_noc",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qup0_core_slave },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qup1_core_slave },
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qup2_core_slave },
+};
+
+static struct qcom_icc_node qup3_core_master = {
+	.name = "qup3_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qup3_core_slave },
+};
+
+static struct qcom_icc_node qup4_core_master = {
+	.name = "qup4_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qup4_core_slave },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &ebi },
+};
+
+static struct qcom_icc_node qsm_mnoc_cfg = {
+	.name = "qsm_mnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc },
+};
+
+static struct qcom_icc_node qsm_pcie_anoc_cfg = {
+	.name = "qsm_pcie_anoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &srvc_pcie_aggre_noc },
+};
+
+static struct qcom_icc_node qss_mnoc_cfg = {
+	.name = "qss_mnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qsm_mnoc_cfg },
+};
+
+static struct qcom_icc_node qss_pcie_anoc_cfg = {
+	.name = "qss_pcie_anoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qsm_pcie_anoc_cfg },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &llcc_mc },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_pcie },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 35,
+	.link_nodes = (struct qcom_icc_node *[]) { &qhs_ahb2phy0, &qhs_ahb2phy1,
+		      &qhs_camera_cfg, &qhs_clk_ctl,
+		      &qhs_crypto0_cfg, &qhs_display_cfg,
+		      &qhs_eva_cfg, &qhs_gpuss_cfg,
+		      &qhs_i2c, &qhs_i3c_ibi0_cfg,
+		      &qhs_i3c_ibi1_cfg, &qhs_imem_cfg,
+		      &qhs_ipc_router, &qhs_mss_cfg,
+		      &qhs_pcie_cfg, &qhs_prng,
+		      &qhs_qdss_cfg, &qhs_qspi,
+		      &qhs_qup1, &qhs_qup2,
+		      &qhs_qup3, &qhs_qup4,
+		      &qhs_sdc2, &qhs_sdc4,
+		      &qhs_spss_cfg, &qhs_tcsr,
+		      &qhs_tlmm, &qhs_ufs_mem_cfg,
+		      &qhs_usb3, &qhs_venus_cfg,
+		      &qhs_vsense_ctrl_cfg, &qss_mnoc_cfg,
+		      &qss_pcie_anoc_cfg, &xs_qdss_stm,
+		      &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_node qnm_qpace = {
+	.name = "qnm_qpace",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14e000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x145000 },
+		.prio = 4,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qsm_cfg },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 10,
+	.link_nodes = (struct qcom_icc_node *[]) { &qhs_aoss, &qhs_ipa,
+		      &qhs_ipc_router_fence, &qhs_soccp,
+		      &qhs_tme_cfg, &qns_apss,
+		      &qss_cfg, &qss_ddrss_cfg,
+		      &qxs_boot_imem, &qxs_imem },
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cnoc },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13d000 },
+		.prio = 1,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13f000 },
+		.prio = 6,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 2,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x31000, 0xb1000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_lpass_gemnoc = {
+	.name = "qnm_lpass_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x141000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x33000, 0xb3000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x35000, 0xb5000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_nsp_gemnoc = {
+	.name = "qnm_nsp_gemnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x37000, 0xb7000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x143000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 2,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x147000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qnm_wlan_q6 = {
+	.name = "qnm_wlan_q6",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+		      &qns_pcie },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_gemnoc },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf },
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_nsp_gemnoc },
+};
+
+static struct qcom_icc_node qns_pcie_gemnoc = {
+	.name = "qns_pcie_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_sf },
+};
+
+static struct qcom_icc_node qnm_lpiaon_noc = {
+	.name = "qnm_lpiaon_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpass_ag_noc_gemnoc },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x2a000, 0x2b000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qnm_camnoc_nrt_icp_sf = {
+	.name = "qnm_camnoc_nrt_icp_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2c000 },
+		.prio = 4,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_rt_cdm_sf = {
+	.name = "qnm_camnoc_rt_cdm_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x38000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x2d000, 0x2e000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x2f000, 0x30000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qnm_mdss_dcp = {
+	.name = "qnm_mdss_dcp",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x39000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_vapss_hcp = {
+	.name = "qnm_vapss_hcp",
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_cv_cpu = {
+	.name = "qnm_video_cv_cpu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x34000 },
+		.prio = 4,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_eva = {
+	.name = "qnm_video_eva",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x35000, 0x36000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_mvp = {
+	.name = "qnm_video_mvp",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x32000, 0x33000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x37000 },
+		.prio = 4,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_nsp = {
+	.name = "qnm_nsp",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_node xm_pcie = {
+	.name = "xm_pcie",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio = 3,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_gemnoc },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qnm_apss_noc = {
+	.name = "qnm_apss_noc",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1e000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qnm_cnoc_data = {
+	.name = "qnm_cnoc_data",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1f000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_node qns_lpass_aggnoc = {
+	.name = "qns_lpass_aggnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpiaon_noc },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x36000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qxm_qup1 = {
+	.name = "qxm_qup1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xe000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xf000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_usb3 = {
+	.name = "xm_usb3",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x10000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x35000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qhm_qup3 = {
+	.name = "qhm_qup3",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x3c000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qhm_qup4 = {
+	.name = "qhm_qup4",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x3d000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x37000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_soccp = {
+	.name = "qxm_soccp",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x3b000 },
+		.prio = 2,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_sp = {
+	.name = "qxm_sp",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x38000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x39000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x3a000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qnm_lpass_lpinoc = {
+	.name = "qnm_lpass_lpinoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpass_aggnoc },
+};
+
+static struct qcom_icc_node qns_lpi_aon_noc = {
+	.name = "qns_lpi_aon_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_lpinoc },
+};
+
+static struct qcom_icc_node qnm_lpinoc_dsp_qns4m = {
+	.name = "qnm_lpinoc_dsp_qns4m",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpi_aon_noc },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
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
+	.enable_mask = BIT(0),
+	.keepalive = true,
+	.num_nodes = 43,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_crypto0_cfg,
+		   &qhs_eva_cfg, &qhs_gpuss_cfg,
+		   &qhs_i3c_ibi0_cfg, &qhs_i3c_ibi1_cfg,
+		   &qhs_imem_cfg, &qhs_ipc_router,
+		   &qhs_mss_cfg, &qhs_pcie_cfg,
+		   &qhs_prng, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_sdc2,
+		   &qhs_sdc4, &qhs_spss_cfg,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb3,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qss_mnoc_cfg, &qss_pcie_anoc_cfg,
+		   &xs_qdss_stm, &xs_sys_tcu_cfg,
+		   &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
+		   &qhs_aoss, &qhs_ipa,
+		   &qhs_ipc_router_fence, &qhs_soccp,
+		   &qhs_tme_cfg, &qns_apss,
+		   &qss_cfg, &qss_ddrss_cfg,
+		   &qxs_boot_imem, &qxs_imem,
+		   &xs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 6,
+	.nodes = { &qhs_display_cfg, &qhs_i2c,
+		   &qhs_qup1, &qhs_qup2,
+		   &qhs_qup3, &qhs_qup4 },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.enable_mask = BIT(0),
+	.num_nodes = 2,
+	.nodes = { &qnm_nsp, &qns_nsp_gemnoc },
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
+	.num_nodes = 9,
+	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_nrt_icp_sf,
+		   &qnm_camnoc_rt_cdm_sf, &qnm_camnoc_sf,
+		   &qnm_vapss_hcp, &qnm_video_cv_cpu,
+		   &qnm_video_mvp, &qnm_video_v_cpu,
+		   &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qpc0 = {
+	.name = "QPC0",
+	.num_nodes = 1,
+	.nodes = { &qnm_qpace },
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
+static struct qcom_icc_bcm bcm_qup3 = {
+	.name = "QUP3",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup3_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup4 = {
+	.name = "QUP4",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup4_core_slave },
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
+	.num_nodes = 14,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
+		   &chm_apps, &qnm_gpu,
+		   &qnm_mdsp, &qnm_mnoc_hf,
+		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
+		   &qnm_pcie, &qnm_snoc_sf,
+		   &qnm_wlan_q6, &xm_gic,
+		   &qns_gem_noc_cnoc, &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
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
+	.nodes = { &qns_pcie_gemnoc },
+};
+
+static struct qcom_icc_bcm * const aggre_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_QUP_1] = &qxm_qup1,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3] = &xm_usb3,
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_QUP_3] = &qhm_qup3,
+	[MASTER_QUP_4] = &qhm_qup4,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_SOCCP_PROC] = &qxm_soccp,
+	[MASTER_SP] = &qxm_sp,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct regmap_config kaanapali_aggre_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x42400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_aggre_noc = {
+	.config = &kaanapali_aggre_noc_regmap_config,
+	.nodes = aggre_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre_noc_nodes),
+	.bcms = aggre_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre_noc_bcms),
+	.qos_requires_clocks = true,
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+	&bcm_qup2,
+	&bcm_qup3,
+	&bcm_qup4,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[MASTER_QUP_CORE_3] = &qup3_core_master,
+	[MASTER_QUP_CORE_4] = &qup4_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+	[SLAVE_QUP_CORE_3] = &qup3_core_slave,
+	[SLAVE_QUP_CORE_4] = &qup4_core_slave,
+};
+
+static const struct qcom_icc_desc kaanapali_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+	.alloc_dyn_id = true,
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
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_EVA_CFG] = &qhs_eva_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_I2C] = &qhs_i2c,
+	[SLAVE_I3C_IBI0_CFG] = &qhs_i3c_ibi0_cfg,
+	[SLAVE_I3C_IBI1_CFG] = &qhs_i3c_ibi1_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_PCIE_CFG] = &qhs_pcie_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_QUP_3] = &qhs_qup3,
+	[SLAVE_QUP_4] = &qhs_qup4,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SPSS_CFG] = &qhs_spss_cfg,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3] = &qhs_usb3,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct regmap_config kaanapali_cnoc_cfg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x6200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_cnoc_cfg = {
+	.config = &kaanapali_cnoc_cfg_regmap_config,
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_FENCE] = &qhs_ipc_router_fence,
+	[SLAVE_SOCCP] = &qhs_soccp,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_APPSS] = &qns_apss,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PCIE_0] = &xs_pcie,
+};
+
+static const struct regmap_config kaanapali_cnoc_main_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1a080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_cnoc_main = {
+	.config = &kaanapali_cnoc_main_regmap_config,
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_qpc0,
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass_gemnoc,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_gemnoc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_QPACE] = &qnm_qpace,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_WLAN_Q6] = &qnm_wlan_q6,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+};
+
+static const struct regmap_config kaanapali_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x153080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_gem_noc = {
+	.config = &kaanapali_gem_noc_regmap_config,
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct regmap_config kaanapali_lpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xe080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_lpass_ag_noc = {
+	.config = &kaanapali_lpass_ag_noc_regmap_config,
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.alloc_dyn_id = true,
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
+static const struct regmap_config kaanapali_lpass_lpiaon_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x19080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_lpass_lpiaon_noc = {
+	.config = &kaanapali_lpass_lpiaon_noc_regmap_config,
+	.nodes = lpass_lpiaon_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
+	.bcms = lpass_lpiaon_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpiaon_noc_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qnm_lpinoc_dsp_qns4m,
+	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
+};
+
+static const struct regmap_config kaanapali_lpass_lpicx_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x44080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_lpass_lpicx_noc = {
+	.config = &kaanapali_lpass_lpicx_noc_regmap_config,
+	.nodes = lpass_lpicx_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
+	.alloc_dyn_id = true,
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
+static const struct qcom_icc_desc kaanapali_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_NRT_ICP_SF] = &qnm_camnoc_nrt_icp_sf,
+	[MASTER_CAMNOC_RT_CDM_SF] = &qnm_camnoc_rt_cdm_sf,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_MDSS_DCP] = &qnm_mdss_dcp,
+	[MASTER_CDSP_HCP] = &qnm_vapss_hcp,
+	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
+	[MASTER_VIDEO_EVA] = &qnm_video_eva,
+	[MASTER_VIDEO_MVP] = &qnm_video_mvp,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[MASTER_CNOC_MNOC_CFG] = &qsm_mnoc_cfg,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static const struct regmap_config kaanapali_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x5b800,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_mmss_noc = {
+	.config = &kaanapali_mmss_noc_regmap_config,
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qnm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+};
+
+static const struct regmap_config kaanapali_nsp_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x21280,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_nsp_noc = {
+	.config = &kaanapali_nsp_noc_regmap_config,
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_ANOC_CFG] = &qsm_pcie_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_gemnoc,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
+};
+
+static const struct regmap_config kaanapali_pcie_anoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x11400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_pcie_anoc = {
+	.config = &kaanapali_pcie_anoc_regmap_config,
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+	.qos_requires_clocks = true,
+	.alloc_dyn_id = true,
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn2,
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_APSS_NOC] = &qnm_apss_noc,
+	[MASTER_CNOC_SNOC] = &qnm_cnoc_data,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct regmap_config kaanapali_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc kaanapali_system_noc = {
+	.config = &kaanapali_system_noc_regmap_config,
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+	.alloc_dyn_id = true,
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,kaanapali-aggre-noc", .data = &kaanapali_aggre_noc },
+	{ .compatible = "qcom,kaanapali-clk-virt", .data = &kaanapali_clk_virt },
+	{ .compatible = "qcom,kaanapali-cnoc-cfg", .data = &kaanapali_cnoc_cfg },
+	{ .compatible = "qcom,kaanapali-cnoc-main", .data = &kaanapali_cnoc_main },
+	{ .compatible = "qcom,kaanapali-gem-noc", .data = &kaanapali_gem_noc },
+	{ .compatible = "qcom,kaanapali-lpass-ag-noc", .data = &kaanapali_lpass_ag_noc },
+	{ .compatible = "qcom,kaanapali-lpass-lpiaon-noc", .data = &kaanapali_lpass_lpiaon_noc },
+	{ .compatible = "qcom,kaanapali-lpass-lpicx-noc", .data = &kaanapali_lpass_lpicx_noc },
+	{ .compatible = "qcom,kaanapali-mc-virt", .data = &kaanapali_mc_virt },
+	{ .compatible = "qcom,kaanapali-mmss-noc", .data = &kaanapali_mmss_noc },
+	{ .compatible = "qcom,kaanapali-nsp-noc", .data = &kaanapali_nsp_noc },
+	{ .compatible = "qcom,kaanapali-pcie-anoc", .data = &kaanapali_pcie_anoc },
+	{ .compatible = "qcom,kaanapali-system-noc", .data = &kaanapali_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-kaanapali",
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
+MODULE_DESCRIPTION("Qualcomm Kaanapali NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0


