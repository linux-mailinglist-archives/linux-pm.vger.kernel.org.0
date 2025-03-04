Return-Path: <linux-pm+bounces-23450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A11A4F120
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 00:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725DA172CF4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57F27811E;
	Tue,  4 Mar 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWiRtKWa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B61FE453
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129510; cv=none; b=bihXwX05VDzt2jIzJRdo8vXOLcniidgiAhTt/lQy62vpHoUZSekTvhlfOp/wLTymgKo0IO/IKQaLOvGrUPeeL6GXkJcb/ULE2jBKT5G2FUpjzflDE+j5SsaTZFv6u1xNqN1B6DVC+tCe/DCUKVHii7/Ct9+PBSlWPa8bG94qWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129510; c=relaxed/simple;
	bh=Hm34EcCZY7Nya6IWrGgD3q/+JNM1BPaGd40TDCxo+LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbmynSmT6XAU97iOLUqmxWCodD2b9A4yYHjBUkamV5Zduc4gqluTmxHVOtkXtWHbnz/3cdMfw+4RVHOO4kQTGR5rlVh2pxd13qlroVxDy7g5veEUGpSr949nff+U5OWP1dU3QG2jk17P4FYKJjOFhLbNpGZhvA0gay/S0LAbWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWiRtKWa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Kb2eZ022770
	for <linux-pm@vger.kernel.org>; Tue, 4 Mar 2025 23:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/E2f4sNa5dJ
	1J/+u/sCAiw4E4qFHfywaLempWlQrqbI=; b=cWiRtKWaXT170egx/cfGYPZPCB7
	sX/WzXJxsY2RmA23d8i7Vg+BXuFSZMK9Hj732aQJm/FuBGXFSPqAGR5/m7XAv0Gy
	L7xk6IzawjX8nfZRcnc5cHXfBezTZcAZ0jlTDfxM27ZUu8Jlz0jSrq/BdjbUNLQ1
	r6VSx5mIW6VJeD1bHPCz9H14WohiHRDFyZ5wKlRvzpGrEOoPkRB5NXEbsPV6ss+V
	1m5mKS5aOedGFvni5JC84mwVVO1SwHF71C5BrQ0rHObOwZXHdCxLGXLPIhx+9LIf
	YwNCg5T2c51d6f1cGlt/BZAhhD7YB+7nsqBllwrYTlaoXxretRnv0v42/Cg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t3fbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 23:05:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2234c09241fso177918705ad.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2025 15:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741129506; x=1741734306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E2f4sNa5dJ1J/+u/sCAiw4E4qFHfywaLempWlQrqbI=;
        b=RfjNhvx7vjKajjNEa2pBjje31DlIJFpS1Yiqh56wTk3/T3vjCetf/9BDSSCdFpV0KM
         HgBV32QAXBNCTEMn9LZa21++diOmVBCqNQk7mk3cLUVC2eY+GgLYR7eVRhmQIOE+1vzP
         5d2u2qEKxPBjr00tUW7oi1f0BeF3SB1Lv79KWmzvrqa+V8FrgDc0czmD+36nrZOOJCd2
         t+TjIk6fOPBt6H/QUOJSAFMh+ADV0TaZOtUkH9bK3EQ6v+DWy58lfpYMTfjkpF5S691l
         koQ068Z84TyLwV58ZyXWZmQiq/T3aTnNaKLrg1e7C4H7unJNgiXF/E1mOVkJw8DdprE/
         JfiA==
X-Forwarded-Encrypted: i=1; AJvYcCW7EHvNJlE/21GM8WMhmTpDbV9K7DGYDKwKxDxLAFL+CdiRU1D6kd50DFxX2lTmuFeGVNqjaj+eYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9unFeDyaEXLUz/EYpBABYMj+45xCX+jPsCoRVCcHnfyPR5Mbw
	dtxzeERXmjzkY6oyG/lmAZG9JiIK8hPlZyhmOeKQVjHtGl6Gg8j0rlu8nxMNyT52OsqDeEa15rG
	QjHB+pfe8708FCo45oUIX6s/1xzKPYYoKsKhMI585ctG7OKUzETH7szQGhWx98KMoRA==
X-Gm-Gg: ASbGnctwwQELe/OWL2p8r6H44msX7YCVDuR1onJikqizvvpOF5R6NqKViNBIl+MNNej
	MLpxHJha+xdP8XfegA0NhT6ouzqD/AXj4soZcUk/SebKqEZ225LRdmI8JA4gl+XcStd4zFwPcjo
	j8vAZlL2h086LTV8XHHrtL2HWKcYTf/a/UQBGkRIkpySI8y2aMMSHfki1puoMLjOBIKWisc9rRk
	i7SokfxgOb9nQ/begg3hHCxvTzIDlfsY6Xj7YfYB819XCnFl01V3nR7JMTccyhDrkUxs5Tcqd8Y
	XXc1l4JP9MD8j5aHuRuh7nmPz7Xn4C29Wg7tO/7gpzmmMDJJvOzGyxf1QfkOoJXOGJ1ZbNB/sTs
	hcUk=
X-Received: by 2002:a17:903:1252:b0:21f:564:80a4 with SMTP id d9443c01a7336-223f1d2641dmr11146225ad.33.1741129505741;
        Tue, 04 Mar 2025 15:05:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5dQHM+3gLIyGw066Ot+0ZAb8HayBTD5e77YOaWae5RvBWVgFXgTWYoWP7HVE36wOIfNe0rQ==
X-Received: by 2002:a17:903:1252:b0:21f:564:80a4 with SMTP id d9443c01a7336-223f1d2641dmr11145955ad.33.1741129505362;
        Tue, 04 Mar 2025 15:05:05 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6cfd9sm11492793b3a.76.2025.03.04.15.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:05:04 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: [PATCH v3 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Tue,  4 Mar 2025 15:04:58 -0800
Message-Id: <20250304230502.1470523-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
References: <20250304230502.1470523-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ufRMgg c=1 sm=1 tr=0 ts=67c78723 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=q_MlTjK-hrb8HEj9cREA:9 a=RVmHIydaz68A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: N0998qa990TsiojNVGZ0xKxKXQISv6fV
X-Proofpoint-ORIG-GUID: N0998qa990TsiojNVGZ0xKxKXQISv6fV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040183

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


