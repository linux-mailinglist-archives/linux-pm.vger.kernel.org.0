Return-Path: <linux-pm+bounces-27767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F106AC74A2
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8742F3B0B62
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79022698BC;
	Wed, 28 May 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U8MaQHN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4E0268FF2
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476236; cv=none; b=qHoAr2ChtoqijORtCygR4Y9SBgq8LqxZns7RPKY28nkZSuI32rzk5KDmseIqWM+s6MvtI8KNLU17QZpq+iR3nLJRQ2lGJz9pf38EQeUlYfatux4Tj+f0WFK4WsgzdnvqJoAFi42ry5p6l0NU2CDoLn2OsdBPZG8jvSCRQumTbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476236; c=relaxed/simple;
	bh=uWUmQZzfwijv2fQEAMByt5CIG6+qQddTKNUWIV1yedA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ck4T+iga2unOHuzfCq6Tw5wjYVrFqpQ962vYTqdeczY5xfcdhvESGd2jqxcw9slynK2kNSA7dHF9D9c5R0Y2+bthWWUMFLV405rZ0A8a18BpAeWsBbj7ud0sqZFGT840dnqoYYNNfbNHGUHVJIpwPwb+Cu3hVG7kL0ka91rcDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U8MaQHN9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SElwxc028914
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y85TMYCwFNn
	++fwJcWQ509YRv2ZapdZbIhgN4u4WAZA=; b=U8MaQHN95TXp+yeHLGULOt79Ihn
	Wr2EKaVQjvF86l5InaUeC8g5294gDV8BIyLkPZhcBFx2EZUqNjuglm9oW9Ropswv
	ty1C2SP73u442RcwY0kknPRBgwwIFZnfMTWVkqPFMMb+yY/zvOr7BVJaanLjR0Sq
	onhOkP7K3YFpcatQP2QjeEvoBJiw/sh7qBVmddv5yJlLg6wolqkzdQrB0XHB6UVF
	oj6oK1QZh0jjoEygZJFa0t4JJ711unH10Z4K5PMi4WZDvhI+dwS8n4WXUC/Un5VF
	xMbcAUd5NhSF6hxiaoQKpwGYsywmiFTZyk6puR6XI59p2O4Q96IdQgt7xKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whuf48a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234a102faa3so2490995ad.0
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 16:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476233; x=1749081033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y85TMYCwFNn++fwJcWQ509YRv2ZapdZbIhgN4u4WAZA=;
        b=FjWo3DfIhtWG44PWPHg01A0fbSP6IbeaT/703+7eLO6uTV/+W62AYLfxxIhQoh+2tw
         VwlZisJdti6f/ViptrrJZwIkyfGS+CmxzCB4bp85ojXJIZ/OX20w8NvsY962iESutHhJ
         0ful70yPoAHCOxQWvtLIO+3bK6CoqRmfwWMT6edijwaLiyDR052TIitxJ97wKWF4/6QE
         Ix+ojsX26BEpQAZ0rzqxWfgXHYCyZS06IHnUUDKKSFfhsq96AcmzdOxk8//pmNWdVGDR
         JZTbIBW8bjWeKq6wNfwqPfqPTbCXWYgGzI7x4TTT/lPgGKA1reYWXPzJH/j+P2z2K4nd
         T7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4MSVaM+NdMRQfg8FDpanpkUmvk2d5VIsR1hREehLbsCp0rfXsrnw34kJxOUlN5NvmYlLtEFtOaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7D0r9sVRE2XdR+6fE+TxqBLtUkIdIAro3CXtJ7lz/yR5sBK/
	/fuaitThd1Fbhb96D0CtDyMU2MPQey/IRGEmzlFqBXrGRtcK+x0tudJwRPNGAHEr3NVRpGe1Acx
	bpJyNz+IJaAmo6tjGtGHSYjicqmWHzQWFxtUx4L8OsPI9+HcE4kKuQN+xriTd2g==
X-Gm-Gg: ASbGncvgrAg1yj09vXGMDcRuTMpL2RlidS8D/3yH3xPyd3DcfS2ULaZwRaUPrCzzIrM
	Lhlv/dsBFUU6xTngWC5XN4r3vQY6hygXiKYVn2k4vSJNqGc5wJF16xqxpSE1RayzmZoib/JNNpk
	QQjNwGe3P2VzybRCdsLzhSywrGGd65uut594KJd/CQji6pL+9D5wrHHZs6fYZUzNfO2Iowqp/4F
	PDRAx//hl8A67tLGo/hLSAMRfvoQ+TpOJ5koM6piH6NKj6wf/2vhxXRsmxDKHWAfaEjDlqz4SgQ
	Ndh3BkOOB0hZ86KgqUHzV3XRZxUDQpzc9D1CqdOPisvnQhXq+QBX3hIkfs6eEd7O47dR5r2TaDI
	=
X-Received: by 2002:a17:902:da48:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-235082e1cb9mr168555ad.37.1748476233353;
        Wed, 28 May 2025 16:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFER6i3y0ujrO9TqIp4SDaBIQHx4Hv3IdZSVeEKTqE8c088lrZ6/nh8NZLuDppFB4ND5sFNhg==
X-Received: by 2002:a17:902:da48:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-235082e1cb9mr168305ad.37.1748476232989;
        Wed, 28 May 2025 16:50:32 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm1403445ad.156.2025.05.28.16.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:50:32 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v4 3/5] thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp Alarm subtypes
Date: Wed, 28 May 2025 16:50:24 -0700
Message-Id: <20250528235026.4171109-4-anjelique.melendez@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=6837a14a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=QmBY4OO-GzUMAyIBBcsA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: AT0n8Uz3SFp47ezOaC-LMgN5zI9AU0MB
X-Proofpoint-GUID: AT0n8Uz3SFp47ezOaC-LMgN5zI9AU0MB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIxMCBTYWx0ZWRfX6wG+paHd8YKX
 U4pFr9INQl68SGAZFmwjfBBgCfy2Uq68KfMl3o6fh1tbAaq9UfLORiGmGtKceLYjE3EVA398Gp0
 iDXEt7oU2D5ECxH/K7gX9NWQ/QtFCJJBf6L5323AnuxIojP16p5Rp3vqAfqpFRS6KaVghpAZ9/3
 Xf483TQ9WMeuQ5ihe717JcdUi2QWZLJheU60wL0Tc8o+i+r76dohDaseM6r6/pL477C/0jg2Ng1
 MRNBs0S6nllD9tGzB9ifQCGRd2B4shsCk3EiYws6mBJ9Vf+6272J7oF14/MtNDww7hdjAcQgnmJ
 YJi2PJ+5fzXBr1JuMnJP/+HOIqP0FGWsWDzHWNu3hlHCSi1L6pYRaojYrJ8Q99UUwo8rBZYCh/I
 8np6S66gIyRap+T+VnIj75r5GloTVoJp6Hbi8nqqaIYCeLVQZH9NV8SI2yQni6tY/eDDSLWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280210

In preparation to support newer temp alarm subtypes, add the "ops" and
"configure_trip_temps" references to spmi_temp_alarm_data. This will
allow for each Temp Alarm subtype to define its own
thermal_zone_device_ops and properly configure thermal trip temperature.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 36 +++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 0d8bbc5b7af6..59a25f02a278 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -71,8 +71,10 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 struct qpnp_tm_chip;
 
 struct spmi_temp_alarm_data {
+	const struct thermal_zone_device_ops *ops;
 	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
 	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
+	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
 };
 
 struct qpnp_tm_chip {
@@ -311,18 +313,39 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
+{
+	int crit_temp, ret;
+
+	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
+	if (ret)
+		crit_temp = THERMAL_TEMP_INVALID;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
 static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
 static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
+	.ops = &qpnp_tm_sensor_ops,
 	.temp_map = &temp_map_gen2_v1,
+	.configure_trip_temps = qpnp_tm_configure_trip_temp,
 	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
 };
 
@@ -335,7 +358,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 {
 	int ret;
 	u8 reg = 0;
-	int crit_temp;
 
 	mutex_lock(&chip->lock);
 
@@ -356,16 +378,12 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 
 	mutex_unlock(&chip->lock);
 
-	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
-	if (ret)
-		crit_temp = THERMAL_TEMP_INVALID;
+	ret = chip->data->configure_trip_temps(chip);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&chip->lock);
 
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
-	if (ret < 0)
-		goto out;
-
 	/* Enable the thermal alarm PMIC module in always-on mode. */
 	reg = ALARM_CTRL_FORCE_ENABLE;
 	ret = qpnp_tm_write(chip, QPNP_TM_REG_ALARM_CTRL, reg);
@@ -479,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	 * before the hardware initialization is completed.
 	 */
 	chip->tz_dev = devm_thermal_of_zone_register(
-		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
+		&pdev->dev, 0, chip, chip->data->ops);
 	if (IS_ERR(chip->tz_dev))
 		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
 				     "failed to register sensor\n");
-- 
2.34.1


