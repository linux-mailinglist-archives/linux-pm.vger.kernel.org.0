Return-Path: <linux-pm+bounces-39877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442ADCDA0B9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C605302C21A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79C335544;
	Tue, 23 Dec 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4HDq0tT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ks8MTDTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5C2F7AB1
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509687; cv=none; b=l3noOKKJwoQQjzQDX6tG9JJzmhSwDu/jGIYbUUgtb13g5v2QBhKnukr67QXFEqxGNPQkAoCD1QyYcyy5CSZbKPeV4EiBhS3fhSykKZJl77pQO7ET214KThgmIejUpEAmk3rGIFA/Hvmopd1lfDCZJUEzn5zFWw9Jrmt+XjZsBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509687; c=relaxed/simple;
	bh=PN8XgGtqW6YgfHr48yEyP7m5MdenrdUHWGoWarnZY1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF+wxUsJuXxt8lR8E/PZiLVJNK9BrlTo3RZTFPrq/oIFzYQ8J2N1QIFWEkHAUuuGN01SP/SRYgxxYUBD7zQiBS6a07ZPoXusmh2TFyT4ULBLKr5S8CQ37i1GsIIMYUkJj5pH4rzpf24HHtnmzoqwiXeNVy+9KhMneMzzRKVE30Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4HDq0tT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ks8MTDTm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNGZuHp2778107
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BuJzfruUe3GRTHem0CZT3bmLDfnPw1fzYeLWKqeqq9k=; b=Z4HDq0tTHyRZcQul
	eGnegLNHouBadD0uwEWvImFKSYkryEFUBZgjlEVV9OyK/pInNCS+ow55edHoxHhy
	8T4cpVGebhej3OwEI5tRUsNOgER2wDwWy3fENnvld7UPLf5dlUh4UF6xWMbadoPd
	1dLpHy9hAG7QvZfAIYpjlE2tcCUihUL3HYaVR/EOvBTo3qfh9JFp2ujHhz2JA8o7
	aks06gGT/DVPLat20Cdg3k1gJ7yjhb869O0BZUXPzAkTXFybRuDFGuBs94TzNViL
	EavKkml7cO7lyea9YwSi8DKX5ZnsxsnQDvNEmavTiT84LaQCCsiBUNY7nYI9Dd1f
	kVfcMA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b76yy4dk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a13cd9a784so54810535ad.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509684; x=1767114484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuJzfruUe3GRTHem0CZT3bmLDfnPw1fzYeLWKqeqq9k=;
        b=ks8MTDTmjO2QDmepaXthscEuTM6g5nCELMppbUzf1XGMu61050tpgZNNCFiHb6TJmY
         gD3FDm3yJxyaoQ8L1THibJNBLYYhmIVz7T/s4OgWcEsbsQ+wbHJToJ3iBX0dM4UnwStx
         4Nr4ammKn5tA6we6YX4QgKW+D3qghCweA2u1n6I4kLtAK2c7mCqd9ORmKCEAaRJb80ZP
         apTljBEXqZm92iqwS6LZ4KhsnLW1yBBqqAXGOv2JZ94GmEOJfjJHI0ehyITGb/kqqO4w
         TegvuwkZPdYQbyy3Q6pY2h4e+zo+2HcFuNr6lWe9xjGQhwUWMs7NLlO33LgKk3fhmotU
         OhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509684; x=1767114484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuJzfruUe3GRTHem0CZT3bmLDfnPw1fzYeLWKqeqq9k=;
        b=gZFJSRcAuyEVOyU9bWF0+zkkczlSKnwl7UZ+j3a55NQP4oxacNAL77KcVWyj0IHBhv
         yO3nVOni0Gv662PqpgxGGyyDFj+FS0OGRBqNIEIKiOaR9jyvRixB1gJpARNVhYHdNIiF
         /ZDCIkrFCLEBWfiuyFAuEWhxGqEHQec2VO5YQjhG/Pi5x8qRauHasjKkY5XRh0ZD9JK4
         NCHNv9mkj5gil8A2q6/VRfGM0c7103QF/RdJIAtJUOBI62tkVvuS5e88v6mvCgf8Cktj
         rPFMUquWlV/Q3d7Y0nVEo8tuMuKHJhGk2IWbaQXlDPxsaINjKG9ER2vzY0swnqWpaGNj
         IjKw==
X-Forwarded-Encrypted: i=1; AJvYcCXjonFbt4zF04xzWczw/YA5EANHoi+SdkGtoIQaCZ+W3onZl6yRfcdhK8KdG3FrnBeBiuroytnP9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0F6BrPfyhM7Xl/tU/+/adc2sXt5Gvz+GUDpL+bh0Y7+LHyR54
	6t9Qk0pl3J0GYpWx/zcVe39b7X3m4IShdJzW06t4sfic9EsTQqLKbXhKO9AZzkl9FovhjrBzsI4
	mCel65KDnOE5ZD0jyu7foHsJTy2uB2Lum5X8mKBdNdyBohwUB463rJQ9w9norIQ==
X-Gm-Gg: AY/fxX5385UOKs6C075wKGASn69lkkirwVwmkuemFrULBR6rEEFo7aV+otkBbRrhvvi
	LDGsYGa+DKpOT3RU1pJOymOQBLugqQrX+9hQG1rrDUA/PSip5H34dn3Rt9R3JhfF6fGqYFw5Bgh
	iAXQ2YvoFLeGX+YXxxNel5rujr6nvWYe6i2hBP19XPqQdAWCSs13/yI9hOjYtUF4I0dNT8N1jNs
	8vFNZ3kgyftpTzLd6jeghtSMjALk1fm7ZpcgHaFGDZEbXhU+xK67PYQobK+u8qaik9At4zVT4x9
	Y3wPkuRXm7VxJg8VRCGVUvs0uvaFR2Q0hanpMWN4452SnKZS58k7q35jPT0CKom+5Yc2uKBjL9T
	20mSsEttP+Cj10eCYOCJaO0YAjdQIZjMHcqBYhaa+CGOVsg==
X-Received: by 2002:a17:902:be0a:b0:2a0:e5da:febf with SMTP id d9443c01a7336-2a2f283de4bmr95817195ad.46.1766509684533;
        Tue, 23 Dec 2025 09:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU2BHLXju0TwubxmcjP35lXQk0iO7RIkXm4wYR+cd3MUQx04iH8XUNtFvswH3MksQD9yYDlw==
X-Received: by 2002:a17:902:be0a:b0:2a0:e5da:febf with SMTP id d9443c01a7336-2a2f283de4bmr95816865ad.46.1766509684008;
        Tue, 23 Dec 2025 09:08:04 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:03 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:32 +0530
Subject: [PATCH v18 01/10] power: reset: reboot-mode: Remove devres based
 allocations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-1-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=3584;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=PN8XgGtqW6YgfHr48yEyP7m5MdenrdUHWGoWarnZY1Y=;
 b=0m1D2Z2VqYUtb58Jr5qq5+QFqF7zQVLl0MIKYRgyGEScmJsdxNQ7obTCiuD9ICuyXEpMer/7r
 8fzGy1I+5KXAlnJ3EIWW93HGxOjOOaMi3ojDNjX2ng3aE4DguLHklRM
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfXw0+K3YnpkQ00
 TaYGpcLTfgIjn9eQbpuEGLsK0gZ4TfwF/si665ykfdIdMa9pObww+Os2RPRK28SgmogMQjV7aa2
 ujZj5E0vmIAehqQTJOxgxxxj5OxE4OywMRYx9BSqlecw6ZSQjQICz6UUTUQFxM/hPb+dFxeYcWN
 Bm9tUCGFCBFpt+sfCV4Ag0ASIS22rulBL2q1rGhEsWRHfYfDxvta2DuuGAXKIoz/9QH1zYxsbMp
 Y2npV0167bS1n8j2Clxi58RWeTT00MYuDbq+RkcnkJeLuar3xa9gRgzLmkNDYfDEcCijyO3Q/ec
 pUoDTjCaK2GXRYg4QPVCnMsRMUv5oNc+PZWQNUv+gae+SLS9WLhFKzd1NKBRm3xgfPVvq8kbRyQ
 yqrThsX3/4SjxPrGLW4wedqTp32CjjkltGiqzGVx2mzKk9acaWp/k8YOZRuF0LRJ/ScDuyFmysO
 Kkktje7JfKZtPl9PmOA==
X-Authority-Analysis: v=2.4 cv=Zb0Q98VA c=1 sm=1 tr=0 ts=694acc75 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QIdouwm7mKRySFGJXRQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: DzexZs2xea9vKMdjjc2jXlmNm4U20zbt
X-Proofpoint-GUID: DzexZs2xea9vKMdjjc2jXlmNm4U20zbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230142

Devres APIs are intended for use in drivers, where the managed lifetime
of resources is tied directly to the driver attach/detach cycle. In
shared subsystem code, there is no guarantee that the subsystem
functions will only be called after a driver has been attached, nor that
they will not be referenced after the managed resources have been
released during driver detach.

To ensure correct lifetime handling, avoid using devres-based
allocations in the reboot-mode and explicitly handle allocation and
cleanup of resources.

Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..4b6ae4007c4f6fb7d51520b4be2bf3cb1dff518e 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -71,9 +73,11 @@ static int reboot_mode_notify(struct notifier_block *this,
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
+	u32 magic;
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
@@ -82,19 +86,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+		if (of_property_read_u32(np, prop->name, &magic)) {
+			pr_err("reboot mode %s without magic number\n", prop->name);
+			continue;
+		}
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
-		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
-			continue;
-		}
-
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
@@ -102,8 +104,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
 			goto error;
 		}
 
@@ -116,8 +117,12 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
+	kfree(info);
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
 	return ret;
 }
@@ -130,11 +135,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
 	return 0;
 }

-- 
2.34.1


