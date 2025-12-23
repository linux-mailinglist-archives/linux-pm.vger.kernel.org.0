Return-Path: <linux-pm+bounces-39879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBECDA0B3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 773D130305D4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A6346A0E;
	Tue, 23 Dec 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HH9NnO8m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVL3E4dk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0F346787
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509699; cv=none; b=LSZw9vr38WJXyODS+m5GjABmURYOEbOLU9WxGIDXJRzRRo7mPdBYuPGbx4WC0KnrRP8mNE0zY0dSWwk9URx3Yk3CXKYieeX9DThJvhyjHgdOCpoab+UcNFk/aYFdPuyopV8ZMkWKnQhoV0YZNDqgO7UEG2CfvRXASseqrSOP5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509699; c=relaxed/simple;
	bh=EwcxR/RujuDEpRybikjE1BbpDVQI9UxyV0ysyUeOLxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7I2k7VjQZ/6MGRM1y8XUUgK154TEEPUHTpCBXsL1r0/dUa+VJV/aM/qDKbFVWJ9rQ9QC+sgHXeEk/O7wKF/yFS/cmKvuHCTBy9sSRr+TNGYd07Q1v4E3Jdt1RVrGYjDzP6oOzAntCM+avyUgVD093tsFEYeTE77UVGxuNWZMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HH9NnO8m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HVL3E4dk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNEJg5Y2115723
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATmBcvdi0ZM8QoG3QXHD/flqNJmgCDsENr6fJV3JS3U=; b=HH9NnO8mW92oPOiM
	fQyYZmS/UYALFDf62pRwRkp/yXzyI4p9u4LraYVQktx1jq2Z7JY/nvTyXWBZ8N8T
	f0l/M3yByd4M6RSFar2vUtHZmC1ZDMPRmLk4xTjVygZW951NE77tXHz1cjFeG99X
	6I0yBE9tzuRjPjxujiT6u/NZMDe1+ft1CHEscs0SXP64n3YVbPCktZzvOADaEeeN
	zrBrew/Z6HDV4CyomtSjP1+aDB8GEBQPoO/drAHKeoyc3Dtd2j7RJq7YSPecpxjc
	7nX7ZGk/bSIe+seEYrI7Y0fVqNxG5obXFXxR1rmd7mMBE9xLFumqlblW9pIb0KGQ
	7Lfm5Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7cudkf9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f13989cd3so157815205ad.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509696; x=1767114496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATmBcvdi0ZM8QoG3QXHD/flqNJmgCDsENr6fJV3JS3U=;
        b=HVL3E4dkg4GdlCw1YBwDA+rUi8UzSVzr+i/OUqGyIo+Ywp+/eiTJKKchT9cdAJxG/+
         ScwyTEss4c/LVk8CwXK/Fl6a5DvS6T0cFJQ5pX4PJfvY0L7C11ckNXG64zA8MrZ6zVlh
         mXhKcGLP17JcT1f6Jp5bQmUTYinpw0vC+QgimGYBoe2hW8ctYQOcSZdTQFNJ4QRA/TcX
         94Kn8/jz8ISVgV64DmPgoic2sTjRrsEgKA9NWV2DQTkrKI10GoVVwoKS7XIM4pSjSC0m
         PWY6HZM/9m9cnYmudDX5ycGD3ybPckemrcUyrBH17sAP3CoYVKCcIPb0IdkeAkVZODPq
         gInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509696; x=1767114496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ATmBcvdi0ZM8QoG3QXHD/flqNJmgCDsENr6fJV3JS3U=;
        b=Q1+2GEPxiU96eYKMXtpPLiuwWUXcLlnX55fwfZraZ8myY3ZKeeuY4cftvy36SbPsLZ
         ir6M/UpGneTC+qM1IZ/uCvS1q8pXP+F4kKjxMrYgvfGAOPtVgMoY6fNAvPq93megl989
         yJNvdJ9g8Pj3JtK90Y/GaXAlPCg/gjqXdeFKyw4/1UcRmgzbwQT/u0k/qfSinJ+Q0yfq
         SxL+2Az+SWjD+hPq5K/iSFao1YAyQA2G0cO34qJlgrcbHlOrcB8LYaH7HWteShtS2cJW
         O961Fy2QX/M5NGaQQdt8Swdd0NaX1B+wDWpTMfS62RpUdX1JqY9D2zDOLuDMiY8khxNs
         gFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9IjFqLL4ym+Lm+os+HKIfQIp+u/1wqMMLxfx5p/QopTe0a/gKNbrAmXJ1Q/ipAw7gi+pT3jcCDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8SefG2PPzafwlcPqj738xxyo9wD9+OXL/SYwgbRRmT6s/96j
	ex62rc2/EZIJRGHA4ExpmU9KTjjWGPPdqFuQLBWN3m8SDgT9OHUPDbxTQ1lZBNwqAgJafnRywt7
	wHPoJJhKBHW+rw/VW0zSYErL+suOb9YBbTslMNPWFUzAbJfi9oIVugoNOQy/9QQ==
X-Gm-Gg: AY/fxX5Qv1k9wzxqNwIFZUBwHNMW3Vvf7lQb2EFJkCok2Ktn8aTBgzzqENykYwKjdra
	JXUrWwkwsBnXHgzQUjTUwBXCVd2Pftp/1baJz2OBXnMuP4p1p1H46WaQcBQak4nFDQPoKaKmV1y
	8s5waYYXJpzwlJuhlabjQ3I2dCdIN5fL5K8KmVVbM5Cl5QrSRsQc8iFqvWZGkneVi/bZ0J6sxgN
	tbuB+VVnk8YnYCST+ZDZxQvi9etBzIiRc3KuD4EvjX3F/8TVlTeIrGJpn8n1xbxzj1eEY9OVwzA
	N1/SbBlSubcx0FMB5TRgwvMDQjuEozGfzEQ5kOzxodaDTyBvEGbz+FZ+5hhqtBvPgWjAulSP3iC
	6hl8VC9SmadOufyQcLiC41vz5YmOnTTFOOZWZRjmwW5iyHQ==
X-Received: by 2002:a17:903:22d2:b0:2a0:de4f:c96 with SMTP id d9443c01a7336-2a2f22290bfmr155876245ad.18.1766509695890;
        Tue, 23 Dec 2025 09:08:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLK98y9AUy+4JNxavuFk4mRdGfVbrYe9HdiVU9bqvyrNEVl99KZev10YEXapHKTBkUt9/3bw==
X-Received: by 2002:a17:903:22d2:b0:2a0:de4f:c96 with SMTP id d9443c01a7336-2a2f22290bfmr155875775ad.18.1766509695401;
        Tue, 23 Dec 2025 09:08:15 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:15 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:34 +0530
Subject: [PATCH v18 03/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-3-32fa9e76efc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=5544;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=EwcxR/RujuDEpRybikjE1BbpDVQI9UxyV0ysyUeOLxE=;
 b=k0L6kc/W6ljfBJPxAe+iBCBIK2dumAtN+LIGDVzfVBr87lfwWKHECVyHSAazU5HMEKCsxDTqJ
 8W2Eiwi72HnB2I0oUhcB8wVNTPjEOpMwbzeoBYJv0zY0ko6WlRNP0Vb
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=ebkwvrEH c=1 sm=1 tr=0 ts=694acc80 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UVh4EkS4hOj72C4E1asA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: QD-AYx_ZqVv4YpJC2g3rVCFsDxHc9uTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfX7ZU0M9LGGFmt
 +wjhb5gc3fESdb/Bkompb8F3HsiSgLNEb1uNJ+NjuQWgqMoD8pr0Sy+CgTyLWYV5lItXjaZDa6u
 LnFSSh1F9kTJmjhZxSerj4WJ7/Gq3gEzxPr0WGvkbD3QrH4QDMzRwL3yOZUY5/lu4LPbYYsrexA
 9hivzN9m/XWjHaw/lKYyI2qHXX8QoF7r90X8SXWY8fq7atERBtB9OIXtHKj/oqqgMvLFR0FkAF4
 k8jQBZizyUk3+9Ay1udBWqgrSOPtmEiSUCNQilMOBwMOlm8rCc1CFhcQe2bZ+t55yJH8LEPp9u+
 iRWKODocz5CwEJbHPhPsA9oZQzXNBqT7iitghxBXsNLmX1e8paUekSKt+vUBEotSTffJRAWc2dm
 eBVZqxLlH7ibH5Kg3f6SW5aTuJq/yYGPanPk44WJomvD2aoqfurh5tC4seRRN80yn+jcv3rUYjx
 kA+oo+L6RgMzYfB6NeQ==
X-Proofpoint-ORIG-GUID: QD-AYx_ZqVv4YpJC2g3rVCFsDxHc9uTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230142

reboot-mode based drivers can define a reboot-mode by adding it under
the reboot-mode node in device tree. This limits such drivers, to define
any predefined reboot-modes statically within the driver and creates a
dependency on device-tree.

Introduce a list for predefined modes in the reboot-mode framework and
process the predefined reboot-modes along with the device-tree defined
reboot-modes. Modify existing reboot-mode based drivers to initialize
the predefined list-head as empty.

This patch enables a reboot mode driver to define reboot-modes through a
predefined static list, in addition to the device-tree based reboot-modes.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  |  1 +
 drivers/power/reset/qcom-pon.c           |  1 +
 drivers/power/reset/reboot-mode.c        | 28 ++++++++++++++++++++++------
 drivers/power/reset/syscon-reboot-mode.c |  1 +
 include/linux/reboot-mode.h              |  9 +++++++++
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index b3d21d39b0f732254c40103db1b51fb7045ce344..b02a2af31aac52cb0ab19cf5d4d315d17c208f6e 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -44,6 +44,7 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
 
 	nvmem_rbm->reboot.dev = &pdev->dev;
 	nvmem_rbm->reboot.write = nvmem_reboot_mode_write;
+	INIT_LIST_HEAD(&nvmem_rbm->reboot.predefined_modes);
 
 	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
 	if (IS_ERR(nvmem_rbm->cell)) {
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index ccce1673b2ec47d02524edd44811d4f528c243e8..bf7b9f0bcdcc4c168aa7ff8d6494122d898814b5 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -75,6 +75,7 @@ static int qcom_pon_probe(struct platform_device *pdev)
 		pon->reboot_mode.dev = &pdev->dev;
 		pon->reason_shift = reason_shift;
 		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
+		INIT_LIST_HEAD(&pon->reboot_mode.predefined_modes);
 		error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
 		if (error) {
 			dev_err(&pdev->dev, "can't register reboot mode\n");
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 54adcda57e44edf2fd2cda0f752226f747aa72d7..c17c61f47f069b96a9b38699de71dc1f30a807c5 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -15,12 +15,6 @@
 
 #define PREFIX "mode-"
 
-struct mode_info {
-	const char *mode;
-	u64 magic;
-	struct list_head list;
-};
-
 static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
@@ -71,6 +65,7 @@ static int reboot_mode_notify(struct notifier_block *this,
  */
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
+	struct mode_info *info_predef;
 	struct mode_info *info;
 	struct mode_info *next;
 	struct property *prop;
@@ -82,6 +77,9 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
+	if (!np)
+		goto predefined_modes;
+
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
@@ -123,6 +121,24 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		list_add_tail(&info->list, &reboot->head);
 	}
 
+predefined_modes:
+	list_for_each_entry(info_predef, &reboot->predefined_modes, list) {
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		info->mode = kstrdup_const(info_predef->mode, GFP_KERNEL);
+		if (!info->mode) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		info->magic = info_predef->magic;
+		list_add_tail(&info->list, &reboot->head);
+	}
+
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index eb7fc5b7d6a7ed8a833d4920991c4c40b5b13ca7..74e2e14c5d87c54ac24ef63c7905b3266d736439 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -50,6 +50,7 @@ static int syscon_reboot_mode_probe(struct platform_device *pdev)
 	syscon_rbm->reboot.dev = &pdev->dev;
 	syscon_rbm->reboot.write = syscon_reboot_mode_write;
 	syscon_rbm->mask = 0xffffffff;
+	INIT_LIST_HEAD(&syscon_rbm->reboot.predefined_modes);
 
 	syscon_rbm->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(syscon_rbm->map))
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index a359dc0c6dede0ac5ce67190a00d46a7e7856707..bddec9b7f94187dcb056540df79eea34c25b1d0d 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -4,11 +4,20 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/reboot.h>
 #include <linux/types.h>
 
+struct mode_info {
+	const char *mode;
+	u64 magic;
+	struct list_head list;
+};
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	/* List of predefined reboot-modes, a reboot-mode-driver may populate. */
+	struct list_head predefined_modes;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 };

-- 
2.34.1


