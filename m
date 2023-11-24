Return-Path: <linux-pm+bounces-200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8417F862C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 23:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F2B2825A5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A4364BE;
	Fri, 24 Nov 2023 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/lnFaSV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C103C478
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 22:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7070AC433CA;
	Fri, 24 Nov 2023 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700865166;
	bh=SruwsS2l79TbUPDZT8+hJEb5a4kT01b9VD/LZ7J5AKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/lnFaSVMQiMkEsslwmzjqzy22MQXd8r9dOLxCa7TLWnoQvJK3pQYuE+Q6CrbEoyR
	 39RMK7baBkVlSAzMhxWIcg0mYsY1sVWkYmD7FkCurSO46YSXqsjEIDzPqOUbgXsK63
	 FrjQ75lmSpZu6ETzAaNH/vz7tuQvdYh2RmvwuKVhJT3Osmh1h/AU7TIvg2inx3mdMd
	 ZSEbZeLhQldnmaE5WqzqY3UPniXAsGIpPw26G6aZrTQOnaTyR73iSfEFzIgSYztgH1
	 740u66mQXDlK06o2pQUyCJzQf3vn4xdoPoqlU1Bn+bD2I/HX6a0CQkejm6GKWo+zh0
	 jjdqFVncadX3A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/7] x86: Add a comment about the "magic" behind shadow sti before mwait
Date: Fri, 24 Nov 2023 23:32:21 +0100
Message-ID: <20231124223226.24249-3-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124223226.24249-1-frederic@kernel.org>
References: <20231124223226.24249-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note to make sure we never miss and break the requirements behind
it.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index bae83810505b..920426d691ce 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -87,6 +87,15 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
+/*
+ * Re-enable interrupts right upon calling mwait in such a way that
+ * no interrupt can fire _before_ the execution of mwait, ie: no
+ * instruction must be placed between "sti" and "mwait".
+ *
+ * This is necessary because if an interrupt queues a timer before
+ * executing mwait, it would otherwise go unnoticed and the next tick
+ * would not be reprogrammed accordingly before mwait ever wakes up.
+ */
 static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
-- 
2.42.1


