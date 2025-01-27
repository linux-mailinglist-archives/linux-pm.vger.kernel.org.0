Return-Path: <linux-pm+bounces-20986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BFA20157
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 00:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754881885FA2
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A111C8FBA;
	Mon, 27 Jan 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+cIRIMO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0B1EB2A
	for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019068; cv=none; b=Afg2+3NY2eX1qFJf180x+jgVehARCL9F+xQmeFxRPKS6rQr1DEqn7Icqa2viaXrghzjc03LfXC8ucNFARs++z8nEPNj5ykcXQfHveB44PyIih7iob5caw2JKwWK30Ye2EP4Rjnd3qwAep+kiCEuaNOhzmwg3WzdjHymiq5v828g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019068; c=relaxed/simple;
	bh=KzDEjIKV0LgmstFm9XF7UtXw8M55lJiV3LYCD9Vb7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZcwDsiaryTLas+ZCyAGDwNh0mBOgBLTbewXSJt4/88M94gyNAX8OxbNg3SssLQxO42x4Xo9CWZ5E8dbqKBQy7qRPhUvX3yX0GBTvog+pEvwsG8GHEGMLhgYemPSYKEjYvKYRkLjJ0dz4tClj+vOLhMi2YzEUeZvn1FY4J6/k7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+cIRIMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76193C4CED2;
	Mon, 27 Jan 2025 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738019068;
	bh=KzDEjIKV0LgmstFm9XF7UtXw8M55lJiV3LYCD9Vb7Pc=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=i+cIRIMO8AhxzDcGzrtqhSqMDYYAnPsFvABht+6aLn7SzqOIAAhBqS8CM0HpO0IDQ
	 UggzxbsHuXfkgiUZGpXLCqGzXSed1xJpkU7eJdakqC2uJv0d+wSxaod5kSuQdNl/j+
	 IkQMcr+2xURGfA2kzO4TBgs/E02Lm/fHNWwN4hA3+fCnjOxRMA0fRqQ0F6GyS/N845
	 9tw7azTjwcoxr5BryXqcEtOWQEHjG3mM+ALxgrDDwwWidVjsMvWENMORNmNB4fk4fr
	 VAKSZZcdCnP0+wrdwEVCLWVdzWCaxWgP9HUh6K6LyPoeEZ0rXrRPayDv0ZSHs5iOxF
	 1IHgCiSNcJ+Ew==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [RFC/PATCH] tools/power turbostat: Fix forked child affinity regression
Date: Mon, 27 Jan 2025 17:04:08 -0600
Message-ID: <20250127230410.38443-2-lenb@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

In "one-shot" mode, turbostat
1. takes a counter snapshot
2. forks and waits for a child
3. takes the end counter snapshot and prints the result.

But turbostat counter snapshots currently use affinity to travel
around the system so that counter reads are "local", and this
affinity must be cleared between #1 and #2 above.

The offending commit removed that reset that allowed the child
to run on cpu_present_set.

Fix that issue, and improve upon the original by using
cpu_possible_set for the child.  This allows the child
to also run on CPUs that hotplug online during its runtime.

Reported-by: Zhang Rui <rui.zhang@intel.com>
Fixes: 7bb3fe27ad4f ("tools/power/turbostat: Obey allowed CPUs during startup")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 54 ++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ecaa4e0fb2c0..1f188a0908da 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1120,8 +1120,8 @@ int backwards_count;
 char *progname;
 
 #define CPU_SUBSET_MAXCPUS	1024	/* need to use before probe... */
-cpu_set_t *cpu_present_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
-size_t cpu_present_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
+cpu_set_t *cpu_present_set, *cpu_possible_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
+size_t cpu_present_setsize, cpu_possible_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
 #define MAX_ADDED_THREAD_COUNTERS 24
 #define MAX_ADDED_CORE_COUNTERS 8
 #define MAX_ADDED_PACKAGE_COUNTERS 16
@@ -8488,6 +8488,33 @@ int dir_filter(const struct dirent *dirp)
 		return 0;
 }
 
+char *possible_file = "/sys/devices/system/cpu/possible";
+char possible_buf[1024];
+
+int initialize_cpu_possible_set(void)
+{
+	FILE *fp;
+
+	fp = fopen(possible_file, "r");
+	if (!fp) {
+		warn("open %s", possible_file);
+		return -1;
+	}
+	if (fread(possible_buf, sizeof(char), 1024, fp) == 0) {
+		warn("read %s", possible_file);
+		goto err;
+	}
+	if (parse_cpu_str(possible_buf, cpu_possible_set, cpu_possible_setsize)) {
+		warnx("%s: cpu str malformat %s\n", possible_file, cpu_effective_str);
+		goto err;
+	}
+	return 0;
+
+err:
+	fclose(fp);
+	return -1;
+}
+
 void topology_probe(bool startup)
 {
 	int i;
@@ -8519,6 +8546,16 @@ void topology_probe(bool startup)
 	CPU_ZERO_S(cpu_present_setsize, cpu_present_set);
 	for_all_proc_cpus(mark_cpu_present);
 
+	/*
+	 * Allocate and initialize cpu_possible_set
+	 */
+	cpu_possible_set = CPU_ALLOC((topo.max_cpu_num + 1));
+	if (cpu_possible_set == NULL)
+		err(3, "CPU_ALLOC");
+	cpu_possible_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
+	CPU_ZERO_S(cpu_possible_setsize, cpu_possible_set);
+	initialize_cpu_possible_set();
+
 	/*
 	 * Allocate and initialize cpu_effective_set
 	 */
@@ -9371,6 +9408,18 @@ void turbostat_init()
 	}
 }
 
+void affinitize_child(void)
+{
+	/* Prefer cpu_possible_set, if available */
+	if (sched_setaffinity(0, cpu_possible_setsize, cpu_possible_set)) {
+		warn("sched_setaffinity cpu_possible_set");
+
+		/* Otherwise, allow child to run on same cpu set as turbostat */
+		if (sched_setaffinity(0, cpu_allowed_setsize, cpu_allowed_set))
+			warn("sched_setaffinity cpu_allowed_set");
+	}
+}
+
 int fork_it(char **argv)
 {
 	pid_t child_pid;
@@ -9386,6 +9435,7 @@ int fork_it(char **argv)
 	child_pid = fork();
 	if (!child_pid) {
 		/* child */
+		affinitize_child();
 		execvp(argv[0], argv);
 		err(errno, "exec %s", argv[0]);
 	} else {
-- 
2.43.0


