Return-Path: <linux-pm+bounces-25996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A35CA97C74
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6057AD773
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E929267F4F;
	Wed, 23 Apr 2025 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujR1UScJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA43267AE4;
	Wed, 23 Apr 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372844; cv=none; b=X1ziPdTRT8bm5A+LGRjqWxBuOwE8ylZPL6/CEa4hGtqiZWeA+4JbqjWG1can/iFf2b+arRzzfsYXhikZk8SZv+dGkBujHblby3aEBmxZpln3xB6g6HnUgC4ZOtr3LpecgUGJCA8sxxQ0Sd/onQX+HwxA9VOz34qegjpnCJBi5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372844; c=relaxed/simple;
	bh=ccxi92/CdYcFz5SRXc75fcFWq7DUZRAtA96LadU0vMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjXDs3dCXTRX61DMUTtkDQbUXTlrCYtKdO24PdQA9hG0XSkgR0KY75m8JUypu8lAG27761aPf2dV8dC3TqRs5FHPbTGHw0Rd16jAl4fmqCxyR4OqV6hNWoDeEasNa3tLvQKivvFg+k8ooD8/iJ9mtoWKeMcdAVAjiQSGn1y2LhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujR1UScJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1987BC4CEEE;
	Wed, 23 Apr 2025 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372843;
	bh=ccxi92/CdYcFz5SRXc75fcFWq7DUZRAtA96LadU0vMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujR1UScJejlUs1alli6VXzUXGfUIDyMk9IrMKs1cxV+cMhuf1302e3ybpaVW3/CP4
	 q+C45d9L9JPn0ValsgWx/aXx+h8/xhDs6OwtLOaEsrLuxm/3pxpgm1abBuYKNlM07K
	 Si1dQyIzS8XAiGXVpAaL1N3nzfb90A7t982bLeb2x4L4knXyvqAgRPh7FExkIir1/2
	 7vJiijOxV8idcCvI1lE9Vd5FW7/K1aY/M/isabS/DLFJYCgAfrljoAdF7HxfdbDhmG
	 u6b4kJw9pUbgVc5RspMxATfTUoI5Q2JEsepYkQLejk3jxrbGoMZMcYSDNNW8xflCTD
	 vZ+snsINadrQw==
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
Subject: [PATCH v9 13/13] x86/itmt: Add debugfs file to show core priorities
Date: Tue, 22 Apr 2025 20:46:31 -0500
Message-ID: <20250423014631.3224338-14-superm1@kernel.org>
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


