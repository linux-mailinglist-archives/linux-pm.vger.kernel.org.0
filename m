Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB47437BBE3
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhELLg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 07:36:26 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:34549 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhELLgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 07:36:25 -0400
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 0FDCB8081D;
        Wed, 12 May 2021 07:27:48 -0400 (EDT)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id 177A26004D;
        Wed, 12 May 2021 07:27:47 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.208])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id 6551960051;
        Wed, 12 May 2021 07:27:46 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 1/2] cpupower: implement the multi-cpu monitoring of programs
Date:   Wed, 12 May 2021 07:26:57 -0400
Message-Id: <20210512112658.89965-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we look inside cpupower/ToDo, the current 6th point makes mention of
a method to implement multi-cpu monitoring without introducing noise to
the tested program itself.

Suggested-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 .../utils/idle_monitor/cpupower-monitor.c     | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 7c77045fef52..5fc9b38be4e5 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -278,7 +278,7 @@ void list_monitors(void)
 	}
 }
 
-int fork_it(char **argv)
+int fork_it(int cpu, char **argv)
 {
 	int status;
 	unsigned int num;
@@ -315,9 +315,9 @@ int fork_it(char **argv)
 
 	timediff = timespec_diff_us(start, end);
 	if (WIFEXITED(status))
-		printf(_("%s took %.5f seconds and exited with status %d\n"),
-			argv[0], timediff / (1000.0 * 1000),
-			WEXITSTATUS(status));
+		printf(_("cpu %d: %s took %.5f seconds and exited with status %d\n"),
+			cpu, argv[0],
+			timediff / (1000.0 * 1000), WEXITSTATUS(status));
 	return 0;
 }
 
@@ -388,7 +388,8 @@ int cmd_monitor(int argc, char **argv)
 {
 	unsigned int num;
 	struct cpuidle_monitor *test_mon;
-	int cpu;
+	int cpu, status;
+	pid_t child_pid;
 
 	cmdline(argc, argv);
 	cpu_count = get_cpu_topology(&cpu_top);
@@ -440,10 +441,21 @@ int cmd_monitor(int argc, char **argv)
 	/*
 	 * if any params left, it must be a command to fork
 	 */
-	if (argc - optind)
-		fork_it(argv + optind);
-	else
+	if (argc - optind) {
+		for (cpu = 0; cpu < cpu_count; cpu++) {
+			child_pid = fork();
+			if (!child_pid) {
+				bind_cpu(cpu);
+				fork_it(cpu, argv + optind);
+				exit(EXIT_SUCCESS);
+			} else if (waitpid(child_pid, &status, 0) == -1) {
+				perror("waitpid");
+				exit(EXIT_FAILURE);
+			}
+		}
+	} else {
 		do_interval_measure(interval);
+	}
 
 	/* ToDo: Topology parsing needs fixing first to do
 	   this more generically */
-- 
2.31.1

