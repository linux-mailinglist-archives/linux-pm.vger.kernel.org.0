Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1102C4266
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgKYOtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKYOtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 09:49:13 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D1C0613D4;
        Wed, 25 Nov 2020 06:49:13 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c66so2544865pfa.4;
        Wed, 25 Nov 2020 06:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVPNTvoMuQocXBX6B4Z3CjlCN/T/BkddtPlKeTTNYgw=;
        b=c1itlySO2ll3i6JaldcbD1GGXWzYGcLgqRT0/m/4vT+mxLl2+NStii1ZzLi9yVoOIq
         HgECDyFXwPCsj7J4AlBmyafeGbKBMvsqJRWrVZbMl7gHslsFkxPyXoK2kCGy1f8V48yA
         Yb8EEntNmKw+sYNit4lhq/QLeevTBsBvyQF5PeAjd5ZZM37NqSDoFMlP0KPZWiHFKfkE
         2+DuQuAE+aw8KuQS8rhnyPKhes39N3Cd3eCnTteL2QuUtB7azTcC6nheJiGpMYap1vGO
         NF4uwEGBAV2kb4AItJTUP3i6mLOHQeP5SEFKH7s50XUfpO+i8u5N9yJImRw8CkMV7qmC
         UyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVPNTvoMuQocXBX6B4Z3CjlCN/T/BkddtPlKeTTNYgw=;
        b=qpKM/c0s7Tap4KlMoiWhF/QFLlIbTAA0nhFNNoh+88C07S+NE2GuVmupaLELLEScGU
         2zx+ItUKAN7H/r15MOd3+fmzowtDgdSNG/YYC5Udx0db9nmJis3f3+d3f5fUMLiRfMvK
         5nNrJLjuPgYlmar9v1O5GjLss3aCijTNB4/11BSDFMqgGsqYbuTVQdWQUQhBXcm0zTqI
         Ik8isVpaXcs+P+zbsizs186fi4A/J9gS8O4C71ZvlH8lkpXZ216JEjki03ZKjkSGqpdZ
         ynvMPJL7r4f5C9ChVXrv8HjCtEHhPkkq5mVJ1i3mjm5QxwPEprZc+or2xUBsPm3xB7vP
         Z/Xg==
X-Gm-Message-State: AOAM531nx9O9WsAhO4x1W2e3fS5Db46FY7WpYAnGq4VIMtEg2h73VZmt
        Ru1WgEUg5YK4I9DVHAXBMl0=
X-Google-Smtp-Source: ABdhPJzlfK8+AYWWfpNo1HlkFvkEmsEn6xc4TQlz2yQSxFEwjD3VFn9vxiYNF4GpO1XAt0tz7Euatg==
X-Received: by 2002:aa7:973d:0:b029:18b:23db:7711 with SMTP id k29-20020aa7973d0000b029018b23db7711mr2792467pfg.13.1606315752854;
        Wed, 25 Nov 2020 06:49:12 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id d7sm2282649pfd.214.2020.11.25.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:49:11 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org
Subject: [RFC PATCH 1/4] cpufreq: acpi-cpufreq: Re-factor overriding ACPI PSD
Date:   Wed, 25 Nov 2020 23:48:44 +0900
Message-Id: <20201125144847.3920-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125144847.3920-1-punitagrawal@gmail.com>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re-factor the code to override the firmware provided frequency domain
information (via PSD) to localise the checks in one function.

No functional change intended.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Wei Huang <wei.huang2@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 1e4fbb002a31..b1e7df96d428 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -191,6 +191,20 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
 	return cpu_has(cpu, X86_FEATURE_HW_PSTATE);
 }
 
+static int override_acpi_psd(unsigned int cpu_id)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (c->x86_vendor == X86_VENDOR_AMD) {
+		if (!check_amd_hwpstate_cpu(cpu_id))
+			return false;
+
+		return c->x86 < 0x19;
+	}
+
+	return false;
+}
+
 static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
@@ -691,8 +705,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
 	}
 
-	if (check_amd_hwpstate_cpu(cpu) && boot_cpu_data.x86 < 0x19 &&
-	    !acpi_pstate_strict) {
+	if (override_acpi_psd(cpu) && !acpi_pstate_strict) {
 		cpumask_clear(policy->cpus);
 		cpumask_set_cpu(cpu, policy->cpus);
 		cpumask_copy(data->freqdomain_cpus,
-- 
2.29.2

