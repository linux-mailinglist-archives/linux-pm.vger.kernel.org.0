Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3245766
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfFNIVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 04:21:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:32836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfFNIVz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 04:21:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 01:21:53 -0700
X-ExtLoop1: 1
Received: from rajneesh-desk.iind.intel.com ([10.66.234.53])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2019 01:21:49 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] perf/x86: add Intel Ice Lake NNPI uncore support
Date:   Fri, 14 Jun 2019 13:47:01 +0530
Message-Id: <20190614081701.13828-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Intel Ice Lake uncore support already included IMC PCI ID but ICL-NNPI
CPUID is missing so add it to fix probe.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Fixes:  e39875d15ad6 ("perf/x86: add Intel Icelake uncore support")
Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index fc40a1473058..3211462717c7 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1399,6 +1399,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
 	{},
 };
 
-- 
2.17.1

