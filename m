Return-Path: <linux-pm+bounces-22332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31EA3A709
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF7B188CC76
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2F28136E;
	Tue, 18 Feb 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM29XqyV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B33281363;
	Tue, 18 Feb 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905749; cv=none; b=V953DhMIFBSIEYvQixm/zSr1MdrOoTQIaDDfEZLZzUq7idxCH6U+1wpmizExKK+NWNlxtpsdZHDEIkPrrjA9g2sPGK7m/Fe0aORje5qx2W8GcZ0XmbZ1Sayje5VFfwiGaa7UkIULKMVb8UKTZROm3PSgJFrwis5V7Rt4QPtoD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905749; c=relaxed/simple;
	bh=SI1sRPnXmV2AWytIfSaxpRG24MRaOV6/z0jvYmJu0ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7+H97ZexRRRvBEXO/7uCD3aJGKPmKrLM71af9X5O759M3i6eHsAFehGjXxMLKkGPEDKVPrkLbMPSvun63f1oFecOZlyGecxRp4orEequv7+u5L6l9auq2c63ozJmFrl0whFoeuPfJe23/ugEOvfPgsRvA3JgtU6KnrpevfNlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM29XqyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A3C4CEE9;
	Tue, 18 Feb 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905749;
	bh=SI1sRPnXmV2AWytIfSaxpRG24MRaOV6/z0jvYmJu0ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MM29XqyVyD2JEs3mtEVhbTMSO0zM5lM9J6SlOgol5maq6slhT7+bchdEWluGedzkX
	 o8CEB7HezddAJtD+RNvSrQ6EtenYXl6McqeZCPWenp009RcuNokXQhRSN649yrx2a0
	 xvpHhgm+XGVw8yAVUuxreYtvYpKnNqe5+ISq9llyPb2cY4wt3o5u1jmmuXItuVwYJr
	 KCAEhpLY4pzARzw7m5sYYZfhqvEknGLab4YJWXrvQI2otpTDq9/etcvBSBhaBejxSn
	 SdvvWNXnRcl2VCIZ1Nl8WbiupjWQRjpz42/Wys/4tO4QAGm9i8fdNL6JGabbRCNia3
	 czg9R8dPWgEMQ==
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
Subject: [PATCH v8 09/13] x86/process: Clear hardware feedback history for AMD processors
Date: Tue, 18 Feb 2025 13:08:18 -0600
Message-ID: <20250218190822.1039982-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218190822.1039982-1-superm1@kernel.org>
References: <20250218190822.1039982-1-superm1@kernel.org>
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
index 226472332a70d..371e0e8f987fa 100644
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


