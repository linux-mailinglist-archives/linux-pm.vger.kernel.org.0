Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7396964E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbfGOOIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 10:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388592AbfGOOIw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 10:08:52 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4862C2081C;
        Mon, 15 Jul 2019 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199731;
        bh=lk6I4aH5+0b+VVVofMZ3cbJ7lsWFwa2u5jH2KKaaD+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCNUV+dLemhzamwpKhRy+dbEgZVdePTAlrw8dSJC4mD0MNCFrEFKo/bFdVLXj/PfA
         yXDT4BonW7QmBqMasHaCeto2/y9Z3XOfY9beMT/tZbFwey39BGpsB3gcap113Eu6yg
         jc0KHuE9GEffVYPkBCoG5sFQTZK7lTBzYbKQoe2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 087/219] x86/cpu: Add Ice Lake NNPI to Intel family
Date:   Mon, 15 Jul 2019 10:01:28 -0400
Message-Id: <20190715140341.6443-87-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit e32d045cd4ba06b59878323e434bad010e78e658 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 310118805f57..f60ddd655c78 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -56,6 +56,7 @@
 #define INTEL_FAM6_ICELAKE_XEON_D	0x6C
 #define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
 /* "Small Core" Processors (Atom) */
 
-- 
2.20.1

