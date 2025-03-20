Return-Path: <linux-pm+bounces-24346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A1A6AF20
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 21:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06601189E9CE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35822A4EA;
	Thu, 20 Mar 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdGX+dfu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FE229B28
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502258; cv=none; b=MWFn6qHTBt9nnFkR0uB5nbs9EbEoctaWvG6c60QUoPQrVmYORIsQnAVXJblj4iVb+CBjGhLGlfyPvJ4hBJmY7dGi8IsHvO9Ttj+kN+9PnS0TTg/jp7Qiu3/+zu3Fbm6QEwQqeexWnHll+/J8GkZrvaiXqDqBOl70Hrk4YjBuxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502258; c=relaxed/simple;
	bh=Hm34EcCZY7Nya6IWrGgD3q/+JNM1BPaGd40TDCxo+LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQvsu1fTU3pTUBNNzTPn+JsEsx+rT7FONrn37C3d4BM1eR80dJP2xan/75y1deOWBD2El4u2XporXFyC3M4OwjRqXMNv02mWWkJw1eg7E8zitG9w2F99AyHEPQfsWE27PsVTG7M2aWVJMSZaJkNVP0MtiaJaQ5TMlm4s1zuHcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdGX+dfu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEIJnH005901
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 20:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/E2f4sNa5dJ
	1J/+u/sCAiw4E4qFHfywaLempWlQrqbI=; b=CdGX+dfu1or4up/kVTceuigYPa+
	PjYTNf1Iodo3P87R2IF7TigyISDQMViNKvOtS3swqAEjAiimVvZk02OPArmZ6aFS
	5yV55tekQfWD3mH47JfH6LZ4UC3YPIO3gLShgXzKHjofMbgxPxhBPSMKS9caxOvF
	yhtU4hj2JnSQq9STT+bqSW6ejDehg4GbyTL54We8YX6k9hxyX+KstjXLmoI5gsUD
	o/IePWHHD5fBf6FOJhuckrPxcJDeXDcE74C/r7XH2orqIsMGjPGNJi/Ju3eLNXfL
	giTqTNm3oWnB8/gyGgbGt6H0reE6/LMtCdYkVjo2PiGw4H7PfIs9PegD9FA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmc2xau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 20:24:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so1739366a91.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 13:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502253; x=1743107053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E2f4sNa5dJ1J/+u/sCAiw4E4qFHfywaLempWlQrqbI=;
        b=iiw3GvWOo9N6I9hXSrhyXXca+pSBPNfzPld0+/xZ3PgMdX020POQmBczF61Tqx/JGF
         UHCfyt4YX93OyzvFw2Cmxh/NJwlHCsrd39xUkByorTuAR0/dUnsUheaqthUbABvQ2PN+
         bUR1ATJWmZiIYJI/zROe6s4ym3EOT3mmQig4bv3lLDz0bQ8AeSA94Z576yf23lYpKk/i
         jVAbfZcVTZKf73qBKLqF1gYxREG1eVeNRBRxhuL9rkBAZUEvwErFHuRLNq84ArCO+ZgW
         z6WTYgeiZnt3vKpiQbJX4bUcZtJDQAblIYY74esowqaxVbximagqJGgUsLszoUu3nxxY
         7Bjg==
X-Forwarded-Encrypted: i=1; AJvYcCWzrPe78BQaZkFSm3itpEdaGVJC/oKPJ7O9fUUsn68b1MXHx0wlFgAnpFNYueGjI2veUjZpG4VRmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxGaAT6WHHfuihNKlirUEV1b8ZnfBPzD5mke3FKnDIKZKyOTk
	eXGZNqzm0yIC/mkU169sbfPYmjmtLfSBQFLokw/UVcFLRsbzd1IcKYbngk0DyEVMe22Ka24/btE
	SKyn4izDlDkmGmu7v0lOwN7YkjfgyeBQM+HNHK8GsZ5Qe+7uhPV1z0A1NMQ==
X-Gm-Gg: ASbGncvzcPanvFxvER8K7CBbrguENtapfLmwDlcPaZ9PG0V9Pul0a5j91+bS2XLEU/k
	KnZv2eXykn62FffXQl3dwUqIHJ1GcJXg8NwfZEKzOA8ClOHObz3oOVaG+Gyb1hLzRZd8O1erw41
	uL5hVsro4+gOjQG4H2X+zHzMgNSZqYlibJ+XZTBXOCpQVNLJYt5/QJnCw6aScCLJ2lTFlcPxHyu
	yVvyFwzDaEkQ+3Hm0MXZaNEZTel2f5ahdUC5YniLUt3iiHCk95WEWW1JtPcQJEr+PkUjPy0BiCK
	p/O2kgLmWB/+4r4WpaZXBWHCyVZVJ79Kp1PkfT89X4IT8Goq3tNo8RKlyGYOTsIU69c1otDXhEu
	4Etw=
X-Received: by 2002:a05:6a00:2d88:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-739059457b8mr1274944b3a.5.1742502252889;
        Thu, 20 Mar 2025 13:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcujCC6dIUgoBwEfsAlF9R5NoEtjy+9Vi+GLQJ5dHhBKP3SMyOMLn0UaHxXsQSLcRFSA/W8w==
X-Received: by 2002:a05:6a00:2d88:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-739059457b8mr1274889b3a.5.1742502252290;
        Thu, 20 Mar 2025 13:24:12 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600b9b1sm249308b3a.76.2025.03.20.13.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:24:10 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v3 1/5 RESEND] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Thu, 20 Mar 2025 13:24:04 -0700
Message-Id: <20250320202408.3940777-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1KNn9pxMIVSiiu7gyv_kK_BumhmZHear
X-Proofpoint-GUID: 1KNn9pxMIVSiiu7gyv_kK_BumhmZHear
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67dc796e cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=q_MlTjK-hrb8HEj9cREA:9 a=RVmHIydaz68A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200131

From: David Collins <david.collins@oss.qualcomm.com>

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
stage 2 automatic PMIC partial shutdown to be enabled in order to
avoid repeated faults in the event of reaching over-temperature
stage 3.  Modify the stage 2 shutdown control logic to ensure that
stage 2 shutdown is enabled on all affected PMICs.  Read the
digital major and minor revision registers to identify these
PMICs.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index c2d59cbfaea9..b2077ff9fe73 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -16,6 +17,7 @@
 
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -71,6 +73,7 @@ struct qpnp_tm_chip {
 	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
 	unsigned int			subtype;
+	unsigned int			dig_revision;
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
@@ -78,6 +81,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_s2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -255,7 +259,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
+	if (disable_s2_shutdown && !chip->require_s2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
@@ -350,7 +354,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
+	u8 type, subtype, dig_major, dig_minor;
 	u32 res;
 	int ret, irq;
 
@@ -403,6 +407,30 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not read dig_major\n");
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not read dig_minor\n");
+		return ret;
+	}
+
+	chip->dig_revision = (dig_major << 8) | dig_minor;
+
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (chip->dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			chip->require_s2_shutdown = true;
+			break;
+		}
+	}
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
-- 
2.34.1


