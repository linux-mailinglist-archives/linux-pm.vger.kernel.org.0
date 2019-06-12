Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED0E42614
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407655AbfFLMiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 08:38:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41425 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406351AbfFLMiP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 08:38:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCb2S9686859
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:37:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCb2S9686859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560343023;
        bh=eYKMpZEAjnJ8Js12oOCOaHQmVBeOrwt5sDU+OKEJZTU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=j40w5J8KWchEte2B1U3uMrs1/vfHUuuU5hL+FnDAJJnmomlYuDLVklWN6Pr4S9f4i
         lcdiCO9kD4PkzSH0QKkb1DU9UreSJsSFk77jetMcBHB1c7KSW6kwwJAS1JreymKcR7
         ZJapELuwESJJ6O0JHcfzJLWjNu4caqtdsDtbL4ViUbWsug8m0/575mqeuJTjrOLIcJ
         ZwVt0qhRtovR2Ku+D63pAoYMgZRAtnRmntYCwB7kPQ/xej6nnwJnaeAHLDOTb7KyHj
         5DIN7SCOXbv1qonO0uurGhz5i2TboGnviM7WrLSeEfNSXuR8Y3a5knE3oTH6Jt1US/
         ywjv984Y6FLsw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCb1LD686855;
        Wed, 12 Jun 2019 05:37:01 -0700
Date:   Wed, 12 Jun 2019 05:37:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rajneesh Bhardwaj <tipbot@zytor.com>
Message-ID: <tip-61caa8621b9979a78b04e353ab2ee44a47ef7a62@git.kernel.org>
Cc:     bp@alien8.de, lenb@kernel.org, kan.liang@linux.intel.com,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        rajneesh.bhardwaj@linux.intel.com, qiuxu.zhuo@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com,
        andriy.shevchenko@linux.intel.com, linux-pm@vger.kernel.org,
        dave.hansen@linux.intel.com
Reply-To: andriy.shevchenko@linux.intel.com, linux-pm@vger.kernel.org,
          kan.liang@linux.intel.com, srinivas.pandruvada@linux.intel.com,
          dave.hansen@linux.intel.com, tglx@linutronix.de,
          rajneesh.bhardwaj@linux.intel.com, bp@alien8.de,
          qiuxu.zhuo@intel.com, lenb@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Add Ice Lake NNPI to Intel family
Git-Commit-ID: 61caa8621b9979a78b04e353ab2ee44a47ef7a62
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit-ID:  61caa8621b9979a78b04e353ab2ee44a47ef7a62
Gitweb:     https://git.kernel.org/tip/61caa8621b9979a78b04e353ab2ee44a47ef7a62
Author:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
AuthorDate: Thu, 6 Jun 2019 06:54:19 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 11:43:42 +0200

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
 
