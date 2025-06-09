Return-Path: <linux-pm+bounces-28330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D04D1AD275B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEFA7A38F3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D821229B02;
	Mon,  9 Jun 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU1diagR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC89228C9D;
	Mon,  9 Jun 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499552; cv=none; b=hWXJfJjs6uHl+YWC78TcmEYSRR+0X9VnQGu5giJs1n3RytmakPUV0l/A1Uo9p4NIdOomWZazbRX2Enbp1pJxyXB8xD1BHaKCE+4CwvPh3BsahWs9ShIFURpbFX8QYQCUNk1d8nJfjT/bfIZUOydetXnWhA/1j9oacH03F4m38P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499552; c=relaxed/simple;
	bh=ccxi92/CdYcFz5SRXc75fcFWq7DUZRAtA96LadU0vMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUwo/2osB/xjPO/BdEczGFn5pEo0s6tT0SvbWrjWi/9h1obKmkrwqDuyYgdtBg80o06Je++8Tx0OpXOEkjcyfx5rKep4fuq1b8gEqZns8jt10FjsTVzu8TYoopW186FmibKC9UUhI0ailtk75svBojiuJIplqHCY8CODWmZ/KIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU1diagR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DDFC4CEF2;
	Mon,  9 Jun 2025 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499551;
	bh=ccxi92/CdYcFz5SRXc75fcFWq7DUZRAtA96LadU0vMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RU1diagRRM9N/rrqnuVcJid6v3sYjjs4ARVPWzRA4HNyGSA9Cgdp/u0DOd7zH1Z/j
	 OBxrQfu01B0JycCekT+t4nPn90DvP01hr50A8cE4vYZG0ISAsoF77m7eWVJAYMEswg
	 k6G/RfXhZ5L87Ok9E0E4WuVeVdsDy0u8IyF31pQv7hZqLbHe6HiQPHsb/CprKmPhKe
	 ycsNk0UMmEUKz1V4GMpKr2Q05mIOjrGNbHSkBHVZ8sKb11hhR5Omq74yz9tR/+IUqn
	 v6pRyoRiewXti7ki3Hfx1xSpCPIhX0Hx4zD05kynXs5lXwg4pTrv+KG5cuy/TCCcEy
	 Zye38+GBreYng==
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
Subject: [PATCH v11 13/13] x86/itmt: Add debugfs file to show core priorities
Date: Mon,  9 Jun 2025 15:05:18 -0500
Message-ID: <20250609200518.3616080-14-superm1@kernel.org>
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


