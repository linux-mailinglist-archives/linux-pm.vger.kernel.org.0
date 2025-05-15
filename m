Return-Path: <linux-pm+bounces-27220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A6AB91B6
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9CF4E74E0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF429DB73;
	Thu, 15 May 2025 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOZTCYE1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98E29DB69;
	Thu, 15 May 2025 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344024; cv=none; b=EfheTduqp+q5JYnMnWn5wFhJIET5b969pNjCk6zVkMAyVAfApdBCihaxGFFZKBizGkOHLdVvVTIWnpLkhEjISjjUsF/kTrypU48vmtGU5IccFxAQx7j7tRjwOVkJ7CPzHOUIvFKrfA0OVwfFogmregxwjVxQefOm9ktmmTyC2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344024; c=relaxed/simple;
	bh=ccxi92/CdYcFz5SRXc75fcFWq7DUZRAtA96LadU0vMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my4P3RsIETlE7AO9sxP80OQOkhLWv/5gxSVO3VyWDjKgESVddb8LSbFGLAR+t+3dUXwbaYYCzOmQpVeiDEPUGuch2i++NrBlZWws2ZU//kceGyfqdZyG6r3oSOvlDIftz01sFMcQt9OBYGE1ZXVy8nJcg4AL957O+EZEPCaZwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOZTCYE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90BEC4CEE7;
	Thu, 15 May 2025 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344024;
	bh=ccxi92/CdYcFz5SRXc75fcFWq7DUZRAtA96LadU0vMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOZTCYE1AfYxSnTPuiMx3EDc6y/a2uA5klS8tlrZUT+kTUswdV2mpHwHq2PtgCZ2D
	 beD2/4FeQp06ZQGtEqdbeuWVZ+ZMTrBW5jJiaMuEgixFX5CPKyBQt1anoB+RaBO7yN
	 0B39LvVbQ25TALtekJjBCIGICa8Q0xb9G801WX9SEWofhEgbPlPN2jMMfPrGl3U+Fz
	 Xu3Y3HBREIsStb/Eu4Z1ZmQQdoneTyPpd3glVAQzHIYAP6Xe7hIWsqpUoe/Fb0Prfu
	 JiJDWPTpLQvmVxenU7fFJqIE/z6JwYfdWzEkxLzURnyRL9Y75xkm2OCFrVUxCBVqlc
	 RLRGWTk2EeeLg==
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
Subject: [PATCH v10 13/13] x86/itmt: Add debugfs file to show core priorities
Date: Thu, 15 May 2025 16:19:50 -0500
Message-ID: <20250515211950.3102922-14-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Multiple drivers can report priorities to ITMT. To aid in debugging
any issues with the values reported by drivers introduce a debugfs
file to read out the values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/itmt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9cea1fc36c18f..243a769fdd97b 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -59,6 +59,18 @@ static ssize_t sched_itmt_enabled_write(struct file *filp,
 	return result;
 }
 
+static int sched_core_priority_show(struct seq_file *s, void *unused)
+{
+	int cpu;
+
+	seq_puts(s, "CPU #\tPriority\n");
+	for_each_possible_cpu(cpu)
+		seq_printf(s, "%d\t%d\n", cpu, arch_asym_cpu_priority(cpu));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(sched_core_priority);
+
 static const struct file_operations dfs_sched_itmt_fops = {
 	.read =         debugfs_read_file_bool,
 	.write =        sched_itmt_enabled_write,
@@ -67,6 +79,7 @@ static const struct file_operations dfs_sched_itmt_fops = {
 };
 
 static struct dentry *dfs_sched_itmt;
+static struct dentry *dfs_sched_core_prio;
 
 /**
  * sched_set_itmt_support() - Indicate platform supports ITMT
@@ -102,6 +115,14 @@ int sched_set_itmt_support(void)
 		return -ENOMEM;
 	}
 
+	dfs_sched_core_prio = debugfs_create_file("sched_core_priority", 0644,
+						  arch_debugfs_dir, NULL,
+						  &sched_core_priority_fops);
+	if (IS_ERR_OR_NULL(dfs_sched_core_prio)) {
+		dfs_sched_core_prio = NULL;
+		return -ENOMEM;
+	}
+
 	sched_itmt_capable = true;
 
 	sysctl_sched_itmt_enabled = 1;
@@ -133,6 +154,8 @@ void sched_clear_itmt_support(void)
 
 	debugfs_remove(dfs_sched_itmt);
 	dfs_sched_itmt = NULL;
+	debugfs_remove(dfs_sched_core_prio);
+	dfs_sched_core_prio = NULL;
 
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */
-- 
2.43.0


