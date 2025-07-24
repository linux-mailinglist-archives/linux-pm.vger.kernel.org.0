Return-Path: <linux-pm+bounces-31403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC076B11304
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA25CAE05D7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F52EE603;
	Thu, 24 Jul 2025 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbBvKarZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61BB661;
	Thu, 24 Jul 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392160; cv=none; b=j3QriadhkF16TV3a/PgN+cEdO2Sd+nx+syWb6Ts/2GZRPV/GnBjmS/r55f0MbG9gt4/DPhQW+KxVSMME0cRzTLMjH7Ev+ExASZpqvy2VFClXljvNa2zW7puN4f2wZDTzMj0C0L0oTCxF1ctCVUVVdiD1sMSyHhU41IUXszY34nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392160; c=relaxed/simple;
	bh=NnSRZiGEPKLCI0YplyyzoVN7Kjr8XvrkVA6/Lh9QUqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hY350y+RWy8MKyz0EPv/CcVLhKTo3AwtctQk9Owq+CUt/KMMsEv15Hnbe0SNSqMhupOaR/sFqgMSBGrdzp5OOMkR4Zq4LmpV1OMZnpFaekmqM8HkjFOmApOwmrjRnbzzvH+LB63EXvA98VIlyzi9PJoXHevZ6KeuDOnmGRhUAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbBvKarZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23c8a505177so11996225ad.2;
        Thu, 24 Jul 2025 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753392157; x=1753996957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEeZUqMIhrU5B1Za/rawSrPb6IUaDfNvtivWsMPHABE=;
        b=hbBvKarZKJj6lOZE2uu4VbM9MtvvMLkKyKLhuaPIDZSXVKRJr56Ak4WZ9npgy9H0tM
         7tVWDcdORmCvplvCGMm99pS/AflUiRnwHsCDy5+Iln5fktQ1qbDr4O+oIjr96RVK3NPp
         RDVpX/jlzHss30qv6IRvFedXYr1mX6/Xev69Wn7CrnIxDHrG/74DqUBCPT1djXO3qwJn
         RF7stLs+ZeHlhnEexevSULq5kaooo5goQMSVl6Yvj/tXWVAcdhNpN5UZK3oSH6XtTUyY
         l1dvBWlMlsVV+RVkr8Qy1+yQN2zBWfiWtU2da69Zs+Lncrk7K7Vb/5Va41Dt9XncFPwv
         HGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392157; x=1753996957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEeZUqMIhrU5B1Za/rawSrPb6IUaDfNvtivWsMPHABE=;
        b=CkWrDTvyBUyfsZgV1SzyiYUYQtBUYPZT8nwRTpjzhfwMQr9OxoL5g7KjmFC+Udkrex
         qSKSABDM6H1atjpX8E4lqgrsLN2iwSA4URd3U4ukYKvzHbVpRuwFFnlyQ9q68u0ETTua
         RjSp5jr7sxGpa1rcCyQ+uHdbxdeOMpfcAogLvH72HNlC9VPwhpmElRPTvGCD1Wg/Asns
         Eqmqes4y9383ZiV2UB+SE1DzwmSaBlMvxp00KUeKlkTIwtLFOOJSNVEhfmDqpbAprqet
         EV9NPK0LCNIIa6RXrpQz0yRtnC50z3c/8e2uEY3XsXTw8NxbpI5WxsYyxFYuMFMcwSD/
         YVOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKVtcaO1SPTqV6Qm8eF8XEwSJ3HEaJa+rk0t0Ic5PsVzzEeAwQIvQnLKRBLH1TfLKg7QNJPyY0NaJn2h8=@vger.kernel.org, AJvYcCWkxotnEd58fGQSw4eKJ9Bh4oLsV5L5wfv6fowfDMzrPRnoauLmNklHyrsuUvuhjbr5PF+lDZb6TRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZ5EWx0UPNB1kpjWCqQ4M9beKWvtJGJ42La2/7lAfuJfxxJtt
	OhI9uX7eVRUm50MJOv4+rNEk59Ivoro915St4d6mt5GL8SH6XhpbI0qs
X-Gm-Gg: ASbGncvhzxtT9awTEPfN8Mxk+UxUkKzzLYAV13kxAjXG0lz8ggwJMfsgmg3E5ciycd5
	/dkoXEp4JY1dUH2HeqnzhuBbu+WxZc05FEvn9d2BbVS+iLY3EJYo1QgXScFxWUgc3UYHa7fnu50
	MnrxWezDthDul/qdysYBbkmh4shXu+NdF+B36WnBmtyIkffXxmB3vcNqrrb4935fPz0O/duZv/b
	me6Oqj7SBScV3Y5BfOMR77bzWsJwHzrzlVSPbuQDfbYWVIzmBr9r54jabplt/ygIB0Z7137CM81
	9Idw+41Tq82NFLRRm1EOzyivjC5fZjo3BCxFuQeRUlqjzERh/cU0McvL1aExia2VRkDGW97KguX
	r7XBt2LVW7JZ00s2GhH+rUQJdUQXYZGXZleMIR9aY
X-Google-Smtp-Source: AGHT+IGKJbEp7DBszqWglZB/cqqhHSFlqGzogABPkIZG8YZVjQAAxbg+ADNp1RVN/R+Rrf8crwHBbA==
X-Received: by 2002:a17:903:3bad:b0:234:f6ba:e681 with SMTP id d9443c01a7336-23f9816196amr113283805ad.5.1753392156619;
        Thu, 24 Jul 2025 14:22:36 -0700 (PDT)
Received: from dev-machine ([2607:fb90:33af:1e63:f0a9:3023:5b5f:ebde])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476ea14sm22496555ad.58.2025.07.24.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:22:36 -0700 (PDT)
From: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
To: ray.huang@amd.com,
	gautham.shenoy@amd.com,
	mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Niko Nikolov <nikolay.niko.nikolov@gmail.com>
Subject: [PATCH] x86/amd/power: Replace do_div() with div64_u64()
Date: Thu, 24 Jul 2025 14:21:05 -0700
Message-ID: <20250724212221.9964-1-nikolay.niko.nikolov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_div() divides 64-by-32, and can risk truncation if divisor exceeds 32 bits.
Use div64_u64() for full 64/64-bit division as recommended, resolving static analysis warnings.

Signed-off-by: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
---
 arch/x86/events/amd/power.c | 49 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index dad42790cf7d..35eff3383660 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -15,12 +15,12 @@
 #include "../perf_event.h"
 
 /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved. */
-#define AMD_POWER_EVENT_MASK		0xFFULL
+#define AMD_POWER_EVENT_MASK 0xFFULL
 
 /*
  * Accumulated power status counters.
  */
-#define AMD_POWER_EVENTSEL_PKG		1
+#define AMD_POWER_EVENTSEL_PKG 1
 
 /*
  * The ratio of compute unit power accumulator sample period to the
@@ -65,7 +65,7 @@ static void event_update(struct perf_event *event)
 	delta *= cpu_pwr_sample_ratio * 1000;
 	tdelta = new_ptsc - prev_ptsc;
 
-	do_div(delta, tdelta);
+	div64_u64(delta, tdelta);
 	local64_add(delta, &event->count);
 }
 
@@ -144,8 +144,8 @@ static void pmu_event_read(struct perf_event *event)
 	event_update(event);
 }
 
-static ssize_t
-get_attr_cpumask(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t get_attr_cpumask(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
 }
@@ -165,12 +165,12 @@ static struct attribute_group pmu_attr_group = {
  * Currently it only supports to report the power of each
  * processor/package.
  */
-EVENT_ATTR_STR(power-pkg, power_pkg, "event=0x01");
+EVENT_ATTR_STR(power - pkg, power_pkg, "event=0x01");
 
-EVENT_ATTR_STR(power-pkg.unit, power_pkg_unit, "mWatts");
+EVENT_ATTR_STR(power - pkg.unit, power_pkg_unit, "mWatts");
 
 /* Convert the count from micro-Watts to milli-Watts. */
-EVENT_ATTR_STR(power-pkg.scale, power_pkg_scale, "1.000000e-3");
+EVENT_ATTR_STR(power - pkg.scale, power_pkg_scale, "1.000000e-3");
 
 static struct attribute *events_attr[] = {
 	EVENT_PTR(power_pkg),
@@ -180,8 +180,8 @@ static struct attribute *events_attr[] = {
 };
 
 static struct attribute_group pmu_events_group = {
-	.name	= "events",
-	.attrs	= events_attr,
+	.name = "events",
+	.attrs = events_attr,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-7");
@@ -192,8 +192,8 @@ static struct attribute *formats_attr[] = {
 };
 
 static struct attribute_group pmu_format_group = {
-	.name	= "format",
-	.attrs	= formats_attr,
+	.name = "format",
+	.attrs = formats_attr,
 };
 
 static const struct attribute_group *attr_groups[] = {
@@ -204,17 +204,17 @@ static const struct attribute_group *attr_groups[] = {
 };
 
 static struct pmu pmu_class = {
-	.attr_groups	= attr_groups,
+	.attr_groups = attr_groups,
 	/* system-wide only */
-	.task_ctx_nr	= perf_invalid_context,
-	.event_init	= pmu_event_init,
-	.add		= pmu_event_add,
-	.del		= pmu_event_del,
-	.start		= pmu_event_start,
-	.stop		= pmu_event_stop,
-	.read		= pmu_event_read,
-	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
-	.module		= THIS_MODULE,
+	.task_ctx_nr = perf_invalid_context,
+	.event_init = pmu_event_init,
+	.add = pmu_event_add,
+	.del = pmu_event_del,
+	.start = pmu_event_start,
+	.stop = pmu_event_stop,
+	.read = pmu_event_read,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+	.module = THIS_MODULE,
 };
 
 static int power_cpu_exit(unsigned int cpu)
@@ -278,10 +278,9 @@ static int __init amd_power_pmu_init(void)
 		return -ENODEV;
 	}
 
-
 	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
-			  "perf/x86/amd/power:online",
-			  power_cpu_init, power_cpu_exit);
+			  "perf/x86/amd/power:online", power_cpu_init,
+			  power_cpu_exit);
 
 	ret = perf_pmu_register(&pmu_class, "power", -1);
 	if (WARN_ON(ret)) {
-- 
2.50.1

Hi,

This patch replaces do_div() with div64_u64() in arch/x86/events/amd/power.c
to avoid potential truncation/overflow, and to conform to kernel arithmetic
best practices.

It builds cleanly for me, but I do not have AMD hardware available to test
functionality at runtime, so additional testing on AMD systems would be
appreciated.

Thanks,
Niko Nikolov

