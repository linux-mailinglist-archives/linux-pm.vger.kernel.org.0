Return-Path: <linux-pm+bounces-40686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1417D14C2F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 19:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4307E30F6034
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88238759C;
	Mon, 12 Jan 2026 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU+O4RXk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3ED387583
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242207; cv=none; b=LR3RiUKiKphrL6MByOE5KmLU8Mxb6CR8c1ULkB4EeknibYMA1FUKR6N2tyCzLnT38iSg4KoAgUQQrEFT7W48NStLUaPXHLqoUXeN7YnVlAKsjOwIBuR9H+++w6aiFOaLwNFMHQehjIPf/FMTi0aAU+jzdWpfnPhFSpgdj6j9ZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242207; c=relaxed/simple;
	bh=Kxc48WP3JMgRcgbxaB+vq6PuqCnjrP3YyAQS4BlYEQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLcGCr323R94gSJ9iKnIfthNZVzroGCj3g853JAnLFhRnMf2uGCF4ijSC1jAyTRksqEUreVCQTN3juYlKKt5wmfAL7JwnMiZ8hrQce5Ug/mxB24j16WFVLLW/HZgTvoxtFPwAyUfVBNOdjbaUX1bAnC/stl8ptBFJn9rWydnA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU+O4RXk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d5c365ceso45169975ad.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768242202; x=1768847002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoCe2UhjfoZKQZoLbe4Gba2T09UGHCeiBMJ/gxSy8bI=;
        b=jU+O4RXkUvB5DFZHEAbH8NKHMRUSQMwiBgxvZn95nYz2CzeKFCPGBkUoCu2T25P8jO
         p3ue8i9VE0yYM0EBCwbBlzTQEVov4iFXEGhrcv+zQ4TB2X66wocSsJnoF2XUev+qyER2
         +cQwQuD2woHUIhvNgYQXeMQrDrxeXg/92IhrYce4hUhw4/hqifT9Iz/Yoet1orPMdolM
         3IkKKmkvqGTJ4qB4J+iv+2q/tg2It5Ty9I3SZS1VwnJSiDbWN5vOJmE1u7MxNL1/n9m3
         dYcm2E4fRfMGzCX+XathPAu1WFgJC+9oWzciVrfw28VIqDkNCsibVkytkt9npkRIA5+2
         ZKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242202; x=1768847002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoCe2UhjfoZKQZoLbe4Gba2T09UGHCeiBMJ/gxSy8bI=;
        b=LGpIGBcE11zCIDQOpSuue6vKP8lCMvE1EBo0yrgtYUHbpIqIm3/5t8NjpBnZpnfee9
         +WNauMDZi1dFKTzHfrR56iD0BQAH1HoPRTyWBSZuxUd3Rtz4+YaGfahj15vneA4KD1l/
         M1Z+R1s6Np09Wib45zCsEaMccMLJtwvvy4iNhjPw/nFCaqjwfjdq1CnTcRJBCMihJ21E
         zFmtPmVbvrF61+el/L4RabzSYRUWrJwXBryc0K6k1zK4vz5tWcanvV39FZewQVu0XMkP
         TRJar/DDvoj7pF4ebQu82YsyxlJvrJyAS8RYJNkIJG9iV07A7h1ljF82HnmC7OnzeEcE
         4iog==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5wwwTV4btR/nmVfaw80kBkpXtW7dwQZ5X4nNMi+tWwM+5DTYw2HW07cnW4BqhH0qxODVfU1A/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7MSNXqM6aczq/6j1qh07t2ECGfg4BDlM45fiphFMG9DJke9i
	UIjKg0R7l/061KEBdRa4QuuUFXM6rdHliB9gw1K0w0NvsgysHCnt6G43
X-Gm-Gg: AY/fxX7Ltus1N9alOdG9DEDfkel0WE+0AZJPABICkE/X2G2538BSZ0KbG4aiQQdktdc
	IQIFfdU5JHob0IXDOnIrqaI0Eqt6uYpZ6d02uUluLRRpPsTQ0oov6thGHka/gu1qHkFg45ixo8u
	koqdaSJSqY6pIKsHSH670Wldb04GEPn36UkoYSJtXIpiVP9j1AjZuIuIvM6IZncAZcW+yBCWlm6
	XbUPHY3Vs7pWEUSMcdFfD3f7MelNGWsUKqt8jqeXK06BbE5TCRlRTR6ms3RBzvT1b0bjPhgudwM
	jXP0R9taWQJXWSuI3qKT7deD3qsN4p8bYn57TWwIwwYz9IdZah8/MrneBP13sKSnZf/32gTj0Xu
	hLkuX3H52nlWIYgH2Qx7Zb5lGL1e9Pq+5LgMN41XPsdnSB6qixap9ZEtJF/vwUn5wrsi3F8lzI/
	aoubwyAZtnNhBF3QyG3ocyqnjmhXaqSIc/4FEaaQ2xbDtIG8k4n/jdvR88q/PIStukFAY6sEL6u
	5gYdiYaZ36nJlRQBQ0X79u9NM/N6knO
X-Google-Smtp-Source: AGHT+IFOhUPoNBwog45Pm9TL7FzCA1sp3oukPpoTWT6iUCTMKypbSZPVqb0VZiOgYc5YjqZK29Rrkw==
X-Received: by 2002:a17:903:291:b0:2a0:afeb:fbb2 with SMTP id d9443c01a7336-2a3ee4f5a79mr156866405ad.60.1768242201853;
        Mon, 12 Jan 2026 10:23:21 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc794asm180981205ad.70.2026.01.12.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:23:21 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] m68k: virt: Switch to qemu-virt-ctrl driver
Date: Mon, 12 Jan 2026 18:22:57 +0000
Message-ID: <20260112182258.1851769-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260112182258.1851769-1-visitorckw@gmail.com>
References: <20260112182258.1851769-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the "qemu-virt-ctrl" platform device during board
initialization to utilize the new generic power/reset driver.

Consequently, remove the legacy reset and power-off implementations
specific to the virt machine. The platform's mach_reset callback is
updated to call do_kernel_restart(), bridging the legacy m68k reboot
path to the generic kernel restart handler framework for this machine.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/m68k/virt/config.c   | 42 +--------------------------------------
 arch/m68k/virt/platform.c | 20 ++++++++++++++++---
 2 files changed, 18 insertions(+), 44 deletions(-)

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
2.52.0.457.g6b5491de43-goog


