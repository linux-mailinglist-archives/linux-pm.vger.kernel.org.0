Return-Path: <linux-pm+bounces-31434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D2B13071
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85E9177DEF
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7C22126E;
	Sun, 27 Jul 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pc3A8fbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AB21CC5B
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633514; cv=none; b=J3yOwLflC9mZBqN7X3lnn/MCvokAenE3YA1iND/D/zbvZ7yr8rBqBZj5Clzn9Ui9tI2ZmwxS99An3ehRAhW6Dhhr/c1InFGAJt/HWIzc2GEkeSl69+WXyKec4IIRZb/uhMxXVncBQpe1b3Gm/EU9VdZTtT7W1VjhlCtXcTaWh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633514; c=relaxed/simple;
	bh=FC7RrRfjKXNVyHBQzF6uwLhcss5N7idT7lbjBm/hwDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2uOS+7gvCWol2fux6r6j9x39NWVEZiYDOll7pYE+BrmsXhsHTwW8S0tdLY9z14AcI55wxStGa7J8K2JkNT6doWOIsilZeS2IoILPOFAq7D4UzhODKyu0P0RKfAomhBuF0QpNFLxTLePVFqNwF++b6iKhQXYrMVJWYbZtrTtLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pc3A8fbH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RFq4Lh017747
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v4YCBWmY0mp9H7MQ3j2gakQJBYTosZxb2APt1bK5h/Q=; b=Pc3A8fbHKs3Uzph6
	DOtrmF5OwSYALF4PY5i7D4F9VXczqAzOrGND4qpa31lWhSlECsdAM/Rv4UFEdQ0i
	PItIVzMOGcrEIvfVFmOaH6NMP1HobYfzXXQ1ND/NB3IBKJhSIlUqY6TA9APIg+Tt
	e1sTVP0biTCkzmhm7UJZ3sNscRVQP0mN9u4tZburAFKw1BFE7BUi7xcbw6c5A1VA
	RX8LUHXTMNCktcb+mBTF5LuLW/dF9nwiio3oRhv7tX98JxczkchN69iHw3NzOnQY
	ZN4w5vyjeIdcPP26WobDOofu4PNgdsS2iG+5STLfwXKwGW+iUlu86bPbW6Ca8HDK
	LnMiEQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85tbbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 16:25:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe984fe57so12533175ad.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Jul 2025 09:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633511; x=1754238311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4YCBWmY0mp9H7MQ3j2gakQJBYTosZxb2APt1bK5h/Q=;
        b=ToMKUAAfFtBhTjsAUQmpXrshBtOSXpilOOj9ov7DQjff4oXVFf/OvJ4M4oRdMqIerA
         b4nTkX6lrcmY2PgmZKEMPTpmHa4vKmiIxAQDFjZMkiQ7NoRH9ea9vjv0ywVNUMXEoQCT
         qBleFe8ccwassN15vjGikUpLjK2mxfxfcgAd+cl4doC5l5cMOKK9yYrv24T+F+XpFQ2f
         3xy2nTt7q27mj88KZRAbC2R1XPWP0cb3z9DLkZ6esfip3VfwTMR4suxTL6mPT7pURq4R
         rx9v/MuyVdhhJYEBrouRL/uPTIrKtCBLYyYiZrK0uQgG0cLJ4aX5x3dtqimysQC0NMlT
         VmTA==
X-Forwarded-Encrypted: i=1; AJvYcCUPGd93nODDeeZ9tFaAd6pIY92NZpWwGUIO9YAqbDNHeqrrX1V5iZdW5Q6Vg3gEtaFPL/6r5Lmmaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7i/TBk5HJ/SRkgTmf8rZvgyUBEnkKvuj+FSQ+q4eAfF7Y+Mc
	iCmH3n3zFR3bhal/FPgcq4dCNeMVPr5nCwFVmyto9niysuEzZy+3JMjgRhJag2JjOdeIByO/dnF
	EwB57p20kkzKLhwuxjx+YIy0UHmcYSHNrrTMvyk/CQYdPSmrWI1IAp3Y7Ks1K/A==
X-Gm-Gg: ASbGnctFIRqb72HziB7koqNkjD4ccWECGFVENNTd0y5oxpmCjUFoitaNrPr+pDetF+r
	S/lhP+TNNeqHxQJ7oFVTc1MAKSr5hB+nLMjFPP5lHV3/pQ996P6ZwHMr0jyJY5lY6OllkBizXjV
	bVzq0fKUSIm6eX1awjRA9ljpwk0xqnW7GAaZwMl9VWPcWgh+E0VzjjD5axa+dWJ3H7fYaGRHKSv
	2CVLRcG7ULI9CQL70jqKMVQeIQmxiiycrnaGZyAdqGDLLJ7+RccFlhF/0zkdNDUg6DENXJhMSUB
	krZmbC4qG0fZ8gdU0E2EwrYYaY6dmO4hKZLIYXRndVXsJZXtdIQ8JUO2u4Qo0PDpdbttDPf0oAp
	w
X-Received: by 2002:a17:902:ccc9:b0:240:2eb6:d5cc with SMTP id d9443c01a7336-2402eb6d9e9mr9977175ad.17.1753633511482;
        Sun, 27 Jul 2025 09:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQHJRnmueFVtjE5Xgx+LUDsaynix8FLVjXOCUqpUqvT52MAlWGQMEYT0tAC2uOxsMT2zpuQ==
X-Received: by 2002:a17:902:ccc9:b0:240:2eb6:d5cc with SMTP id d9443c01a7336-2402eb6d9e9mr9976695ad.17.1753633511036;
        Sun, 27 Jul 2025 09:25:11 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:10 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:44 +0530
Subject: [PATCH v13 01/10] power: reset: reboot-mode: Synchronize list
 traversal
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-1-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=3679;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FC7RrRfjKXNVyHBQzF6uwLhcss5N7idT7lbjBm/hwDg=;
 b=wuM7Ud9mvdBgYMygF1JESinqXl7pH9Sn1j9nV94LYy4tSZEq96eslDnylVV4vStbiMeqYy+l1
 Cs6ZBdqK3AwBOUismrxPOsG47QSiHQe0Arf9SH5ULtsQcLsU7g18Y+3
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NCBTYWx0ZWRfX3780dY7g8nm9
 qX7PzXVZ5HqCPbTMzf8LelClGlmE5aw57d6a6Z7MGYLRECUfd5fvkG1WqJS77x8SPd7d2nfHISP
 HCngBDPf6R3ZuJLiki9PgAnk09eDtfiPCa5nma22sB/EOAeVMVJoEOPpGe0cuYpZm1kb7XhmaIn
 56PBfbMj3LgP+iMo+mc5KsP5ejInzASpqZ6Gnh3Mo3e+kbsBxhatKO4nOTy4XCDIbK9G5sSlUbl
 MvY1nVyZX8dsSZOH1xIp8+OtULDFEEorJVs58tClxymNY4AXl4Cuh1IfktpF8BTfAl1TFpPmDRh
 sbaFE265gdN+za3WFpLnVYxMJKhBpQQ3OSPxao6i839rABDB0oQ1Kb8iEaRG5ElhBVqokYvuq8y
 PHOHXGOL/YiyZpho71qCTNjFpe+hk+Y4SKXZUNUsBcRk9ecFkMt6Z1Z8T4DFmIvY2abu/g/A
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688652e8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=iWTyA_h5fkyOTIp6uasA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 6tU93m0F_1RhG_aXKwV3yX36wx5yRlU7
X-Proofpoint-GUID: 6tU93m0F_1RhG_aXKwV3yX36wx5yRlU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270144

List traversals must be synchronized to prevent race conditions
and data corruption. The reboot-mode list is not protected by a
lock currently, which can lead to concurrent access and race.

Introduce a mutex lock to guard all operations on the reboot-mode
list and ensure thread-safe access. The change prevents unsafe
concurrent access on reboot-mode list.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 24 ++++++++++++++++++++----
 include/linux/reboot-mode.h       |  4 ++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..42bb99128ed3846d4bff62416dc31135ddeaeb90 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -29,9 +29,14 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	if (!cmd)
 		cmd = normal;
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd))
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		if (!strcmp(info->mode, cmd)) {
+			mutex_unlock(&reboot->rb_lock);
 			return info->magic;
+		}
+	}
+	mutex_unlock(&reboot->rb_lock);
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
@@ -41,9 +46,14 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 	strreplace(cmd_, ',', '-');
 	strreplace(cmd_, '/', '-');
 
-	list_for_each_entry(info, &reboot->head, list)
-		if (!strcmp(info->mode, cmd_))
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		if (!strcmp(info->mode, cmd_)) {
+			mutex_unlock(&reboot->rb_lock);
 			return info->magic;
+		}
+	}
+	mutex_unlock(&reboot->rb_lock);
 
 	return 0;
 }
@@ -77,7 +87,9 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
+	mutex_init(&reboot->rb_lock);
 
+	mutex_lock(&reboot->rb_lock);
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
@@ -113,12 +125,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
+	mutex_unlock(&reboot->rb_lock);
 	return 0;
 
 error:
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
 
+	mutex_unlock(&reboot->rb_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -133,8 +147,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
+	mutex_lock(&reboot->rb_lock);
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
+	mutex_unlock(&reboot->rb_lock);
 
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


