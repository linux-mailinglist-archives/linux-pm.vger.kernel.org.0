Return-Path: <linux-pm+bounces-31234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C39B0CA93
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF4B6C103A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6A2E49AA;
	Mon, 21 Jul 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgPjvW91"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFC2E499B
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122613; cv=none; b=f//uKjWGgQ5r7DYUNZBAAIUct28TW+WOLKxNemeNrXVBPcs1Q60yj8iezxMtLuo5Lf8EFtqCH+gGryHdLI9lW84sJkWqI9gpaaga+gSi2A/DfZQ6oslwQ4b9yRm2HVDrQBck4kEA84d3Mvl6b8nHC0ZdCF3l1XOOw9sjvscW4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122613; c=relaxed/simple;
	bh=WRonUOFFWFBCm1rQa5vJx+BF5lvxtARn9QwJcpcG7rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shgqaH0xCegTIjZYQwUfjv3jII1Te32Jkemsqm8XHM/kkohWStwetUg/7e1MfBn70ARmtc17Iuxxyugen0SkzPO3dqvudZsWVI92QidW1tp4bTfJvjWuSMcpeedXrPVcAZX12ey/lRj3wXIWwGogL7HPMQTRqFWrvi2CD9LeAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZgPjvW91; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LG3Hq1029355
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IEmpumKrhaODJMwEzzkAX1UibK4n47hwRLwgIiszPOo=; b=ZgPjvW91SwqWnmVM
	7faHGCv2Nd/EQxZ2UQ88t66pvS6Q1Owj9obnZyrWbzM/Ix6tWV95FIIg96TEmwJG
	AdyfnLGOZZMq5Blxdyn0bsa/j5VKRgbFAWwJHyrCm+zapDwcnhMeRkyENJUYs9Fp
	+kr4Mi7iao0Lh88B1ysSQEh32j/Ag2WMzMpvf6DnqT1sARgtS6FfhjpGrwQYR5tS
	HvDMFPo37PmuRF5nfHG0EknFYGxQO+6CR02MpY8LxAhe+IlxvLE+G72YI/P3TpjY
	eS+N+kFwNhdBaUvBYLgs5NrfzromZWGOShHDG+xehVwgZ/69U4kTDhLbraMzTYjA
	a9dKhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048tera2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:30:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234b133b428so34949225ad.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 11:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122608; x=1753727408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEmpumKrhaODJMwEzzkAX1UibK4n47hwRLwgIiszPOo=;
        b=XRAlaYY4cXCpPDa1N/fdANRsrMijiPL1M4glBWyfJcGbHCpxVr50zsEzNr8pNxreqR
         /9S5K5QsCrcSyPjNbKxYzG+KIay8CL52PcZi4e9iv/wLu6eZRCCzXkxW7SEEvqB3UKmH
         ak24d/AAmcY1guzJrAQhkoMfNQonaHRYyRSKgxCu2ad/uC8YKTCtolSivWeu1Cg7xNY+
         EGBiBpv0yQhlY2Vv8VjXIaXveKhV4K/9KKCVJSKSS6pYmMopfoKBmQ8aOhNsoXJCibHm
         tEX80BKHQkGpPiiewMc01Cb3B+jU0z+vrf727+sJA26MIjS4cD6fh7LLbFyuhOeqgWw+
         wing==
X-Forwarded-Encrypted: i=1; AJvYcCUyINWRmG3Rjtv+OnTPJKrlmhLe4QEy/r6T4Y3qLEeZQH26IprItj3Nl6kqVcoMEVpj5Xi6q33YhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLggtW1rV9k//ZyweAuas3aSRNfbkTRsLMcQmlc+c5nczMctIt
	qdqzZRMsigF5rCDYI/a26KQOmN2iuZBOQtBwuQp6jsEpz6VBoomXyxlF4Rto85uTWdcqllFH9yy
	6dCLSFkXaCs3a831OP8JxSdoULpwN7zYTfGrELftjOLZRUEylmERyEEE9kWNkkQ==
X-Gm-Gg: ASbGncvxzEusC2KTjt1UGUQ77UDgKglsf3j0/e5yCfUj1AIFlhyfqoe5DziL71gYC7r
	HWsUcnKfum13ymyxYhva1izLT+L0nlsv42JGDf67aNyZOTaEflIsPMUj7oBWPde41uNQC0wknn+
	HRgKyDmFEwUaR54zkkPRIldlzi5pfWzUl3zsS29sUD5tjOhG+uIZFhCafaUiQtyWB+cvjYB4RDX
	TVuPhKGOTssaEPyXPB0rcIv5hefnQ6syaVDo0p9jxnvL7wRiQA3jVbN/Ub2qhIVKsPj9Cy0Wxdd
	kNlZUEjjz29SIpE3cNYoyC3MXvZYhPw3FDC2VHRLywFjV8aBneolaq4DEVWiA8IRRO6rPlDM8n4
	r
X-Received: by 2002:a17:903:3c6c:b0:235:f51f:c9e4 with SMTP id d9443c01a7336-23e24f49430mr332444765ad.12.1753122608200;
        Mon, 21 Jul 2025 11:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzc5T8auyleKAM78gdw7nHnOP+rs5jlCWnnod/hDPSNKGt7NKcw2Z+61prVl/mK5+bZSi2RA==
X-Received: by 2002:a17:903:3c6c:b0:235:f51f:c9e4 with SMTP id d9443c01a7336-23e24f49430mr332444305ad.12.1753122607738;
        Mon, 21 Jul 2025 11:30:07 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:30:07 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:55 +0530
Subject: [PATCH v12 8/8] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-8-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=8348;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=WRonUOFFWFBCm1rQa5vJx+BF5lvxtARn9QwJcpcG7rc=;
 b=9+F1OboddRi/w7XhvUe0uUkbbtNToE1ZUmtWBNgqJFlLCQJTdSKDU8SJT9yHw4UaPJOQlMa+H
 49ExLAETNSpBfJ+T/ydBKw6NwtFqX4kK7Hc9yXeVs1ZEly2/24D38Vj
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX0s+cnZAUR99O
 F0fTrYTZFBhQhJ7YSWHH74eZD2G/dr2aBwe6i9cC1iQrpH/guF1nrfIw3Qnv8C+bWnxoaxlmLm8
 NEUtvmv7ORFLnhDS/L+B5o/nq+JqgfKOWPzL74hFUDaLwDNeG1TiU5Gv9/clP98fqsXNR9iqFZZ
 XUNzT3fk8w3+UuBBcqiulss+jw1utEoTWVXHZOnnY2aEQvahOxvIguAZkYNOdRh13bb5wv/8Z3d
 YkxygkQ2jDWB0bhn66cLtnY/Lwfmu6DZbf08vq9tko8D1L/DV19MrBKGTO6cWUAYNYyM7MwUYel
 U1N/O3oeK2YC6G54iZw0b99NfjRcR/lPIE/vylJF2+0GZIlbqN/4FWOtC/TOzGrIt506Kw8/th4
 rPLU3vcy8egf/vS8GXf5Z0ehvm2ov/0e6p74QJLaHR9/mD4t7vdG4oDfeezwdUt1rVQLBC3h
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687e8731 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=K9ZbaieeY_mUnl2nlUwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: oRUwo1Lr9D37EKDf0lQtKeShkRmrp1os
X-Proofpoint-ORIG-GUID: oRUwo1Lr9D37EKDf0lQtKeShkRmrp1os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

Currently, there is no standardized mechanism for userspace to
discover which reboot-modes are supported on a given platform.
This limitation forces tools and scripts to rely on hardcoded
assumptions about the supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a
sysfs interface to show the available reboot mode arguments to
userspace.

Create the device using the node name of the driver that
registers with reboot mode driver.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported
reboot modes arguments provided by the driver, enabling userspace
to query the list of arguments.

Align the clean up path to maintain backward compatibility for
existing reboot-mode based drivers.

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   |  38 +++++++
 drivers/power/reset/reboot-mode.c                  | 110 +++++++++++++++++----
 include/linux/reboot-mode.h                        |   1 +
 3 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..63b3ef1ecc66c73744fc831fa9864592c514bd56
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,38 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		July 2025
+KernelVersion:	6.16
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a comma
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 normal,recovery,fastboot,bootloader
+
+		The exact sysfs path may vary depending on the
+		driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/pon/reboot_modes
+
+		The supported arguments can be used by userspace
+		to invoke device reset using the reboot() system
+		call, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
+		Example:
+		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
+
+		A driver can expose the supported arguments by
+		registering them with the reboot-mode framework
+		using the property names that follow the
+		mode-<argument> format.
+		Example:
+		 mode-bootloader, mode-recovery.
+
+		This attribute is useful for scripts or initramfs
+		logic that need to programmatically determine
+		which reboot-mode arguments are valid before
+		triggering a reboot.
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index a17851a303171fd04a47e240f80687541cc85a24..c22d296c9549a1be10523cd11bb0b77a86e53b09 100644
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
@@ -67,6 +70,83 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static void release_reboot_mode_device(struct device *dev, void *res);
+
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct reboot_mode_driver **devres_reboot;
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	ssize_t size = 0;
+
+	devres_reboot = devres_find(dev, release_reboot_mode_device, NULL, 0);
+	reboot = *devres_reboot;
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		size += sprintf(buf + size, "%s,", info->mode);
+	}
+	mutex_unlock(&reboot->rb_lock);
+
+	if (size) {
+		size += sprintf(buf + size - 1, "\n");
+		return size;
+	}
+
+	return -ENODATA;
+}
+static DEVICE_ATTR_RO(reboot_modes);
+
+static void release_reboot_mode_device(struct device *dev, void *res)
+{
+	struct reboot_mode_driver *reboot = *(struct reboot_mode_driver **)res;
+	struct mode_info *info;
+	struct mode_info *next;
+
+	unregister_reboot_notifier(&reboot->reboot_notifier);
+
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
+		kfree_const(info->mode);
+		kfree(info);
+	}
+	mutex_unlock(&reboot->rb_lock);
+
+	device_remove_file(reboot->dev, &dev_attr_reboot_modes);
+}
+
+static int create_reboot_mode_device(struct reboot_mode_driver *reboot,
+				     const char *dev_name)
+{
+	struct reboot_mode_driver **dr;
+	int ret = 0;
+
+	if (!rb_class) {
+		rb_class = class_create("reboot-mode");
+		if (IS_ERR(rb_class))
+			return PTR_ERR(rb_class);
+	}
+
+	reboot->reboot_dev = device_create(rb_class, NULL, 0, NULL, dev_name);
+	if (IS_ERR(reboot->reboot_dev))
+		return PTR_ERR(reboot->reboot_dev);
+
+	ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+	if (ret)
+		return ret;
+
+	dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+		return -ENOMEM;
+	}
+
+	*dr = reboot;
+	devres_add(reboot->reboot_dev, dr);
+
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -77,7 +157,6 @@ static int reboot_mode_notify(struct notifier_block *this,
 int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
 {
 	struct mode_info *info;
-	struct mode_info *next;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
 	u32 magic_arg1;
@@ -87,6 +166,10 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	if (!np)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot, np->name ? np->name : "reboot-mode-dev");
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 	mutex_init(&reboot->rb_lock);
 
@@ -136,13 +219,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	return 0;
 
 error:
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		list_del(&info->list);
-		kfree_const(info->mode);
-		kfree(info);
-	}
-
 	mutex_unlock(&reboot->rb_lock);
+	device_unregister(reboot->reboot_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -153,26 +231,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
  */
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
-	struct mode_info *next;
-
-	unregister_reboot_notifier(&reboot->reboot_notifier);
-
-	mutex_lock(&reboot->rb_lock);
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		list_del(&info->list);
-		kfree_const(info->mode);
-		kfree(info);
-	}
-	mutex_unlock(&reboot->rb_lock);
-
+	device_unregister(reboot->reboot_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_unregister);
 
 static void devm_reboot_mode_release(struct device *dev, void *res)
 {
-	reboot_mode_unregister(*(struct reboot_mode_driver **)res);
+	struct reboot_mode_driver *reboot = *(struct reboot_mode_driver **)res;
+
+	device_unregister(reboot->reboot_dev);
 }
 
 /**
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 370228b5161963aac1d75af752ada0e8282b1078..d5ffc36272ba776a6bca4e61356714e07a5b0501 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -7,6 +7,7 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;

-- 
2.34.1


