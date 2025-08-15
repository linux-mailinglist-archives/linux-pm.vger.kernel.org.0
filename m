Return-Path: <linux-pm+bounces-32441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7410B281FE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 16:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E275C4FA7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA323A984;
	Fri, 15 Aug 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X80UDi5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28593233128
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268632; cv=none; b=Ild02EirKNwpuuLC4IqAXBmwtXG+1o0dTZ7BNezxSCQlbnTYWWulIBziafdkAeAgpWb71oRRpeevzIMxiTvBYWL5tE1cv+bTSMrgX3kABR5cXRJbRnKivc7nkyWjmJjBJ958+SehiAEfy9U62nM6k3Ba6EWIQTPzRBbj9ZwbFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268632; c=relaxed/simple;
	bh=/cq18pjLWig5FtkFDIdwUtfrzOBXNV40XqrxsOZOo0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbdPH5KpPq/clytvqPcqjoabo72yJ6y8xdYgXLaV5yOV5CScdEUmijnuEocTOWD0zpdQi3hRvutqPzi8pUqYF9nOOdTUMO/YQrL5Dk3pQ1aDhhEyKPB4khub4/ybGFrRQ9gy9pFw7ZAvjBUGRHFatvbhToHHFjM5Bapl2W5dRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X80UDi5p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJ89t021050
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3zDTag6B0PbaB1+ygZD7ZZ/pAHwEXMw02xGe8CGFm0U=; b=X80UDi5p8jwKanti
	tZZF6okguAFZd6oPl0JQ4U7uJ4Zo8tf7829hjeuYEz11g0MDd/QpTWBHM8jeeKqb
	5rw2pyYndyUmPCF3BBN8qAxMgtnotE4leopT0MXV5pV76tpUMr/m+uUV3pW1tgi2
	2C0nv0uO/fk8d7DcsWCVXaOjv91ClFiu4RncuLrd7fmf0ZX6NQceSjoUIfDn/Rez
	Smfm03FliLkI+5zPfLTXs4QirqqFpaNnGpHcRzERkwMgjLYetfD6HoW740UugByy
	xplvisF9WJOu82stjlrPrfedv+oijjVG1ZX8voPGZlC0O8o+sjHk7jNcUQoYGF/U
	dKM8OQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gk6p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:37:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323266b41f5so4027358a91.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 07:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268629; x=1755873429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zDTag6B0PbaB1+ygZD7ZZ/pAHwEXMw02xGe8CGFm0U=;
        b=awyC28cEMV0PNBL6BD8V8UjW6eMmOiT5Im+aoHFh5xstVSF1QNxNJc3gzPbXIHnGfj
         Kv2vcXdVgCuAu7Cb2pmdjmARaPcZoaRFpuF5ZADI2ziQ9v/naB99RmvpC4MmvsxGzsjK
         826MN0WM7K1ZnQ1acV4DCidh3k8HdGwzU1rIQygXcuZSuT6uUOx1iAKSj8k5erPD2bGd
         8HSclKTVOC6zCvWfCCc/2P8F7Eip7KswBW1b3nfHgQe4Klx/fvBggZKfNR2loGN4FSl4
         S2YqLFPSeXIS6vxRNkk/osQdmznw0C1IxNSxSYDMdBhCWf9HS5vucxoIrqvdxRuIW8zG
         tPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUiMvPAmzeyidUZOgy2cV27aUGssXiRmRoQf5syHMYgZheRdryYRsjoeyww5xLBcPiK6YDly96Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ywv3N0pQ8AUOXTNvekJWsTv8WDr68qF8q9L9oP0NrfiOJ3sP
	mm2i2FMvJJzE58nAMMXF90IOsvix0g0K2l9tPDvCt6gklYVn8i7nLM36u3K+8MhSPjyPHk+lIlC
	FvM8QOnju1s0JkojEW0FX6EJ7AQgUENNtFsqm1l0udetZ71f1g+ZBXFs2E6Byqg==
X-Gm-Gg: ASbGnctycSD/WrkHlD0hC1JRxVerUnn+QFy8ZEr6Nlz1hlEfhk8vGcC4AGL2t/7Br5G
	ohdr7vCPQOhqpgpcsE0g7tELXcYVPdckf41LJ6QRyTxZdNGtZTLQP8OeXW+TZd9+wZcjVOxUtbO
	ywj+aTFPb7zopmFS87rHXaJzIXROZS7mVM1U7qT1irdXeSnH1Jx6is0g7FE5rtRVFR9fTfPwH/N
	gccAGyKqc1YX8AnJOr0fOMypU+yd91u7qGI/E1L8zoFVoY2Qs6BUWA7CRivP2ltKg64cMr9kDdJ
	TLh/y9ajZWWjPq4P23YpDGjvt+1oyKcPW5pDk8WhbVOQgZNvMMBbHP2o1YFGQGQsKnBUFs9mYue
	/
X-Received: by 2002:a17:90b:54c4:b0:31e:fe0d:f48f with SMTP id 98e67ed59e1d1-32341eb9ff4mr3586709a91.10.1755268629214;
        Fri, 15 Aug 2025 07:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR9+JNwAnkNnpK95babxi24ft9HL9R2NpwxxciFjgDeImk29mC5ZpyJI7qlPsUL6h7I4vrew==
X-Received: by 2002:a17:90b:54c4:b0:31e:fe0d:f48f with SMTP id 98e67ed59e1d1-32341eb9ff4mr3586639a91.10.1755268628704;
        Fri, 15 Aug 2025 07:37:08 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:08 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:10 +0530
Subject: [PATCH v14 05/10] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-5-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=7924;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/cq18pjLWig5FtkFDIdwUtfrzOBXNV40XqrxsOZOo0Y=;
 b=/JH+an9qBrDld6l1nDJbKdEeW2TlWDNSo1WgUW8EKdMYS5NkP1Uo9v8cx0bCY33UJxKONZ3cQ
 2AfXxFbS358AppaJGKg6KtJ3D4Gdun7JC5/GmZnORltV+OSaZDvQhNl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689f4616 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ty-NMr1YQicgvEyun9kA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX3gdIcDfP/CpH
 UwJea/78cVC3NL7ovOKGZ19MJUtQVNLClirt7K+O0N6ewpT1JVr5bH+f+ZQct9LZWYrjilLWvZx
 /U2NWjp8u0dNRd2bT7hZLe36gt5Q/xMLPlCjYlNkLtEQUgVXVNA/Vz3uGVLMlNWO31DoUq6eo70
 bhWDdma8QMhrRjvT2AW1+FsrwYQzQjmC7c/ehVl/57nqGU/b/E70lWi80udEQ73tkVuQXIlnX1k
 x5OHn7lHU8Eub90z/Mc7Jxq4eVMFypNws10gy8RlChPlhGGvQTVqE5Oapjgbb1lN5fXT85k/nw0
 DQ2oU7Jp9i2/YGV7bdH5vQXfGw7Vbqcq10HjLIlBQMphert48fCVUtg89hh9DAJGX8wMghlaJkm
 DCrHIxeg
X-Proofpoint-GUID: JbpPntEUOnLHfE7DnPTioYRiZ_gtykOy
X-Proofpoint-ORIG-GUID: JbpPntEUOnLHfE7DnPTioYRiZ_gtykOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Currently, there is no standardized mechanism for userspace to
discover which reboot-modes are supported on a given platform.
This limitation forces tools and scripts to rely on hardcoded
assumptions about the supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a
sysfs interface to show the available reboot mode arguments to
userspace.

Provision the register function with an additional parameter to
get an explicit driver_name. Create the device using this
driver_name. For platform drivers, use the driver_name configured
in dev node.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported
reboot modes arguments provided by the driver, enabling userspace
to query the list of arguments.

Align the clean up path to maintain backward compatibility for
existing reboot-mode based drivers.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 131 +++++++++++++++++++++++++++++++-------
 include/linux/reboot-mode.h       |   4 +-
 2 files changed, 110 insertions(+), 25 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index ac81b8b0a9b7fc31f8ef21024333a050087ce90f..7ecab050e496af3e1cc01c1a4614787707cb74b4 100644
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
@@ -75,26 +78,121 @@ static int reboot_mode_notify(struct notifier_block *this,
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
+	devres_reboot = devres_find(dev, release_reboot_mode_device, NULL, NULL);
+	if (!devres_reboot || !(*devres_reboot))
+		return -ENODATA;
+
+	reboot = *devres_reboot;
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		size += sprintf(buf + size, "%s ", info->mode);
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
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
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
+		goto create_file_err;
+
+	dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		ret = -ENOMEM;
+		goto devres_alloc_error;
+	}
+
+	*dr = reboot;
+	devres_add(reboot->reboot_dev, dr);
+	return ret;
+
+devres_alloc_error:
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+create_file_err:
+	device_unregister(reboot->reboot_dev);
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
  * @np: Pointer to device tree node
+ * @driver_name: Name to use when exposing the sysfs interface
+ *
+ * Registers a reboot mode driver and sets up its sysfs entries
+ * under /sys/class/reboot-mode/<driver_name>/ to allow userspace
+ * interaction with available reboot modes. The DT node is used
+ * for parsing reboot-mode arguments.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np,
+			 const char *driver_name)
 {
 	struct mode_info *info;
-	struct mode_info *next;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
 	u32 magic_arg1;
 	u32 magic_arg2;
 	int ret;
 
-	if (!np)
+	if (!np || !driver_name)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot, driver_name);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 	mutex_init(&reboot->rb_lock);
 
@@ -144,13 +242,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
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
@@ -161,26 +254,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
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
@@ -200,7 +283,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot, reboot->dev->of_node);
+	rc = reboot_mode_register(reboot, reboot->dev->of_node, reboot->dev->driver->name);
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 370228b5161963aac1d75af752ada0e8282b1078..0b9844a71224b3e4bcc0d1e396d6c9cb11ad8c97 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -7,6 +7,7 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
@@ -14,7 +15,8 @@ struct reboot_mode_driver {
 	struct mutex rb_lock;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np,
+			 const char *driver_name);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


