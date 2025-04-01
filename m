Return-Path: <linux-pm+bounces-24680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510AEA775C6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB9166B2C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464641E8837;
	Tue,  1 Apr 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dbx6XvMy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A41078F;
	Tue,  1 Apr 2025 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494285; cv=none; b=PT4zWu9lneRWyPrp7zOvA86fUM+7TO4OyTZn1Idh59rpII870umTj3WXlNlPi+wNiQikdyx2O+qz/k9K+wshwF6VGtGNC0a9c3Vqp5sfw5m0qqhPYN+AYFaa3QHMnk3yzWnlJes2BEtpGygC/syNpxNNBOzkBUf/tlwVdvcIAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494285; c=relaxed/simple;
	bh=Zuky21qHhOoUcW95DBWvq7xeXz3F0IcpbLmzX/Q+5yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeOex4eYlhiWbZMAsNpNaQ3/ijv0dxOSqtrXFpJDKChVuTpSOlcb6t1IGnk6fxL96t3EZ44i5fLgkjcB0ygtf6J/hDIKQ8wKN+hQtMHVFZ+joNU6VsxhRLaAAv22JdIawECDKA3Rv8x748AKotFcSZN9TnbBNkoXOZAgHOkVumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dbx6XvMy; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5317vSlf3626157
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 1 Apr 2025 00:57:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5317vSlf3626157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743494252;
	bh=PXqPsnXL5zoeesrQ9uDoxGxPHXk0Y7zXqzlVU5X8/Lg=;
	h=From:To:Cc:Subject:Date:From;
	b=dbx6XvMy8z0d5iKogpw0LKrho5EEcyx61LP9SgpA9LRDPafRIVAW9FSiKnNykThiJ
	 4Ya5coPyx8+Ab5GxWkSuohdzIEM2uBPluLzbYyHskEb0TQCflNtCZjkmFYbxprJ/8s
	 Tz0qnCQ2CmZeMzw3x2Z+z7dcMf5XotW7am3gML6eq8HFSY6TZVAwdzlUrYbewN9seF
	 170Y0rgiPolqw3YYcHUYXL3LHnFzW0FwArxFt1vxLHBSPfMsTI4ZQhFyIR+nT6FY+Y
	 9AuKhJMjQnMyNsUix4IGPUUdElWMSACNzv8tkhzjvMZQKxTMFca2OFU0BXPUuA2Ic5
	 bSx6NsQJA3GXA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: rafael@kernel.org, pavel@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, brgerst@gmail.com, jgross@suse.com,
        torvalds@linux-foundation.org, xi.pardee@intel.com,
        todd.e.brandt@intel.com, xin@zytor.com
Subject: [PATCH v2 1/1] x86/fred: Fix system hang during S4 resume with FRED enabled
Date: Tue,  1 Apr 2025 00:57:27 -0700
Message-ID: <20250401075728.3626147-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon a wakeup from S4, the restore kernel starts and initializes the
FRED MSRs as needed from its perspective.  It then loads a hibernation
image, including the image kernel, and attempts to load image pages
directly into their original page frames used before hibernation unless
those frames are currently in use.  Once all pages are moved to their
original locations, it jumps to a "trampoline" page in the image kernel.

At this point, the image kernel takes control, but the FRED MSRs still
contain values set by the restore kernel, which may differ from those
set by the image kernel before hibernation.  Therefore, the image kernel
must ensure the FRED MSRs have the same values as before hibernation.
Since these values depend only on the location of the kernel text and
data, they can be recomputed from scratch.

Reported-by: Xi Pardee <xi.pardee@intel.com>
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org # 6.9+
---

Change in v2:
* Rewrite the change log and in-code comments based on Rafael's feedback.
---
 arch/x86/power/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f..08e76a5ca155 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/fred.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -231,6 +232,19 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 */
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+
+	/*
+	 * Reinitialize FRED to ensure the FRED MSRs contain the same values
+	 * as before hibernation.
+	 *
+	 * Note, the setup of FRED RSPs requires access to percpu data
+	 * structures.  Therefore, FRED reinitialization can only occur after
+	 * the percpu access pointer (i.e., MSR_GS_BASE) is restored.
+	 */
+	if (ctxt->cr4 & X86_CR4_FRED) {
+		cpu_init_fred_exceptions();
+		cpu_init_fred_rsps();
+	}
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
 #endif

base-commit: 535bd326c5657fe570f41b1f76941e449d9e2062
-- 
2.49.0


