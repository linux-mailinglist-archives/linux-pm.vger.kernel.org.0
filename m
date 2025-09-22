Return-Path: <linux-pm+bounces-35156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EDDB91702
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66172A2EE4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4530E825;
	Mon, 22 Sep 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYGtS06H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E730DD37
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548444; cv=none; b=eTQxkGfsWJRtuDkJ6HG8R1m22jusHcC/J2RB+7R+JSPyhiWAk4FIuqVumJ8TS1kSrVt7aZ/JcHLu49AUP8RakVDyCbYRbSzqNLuwDH49YXSedZEFLOsQVUioBV3LQDVHfFso1RSTIQQC0nUnJr20dxaehm0k7X43dQWc0mjn6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548444; c=relaxed/simple;
	bh=+LF5Rl/5f5znpMQv1GLZ4NG0dpObtQwZ7SckbxZ5OJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6dFRa3u0lG9KGsxUzTbrbXiSVyyGmi0ExFUrVG/NGtrmyeF7UdSwKNG8wlJkOy8dwirAjg/FSYhTYYlboA260OzOscHr3UcI3B9oHEpuuPxoZXhGgBhIdq6sRKrKiZJPm9DNRu92eSOUROP5h2cf/99btkKm8hvsajmhAncCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYGtS06H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8w3P0031200
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wck1RFL3Etc5iANJFBisnl6A9QEEqYSWtMuEcnVHG7E=; b=NYGtS06HtujpjOy7
	EaoMP5NEqsjM5+zsN1ce45OXw/3Z9TlNtgIumlgKxHX//KFHHzHW+xmQr28/ArdH
	0Whc8vUWcy0pgIrlBvaqAsDmfJfyv7WciT6wvZeROXDrRCyEr8BpIzr7tm4PRsGy
	+7S9JnKlXrX68Y5kTbKezzUPPCoDQJh9cHAUTIrX+fdDAfZ8RRD379r8TVhkknKD
	aGpDMz1l9xnB6/sKJa6gFskwBkXQaKVAKbjBBasf+CizCXLByRl+tUcFAvfLX2pA
	TlYTDfdaY8+NFfq2nNxMzjosgWykffDR3DrQIPYRA8iembPFe4H1EkHlK7Pv7xvO
	n/T50A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cwgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:40:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d21fddb85so77782315ad.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548440; x=1759153240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wck1RFL3Etc5iANJFBisnl6A9QEEqYSWtMuEcnVHG7E=;
        b=ledQIDDoxXOSbAUpkhZwBwO4E50sFMlJ2M8MJOy517Hme1yZWo/EwLopz+Z+v7M9Ie
         YqqwwvCSrXOb6Kfmqr64DA4+Eu+DW2VzUTEdhyP9pm6/ROyymWMxG4YWn4zxlc5UiBGV
         9X+fzZ6l055ZwujM8GrICk4qrQM19X1RTraw24ASqTuJgUZGNcqenS9JtcBYQZDti8o5
         T3G9U+UBLKVKCCVnuN4rmjj2EbIhuCbPGGhooyOJ0AeBBlz0T+/qmmbuG9mWPBCa/T5O
         gVymqr5Johpg3xXxD4aUO5qJjJfFuIpsSwFj1GkWpoOHRHRFd0QGCJxpaZx0Yx/mIaX/
         nVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd/xZbH8lt5luYoXQMGnYPZUrZa/rnK7FKE5oxo26tbhSgE41XXZI6HrM6PiuRe4tXW1pHqhBJ6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvtwFZA+6cBIEwZs4vRLAA7/U80O4dbuIyErXsg0DV3NGaDB1
	XGNPwQ3cRfzFa5NwLePCE3J4r6qGFPtvXGHezetLTU2upijER2hkUvUL+ShrmiC3KjivbwSy3mn
	RsMsFhw8QrcPCpviA/9tq0Kkxq5mCGkE4cdB8tsXqKy/k6EbocSAe/8wK164bwA==
X-Gm-Gg: ASbGncvDoeXpgUtC1kgN/hmruxtVq8jxPi2cMqmEjfaW3SU8jufTubYkCSqveIT3Xas
	j+wp/e+0FoXsqXsg8NFuUZyiTKCLvbUwi+LG+8aPzS7U3+ky/92R3bN4X+cr/J7j36+TAhUCmLL
	9PdM/RajZ5J/LzZAHrOWkd71PIWumba2QVKWc6eebW3SSG4v9sTHO3yyiOmiwOVyfGvuzxPBZ9T
	EMEUm27uJ2sYxcqvyb16uBIWxUwfOyE5Zcq/6y3YuPdUOOswkgQehU3LriYoqIGkAiefeXxPlGj
	9gLaZKqS3+8FDZk9H6HTBq0IjVE/ngl9qC93pM7rbxYfBlpSrRfX8We/HAYyRiWs8XAWgGJ9Gwc
	E
X-Received: by 2002:a17:903:2342:b0:265:982a:d450 with SMTP id d9443c01a7336-269ba533c6cmr153441535ad.40.1758548440176;
        Mon, 22 Sep 2025 06:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo2/a4BVdjp6tjYR2Y07Siikp43uvotxG3p+AwbYTvOOPwZqz5VaSP3wBnmdNsJoZXYNxiFg==
X-Received: by 2002:a17:903:2342:b0:265:982a:d450 with SMTP id d9443c01a7336-269ba533c6cmr153440945ad.40.1758548439664;
        Mon, 22 Sep 2025 06:40:39 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:40:39 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:11 +0530
Subject: [PATCH v15 01/14] power: reset: reboot-mode: Synchronize list
 traversal
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-1-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=5404;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=+LF5Rl/5f5znpMQv1GLZ4NG0dpObtQwZ7SckbxZ5OJg=;
 b=yzvvk3xOQzGRIfbypo337GvXrt2u9sEAEj3aA6MIS0LHEOylzx77NGaQMiaatRSoiCZG1XFdY
 RBTwjziAxJgBmHAO5r5GKKjyxKj4zbZtbDfuYZM8V2wAKDMIVJwAOq8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX3SwS8H0ERrCH
 QKcjXoaf4WGXelZFPZ676JN6RMWayMM4GmIt/Zv0o/xLgzdoYVxR0KVf/y8o+Nm4TK6lZSQjvwS
 LYQfs/1zeAhyoAnNr0EBovqVcHLtXErA3mpchbKgCNJBr67rQiEl2EydIdTYrIsMev2zWNbxsIE
 vKp4hRHSOEdeQG/2lUad13RqHl7lMPHPzd9NKFQuNp+2QAOvVBgkiiIYi+nIRpXXTcMVjuF7w2D
 uHvIkq65agACpX2pzCu/gJy85Ba2x+V1t7TKlnW9avoDg7IEoyLY5s5My56WN9sgCWetbJGyV+x
 qvvA5tzkGk7152ChPTJHuLEil5Gl7yPzEwX06ls7skC9Xs6S7d/xngy/MGRzywwCAb8XzUZ0uVH
 hN+zYUgE
X-Proofpoint-GUID: wWtFp0eOJ19hksQ8iWoXtsPZUKsOC7DV
X-Proofpoint-ORIG-GUID: wWtFp0eOJ19hksQ8iWoXtsPZUKsOC7DV
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d151d9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gP18aZtcJwKeVuiPoooA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

List traversals must be synchronized to prevent race conditions
and data corruption. The reboot-mode list is not protected by a
lock currently, which can lead to concurrent access and race.

Introduce a mutex lock to guard all operations on the reboot-mode
list and ensure thread-safe access. The change prevents unsafe
concurrent access on reboot-mode list.

Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
Fixes: ca3d2ea52314 ("power: reset: reboot-mode: better compatibility with DT (replace ' ,/')")

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 96 +++++++++++++++++++++------------------
 include/linux/reboot-mode.h       |  4 ++
 2 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..8fc3e14638ea757c8dc3808c240ff569cbd74786 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -29,9 +29,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	if (!cmd)
 		cmd = normal;
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd))
-			return info->magic;
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			if (!strcmp(info->mode, cmd))
+				return info->magic;
+	}
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
@@ -41,9 +43,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	strreplace(cmd_, ',', '-');
 	strreplace(cmd_, '/', '-');
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd_))
-			return info->magic;
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			if (!strcmp(info->mode, cmd_))
+				return info->magic;
+	}
 
 	return 0;
 }
@@ -78,46 +82,50 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
-	for_each_property_of_node(np, prop) {
-		if (strncmp(prop->name, PREFIX, len))
-			continue;
-
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
-		if (!info) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
-			continue;
-		}
-
-		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
-		if (!info->mode) {
-			ret =  -ENOMEM;
-			goto error;
-		} else if (info->mode[0] == '\0') {
-			kfree_const(info->mode);
-			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
-			goto error;
+	mutex_init(&reboot->rb_lock);
+
+	scoped_guard(mutex, &reboot->rb_lock) {
+		for_each_property_of_node(np, prop) {
+			if (strncmp(prop->name, PREFIX, len))
+				continue;
+
+			info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+			if (!info) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			if (of_property_read_u32(np, prop->name, &info->magic)) {
+				dev_err(reboot->dev, "reboot mode %s without magic number\n",
+					info->mode);
+				devm_kfree(reboot->dev, info);
+				continue;
+			}
+
+			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+			if (!info->mode) {
+				ret =  -ENOMEM;
+				goto error;
+			} else if (info->mode[0] == '\0') {
+				kfree_const(info->mode);
+				ret = -EINVAL;
+				dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
+					prop->name);
+				goto error;
+			}
+
+			list_add_tail(&info->list, &reboot->head);
 		}
 
-		list_add_tail(&info->list, &reboot->head);
-	}
-
-	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
-	register_reboot_notifier(&reboot->reboot_notifier);
+		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+		register_reboot_notifier(&reboot->reboot_notifier);
 
-	return 0;
+		return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
+		list_for_each_entry(info, &reboot->head, list)
+			kfree_const(info->mode);
+	}
 
 	return ret;
 }
@@ -133,8 +141,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			kfree_const(info->mode);
+	}
 
 	return 0;
 }
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b73f80708197677db8dc2e43affc519782b7146e 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,11 +2,15 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/mutex.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
+	/*Protects access to reboot mode list*/
+	struct mutex rb_lock;
 };
 
 int reboot_mode_register(struct reboot_mode_driver *reboot);

-- 
2.34.1


