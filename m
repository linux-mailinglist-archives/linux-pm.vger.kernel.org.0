Return-Path: <linux-pm+bounces-37680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D862C44070
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAB2188C2A3
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB8C2FE561;
	Sun,  9 Nov 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIoQb7Uj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DqKsCLBb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30AB2FE06D
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699096; cv=none; b=QMl8cQ8bXdAXh8ni+wkcKv9Av3EdU6b3cCsT1LiLjWJJWHKLuw/nEWg3RsUDnQxI+6dx3LaFYb9yyYG46CxOf7p1G1qqPtZSGzF5HZZI1SqLJ85QUxErI/IzAoOQ3nEenFai3tTMoKxDKjkF58fKupHR7SZYiJ/mRoWO/0oAuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699096; c=relaxed/simple;
	bh=tSD2yNZaJDc5m1jdDRoQ2dA6oSVGR8ZTHjS4GRBmNcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrWYUvlbH3hoPyLmTbV7yeTffCCxjrrLdHCtl6wy8wutm5kCx94d52NHKxIaCjQ/QyUS4SFKpkvn+cAhBydWO7bf6PArOD0d7o96JnW+AIj9dp+vKKXgt99HacUVwB40JxmpPOkPnDP81WasvrsttLFrzuuKv7lL38pTlUCr+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HIoQb7Uj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DqKsCLBb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9D0BRB634835
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jiNDMgJ1PRczoI1657/zd47IielAoH6hCTaVhiNKpyE=; b=HIoQb7UjY9q077NI
	kVl2CpnPnEJvwugYDSyD0BYY7Ki1Ddbt4V2S12+fnDUy7cDXHr5lEwCKvV8sfzI4
	UGzOvjxgkrxhEUwljXiwKmposcK1U9CsT3eDZA48WD9edb5d24OEq03Qy3iKMW/l
	gm0pZPVbVktoSzG9zqMu1MEuAM/FnB5PduxO6LdBsEO/sSKBZO6gkjsIglsAlUl7
	ucvhr1MhO+1vPJlKDrGpgkph5Id5Xk3qpn0TgRkyaMaOmdXOHOuBCrhDfDG8nNrR
	bDGsRSZXq0NYbxd/hjscqlwJHKiOraj4NgN6QLnWQ9jauzBQkncuaBsVC+vb00o/
	irn1fg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0g3cc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:38:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340299cc2ecso2896730a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699093; x=1763303893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiNDMgJ1PRczoI1657/zd47IielAoH6hCTaVhiNKpyE=;
        b=DqKsCLBbFDQft/ZoGsDbfSkzCNmoOhIn+rQjC7NCEHqAshONiYsT6cuUhZsfhcFQs0
         WRqF7iwG0cZRrMtvevOukeUEzaqhbwQ7wfUtRWhsnwwNNxAHQDE22WuOqyef1nte4Ue6
         Z3QL/GAHMi/h17jO4dhzEpicBbZu07CXmJKsdNQ4C+gts1rI5ZvdUJ5lEMkFHTr2Iez3
         A8skSGTo8bmWWXWm8s37LjRYmvT/pqPAJEf1Q2DeSs8rfgL1qKtcAzuVLbjdqJ7lmr0D
         0CgzYxFhBmfdcc5ZJrY8f2VEflbEWmaE8aqx076ILATG9m2uTXlKCwQAMLABE+J3gNC7
         9CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699093; x=1763303893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jiNDMgJ1PRczoI1657/zd47IielAoH6hCTaVhiNKpyE=;
        b=SPJGy4Em649Wc4N/Ncj5sj2hIcJpN5KR3E0XxbIJnNRhfwt2lMebOd8jsbT/xcZ/Ge
         dli4LpMW90g44VSPL63NugP6JUFdF9h+OXe46zY27E5Ix4uel6zScXCk/Zrfce73mEtA
         7iiABYMYkF7h+NorchPh0rjCFF9Vh0H8GFmSWWIL8g5VPew2OTk6ViQNclwJsF7l1okw
         1vnsTebe7Q9BtcpmbiDSM8U7IwuS7+97+6HyTLyjLtQl80gm8KsmQorbPG4/jLOErEni
         kk8GUZiEqSA7NoniZjGpLfd3gt+YMi6R7ETESPXBpj63g3AYi3meU0+8YWApBZNLKalD
         2t4A==
X-Forwarded-Encrypted: i=1; AJvYcCVPcd8oe5dPETASKjJpZUad/yHwyW/0Yzyj3etnRtAc6k7RIDM18uGyc+svQbSMPdXCGHgaDZqRmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XrtXOiih67LX8+I0Z7wK6oVrT2XhAXkm57mWMVt+qB4pzZlq
	iKCOfOicvTyVRfjhTSpOmvlglUNhYTc6R5ipCcpPuEa2bQzpmYvxKWMZbL/fFtjLR7ZC8iVfnMH
	fWmlyInS+Y4LRJdJEHC6JwJ+8bGSJBb0TboNm8pfIkrHD9Z/n8petKucaTqfSmg==
X-Gm-Gg: ASbGnctdjs9diAkc3QHdUka7ayRmDrRPjgclH/gV+Hm0NPiAByQqLOAq/q2oZWkOx4v
	qK61O5WvFxD0qKQJZMaYBnZHCLrOYVFtyMZw/XqnAEAktR+H1Q0hN7zIX+Lu60F9W4EuJyGqQPD
	6jpYwQS5n8l5GfZZ6dB+3edX2Vi8eXfk5PTG+Cm1zw348o4RNy1PKGDm63I8hXTKLu63fxfuLfI
	UNsFdlaRIquGfqTp/UVJ0ZdzV/NxVilMOU5844iI32zmzWXzwNWeR5icugsSvqsMzXWyWXrWFBX
	OhJiIF47eyN0jCclv56AkTYiQIwhPk4kvxg/Q8oknZHEndLJmahrzxpH9UxLt7WLV3DELhHIe17
	IMAHkgTP6g0YPvJetQAQTQlNCDaE99umgwnU=
X-Received: by 2002:a17:90b:2e50:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-3436acc10b1mr6325908a91.15.1762699092558;
        Sun, 09 Nov 2025 06:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsz33mCu2I9XufPajBf7LFsiT4u4peJwvXKj1MW+NqngdPeP21HWE8OBRYf1Aie7N1TK+YOA==
X-Received: by 2002:a17:90b:2e50:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-3436acc10b1mr6325873a91.15.1762699092004;
        Sun, 09 Nov 2025 06:38:12 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:11 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:14 +0530
Subject: [PATCH v17 01/12] power: reset: reboot-mode: Remove devres based
 allocations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=3273;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=tSD2yNZaJDc5m1jdDRoQ2dA6oSVGR8ZTHjS4GRBmNcg=;
 b=bUjyq9xpjS9KUiS6+Nw78zrsSxHqaWYFJL0jGHwwWaOkVhD0IIgjEAY5Z0HoEPo/CcR3Xz4oA
 IulwmmBv4T4A9e0Vrji+SnFgsZO+5ByFEtY5OaqNKYLzIpwTq8pESLl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: sqTpR72kIPJljn16ofy5KRXNi7Ppr60U
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=6910a755 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wx_w4_m59dWKJ5at3RkA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: sqTpR72kIPJljn16ofy5KRXNi7Ppr60U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX5VKWJWrEQV+l
 ZEU/5GuDP13FzbmrKMAKdIg/MA3fSgj9JhD771YmYGG0uJUCG5SlyEENqgxQlFaxuYYTBhelqO8
 dau+uCbZWJlpumjqgZsnrF0Qlkmu6DBmAAL6spEPZ+WiupRmisEb12a69TWQYOevzyU6KT8Uv+O
 ugHU5z7RDPjtR7b5p88ffxKLkpRpa8rpzL3t4YeslX4EnhQiUYI6KBgbnVTGCmhiT4vefqfxl/X
 UF4o60UQs3wHTZFRcvwgFUgVNebhccvebcoaoRhdLJsK/siwcODtdDpT5xl43nMojq1TX/noVaK
 TKd/Dbm1At/O6K9rjaW4LjOf5wVni9RDf7PSbaL5dcN6OuRNUsirI2+S7Jcv3RtGNYeGQ5g2nRk
 +WjHJOY5JxaBJPR8b3/h+485Xvoedw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

Devres APIs are intended for use in drivers, and they should be
avoided in shared subsystem code which is being used by multiple
drivers. Avoid using devres based allocations in the reboot-mode
subsystem and manually free the resources.

Replace devm_kzalloc with kzalloc and handle memory cleanup
explicitly.

Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..ac4223794083f36960b2bd37a601b7e1f1872de5 100644
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
@@ -71,6 +73,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 int reboot_mode_register(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
@@ -82,29 +85,27 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
 		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
+			pr_err("reboot mode %s without magic number\n", info->mode);
+			kfree(info);
 			continue;
 		}
 
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
-			goto error;
+			goto err_info;
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
-			goto error;
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
+			goto err_info;
 		}
 
 		list_add_tail(&info->list, &reboot->head);
@@ -115,9 +116,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	return 0;
 
+err_info:
+	kfree(info);
 error:
-	list_for_each_entry(info, &reboot->head, list)
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


