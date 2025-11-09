Return-Path: <linux-pm+bounces-37684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2BC440A6
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D854188D19E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533A2FF652;
	Sun,  9 Nov 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/frQ9Ff";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hgFRdL8P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110B2FE59A
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699132; cv=none; b=NHzIM2ihnTT26fSEqxuqJ0F0rUVV1MmYt+JKWyYhQgU55E74rKcMiCX/9ZIYEj9HNAFnAb9Wbxut+i5XMNzjZHQvexzvtB5Z9jn/gCEEqCpumN8G1q/SnPl3uwUe0X1L5ebLOJOvKRK6YUDbqqog9GosAeltnM0CsVo5EaGpwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699132; c=relaxed/simple;
	bh=p8VTlQ3pXarRYayw8UBrYcTj+4OjWYYKSpMSZeU0bPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBkgAlhmEgX3gobZbm8vmPJvDBQROBu7gPLbKsRIUiLmxA1ZVk+a8KLwU66oOK07FLvM9787Zaw6kxNWxbE2eYi/Xd/GGdX8IYIASfXkhBDt5ncWSDgG/RT2Btb0kmqfrM9X8KG86bitVJ6kYmyC6QWE27Icyax85CaH+8hxWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/frQ9Ff; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hgFRdL8P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A97ZdFK4122918
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PHiUGzt7WA5d+ZZv2cAEdOLPNuf+lkNI7THaM5BmfBE=; b=Z/frQ9Ff9WvMicSf
	jXePQiSoQ2DCGdI57w/z4ylqCylDODHu4P11/CPUpUTBVhxa6lqXX24xUWKEVNei
	K28GJrz+2qUR4jSnU81xzsyG8e4ey3To1iSlmFaU7sm/p2pP7OvPx2Le9QYB4WkS
	g7O9mdU0ZY+W6FsN19wOfeD/ylwHROcMZPsXTGluKMA1dExpOw7dtyLpqDj3hdr1
	BfR/F6FxZxnTWQ9xQhVF3x/DdZvqVUsFXDPprIC2voHF5/aPTbHaqIvSKdYi2a4w
	8ViGj/xyE+eyU4bzexf/YfLdClCKkLAaNzK6mJq2yRET2pBzKbeHJ4uYPW7KQ3R2
	UKLBcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a12ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:38:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3436d53e990so1051124a91.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699128; x=1763303928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHiUGzt7WA5d+ZZv2cAEdOLPNuf+lkNI7THaM5BmfBE=;
        b=hgFRdL8PPfoZHEanfw7qP1yLBaaLKopfMnV9o4NmKWCQQ7msoDomIgY6Y31XLpwEuc
         2QgQari+Z5TEtVNJ9SBIIPhJbLb22KZ+qDWQhM8rELC7BIDrA4yClLzVQnVGntNboOF2
         Ex7GduGZuV3DowEMBuLhaOjh1obvtY627ryTPy35WsPVNsN83Fb19JCJA5MAhnlUOUa4
         5WE/uEouCArrB9jb6TMvy14Y7CkdSCpHdtxaUM7qwVijuJ6XR5Bvp26tqIWw26PC39OJ
         n3uNl1PsvcQ51MO05gzn8XzMgABmYMUsHZuNJhZR2+7OxWTYCx+DRvc+0c4/96YUjE0T
         /7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699128; x=1763303928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHiUGzt7WA5d+ZZv2cAEdOLPNuf+lkNI7THaM5BmfBE=;
        b=mZsgIiOGNKVcnaqIOgLCTquMGVqepRdGcPH2BUNK2qoEgi2IaTdHEfVK8fhBDFYsPf
         V87+pJLQDFDy9IEFARMexo88EVG7hMlsMvHQMuOxWjnv/E27/+REFHM2hYbDJPziyHUp
         SlvKbEuucmXII45JPDwOtcSHfGNgfT6A8w7rceKBZru/5tq5AnGTirJ6Lf/TSfj36MQi
         5A8PEsoRRrYJZe3v5x70QtiIOwb/Qml/GljCa6h7KQOAuOISgRjm9Xq85hXnY3Gt6HCN
         XkcZe2L9I+YT9C00P8rXkBH82R535tvOYrpxPBeZy0d1HPUVCby1HK0qMeqQL6QOHNnA
         uy3A==
X-Forwarded-Encrypted: i=1; AJvYcCWgNKdn7iV+/vFizFQ+ubOy5LwCZiJwtsDkb7lK6ek1b/oJFGtSVk8zmt8bdhIkowVs4LJpIJqkNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EatI+L7ekxXqlu4fjmpYjKHgxkYdlWygRHNg5OBKXmaI29oB
	JdqwtpubQp84XS1qeTOQTwBZzeZz1PgGf6UEwWVCyhRpQIUdAnT7tigsUEju5csi0XxwP+KUptp
	EHJi7lizP26EjRwIpgR81mtKVdYKhbfoNfoSfqGeKlXX+9fvLzoY6uC/M08IuLV6vMrqVhg==
X-Gm-Gg: ASbGnct59L/wZ20GlJGDKmRQxVttBZR1UEUPl25+FyZ2WusxSaoLvVJUPzGhO5bBG3y
	6myK39YYE6PmKHdgIVRr1FPoPe8chP7bnskjp8X8WdXOTNBgQLpDvzeMGQDqQmHItDO4e2XBX9r
	96Z5kEwrpl3LVqjQpY5RwvX0h5XLq7iXwRFJJo36D+DvHKH/NovxVn7jjVlZwvGjc4Q7VNs4u/m
	pMxKYcDj/1rShHBLeewFfO6QigCNlBSmo4CsnZrhB8ag/QOpgK7hJsTatvcE678cs+6vGw2+Bx8
	o4wJPOJReTCPJURATGqAQMrE7Cv7f7G4m4j5x3J7Owu3H1n2525jpDsJlLcAwu2V8URbcTW/Ubo
	FQS35GrcSaIr2/UIvnYcAsNxv+AaDqH/qwiA=
X-Received: by 2002:a17:90a:bf11:b0:343:7714:4ca6 with SMTP id 98e67ed59e1d1-34377144d90mr3756506a91.22.1762699127684;
        Sun, 09 Nov 2025 06:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJi8IG6JcT7AZMHFUMvIpgZqX/jl5jfBcQHPdOcQ8sjNa1J3m8dUnVgXFrv/h62wi7ogujmw==
X-Received: by 2002:a17:90a:bf11:b0:343:7714:4ca6 with SMTP id 98e67ed59e1d1-34377144d90mr3756460a91.22.1762699127112;
        Sun, 09 Nov 2025 06:38:47 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:46 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:18 +0530
Subject: [PATCH v17 05/12] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=5178;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=p8VTlQ3pXarRYayw8UBrYcTj+4OjWYYKSpMSZeU0bPM=;
 b=MD9m7lTEeVEibrUjikce7zPcaS1semLkXOkrguR66wGJvIqOv+EHyzaYktJlvdV2jDw8VWpxB
 tIqnoN5SuPkBCmyCv5QcKTnCU5JaIMN/Q1g3pDkebYFGBmrGkIioukZ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=6910a779 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ogmrOWMnV0kDla0zgWoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX0aK3qQQydy1z
 6owqh9nw3gf61+eW9Uuj3u++eP55vWqRI5FGPx0MfzUZ0608BNga+SnnNixdOEcxnfW+YiM7Ixl
 2zmYt3yMkMWhGLaBhK+G70slVgugeRSmDBWVkEUrPYnDczUNyW+tiUqSMKZX5k+wg6O0mE0Jf5O
 Ns1sdYBEvgWBmPQtbyLrNz9MX6HVbGEH1qmmNrogGPtiVU5Pg2K9Nk5yYc5WJMNUOmupxdN2ZBA
 6zrdaKXfi+gbTQpK16uJvA2PP/Wi46XYL9H9ntGH/6JIDREhr1eegxfXmCelCjA9FRLUXvvCvJz
 zjfYZROZdcuaXghhzFoQuyefwfMa1SOSt6vyk/30Hy3clRQxv8tbZiTKKtLj95P3SSMdu06/gke
 UhdcF7oVhQ6L9JBqq6DmFw+aR4zmWg==
X-Proofpoint-ORIG-GUID: JRzq4vXSsZojf5HdjWs1fHyZFlrNfq_P
X-Proofpoint-GUID: JRzq4vXSsZojf5HdjWs1fHyZFlrNfq_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090129

Currently, there is no standardized mechanism for userspace to
discover which reboot-modes are supported on a given platform.
This limitation forces tools and scripts to rely on hardcoded
assumptions about the supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a
sysfs interface to show the available reboot mode arguments to
userspace. Use the driver_name field of the struct
reboot_mode_driver to create the device. For device-based
drivers, configure the device driver name as driver_name.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported
reboot modes arguments provided by the driver, enabling userspace
to query the list of arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 62 ++++++++++++++++++++++++++++++++++++++-
 include/linux/reboot-mode.h       |  2 ++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 873ac45cd7659b214b7c21958f580ca381e0a63d..582aa7f8ed7fa485c5a67877558c9b15d3600ef4 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt)	"reboot-mode: " fmt
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -23,6 +24,8 @@ struct mode_info {
 	struct list_head list;
 };
 
+static struct class *rb_class;
+
 static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
@@ -65,6 +68,51 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	ssize_t size = 0;
+
+	reboot = (struct reboot_mode_driver *)dev_get_drvdata(dev);
+	if (!reboot)
+		return -ENODATA;
+
+	list_for_each_entry(info, &reboot->head, list)
+		size += sysfs_emit_at(buf, size, "%s ", info->mode);
+
+	if (size) {
+		size += sysfs_emit_at(buf, size - 1, "\n");
+		return size;
+	}
+
+	return -ENODATA;
+}
+static DEVICE_ATTR_RO(reboot_modes);
+
+static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
+{
+	int ret = 0;
+
+	if (!rb_class) {
+		rb_class = class_create("reboot-mode");
+		if (IS_ERR(rb_class))
+			return PTR_ERR(rb_class);
+	}
+
+	reboot->reboot_dev = device_create(rb_class, NULL, 0, (void *)reboot, reboot->driver_name);
+	if (IS_ERR(reboot->reboot_dev))
+		return PTR_ERR(reboot->reboot_dev);
+
+	ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+	if (ret) {
+		device_unregister(reboot->reboot_dev);
+		return ret;
+	}
+
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -83,13 +131,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
 	u32 magic_arg2;
 	int ret;
 
-	if (!fwnode)
+	if (!fwnode || !reboot->driver_name)
 		return -EINVAL;
 
 	np = to_of_node(fwnode);
 	if (!np)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
@@ -142,6 +194,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
 		kfree(info);
 	}
 
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+	device_unregister(reboot->reboot_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -155,6 +209,9 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 	struct mode_info *info;
 	struct mode_info *next;
 
+	if (!reboot->reboot_dev)
+		return -EINVAL;
+
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
 	list_for_each_entry_safe(info, next, &reboot->head, list) {
@@ -163,6 +220,8 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 		kfree(info);
 	}
 
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+	device_unregister(reboot->reboot_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_unregister);
@@ -192,6 +251,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
+	reboot->driver_name = reboot->dev->driver->name;
 	rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
 	if (rc) {
 		devres_free(dr);
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index e0d3e8a54050a76f26846f456120b4c7e371d284..81c149edf40fbcf0d3427c2e12eb415199cb153b 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -7,6 +7,8 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
+	const char *driver_name;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;

-- 
2.34.1


