Return-Path: <linux-pm+bounces-20436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5649A110D2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1211886035
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE272040BD;
	Tue, 14 Jan 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bxq3MzXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4D1FC10E
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881568; cv=none; b=cRaT/Q+ljx6Y/CuXXrsKTB1Qk0uouwIZMvKR1+odooxjbigFBwSzBNBpxH4XETNYAuI1d1mb3pwqtkmTJB7r1RaCuFv5XXg59rlu/4QJ7k42hWcsmkfzD3q2jcvAsBKjHZe7Qy7UuXieXB+hUzlvtOU2TmzMMZw2V0JDbt+JKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881568; c=relaxed/simple;
	bh=LXLQiJqWt+6VSxSgWHu0HnY8Id/SQVdnYvhKrOX0X7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsKvMuUCO2i+FN0T7qcHCH/myC7diJCgpGFNMVAICMADNfR0GzOs8RAuVQ0AH/cORgFdViMBm29QxTh9b63aZe2+qQ2vMKBAt3XOZdbpmORUHUtyTd7pR0ociQD5YYWWlevezgNFBEbpRAWJk0B7uztQSaIZLUg7Nw0oTVSNQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bxq3MzXx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862de51d38so270373f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736881565; x=1737486365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN5rUEMysp3+AroTy4SlvvD7Pduqgen38rd5O/+MvPY=;
        b=Bxq3MzXxtNeyVBTpsf3utpz6NkwjrQz6mV1qh68FgOIgezYUFS8qIAF+XT5jsAvT7c
         h66i7mApvhJtNIHdJHBrRIlRu3Pyge9jgIl6xACMxTmN3+plyc39SkY91AuChSZ+n8Mc
         quGEVWWJ1cmJ0HbgYMgmWFusfVCVK7IeM3/fMX6IXGIzGSRuyG1fYFqpd1WBKDwbZQUy
         4zBsGgvVJPi5+5IcuzYgTajTm/Ipm1Vnh2PKvd2rotEHPMdyCRsLO+THADdQ7g1URFQi
         FKpGT/+m3YfLDN8Gb+SnuvH0n5dEOnfNmyHDyAeQazPnTf/Rk5RPhaTnWYbO4rv47Swe
         TgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881565; x=1737486365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN5rUEMysp3+AroTy4SlvvD7Pduqgen38rd5O/+MvPY=;
        b=Ac6zFSWgHXGrSSLlTwUR6Mr9cKuxHlBek6D0AbhkexGeISCasi+TVgQF/Jhb0bqRwN
         4bimRlYiwmByRUjR0tjt5c/+nDSTlXB/6jm6sb/5B0dL99JXhfXrvoUTJBbR5rZoNrxr
         bAkjKz/StZ9LlNEQOOt6EhnmVeKBtsrolAp6Khw7IaPyp86Egw3lLJ0wHvJOGkXfYez3
         VXZSO35jmmaXbCVdNm2ZSWKXJWuHdUftGcVeYTDfA6SMjbU6nSJPDE4/rgD4doRcJK5n
         z/cfbbE1GFLHnHkrgG2Mo3dNgzEWKlqH4clBlr/O0bZYn+zTzCxMIcy80YwVi4JUpuo3
         q98Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQQfhNkF2hUPd3BaLSukCesjKFm+L0Txytq375Mw2+1n5gwyhjsUNmi/xH8sXM8MA91jHsT3vowQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBU8gPAQbH5vBwLfo/U6VP1x+/rLsRe+sMqb1gaP92VowmsJd5
	6lmPtAs6Q2/OlG74fBtEmyl4UmObGICYNHzae4F2MZRJiB03h3+Bt0v15JGqnLE=
X-Gm-Gg: ASbGncsUM1tnjsRi0yJUIkF24BfT0jZCcAAFEvJOk9VmvsDPaR6QSjn5OeI+wYbbD1e
	P4Vwbf1ruuoyyuPCrTkX2wyKy64544uWDAGPq+WSLAxcfQsTR1Py3/ydsoqAvT4G7JC2a+la4kY
	SztJkaFHpCeQrCBUeOu1k+FDQ9+Wv+lkJuPnLq4QZL2Va52WUdxl7sD9+yqZn5+lka19TWgBktt
	fwxwjBpHDUJtGOSf+PFHOEPC8TXwAZ4S4wDEuoNnCMjFduAoIoKYA40534HtjpyFw7rRFw=
X-Google-Smtp-Source: AGHT+IE6pa0lthPJtWzhB15VzlOKuOcoh6DUo2csVHRrLlrQDBEdBv9yOOVd7c4Cp/ivr1V81kDl7A==
X-Received: by 2002:a05:6000:705:b0:37d:4aa2:5cfe with SMTP id ffacd0b85a97d-38a872d9f96mr8638256f8f.6.1736881564689;
        Tue, 14 Jan 2025 11:06:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81a4sm15958883f8f.68.2025.01.14.11.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:06:04 -0800 (PST)
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
Subject: [PATCH v2] cpufreq: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 20:06:00 +0100
Message-ID: <20250114190600.846651-1-krzysztof.kozlowski@linaro.org>
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

Changes in v2:
1. Fix enable->enabled
---
 drivers/cpufreq/cpufreq.c         | 7 ++++---
 drivers/cpufreq/powernv-cpufreq.c | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 418236fef172..1076e37a18ad 100644
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
+		 __func__, str_enabled_disabled(enable));
 
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


