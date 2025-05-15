Return-Path: <linux-pm+bounces-27216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAB1AB91A7
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D9F7B61A1
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074EA29B8FB;
	Thu, 15 May 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utRktGWo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAB2980C2;
	Thu, 15 May 2025 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344016; cv=none; b=jDc+zhcfigpm0Sqd5lTSHMa1KQiQa29LfTYwVpKXNS9l53yP1NUoj/MNlvmFCoJKRQzoItGlePtYyP7T4fVpL38YZGeyIcxDkuAdq4lzPxpzPearUGMlSBDGSPafUVEnSpvLGzPmuhPuaw+4uLKMJwngc5d+mUesloxfM9Ki8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344016; c=relaxed/simple;
	bh=wNnL8W6bUGlGgnFxf75mSRXIwH84JOfIf/StjigsqEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IstQdrp5J5hk2/vhDJT2DBzD8WYgxjcwXMxuUHzFaTtsQJb/3T8EEq7L1zN99Hnu/qPkhTLP1VRkInHIecfNQfO8A3z4EtEXB/DEMbyh9atssE40+jlvOY/zvVo7zQmBwYYxs58drwpaqt8ohw5hH41Kup+a6GBtfuODlg+Ralo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utRktGWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD9EC4CEF0;
	Thu, 15 May 2025 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344016;
	bh=wNnL8W6bUGlGgnFxf75mSRXIwH84JOfIf/StjigsqEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utRktGWowgBPaC9dRb7s6b9yYSAYm6/gVc6NAgOk+ESa/XR+bm6Gnu9TdCyZNULU1
	 pRSs4vT+Rc3gmHPMObvWUui6ckxfjQvzPt8GoHU+ehBz8jmvtA438KmxPO81PvIlbc
	 Qt2bZxspXAjCgENaYOgZuALQj8boYeXAQFQR96yvTAjZq68VlG+YkgEldkK0DAOYTE
	 2g2elRS89aaOmg+Rj3/ILK4Lrl2hDzNqL5M4WL1EKr+NpHMAoDZMI69T5NAmALePv0
	 EpuhuR6AT6Mx5Ykbx2ao5pnn+TBYBHsJLCPwAMC5UKoh41zakOiOXcb3Ind2kWjVc3
	 0sVL7YWNmIlDw==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
Subject: [PATCH v10 09/13] x86/process: Clear hardware feedback history for AMD processors
Date: Thu, 15 May 2025 16:19:46 -0500
Message-ID: <20250515211950.3102922-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515211950.3102922-1-superm1@kernel.org>
References: <20250515211950.3102922-1-superm1@kernel.org>
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
index f39ff02e498d7..3ceb93b784013 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -707,6 +707,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
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


