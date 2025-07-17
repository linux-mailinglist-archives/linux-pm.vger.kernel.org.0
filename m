Return-Path: <linux-pm+bounces-31003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53132B08D59
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BD75626E0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D8299AB3;
	Thu, 17 Jul 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Li7ofBKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828F291C26
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756476; cv=none; b=D0mKbt6XxQVqUF+7tSV/V+a5oq9011vNHkNjqaRjge4S+Q9kitlCo9amBaxJ21tHKAUrCq2ayKv65QEGnXYsnTYNxmYy+/uo//tX3g1WhzIokGX4tzqcyemiZFratRwpN+kTCFXCNhXkbfGbU/15mA7LDlAEif3KaDjqdiAe2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756476; c=relaxed/simple;
	bh=Ac0WjvV+M2yFP9Da/mh/o8GHODNrcW5YrR+v85Mz4Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7DlJQnyAXh65lY4EsFwYdwqlsbL9uu+OYq3z7uaUg9umg8Jn2UDlJLzBIYeDbJjwij2y+nkrBVOWJHLk2123/r7heTUTBqtg73KeAMZwNhKu3e5ImUKuOUmUB1WF8roOJSL+gxsQfiacsdVP3l0Pf31SNmrQSvvJj3SJ9YFA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Li7ofBKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBsJhE022444
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SiZpTfe8Zu+K6BMsKWciZIsGv+skYHmcAh4GOfMFdWc=; b=Li7ofBKinmY2cAVn
	79Bvy9YiXw96IOTZPfIrhChJkdb0NLe3/fgj73gL9n1PiAE8rgDez6onjPRem/Ir
	fG1CzI65mA7fXo+D53pLUsOvYxSvtm9OkB11r/zbyMyjZ3a/iO8bvCR1AiyjodqV
	0yvnY5m649TXi+94CiD9qs9aDlSoiVvxOVFMc6bDmaDdakcymcR8DEwX+2C0caqZ
	Y6ivNYOqD1aNrNDVBtHHYQE1ToqRe9SG7uV0dCHTD6ym4ZC4+DmoqQZ4gmFeuE4r
	pdId6oTHOopS2eF8yNFCUhA1JHUpu0CJWUbiNotTE0V8Vvnm5CEAUQffJbfLjSrS
	XV6I/g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7k54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:47:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so928995a91.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 05:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756472; x=1753361272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiZpTfe8Zu+K6BMsKWciZIsGv+skYHmcAh4GOfMFdWc=;
        b=AoyC8VE98egWEhXEkfqg4zLrPT26QB8SdKv8ju83JfQAJS6YnPw1xiIxi+zAvZiRq2
         zn+mvVx6BCEe+W741FLhmO83w6di0+woS5zTPpGuCgnr5jL4d4/fAlNPrpOsDvf+zE47
         byzvEYoohMDaXK1XCNWLcqdEdPMgKmD5/YNp+h7bng33PT/PEZSFoaAwX/A096fa0cLV
         b/LwJFampEVpjSvl7mBy/QCmRPF3ecjqnhjvICq/Dp1FNiNSHynUi5/kV0NFSjQidMvI
         SwxpkiSPxknob/2iojNSYiz5LLzNH46qaliXha0SGajGmkQUk/sly3FJ4UmipECEkpMv
         zrCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7jLGY5BkCLovWbfat1CrRrVyp8DvRUcFaqEnabQBgJ3JPXk4+QrPa2YOWZJDk2wWbcNqbRG/5fw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGfILh/O8ZtU1cadGMxYIwHO47bX0TmYap1GSqGMB9cpfMXN+
	QuJN/eCfw9oJWDvj46xtjt33p2Lf1oQ6s+CuSOzltZ2AzDfZ7vzL+wRbI/YrPqYNMDHDMuvie9R
	nSK4Onj4N5XtAB0zXHPEGwD9Nn6dPYB5DA/km3orkAT+yKeffRX4vWflzK8TuJQ==
X-Gm-Gg: ASbGnctkEa6NlDjOckjKlmlp2td7n/Lu6WA+DRvyoN8a/F8ulNoILdAGZEQ1SamAoG6
	KaiIcuCEPHSHQiCicCTFr7NPCL/tTKJmHuhoSZlmYnQJlWEV1yz6ut8F9iztCOzjBZI5M/OqnUr
	8jRKvZiYz2SN0dcY5bCZQb3JE4jkJXv5i6z/4ApcvHBOeq7uhhhNskyYBlknT5Xf8NYMH/49ip6
	LTeP1FAIKx0Vt3BRJkOBT+USwHL54WbmWNkk8XlhC/K82IuCMbJ5G3wiXlVyGyDDtk+p9bRWx90
	18A+GrNy6exstlnvTTlHhREqMC7G+CaVxdyGRWLa94gyhbXMWF3Fkmx3eksmzDzf9p3gXLyDVgb
	n
X-Received: by 2002:a17:90b:50ce:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-31c9f45b0abmr8446898a91.31.1752756472124;
        Thu, 17 Jul 2025 05:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeDXvff2phI+gdj5k/aZjVFSg5HoF5SSERKmlmox6bjKji8pYexr3zYbXI3CwHG6Qv0EEU5w==
X-Received: by 2002:a17:90b:50ce:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-31c9f45b0abmr8446852a91.31.1752756471656;
        Thu, 17 Jul 2025 05:47:51 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:47:51 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:47 +0530
Subject: [PATCH v11 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=4290;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ac0WjvV+M2yFP9Da/mh/o8GHODNrcW5YrR+v85Mz4Aw=;
 b=jQZGEPbbqcRPTYTNCkzogKxfIiutINDN+O/ZIaySmkSbWhNHqd/Y/564EWs4jG5AxSxgCntTq
 A4sgUiptrehBNUzt39OkoGp3QkKGGtncvx1v5my+muPAQH1Lc2Z+7j4
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfX27ss1i/ebz/y
 5ZPizeLl94MrBYcvKil5KO0utUuaoP8lpLYBxXqiAXYlpvxdFmiFs9fUCcXZD1JgsBp92s8t7a0
 xmRN/35iRYLLmIUZEkG3DAjqJvLJf238ItJi6EehiX8TDJuFCqz/we8AMgqXYPQkj9OE0BBshOc
 1U60ZWPv1OP34MN8FW55Rbuiui04wGm+JtIGlCrWtg1tSwhgpyiH51qZzARvdAQYjGZFf8sTv8z
 9INDwqIYVE+8b+1o28SGQSa8Wg4oPY/e4IGeywlwfiR9QJm1j+cfsD6dvaR+rAl8AAr8Y6YXUn8
 FIJZG7iIk0Yi7jVtSi1k46UPNEGIUWUu3OjjXJFnkcJZV61t6n3y+39csszibEBy+IoU1YWHvAV
 Reg9aUC7+jsfNx7zzHSMXkuK4icotPzCN3/RQ5DvJduLI1LEieCXZge3jhCrZiMfP3cpq83K
X-Proofpoint-GUID: vwQmOZj88OdhM-x961gNFtq3uAwH_5nn
X-Proofpoint-ORIG-GUID: vwQmOZj88OdhM-x961gNFtq3uAwH_5nn
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6878f0f9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=IcmTHOqSNbDvJ54L4SUA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170112

The reboot-mode driver does not have a strict requirement for
device-based registration. It primarily uses the device's of_node
to read mode-<cmd> properties and the device pointer for logging.

Remove the dependency on struct device and introduce support for
Device Tree (DT) node-based registration. This enables drivers
that are not associated with a struct device to leverage the
reboot-mode framework.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 29 +++++++++++++++++++----------
 include/linux/reboot-mode.h       |  2 +-
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..0269ec55106472cf2f2b12bd65704dd0114bf4a3 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,13 +3,17 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
 
 #define PREFIX "mode-"
 
@@ -65,33 +69,35 @@ static int reboot_mode_notify(struct notifier_block *this,
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
+ * @np: Pointer to device tree node
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int reboot_mode_register(struct reboot_mode_driver *reboot)
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
 {
 	struct mode_info *info;
 	struct property *prop;
-	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
 	int ret;
 
+	if (!np)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
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
 
@@ -102,8 +108,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
 			goto error;
 		}
 
@@ -130,11 +135,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
 		kfree_const(info->mode);
+		list_del(&info->list);
+		kfree(info);
+	}
 
 	return 0;
 }
@@ -162,7 +171,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot);
+	rc = reboot_mode_register(reboot, reboot->dev->of_node);
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..36f071f4b82e1fc255d8dd679a18e537655c3179 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -9,7 +9,7 @@ struct reboot_mode_driver {
 	struct notifier_block reboot_notifier;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


