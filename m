Return-Path: <linux-pm+bounces-41993-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEjsCRMtgmlFQAMAu9opvQ
	(envelope-from <linux-pm+bounces-41993-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:14:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71362DC97C
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54A430E05EF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CD3D3CF9;
	Tue,  3 Feb 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZc3Lg0L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F653D3D03
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138526; cv=none; b=a1gQmzgne7Yp+S7ngBRxw0CpIlxHo/8l3SX/L8YN/D1A1HcvaUrwaXyMi9VMF2ADr3eK4yrwdhqmZYCZqZJYUpeQlGPiDj/YONoWA1/my86LuoNuqTUk15QEimVePglql5mpvEDa6zRkrUHudVvpb3l6nKCeGWqN3/i6L4M81hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138526; c=relaxed/simple;
	bh=T6tIZRJUpiLEl+8c9MJZV1DBe1EhMpSZLJGZ8wivEa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYsOF3TQhL9fZ15kR5P7Wc0Jq5uzL9IPASkXGdAKxhYqvC9KeTU8Ucjcx+GONNUZeG/+Edked/2jYOuRFap7aOSAEIBaNu2x/q4Imqcm9nY+qMYbsSZMxZ4ejNYc7sw0mfYfBeoJDeFkgglC7t0+rEi8VOgMdabFtk6X1wK3Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZc3Lg0L; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35334ea1f98so2677380a91.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 09:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138524; x=1770743324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zD7pq3hW6e61IJuUPkSkjm+44mDvpuhBJ6/ipMbijs=;
        b=LZc3Lg0LLPrtpw7Pj0uBcZmSharSXYngpdAs7UGm2bushRIDmxKpCF76vyj0BLAZHT
         mH2/nm0BX+GmBt/GcwHFiBOaSkYqyBVkZfMq3OBCBWm7plbY5M90T6h3Jok4z9leQsIz
         2kfbu7749hpwhsLbYt7EFQCzwiGCqfc1VZvbDbPyAWhBsENnWbbW6NBTBibt2anq6zkz
         YDgKxE1dmOuIdlhLc1JOTlSiOqAXirqqFF03qeXM7Au3BPLTnXKhRQq/4SKSvsZ7qbya
         27Mno0JsMe+KoQL44nEpkjR+guvcTvWGHMVv3sU02N/NVYCYBWtL6JrAuLZMz+7lNhtQ
         38GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138524; x=1770743324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zD7pq3hW6e61IJuUPkSkjm+44mDvpuhBJ6/ipMbijs=;
        b=A96kd9+tFaq8Fapa4soWUNNzhJ0wUPQDzC67cLnhQQFMgho48RC9tlmp2TzKnSQgVu
         G4lH8bYgrjEm/Bx5nH2Va19/NsvlOT5XuqViqHGcY6p/aslelP/8X3Lx+N4wi+E13DW1
         N51ktAA4Adp6HyoikDF340Vl0b9crNSvsVjpr2OlJ+BBXH9L3XngIAt5KPW5w4U2SK5t
         oEIlNdaQSoTc0ajE9mtvooWVrnR7Bhf9Z/mAPbKy5qyFmk2t6MRWAmfN/DmbTRlHSKu7
         SemnqxaAWUjaC7pRhTA+kNlRZUkeQ3O9QL4dNoUKDggUMX7MT5QO50e+Ida7wO5wJiwy
         dSrw==
X-Forwarded-Encrypted: i=1; AJvYcCWliTX9r5va1wH5jzITxGeIU6AtuMAEyejlKL2rrUgN0GeGUblxxcCxic2OaaZzd9S1sNLkiqahlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWqmT11OkiBxytwJe6Sj4bZkXbjh74QFaT67e7E9+W4xYX9WDv
	WjdUSJ2ix9FtHoyuifDijqLP8ixYvn9OQnSdw5OqORY+S9w3leruW8m8
X-Gm-Gg: AZuq6aKAfWgB7u3sC27jH89xBaTkbmLZM+KVwCNWUr7OLn4/kmzf5qg9J1YoA8eLd6W
	50uD0uvnTPMA7OqUh5NBkvasIT1pLASi2XGBOlZYQJbatTKqLuslVEYU3LxD+tTnJJJbk8mCgwr
	ftM9H39tgzUkdGP3/+ZqMG8d40UzxN4uPd7bCxHYWIztoaHoHPUJOlZnhzci8LERwzCDImFm0W+
	XsrlwJa4gPUMKcQZDvnRDBxh4cVH+uuEsUZAP5K9hWWVBWzAnmpWL3iq83HQm3o/S38tJ5rA9su
	m76e5+uuq0V81gLdLCeNGFRYztFo7gEFTTwfKnV3wZZ19Nq00AkW7WIH88UwA2j7fh3ZiDk5Xfm
	wei1c5rGT71bQD+nftGsVXBjjTIQBQxE2Gs8n5T/GE9sofaJqNKQjXP68twazxgs3+UzHU2lCcM
	5vlEVxYMeOyxMGKhXSDJOS2ZftlQ/1YGtekTKUKmGPYTGExU6Q0DZJuhaAgs+jUWKwYlILXKoTt
	V1znfGXi+dXUVcmPBWg9UZND2E=
X-Received: by 2002:a17:90b:3905:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-3543b3b21d6mr15984672a91.17.1770138523661;
        Tue, 03 Feb 2026 09:08:43 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (118.239.201.35.bc.googleusercontent.com. [35.201.239.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548633616csm177520a91.17.2026.02.03.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:08:43 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] m68k: virt: Switch to qemu-virt-ctrl driver
Date: Tue,  3 Feb 2026 17:08:24 +0000
Message-ID: <20260203170824.2968045-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
In-Reply-To: <20260203170824.2968045-1-visitorckw@gmail.com>
References: <20260203170824.2968045-1-visitorckw@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,0x0f.com,vger.kernel.org,lists.linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41993-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 71362DC97C
X-Rspamd-Action: no action

Register the "qemu-virt-ctrl" platform device during board
initialization to utilize the new generic power/reset driver.

Consequently, remove the legacy reset and power-off implementations
specific to the virt machine. The platform's mach_reset callback is
updated to call do_kernel_restart(), bridging the legacy m68k reboot
path to the generic kernel restart handler framework for this machine.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
No Changes in v2.

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
2.53.0.rc1.225.gd81095ad13-goog


