Return-Path: <linux-pm+bounces-23528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58552A50F31
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 23:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A70A188C5F0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B1262D0C;
	Wed,  5 Mar 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6bipTka"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E452459CC;
	Wed,  5 Mar 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215225; cv=none; b=GuhuqcPJzF1TZJQWELAWaafIgpyetfy0/pYyq24bg3Taqgg6fbQzqG02bk0YU3YY7N4O4KR+2kR2YRcBfGyKam2XKUN3wQZyZTtc1hLlbL+u2xvTT7xH/pV3UjmNulQAUdVQdJQZwgXes877y5KzM57lWBb31C68w8Lb8ymO2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215225; c=relaxed/simple;
	bh=ZmBQXKeDJ/oli6LAZSEpY/fC5UuY/yv/eZLzhYt8/AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3Q4qCOUjGZOXA7R3wSFOcxl8fwDaja13I5PZkh7K2vwFLe3NXc2HWNyl+9qCCtXM2I1r5pT/z2tjsjFS/O8PkzIGs4bxKEqP2FXsm4cQFpMt8Kug0iQhOCIUsjSHqixyv8eP4Z98dCW8tx/b45ExmlPqBKkWXCFb2TlZbxHt2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6bipTka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54BDC4CED1;
	Wed,  5 Mar 2025 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741215225;
	bh=ZmBQXKeDJ/oli6LAZSEpY/fC5UuY/yv/eZLzhYt8/AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6bipTkauDpyLBt8oZNkpqRzTntk+68MupJC6thsCCM5RomqBg9cyVLvmQpFQbvVw
	 QLWg9ExEyYeWs5tf/FIYJkKJeOejYtomEO0FHWV8J2ww+ntxQ6LZs1EahurniEXKqk
	 FDA1ZUidm8iTa1TyOei/oCg0KZYLTppkcJwvkGos=
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pm: cpupower: remove hard-coded topology depth values
Date: Wed,  5 Mar 2025 15:53:40 -0700
Message-ID: <20250305225342.19447-3-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305225342.19447-1-skhan@linuxfoundation.org>
References: <20250305225342.19447-1-skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove hard-coded topology depth values and replace them with
defines to improve code readability and maintainability in
cpupower-monitor code.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../utils/idle_monitor/cpupower-monitor.c     | 40 ++++++++++++++-----
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 0380d2e70016..ad493157f826 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -92,7 +92,11 @@ int fill_string_with_spaces(char *s, int n)
 	return 0;
 }
 
-#define MAX_COL_WIDTH 6
+#define MAX_COL_WIDTH		6
+#define TOPOLOGY_DEPTH_PKG	3
+#define TOPOLOGY_DEPTH_CORE	2
+#define TOPOLOGY_DEPTH_CPU	1
+
 void print_header(int topology_depth)
 {
 	int unsigned mon;
@@ -114,12 +118,19 @@ void print_header(int topology_depth)
 	}
 	printf("\n");
 
-	if (topology_depth > 2)
+	switch (topology_depth) {
+	case TOPOLOGY_DEPTH_PKG:
 		printf(" PKG|");
-	if (topology_depth > 1)
+		break;
+	case TOPOLOGY_DEPTH_CORE:
 		printf("CORE|");
-	if (topology_depth > 0)
+		break;
+	case	TOPOLOGY_DEPTH_CPU:
 		printf(" CPU|");
+		break;
+	default:
+		return;
+	}
 
 	for (mon = 0; mon < avail_monitors; mon++) {
 		if (mon != 0)
@@ -153,12 +164,19 @@ void print_results(int topology_depth, int cpu)
 	    cpu_top.core_info[cpu].pkg == -1)
 		return;
 
-	if (topology_depth > 2)
+	switch (topology_depth) {
+	case TOPOLOGY_DEPTH_PKG:
 		printf("%4d|", cpu_top.core_info[cpu].pkg);
-	if (topology_depth > 1)
+		break;
+	case TOPOLOGY_DEPTH_CORE:
 		printf("%4d|", cpu_top.core_info[cpu].core);
-	if (topology_depth > 0)
+		break;
+	case TOPOLOGY_DEPTH_CPU:
 		printf("%4d|", cpu_top.core_info[cpu].cpu);
+		break;
+	default:
+		return;
+	}
 
 	for (mon = 0; mon < avail_monitors; mon++) {
 		if (mon != 0)
@@ -454,15 +472,15 @@ int cmd_monitor(int argc, char **argv)
 	/* ToDo: Topology parsing needs fixing first to do
 	   this more generically */
 	if (cpu_top.pkgs > 1)
-		print_header(3);
+		print_header(TOPOLOGY_DEPTH_PKG);
 	else
-		print_header(1);
+		print_header(TOPOLOGY_DEPTH_CPU);
 
 	for (cpu = 0; cpu < cpu_count; cpu++) {
 		if (cpu_top.pkgs > 1)
-			print_results(3, cpu);
+			print_results(TOPOLOGY_DEPTH_PKG, cpu);
 		else
-			print_results(1, cpu);
+			print_results(TOPOLOGY_DEPTH_CPU, cpu);
 	}
 
 	for (num = 0; num < avail_monitors; num++) {
-- 
2.45.2


