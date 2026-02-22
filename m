Return-Path: <linux-pm+bounces-42980-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMXHCOo9m2m8wgMAu9opvQ
	(envelope-from <linux-pm+bounces-42980-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 18:33:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDF16FEFA
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 821CC30116AA
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DB135B658;
	Sun, 22 Feb 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqs7c+Qv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FCF35B650
	for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781569; cv=none; b=n9KoTndOb607eDYsldzsXuiKBSGNAX9KvWwBtEypaMGcEzEdoMtMidqGusxUbdF6UJ+WpQH7JfZq+TmUqAPhzCEni18/bJOcr4x7p/Hj9K5j63mQ+Ndjoh6c4EMlqUG06RK7iNQM+ZtxuCDchbGhBW3YviSOcFrIDxa6pDZabHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781569; c=relaxed/simple;
	bh=1m0uQK6CF91pCqxZ05R2dJ2x/VRhrWU9g6QLkLHuA+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaN4X9ehCB8aoziIUR+6J40aom9CunlsTwaCjx7iCdgzEG8qrgd99Hms9A/LxBd/wzYchuobx6Z8dUaFDNSgJwzSmyVG2CENzIf/qaCqoGrRpjAaOMQLpUqJRR8jy26JHFDFQycgylhy340qS4lnX7GfoIKJi1iZe/KW4Us9Iow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqs7c+Qv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso1505108a12.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771781567; x=1772386367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wImU8utWXre1Uxo904gEyPqXxKNFzEXRXMuF4CHFNE=;
        b=Wqs7c+Qv6EJG//0TZ8uia4pjvAx3aW9zFICvglDd79CYOGlLAmkSvlaqNP3Ka6YCjF
         1YMBUzwHuIu31pFI9LoRFt2BPDoMKAiMACh+jh/4N1j/pxHx9G9u8/Jw9/EjkSDnfeX/
         KPlWNR8ISGxTADV3uguVE/qG7uAg0MNz+FFoSJGtxunmZNsZxdkWm/F/GPpJfmwvjnXU
         ozCUyC/nrNt7/pqRbGPxXXyHN1a5/2ye/ffITBKgW+IB9UTJO2vCdbBdY1JyBo4IpuTp
         fjDB4fYnfEvGuKoskXm9fgzCp8RalRs6F/X5wo0nCrhadhtylvW4rpuHEEpEzRyauZJ4
         qBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771781567; x=1772386367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wImU8utWXre1Uxo904gEyPqXxKNFzEXRXMuF4CHFNE=;
        b=F6GwvmTZD3wsBwp8rWVbPVDYpG2sRPCdqQ/CitwqVQM+pKJJv2xbqPZUmYhw7kgKX9
         EiS8dHn58qGx8qsugJ9FipgAqUlxyaOSy2Tk9kjc6OJCcCfoChp+81d+d3AZtxrW4Aj/
         BZLCf2xtWXyDyNAW9UaFaBlygn/d1MNdI+vdZL38xC3N3p33LNwPflgK5en5FAhiB9NM
         Zv1jF8Wu0LchELSHbETvXyHpyonYYrjm6IAJim5+xkgMnykFYWFAHaACLWaTNK9iWaRT
         o97i5aCVPv3ytnD4ip9tdRUwKia4nzISHhj29IL4z3uUpv4BXGQZe2sW83LZlxqZ0rp9
         yYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt4glRXIcgToDgicMtlMgPIJKHTgH5sHaJNN5btULwiRo8LhRJ31TvFIqQCs/cjyLftlDLq6M3Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqrtk84iz60Ts1oHPxl6Ax4C220psbXaeo5lzZ/yAZWAWmsEb
	qzgITYLPrFfMWSYoUhozu3YsuVapXxVnHEQUuWWO5ERRrCZPpLe81SSc
X-Gm-Gg: AZuq6aIJify2q7XnLCM5AcA/P6he3l3q6BJMjXVw77JjaV8nikae19l+cDQqpAOO+Ku
	LkJ4HgyfCSuGNnRUhUJAFjA0g4VSGWYCM+w7krWKurnpScI3BRXpJsEjMKV+lXXW6lZa4er/dKw
	3TsxZJWkJ4VQlJXvl3npJfSbcWOKzP5UFGwGYGoDOmRw6N2JbIhGifMPPJnu2Zz0piNE+Zxs+2Z
	Cmlku+gYt7LBdaemKCqkCEraovTVyl+wDY41W7WrDp3pvw2yhZVXYUOW5AzgiBGvLxYA+njbVGb
	AokjJ9Om3BbxZhNp4UJDBe1ksuKJWdJ6opm/uCmmbO8vakAIBb6wzA6AmdnIt+/937Yfw5bFGlg
	x70vxWfrt4Vz9sVtIOf0kNX2y6CPH5H2C3MRJDDtEn1AjT1rf9oxT3XdTkPGhc1/jCN4wb1ZF9+
	YKMlP/E9nW+IoDkQXxWJokdZbkzEd7TgD1v+kwEoI95jDF7cu9CbZl3i9gd3CLTwluNKhx63Ydb
	X9yLzDuHe6OPJcDPB/060anXPEsLFGE/NO9
X-Received: by 2002:a05:6a20:3d19:b0:394:6344:e5c4 with SMTP id adf61e73a8af0-39545dc00f1mr5380438637.3.1771781566900;
        Sun, 22 Feb 2026 09:32:46 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b726cbf2sm5275750a12.34.2026.02.22.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 09:32:46 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	laurent@vivier.eu,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 2/2] m68k: virt: Switch to qemu-virt-ctrl driver
Date: Sun, 22 Feb 2026 17:32:25 +0000
Message-ID: <20260222173225.1105572-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
In-Reply-To: <20260222173225.1105572-1-visitorckw@gmail.com>
References: <20260222173225.1105572-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,0x0f.com,vivier.eu,vger.kernel.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-42980-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57FDF16FEFA
X-Rspamd-Action: no action

Register the "qemu-virt-ctrl" platform device during board
initialization to utilize the new generic power/reset driver.

Consequently, remove the legacy reset and power-off implementations
specific to the virt machine. The platform's mach_reset callback is
updated to call do_kernel_restart(), bridging the legacy m68k reboot
path to the generic kernel restart handler framework for this machine.

To prevent any regressions in reboot or power-off functionality when
the driver is not built-in, explicitly select POWER_RESET and
POWER_RESET_QEMU_VIRT_CTRL for the VIRT machine in Kconfig.machine.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Add 'select POWER_RESET' and 'select POWER_RESET_QEMU_VIRT_CTRL' in
  Kconfig.machine to avoid restart/power-off regressions.

 arch/m68k/Kconfig.machine |  2 ++
 arch/m68k/virt/config.c   | 42 +--------------------------------------
 arch/m68k/virt/platform.c | 20 ++++++++++++++++---
 3 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index de39f23b180e..624e6b27f394 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -133,6 +133,8 @@ config VIRT
 	select GOLDFISH_TIMER
 	select GOLDFISH_TTY
 	select M68040
+	select POWER_RESET
+	select POWER_RESET_QEMU_VIRT_CTRL
 	select RTC_CLASS
 	select RTC_DRV_GOLDFISH
 	select TTY
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 632ba200ad42..b338e2a8da6a 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -13,18 +13,6 @@
 
 struct virt_booter_data virt_bi_data;
 
-#define VIRT_CTRL_REG_FEATURES	0x00
-#define VIRT_CTRL_REG_CMD	0x04
-
-static struct resource ctrlres;
-
-enum {
-	CMD_NOOP,
-	CMD_RESET,
-	CMD_HALT,
-	CMD_PANIC,
-};
-
 static void virt_get_model(char *str)
 {
 	/* str is 80 characters long */
@@ -33,25 +21,9 @@ static void virt_get_model(char *str)
 		(u8)(virt_bi_data.qemu_version >> 16),
 		(u8)(virt_bi_data.qemu_version >> 8));
 }
-
-static void virt_halt(void)
-{
-	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
-
-	iowrite32be(CMD_HALT, base + VIRT_CTRL_REG_CMD);
-	local_irq_disable();
-	while (1)
-		;
-}
-
 static void virt_reset(void)
 {
-	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
-
-	iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
-	local_irq_disable();
-	while (1)
-		;
+	do_kernel_restart(NULL);
 }
 
 /*
@@ -113,20 +85,8 @@ void __init config_virt(void)
 		 virt_bi_data.tty.mmio);
 	setup_earlycon(earlycon);
 
-	ctrlres = (struct resource)
-		   DEFINE_RES_MEM_NAMED(virt_bi_data.ctrl.mmio, 0x100,
-					"virtctrl");
-
-	if (request_resource(&iomem_resource, &ctrlres)) {
-		pr_err("Cannot allocate virt controller resource\n");
-		return;
-	}
-
 	mach_init_IRQ = virt_init_IRQ;
 	mach_sched_init = virt_sched_init;
 	mach_get_model = virt_get_model;
 	mach_reset = virt_reset;
-	mach_halt = virt_halt;
-
-	register_platform_power_off(virt_halt);
 }
diff --git a/arch/m68k/virt/platform.c b/arch/m68k/virt/platform.c
index 1560c4140ab9..764f556b4b32 100644
--- a/arch/m68k/virt/platform.c
+++ b/arch/m68k/virt/platform.c
@@ -30,7 +30,10 @@ static int __init virt_platform_init(void)
 		DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
 		DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
 	};
-	struct platform_device *pdev1, *pdev2;
+	const struct resource virt_ctrl_res[] = {
+		DEFINE_RES_MEM(virt_bi_data.ctrl.mmio, 0x100),
+	};
+	struct platform_device *pdev1, *pdev2, *pdev3;
 	struct platform_device *pdevs[VIRTIO_BUS_NB];
 	unsigned int i;
 	int ret = 0;
@@ -57,19 +60,30 @@ static int __init virt_platform_init(void)
 		goto err_unregister_tty;
 	}
 
+	pdev3 = platform_device_register_simple("qemu-virt-ctrl",
+						PLATFORM_DEVID_NONE,
+						virt_ctrl_res,
+						ARRAY_SIZE(virt_ctrl_res));
+	if (IS_ERR(pdev3)) {
+		ret = PTR_ERR(pdev3);
+		goto err_unregister_rtc;
+	}
+
 	for (i = 0; i < VIRTIO_BUS_NB; i++) {
 		pdevs[i] = virt_virtio_init(i);
 		if (IS_ERR(pdevs[i])) {
 			ret = PTR_ERR(pdevs[i]);
-			goto err_unregister_rtc_virtio;
+			goto err_unregister_virtio;
 		}
 	}
 
 	return 0;
 
-err_unregister_rtc_virtio:
+err_unregister_virtio:
 	while (i > 0)
 		platform_device_unregister(pdevs[--i]);
+	platform_device_unregister(pdev3);
+err_unregister_rtc:
 	platform_device_unregister(pdev2);
 err_unregister_tty:
 	platform_device_unregister(pdev1);
-- 
2.53.0.345.g96ddfc5eaa-goog


