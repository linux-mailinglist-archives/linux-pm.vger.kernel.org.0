Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D33A45EE
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfHaTfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36483 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:31 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so21126549iom.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=xKyYA9KsO1EO5NoXY2+q1lFzQrl8ewmkWHBmX9CJ9h8=;
        b=Oc0WBv1wp2Th5YIHJyG27V9qkYFpqvcZcCrlwBOdKCbwI/uYeRExwIy73iZ/F6QIbU
         S0r3TFvMr4Idl3magmWf+ytjNAwv8O/DsyomJTwLiqggovTBi6kUu6Zlra4JfGy3vWsF
         9SxQoFOzkmmuZf74EFKXPM/8VOjR3/oZ4qJSKreNxRwprGQFgy6eApbOGlJVMV8KmO9X
         PrQY9zESKU95QLBUuyirTl0p//THsIh9EgmQA0sv7X3+w9sw7y2bWnwKgG11EwoQWJYc
         6T8iWGW1brhDpypeT9i7Auz7pSRQRXh5wCjHd2rJsTbbY9Y+t2rk8DYi9BV0WqIW9z3x
         YhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=xKyYA9KsO1EO5NoXY2+q1lFzQrl8ewmkWHBmX9CJ9h8=;
        b=AxCK6B2hS3qdXZTz4q8R3+g+WsJPgAFgvCXrmkow+P0ZQ8tW2kb2MKiNl4g6lI1yJp
         zjh1IDcHGYHve9clVaSpMwBjyUahV7QkjmI5FI4JVuMZh0GCEqv6gcNEKCA8kRS4t+aW
         1gRNSzVuAx3P5sO7v/RZcRtbkE3nGLsGxfkCHy0UW9yw8g18N8HuG65rO+0ov2tjG2CY
         PZ6Y0m/7wtgEXIE6qfW1FkDpGaUV3t/R43Jz/tpvwySQfy+0/Cos6KZkZk4SC/Lo2zf6
         yEUiRBakWpWiEcXz3APlUMyuT8OC47TpnpNPdbgQ+ueR/IIBS+4ceKRReWlNp5a1M6XG
         zrww==
X-Gm-Message-State: APjAAAVWzVEGTJQdCuyZgJN+PCjpoYnJVGk2QMWXsir++CMi15D8vzY/
        8bkAgWR0PhhKz4yIWHdgNkl/Yfqe
X-Google-Smtp-Source: APXvYqyWoO918KI09CabWk9bxpfwPVate1lncW2H2rscwhb6o7LWMDdzx/jZhirj7Mg5xjkEj+LzEA==
X-Received: by 2002:a02:c652:: with SMTP id k18mr16761184jan.44.1567280130649;
        Sat, 31 Aug 2019 12:35:30 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:30 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
Subject: [PATCH 11/19] tools/power turbostat: Fix Haswell Core systems
Date:   Sat, 31 Aug 2019 15:34:50 -0400
Message-Id: <cd188af5282d9f9e65f63915b13239bafc746f8d.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
References: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

turbostat: cpu0: msr offset 0x630 read failed: Input/output error

because Haswell Core does not have C8-C10.

Output C8-C10 only on Haswell ULT.

Fixes: f5a4c76ad7de ("tools/power turbostat: consolidate duplicate model numbers")

Reported-by: Prarit Bhargava <prarit@redhat.com>
Suggested-by: Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 35f4366a522e..78e7c94b94bf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3217,6 +3217,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -3413,6 +3414,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -3849,6 +3851,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SANDYBRIDGE:
 	case INTEL_FAM6_IVYBRIDGE:
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -4040,6 +4043,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -4259,6 +4263,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
@@ -4292,7 +4297,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
@@ -4576,9 +4581,6 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_XEON_PHI_KNM:
 		return INTEL_FAM6_XEON_PHI_KNL;
 
-	case INTEL_FAM6_HASWELL_ULT:
-		return INTEL_FAM6_HASWELL_CORE;
-
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
-- 
2.20.1

