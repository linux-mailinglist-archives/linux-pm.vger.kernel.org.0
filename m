Return-Path: <linux-pm+bounces-16551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A79B2391
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 04:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DD51F205A8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5483A18;
	Mon, 28 Oct 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cTo/Yzyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D85161
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086783; cv=none; b=knkfatQbTsEW8MeWqbSH5WCGw275HdOwHUnrr5S11nsk2nKlhWIqzpEHiSjZTfze5diLJJwJE4qe/1Op8UEeB7S82vdeG5D/e3/eiMYlF20ZU/VlE91TAlrQV5jqqnLS7RmoL0zwjtuxh3NpG776+i93im8AU6EDlbrQovUadZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086783; c=relaxed/simple;
	bh=IOaCLXtRKMj1XaFGEqYfcoGSRq0kGRGrZLs1Q90y+f4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu6mxf0KAh5mcv85/Fh1/v9J5naRqVSktBEdu4S4faeruA00aHllq6IeIMVqz7S4WxFe985ZM7ZvXuGIi9VJw/YF7FVwz8KyZ/IC+llLKFW+bZ5Wftqxn07MM/4zukEjEBCcXbCZkAHpTFfh31c9GhTimrTBGcYTBcKLwaa5DlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cTo/Yzyr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so2827572a91.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730086781; x=1730691581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riHqjf4TEkSfIjrBl/2OcUP/uMFiYpg8/raWLqLOU7Y=;
        b=cTo/YzyriVjyxoo3WAYLN1GXww0W6Ok830S2VEszvPSeLEvE5Kx19S0rYdQel/0nO+
         0rivDnTkqnYhCiq+jalsniPPQkqUAo0FppzWEHe1A0X4wo9Yw700UvUsbUYCk3NjlVhP
         gaXGfGS3FRpgKcOarrHr40yB/UWWCST1u/5UiPqTD9nu/JpNlJ7mfnhXFOBl4J+onS2/
         2pt5sI3WoMVdANsJzb/ilVml6FFqX88fc1b5nFAb1Xb665p4369ggB2Dg9hEVeVY//VN
         MJmXnpj5/37mjVUbn3LkCwTBBIVaMs8p8udjjKrDDyfnUcbsN8Vwig5fI4P2lUd6r6aT
         M+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086781; x=1730691581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riHqjf4TEkSfIjrBl/2OcUP/uMFiYpg8/raWLqLOU7Y=;
        b=dR1NKM7d5UsVts6xN85aZ37MJPxnEZF48eev7LJShLuMqzerXsN3tHmlYBzI4jFSvg
         OTvU3qw9wafUTDjXt4jgfK+6nqgYz1SOysZk0SbpmW8TyvzooIrkBGoy+2ihzqPFkH3h
         gdB1vHXzzkTU7nbsKk5XcCr3fkSg3Fvy6TlpdQJppud78tbYvzx/WJ8Yl7Hz8IE6KGZB
         YW8ftnAc6mkw3ZlzPCb0JYeQCq5aqc27AlECxg43TkMocjJ0gS2gxeMohWYJ67UDc+Xn
         CwEwiy+Mw/UXCA/iZnaxzo5XhNqFvlaVfgs6AaJQhwdvNfz1lCrZxvtZOMifpvp7tV3S
         aKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlV6FRbRIx1HGBkjmBXAOLNRfucgPNJ5RXSNOMrHXa2RH64idq8T7V7d+MQKbzv2+UsfWd4yST1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JL43YiD/N28jaBmWE/pGSiM7rzG4Dvm8C7F6gBDrzqJ8RsFN
	5ZZMlRCL4+1oh7dbyK4gu7IUbErbw5bFpe2wLeQFXLrbZPXJ8m17vjygnTtlHXU=
X-Google-Smtp-Source: AGHT+IFvmxoPCy/7sSomoKgH2rLyOpEyqOsKkL4VWxhavzi+tm5x5d2JksHbArO8sToXYxd+TOAmNQ==
X-Received: by 2002:a17:90a:1c16:b0:2e2:e937:7141 with SMTP id 98e67ed59e1d1-2e8f107d831mr7994236a91.20.1730086781313;
        Sun, 27 Oct 2024 20:39:41 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e340e544sm5961888a91.0.2024.10.27.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:39:41 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: Add stimecmp save and restore
Date: Mon, 28 Oct 2024 11:39:25 +0800
Message-Id: <20241028033928.223218-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028033928.223218-1-nick.hu@sifive.com>
References: <20241028033928.223218-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the HW support the SSTC extension, we should save and restore the
stimecmp register while cpu non retention suspend.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 arch/riscv/include/asm/suspend.h |  4 ++++
 arch/riscv/kernel/suspend.c      | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..dc5782b5fbad 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -18,6 +18,10 @@ struct suspend_context {
 	unsigned long ie;
 #ifdef CONFIG_MMU
 	unsigned long satp;
+	unsigned long stimecmp;
+#if __riscv_xlen < 64
+	unsigned long stimecmph;
+#endif
 #endif
 };
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 9a8a0dc035b2..24b3f57d467f 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -30,6 +30,13 @@ void suspend_save_csrs(struct suspend_context *context)
 	 */
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		context->stimecmp = csr_read(CSR_STIMECMP);
+#if __riscv_xlen < 64
+		context->stimecmph = csr_read(CSR_STIMECMPH);
+#endif
+	}
+
 	context->satp = csr_read(CSR_SATP);
 #endif
 }
@@ -43,6 +50,13 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_IE, context->ie);
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		csr_write(CSR_STIMECMP, context->stimecmp);
+#if __riscv_xlen < 64
+		csr_write(CSR_STIMECMPH, context->stimecmph);
+#endif
+	}
+
 	csr_write(CSR_SATP, context->satp);
 #endif
 }
-- 
2.34.1


