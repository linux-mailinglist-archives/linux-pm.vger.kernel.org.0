Return-Path: <linux-pm+bounces-37312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97DC2DA4A
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0AD3BE0B6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C229289374;
	Mon,  3 Nov 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXJ3DqHI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FBSgSJUa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBE288515
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194021; cv=none; b=JKJo9LqHja6ocKvmRp0xwBkgduc07w8Agg6UrR51Lifihdu1ZrdVw3XWnInt23RMq6JKf19UEppVbFB+gVg+WmcaZk6Ds9+Yq/l2R6jo2aJHHHhbetszobRq6vb9UogFbxGyHczEI+iFrVLW6CSz7yIMNAWaukiJaBMl6enxWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194021; c=relaxed/simple;
	bh=Q6bHgr1oqrBnoYvPGNlD5xwgEH7qcJBuNaL/oeVsRJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBwBba0kEWXaFcfuNxyxw2ufeisaa9BVYztkor6hAhRlKDzaeOOFVk9LkkFj+dPNDfdqhf7IhVGh8FGJopiy9Gy2IEOGtNzmiZ2IUNButehIdbkXnVfTXq2CEHJUugb1d1//qkLNNRJWlSiSDDL43jPukG97fObEbw+4hZ1+LVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXJ3DqHI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FBSgSJUa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3Gfl7n3693411
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 18:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8tRAlNWUh1T
	DOg1qx9b2GlE5CtgGaW52tx1QaEy3eJ0=; b=pXJ3DqHIdtjVmn9uoiKese2ZzIn
	WtnwCm9yQzYmydIbk7up1bmSWFRK3oMQ2/oLyrNKQrtcXsb6LC9vCGf26PyoM8I7
	JbZtsFuUPpFQfknm15cAiNiIfKkJOOj+2NLHThQNAmQQbAKh7vS6OqTgGc27A+7r
	5SpwOIQyRIknnP3IAxHfW68++2Pyg/MkqCaGfIg3abMtSPTttwvyh+4ikEhvHI51
	fkPeUj3x8+SAJDMMWJUssNG7oZIYWarA2Wn4L7xNvGdYtfBJ9AdZsp8wzewJkUJC
	7C+Xvz/ZtQkifsTpKdqEAh7/IMEhERQpoKn7QmA8pcrNjSZaZo6apiqeWiA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b1748-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 18:20:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eba930d6ecso137819981cf.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762194017; x=1762798817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tRAlNWUh1TDOg1qx9b2GlE5CtgGaW52tx1QaEy3eJ0=;
        b=FBSgSJUaJBqd5Wotx4JzzJ+ndM7EynHwrPCmSkQ1wIjc9JqAHZd9L4GrM+SkAjgmF8
         XcTJEib0A7XWf+HT+UaUZf5GLML+aPzPgNOWfoDBRyvJSS7tEgSfksOLJYNjA11b14Ie
         xebZPriU1R0H+DxQXOcm4Xtsqnypvv8wXoqRKiFWRl+eLtKEe1C1thW6AE5Ffz1UkNMo
         J9LuweeP8yJiF58JkG7GlVJVnVgZmqfxPTMdL9vUqneBaQvo8KSGCs09XZXz+WD+sj6Q
         gMaNopjWydoi2hsDkX9W6T2qQ6OvSwTqgRh+QhbzNKMKIf7ucU0JtrW7pLhvjGAQ00ug
         JC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194017; x=1762798817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tRAlNWUh1TDOg1qx9b2GlE5CtgGaW52tx1QaEy3eJ0=;
        b=jBojva/ZZNyibCViGplVXwBgA7N9JDZexl120YQo8OEHzwwh15Dmu36PIpkpLPfZem
         MX8/TWS7NW/uyn5A68k/ISy5qn47RfyjCnCiwvmmPtOMRqpg90U7/LnZsXmoO83xswV0
         aiwp/MgUKtDAPNnCf7k/Ou75Xkv8Q+tL/xOx4UdABH+z9aocIGfKXuezkva8yxkzEumn
         l4wryivE9IsQrn3gYxwVhvHHno+/U9neQCIwXkzkYy9MGQGvtme7fa1vVG2CFO/fsNNG
         ZcrpJ6V+UcCaU0vGHrIV9lP0e6gkgl0kc785BBQfLFBxWoR2QZOFSQmIGT0kiDsmBuXW
         L9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU6wIiW5phSmWN13L2Ah2xa2cWVeLzSZHwjY1V57b6TAWrXf2wuiBllOaymx7lGN/pksuoYNm4bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJHDt1vUjPqHvtFeLukBr0vgH3I7nlzORNY2LRzJ53cP3BML1
	9WY8Jf2uiz+g2WNYNT3l6GLH8VTEYyAmhFiqBj/YkS//cCqBe15jo/1oCtrfTk9DqwdJFrPc7jf
	W5xNGFV0zkW6RRwCfIYN8h440fExoNvyC5G3yyLf2Zegjuuke1AouGmQtNs7v0A==
X-Gm-Gg: ASbGncvQs+sVH8e4gfBxoLkYLYsodWiM1t/HbvQajR3llktHlcncDEkGWX5+Ez4H2po
	xs+D/1toFcIwYtg/S/3OPUsyqnPzn+0GJn33OA2Ed4g0apZtFeiiFfzMSCDWKngnVjlG0tAfKoG
	9eZxaB9PDDqINOC4KLMfF05jbaQ/l980Vo1c+AzWFyIGCynoC838IAxC8trpUrUFJWHtJzRJHWj
	fYJWXGwdyKdqAunsDRWwh155UyZFVNWiSyWAxe4LmdbZIr4DO7tQ9Xrj4gxFH2caEgD0quJ5m8N
	LGQATOY447eKHV4WMPm29g74Y3qFfQ2DyUw04ORCwXFi42EehYlqnS0EG5OM/QwawfGUdb/ZiNS
	ZBGsV6nShLj0MqSum1qSnwTyt+r4DiRSkRG15gQk0HfxbeuSAinDv9gX64Kk96rq/yA==
X-Received: by 2002:ac8:5c82:0:b0:4b7:9f68:52d6 with SMTP id d75a77b69052e-4ed30d84740mr199283471cf.9.1762194017590;
        Mon, 03 Nov 2025 10:20:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2qfi+M04ye33cTnZO0lu9yM7vkU12Xr2q2GEjdvMB7mCD27JrucNB+izaWmXtzykpET0+bg==
X-Received: by 2002:ac8:5c82:0:b0:4b7:9f68:52d6 with SMTP id d75a77b69052e-4ed30d84740mr199283101cf.9.1762194017193;
        Mon, 03 Nov 2025 10:20:17 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:8842:5746:daeb:a8f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm169096545e9.11.2025.11.03.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:20:16 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
Date: Mon,  3 Nov 2025 19:20:03 +0100
Message-Id: <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NCBTYWx0ZWRfX4IPLMJKx6YJg
 xo0HXjoarynE5H91mtwYQkcOGFdqN5py8cpcsX7pdi0Gz+UDAOz/D53+V7KDP/Kz1195+moXajF
 DHcELfXzvMTs7z7vJ/e94oF4R60ek/7MYE82anT3qFpeWl7L18dwSEVHB9My362pwzxezCXTAz0
 uZDTbX56zotHrCwyprRvyHFWMBM7yXqB6megEJoNhaq/5wExWwL6w4WZe86n/ExFniJ52KyQHqW
 42jXlE8rd6rxq606dV7p7RtP8+qKuKsnUDi0TgP+J3nzf/+PNGfy7HjiqRoLXI2smfD08ChaQrm
 WA6esG194EmWIoxCmQBb42j0PIgi/gMzGnseTw04yfWqbwiF1N/KVWPtuiL43M69NzEqMYYJ21J
 xy36c+g5gcYgVf6qSNQXa3lHB8xWjA==
X-Proofpoint-GUID: x7qOML9HzuKBS_aQ3_wg_3RuOve0Ga4j
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6908f262 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=SLKSYyjenuDOKbfwxIIA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: x7qOML9HzuKBS_aQ3_wg_3RuOve0Ga4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030164

This mechanism can be used when firmware lacks proper warm-reset handling,
for example, when the PSCI SYSTEM_RESET2 function is not implemented.
It enables the warm reset functionality via the PMIC.

This fallback is only enabled if qcom,warm-reset property is present.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582..684e9fe9987d 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -19,12 +19,20 @@
 
 #define NO_REASON_SHIFT			0
 
+#define PON_SW_RESET_S2_CTL				0x62
+#define		PON_SW_RESET_S2_CTL_WARM_RST	0x01
+#define PON_SW_RESET_S2_CTL2				0x63
+#define		PON_SW_RESET_S2_CTL2_RST_EN	BIT(7)
+#define PON_SW_RESET_GO					0x64
+#define		PON_SW_RESET_GO_MAGIC		0xa5
+
 struct qcom_pon {
 	struct device *dev;
 	struct regmap *regmap;
 	u32 baseaddr;
 	struct reboot_mode_driver reboot_mode;
 	long reason_shift;
+	bool warm_reset;
 };
 
 static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
@@ -44,6 +52,37 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 	return ret;
 }
 
+static int pm8916_pon_reset(struct sys_off_data *data)
+{
+	struct qcom_pon *pon = data->cb_data;
+	int ret;
+
+	if (!pon->warm_reset || data->mode != REBOOT_WARM)
+		return NOTIFY_DONE;
+
+	ret = regmap_write(pon->regmap,
+			   pon->baseaddr + PON_SW_RESET_S2_CTL,
+			   PON_SW_RESET_S2_CTL_WARM_RST);
+	if (ret)
+		return NOTIFY_BAD;
+
+	ret = regmap_update_bits(pon->regmap,
+				 pon->baseaddr + PON_SW_RESET_S2_CTL2,
+				 PON_SW_RESET_S2_CTL2_RST_EN,
+				 PON_SW_RESET_S2_CTL2_RST_EN);
+	if (ret)
+		return NOTIFY_BAD;
+
+	ret = regmap_write(pon->regmap, pon->baseaddr + PON_SW_RESET_GO,
+			   PON_SW_RESET_GO_MAGIC);
+	if (ret)
+		return NOTIFY_BAD;
+
+	mdelay(100);
+
+	return NOTIFY_DONE;
+}
+
 static int qcom_pon_probe(struct platform_device *pdev)
 {
 	struct qcom_pon *pon;
@@ -80,8 +119,16 @@ static int qcom_pon_probe(struct platform_device *pdev)
 		}
 	}
 
+	pon->warm_reset = of_property_read_bool(pdev->dev.of_node, "qcom,warm-reset");
+
 	platform_set_drvdata(pdev, pon);
 
+	/* Higher priority than psci to handle warm-reset properly */
+	error = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
+					      pm8916_pon_reset, pon);
+	if (error)
+		return dev_err_probe(&pdev->dev, error, "reboot registration fail\n");
+
 	return devm_of_platform_populate(&pdev->dev);
 }
 
-- 
2.34.1


