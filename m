Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315132D6B3B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 00:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgLJW56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 17:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgLJW5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 17:57:22 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911EDC0613CF;
        Thu, 10 Dec 2020 14:57:07 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so5589542pfh.7;
        Thu, 10 Dec 2020 14:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV4FwuT39LDPSHx2pYr7hgyN2X5aOJ5cTXK1x7iNdFw=;
        b=erKBhHSSFRvAb62wKlrAwAJt9MfvsYAfmx8TFxKoAs5q/NWy5nRtMiubLsOi0+8KJ7
         8cyzTT1PiE/3BA6p8fgu5KHJB5+RabxPQBXAFURqC0scLnGtomZ4s5odfMrRbi7lD2f3
         16CMKUOqbc0XD2pEhBWXjOk6eRSGx3N75/ZExYXgb6KqmrsqxwZSODAn6Vc4g6jk9RV2
         dotoeZS6HAa3+KPqi8FyV5tWD5cErHtkQ7xi85IgsWzDZKPs8sHt3GyUY9LCyDnWijqE
         UozRLuAqMgJOt+UASetUbXnqi3r4sCedBL8oLzAS3lN2ob+4ljFA1jjL8QXovtim8yHJ
         Poxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV4FwuT39LDPSHx2pYr7hgyN2X5aOJ5cTXK1x7iNdFw=;
        b=mDFyVFoqSYv8a/TDWpUtOwpeWCV9nC6Yk3m6ph6+Hi9J2ZhPuQ5jytnLVYQQ/5LozM
         aa4iWlIetgewdkzUARS2KWrWZnCH/Jw3awQABuuJdGcm0uC14zY+OY2K+xB1wz2D+bXU
         +0KiIIz0Ko5Elas6VK3py46jpkjlOpviElDoq/o2UU7f7v0BNKPwZRDVKo73GcXgu1J+
         XEQNDg5AZEucwhnBdVjPWJENHJDKJEvfVbwzOhHQwH3YLYtSZhZQF0goRig8kuFreA7v
         0OfbgNx5JfxvzTo7fRu80ouzii+/214GCUPOKA36Zl9h+Xvz0MX7Ggh/5tMt9MMwZxN3
         cF1w==
X-Gm-Message-State: AOAM532icLQvm6gqpKDxnLzMT68qz+VFdgkNJJtPyG/hQlk6g59HyfzT
        08Bgze3gW+FMp6bpivlsEZA=
X-Google-Smtp-Source: ABdhPJwIVy6CIhNci6YRZcnsHWGo5K2vf+a+JePTr0pn+J+5i1hjvWxZfBNvCkVZpv9WTAsbM7VI6Q==
X-Received: by 2002:a62:764a:0:b029:19d:9fa8:5bc6 with SMTP id r71-20020a62764a0000b029019d9fa85bc6mr341063pfc.76.1607641027057;
        Thu, 10 Dec 2020 14:57:07 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id v6sm5160381pfi.31.2020.12.10.14.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:57:06 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de
Subject: [PATCH 1/2] cpufreq: acpi-cpufreq: Re-factor overriding ACPI PSD
Date:   Fri, 11 Dec 2020 07:56:39 +0900
Message-Id: <20201210225640.317719-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210225640.317719-1-punitagrawal@gmail.com>
References: <20201210225640.317719-1-punitagrawal@gmail.com>
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
index 1e4fbb002a31..126315ad225f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -191,6 +191,20 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
 	return cpu_has(cpu, X86_FEATURE_HW_PSTATE);
 }
 
+static bool amd_override_acpi_psd(unsigned int cpu_id)
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
+	if (amd_override_acpi_psd(cpu) && !acpi_pstate_strict) {
 		cpumask_clear(policy->cpus);
 		cpumask_set_cpu(cpu, policy->cpus);
 		cpumask_copy(data->freqdomain_cpus,
-- 
2.29.2

