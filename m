Return-Path: <linux-pm+bounces-39955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8ECDEECF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F883005193
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AF299949;
	Fri, 26 Dec 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kidUAE2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Co99KKmm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152C28313D
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766775407; cv=none; b=eN9YVeogQCaoGkQDEqibLdFywUw/dnaa+gu6JaxGAC2WbeQ8PYv9tFSNG8UGSiVTKFcc7/CAZ9d88sFjEroyHkDm2Umt14DkF2cR0NP19XSsWaSFjrOyPeJR9WlE/1BhJgeJH+NmPr+h/TDFebvTEGQAp32CIukxBK4zskxrHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766775407; c=relaxed/simple;
	bh=wPXe6SW3yPWML0XHCTsiC3JvUhngTfoBSWSCPop8FdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLHRVRlsN2Y/DiTuaLfvnkQKNoEdaI7CyJzGgsBaurLHZmML4VF2aZKHfuj7gQhH0jKKcS5C8TeDxgL2V3xvN+s54t2YLyKgnAyzHsbBnMSEFn70TDAu+TtgCALqz0orXZ6Pteu8OqpRRu3IChriInKAkVtRr5sXCtLbJSSBXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kidUAE2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Co99KKmm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BQHg6X31694872
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 18:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zJ4utG9reyisAFKwQHOylIbjjaGeNr2J4MMS4CXniCY=; b=kidUAE2wiBwi0LFr
	UbegkFSfM5QkDcbBQOfD1U1ufU6eNNKrTnxydFyFBlR/LvTShGsAjux4GymGnxqs
	VdaK+gaKafa4j0hP6jgy+98Nc9QFpmbXthuvmTQZIc3vNUiLmK3Xcx65kJTFuK1Y
	sidB2p/V1yoiIF5aon3j7fwkFmBzwkM/BHBJv9X99Cs7y+mMtR/RZ12c0TsTbMc3
	UW7EWAGOjAN3pYtXUW4f+V0tjpLJXUNt3CmwyHi6npJUKMfdr1LspojHzcNFN7wN
	9HghqBX9LyccMxqA3wNZRuo+wv8+nGByY6A2HfNV+QhXp75JQRFoRiUPGYEcOsTG
	Z3FLqA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b9bgmaan7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 18:56:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7fc82eff4adso7374966b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766775405; x=1767380205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJ4utG9reyisAFKwQHOylIbjjaGeNr2J4MMS4CXniCY=;
        b=Co99KKmmlv76j3DGRPDfhCioSwDIqR4lbF/VtVD90XGcM5BExjuGysKdPAhptI26ZH
         MHhBLdQQaEjdif8wN6R3XTFT0UIla3nEMGP0pavRxMI2XRKc/lzjUOREWEFWUsJgaPIr
         +/NQDvUtpk35FdwGAulXoRgS6BrtBwwrn4MsP8kiTgv5HDDanJBRn03y7H0c06bMErto
         m8d5eyeLCCLuGt5awYXThHd9h8MPfdTnxBbkxRLZqTFn8/RWjKZl+iNi9KHXursGebaw
         PwvCVUIzNhG1xqK4iP/QzasqlpVzREDlDl2d2AmEMDBMkVeOHdFQ1WATvTA0uWzHExVE
         4H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766775405; x=1767380205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zJ4utG9reyisAFKwQHOylIbjjaGeNr2J4MMS4CXniCY=;
        b=FuSkNlXQdoFDkwhkDmrQTu4c+9uDpQw/e2h/pjX1W9Yr34h3bAMG0s/HEtS9vrqIrE
         T4pBinHpKsm9/01/Kw5yJDIq6TR/NtRK7vFmouuuwozXLHCFsuudYgXCWeXCofVJhSjH
         5oFzHUw/NN0VlYSRs2aDT1WIyraQ1dPqzpYdRbhBAEg6Xqy3AM9qmZY1upx+wo61+tCx
         Y4b/pWV0DWIoXnzH1uo0qu/g6aJpobvx7SByWQP5jtHCevE1UG+A1060U4/syGhMOITK
         iRhoQKwDxAWMWhuTRTTfd+WD8IX+ui/x7fk9+o5pJMlqzFQdw2y+prvbYCSix/phySQq
         12YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1GWaTxLQQofkWn3v6AaTceO90aYHoDqAe+vKMmCfh6bIIGhA41OpMA99LIAPP2FcWRm7HwsuCdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTCceh/y+4zBArK8VCEQRSDQuh1Ib3oD1BI6/ATI/Nkvl5hQ3
	ZjxDnYNlIMpU1Mo6WWNnEtqNnS2U1b7Ski/ccPiJ0ECRO9Dm6HC6joVN2BJwvUNNj4mxDfXG4Pn
	44xYDqWPhQdpkE/mUBbg6ngX2ChS4/Whr8NljLguw4xGTmCaHIWoAKahXeZ9jEQ==
X-Gm-Gg: AY/fxX5dMnDsoGbPAHIevP7tYJ97I5+hPTd+nZyWJGCrU6IEGDpXo3jFvn0X0TemACJ
	vg2SD/KhVZ7K9pF+sKXMu3EqN0F3wiBQY58qvc/oxxMyHE1Sqd55NcfRwk0hM1PaZV3HSXkB53m
	7pGumiGbL6uW2s/jYud+81jdYYetnhbCGmo3VL6XdXEmgq4bivacfO/vWfS6mJ353E0m6Yoykxw
	y4ET0ZnUFlW4bqnKf1XSs3O1++4GX7IpupvCHw2OOcmKMuJsZFZWKC9Axd7kARLI2dKLw9bf6GI
	IKjo28hab1AKgVpz5JnnJbcmoYy3CYIoVk59qpxsvm5eL4G2fm6lROc8o9RyqmtXsCVoJgKjsu6
	AuTxnBuf/nkPaVnwZt9FIRty5iQTS8Q/ZHWFhF8UqPHwUQg==
X-Received: by 2002:a05:6a00:451c:b0:7e8:3fcb:bc46 with SMTP id d2e1a72fcca58-7ff54c01878mr23601824b3a.27.1766775404835;
        Fri, 26 Dec 2025 10:56:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5LYf5gwF5Mw0rW6Bn0JmyCVj1YI+U4fm5OEfHUcNrtUU/4RUIo0u+RAgSisIwlBGpKyyHLg==
X-Received: by 2002:a05:6a00:451c:b0:7e8:3fcb:bc46 with SMTP id d2e1a72fcca58-7ff54c01878mr23601806b3a.27.1766775404326;
        Fri, 26 Dec 2025 10:56:44 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e88cd71sm22638187b3a.64.2025.12.26.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 10:56:44 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sat, 27 Dec 2025 00:26:34 +0530
Subject: [PATCH v22 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19@oss.qualcomm.com>
References: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
In-Reply-To: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766775395; l=6599;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=wPXe6SW3yPWML0XHCTsiC3JvUhngTfoBSWSCPop8FdM=;
 b=zQNhHrh6qDreTMfLnbSSuMfTnxTaPWa6u0uL6c1Ld3NUDWM/Th0uvKnrtp+iGX8On2hpd6fAZ
 nSE1e5cqdxWA0AT+enICXrvwj6384uLTTyazYp/J+2XjnOwrAZDp+bM
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: IYuu3UwDcFYcfngfM9qAABmP3YsZ4g2W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDE3NyBTYWx0ZWRfX18IWuVlA5AEK
 pAp8Ga1GgEAeeR856G9eI+VxQucZ+g6rtn6OcxiqeByBR8EwPRbmISXNbK828Op/HvBnSjh+kBe
 6lK7HRl16a+PsIhPsuCI2TNwBHJcZg2t2Oag6hoFzy2g7VSBV6evt+toEiHIdjOsnVjIW6YqDgY
 6Qq2PQkYUXvgIdY6EiSlaSarbUCa4wyDgz2KYR+Q3Ex+Pgzf7bD+VZlzk0qM+rVi4xYGHn8aove
 eiGy9wknmHTb0kbSa4TqDYpr9Dew97CpuGIEHTBi9FVH+bIw+iZo6MR0ReidnxbzbFBPDH18GpQ
 uBgZ/SZ/Gtb5SgeXDJGnkCMAiftJOckj/LVW5/HnGjIorYN66FrWmgPpKrG5KYZmR+vbi2/56a7
 eNN0F+odM7FzhV5A73gU+2jGp3yUgVrXTeUEz58CmtYuS+Ug7lYviYYxySLtynJbNeZ5K/YWJi6
 dFcXmP7g5p9XRAuvMXQ==
X-Authority-Analysis: v=2.4 cv=Mbdhep/f c=1 sm=1 tr=0 ts=694eda6d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=PEngcyRGguBFGVBpi14A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: IYuu3UwDcFYcfngfM9qAABmP3YsZ4g2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_05,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260177

Currently, there is no standardized mechanism for userspace to discover
which reboot-modes are supported on a given platform. This limitation
forces tools and scripts to rely on hardcoded assumptions about the
supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a sysfs
interface to show the available reboot mode arguments to userspace. Use
the driver_name field of the struct reboot_mode_driver to create the
device.  For device-based drivers, configure the device driver name as
driver_name.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported reboot
modes arguments provided by the driver, enabling userspace to query the
list of arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 139 +++++++++++++++++++++++++++++++++++++-
 include/linux/reboot-mode.h       |   1 +
 2 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..96d0201697a539c6d048dac021db97e4e3063366 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -6,10 +6,12 @@
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
 
@@ -19,6 +21,42 @@ struct mode_info {
 	struct list_head list;
 };
 
+struct sysfs_data {
+	const char *mode;
+	struct list_head list;
+};
+
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sysfs_data *sysfs_info;
+	struct list_head *head;
+	ssize_t size = 0;
+
+	head = dev_get_drvdata(dev);
+	if (!head)
+		return -ENODATA;
+
+	list_for_each_entry(sysfs_info, head, list)
+		size += sysfs_emit_at(buf, size, "%s ", sysfs_info->mode);
+
+	if (!size)
+		return -ENODATA;
+
+	return size + sysfs_emit_at(buf, size - 1, "\n");
+}
+static DEVICE_ATTR_RO(reboot_modes);
+
+static struct attribute *reboot_mode_attrs[] = {
+	&dev_attr_reboot_modes.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(reboot_mode);
+
+static const struct class reboot_mode_class = {
+	.name = "reboot-mode",
+	.dev_groups = reboot_mode_groups,
+};
+
 static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
@@ -62,6 +100,61 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
+{
+	struct sysfs_data *sysfs_info;
+	struct sysfs_data *next;
+	struct list_head *head;
+	struct mode_info *info;
+	int ret;
+
+	head = kzalloc(sizeof(*head), GFP_KERNEL);
+	if (!head) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	INIT_LIST_HEAD(head);
+
+	list_for_each_entry(info, &reboot->head, list) {
+		sysfs_info = kzalloc(sizeof(*sysfs_info), GFP_KERNEL);
+		if (!sysfs_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		sysfs_info->mode = kstrdup_const(info->mode, GFP_KERNEL);
+		if (!sysfs_info->mode) {
+			kfree(sysfs_info);
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		list_add_tail(&sysfs_info->list, head);
+	}
+
+	reboot->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
+						   (void *)head, reboot->dev->driver->name);
+
+	if (IS_ERR(reboot->reboot_mode_device)) {
+		ret = PTR_ERR(reboot->reboot_mode_device);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	list_for_each_entry_safe(sysfs_info, next, head, list) {
+		list_del(&sysfs_info->list);
+		kfree_const(sysfs_info->mode);
+		kfree(sysfs_info);
+	}
+
+	kfree(head);
+	reboot->reboot_mode_device = NULL;
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -113,16 +206,39 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
+	ret = reboot_mode_create_device(reboot);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
-
+	reboot_mode_unregister(reboot);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
 
+static inline void reboot_mode_unregister_device(struct reboot_mode_driver *reboot)
+{
+	struct sysfs_data *sysfs_info;
+	struct sysfs_data *next;
+	struct list_head *head;
+
+	head = dev_get_drvdata(reboot->reboot_mode_device);
+	device_unregister(reboot->reboot_mode_device);
+	reboot->reboot_mode_device = NULL;
+
+	if (head) {
+		list_for_each_entry_safe(sysfs_info, next, head, list) {
+			list_del(&sysfs_info->list);
+			kfree_const(sysfs_info->mode);
+			kfree(sysfs_info);
+		}
+	}
+
+	kfree(head);
+}
+
 /**
  * reboot_mode_unregister - unregister a reboot mode driver
  * @reboot: reboot mode driver
@@ -131,7 +247,11 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
 
+	if (!reboot->reboot_mode_device)
+		return -ENODEV;
+
 	unregister_reboot_notifier(&reboot->reboot_notifier);
+	reboot_mode_unregister_device(reboot);
 
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
@@ -199,6 +319,19 @@ void devm_reboot_mode_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
 
+static int __init reboot_mode_init(void)
+{
+	return class_register(&reboot_mode_class);
+}
+
+static void __exit reboot_mode_exit(void)
+{
+	class_unregister(&reboot_mode_class);
+}
+
+subsys_initcall(reboot_mode_init);
+module_exit(reboot_mode_exit);
+
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_DESCRIPTION("System reboot mode core library");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b56783c32068096325f92445b9530d1856c4826c 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -5,6 +5,7 @@
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	struct device *reboot_mode_device;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
 };

-- 
2.34.1


