Return-Path: <linux-pm+bounces-20404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2881A104BF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0181691FD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4124334A;
	Tue, 14 Jan 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OU/O7M33"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197863DABE4
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852177; cv=none; b=WO4gOfbV2Hgkv9GF2B+oaBYF7hxXG/iyWsETUIR6NdoUzlDtayuMw4UlztfZ8yD9novZRRHqXewwFjUYs/db5V6rxRJuYwlrMeduhVQRHIIoJQhSi1GICdx/whOvpGjt8b3RSjrW63sNYBuZjzmdIdWe1IQNlr4/W/BvDM/hTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852177; c=relaxed/simple;
	bh=apw9YRbIZ1vmrPQOI1/lMVImDpyDtn8TVgIS0tClx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDoVr4ShaXa1G5eivpPbJLoT6o3U6mpLgUBP1fflO6q4mIubDcQAwaKPEszjdhaSkFlcoWBvctXSY15EGZ4cz2T9sOqNs5ndw37rsOCrH2t1IahkbYL61YicLFfP5YUiUylTwDm7bQc3Pff8g6RdrH73/7If+KWmr1FIJcB0N2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OU/O7M33; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab30614c1d6so53646266b.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736852174; x=1737456974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9oSrldtgC1P5MkOGOlIxpHFkeRWTLigJBFqOxmE9I8=;
        b=OU/O7M33UZQhjE1xPYGHXdbPcTDJ8kJzCbhIiSjWBYDtR6eVl7HAX3M16Jpz8BNjaz
         joJT+F9VlIf+NDzT9V1F8X0QaUwDeb+lBD6yXhp527Ln+tv+EbLXdQhbcbSjk0/RHiK7
         gCrMM/LMTS0ojNtiz1oNjYQH0AXqA0IvTZ7PwkU9bsXddkIiP91hA682PHZfRoFWLOun
         QiMA7c0KVv5SMduYg90el6oDFzbNgxa50cExSHYrPiSnDYgA1WzbfIDF7tRHFkpo6f8i
         WkA9tAygAp0wIWAVOGSu0xHem/PgRMBSeHYiCVQePoSLWzaFZQRXbkXUffeF2OeHvA2+
         ucBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852174; x=1737456974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9oSrldtgC1P5MkOGOlIxpHFkeRWTLigJBFqOxmE9I8=;
        b=RjC0GBgGYW5nUzy2XEsnurk4NVPQuuK8tDjlN6apyKUZIxz3tozOEn3LD+CNylwioi
         yX5RXj7vey6uC9qnaSZ7kAYqRZXQNsfEuIL2tZRyJx2u6P6zYWwvzCy5c377A7sc24Pp
         tDU3P/ov1t5cJ/yL9N16Qa4G1u6BdMow0Jg47FSoBFJRVmbHG7Rna9NgSQdHNKlz5EP2
         shryU9yY2ISE8uoOxOlh8fOGFuXh5n2Z0C3IdZBHd/wKev+b5bKvqsVmo9te0WM11RTs
         kU3ZWh7wkx1jRp7ODlLP4NlZ0RD8iEwvRWzjR04tDtNE7mpdxj78zvolbPN29mlh/1/d
         +cRw==
X-Forwarded-Encrypted: i=1; AJvYcCXGTQv+pTBhOrESuceqFbrEolqU1OgpG92uy3njiFn6r5KhhrOaEe/mojUHZs+l+y6kpNZ6OYvVmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0AcDlJi7xyNQNju94ObGpOaCaeW4b/Qiee0LmnbSYhZSVT/y
	3I9gEVCJPyN5QsLqznewsRm7sfvSCWgTQrbg9jPQQM1LgyQRQs3R/F/QlVubixc=
X-Gm-Gg: ASbGncuyFvRb2Mq2rFWXb0XlpvQuW3h0LVFZGEzOtpJQ0QqVS4w04Lb+tD+8ydxK8NV
	CnwG+YKxNdXXNruUtIAkQmmF64lfpwNPfeaKr16xMkOlS+TKzp70HesVtlCLA+EJcrfoVuAbLtY
	J/+eDub1DkkJISw0aLQ5ULutOic5JTRHRR2scqkkD19eSzfsZ1Dc5c+EwfhLOgTPYjOn2+T7iVe
	BGl6kREum+9iVReFum+37snuI/BhDfq/oRF31gKo5qLHKJ6GmAFm7XscB7a8dHFZHEQpsY=
X-Google-Smtp-Source: AGHT+IELLCYYvHKb5lpw7z0EW5WhiA9Rzrdg/loEMvWoWRnv3YcLbL4xd0LbtlI+AziAeBNghsD6uQ==
X-Received: by 2002:a17:907:2d92:b0:aa6:9631:923f with SMTP id a640c23a62f3a-ab2abc9519fmr845034066b.12.1736852174367;
        Tue, 14 Jan 2025 02:56:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b215esm611700266b.161.2025.01.14.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:56:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] cpufreq: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 11:56:11 +0100
Message-ID: <20250114105611.273202-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpufreq/cpufreq.c         | 7 ++++---
 drivers/cpufreq/powernv-cpufreq.c | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 418236fef172..fba62124b56a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/tick.h>
@@ -602,12 +603,12 @@ static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
 
 	if (cpufreq_boost_trigger_state(enable)) {
 		pr_err("%s: Cannot %s BOOST!\n",
-		       __func__, enable ? "enable" : "disable");
+		       __func__, str_enable_disable(enable));
 		return -EINVAL;
 	}
 
 	pr_debug("%s: cpufreq BOOST %s\n",
-		 __func__, enable ? "enabled" : "disabled");
+		 __func__, str_enable_disable(enable));
 
 	return count;
 }
@@ -2812,7 +2813,7 @@ int cpufreq_boost_trigger_state(int state)
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	pr_err("%s: Cannot %s BOOST\n",
-	       __func__, state ? "enable" : "disable");
+	       __func__, str_enable_disable(state));
 
 	return ret;
 }
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8de759247771..ae79d909943b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/cpu.h>
 #include <linux/hashtable.h>
 #include <trace/events/power.h>
@@ -281,7 +282,7 @@ static int init_powernv_pstates(void)
 	pr_info("cpufreq pstate min 0x%x nominal 0x%x max 0x%x\n", pstate_min,
 		pstate_nominal, pstate_max);
 	pr_info("Workload Optimized Frequency is %s in the platform\n",
-		(powernv_pstate_info.wof_enabled) ? "enabled" : "disabled");
+		str_enabled_disabled(powernv_pstate_info.wof_enabled));
 
 	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
 	if (!pstate_ids) {
-- 
2.43.0


