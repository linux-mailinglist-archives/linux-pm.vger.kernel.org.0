Return-Path: <linux-pm+bounces-30640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED1B00EF0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A185C3691
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2602BEFF1;
	Thu, 10 Jul 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3pkjYIp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77B2BD013
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187562; cv=none; b=Otk+UdcGiRUfTLQ2bD0PTof3QNf9QHhFe4Znpq+vNG3VOPJ92HO133DGjy9zMzViBwJrB7uhfMiW5jzsfAAIWlByAuCTt9uj20vq3RvLIF3RAo804AHpCXyZCfIXCpMObVjlz2ba7E3NKL7TKShgTPSCT+HzVCAb5AV25CWkupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187562; c=relaxed/simple;
	bh=/G3yjvmAIVn8+g+OKZB3AzxtfHQGlX8eD13Fl1ZcDVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwqDUAWEQPwyC7ojjjH17SQ9Wh35+3o5IzHW32/ONTRySkVbXN6ft8nFoMLqaQQh1e2V5zBbTaLiopj1bLSzLPx+5wRSjFZppXgd5kkmCqXWGK24dmzUPjCtGGVQzDfuY4zsCQZM5ooIj8CXwRYF2J/jzaimMd2PckxoWfG2O0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K3pkjYIp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJR5DY013630
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2+Bx4W9mabN
	GnGAOk9vdoVwnLh7nIUmtj3EmkWbgNNA=; b=K3pkjYIp8d8+u3U3e5+oWQz9k2R
	WuffzfWkg/YGs7d8nMG3sen+wNdeOFZbN+t6M5WIK3SvrXN87ACzusn5YOyftgUQ
	hbWfhCiqKiELxgQ8uvtiiNJNS6eWy0w5m3v7YxInF66r31RFiKQt/7iJ0O2d3JYr
	KCz1RE51UpO7/276rrHBDnPel2p61UpWnad5Q2F10NXWPi4Z89NO0U7wMnBYJRMU
	K1h1AMzRHRbX88JQOx5U6PyiumCVFvCFVfdaLtqMqZKLW0/unYucI1ZNQ6cZ0HaY
	Y2Kql93yF67mfBJDj9W9ss/GpLfj5x+JfLETi+6yafhdtC+F4e8FA2Ipvbw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bhtt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:45:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d70d67so14522635ad.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187558; x=1752792358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+Bx4W9mabNGnGAOk9vdoVwnLh7nIUmtj3EmkWbgNNA=;
        b=MxzNQZMjenPAV2I1Syz4spJ1aud2gHP6EoQ4uyp3HGw+0jAu4FkqJDbTciJfgi+nEj
         8lGPZs3Z7wgpkcCwJGc+2Vp6Lq3GTfGsdkWL2ebPs6bKSGlevqh37zwKREX4RzjmpYzC
         8XeT2hNBLYZBDGXg6k0Zki2Wuq9zCCe5BndWD7izeXZtmUeKqjofXI0BuMjJfAJLzCZ5
         gxBG/+YG8YD3eclZNWU4bQ620IMZU3h8fWpQCV1lzauRkAA726QQGmbIVW5GQKvBaDTV
         unw4AQPOrfapJVOlVK4KtsKpq2WhBjTff0wxlLV07OXq2v8qT2A9gFcPKph0Yta7XXfk
         U3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2CtDPXDMnpmLqLiXFU0ykOyJamYxlRoMk1FDSvKr4jKudjEQ5hElTT7pftsfOmQZl2r6zz+zXWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzy44BLVpDbgREEx6upklMUL/cMBNv1OxKPC50/OdjmgxTgbKn
	vQhECK5mPJY3LeQZarBZaxY0CB55mR6BoSnhqieOzT3pr/AM/a3mRttvYXKinDnvSgT7AC581TZ
	UWS4zQ5hUl8waUex0yNYljw4M/xUN4pgX4NWsyRHYbP/v5Gq87dJA8uT0CXmgGQ==
X-Gm-Gg: ASbGncsvY2U5AbmKs7XXMzguTG0VzYy2CtkQoc+U4M9tRioaUmGjEftCw0SJqf1f6WF
	zvAXWmQnQtSaYFkpprbc4ABwLSnBNVTdhV0KX9ovvjc8fLG7YEsCpAgScNoiwQT1bbnxtdVYaTM
	kB8nQC5/YCEqqVUqYlNAuK1xt8DIszWAIeblFM57Y89dowUrh9xTqU9NRoCNz/KAvxVJzEtGJSQ
	ViUX4eUAwVNcCT3V+BrHotCBO7P0j7VprnJ4uzoYv92LBSrYDNyJ+Ge6cggI0ebWOqgzECulWww
	77kyWoQ6vHRjRrc0V6VMKyLfWF0rAHOElUBo60fNB2CwkDhkcv1DFymoRUAkFKj5MZTh2l9syOT
	UY9G4kq7nV4AS7YM07D4dz2kBOPE=
X-Received: by 2002:a17:903:b8e:b0:237:ec18:ead7 with SMTP id d9443c01a7336-23dee27d2f0mr12009225ad.24.1752187558558;
        Thu, 10 Jul 2025 15:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+kL17WYIoYYBJY3WzQsljLuG5yOgF0j4V2/C1bfca3Lxbq/ar9/HqaY2SNZCXXYtPSrSpiA==
X-Received: by 2002:a17:903:b8e:b0:237:ec18:ead7 with SMTP id d9443c01a7336-23dee27d2f0mr12008945ad.24.1752187558101;
        Thu, 10 Jul 2025 15:45:58 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:45:57 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Thu, 10 Jul 2025 15:45:51 -0700
Message-Id: <20250710224555.3047790-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
References: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfXymvf/S+Zn7Ho
 IVe1DomZNSC7zl7bz34p8imdep3C0GB8qpzBU8MPYt1exLNw3BBGmzfYTinwcybxFd1G9beOLla
 /whaPWCWyJtadIB34JAMmB8a03B/yKmcU50pBoUHQCERZtK1578NSxtwSZ+gyDKapxHV/B1t1VV
 G5qMYVWDYNRRg/UeGdi0Yscp3stcUKyhEKoZfskQoEDyRJQkHkrLzSMyVQ9u7/I5AcWDVNaK2yH
 qfzcsZpRv9JypmvUdsLAGW8+4Xd6Np4qk1niUmZY/3A8uB5zfT6wehJhQKdjTIWgygJVUXrgnj8
 O1wd0j/Az7EFwVytkgkQsYzH65S4PJziH4LtFe4V5ILJqW4ms3t+iV6YIWDfUgpqRrf+i3M9nO5
 NmzkOiC/L/0MMEgQGt5Rex6ESYIV4P7OE4Rd20kSTiYrnRc+UQ0f9Tungtkmq/zFC7yS27fv
X-Proofpoint-ORIG-GUID: P3sKoPg7O4o8eWj0-DMPnSPmm9bp9hMM
X-Proofpoint-GUID: P3sKoPg7O4o8eWj0-DMPnSPmm9bp9hMM
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=687042a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=2ebS6B6wQDVqfW-kuUgA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100191

From: David Collins <david.collins@oss.qualcomm.com>

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature stage 2
automatic PMIC partial shutdown. This will ensure that in the event of
reaching the hotter stage 3 over-temperature threshold, repeated faults
will be avoided during the automatic PMIC hardware full shutdown.
Modify the stage 2 shutdown control logic to ensure that stage 2
shutdown is enabled on all affected PMICs. Read the digital major
and minor revision registers to identify these PMICs.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 43 ++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index a81e7d6e865f..4b91cc13ce34 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bitops.h>
@@ -16,6 +17,7 @@
 
 #include "../thermal_hwmon.h"
 
+#define QPNP_TM_REG_DIG_MINOR		0x00
 #define QPNP_TM_REG_DIG_MAJOR		0x01
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
@@ -31,7 +33,7 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
+#define SHUTDOWN_CTRL1_OVERRIDE_STAGE2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
 #define SHUTDOWN_CTRL1_RATE_25HZ	BIT(3)
@@ -78,6 +80,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_stage2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -220,13 +223,13 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 {
 	long stage2_threshold_min = (*chip->temp_map)[THRESH_MIN][1];
 	long stage2_threshold_max = (*chip->temp_map)[THRESH_MAX][1];
-	bool disable_s2_shutdown = false;
+	bool disable_stage2_shutdown = false;
 	u8 reg;
 
 	WARN_ON(!mutex_is_locked(&chip->lock));
 
 	/*
-	 * Default: S2 and S3 shutdown enabled, thresholds at
+	 * Default: Stage 2 and Stage 3 shutdown enabled, thresholds at
 	 * lowest threshold set, monitoring at 25Hz
 	 */
 	reg = SHUTDOWN_CTRL1_RATE_25HZ;
@@ -241,12 +244,12 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 		chip->thresh = THRESH_MAX -
 			((stage2_threshold_max - temp) /
 			 TEMP_THRESH_STEP);
-		disable_s2_shutdown = true;
+		disable_stage2_shutdown = true;
 	} else {
 		chip->thresh = THRESH_MAX;
 
 		if (chip->adc)
-			disable_s2_shutdown = true;
+			disable_stage2_shutdown = true;
 		else
 			dev_warn(chip->dev,
 				 "No ADC is configured and critical temperature %d mC is above the maximum stage 2 threshold of %ld mC! Configuring stage 2 shutdown at %ld mC.\n",
@@ -255,8 +258,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
-		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
@@ -350,8 +353,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
-	u8 type, subtype, dig_major;
-	u32 res;
+	u8 type, subtype, dig_major, dig_minor;
+	u32 res, dig_revision;
 	int ret, irq;
 
 	node = pdev->dev.of_node;
@@ -402,6 +405,11 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not read dig_major\n");
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not read dig_minor\n");
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -415,6 +423,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	else
 		chip->temp_map = &temp_map_gen1;
 
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
+		dig_revision = (dig_major << 8) | dig_minor;
+		/*
+		 * Check if stage 2 automatic partial shutdown must remain
+		 * enabled to avoid potential repeated faults upon reaching
+		 * over-temperature stage 3.
+		 */
+		switch (dig_revision) {
+		case 0x0001:
+		case 0x0002:
+		case 0x0100:
+		case 0x0101:
+			chip->require_stage2_shutdown = true;
+			break;
+		}
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.34.1


