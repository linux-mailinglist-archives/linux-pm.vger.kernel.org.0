Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA82458AB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFNJak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:30:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40427 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFNJak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:30:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5E9SDmZ1626959
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 02:28:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5E9SDmZ1626959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560504494;
        bh=8ovtBRuZ0q8GIqCVFE0Skn79qdS+yqXGPq1xONZOsDw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uLnFCratGXjhc7DxN/+6K+HriiKU8DO2JkCt+8Ylz1udjr4vbHqPo7jSPe+qOlFv+
         XZ+s/9pRawXJmV8iST+m7AgYz5j8K1gdpR6Hz0qARVE3/yMUEp2RoFEf3jo8Vfl3yY
         eAqaeoMPcL0ON3NkuwatnhITWjb3Z1r+QtMz1QEcd1VOOnysJpL/h8V5CIMlVHyIHS
         L51DDoZ+plQtFAFqyT2MrDUp1ZPanF3NlNZoYkiJsXqogWrSUycoppm2Q1IHWnn5Hi
         vDLXNR3DmyQOhM4b6dlFfqAogn418gYmvpYSc3u0lCCcO5PrZRNdSRZ7hJjmZjKTTa
         HiPSxD4ZjdlUw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5E9SD5k1626956;
        Fri, 14 Jun 2019 02:28:13 -0700
Date:   Fri, 14 Jun 2019 02:28:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rajneesh Bhardwaj <tipbot@zytor.com>
Message-ID: <tip-e32d045cd4ba06b59878323e434bad010e78e658@git.kernel.org>
Cc:     peterz@infradead.org, rajneesh.bhardwaj@linux.intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-pm@vger.kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, qiuxu.zhuo@intel.com,
        andriy.shevchenko@linux.intel.com, bp@alien8.de,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        hpa@zytor.com, lenb@kernel.org
Reply-To: rajneesh.bhardwaj@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          linux-pm@vger.kernel.org, mingo@kernel.org,
          kan.liang@linux.intel.com, qiuxu.zhuo@intel.com,
          andriy.shevchenko@linux.intel.com, bp@alien8.de,
          srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
          hpa@zytor.com, lenb@kernel.org
In-Reply-To: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Add Ice Lake NNPI to Intel family
Git-Commit-ID: e32d045cd4ba06b59878323e434bad010e78e658
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

Commit-ID:  e32d045cd4ba06b59878323e434bad010e78e658
Gitweb:     https://git.kernel.org/tip/e32d045cd4ba06b59878323e434bad010e78e658
Author:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
AuthorDate: Thu, 6 Jun 2019 06:54:19 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 13 Jun 2019 19:37:42 +0200

x86/cpu: Add Ice Lake NNPI to Intel family

Add the CPUID model number of Ice Lake Neural Network Processor for Deep
Learning Inference (ICL-NNPI) to the Intel family list. Ice Lake NNPI uses
model number 0x9D and this will be documented in a future version of Intel
Software Development Manual.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@suse.de
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com

---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9f15384c504a..087de5d3b93a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -53,6 +53,7 @@
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
 /* "Small Core" Processors (Atom) */
 
