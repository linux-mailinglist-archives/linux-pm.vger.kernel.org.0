Return-Path: <linux-pm+bounces-29113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA63AE104E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 02:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202433BFCB9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 00:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A07B65C;
	Fri, 20 Jun 2025 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="id3n1GHI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782F63CF
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750378766; cv=none; b=Ywul2mTeN7euE1rqML0nhEdV/kW/eUlGI0q+Klae0XRmvPSSo4cJh/VlXNimQCNx+gy+WJudeTkKpPU9qEt13dH/rPTlvU8RXBLySbhFUFXBqXiH6dEJiYol8P3FRi6y8GUSNi3HH7IFFsrOSxpPF0p3huhSXOSxdLH9VnmtA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750378766; c=relaxed/simple;
	bh=5CPyfvzDaJpcwVacU8qqUyuSNCIguXVwmFtDEuuVP6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5XsJr+vY1Wl3Om3gMwX+hkJbFMOXTJMHe/noINJ3OSWoN+2o52dzFqyiRiCZCIyyMfhJRSw366mAj3ZTsmIQy/34WAoUBp24OuvhIq96z7AMsASsZI+xCKpgoTuIbcnt6zum8Rfi+gDeRrbwLkntFlh6pO/vsfVxuPG8p9ATIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=id3n1GHI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JC9YLB005764
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=76OYDegfiux
	sYYakcQ1hn1ucR5+j5q4iTlRVv5GuZVY=; b=id3n1GHIkoityWcUwWBNDRc71Dz
	4tSqH5Eu/tZ/SrmgjeviONaVzKzFbqUVqbcb6lCqXo7/kaeuN4sx0/S5sXr6OJbb
	fXUtIXu1UuRGMOcxlkYJ3Mtcoym2TL3CZjm/eeShok1KMGnF8/HWslp6G3LJYW3c
	O7s12R3YR8f7Hz10I6PGgx2DwfVNRp7ZWBkP8Qg9quP6bAIvzVieLhEHg5Kpe3eb
	aYGQz1Fmdew4+4t/QIPcUIRCO+IHCElJReaWDGx9UM8QCmO3NIAqWZmzeZ+IFKoS
	Zrmi0PX7EdeQ96vvdPa6Nd7tMPJZptP5Pbgx2FqT+EbNtQtOvIUTnG7HwvQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47c0rvmq37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 00:19:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-747ddba7c90so1125101b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 17:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750378762; x=1750983562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76OYDegfiuxsYYakcQ1hn1ucR5+j5q4iTlRVv5GuZVY=;
        b=GHrdsyBTc8KP6iyhnpUKvUFvjuCT8fyJjlFqnaVdAI4QCqmM9OfXzXFClpnsZULG+a
         1ZmuJG2ZjJK3JHq0dFGHBELwV0FcsDF3NS9cOaYgaqbln4quQ1S0aBfz3eEcKHi4QYy2
         GF0gDFzXaXvZMxDP5dWJb2rFcWhp3rn1bs/38oespDYbkXMH7znLbCiubQ4m1Zbna2bR
         x8MtDFoWc4R9tsnluV9nsPsOACh/gjvkmElHW1xmBl4nNy1CRztft7Ua2vgGDGgowFZO
         7TxL5JQZr56FEShgICcl52slQiIzann7hOnJsY8HrXRPo+fAcp5a99drqUh9SY/KtfTs
         Qx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdyqDjzYV833UdpQcQkVRG+qKSil2OU0UoixLsM1dzjLNA7rawWXxCQ9PlnBKANJQbCKwccWd8PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWnNX63hbXCy7EjADaA/d+d750MlNn0M8Bs+PvDCdCfSvdGMdN
	rp8J6iFilbdN9tQMk+xuckY0SUdd3/rReOMBXMjP0jBgmgPp6VaTLWGHdYQsebp+c+5XuV9uW2c
	BPnbPD4pjK5hrzRYyPnifwg/nereoTCa5ikrpD/p5kPxNnNsUCEd70ZG1EzSMEQ==
X-Gm-Gg: ASbGncsU6HJEnNxG4SubwiXd/Z6yfKlvcetbFCT6A7p/xm6sqVeStu43av8EcI4Qkjy
	8KBTZcGKyhqW8CDufR5v4qVaWIrXvlxWHOkAL5dlhduIwIEhhZ8qqDR4sjPkTiup+9vYY50ZXW2
	wywZlwHuxpnxnMGx78xVdaxoUhqeSpA9GhINUa2Xt/CDwWD/8v5+6J96XU5zgJEN3JZ5K/yyGy8
	RRwUJFo56dyMlV49znBxgptcsuejpBDT9wIMlMbpBDPnQ7M0Z1+cHiBPUenAop5a22La18C8S/s
	Me8VREybnpfvGFEZpZ0j44JkvFoCfxo2Y78bCNwEeF51Sj1YOsfjTMaOb8VLU8NPuqnlvpInrfX
	AuwRsCn3xzw==
X-Received: by 2002:a05:6a20:394a:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-22026e603a1mr1258201637.3.1750378761818;
        Thu, 19 Jun 2025 17:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmSLS3HvBIl5p+5bxb85rZ5sLgXcnodT6WFnTVFSa8rKH1nuyLCxXtVkWK9fust89zHfqCAQ==
X-Received: by 2002:a05:6a20:394a:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-22026e603a1mr1258164637.3.1750378761411;
        Thu, 19 Jun 2025 17:19:21 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258932sm410011a12.64.2025.06.19.17.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 17:19:20 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v5 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
Date: Thu, 19 Jun 2025 17:19:14 -0700
Message-Id: <20250620001918.4090853-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
References: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwMCBTYWx0ZWRfX0TZQNq7+fENI
 7AyR9KlWu4G09aGy5rNq+gZsyzBx/4fbtAOTmjGpTsDoHZpPYy5NcrCe3gnj3LH+M73XdzsHUBk
 G5jXv8Gsf/WcRu7psHfGVcxEwhyGSWwSGT/qsVNwI5eQnpSRXMZEQBFRHNlWJMEzEf71x1DcNXj
 IPlIskBWhX9L99pnya976oxijkn6yVCOip+AexsQtNPpBr+l9Lu8os/PT9zCOMPQ2N0q9+WQoyW
 NqVW/3FG71G4m67OhhoMHieNfQrOWHy5Kjkw3Hu+iM6upqFsFCAXdo0CZcIu2Ka3zsQ77eNCSss
 GmythZHEEQRe/NxEeh92NO51C2hV6Z4QJHO0TKcG6En17HzlgFx0G8pyr8lmCAO9zaaVgE92vLC
 G5k5jNeWeDYG1TBCuBzxgbT6uOXWZGTR2WMSrYXQ9hEGvfRGFCrqCbSMQU+7oa/Gh5Bdu6F1
X-Proofpoint-GUID: bsG4NNHTaOhIund60ZGviMfFRpxaj3zk
X-Authority-Analysis: v=2.4 cv=btJMBFai c=1 sm=1 tr=0 ts=6854a90b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=e8SBnR8fKgZMydxn7aMA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: bsG4NNHTaOhIund60ZGviMfFRpxaj3zk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200000

From: David Collins <david.collins@oss.qualcomm.com>

Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
stage 2 automatic PMIC partial shutdown to be enabled in order to
avoid repeated faults in the event of reaching over-temperature
stage 3. Modify the stage 2 shutdown control logic to ensure that
stage 2 shutdown is enabled on all affected PMICs. Read the
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


