Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AB1286EE
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 05:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLUEqH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 23:46:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:31838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfLUEqG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Dec 2019 23:46:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620123"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:46:04 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v5 15/19] KVM: VMX: Use VMX feature flag to query BIOS enabling
Date:   Fri, 20 Dec 2019 20:45:09 -0800
Message-Id: <20191221044513.21680-16-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace KVM's manual checks on IA32_FEAT_CTL with a query on the boot
CPU's MSR_IA32_FEAT_CTL and VMX feature flags.  The MSR_IA32_FEAT_CTL
indicates that IA32_FEAT_CTL has been configured and that dependent
features are accurately reflected in cpufeatures, e.g. the VMX flag is
now cleared during boot if VMX isn't fully enabled via IA32_FEAT_CTL,
including the case where the MSR isn't supported.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a026334ffc58..06e0e5262704 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2204,31 +2204,8 @@ static __init int cpu_has_kvm_support(void)
 
 static __init int vmx_disabled_by_bios(void)
 {
-	u64 msr;
-
-	rdmsrl(MSR_IA32_FEAT_CTL, msr);
-
-	if (unlikely(!(msr & FEAT_CTL_LOCKED)))
-		return 1;
-
-	/* launched w/ TXT and VMX disabled */
-	if (!(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX) &&
-	    tboot_enabled())
-		return 1;
-	/* launched w/o TXT and VMX only enabled w/ TXT */
-	if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX) &&
-	    (msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX) &&
-	    !tboot_enabled()) {
-		pr_warn("kvm: disable TXT in the BIOS or "
-			"activate TXT before enabling KVM\n");
-		return 1;
-	}
-	/* launched w/o TXT and VMX disabled */
-	if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX) &&
-	    !tboot_enabled())
-		return 1;
-
-	return 0;
+	return !boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
+	       !boot_cpu_has(X86_FEATURE_VMX);
 }
 
 static void kvm_cpu_vmxon(u64 addr)
-- 
2.24.1

