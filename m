Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5800B458C2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfFNJeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:34:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfFNJeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:34:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5E9Y2Nc1628507
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 02:34:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5E9Y2Nc1628507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560504843;
        bh=ToGepS8t5druAqk7Q+F02KI+kL55oP+dZQHYZ1vqyYs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OtGVlkdemUCvmDCuHvmXR2T5JONDhdaTcyxIEHentMwcfe/61B2k9jXNv46qawGyg
         RkbcorKOpxBByeSEXJfbtWqkYDfEA4wtPgR18hxWjImVxi1Q6yimr8EDkkqTCmYVxT
         giMQgjk3Ca8xvD+bghl6HM+Tj/KCY8rIrkuku190ne6uVFi6Ifdm+w5JDVm5Xho9X7
         NIOLpXl//Oi+xP5+y4luwSFj7UgrL6BkJPZF/OG47A8wL+qayy4XXk52W6YnZNkq7d
         anjuSHHz8pS/75o6V3qLptGN1/jVNTC9p6G9dj62YJIe+edThL3GFDXLUNqi8qBdvC
         qpAdKcxQqlaVw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5E9Y2vb1628498;
        Fri, 14 Jun 2019 02:34:02 -0700
Date:   Fri, 14 Jun 2019 02:34:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rajneesh Bhardwaj <tipbot@zytor.com>
Message-ID: <tip-5f4318c1b1d23a9290e4def78ee76017c288bf60@git.kernel.org>
Cc:     qiuxu.zhuo@intel.com, hpa@zytor.com, lenb@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        rajneesh.bhardwaj@linux.intel.com, mingo@kernel.org,
        srinivas.pandruvada@linux.intel.com, kan.liang@linux.intel.com,
        linux-pm@vger.kernel.org, dave.hansen@linux.intel.com
Reply-To: srinivas.pandruvada@linux.intel.com, kan.liang@linux.intel.com,
          linux-pm@vger.kernel.org, dave.hansen@linux.intel.com,
          lenb@kernel.org, hpa@zytor.com, qiuxu.zhuo@intel.com,
          linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          rajneesh.bhardwaj@linux.intel.com
In-Reply-To: <20190614081701.13828-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190614081701.13828-1-rajneesh.bhardwaj@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] perf/x86: Add Intel Ice Lake NNPI uncore support
Git-Commit-ID: 5f4318c1b1d23a9290e4def78ee76017c288bf60
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit-ID:  5f4318c1b1d23a9290e4def78ee76017c288bf60
Gitweb:     https://git.kernel.org/tip/5f4318c1b1d23a9290e4def78ee76017c288bf60
Author:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
AuthorDate: Fri, 14 Jun 2019 13:47:01 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 11:30:47 +0200

perf/x86: Add Intel Ice Lake NNPI uncore support

Intel Ice Lake uncore support already included IMC PCI ID but ICL-NNPI
CPUID is missing so add it to fix the probe function.

Fixes: e39875d15ad6 ("perf/x86: add Intel Icelake uncore support")
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: alexander.shishkin@linux.intel.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190614081701.13828-1-rajneesh.bhardwaj@linux.intel.com

---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9e3fbd47cb56..089bfcdf2f7f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1400,6 +1400,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
 	{},
 };
 
