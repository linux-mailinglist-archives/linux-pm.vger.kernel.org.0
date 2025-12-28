Return-Path: <linux-pm+bounces-39988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E5CE5418
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A388302F836
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304F522689C;
	Sun, 28 Dec 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cp+aJFLE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WiK83+Q8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557E13A3ED
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942461; cv=none; b=DPu//QGebz5/FCS6FQv41tuvYcTn0rnQ32yoHhYu1RdX3pEEZ1Hax/9K02LdBXPsv8rmsXPwew4naCA55Xh7TtbhpRKLHMPmFxnyKRUAU4KY9jK/9AedfGkviyECJKnIZ4v4TR+uePdGdZWg7t2cqN64zAG/zusXBpgp4wSzSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942461; c=relaxed/simple;
	bh=RR0xOQLLtrXPV5kRPIO4cHWLbRM+XB8C1weupKJA+c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bv5Y1S12oDz2BHAaMkcG4cwEHB0chdGYMBcU6g7BKsMt1IOUtQaXOjtNVTihTrtofXeqqzgORh+tbjxYLTW+jDLPayXSmFJmuj/JzZkW3IZvG0YyZEU0M+oTFRxgrDYETV5eDELBPgnw95A9c1hQV7ZUjcXBdfDtuyT8R2rm+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cp+aJFLE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WiK83+Q8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSCYYNL2523333
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S0o1zCXTjNkh/pbRdZs0xzKk67AJPh5NU+NUSgiOw/4=; b=cp+aJFLEvVC1VWrh
	B4+E+Tql+Q7M3DevsdpOgnBdBBE6ZdphLHdLJKe/+WgjUOU8r2c18uIhXGtN0UF3
	U3P7i2A/fVNRi0WSVPceVbcf7poZ3+OllGDmj504PT2KeVNAEZVNh2QDC6hrMwvY
	PZm+2XHl3I6lModn6uJt6FBF4lUiWQ9pe7H8lVzWGjOAT+YESAkZFWW9Fcj0ZUMG
	RRgnGW1BzbCyw395keZeq32BEIsbjY+sFKu8bABo7jSRtD8hGw1VL1DEyL57zQgs
	2iL2v6Rd5wVN7hGfFHANSDOUndSEeNe0mywMWBUizKdXbOpHZwAtbWBBH386WZWT
	KQ6n/w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7p1tgyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0e9e0fd49so100461555ad.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942458; x=1767547258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0o1zCXTjNkh/pbRdZs0xzKk67AJPh5NU+NUSgiOw/4=;
        b=WiK83+Q8W/4Ig13t5zTktug3Zitziwgqkicf5dq3wAcgaps38k4j1dK8D0cERMcpQB
         gdacipLwEnepGtIUEjBfEmOdijeQb9KsvRVD4YEECIsp6GUHAvl6duBUNDpJp5pE0zF6
         yDays6c74VTY8kFUmLjdzJ/F1hE9Z5QcLfCJGX17Lysr8o30ffj7Ch/R9e6qufqHGs4L
         maJYXn1C1sHqS3fHOdJZT/E9C+WxcNG5V/F2cD7xSI6xhA5iC5ig9PaqMI/DXFG+u/yc
         6BXjx4i6L5cyNq9c1QQgPonweH6TZApIBT+Yp6AJ444G3aWuqRNGtz+zKtG4IT1wMPPv
         EDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942458; x=1767547258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0o1zCXTjNkh/pbRdZs0xzKk67AJPh5NU+NUSgiOw/4=;
        b=QUQPOC0sT6xuFXNPTu/2O/jt+hcAQzu7EZsq1fu+7SHwIdg18IPrcJcnnudbXwjflC
         Q7yUGJOaOAD5K0qJgntRKVAvqC06vHlAxHD/BjwQy/bWsau9y4g/Uc8qzom3VSrXMv71
         D+zExzHzzg1qMXDi0qo+RHnTNC1doNaXHGwK7pYCwMpyP+CFMWED2wjQGLoFwai/93Yy
         +9MHihv1uEgzpVxBaAMCZDiG7/j0Iharuko3xD/Dp0LGA/OJAzq1YtsDyR11UE8paDpe
         xKOlfsDQwgxrD3KkxlYW+eewzyvjgcdoIfmx+4kiRKoSAbi7Khg3bo8CFSEopRSTmHt2
         HFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWn1TR2QAMM0ZVoOL7axDSeyidHB9Sv5DndflrxMtET9D71QE62ucimSNTL1szve/f8eVe98NADg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5QrtDhx1/3vwFJWUCYLDyIJuJM68K/G90zQ/v6vu/0VeeWYx
	rdKmBL8gW+LIXptcz70iOdnKwhu0tO0ZlSzaFXMEj71RMJWFxEQxtKgRj4wE7G0nbwWdI7e+r3i
	xxGWkvKN25Xp8pGNjXLytLapL5E/NNyX/Hsv6YhwH+pEE9qrveo+U09BXsfo3EQ==
X-Gm-Gg: AY/fxX56fyXMj+lTIh0My0kSUJuu0dbAvUY549o9JMFi4s7GoxQCOPHaa2q7JvbeiSG
	Mtdwfr6y1knKq0vT/kYGVbMw381lH9JqfT20+gQCjXPZ1sEg9ZEbPzzUKq45QNehv2DTb7PNDq1
	86dkZvSO2Cuh0jGAhPKo5UJq4QCYnetGXLR7lhEB71qmzZ1j6jOmcMIfSDCWbo8OzgyLk1Mhr3i
	Wy992aJiJYpDFPxvwwaAsV6VZR+jOkckTYM+dnbiIzjP94LeEAOXXUe8JaGLadERB4JQv//6L1b
	5AvzDxyc06tfL0/tIQjZg7AGY5GzNTiQJ+Qi42QHXRPZYBhbfWJD6RebQmUcaoIH0ANq458cz6a
	aAQEFEDOKJOgEdF1hKts4V4+Xl0N3PH1vjr/CKxHOEPLgHg==
X-Received: by 2002:a17:902:d2d0:b0:24b:1585:6350 with SMTP id d9443c01a7336-2a2f0cd2058mr314763815ad.11.1766942457550;
        Sun, 28 Dec 2025 09:20:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBe5Txf/b1blWPhrmKhnlyFpaO+p9BsHeyiOjkOmGftLhpF+t6BCy4iYoTHXTykwYPFM84OA==
X-Received: by 2002:a17:902:d2d0:b0:24b:1585:6350 with SMTP id d9443c01a7336-2a2f0cd2058mr314763345ad.11.1766942456990;
        Sun, 28 Dec 2025 09:20:56 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:20:56 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:21 +0530
Subject: [PATCH v19 03/10] power: reset: reboot-mode: Add support for
 predefined reboot modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-3-ebb956053098@oss.qualcomm.com>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=5544;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=RR0xOQLLtrXPV5kRPIO4cHWLbRM+XB8C1weupKJA+c4=;
 b=M/YNhCaGnRsu/MkjLVjdG2SPg9H51HzeE4kgbtRPGlIFzxuidQi8h+tPHbojQ3ty47bBbQihz
 Tst7V7lloqGAL95py59+K6ejFt5sVD6F8mFcTbr9f2XAzKPHOtnN3aI
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: ppf-UWGkr8Hg4pBOcWtUug4H2WfUGvFY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OCBTYWx0ZWRfX2jAbpKP04kZi
 +E6Bm7ZESoP9hhsadtAdDtmayTTyjFvRiFDg+OngYNUdTMqwBTgXyuntQqWmTPU1G3TJDgQ/B7s
 l/6SWvH1gyjGEUBBBp8BpZUKb/cGn4QLlbx9JAdQX9pXohvfEtDxtLlP6kF6glMZmsLBLmmdb4n
 FNFcKUBCM2O9NNcqUfISW95+Qqont/mpWR6lJiYVaLMepyxy8THNHw55k/qJ6pqKRqjRBVUBimY
 jy7XC1+N1CuiBoAHCj4UZbwAwomY7fpvAzBatQKn1xQVFFrPO/lVFi4f5Fdb90k+Myl//0BiHD/
 M59nvWsUxJ0+uY9BKzZ/PvsNcNKq0FuSFqNsn+9+iPkdMiKR9OQJfupXFft2rjwDIXd2SPWPOu2
 1un/D+f7weOU0FIlbQ1ZfLlDHwMx60RXBeRtEB9EPojRk6ZLuT3Pi87odqhTxHR6WMUxyH0Kp74
 nholCBb3VkOr9G2JOLg==
X-Proofpoint-GUID: ppf-UWGkr8Hg4pBOcWtUug4H2WfUGvFY
X-Authority-Analysis: v=2.4 cv=PKMCOPqC c=1 sm=1 tr=0 ts=695166fa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9azGcnLTnVfPEkPguh4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280158

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
index 1e85f2c052c916e153c7c9ac0b184c91d7153402..877c2459a3b2e47679ee2e9fbb9b0329dc3b1e0f 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -16,12 +16,6 @@
 
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
@@ -72,6 +66,7 @@ static int reboot_mode_notify(struct notifier_block *this,
  */
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
+	struct mode_info *info_predef;
 	struct mode_info *info;
 	struct mode_info *next;
 	struct property *prop;
@@ -83,6 +78,9 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
+	if (!np)
+		goto predefined_modes;
+
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
@@ -124,6 +122,24 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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


