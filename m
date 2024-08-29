Return-Path: <linux-pm+bounces-13102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C479638DF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91DA1C22667
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 03:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6149626;
	Thu, 29 Aug 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KPD6rTw3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08B5C8EF
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902785; cv=none; b=CX39JLasPoMQgfE4AygpHDjyE3IUsK5+gpcu/aI5AunrSQMquYzTT3aH4/EDbYJRXRnN3ENnHGGWLGaIuu0O+8hq5akS1zyDXpVwMkeGlGm559H/35H863ZuVZjJtyHZ3wZ2CeyUB2WZFgULVkfpiA9Uw2OG01Ppu43jXtIfxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902785; c=relaxed/simple;
	bh=T7kgz+UReCuGs6omoj2FRqCcdPM1eQqdNBZ/9k30hFo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRWktJAnK4rI3feY1yqCom+fDLTLvWwLUGM51Vb7nBhCDBXrArNkJgDmQoVOCTRxzAM9KrkIKHiyumh+/+QIAQdu7GwwWJDUiGportwms5f04I0QPHqz4+5jczJo5OgpoLgQ29sM4s7MeuF/fenvCLnXDk3DPIP3LDugInPSHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KPD6rTw3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715abede256so156662b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724902783; x=1725507583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrwXOu6Y2eq9/DutoAmZcGJLSt10/i5s5gPboSdN3cw=;
        b=KPD6rTw3jhN4QBeEo1HWOvxoiOmLh6teQ7vIkysh50NN+rIw1DNUIzT96EHzGt72Sg
         kRz1EuD8/sw/FjY3ju92QnEpSUpsUi7/i8uscZydgdji73z9xQVnTHIYPDrx6/OMnJI3
         a4NV4SWU9t1h3yNjCLV+n7LvtJB+LjWNW8UeR1kiJa3wpP5rCeX6DTMGO1KuSD4QpiNS
         PqB+gHN4O3jaAcLqdSGivoD9Oyy8NG9Ecm5TmRQZx44bRoowOFhh/1Fj8a66L95kC8UY
         C1zTOIDTFuj3Li43ziizhtyPmBBQI9TuXHkKtN8EJ8yCzAJFXaBjdd7yDF7X6qc9vhgI
         4gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902783; x=1725507583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrwXOu6Y2eq9/DutoAmZcGJLSt10/i5s5gPboSdN3cw=;
        b=VISbfXwNllg40ue8Yzyaa4OiUR/NUW6+Q9FRVCcgwOt30HZDvnLaYEhYWLLT7ekpDk
         T8LRP49lXa/XXxUHlOHYbOu9+0ZaFNzcN2gW0u+NLT+2BM5g09ACdGC0Gffhatgd5a2l
         neeI3xP8CYv1j03impMY3iue0PGtdGcBDG3i8wdLVkCrdnOtW8ZHFM0bRBjeizZubeMv
         /s4k81QgTNmfuVw9ex+mAXBE8QRHEAii4QIVP+kKN21pm45TjNQSNimCVjSK+t6nAnp9
         zdTFKhGnq6M87n+2czckp5pFfkdvIfcra4NAQFNxa+IoyCtKDTMFbMLprofz46vX/PST
         hokg==
X-Forwarded-Encrypted: i=1; AJvYcCUIM3iUn9hZj5K+++H9wMyukXKx1pcHami5Ig3tc7yQpFrPekIS1PNfqJ0Dbcdf3H+OYbDBTKV7TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlTr2V4KyaVkk0NnPNvRai2+RxO6c4jx7UrUewLsZP6HlMNE8
	ZNipAQhoRKiDsgFEvCiNTgfED653iqz2GGY6pF5bnu2W/kJm8ravnlYSruObKKU=
X-Google-Smtp-Source: AGHT+IGCXoBvzsnohRqBHn/iqCDm2IbaqJS23BlnE45K8XNpxo0rAp13dmNYs/C4f+WCpok9krlErA==
X-Received: by 2002:a05:6a20:e617:b0:1ca:ccd1:4b33 with SMTP id adf61e73a8af0-1cce0fed420mr1740251637.7.1724902783349;
        Wed, 28 Aug 2024 20:39:43 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542498sm2056065ad.188.2024.08.28.20.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:39:43 -0700 (PDT)
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
	Nick Hu <nick.hu@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
Date: Thu, 29 Aug 2024 11:39:00 +0800
Message-Id: <20240829033904.477200-3-nick.hu@sifive.com>
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

Stop the stimecmp when the cpu is going to be off otherwise the timer
interrupt may pending while performing power down operation.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..9a6acaa8dfb0 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -32,15 +32,19 @@
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
 static bool riscv_timer_cannot_wake_cpu;
 
+static void riscv_clock_stop_stimecmp(void)
+{
+	csr_write(CSR_STIMECMP, ULONG_MAX);
+	if (IS_ENABLED(CONFIG_32BIT))
+		csr_write(CSR_STIMECMPH, ULONG_MAX);
+}
+
 static void riscv_clock_event_stop(void)
 {
-	if (static_branch_likely(&riscv_sstc_available)) {
-		csr_write(CSR_STIMECMP, ULONG_MAX);
-		if (IS_ENABLED(CONFIG_32BIT))
-			csr_write(CSR_STIMECMPH, ULONG_MAX);
-	} else {
+	if (static_branch_likely(&riscv_sstc_available))
+		riscv_clock_stop_stimecmp();
+	else
 		sbi_set_timer(U64_MAX);
-	}
 }
 
 static int riscv_clock_next_event(unsigned long delta,
@@ -126,7 +130,11 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
-	disable_percpu_irq(riscv_clock_event_irq);
+	if (static_branch_likely(&riscv_sstc_available))
+		riscv_clock_stop_stimecmp();
+	else
+		disable_percpu_irq(riscv_clock_event_irq);
+
 	return 0;
 }
 
-- 
2.34.1


