Return-Path: <linux-pm+bounces-13101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 486459638DD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA911C2242A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 03:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0949637;
	Thu, 29 Aug 2024 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QqROOwUh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F44962C
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902778; cv=none; b=P+Tx9YE1qePG9+WtUws3TuT9r3CwafrEWIgUsm9IE03jy6d9zqzeJvJoXITTSPOJOg4CElGj8sTV4/16O3z9c32EqvtVtYGGVdrsgblV435fqOe9uqwuFUgvxV1ZPcezE6dVf/Rv4Mr0pWaqfmDIJOqsCQ90FJ1mQYMbcKfw34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902778; c=relaxed/simple;
	bh=EbBEvc0PKXsSnG7+GH+yqgj1djjwXCeEDQP2lGPTKew=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDpXAY+9S9jn9bx/X3CmZIQDlSJWxPvSSQ8zj533DUaOVjqJ7vxQA1NS9vFpQOMn4Ywtpusq1D0iHF1lrbcX5chlOeoUGNI+Ok/yBpt7MhHlT+hL+W6/b5gBV6suPy5hIYQ0pgmH+xSAhzgRnqKG2LTLG6v1cqmtjW2WhQBIDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QqROOwUh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2023dd9b86aso1257255ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724902776; x=1725507576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3GAnBxuP0k13UOo0B/EnxeGCQ0ew6a+lFlFL3wfeVM=;
        b=QqROOwUhd5EyI5k97vdfTkdEbkoipbTIKQcIHtHtNtqnh3kcM0V7/I4b1QclvIfoqz
         h0ISggYy6MbUl1T5KqsdNOGETszwXJCVl4LuOr8BbUkL6Hk+EuCAiUvMEo2APzKgCLDl
         ATDqmdAzDUsq48LjyWozoSSkXIEWegS852/EneBDlnJfzeF1WeZJXPtMq28hlKhLhv/1
         YInDuysa6n90K98yGymmduRaCcRLqQk3vnZuh2sQK8+kzqrjgR1HWSrapuHl6qIQJ64x
         jRr29aMM8XgcpIkZhNark9BJVRLj/Tvh5qj8GNo5IQRZUmTTiu079v++CQYl+aMOU+2e
         08dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902776; x=1725507576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3GAnBxuP0k13UOo0B/EnxeGCQ0ew6a+lFlFL3wfeVM=;
        b=JFd6qhtobw0pbR8g+sS+Ke2iz0L9X3lv5xxjeF6Ywimozi1Yy+WvFLh1lxn6QLl1M0
         npSZL9HzL3Xm3YsVaj22jlSloL+bScbn6Jw6WA7eibvsBRNxbjIqmwtqXWgLuMF2e83K
         MhVUzibyJCG2JdDDBMzvlfR2chWrHGxDbehfk4+b0sernuKmX+H54GNkJI68RdkYS5Fh
         7Oy9U/lopMMUmzN8H2MMAILd1/e/JGjPrcZcAvjPuTOEUOKL6LvbwjiCYRma+hfDHLSS
         gufVqgOmt8v7kF/3aw5Fzc4fgoJhRESehcgKtwKSIBbZFCPAsAN3YBigCgzcqSt1KpJv
         P/RA==
X-Forwarded-Encrypted: i=1; AJvYcCVRsUNiGrcSI2PjJmXuuDVWM/rtwethi42ppFiZmOwkWf8U7m6BlMT+VIxYcwtxucYb+GEF+kmg2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaYq/zwiMlpHywez4V8hagozaFZ2UmKcQSkjfMOdUNg3f+6xF
	DNjfzGiV3LkAiWBdp7blS2OxtWzSgCYUbcYLCg9Ly92cQDPqgu+hUQZeZXk1eUI=
X-Google-Smtp-Source: AGHT+IH/8fsuBgr/qoojKI4pyRmSBKKLvKU8OllZIsbVlPHRLEjgz17SXXEQ34o9DYQ5ZzKFjsFW3Q==
X-Received: by 2002:a17:902:d50d:b0:202:5075:428d with SMTP id d9443c01a7336-2050c4b6ca4mr16399455ad.64.1724902775824;
        Wed, 28 Aug 2024 20:39:35 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542498sm2056065ad.188.2024.08.28.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:39:35 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: Add stimecmp save and restore
Date: Thu, 29 Aug 2024 11:38:59 +0800
Message-Id: <20240829033904.477200-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829033904.477200-1-nick.hu@sifive.com>
References: <20240829033904.477200-1-nick.hu@sifive.com>
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
 arch/riscv/kernel/suspend.c      | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..ffaac2efabb5 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -16,6 +16,10 @@ struct suspend_context {
 	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
+#if __riscv_xlen < 64
+	unsigned long stimecmph;
+#endif
+	unsigned long stimecmp;
 #ifdef CONFIG_MMU
 	unsigned long satp;
 #endif
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index c8cec0cc5833..3afd86e1abf7 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -19,6 +19,12 @@ void suspend_save_csrs(struct suspend_context *context)
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
 
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		context->stimecmp = csr_read(CSR_STIMECMP);
+#if __riscv_xlen < 64
+		context->stimecmph = csr_read(CSR_STIMECMPH);
+#endif
+	}
 	/*
 	 * No need to save/restore IP CSR (i.e. MIP or SIP) because:
 	 *
@@ -42,6 +48,13 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
 
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		csr_write(CSR_STIMECMP, context->stimecmp);
+#if __riscv_xlen < 64
+		csr_write(CSR_STIMECMPH, context->stimecmph);
+#endif
+	}
+
 #ifdef CONFIG_MMU
 	csr_write(CSR_SATP, context->satp);
 #endif
-- 
2.34.1


