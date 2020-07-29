Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC93231CF6
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgG2Kwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2Kwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 06:52:35 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FBC0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 03:52:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j8so13033023qvu.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 03:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VdvFgU2sJajZQhv3MVeiLmUvHk37Zjgz6OyvSzeJgPI=;
        b=VH5vh/h1CiQfGCWkgXImQT9oye7oyZd7c/0RHFe5kCvjyEHi8SZqVsYVK3FzkSMEHc
         CEe1qOhBCT1n50JP4yH8vtSkP078jQ/EJVp1f/8qbRdugGfpmofvtdEgFpZzFcOIED4B
         M+KzbyZ+tvs2VQiPMe6iEzRnPyDOP23GrahJaX5PXNHJxTkw+aP7qAAx/Q/heLxvpDN1
         /Ae+V0g+QucjPDoDgLxIduaBk1Vlpb8I+Ch8ChqvGpGk9+MS6e38s7Lh6kJ3Nwgb2gwS
         gOt7jv6yrotV1bXbuE52ftjFPKgXTJULkEx5B3riqwXE/Xg98Dd2AL2F9pQCTz9U7lyP
         pBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VdvFgU2sJajZQhv3MVeiLmUvHk37Zjgz6OyvSzeJgPI=;
        b=Napuq24y2F64mukWmhRg1w1bm2H02sofxgyG0HQWCCQKjhidHwe7PAPR6L6b9mSBYE
         bmP7cr7GnhDVmcTrqG4BffWVp4Y+2Hm2WSTB07nG0M45gt6ANM4taueBj2qU9txcmQ4p
         5VfbkUtDjrz13mEMH5vcnThcvzrp8vp5Nx6a0ofQsA16xPbRIKvd8D3iNIMji8ORL0q5
         BG8FDo9eRV6B6tkLFFm4bcDa64gTuvT/KdjJHKLhQ56yXJ8skAxzYw2Uehm8yuw9Y4rK
         n+IH68SgL+gX8a+s10Jh0XjpiMqBQ1558zUfPGkJirDraq57ZDdF+yokf/HOqLzCQtA3
         ujQg==
X-Gm-Message-State: AOAM533jTRpAymdOoueJpUba0BVJJ6dVz4lrVBPJ/2DJM+2+9IbDc/fr
        uKjFEZsA3N6BTtMj7k4EceoUb0UbnHY8YFVj
X-Google-Smtp-Source: ABdhPJzrjvNW+LcyVgXeMphH9MDQ9h2e+pswLPo96f6zIMh99r83nvSU7HUjLd/mvwbwHf5YpATud9FHal58LYu1
X-Received: by 2002:a0c:aedf:: with SMTP id n31mr1300551qvd.16.1596019954867;
 Wed, 29 Jul 2020 03:52:34 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:52:06 +1000
In-Reply-To: <20200729105206.2991064-1-victording@google.com>
Message-Id: <20200729205144.3.I01b89fb23d7498521c84cfdf417450cbbfca46bb@changeid>
Mime-Version: 1.0
References: <20200729105206.2991064-1-victording@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 3/3] powercap: Add AMD Fam17h RAPL support
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Victor Ding <victording@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
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
---

 arch/x86/include/asm/msr-index.h     |  1 +
 drivers/powercap/intel_rapl_common.c |  2 ++
 drivers/powercap/intel_rapl_msr.c    | 27 ++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c5e92317356e..533208998297 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -306,6 +306,7 @@
 #define MSR_PP1_POLICY			0x00000642
 
 #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+#define MSR_AMD_CORE_ENERGY_STATUS	0xc001029a
 #define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 
 /* Config TDP MSRs */
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 61a63a16b5e7..8ca4413ef2de 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -992,6 +992,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 430b4819d6ab..31d10a169e41 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -47,6 +47,21 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 	.limits[RAPL_DOMAIN_PACKAGE] = 2,
 };
 
+static struct rapl_if_priv rapl_msr_priv_amd = {
+	.reg_unit = MSR_AMD_RAPL_POWER_UNIT,
+	.regs[RAPL_DOMAIN_PACKAGE] = {
+		0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PP0] = {
+		0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PP1] = {
+		0, 0, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_DRAM] = {
+		0, 0, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PLATFORM] = {
+		0, 0, 0, 0, 0},
+	.limits[RAPL_DOMAIN_PACKAGE] = 1,
+};
+
 /* Handles CPU hotplug on multi-socket systems.
  * If a CPU goes online as the first CPU of the physical package
  * we add the RAPL package to the system. Similarly, when the last
@@ -129,7 +144,17 @@ static int rapl_msr_probe(struct platform_device *pdev)
 {
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
2.28.0.rc0.142.g3c755180ce-goog

