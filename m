Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF617BB92
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFLX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 06:23:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:33992 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFLX4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 06:23:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 03:23:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="234775985"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2020 03:23:52 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, andriy.shevchenko@intel.com,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH] tools/thermal: tmon: replace error message SIGINT with SIGTERM
Date:   Fri,  6 Mar 2020 17:00:11 +0530
Message-Id: <1583494211-31231-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the wrong error message reporting by replacing SIGINT with SIGTERM.
Fix multiple checkpatch errors and warnings.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 tools/thermal/tmon/tmon.c |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 83ec6e4..7eb3216 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -46,7 +46,7 @@
 
 pthread_t event_tid;
 pthread_mutex_t input_lock;
-void usage()
+void usage(void)
 {
 	printf("Usage: tmon [OPTION...]\n");
 	printf("  -c, --control         cooling device in control\n");
@@ -62,7 +62,7 @@ void usage()
 	exit(0);
 }
 
-void version()
+void version(void)
 {
 	printf("TMON version %s\n", VERSION);
 	exit(EXIT_SUCCESS);
@@ -70,7 +70,6 @@ void version()
 
 static void tmon_cleanup(void)
 {
-
 	syslog(LOG_INFO, "TMON exit cleanup\n");
 	fflush(stdout);
 	refresh();
@@ -96,7 +95,6 @@ static void tmon_cleanup(void)
 	exit(1);
 }
 
-
 static void tmon_sig_handler(int sig)
 {
 	syslog(LOG_INFO, "TMON caught signal %d\n", sig);
@@ -120,7 +118,6 @@ static void tmon_sig_handler(int sig)
 	tmon_exit = true;
 }
 
-
 static void start_syslog(void)
 {
 	if (debug_on)
@@ -167,7 +164,6 @@ static void prepare_logging(void)
 		return;
 	}
 
-
 	fprintf(tmon_log, "#----------- THERMAL SYSTEM CONFIG -------------\n");
 	for (i = 0; i < ptdata.nr_tz_sensor; i++) {
 		char binding_str[33]; /* size of long + 1 */
@@ -175,7 +171,7 @@ static void prepare_logging(void)
 
 		memset(binding_str, 0, sizeof(binding_str));
 		for (j = 0; j < 32; j++)
-			binding_str[j] = (ptdata.tzi[i].cdev_binding & 1<<j) ?
+			binding_str[j] = (ptdata.tzi[i].cdev_binding & (1 << j)) ?
 				'1' : '0';
 
 		fprintf(tmon_log, "#thermal zone %s%02d cdevs binding: %32s\n",
@@ -187,7 +183,6 @@ static void prepare_logging(void)
 				trip_type_name[ptdata.tzi[i].tp[j].type],
 				ptdata.tzi[i].tp[j].temp);
 		}
-
 	}
 
 	for (i = 0; i <	ptdata.nr_cooling_dev; i++)
@@ -219,7 +214,6 @@ static void prepare_logging(void)
 	{ 0, 0, NULL, 0 }
 };
 
-
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -283,7 +277,7 @@ int main(int argc, char **argv)
 	if (signal(SIGINT, tmon_sig_handler) == SIG_ERR)
 		syslog(LOG_DEBUG, "Cannot handle SIGINT\n");
 	if (signal(SIGTERM, tmon_sig_handler) == SIG_ERR)
-		syslog(LOG_DEBUG, "Cannot handle SIGINT\n");
+		syslog(LOG_DEBUG, "Cannot handle SIGTERM\n");
 
 	if (probe_thermal_sysfs()) {
 		pthread_mutex_destroy(&input_lock);
@@ -328,8 +322,7 @@ int main(int argc, char **argv)
 			show_cooling_device();
 		}
 		time_elapsed += ticktime;
-		controller_handler(trec[0].temp[target_tz_index] / 1000,
-				&yk);
+		controller_handler(trec[0].temp[target_tz_index] / 1000, &yk);
 		trec[0].pid_out_pct = yk;
 		if (!dialogue_on)
 			show_control_w();
@@ -340,14 +333,15 @@ int main(int argc, char **argv)
 	return 0;
 }
 
-static void start_daemon_mode()
+static void start_daemon_mode(void)
 {
 	daemon_mode = 1;
 	/* fork */
 	pid_t	sid, pid = fork();
-	if (pid < 0) {
+
+	if (pid < 0)
 		exit(EXIT_FAILURE);
-	} else if (pid > 0)
+	else if (pid > 0)
 		/* kill parent */
 		exit(EXIT_SUCCESS);
 
@@ -366,11 +360,9 @@ static void start_daemon_mode()
 	if ((chdir("/")) < 0)
 		exit(EXIT_FAILURE);
 
-
 	sleep(10);
 
 	close(STDIN_FILENO);
 	close(STDOUT_FILENO);
 	close(STDERR_FILENO);
-
 }
-- 
1.7.9.5

