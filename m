Return-Path: <linux-pm+bounces-41554-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHd8Do/heGkGtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41554-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:02:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A77974FB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D69130C5C51
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6335EDAD;
	Tue, 27 Jan 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e2MEiGrY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGt0XGFm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571235DCEF
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529469; cv=none; b=Y3n4CQ1YkANo/qH5vn2WF976IxJAOHKS/mVbagvqr3wVLI+1DqZcQGtDnHCrwi6THIbo6rr5pNAeyyRefPSTXfcZeWol+MtGUbTQtNart5abU5wo89YwH29FYHyb4RHT+2xr2KzYUK4QiOVRZdKXucdSQl5xxLZ7GKbhpYiFcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529469; c=relaxed/simple;
	bh=YyaNXeWaLIKpWzCU/L/ILFdXN/+iun4frf5IkoJMhJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdN5UST9P5ob5zef8P/2ND5QibLHu2Eo6hYsRT2V0blJSw6a2nuOnjse9EJzePLCWDphe1nGNE1xVtUI+kB/LbkE3PCQNAytkbXA1NJ2H3gMYLaQ9zAmRErovdH3Re1D5v0IeaPoi4PaYwQglYvjdNj+9wet+hQ6m/URUcY4QA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e2MEiGrY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NGt0XGFm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAjjkw496114
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5nar1uSCNy/
	fyhypcdwInxOup3xqwfDAP5lnvImXQmk=; b=e2MEiGrYMzVHg7YLNP3oMczkud3
	GomERdLlTL9e/zdasrlSxwni6xGMxXr0jaWX8wFaDuy677NeREJCVz3xiNv+Rfab
	MXB6Uh/FRD2G4V55i1DBkRx4kNG23GIw+Qsbb4WpO2uNNNXbrPGagZHjPfemBX0K
	l3v4bdceC8owTYTA3+tshUUORYcDgmhpes8+xtF4NbfeRWHq+juVBBYjC/nammJ7
	ffgAiSFk29FEh/wXM91uTDAYgQLVzTQn8+NOJuuCOeVXPBUjIbWj0Tkr97zf5t4C
	fPr2P/9dc1UAASMKTasobnwyfsvATn7PLOjfxwO3gyKLEg2rKfpj6Cmq5Tg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bkd8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:57:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a79164b686so61412945ad.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529466; x=1770134266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nar1uSCNy/fyhypcdwInxOup3xqwfDAP5lnvImXQmk=;
        b=NGt0XGFmucQoYulaecA6hWVSISy44oSTR30LqbQAdoFeMCOnr5JMfzbFuxNjTuW1f+
         IhMJrAFmZSCffvkz9KEehKdKitoqMNbAbqT2SVM+r2RssBVzTNe3BHbQtBdEAN+3qEBt
         Wgc5UqHJfGIkQdzVyIT1jfYUYhxw3Pm7852PPWssOWw/TehYrqhfzLcpFeOm/217WlsM
         NM78hW6Rw3cYioL0uNXASgK+R8pkcIsZ2X+/hwZnsd9CWt27bwBj+GbpKSbIbwsgMHHN
         qJlGQjkFBad97UAvzZHTNsTedNBTRT4ibgoFcj/CYjSQA4dugMqus5gpKne77/f/gP1L
         uOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529466; x=1770134266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nar1uSCNy/fyhypcdwInxOup3xqwfDAP5lnvImXQmk=;
        b=abycbDnoxbTBg4U5wlDWlAr0Dl2l8Ab9bknd75XKrjL5uX8mfUYNV+uZYNcc1enQr1
         xWQcoPtGjeAt79Vi8HEVR0cvoGXYCJMuJKy3TtbfI6PpkA6/hVvwbGcW5MvG/8Kszdgb
         K4ymC6rsz/hMH0G3g18CrW/HFsJ9uVdaSvHdCdmCPf1tbt0SuZkbYxx5ILij/s5jTciw
         tEbGyWX+ohCIO9uGrRisUXEp/dAZ6mhNv4rI3mZqMCH+eStMLThR2rvEtnHRXkPH/Ua8
         hy36TL2ewPn3LmEu6g/k25rh/UMlwQHF8y5DPX8XF7AkweGZap3RiNcgq86esQ7on2cv
         tMRg==
X-Forwarded-Encrypted: i=1; AJvYcCXZRGauYtqQ2Fp4eDYzsoSlGCJm9yvoOQ9v0i0NZTTLe6npzEJVSaYqnRjd0WvKdZG3joRCX81hEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwuMiHfb1jQEWLMkK66dKXPwOz31JAknSUsOhx1zb9/fuwSaI
	rpNC+5hOHo46zdz2/H23TD0f/oBxvwv0//0F+gxkwEHQsiihhUou1c3RSb7dJBCMMVUGEnrTvXR
	sFUdVrNOxYFNLuPAkC6L1szcE4GNzPKX7hLinIzOhwLGsRney5ZSCcbspf0tnlQ==
X-Gm-Gg: AZuq6aI6wHNZWow0qe8iZ1g2pX5bhrW0gUIcGK5Lya1BWKexYYDDErXnk1Iwow8SdVn
	yCGMgAhcJOSK6HWjNjwAEaxeqxj0zOi8ik7eELnRZAOtZUALgJh+mHEBysZF06kL5LPtCrQ4tXa
	yiasmoPf9Qql17XJhKxiCHJunS5pUWeSsDgKXp9NjP7LrgoRviEqDyPwyeDsyQdTc0TIPIahSDN
	y2doH9FD8h2tq09US+9A3WNTnX99K5dPNUNqrdDu6Bj6HrPlnSWiqRypfBs2ijGZp82GnbeZvjz
	B0vCZGtfk7Wz+60Ofj8rrG2d/p9OEObSPFnSPLQcsiL1lD7sjpFo+nGka5bZoJ2PaNACESuEk9X
	Idq3XBfq/ePN9Ladn9NALu8lMBRTgzeuFfQwoRts=
X-Received: by 2002:a17:902:f68b:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a870ddd7b6mr26852585ad.49.1769529465607;
        Tue, 27 Jan 2026 07:57:45 -0800 (PST)
X-Received: by 2002:a17:902:f68b:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a870ddd7b6mr26852185ad.49.1769529465015;
        Tue, 27 Jan 2026 07:57:45 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:57:44 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
Date: Tue, 27 Jan 2026 21:27:15 +0530
Message-Id: <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FSsUxyDLBl-G_K98P2iBx6pW_XJXlIYA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX3IKKWYzZ+Xow
 H6DvtXLjJOhdj0XpxA3HLDkdQATdou2z/U5gjYR9vPidGNYTuaR0QSFURkYr1GdkLsur7T7gq33
 sLKBH6kkgyNt7inm0tgf78HUFKaufgRDljhNO2L3ikO3AZPaZe9n1G6f5rI4L1dztAfK1yqWe/p
 PDnrqSmS5F1YbYA9kTpi1J4mh9nAytbnOIaYpW2hdHgmWptIqQZDIUv1TYj/u0+DuUZeajnYIj2
 UNdwro942jGwjUkkIHMbgZGMWIibVKQIHXg3O/GESGLS5d0Vm8a8dmKrTb52Sjl8CZNOUPLoyFn
 escRQ5Fs/Ow8RUOO7yRRhqbaIrA4YVRyePcu9oekLinkuyU3Kr0ZrIyk9txm6KDGpTMljmTbfgh
 RjWPbUln7JnSETJl9SHkkVrOSVg8ZIhKD1Ng1qd4D173BGYRiUDji+VU7YpcD2teMWO94ms6YFm
 6S/pbcnrIGbHxcmhhLA==
X-Proofpoint-GUID: FSsUxyDLBl-G_K98P2iBx6pW_XJXlIYA
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=6978e07a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=2qJnY-jACA4cO-adHyEA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41554-lists,linux-pm=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[lukasz.luba.arm.com:query timed out,linux-pm.vger.kernel.org:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8A77974FB
X-Rspamd-Action: no action

Add a new generic driver for thermal cooling devices that control
remote processors (modem, DSP, etc.) through various communication
channels.

This driver provides an abstraction layer between the thermal
subsystem and vendor-specific remote processor communication
mechanisms.

Advantage of this to avoid duplicating vendor-specific logic
in the thermal subsystem and make it easier for different vendors
to plug in their own cooling mechanisms via callbacks.

Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 MAINTAINERS                          |   7 ++
 drivers/thermal/Kconfig              |  10 ++
 drivers/thermal/Makefile             |   2 +
 drivers/thermal/remoteproc_cooling.c | 143 +++++++++++++++++++++++++++
 include/linux/remoteproc_cooling.h   |  52 ++++++++++
 5 files changed, 214 insertions(+)
 create mode 100644 drivers/thermal/remoteproc_cooling.c
 create mode 100644 include/linux/remoteproc_cooling.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 414f44093269..5ebc7819d2cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26169,6 +26169,13 @@ F:	drivers/thermal/cpufreq_cooling.c
 F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL/REMOTEPROC_COOLING
+M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/thermal/remoteproc_cooling.c
+F:	include/linux/remoteproc_cooling.h
+
 THERMAL/POWER_ALLOCATOR
 M:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b10080d61860..dfc52eed64de 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -229,6 +229,16 @@ config PCIE_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config REMOTEPROC_THERMAL
+	tristate "Remote processor cooling support"
+	help
+	  This implements a generic cooling mechanism for remote processors
+	  (modem, DSP, etc.) that allows vendor-specific implementations to
+	  register thermal cooling devices and provide callbacks for thermal
+	  mitigation.
+
+	  If you want this support, you should say Y here.
+
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index bb21e7ea7fc6..ae747dde54fe 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -34,6 +34,8 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
 
+thermal_sys-$(CONFIG_REMOTEPROC_THERMAL) += remoteproc_cooling.o
+
 obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
 # platform thermal drivers
 obj-y				+= broadcom/
diff --git a/drivers/thermal/remoteproc_cooling.c b/drivers/thermal/remoteproc_cooling.c
new file mode 100644
index 000000000000..f958efa691b3
--- /dev/null
+++ b/drivers/thermal/remoteproc_cooling.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Remote Processor Cooling Device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#define REMOTEPROC_PREFIX		"rproc_"
+
+struct remoteproc_cooling_ops {
+	int (*get_max_level)(void *devdata, unsigned long *level);
+	int (*get_cur_level)(void *devdata, unsigned long *level);
+	int (*set_cur_level)(void *devdata, unsigned long level);
+};
+
+/**
+ * struct remoteproc_cdev - Remote processor cooling device
+ * @cdev: Thermal cooling device handle
+ * @ops: Vendor-specific operation callbacks
+ * @devdata: Private data for vendor implementation
+ * @np: Device tree node associated with this cooling device
+ * @lock: Mutex to protect cooling device operations
+ */
+struct remoteproc_cdev {
+	struct thermal_cooling_device *cdev;
+	const struct remoteproc_cooling_ops *ops;
+	void *devdata;
+	struct mutex lock;
+};
+
+/* Thermal cooling device callbacks */
+
+static int remoteproc_get_max_state(struct thermal_cooling_device *cdev,
+				    unsigned long *state)
+{
+	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
+	int ret;
+
+	mutex_lock(&rproc_cdev->lock);
+	ret = rproc_cdev->ops->get_max_level(rproc_cdev->devdata, state);
+	mutex_unlock(&rproc_cdev->lock);
+
+	return ret;
+}
+
+static int remoteproc_get_cur_state(struct thermal_cooling_device *cdev,
+				    unsigned long *state)
+{
+	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
+	int ret;
+
+	mutex_lock(&rproc_cdev->lock);
+	ret = rproc_cdev->ops->get_cur_level(rproc_cdev->devdata, state);
+	mutex_unlock(&rproc_cdev->lock);
+
+	return ret;
+}
+
+static int remoteproc_set_cur_state(struct thermal_cooling_device *cdev,
+				    unsigned long state)
+{
+	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
+	int ret;
+
+	mutex_lock(&rproc_cdev->lock);
+	ret = rproc_cdev->ops->set_cur_level(rproc_cdev->devdata, state);
+	mutex_unlock(&rproc_cdev->lock);
+
+	return ret;
+}
+
+static const struct thermal_cooling_device_ops remoteproc_cooling_ops = {
+	.get_max_state = remoteproc_get_max_state,
+	.get_cur_state = remoteproc_get_cur_state,
+	.set_cur_state = remoteproc_set_cur_state,
+};
+
+struct remoteproc_cdev *
+remoteproc_cooling_register(struct device_node *np,
+			    const char *name, const struct remoteproc_cooling_ops *ops,
+			     void *devdata)
+{
+	struct remoteproc_cdev *rproc_cdev;
+	struct thermal_cooling_device *cdev;
+	int ret;
+
+	if (!name || !ops)
+		return ERR_PTR(-EINVAL);
+
+	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
+	if (!rproc_cdev)
+		return ERR_PTR(-ENOMEM);
+
+	rproc_cdev->ops = ops;
+	rproc_cdev->devdata = devdata;
+	mutex_init(&rproc_cdev->lock);
+
+	char *rproc_name __free(kfree) =
+		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
+	/* Register with thermal framework */
+	if (np)
+		cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
+							  &remoteproc_cooling_ops);
+	else
+		cdev = thermal_cooling_device_register(rproc_name, rproc_cdev,
+						       &remoteproc_cooling_ops);
+
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto free_rproc_cdev;
+	}
+
+	rproc_cdev->cdev = cdev;
+
+	return rproc_cdev;
+
+free_rproc_cdev:
+	kfree(rproc_cdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(remoteproc_cooling_register);
+
+void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
+{
+	if (!rproc_cdev)
+		return;
+
+	thermal_cooling_device_unregister(rproc_cdev->cdev);
+	mutex_destroy(&rproc_cdev->lock);
+	kfree(rproc_cdev);
+}
+EXPORT_SYMBOL_GPL(remoteproc_cooling_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Remote Processor Cooling Device");
diff --git a/include/linux/remoteproc_cooling.h b/include/linux/remoteproc_cooling.h
new file mode 100644
index 000000000000..721912d1a5ec
--- /dev/null
+++ b/include/linux/remoteproc_cooling.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Remote Processor Cooling Device
+ *
+ * Copyright (c) 2025, Qualcomm Innovation Center
+ */
+
+#ifndef __REMOTEPROC_COOLING_H__
+#define __REMOTEPROC_COOLING_H__
+
+#include <linux/thermal.h>
+
+struct device;
+struct device_node;
+
+struct remoteproc_cooling_ops {
+	int (*get_max_level)(void *devdata, unsigned long *level);
+	int (*get_cur_level)(void *devdata, unsigned long *level);
+	int (*set_cur_level)(void *devdata, unsigned long level);
+};
+
+struct remoteproc_cdev;
+
+#ifdef CONFIG_REMOTEPROC_THERMAL
+
+struct remoteproc_cdev *
+remoteproc_cooling_register(struct device_node *np,
+			    const char *name,
+			     const struct remoteproc_cooling_ops *ops,
+			     void *devdata);
+
+void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev);
+
+#else /* !CONFIG_REMOTEPROC_THERMAL */
+
+static inline struct remoteproc_cdev *
+remoteproc_cooling_register(struct device_node *np,
+			    const char *name,
+			     const struct remoteproc_cooling_ops *ops,
+			     void *devdata)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void
+remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
+{
+}
+
+#endif /* CONFIG_REMOTEPROC_THERMAL */
+
+#endif /* __REMOTEPROC_COOLING_H__ */
-- 
2.34.1


