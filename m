Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C847A45F6
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfHaTfk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38511 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:39 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so21120347iog.5
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=TJAgY0/lGSieq/yTPh5m6qoZ24u/ZjIG1jCgb3s0F6s=;
        b=vHhw7+/mIMfa5vweut78O7+zTeRaoXl+MGDPw8S7+4wsKvuo/FHdVaNBUdioQNG3wR
         U6x4zdPrbnSQ5csgozDOUg3YFDQv7/FWm6Dmdzq4l82epz0vjQo5w6cbDyKFiXQFSmz5
         1oRkq0jghlFgYqBtlRmEJQ3umiAzxOdTnKUsQIJLJ3WiIWsAZDRtSPv+7V+2JA4EhC5+
         iSjPL9xiJupJs52pPHg8EaJmLzjil+BnY+4QJwTTOvtHPSfd3wNLXxKCLHGC7qcas1Pt
         a9lJUaxbRk2BzhsEvozU45BmsqXsQ1mMmS3k09BPXA0BA6Faq51tzSYb3Whhr9sATsIn
         Rzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=TJAgY0/lGSieq/yTPh5m6qoZ24u/ZjIG1jCgb3s0F6s=;
        b=GzkrGPp+EtJssZelYneglB+Cahv05pIgqTtbtjend2Z8YbaKerihK76ag3zOa+YAqg
         nfLyELGRQUfNZ9HyxyQ71c6ARtv9tWL/EV3CZISIojbJsIVcU8fsTAPtmWFvZ0qUgAaA
         vlATfNZ8ZbZKR4u/+TRdhtWp37HQ7FveLfUbjoq540T2TWD9cW12X26m1ujDKOFbWOO7
         CPSzf3bgK8qBNe0bGNIOBoBl6+3JbkHQc6kbHluJu4de/G8yyc3tS1l3mLohag1Z4rwv
         sNlbZIme0Yevxm6S775CLwrF1/SEPs6xTczM8v2fJ7v93iM1JlclReJswXkBm0LVK+85
         ndeQ==
X-Gm-Message-State: APjAAAWHIZ9krHCVlct6irAV2lGFC1xBFgU0uOBNvJeM+Bvxbt/1ZcOL
        nKFFeXD6BIGl0pLVXfuqO6v+qCEC
X-Google-Smtp-Source: APXvYqysRLs/ZZNqGRkOV4ovsCm4UpI4aeqZGq/qabrAL84xP4VUJ6E0juBqlwTyG+C1jd4pUizf8g==
X-Received: by 2002:a6b:ec18:: with SMTP id c24mr994515ioh.72.1567280138800;
        Sat, 31 Aug 2019 12:35:38 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:38 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Pu Wen <puwen@hygon.cn>, Calvin Walton <calvin.walton@kepstin.ca>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 18/19] tools/power turbostat: Add support for Hygon Fam 18h (Dhyana) RAPL
Date:   Sat, 31 Aug 2019 15:34:57 -0400
Message-Id: <c1c10cc77883932abdb7b103687ecbb01e80bef9.1567277326.git.len.brown@intel.com>
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

From: Pu Wen <puwen@hygon.cn>

Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for AMD
Fam 17h (Zen) RAPL") and the commit 3316f99a9f1b68c578c5 ("tools/power
turbostat: Also read package power on AMD F17h (Zen)") add AMD Fam 17h
RAPL support.

Hygon Family 18h(Dhyana) support RAPL in bit 14 of CPUID 0x80000007 EDX,
and has MSRs RAPL_PWR_UNIT/CORE_ENERGY_STAT/PKG_ENERGY_STAT. So add Hygon
Dhyana Family 18h support for RAPL.

Already tested on Hygon multi-node systems and it shows correct per-core
energy usage and the total package power.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6cec6aa01241..e8b6c608d6d1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -59,6 +59,7 @@ unsigned int do_irtl_hsw;
 unsigned int units = 1000000;	/* MHz etc */
 unsigned int genuine_intel;
 unsigned int authentic_amd;
+unsigned int hygon_genuine;
 unsigned int max_level, max_extended_level;
 unsigned int has_invariant_tsc;
 unsigned int do_nhm_platform_info;
@@ -1730,7 +1731,7 @@ void get_apic_id(struct thread_data *t)
 	if (!DO_BIC(BIC_X2APIC))
 		return;
 
-	if (authentic_amd) {
+	if (authentic_amd || hygon_genuine) {
 		unsigned int topology_extensions;
 
 		if (max_extended_level < 0x8000001e)
@@ -3831,6 +3832,7 @@ double get_tdp_amd(unsigned int family)
 {
 	switch (family) {
 	case 0x17:
+	case 0x18:
 	default:
 		/* This is the max stock TDP of HEDT/Server Fam17h chips */
 		return 250.0;
@@ -4011,6 +4013,7 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
 
 	switch (family) {
 	case 0x17: /* Zen, Zen+ */
+	case 0x18: /* Hygon Dhyana */
 		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
@@ -4047,7 +4050,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 {
 	if (genuine_intel)
 		rapl_probe_intel(family, model);
-	if (authentic_amd)
+	if (authentic_amd || hygon_genuine)
 		rapl_probe_amd(family, model);
 }
 
@@ -4632,6 +4635,8 @@ void process_cpuid()
 		genuine_intel = 1;
 	else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
 		authentic_amd = 1;
+	else if (ebx == 0x6f677948 && ecx == 0x656e6975 && edx == 0x6e65476e)
+		hygon_genuine = 1;
 
 	if (!quiet)
 		fprintf(outf, "CPUID(0): %.4s%.4s%.4s ",
-- 
2.20.1

