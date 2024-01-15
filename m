Return-Path: <linux-pm+bounces-2192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892D82D6E8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 11:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2DF2811BC
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2FF4FA;
	Mon, 15 Jan 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="prIktfAD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135A2BAEB
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd6dc05690so1349278b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 02:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705313476; x=1705918276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKR76xvkppExc7Ae5ic+6mPrVpT9dqve2Cn1Oe/qHYw=;
        b=prIktfADJjqu2qTrlGHTj0KZKU1jxS860clskcF1Pr1QeeiBEXNZRJYwQbqp4Cvkso
         Qjv4u0grDYKbx9Xz/aUWKBbOSaLI4Bc0MIv4daelSETymYEMg+/s1hOMfpRO5OVmgAy/
         Hb0VVH4QQVIu6+k/PIqPEhTi687kFdYycz/DjOMf1hUXxajCvhV1kNDjlgzh0PI3kqlZ
         PDNNVWXnY9o/kNazmIWRTGEJJO1Nrts1NpYdPBjyutUQQwT5W0Lz3A4aNfGDWa0dkAkv
         xJ6uxubXVI+NGAlPqG5qrQyfWiPAmVTVKE8cZlS4MTuqWuS5Sn4GGtkpyjBF21VIa1Hx
         MgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313476; x=1705918276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKR76xvkppExc7Ae5ic+6mPrVpT9dqve2Cn1Oe/qHYw=;
        b=imLumHWhvXE1jn9eEbayEiHZJmKHf9D0pCAENRyNoA2Xnf4SakYS3E8bqXyqM58T8+
         CKojzDqbFHot39PEZNeKf7WDCHvK0Jlt31jdcun90KVBJTQWatlIYXwQc37fsJ2/dSQg
         wrYpq3/setKspSa8nBrbXaXp6huMI98hsrMAB/qXMmvRV6EZtpntEtc64LocKZM3U4Tk
         sB4dUYlIlGxFt5JebREJyXS3FnSwc63QaEi/Gcog85AA6sybA+3QcnbsyLiBgbA01/+f
         3LTWH4H4byz2dDUJ+5pc2z/GqrYdRm3BQ7dm4OFl0K7esoz2CukPI2aeYD3RCUKVMOpj
         HUiA==
X-Gm-Message-State: AOJu0YxusMuJLkJWTz8tquVqc7q8fVzjQQd5WGpUOjLNdpe0ElJJS2Jl
	4r5xDCCUkTi6B1eXnlPlCr8DZxWxsVeg5w==
X-Google-Smtp-Source: AGHT+IGWojS8RsJT/iDe5Ctvj5HBEJFzGZS/l46ZI7pdhdk1JBFy+CjL4CsRK1CYjAHvPpRJ4by1hw==
X-Received: by 2002:a05:6808:152b:b0:3bb:edf8:c497 with SMTP id u43-20020a056808152b00b003bbedf8c497mr7585343oiw.71.1705313476617;
        Mon, 15 Jan 2024 02:11:16 -0800 (PST)
Received: from localhost.localdomain ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b006d9b8572e77sm7348256pfm.120.2024.01.15.02.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:11:16 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Pavel Machek <pavel@ucw.cz>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 2/3] ACPI: RISC-V: Add LPI driver
Date: Mon, 15 Jan 2024 15:40:55 +0530
Message-Id: <20240115101056.429471-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115101056.429471-1-sunilvl@ventanamicro.com>
References: <20240115101056.429471-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Low Power Idle (LPI) based cpuidle driver for RISC-V platforms.
It depends on SBI HSM calls for idle state transitions.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile  |  3 +-
 drivers/acpi/riscv/cpuidle.c | 81 ++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/cpuidle.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 8b3b126e0b94..7309d92dd477 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o
+obj-y					+= rhct.o
+obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
new file mode 100644
index 000000000000..052ec3942902
--- /dev/null
+++ b/drivers/acpi/riscv/cpuidle.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpuidle.h>
+#include <linux/suspend.h>
+#include <asm/cpuidle.h>
+#include <asm/sbi.h>
+#include <asm/suspend.h>
+
+#define RISCV_FFH_LPI_TYPE_MASK	GENMASK_ULL(63, 60)
+#define RISCV_FFH_LPI_RSVD_MASK	GENMASK_ULL(59, 32)
+
+#define RISCV_FFH_LPI_TYPE_SBI	BIT_ULL(60)
+
+static int acpi_cpu_init_idle(unsigned int cpu)
+{
+	int i;
+	struct acpi_lpi_state *lpi;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
+
+	if (!is_sbi_hsm_supported())
+		return -ENODEV;
+
+	if (pr->power.count <= 1)
+		return -ENODEV;
+
+	for (i = 1; i < pr->power.count; i++) {
+		u32 state;
+
+		lpi = &pr->power.lpi_states[i];
+
+		/*
+		 * Validate Entry Method as per FFH spec.
+		 * bits[63:60] should be 0x1
+		 * bits[59:32] should be 0x0
+		 * bits[31:0] represent a SBI power_state
+		 */
+		if (((lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI) ||
+		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
+			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
+			return -EINVAL;
+		}
+
+		state = lpi->address;
+		if (!sbi_suspend_state_is_valid(state)) {
+			pr_warn("Invalid SBI power state %#x\n", state);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return acpi_cpu_init_idle(cpu);
+}
+
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+{
+	u32 state = lpi->address;
+
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
+						   lpi->index,
+						   state);
+	else
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
+							     lpi->index,
+							     state);
+}
-- 
2.34.1


