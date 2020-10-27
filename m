Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C458629A577
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 08:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507592AbgJ0HZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 03:25:06 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:41056 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507589AbgJ0HZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 03:25:05 -0400
Received: by mail-yb1-f202.google.com with SMTP id c9so480927ybs.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6rOIjCU41RmBcOLQKBev/ecK/YxKmDMIy5ABsxdSYCE=;
        b=QrX7cXKrWwhToRwCILi0aJLfIUraRa7nc85z1nt+jfZWEBJ05TVAqrwtwoFfuEbTzJ
         dHEJIAmqmW0vI1ezGGRXxmwgUTJSvxLj3EG7JgaCHzu3ryA/vG60/geB33kNOakoipyL
         FcrN9CPKwRJzXRCM2O/rIUaF0kX4viQCXDhCQ5ZhPo4CSuDvjMZ1hkR6c9eGhCO48VO6
         43qaZAn0QnNGDCBBzDl3jlGZ3C8q44/yripuJIqcXI2/2Ezy6qvG1gJEoYNqpbtwICLa
         wFWZNt9Xe7w5p1CuCEYX3MOfE9FAWII7fhepQTeDIYTiv5ja6Z86obJJxCZZZcf+kVGB
         dvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6rOIjCU41RmBcOLQKBev/ecK/YxKmDMIy5ABsxdSYCE=;
        b=KG6rEes8v8NNn6RUg26qYPAicgF2753/cy5vNnfQL0BR9pJjHkgxM/x5+TMZ18HaxQ
         vU3INc9J4UZ7JnjZire9QeHNVVoXgGZNtDwY7e1nRK2sufBqErxtB2xbyY8LnsXXNJBF
         rplmjgwv3EN+g3rB67BlF5JD7JEEnAg2x1FugJm/ko/rA1YC7hdwN/THpC3vp6KqIUvt
         GBM65sC/cyl741VZfblO8O+TdP27gDqz+LrnOxEBdOuS1cO7gwihHmsQVz1dvmV3Oroh
         RYXivxXlKPjo+MPudZSgiLI6xa06Mh8vW8cKRYleLNDJjs39j2CvRwioe6q9XQnHJq9X
         eVVA==
X-Gm-Message-State: AOAM531fOoSPecqRzlXMGKQHTwr+EJ19AhZL4+D+CTyZ1JX9ZgL3YCaO
        pWcJYvE3hKFJQ4OefzaG9GJ5imU/Ey7kuw+U
X-Google-Smtp-Source: ABdhPJxGQbOMLGXGj3UgCL6+1wWQWGlw+40OKZUZ688ahZtZZ3L7CpQeNb49i6nF0XZafiTvD/wCOxoPjxL/x+9A
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:a25:bd0c:: with SMTP id
 f12mr1215275ybk.3.1603783504108; Tue, 27 Oct 2020 00:25:04 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:23:56 +0000
In-Reply-To: <20201027072358.13725-1-victording@google.com>
Message-Id: <20201027072358.13725-4-victording@google.com>
Mime-Version: 1.0
References: <20201027072358.13725-1-victording@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 3/4] powercap: Add AMD Fam17h RAPL support
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Victor Ding <victording@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch enables AMD Fam17h RAPL support for the power capping
framework. The support is as per AMD Fam17h Model31h (Zen2) and
model 00-ffh (Zen1) PPR.

Tested by comparing the results of following two sysfs entries and the
values directly read from corresponding MSRs via /dev/cpu/[x]/msr:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj

Signed-off-by: Victor Ding <victording@google.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>


---

Changes in v3:
By Victor Ding <victording@google.com>
 - Rebased to the latest code.
 - Created a new rapl_defaults for AMD CPUs.
 - Removed redundant setting to zeros.
 - Stopped using the fake power limit domain 1.

Changes in v2:
By Kim Phillips <kim.phillips@amd.com>:
 - Added Kim's Acked-by.
 - Added Daniel Lezcano to Cc.
 - (No code change).

 arch/x86/include/asm/msr-index.h     |  1 +
 drivers/powercap/intel_rapl_common.c |  6 ++++++
 drivers/powercap/intel_rapl_msr.c    | 20 +++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 21917e134ad4..c36a083c8ec0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -327,6 +327,7 @@
 #define MSR_PP1_POLICY			0x00000642
 
 #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+#define MSR_AMD_CORE_ENERGY_STATUS		0xc001029a
 #define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 
 /* Config TDP MSRs */
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 0b2830efc574..bedd780bed12 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1011,6 +1011,10 @@ static const struct rapl_defaults rapl_defaults_cht = {
 	.compute_time_window = rapl_compute_time_window_atom,
 };
 
+static const struct rapl_defaults rapl_defaults_amd = {
+	.check_unit = rapl_check_unit_core,
+};
+
 static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
@@ -1061,6 +1065,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index a819b3b89b2f..78213d4b5b16 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -49,6 +49,14 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 	.limits[RAPL_DOMAIN_PLATFORM] = 2,
 };
 
+static struct rapl_if_priv rapl_msr_priv_amd = {
+	.reg_unit = MSR_AMD_RAPL_POWER_UNIT,
+	.regs[RAPL_DOMAIN_PACKAGE] = {
+		0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PP0] = {
+		0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
+};
+
 /* Handles CPU hotplug on multi-socket systems.
  * If a CPU goes online as the first CPU of the physical package
  * we add the RAPL package to the system. Similarly, when the last
@@ -138,7 +146,17 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
 	int ret;
 
-	rapl_msr_priv = &rapl_msr_priv_intel;
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		rapl_msr_priv = &rapl_msr_priv_intel;
+		break;
+	case X86_VENDOR_AMD:
+		rapl_msr_priv = &rapl_msr_priv_amd;
+		break;
+	default:
+		pr_err("intel-rapl does not support CPU vendor %d\n", boot_cpu_data.x86_vendor);
+		return -ENODEV;
+	}
 	rapl_msr_priv->read_raw = rapl_msr_read_raw;
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
-- 
2.29.0.rc2.309.g374f81d7ae-goog

