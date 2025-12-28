Return-Path: <linux-pm+bounces-39986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B0CE538B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 819F03009FEC
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14922689C;
	Sun, 28 Dec 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CsAEIi+H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fG2ZVz8H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113121ABC9
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942445; cv=none; b=fQD0lBnIZ8fHtR1fMMpKFDfrUTlujdCccrn2CX6wGXpUo462tG4RzpeKct+UvyscMsnw6bOOHBAlH2pPwNlg0QoV3Br7U2sCo4WjZAw1ndE87An8VS0X0q8ve48EKdhHCUPKX2T1hdc3XSsFzQOTmVZuNZmdrQBxhT/kZcbJ6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942445; c=relaxed/simple;
	bh=rk/o3/dn1oyoyEh9/h7QN6VQvqM1qIx8S8Xwn8+Lv1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7zlQFYftbaaFE0kF+TtbU4o/xVCrvPTAMjT2dJSLcopqzw6FSHT3RoBua0Y/+sKJ8r6rH2qw1oCwXRa4JaWENHyFDkNxym3Pn5CuI+G52hKXlxjTr7TEetvEXEwWqmWEqStDUM/jEGYeuOgqOaEe9so9yN/kvDAq5fTm0ft6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CsAEIi+H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fG2ZVz8H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BS7fjUf2127444
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ncyvah5e5r6XDWMSFFSo1CfTUNq2hV3TRvAvXWzPgXY=; b=CsAEIi+H4I3xtisP
	SoQ/SvYTumEBaxTPnC1xk/lGc/cyHA5yP+3+stHCh5YICgohzQNOXA9F8TCxOc4N
	c/SFAuYmsfe4GBrQsN/xYpNLiktvDnUH1KzCinrosKElrqUTFzYNv+JiSpIs5LOC
	4jAejny4jY44qNyPsjEy9N3LKPcX6gNnGMKN30RO0OQq+fAFxCeT/GlFiHnC2I6u
	JIzjjcyUHJY+Po8tEe0jeOpmmSZCvmuu1z0uAngx2XjErYkAK4Qo9WRhfj/NOePB
	Uq2rUnnKj6I+5un11dfCYfuF+ypfMpLFT7DQr28f6hfSiLUXsYp6x84IEcQXwCrb
	FBStqw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6dr2m4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f4822f77so238549945ad.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942442; x=1767547242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ncyvah5e5r6XDWMSFFSo1CfTUNq2hV3TRvAvXWzPgXY=;
        b=fG2ZVz8HAWIZEwUXjryVtHODQoQivGUP84GYO+fbrjfTzXbZYHrxqd2oBngwmKBR3j
         AQG70EBYVUSYSsbmQ6Nd1LzCE7GU1qvpVHdSQkMpIehOt+u+zDjl+ydTAAISBJYXnlPA
         iTM3t3yZh5p6V6wMZPMDQI6Pl3NH1MWoOezN2e5uq832UlgDoC7T+BwmqBw+IoRemRee
         gCB0zEmENEKrOy+o/JtqhGJaAwQDmiRj8upPHc6b6H0e3Wq74SD6SEOCJL0kst+cWvvz
         n5O4IDCFiOExNrNZ1fczxi0hGp2RNhT0C0bFsQxQT/j/zw6UPXAHlu6w56s5l4eJo5+k
         Ad5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942442; x=1767547242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ncyvah5e5r6XDWMSFFSo1CfTUNq2hV3TRvAvXWzPgXY=;
        b=hyzQW815sf8SuSKxPh/BHP3D0dvuyzpuJ7rC7480QO2+D4V6Y919ScuTAZ/ucUP1pQ
         JgyjLLEj3CxqM1pO/LR4RuDfvDWRvkFUBfcaC+KfHoCDmBMU0tf8wk74tsjpWXzGs/l0
         rafZt0rLMsfkoQUSD3cEzPP3hVyKTTxrwGD4CGVcLGI2MRxF7oFQ+PICjojt9Fv8nv43
         3SM2EatnWTo8SgEmDEWtoWjDVHQZRwng6w29w5XaDc4yPknzpJaRuxrnoZaO6zpv7SP8
         3v36C7u7DfittHZXdNeLC3SIIr9tZNAvv4kRbXThxZMSGiYEZvHN4Q/5YJNEIepoyoYN
         Fwqg==
X-Forwarded-Encrypted: i=1; AJvYcCUoDN+NdDgnKJ4IFBgc1T1POakwpYmy/VKX4zclTI45zKyWrDJQZFvslB2U4+vxk1OewOQ7rAGk6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MDWrPVb6beNV3Vd354+94tzcybtQ1fQI3z5rV6FZ2tpKEohZ
	s82bDj7dx8EqPCJ/d1SXANY47nZlhPocy3SEw5GwBMGIeLzd07Egc+AdhS/meqXS5Nz2HLtAtGi
	E5EVWBgBmJmQRPl3asYVMbgeoAjsC5okw/IJVUbq+s3Sbvr64SCxm9/XNy9Eajw==
X-Gm-Gg: AY/fxX5WfLYinJe6UGzcwoVz3s3LGtUQfcoX9lGLBdPb9I7CPjGbJRnpQKhfxI3vBz1
	fwGBlZFYuPguCF+eiWAer0QGTeIpVZYhA0uTcPcuFwRvXsciS7ONWnijW2dSEj/+1e2pD+w6C8b
	sF1pAx+YbEL/qswtUUf/8V+DQ1hiBcz06jQ9GCJrkc0BNqTBYRuU5+r1+Yoq0kh7M+VJyF2uESq
	cVgrSJzncWCZt+DKJpHWD8HyjscpCbgXMX0ow1YmWass6MrrwLKTkf6uESxJ0c5z2DL3VZAyiif
	hfCWxwQQywkExhWnRcKQKoKXhS3H4XzhYATYRgPTpsvM9u8PODqLVtqbI+VP7g/xLJl1ul/7x8e
	Gop7NCO6hybXay5mJv3EMUacPvwG4fOq6LHNWlpktNnuo8Q==
X-Received: by 2002:a17:902:ebc8:b0:2a3:48ff:32df with SMTP id d9443c01a7336-2a348ff336fmr203369165ad.57.1766942441879;
        Sun, 28 Dec 2025 09:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN95+Mh2TIq2sK2yELjxg5pJShOwNEfi8iqz115YSh9XEjuzYEa3oHJxrcZLIHspPckdDAJQ==
X-Received: by 2002:a17:902:ebc8:b0:2a3:48ff:32df with SMTP id d9443c01a7336-2a348ff336fmr203368615ad.57.1766942441364;
        Sun, 28 Dec 2025 09:20:41 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:20:41 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:19 +0530
Subject: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based
 allocations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=3746;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=rk/o3/dn1oyoyEh9/h7QN6VQvqM1qIx8S8Xwn8+Lv1A=;
 b=WE4KkMlDQE7y1M5MuyPJ1J7DZ5mg6wAYvAt8IvFE22WMA3CeJgkTNkCcQPVJBpH5LcUfAa3Tt
 df8S2bPCksBC7ZHZmNVMKfghCx06BAEc/44PoXkkmPTb4hFQJGCixP2
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX1xmNDjsEqymY
 rNyqFyvwHyvMtQOOokDy/xNESHB+1RvO9BLEJ7/CCPmhIuwOOcF/0ovrmYZgpJ+/XOH7PWRW8Zb
 aayp3FzX1EN8v3UZY2CFD8UrA06BXhtJPE4zWcOtcMzweFMiqI6Hr3PISdUIDC2APw/2nXBtTQb
 nvfwBj66bjVZ/Uxz6TAI4fBziewHtdYAtT0V4ke6pEB1TiTy84SRUE1414PLJ2iDFXtfRYhHj5q
 gYLqbjRy3Iuywu2+S6CGDgaZjfIHA6fj62c1mcMdS2DaWCYdjw5GjoCZlreKszDzfChsIUtwaem
 8E6lu6X+6vB0wxaz1PFBvKKjR50JLsfhtTE5sHuivz8u9VbAUa02WZH5zEL0bi3pSMr7IaTnzU9
 5fS9g0Py0O41B5DoOM0Ktec2XAGONW635KZ3GPIe82riwwNBJ+NStnS0oPZAhtP6iQIcvoHAmMK
 2Ws4HwzxMXMgQj/K7Ng==
X-Authority-Analysis: v=2.4 cv=VdP6/Vp9 c=1 sm=1 tr=0 ts=695166ea cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QIdouwm7mKRySFGJXRQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Zb6eJLBRL8rNyu2gr_TjAaEgp0iCJqol
X-Proofpoint-ORIG-GUID: Zb6eJLBRL8rNyu2gr_TjAaEgp0iCJqol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

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
 drivers/power/reset/reboot-mode.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..3af6bc16a76daee686e8110b74e71b0e62b13ef8 100644
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
@@ -10,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
 
 #define PREFIX "mode-"
 
@@ -71,9 +74,11 @@ static int reboot_mode_notify(struct notifier_block *this,
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
@@ -82,19 +87,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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
@@ -102,8 +105,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
 			goto error;
 		}
 
@@ -116,8 +118,12 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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
@@ -130,11 +136,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
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


