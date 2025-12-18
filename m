Return-Path: <linux-pm+bounces-39687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC50CCCDD3E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9ED03079AAD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4833290F;
	Thu, 18 Dec 2025 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSEzXV9O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0674331201;
	Thu, 18 Dec 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096771; cv=none; b=LQA7enKU3GoFVJDSFXqg9gaYSDgjRmJMPzGLZ1v+91/eIOdllcf3cANsQ5zQ/1VNTuWbeKIYCYfIxaWFzgZpkJAZGSIay45JCep0zWzsDEXExQT7VUkcRmAP9qZfiLvtZd4Izi49tM1MFsnFIXKQ+ZmcSPZh4udoCKfUCfN6+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096771; c=relaxed/simple;
	bh=8gapdIC1wUXz8+bbuwPpFHjchY0o4gI12RGOrPBSP6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgLX1vgxl1DZEZ1qViVUsHXPbhTbURbw0sC1qYgU764jayGbNc49nkFsuT1Tlzz3ThzC5qBwgilpHJ4YSQ7f2TNN5YxY9w3yqLW/AEgpkjcLlpHc/yV65pQFQvOrVq7cGqi3h+qYlgZbM3MkN7bVqqIJYrdoSummovz5FFKV6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSEzXV9O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766096770; x=1797632770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8gapdIC1wUXz8+bbuwPpFHjchY0o4gI12RGOrPBSP6U=;
  b=dSEzXV9OeVbAK8ZyYhtlH9dtO5qnKKSqYYw67odDNMMETSEDVtmZOflR
   brbYyGbedjK0e5YWTGADqkQjK9gDb7g7ng9EXXzmMOVOumREHc2GGH6Si
   TfC0DNoCXfYJbmJKtWn32bsrD5EjKGgavWWGeQWo9NXkGNdIwPPkNGtji
   b0JmOKn2c5wcbm5hPAhvkSZKnxspYJqxtdC0Ua+JoD9I7GBzdY579n1TU
   sWIdDUUDU6Y+1A+NVV02r4O3xOP2jON1/FtrSS77DhZXLoQo10zKTeph0
   XOZjt449tAHR6U7QtGXR6cccC/JM/EyBnNRojkX4ARJN1eXE5AUeeaZ3i
   Q==;
X-CSE-ConnectionGUID: /6mjRaFtSOqaO2yPsYWS7w==
X-CSE-MsgGUID: fvv29PuZQDeFLrrp/a8uHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79519096"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="79519096"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:26:06 -0800
X-CSE-ConnectionGUID: vkkl7OAuRkKYjsjelFydUA==
X-CSE-MsgGUID: 4o8Zhz7IQWqDoohKwpITaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="197851498"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa006.jf.intel.com with ESMTP; 18 Dec 2025 14:26:07 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] thermal: intel: selftests: workload_hint: Support slow workload hints
Date: Thu, 18 Dec 2025 14:25:59 -0800
Message-ID: <20251218222559.4110027-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
References: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add option to enable slow workload type hints. User can specify
"slow" as the command line argument to enable slow workload type hints.
There are two slow workload type hints: "power" and "performance".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/workload_hint/workload_hint_test.c  | 74 +++++++++++++------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index ca2bd03154e4..569d44f22835 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -12,6 +12,7 @@
 
 #define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay_ms"
 #define WORKLOAD_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enable"
+#define WORKLOAD_SLOW_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_slow_hint_enable"
 #define WORKLOAD_TYPE_INDEX_ATTRIBUTE  "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_type_index"
 
 static const char * const workload_types[] = {
@@ -22,6 +23,9 @@ static const char * const workload_types[] = {
 	NULL
 };
 
+static int wlt_slow;
+static char *wlt_enable_attr;
+
 #define WORKLOAD_TYPE_MAX_INDEX	3
 
 void workload_hint_exit(int signum)
@@ -30,7 +34,7 @@ void workload_hint_exit(int signum)
 
 	/* Disable feature via sysfs knob */
 
-	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
+	fd = open(wlt_enable_attr, O_RDWR);
 	if (fd < 0) {
 		perror("Unable to open workload type feature enable file");
 		exit(1);
@@ -46,6 +50,26 @@ void workload_hint_exit(int signum)
 	close(fd);
 }
 
+static void update_delay(char *delay_str)
+{
+	int fd;
+
+	printf("Setting notification delay in ms to %s\n", delay_str);
+
+	fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
+	if (fd < 0) {
+		perror("Unable to open workload notification delay");
+		exit(1);
+	}
+
+	if (write(fd, delay_str, strlen(delay_str)) < 0) {
+		perror("Can't set delay");
+		exit(1);
+	}
+
+	close(fd);
+}
+
 int main(int argc, char **argv)
 {
 	struct pollfd ufd;
@@ -54,32 +78,26 @@ int main(int argc, char **argv)
 	char delay_str[64];
 	int delay = 0;
 
-	printf("Usage: workload_hint_test [notification delay in milli seconds]\n");
+	printf("Usage: workload_hint_test [notification delay in milli seconds][slow]\n");
 
 	if (argc > 1) {
-		ret = sscanf(argv[1], "%d", &delay);
-		if (ret < 0) {
-			printf("Invalid delay\n");
-			exit(1);
-		}
+		int i;
 
-		printf("Setting notification delay to %d ms\n", delay);
-		if (delay < 0)
-			exit(1);
+		for (i = 1; i < argc; ++i) {
+			if (!strcmp(argv[i], "slow")) {
+				wlt_slow = 1;
+				continue;
+			}
 
-		sprintf(delay_str, "%s\n", argv[1]);
-		fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR);
-		if (fd < 0) {
-			perror("Unable to open workload notification delay");
-			exit(1);
-		}
+			ret = sscanf(argv[1], "%d", &delay);
+			if (ret < 0) {
+				printf("Invalid delay\n");
+				exit(1);
+			}
 
-		if (write(fd, delay_str, strlen(delay_str)) < 0) {
-			perror("Can't set delay");
-			exit(1);
+			sprintf(delay_str, "%s\n", argv[1]);
+			update_delay(delay_str);
 		}
-
-		close(fd);
 	}
 
 	if (signal(SIGINT, workload_hint_exit) == SIG_IGN)
@@ -89,8 +107,13 @@ int main(int argc, char **argv)
 	if (signal(SIGTERM, workload_hint_exit) == SIG_IGN)
 		signal(SIGTERM, SIG_IGN);
 
+	if (wlt_slow)
+		wlt_enable_attr = WORKLOAD_SLOW_ENABLE_ATTRIBUTE;
+	else
+		wlt_enable_attr = WORKLOAD_ENABLE_ATTRIBUTE;
+
 	/* Enable feature via sysfs knob */
-	fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR);
+	fd = open(wlt_enable_attr, O_RDWR);
 	if (fd < 0) {
 		perror("Unable to open workload type feature enable file");
 		exit(1);
@@ -145,6 +168,13 @@ int main(int argc, char **argv)
 			if (ret < 0)
 				break;
 
+			if (wlt_slow) {
+				if (index & 0x10)
+					printf("workload type slow:%s\n", "power");
+				else
+					printf("workload type slow:%s\n", "performance");
+			}
+
 			index &= 0x0f;
 			if (index > WORKLOAD_TYPE_MAX_INDEX)
 				printf("Invalid workload type index\n");
-- 
2.51.0


