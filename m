Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8C549C8F5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 12:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiAZLpl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 06:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiAZLph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 06:45:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8205C061748
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 03:45:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so4345619pjj.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 03:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lyNDT6gMUVd7XADlZEueFFVmp7iqGlnv4um7W4NGQTo=;
        b=X/glJO/YXqUfegb4WPXVEs5tC0FQx5MOWhX8pyx+pqRXQiUOisuqU2dVXA01T5DC9c
         SDfhm5o7uSL9nxx4sr+5SPwCINVjHNsrdr142Jx4eYcd76Zqx8SWFZD8nNPEUvueYkAB
         AP9YiDlNKPWFur9wtrGmfKHrjiV+AYVdXRosdP2jsYeQqGJk/MjG19qyujAC9IltGfvS
         /1CLgmqFazoZ6/GjjdgLOowm5JSzoGLeCOqhMvH4dlfGl0EOVcmxHGz9xKhoBy7sW/5i
         OZ2wETRk1posLrUmU9fPqV17/10aUaaOGkit6zhYSs0CHDlv2NXZ3D7twGJaO6Jw3MY5
         B2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lyNDT6gMUVd7XADlZEueFFVmp7iqGlnv4um7W4NGQTo=;
        b=JCgejy4g8gX/yOIiJHvUIrUAXGPPOiyp+bZDpCmbpsYE2BJnyJ7TL/9wsajZMbgPAb
         2U5P6bH9Klr2BBvgS3v5Nb7q1w6XIphvhXAMpANgplz9CeHoZW+QuEYaovYxerd0kad/
         itJDVDtO72J1/kzZbYUEuhATyYw33GLOTDCTYhRJK97bk8w4Z3QzmzRNmVt1byKEkey0
         vMmZSnNjpvaiwlRBq8vpRLBbRuS+HA2V1o/DftEBTOHq1S3itpSMrC9/cJ4Q5FQsgp0X
         UAJboggQTb4Tz8LurRlctpigEh6NQqrFyML4QcH9NReUHTtADGZPpeZhNZa9otne3n1P
         2CHA==
X-Gm-Message-State: AOAM533GSEuWVvWf67VXOGMFaC4sAlNZAqj884/PzI5oWkz7IXUaLsvA
        zisHWTDL31EJYmbPIsI4s+0SOw==
X-Google-Smtp-Source: ABdhPJzar3JqtFOygpsMZMlMib3kuQuQ5BO1QD+6o2GkOnwRAIT8zA+tjj+e5DF9gaRHipW3gQZ1pw==
X-Received: by 2002:a17:90a:c901:: with SMTP id v1mr8224362pjt.203.1643197536474;
        Wed, 26 Jan 2022 03:45:36 -0800 (PST)
Received: from localhost.localdomain ([122.167.221.23])
        by smtp.gmail.com with ESMTPSA id nn2sm2994976pjb.35.2022.01.26.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:45:35 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 4/8] RISC-V: Add SBI HSM suspend related defines
Date:   Wed, 26 Jan 2022 17:14:48 +0530
Message-Id: <20220126114452.692512-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126114452.692512-1-apatel@ventanamicro.com>
References: <20220126114452.692512-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

We add defines related to SBI HSM suspend call and also
update HSM states naming as-per latest SBI specification.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
 arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
 arch/riscv/kvm/vcpu_sbi_hsm.c   |  4 ++--
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d1c37479d828..06133b4f8e20 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -71,15 +71,32 @@ enum sbi_ext_hsm_fid {
 	SBI_EXT_HSM_HART_START = 0,
 	SBI_EXT_HSM_HART_STOP,
 	SBI_EXT_HSM_HART_STATUS,
+	SBI_EXT_HSM_HART_SUSPEND,
 };
 
-enum sbi_hsm_hart_status {
-	SBI_HSM_HART_STATUS_STARTED = 0,
-	SBI_HSM_HART_STATUS_STOPPED,
-	SBI_HSM_HART_STATUS_START_PENDING,
-	SBI_HSM_HART_STATUS_STOP_PENDING,
+enum sbi_hsm_hart_state {
+	SBI_HSM_STATE_STARTED = 0,
+	SBI_HSM_STATE_STOPPED,
+	SBI_HSM_STATE_START_PENDING,
+	SBI_HSM_STATE_STOP_PENDING,
+	SBI_HSM_STATE_SUSPENDED,
+	SBI_HSM_STATE_SUSPEND_PENDING,
+	SBI_HSM_STATE_RESUME_PENDING,
 };
 
+#define SBI_HSM_SUSP_BASE_MASK			0x7fffffff
+#define SBI_HSM_SUSP_NON_RET_BIT		0x80000000
+#define SBI_HSM_SUSP_PLAT_BASE			0x10000000
+
+#define SBI_HSM_SUSPEND_RET_DEFAULT		0x00000000
+#define SBI_HSM_SUSPEND_RET_PLATFORM		SBI_HSM_SUSP_PLAT_BASE
+#define SBI_HSM_SUSPEND_RET_LAST		SBI_HSM_SUSP_BASE_MASK
+#define SBI_HSM_SUSPEND_NON_RET_DEFAULT		SBI_HSM_SUSP_NON_RET_BIT
+#define SBI_HSM_SUSPEND_NON_RET_PLATFORM	(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_PLAT_BASE)
+#define SBI_HSM_SUSPEND_NON_RET_LAST		(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_BASE_MASK)
+
 enum sbi_ext_srst_fid {
 	SBI_EXT_SRST_RESET = 0,
 };
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index dae29cbfe550..2e16f6732cdf 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -111,7 +111,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
 
 	rc = sbi_hsm_hart_get_status(hartid);
 
-	if (rc == SBI_HSM_HART_STATUS_STOPPED)
+	if (rc == SBI_HSM_STATE_STOPPED)
 		return 0;
 	return rc;
 }
diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index 2e383687fa48..1ac4b2e8e4ec 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -60,9 +60,9 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
 	if (!target_vcpu)
 		return -EINVAL;
 	if (!target_vcpu->arch.power_off)
-		return SBI_HSM_HART_STATUS_STARTED;
+		return SBI_HSM_STATE_STARTED;
 	else
-		return SBI_HSM_HART_STATUS_STOPPED;
+		return SBI_HSM_STATE_STOPPED;
 }
 
 static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
-- 
2.25.1

