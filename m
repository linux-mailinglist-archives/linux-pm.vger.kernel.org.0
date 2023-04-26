Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747BD6EF93D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Apr 2023 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjDZRX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Apr 2023 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjDZRXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2023 13:23:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD08A45
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2023 10:22:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so59280215e9.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2023 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682529776; x=1685121776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao9SULoqOYHe1wb+WsMxHa64A3jFl7Peh/VgaYWCFAg=;
        b=DY+TC1OCVCIeEXaZllSL/ncia5yNDWJGP/aTOVDKSL0tq6+ubwMc0sCq5FuD/jKtCz
         fwf5cjrdRcAoOwZQUOiKkDY3XaWDu8iH5fmw2zPoTBz9pAkDbvY9XmbqZlG+O0PmUqWc
         BST2tAJzl+kEVCqIc72W9YDjuTmEgPy/aaM0pJdCPaoq8AeWzOKfQwC8/cfH9/BdSzJq
         EibxWzIKO3P2nov+P5jYIEGj0vLX1KLYAouQ/+bCBncbs6u6IdK1M6fX6gbXvjoKaQPD
         /gMVh4tj6i7mAEL2mRB0fG6UNC+nW/9tYvWW4PJ1lEfTaOsAKpTloZa38KhsfX/kmD/B
         FNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529776; x=1685121776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao9SULoqOYHe1wb+WsMxHa64A3jFl7Peh/VgaYWCFAg=;
        b=khtmIff6d4n6cPGiob8fuql2RIXvizk5HYw6w7jzyJhdXzMCllfU4KwTGnBtXsvb4n
         elhn4/tfnvYgs0KnQA4jPL2ZMvjOvOqDI0xU1y3PzK9PeD0qaDmQHmgL9Dy9CBI92i/s
         xLQkub5YYEBZqQgGpPVi2YhNN9ZqP14Lf/l0/EWsn8dFv8Qbmp4Zw+5c/crXQLzKthP5
         IDL8Os7yadRJqeZeENPU6yomT30dEUX4Ci0y7tyWbuYw5ZpeRQBhKH5APSnj72bTfgQ2
         4yIIjrlfhwzlDU9rD3LITgvw06zXOubdIqr2OaJeovMZbonmbViH38oCXa0plSkyED5Y
         SHMQ==
X-Gm-Message-State: AAQBX9eviAXxkzJNQMD2MKJoOobdcmwuFggSB/3rp3A2e6ej1Mba2w04
        DZQyLidTRJjl9XoZNk6kNgVadPGBzBR9kxETIIY=
X-Google-Smtp-Source: AKy350YDguXXIY1HG6VKKrSfWSlOGC4ugYT/K42/tDcm149Ha/AaZft7swDj2jvD5mvKlMDbOzXqZA==
X-Received: by 2002:a05:600c:d1:b0:3f1:6ec5:bc6f with SMTP id u17-20020a05600c00d100b003f16ec5bc6fmr13327077wmm.24.1682529776352;
        Wed, 26 Apr 2023 10:22:56 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d6910000000b002efdf3e5be0sm16435557wru.44.2023.04.26.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:22:55 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm-riscv@lists.infradead.org
Cc:     "'Rafael J . Wysocki '" <rafael@kernel.org>,
        'Will Deacon ' <will@kernel.org>,
        'Daniel Lezcano ' <daniel.lezcano@linaro.org>,
        'Mark Rutland ' <mark.rutland@arm.com>,
        'Atish Patra ' <atishp@atishpatra.org>,
        'Palmer Dabbelt ' <palmer@dabbelt.com>,
        'Anup Patel ' <anup@brainfault.org>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        'Albert Ou ' <aou@eecs.berkeley.edu>,
        'Paul Walmsley ' <paul.walmsley@sifive.com>
Subject: [PATCH] RISC-V: Align SBI probe implementation with spec
Date:   Wed, 26 Apr 2023 19:22:54 +0200
Message-Id: <20230426172254.70342-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sbi_probe_extension() is specified with "Returns 0 if the given SBI
extension ID (EID) is not available, or 1 if it is available unless
defined as any other non-zero value by the implementation."
Additionally, sbiret.value is a long. Fix the implementation to
ensure any nonzero long value is considered a success, rather
than only positive int values.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h        |  2 +-
 arch/riscv/kernel/cpu_ops.c         |  2 +-
 arch/riscv/kernel/sbi.c             | 17 ++++++++---------
 arch/riscv/kvm/main.c               |  2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c |  2 +-
 drivers/perf/riscv_pmu_sbi.c        |  2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 945b7be249c1..119355485703 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -296,7 +296,7 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid);
-int sbi_probe_extension(int ext);
+long sbi_probe_extension(int ext);
 
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index 8275f237a59d..eb479a88a954 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -27,7 +27,7 @@ const struct cpu_operations cpu_ops_spinwait = {
 void __init cpu_set_ops(int cpuid)
 {
 #if IS_ENABLED(CONFIG_RISCV_SBI)
-	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
+	if (sbi_probe_extension(SBI_EXT_HSM)) {
 		if (!cpuid)
 			pr_info("SBI HSM extension detected\n");
 		cpu_ops[cpuid] = &cpu_ops_sbi;
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5c87db8fdff2..015ce8eef2de 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -581,19 +581,18 @@ static void sbi_srst_power_off(void)
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
  *
- * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
+ * Return: 1 or an extension specific nonzero value if yes, 0 otherwise.
  */
-int sbi_probe_extension(int extid)
+long sbi_probe_extension(int extid)
 {
 	struct sbiret ret;
 
 	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
 			0, 0, 0, 0, 0);
 	if (!ret.error)
-		if (ret.value)
-			return ret.value;
+		return ret.value;
 
-	return -ENOTSUPP;
+	return 0;
 }
 EXPORT_SYMBOL(sbi_probe_extension);
 
@@ -665,26 +664,26 @@ void __init sbi_init(void)
 	if (!sbi_spec_is_0_1()) {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
-		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
+		if (sbi_probe_extension(SBI_EXT_TIME)) {
 			__sbi_set_timer = __sbi_set_timer_v02;
 			pr_info("SBI TIME extension detected\n");
 		} else {
 			__sbi_set_timer = __sbi_set_timer_v01;
 		}
-		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
+		if (sbi_probe_extension(SBI_EXT_IPI)) {
 			__sbi_send_ipi	= __sbi_send_ipi_v02;
 			pr_info("SBI IPI extension detected\n");
 		} else {
 			__sbi_send_ipi	= __sbi_send_ipi_v01;
 		}
-		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
+		if (sbi_probe_extension(SBI_EXT_RFENCE)) {
 			__sbi_rfence	= __sbi_rfence_v02;
 			pr_info("SBI RFENCE extension detected\n");
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
 		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
-		    (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
+		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
 			pm_power_off = sbi_srst_power_off;
 			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 41ad7639a17b..c923c113a129 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -75,7 +75,7 @@ static int __init riscv_kvm_init(void)
 		return -ENODEV;
 	}
 
-	if (sbi_probe_extension(SBI_EXT_RFENCE) <= 0) {
+	if (!sbi_probe_extension(SBI_EXT_RFENCE)) {
 		kvm_info("require SBI RFENCE extension\n");
 		return -ENODEV;
 	}
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index be383f4b6855..c6b599167036 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -613,7 +613,7 @@ static int __init sbi_cpuidle_init(void)
 	 * 2) SBI HSM extension is available
 	 */
 	if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
-	    sbi_probe_extension(SBI_EXT_HSM) <= 0) {
+	    !sbi_probe_extension(SBI_EXT_HSM)) {
 		pr_info("HSM suspend not available\n");
 		return 0;
 	}
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 70cb50fd41c2..4f3ac296b3e2 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -924,7 +924,7 @@ static int __init pmu_sbi_devinit(void)
 	struct platform_device *pdev;
 
 	if (sbi_spec_version < sbi_mk_version(0, 3) ||
-	    sbi_probe_extension(SBI_EXT_PMU) <= 0) {
+	    !sbi_probe_extension(SBI_EXT_PMU)) {
 		return 0;
 	}
 
-- 
2.39.2

