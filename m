Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE8C393EEA
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhE1Ipw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 04:45:52 -0400
Received: from [110.188.70.11] ([110.188.70.11]:27328 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229950AbhE1Ipu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 May 2021 04:45:50 -0400
X-Greylist: delayed 1687 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 04:45:49 EDT
Received: from spam1.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam1.hygon.cn with ESMTP id 14S8G8a5031124
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 16:16:08 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id 14S8F1qJ030977;
        Fri, 28 May 2021 16:15:01 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id 14S8EwBr007965;
        Fri, 28 May 2021 16:14:59 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from ubuntu1604-2.higon.com (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 28 May
 2021 16:14:59 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <rafael@kernel.org>, <len.brown@intel.com>,
        <pavel@ucw.cz>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@suse.de>, <hpa@zytor.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] x86/cstate: Allow ACPI C1 FFH MWAIT use on Hygon systems
Date:   Fri, 28 May 2021 16:14:17 +0800
Message-ID: <20210528081417.31474-1-puwen@hygon.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn 14S8G8a5031124
X-DNSRBL: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hygon systems support the Monitor/Mwait instructions and these can be used
for ACPI C1 in the same way as on AMD and Intel systems.

The BIOS declares a C1 state in _CST to use FFH and CPUID_Fn00000005_EDX
is non-zero on Hygon systems.

Allow ffh_cstate_init() to succeed on Hygon systems to default using FFH
MWAIT instead of HALT for ACPI C1.

Tested successfully on Hygon Fam18h systems.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/acpi/cstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 49ae4e1ac9cd..7de599eba7f0 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -197,7 +197,8 @@ static int __init ffh_cstate_init(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	if (c->x86_vendor != X86_VENDOR_INTEL &&
-	    c->x86_vendor != X86_VENDOR_AMD)
+	    c->x86_vendor != X86_VENDOR_AMD &&
+	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -1;
 
 	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
-- 
2.23.0

