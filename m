Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A192A45E4
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfHaTfU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34954 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:20 -0400
Received: by mail-io1-f66.google.com with SMTP id b10so21163226ioj.2
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=JYg10VqX7rTAkx/JExMqEMdDn29Ok8oTJWNgkcB1Vgg=;
        b=rGxCIdpLSxQu84FG9VyjvnPrTydFgBKzx4f6h+JLk7JTYwYBtTMtCf7KE8dUmsl8hK
         h6iAvlO1u2qVHeUaFfmTdZsUNj3tpe4MKj+Q5lX8LpWeT8JcQxiuFCvoiQMi/Ou2j+pX
         uoXjmXNpXMRNx/SsVso7rDLKThtM6HLz1MWzDu+DE6+gpPwxsrw4qwW/v8Ib4H8A4Ajf
         ZLhW4DEIZrV/s6+2RlBKO07irQAk8162mQvF9UYbDowgQAAx7UmkCIB8qKUydNgDhqpi
         rXVnOgLfEvxz2dYnFQrXVITmmz9Wj8yh/tmyYZVW/2QnZgdsuNs6ZeOqX+BT7R42Yx2k
         Q7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=JYg10VqX7rTAkx/JExMqEMdDn29Ok8oTJWNgkcB1Vgg=;
        b=QxKVWRYAaMXpk7RjnxB4/XBHoyo4PFCKhKTkZLWspl6h3jWpj/RJDHhfsXJR3OpM/e
         uZUIhSQgMnL8UwKtpCKATDLf0DWD2H8+F4LIrfp0sKJndofDOjZf3ujtG4clO+RAo5Fz
         pbGtVPwfjtpIKbaK+nZOyC29rCDqmrXjXvYrh5pP/2fAufyezkgtBjTREQn0ZQsCDa2b
         357Jl1tGyCnPQgDCcslibvbX0AIxDDHPhwWQ4tWlormtHxpu6CBlbwanuDZCW9ms3Y5z
         Z5SziQ8Ikr8xh2S0zAs7DPhWEHQ9nbdVTJJl2cRzJFO73hq5Q3l2PNTkq/mNjDeee8Su
         D0ig==
X-Gm-Message-State: APjAAAU+muDGZXn2wQcF30DJI2Xi2QYwD3L0NlUhogVptkcNuHSghp0g
        odhrdtX2p2wqvy/KEWiDY4QAERzs
X-Google-Smtp-Source: APXvYqxprwafgLBkOj35lQdotRs/H0J0iR3d3zx3jlujXHWkDkEf2xkX/q7UivVR4K5Zs3pTRmSwow==
X-Received: by 2002:a5d:9dc9:: with SMTP id 9mr17413524ioo.199.1567280119044;
        Sat, 31 Aug 2019 12:35:19 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:18 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 01/19] tools/power x86_energy_perf_policy: Fix "uninitialized variable" warnings at -O2
Date:   Sat, 31 Aug 2019 15:34:40 -0400
Message-Id: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190831193458.12698-1-lenb@kernel.org>
References: <20190831193458.12698-1-lenb@kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

x86_energy_perf_policy first uses __get_cpuid() to check the maximum
CPUID level and exits if it is too low.  It then assumes that later
calls will succeed (which I think is architecturally guaranteed).  It
also assumes that CPUID works at all (which is not guaranteed on
x86_32).

If optimisations are enabled, gcc warns about potentially
uninitialized variables.  Fix this by adding an exit-on-error after
every call to __get_cpuid() instead of just checking the maximum
level.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 34a796b303fe..7663abef51e9 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1259,6 +1259,15 @@ void probe_dev_msr(void)
 		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
 			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
 }
+
+static void get_cpuid_or_exit(unsigned int leaf,
+			     unsigned int *eax, unsigned int *ebx,
+			     unsigned int *ecx, unsigned int *edx)
+{
+	if (!__get_cpuid(leaf, eax, ebx, ecx, edx))
+		errx(1, "Processor not supported\n");
+}
+
 /*
  * early_cpuid()
  * initialize turbo_is_enabled, has_hwp, has_epb
@@ -1266,15 +1275,10 @@ void probe_dev_msr(void)
  */
 void early_cpuid(void)
 {
-	unsigned int eax, ebx, ecx, edx, max_level;
+	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model;
 
-	__get_cpuid(0, &max_level, &ebx, &ecx, &edx);
-
-	if (max_level < 6)
-		errx(1, "Processor not supported\n");
-
-	__get_cpuid(1, &fms, &ebx, &ecx, &edx);
+	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	if (family == 6 || family == 0xf)
@@ -1288,7 +1292,7 @@ void early_cpuid(void)
 		bdx_highest_ratio = msr & 0xFF;
 	}
 
-	__get_cpuid(0x6, &eax, &ebx, &ecx, &edx);
+	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
 	turbo_is_enabled = (eax >> 1) & 1;
 	has_hwp = (eax >> 7) & 1;
 	has_epb = (ecx >> 3) & 1;
@@ -1306,7 +1310,7 @@ void parse_cpuid(void)
 
 	eax = ebx = ecx = edx = 0;
 
-	__get_cpuid(0, &max_level, &ebx, &ecx, &edx);
+	get_cpuid_or_exit(0, &max_level, &ebx, &ecx, &edx);
 
 	if (ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e)
 		genuine_intel = 1;
@@ -1315,7 +1319,7 @@ void parse_cpuid(void)
 		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ",
 			(char *)&ebx, (char *)&edx, (char *)&ecx);
 
-	__get_cpuid(1, &fms, &ebx, &ecx, &edx);
+	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
@@ -1340,7 +1344,7 @@ void parse_cpuid(void)
 		errx(1, "CPUID: no MSR");
 
 
-	__get_cpuid(0x6, &eax, &ebx, &ecx, &edx);
+	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
 	/* turbo_is_enabled already set */
 	/* has_hwp already set */
 	has_hwp_notify = eax & (1 << 8);
-- 
2.20.1

