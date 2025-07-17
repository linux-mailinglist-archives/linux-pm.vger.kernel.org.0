Return-Path: <linux-pm+bounces-31010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D049AB08D73
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4B0A66491
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2972D8765;
	Thu, 17 Jul 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hdoC58Fp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B082D77FA
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756531; cv=none; b=ozZj4jg3g8Bihjp2toqxcSISR1IcNcGJKrb+1Pgnu+rnBxqX1P/I7Y7bJ59cdPvi7/TgR59+sEOVE9dRWvgD7S0V3QLTG6nsdV9j9XIiFuhC36+6fPe9Nccaux4d92o+mGdf5PFFiyBeK9R5z1XPeXsSzKx2TvNeGePnZ8w4mXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756531; c=relaxed/simple;
	bh=dzfywuUuVDRiw0cxEMBMzlxkHVeafnNl2y+/gY2scNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxCnwrnn/HcJ+fWHYRQuV8lKNWQCsiGtKV7uu9cpWiWqUGGlAqgt5YOKTgPzSRFsYAsUNxpv385GxLhgG8dpTO85L2nj2p0d07gi7Td/PjlX3zqCF4FsAyICoFpW+5vmfNT7mfzuWKudTJ61qdFn5g0UrYI3ConMIszrZqNNbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hdoC58Fp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCGTVj000541
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tkUicWB76ieKISxjnwkwmUAWcFBcwTj81cvO9nIz9Bk=; b=hdoC58FpNpctw++K
	Sn76G/AMFCO7bv26b8rfuUDuFzPS3sIvTN7q7prrNRsltvbpKlpB22Y2rJ3Qss7T
	oiJrAVXBKFTGXNyOahK+h1OfF4BiOdmyQFcmTelI9TKvwiyorRz/7LUEMf8x5fSS
	I48DeEMHVqDw/exasxqGNnUFzWbJX5D3eAquUHbCYv69UMXQvia6a9GsBQTsneyq
	ohEOQEa0ksHtb+Y4TKkzS6Kfu6AFDy9LjjXR9tu4u+C8V5PinJ7ozUhPVM8PajIO
	iLtHf1gB8fiUWBiYqhigDtQByywBztKFN/KiQKYbku1WDuqyLEbpNWulhXBkwaO8
	5wrx8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drtq82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:48:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so964319a91.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 05:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756528; x=1753361328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkUicWB76ieKISxjnwkwmUAWcFBcwTj81cvO9nIz9Bk=;
        b=K/pUqNiwYhAsMpsLB8/PDevvtvo7WGTBGI04GyV7eC7nNF/B3YNJEZqG2rhG8KDOO8
         QGo4mtsbKrJPs9y52CXvKhWa9dkof0DjLtCG/jW3v0WMUaVjjOxwG5ylLfZoRI+rYVsI
         Q2viHb6s5jP6vbYllLSubobkoaGAuMk53sTn/FQphDKp5zoQ946dz4OrUx9+0bmwpovD
         iR31o95KyfimgZ2wzJvYMHnTl96LshH6S/NwAvYYS2MQhjrs0/kOEwniRykp/NBYs5DY
         ldBFKQqG7BCcoyj6gMBcJnSOGSez9kGDtTZtjexpHuSHetUH3eorBRTwLfJUwoWuLDld
         nqhw==
X-Forwarded-Encrypted: i=1; AJvYcCXXbOX2oiiFaGJkzF2I309gMt0uEx4g/tov2A0tYBX+UL4jUHUCSsTFj/enWea6WGGQgv23lyu9Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydRORRGCauywl/1BQdfMdOj5eAt3JAWUyZbQtgmFar/VHEZixZ
	9csYVUMcKFzMAdV9MmTpNJI9nwM6TlOFPmeWpkIezMJ2Rk55qv9bOHQVc+86fTPmBplJDNaNtAc
	r9FUQwZVzlfopwFnoNW+gSAcN9xBVyxHrdDNeQp+2hf0J5Vh4ed81y5VDXAvQpXC3YBKoHw==
X-Gm-Gg: ASbGncs98B8j0wa06gzJU3Gv9EjcwQ2CyX/CqwKRJ3vSfs1QDBCY58/W3OnV17nAOgc
	VOgm5xIXEESUEroS5wcVOVBcDyxNDrTRN5Gw4JUPrsrMWSCRCteXggTa9gnawMLen0uRovOudFn
	jjVq3ZTxxjWeS/b66o0YKXEGppB+VuBys7C67rESG7E2B3fVA1yG1eGhMP0sak7Mo6GieD+TI4j
	ZsULA/+mWxrl/aRrZxP3Ct7oH7Q0K5a4gbZA8ORXUPDBSspFyLqOsyduZccDeoy2eQKyEqOaz+b
	1tzIZXvxb6zQW9VhvwWbMO9wx9fs1+XySxdDcWpq5gL10sDAEq7+fLC5Aro3Ud/sZ7Kd2hSS7Fe
	P
X-Received: by 2002:a17:90b:1ccc:b0:313:271a:af56 with SMTP id 98e67ed59e1d1-31c9e78d9fcmr9191636a91.30.1752756528357;
        Thu, 17 Jul 2025 05:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRdKlC16lxkWUCUZhw0+fz+yA0Fr68ZbmeflAPY4PRaTdeyJr/foHYSUxJAaxMSb2tkmP1bQ==
X-Received: by 2002:a17:90b:1ccc:b0:313:271a:af56 with SMTP id 98e67ed59e1d1-31c9e78d9fcmr9191603a91.30.1752756527883;
        Thu, 17 Jul 2025 05:48:47 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:48:47 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:54 +0530
Subject: [PATCH v11 8/8] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-8-df3e2b2183c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=7454;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=dzfywuUuVDRiw0cxEMBMzlxkHVeafnNl2y+/gY2scNQ=;
 b=5xhLKNPQS9288lBeKvndsb2ahvA45N7vW93WeXRvHYkiJ3x0JHi1/4pHQT6SKD9hbWK6UZK/C
 QFftekoiK3iCxfTUpVKLTbdmPu/sUWAZDSDiJeONjmSnzidTJWdlBoA
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 4_noEYmTR6dsElpmckwJ7LpUzPFlZ9yd
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6878f131 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=I4qJSSq-i-5ETPqSmjYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 4_noEYmTR6dsElpmckwJ7LpUzPFlZ9yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfX6dT3lLro8Oj9
 NzP415RfRrqZYHrJNQZ2LpoyD8/UgoJMCm4kPpfI59vqcAezMX4ojMu1srz+s30bhmlVDsUkyY1
 SjxNP7ZvbX0wMRNVoEMdivxqlMma2WV1hMsKfvk0kaLi8NH54kwsSrYjSulu/CpKHowO27rsV2s
 3wpD+/O6wQZzGoATjIV4L6TU3BNK/5qw+JovcdLUi1gfZjv3VHHiEyBiwpoVrjzlwmpjzXRnTrA
 uOOiI9VJXQa9YSNS+Yz/ZSuBfxpYmarez+BUeDLL2dfW2o4vVJi2LFa4CC1OSaQZJwFWyWOJ12c
 5SER8UxCIz1FkSR4ijTyp4yHdCEW4L8U2gd4PI9x/XG+/B8K51BPG6bFXg5muZ+4+IngtRM7aDM
 FMqs0X8rbcP2uMlJqtr3NMCEoLILXLQDj7MsbdWhN1GzhuKbcfiNS7YVVBDyYx/d6vH/rVKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170112

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
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 38 +++++++++
 drivers/power/reset/reboot-mode.c                  | 96 +++++++++++++++++++---
 include/linux/reboot-mode.h                        |  1 +
 3 files changed, 123 insertions(+), 12 deletions(-)

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
index 1196627fbf98d87eec57a3d4ee544e403e6eb946..af3551fe2f625aacd31699604b7cbdd66c318c00 100644
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
 static struct mode_info *get_reboot_mode_info(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
@@ -65,6 +68,79 @@ static int reboot_mode_notify(struct notifier_block *this,
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
+	list_for_each_entry(info, &reboot->head, list) {
+		size += sprintf(buf + size, "%s,", info->mode);
+	}
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
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		kfree_const(info->mode);
+		list_del(&info->list);
+		kfree(info);
+	}
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
@@ -83,6 +159,10 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	if (!np)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot, np->name ? np->name : "reboot-mode-dev");
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
@@ -137,24 +217,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
  */
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
-	struct mode_info *next;
-
-	unregister_reboot_notifier(&reboot->reboot_notifier);
-
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		kfree_const(info->mode);
-		list_del(&info->list);
-		kfree(info);
-	}
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
index d9d9165a8635e5d55d92197a69c7fae179ac2045..8fb35ef1c00749500a99d088b5f7010d57547844 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -6,6 +6,7 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;

-- 
2.34.1


