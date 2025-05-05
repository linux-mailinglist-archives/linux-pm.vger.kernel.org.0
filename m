Return-Path: <linux-pm+bounces-26669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A688AA9ECB
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CA91A81261
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D729276051;
	Mon,  5 May 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCLo2yZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F372276042;
	Mon,  5 May 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483266; cv=none; b=UD7lq46UAuZrIx+a/zmHu+FZhPyWkU806rKUk5Vwy2cUrF9ejuMspAqgkyu9GpsVIoFl6rmp4Irstawus9t8R4uZlq8jOf23cPLRZm9PN+jZ1MgHxff3STJRQPviyBxsufaR0bEXwBhRivK31NM6RIa9YLv19dOKd8suNoqM+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483266; c=relaxed/simple;
	bh=J9LKa0JVlnkzvGDcwNe2mR9Fops5wHLY5lriBOCwhnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIe8mRGdDqANet3sC/mO6QD77iZU/CSYkkVii8Z76VWsec52A6KT1HuBdBvwgVeguxdtuR+I5hlP2wRRcBxy82Pc570sh6vJ5s+TkYFSF3I+ThGGhrCeCQo+NVbby5dC62jACWo4ab0j4Ae55KeU14T842InsqLCAM97rYXw52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCLo2yZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A876C4CEE4;
	Mon,  5 May 2025 22:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483266;
	bh=J9LKa0JVlnkzvGDcwNe2mR9Fops5wHLY5lriBOCwhnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCLo2yZsGYJAsp8821Ip+DvyklxUAd/WtOs4iPpqkDzrbibgO5BrJmdSWxd02TUkp
	 L+Us8VTlvYGC/fr69h36k3/VJsAdVKpfl4F0LNz4ApZDU1E1P70vsLboe9C0M8UC9i
	 6z8cWtjihR2OehlBEwSdwx657Zpqf4ERABBPav3a7AduEKNFjyoRtbDs+d0KEUrtpM
	 2qN4FjKYNp+xkqiJoFg4lWhYakaYjlAylLBy260JinatII997yIMLvQTnUAsxQX4na
	 Ib0PHMGZjoqAv6W9RvRvQiXLA+apv8kxoj5Aq11aKxHF2iWOVwWQmZ4NnCV6bjCz35
	 zlSb3M4Eqzsjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xin Li (Intel)" <xin@zytor.com>,
	Xi Pardee <xi.pardee@intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	pavel@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 002/642] x86/fred: Fix system hang during S4 resume with FRED enabled
Date: Mon,  5 May 2025 18:03:38 -0400
Message-Id: <20250505221419.2672473-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

[ Upstream commit e5f1e8af9c9e151ecd665f6d2e36fb25fec3b110 ]

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
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401075728.3626147-1-xin@zytor.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/power/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f0..08e76a5ca1553 100644
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
-- 
2.39.5


