Return-Path: <linux-pm+bounces-27766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0AEAC74A0
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F34A33E3
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C326980D;
	Wed, 28 May 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzsLzZvc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F979267B6D
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476236; cv=none; b=f7zpIiE1lMr22TtqS9GDe8DLGFdmTL6P+XyrRThGqDS4YiENbjLe5GaIH7nfq7Okoe3unX6YaqE4o9Tzed4G5LVZElAHuRjmp5XeERHikmweuimxHb9R8H0iee91TQTFGYtNgJdFY3CIrCyWgfGnDC2rY7rJGxYMuSDaN6BFOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476236; c=relaxed/simple;
	bh=PAVEaTNuIFwn6uxuzqc4IGyQxSym92XjfRwGxkI5LBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMd75QGoqKVkcfYABTCbcBtB0K44JPvAitVgfiLbgfVU7Rsq+K4T2dzfz4geAMo3ZHvn+66TVgo6tsFkWdgEXdYWYI8qm3HcbW79o7Co+p9JNgYOVHElEmYynR4rMdj/ZMSuTTmepQvHK+k1yrUpIu0jU8RnnvXkFWKohmbaV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzsLzZvc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SJAPCB005814
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=76OYDegfiux
	sYYakcQ1hn1ucR5+j5q4iTlRVv5GuZVY=; b=UzsLzZvcrIsuw8FAUyBEIrXvUDV
	IoaHdTGLYJablVBla/GFTbmcidMnV2HYfZOsREuJ+KD8SONG1Qgk9iFAmy67+fZo
	DFjaWtZXg/YWt1xpbxDn56lt57leXTXE/LVXpy+kfv0BDO8HRFVvNm8ayahfa8BJ
	lyhc1Tx7HqBj1ml+pfjb/Sd4f/y4qcfwOF2TngYspDxDVtEsbiYu6qzAuu3i2O8i
	qb4JINtoJfoW2piBLZp6sb4Zl+Qf9d11rIgLMCvn+3F74hIy/SoiyGNHw7ASLSjm
	Rby4DrhLMOrrAjFIOgcDW+c8onFBxlcA8hQa9A5zX4hQRzSbReguPYfay1g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x8d78he0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234a102faa3so2490305ad.0
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 16:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476230; x=1749081030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76OYDegfiuxsYYakcQ1hn1ucR5+j5q4iTlRVv5GuZVY=;
        b=jH2OfHzvcAnn32ufycIO7eWc2YATHdX3HPmiqFXcGbxgW0zuQQzQb6hKFwF0tyr8nt
         BFn2nI9+rHB7PjqUjtQxFs0wyBnsdYATRNMlIPU64OVXEfvUqtJULpRg3sjvB3hgSF3S
         V4WfO3zfc3FRgtV4YsVfcZZCodQHEyTEKHIjqMoWEEzwzhKHU4N4rP7pjde2W1M5BDeJ
         3NuAASDfPG5dyub3XmRUa56sEZ/jGJAePUS1iPSFJNHsa/DxxHWo2zF9WSrbdDvOZ7VK
         g+xvjgmccx04kCIoRO9pwynEdXk9zId7tKuxWWYHSyGy/6Ud3n7E2SudXYqpqUMue++/
         kPTA==
X-Forwarded-Encrypted: i=1; AJvYcCWAompz1fFLexXHct9/vwlGYbZctlHEnJdEnvDrUgtCzd1WNcTyncW81OvWgzuQ2rbiTBvs7eCfvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySWz5serP2y+kR0E3JfQi66qWwSp8vx6gTmXD2fBkc6+M5y82Q
	VPTaS+wdtDk4Y1sWGncyujJt1hbStdHICJFxPMs/W37qP/mgeU2NMHN+5SFiNMURgnhY6MNHYnb
	c0Tg+5mdRvLpO2hww6yzzGVDJtaYrKw3e8ulAkvDeY47FjG/4pf8/KAdoNySDuw==
X-Gm-Gg: ASbGnctJKVLYbWJCWFmbSg3s5Xh3rAL02a8lYjR6rTmkS8rchiLEO+e41kW48KSlUnW
	czEsWq+aVPJgGGoI5MW79ug39IATnsCUG3+qDMDwp408GhYIF9BEsjkwUhZPkmN1YJ+d1SWhtNS
	+AVGcPG6WahQWBoygU63o4g1w8sfpZlPs++ffIGbNvqPn47pK8ZvMPGhQ6BBLg7r2ycRCLuAF8U
	ZMDXKJqWsOVG8HMv0hzBKb89ftvMuke7CMKe73Z+jpWFtwJSe2fgZs/MdFJ6HwIGZQvsiY9uh6X
	hWGqRYKh8xlvVa9DHy36jqMalm99XByuSmdFItwDOLeqeq33YQfhR1D6RZoSGBYlx0MXYjZiDSA
	=
X-Received: by 2002:a17:903:3ba3:b0:234:986c:66bf with SMTP id d9443c01a7336-23507fda8e1mr687015ad.11.1748476230560;
        Wed, 28 May 2025 16:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXJ2CH253RcCjsEbKAglqaviACnPHSjcPxqaSjGqZk/+EVCV8EtG5Q2YOsePh+6HsjQ9HZIQ==
X-Received: by 2002:a17:903:3ba3:b0:234:986c:66bf with SMTP id d9443c01a7336-23507fda8e1mr686765ad.11.1748476230187;
        Wed, 28 May 2025 16:50:30 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm1403445ad.156.2025.05.28.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:50:29 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v4 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Wed, 28 May 2025 16:50:22 -0700
Message-Id: <20250528235026.4171109-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gh23d-qYmJPRxYxI7_rcrfoVK2YQHAFE
X-Proofpoint-ORIG-GUID: gh23d-qYmJPRxYxI7_rcrfoVK2YQHAFE
X-Authority-Analysis: v=2.4 cv=X8pSKHTe c=1 sm=1 tr=0 ts=6837a147 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=e8SBnR8fKgZMydxn7aMA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIwOSBTYWx0ZWRfX/kK0i2BANkrw
 5sEU7IH3zMQahib7VeqW3WhOrJZYFTbof46CayijfaeldIT5nAFgKWaRGj3uuJt97p4T+MMScjB
 hbOfDjfFeEvJW/p7LYJLOzMP3U3ux/2W3UZFzlVYc8fgCxLRN/mjRrxQphVUEyLovs7xtP293f7
 ROAEGLhZth+qov0x/o0KsARwjVJaDiiejVQjZDz8YTDJNQaOnm9lbjWAf0HcsRi1QuK2KV32VDS
 jvuPPWS9VuGYETaAxBROj+d3VY9o3k4t8Yk8ZaFdvh6/8YwqWzErc7USmI5mpbJNcaZppXJAD9h
 JdmsKoRS63wzpzqFjLzu0FdZTt3/e9ORR6chFss4xJ4QPC+QD2op+zpOtOdJnwqLklcNx4KbNcl
 R7puNUDU2WHgeHQB7bPqLB52WpwkL7A9YVJ8P5krj1MQf2GcJC3t8WFZrCA9rUtlMAVsJf83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280209

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
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index a81e7d6e865f..47248a843591 100644
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
@@ -78,6 +80,7 @@ struct qpnp_tm_chip {
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;
 	bool				initialized;
+	bool				require_s2_shutdown;
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
@@ -255,7 +258,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 skip:
 	reg |= chip->thresh;
-	if (disable_s2_shutdown)
+	if (disable_s2_shutdown && !chip->require_s2_shutdown)
 		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
 
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
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
@@ -402,6 +405,12 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "could not read dig_major\n");
 
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not read dig_minor\n");
+		return ret;
+	}
+
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
 				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
@@ -415,6 +424,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
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
+			chip->require_s2_shutdown = true;
+			break;
+		}
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.34.1


