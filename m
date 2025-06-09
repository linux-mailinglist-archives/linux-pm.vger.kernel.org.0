Return-Path: <linux-pm+bounces-28326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2DAD274B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9A1894743
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114E2253F8;
	Mon,  9 Jun 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6XeH2mx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BA22423A;
	Mon,  9 Jun 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499544; cv=none; b=lL4ebOZtv6ANpYpb+UwFBEIutzQgPnOdwqyEOEYQUx1G4wFoVVWvldyMtIzGzrUZqghBQEQg2o7V8LHScvnxm3b5h1RqAOcbFymRUlLQ/dpuZLywBSqPvV3He+9eZw/wDtZM881TLMj9VmJfDte/eBFAPjpyT0uwAnDlZ6DWIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499544; c=relaxed/simple;
	bh=CC3ONKTbRtD9u8FsFEBcRqpmUcqJA7JDfWnuy7ME05E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLOQKkDF+E+rcRVJ4Vfe475yy4gyi+zs1VrHcagtPLAJX/Y7i/8rqKDDWYg3yZhAgbqhCrPsQl9WzByVu7piE+3xNKh119sdS61uO/w8H75cIf9NJ1RktXvckvSTjCbxRD+eT12jSbKCf3R1CLi+cmsvWCTj+bj0XX1A0/+KZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6XeH2mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836B6C4CEF0;
	Mon,  9 Jun 2025 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499544;
	bh=CC3ONKTbRtD9u8FsFEBcRqpmUcqJA7JDfWnuy7ME05E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6XeH2mx97jgo/6o57NQQrj2A+Xl8cJCzQQbu1BkSsyct/nF7eL9b5Z6btlF7pNMo
	 wlip4mu5w7psSaicD76pGWh3m0PNGNinDmpaKCyGE1hfgwpHA66/xQKxwihBsibH3+
	 2vFxQtlP0DdOuky1nPfaaH4kzXOluCmR2pj+e/EKIclO8ZGsXrX5/KVOQ6zCS/ZOhg
	 pBVAVpZeLKrqmCf9pUVWf33Ujv87Gj/zqc0/iKfFUqNQtdKOwCz2GY6CKCIoc36Fr3
	 cWZc0542WXy3AtRW+qiNuMO79opi7w9jxrlTTW3Uf0q7Yw9MIEB3DtMT1W/hsAAYbC
	 RdZn8SOqii4aQ==
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
Subject: [PATCH v11 09/13] x86/process: Clear hardware feedback history for AMD processors
Date: Mon,  9 Jun 2025 15:05:14 -0500
Message-ID: <20250609200518.3616080-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
References: <20250609200518.3616080-1-superm1@kernel.org>
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
v8:
 * Only for 64 bit
---
 arch/x86/kernel/process_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8d6cf25127aab..f386928c472db 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -707,6 +707,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_arch_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(MSR_AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
-- 
2.43.0


