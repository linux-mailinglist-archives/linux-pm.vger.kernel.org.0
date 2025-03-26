Return-Path: <linux-pm+bounces-24505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD4A71084
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 07:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E87174666
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF318A95A;
	Wed, 26 Mar 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ObpjPIF/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735045383;
	Wed, 26 Mar 2025 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970382; cv=none; b=OQNHmNnY25Rgt/4tSWM64aW4b+/KsWekNHRNh07/eui4OzVpc8VzehI3qVw5wWwZkpSCIqpJABHdj1vADlN6w/U3uVr1U1S0tOqPfa8KWMoPvM8dSOAZP+DrulziKeJzfzvUvCS/6BqOTtNUxP82I6ZcFzV1RoN+SXhfnQRI7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970382; c=relaxed/simple;
	bh=SLoSylU4qgUijl3kPFpMlS/vS5vn8KtJVrS29UujDqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCYtassndXheH9v3LgdgH8h6IJFp+t5coVJqT2Gr1hi5Wc5eMpL9ssfi0i1Y+CVxKvkfjYYBb6PJ7+FhmK7TDXRDbWiKwIkUBsCWqcLgw4M7rFZ5JxYinUF8x4OS+obJAYYkwL6hAZswDgQs28uO2IG5rlzykHUAPXeYwBnXQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ObpjPIF/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52Q6Pe0f820566
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 25 Mar 2025 23:25:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52Q6Pe0f820566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1742970345;
	bh=dua79PBBKker/1j9LILEnmvZHiuERjndK92447LhRYo=;
	h=From:To:Cc:Subject:Date:From;
	b=ObpjPIF//tAzNPKhc9OkX1e+B1lXayZGUcyRIBwAwoCErQo+NigRSJK0eEdE+at4z
	 CbB54hmSkUXd6U7US7Kyr29TAFdu2V8E9oaHbtbtHGFERuf8uEro/RsT+s9kI4Pdd0
	 8m/OOqdWZhgpL9EnrBHj9HrmjiUu8bO98JPX+hbu+3bI5+0bt2ZUb7sk+AWcyMojLL
	 aYWSNgkJyewPlSTacO6dGi/+sJIJTRYstT8gLFNqaR7N2fE8lfj+bt4hIc8prJb3Ix
	 fkYpNIXZFbMNtA54y7nGj+vzjVczLg7fCN8IKajuUpSocqEgXZ3LbhZVWCy82mFsvS
	 Mu8xWqknfXNIA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: rafael@kernel.org, pavel@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, xi.pardee@intel.com, todd.e.brandt@intel.com,
        xin@zytor.com
Subject: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with FRED enabled
Date: Tue, 25 Mar 2025 23:25:40 -0700
Message-ID: <20250326062540.820556-1-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During an S4 resume, the system first performs a cold power-on.  The
kernel image is initially loaded to a random linear address, and the
FRED MSRs are initialized.  Subsequently, the S4 image is loaded,
and the kernel image is relocated to its original address from before
the S4 suspend.  Due to changes in the kernel text and data mappings,
the FRED MSRs must be reinitialized.

Reported-by: Xi Pardee <xi.pardee@intel.com>
Reported-and-Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: stable@kernel.org # 6.9+
---
 arch/x86/power/cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f..ef3c152c319c 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/fred.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -231,6 +232,21 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 */
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+
+	/*
+	 * Restore FRED configs.
+	 *
+	 * FRED configs are completely derived from current kernel text and
+	 * data mappings, thus nothing needs to be saved and restored.
+	 *
+	 * As such, simply re-initialize FRED to restore FRED configs.
+	 *
+	 * Note, FRED RSPs setup needs to access percpu data structures.
+	 */
+	if (ctxt->cr4 & X86_CR4_FRED) {
+		cpu_init_fred_exceptions();
+		cpu_init_fred_rsps();
+	}
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
 #endif
-- 
2.48.1


