Return-Path: <linux-pm+bounces-25992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F87A97C5E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D53AB008
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93117266F09;
	Wed, 23 Apr 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPnl1+3i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1C266EF8;
	Wed, 23 Apr 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372836; cv=none; b=Y81tswVwlXFP2ae8iuio8ZGSKEwwmXAKHWBMOx6Mcgvv6zAfpO/AVKD0AjSMF5nCdZf60U9Aa47pxAWpRHfesp3/uB1E26cHVtTCiRFrEHRI4bQJevSMAlD2wLrkAHohPia4kzNsH67OjbaazmmxB92aztcmqLkl3kdPLFH062M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372836; c=relaxed/simple;
	bh=Do1426mrGV2LHA/HL/SD6shDSzpjPFUyAEjYA4UDuPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EowuYIYvBQtgakZt/3LdRU7DMwXJxKarK9OXr6FUpm1htfQkiBD+vRkSO7vtRtR9CtD9wmBgbAIcZrmGO+IIJJ35Cm4KC73U8UGFbiLbFw75wC4UKo5C4oT9CFUow254ubyJV7sXUuL7n0RSLad5O7pVre+b5TJtzCAX7ClLUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPnl1+3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BFFC4CEED;
	Wed, 23 Apr 2025 01:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372835;
	bh=Do1426mrGV2LHA/HL/SD6shDSzpjPFUyAEjYA4UDuPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPnl1+3i7SWg98r+Ur9CpacIZYwkwyqeMjrLH7qauPQq8JjbI2E6NV2GKgtvlCIAv
	 AJOmRHjn6OU25PE7QNgBoddyKfuc+oaaoY9PUCA/1s+6vqV2NVSAUme+FE6HiSvSfr
	 1+n/H0HsScozScYgEQt8hn2i0B9bfAKRVFZAgQ+IDH7JmRWQzmt51GkerTH7uqIDat
	 TnoXpbdF12+tN8WK4MAplOsNHqMe9ZkWd8Mq+EAhxug1Zv5fAO9jycG6PpL/uhfL59
	 uTH/t/Mak5AaGT4r06uA5+GP0nEN3GybMMOWbsz9Y8EvaJz+lZfP6YJI4cAFoJyVNI
	 EjzxT6uCQiOgQ==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER)
Subject: [PATCH v9 09/13] x86/process: Clear hardware feedback history for AMD processors
Date: Tue, 22 Apr 2025 20:46:27 -0500
Message-ID: <20250423014631.3224338-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423014631.3224338-1-superm1@kernel.org>
References: <20250423014631.3224338-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <perry.yuan@amd.com>

Incorporate a mechanism within the context switching code to reset
the hardware history for AMD processors. Specifically, when a task
is switched in, the class ID was read and reset the hardware workload
classification history of CPU firmware and then it start to trigger
workload classification for the next running thread.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/process_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 24e1ccf229125..aba6d182a7d25 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -709,6 +709,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
-- 
2.43.0


