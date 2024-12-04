Return-Path: <linux-pm+bounces-18518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816889E33FE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C948167E93
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF7D186E52;
	Wed,  4 Dec 2024 07:19:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005A184;
	Wed,  4 Dec 2024 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296799; cv=none; b=hNChl8sVQAnLIiaYPoHYfw7pHGrOxJsQJb9ytBI0mtdFSRvkYMZNTpRHLvhGEqJSmY2u3Avdirjir/rSzW/diCyQzI39G5muo05l1vD9w1nkqB+HijffqgZxQrm75STprCdgf7GlXXkeCfBYKcfS7eEAdswGxuBTP9xyMwnGozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296799; c=relaxed/simple;
	bh=9mQhTzx1m4a091ltr0G5mqMtvcS7YCCzjfG1w5xrjI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvmSgRB1rc9j5gMsr/9QVNksplg3TCzXOZOds0SqtebMqwo/cq8hdfsOnWeEcRvyJDNknyytCGMn9/vramC1UPiBJoqhoRutWsoi3T+SbiEhin7DfciVk5Skz8IDdOrej1RxVKxys/bC7WtjR+eC1Tb8kQ+BcS9w9oYAFdYKN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <trenn@suse.com>, <shuah@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jwyatt@redhat.com>, <jkacur@redhat.com>, <romeusmeister@gmail.com>,
	wangfushuai <wangfushuai@baidu.com>
Subject: [PATCH] cpupower: revise is_valid flag handling for idle_monitor
Date: Wed, 4 Dec 2024 15:02:47 +0800
Message-ID: <20241204070247.3669-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 10.127.64.16
X-FE-Policy-ID: 52:10:53:SYSTEM

The is_valid flag should reflect the validity state of both
the XXX_start and XXX_stop functions. But the use of '=' in
XXX_stop overwrites the validity state set by XXX_start. This
commit changes '=' to '|=' in XXX_stop to preserve and combine
the validity state of XXX_start and XXX_stop.

Signed-off-by: wangfushuai <wangfushuai@baidu.com>
---
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c  | 4 ++--
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 2 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c      | 2 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index 55e55b6b42f9..f5a2a326b1b7 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -117,7 +117,7 @@ static int hsw_ext_start(void)
 
 	for (num = 0; num < HSW_EXT_CSTATE_COUNT; num++) {
 		for (cpu = 0; cpu < cpu_count; cpu++) {
-			hsw_ext_get_count(num, &val, cpu);
+			is_valid[cpu] = !hsw_ext_get_count(num, &val, cpu);
 			previous_count[num][cpu] = val;
 		}
 	}
@@ -134,7 +134,7 @@ static int hsw_ext_stop(void)
 
 	for (num = 0; num < HSW_EXT_CSTATE_COUNT; num++) {
 		for (cpu = 0; cpu < cpu_count; cpu++) {
-			is_valid[cpu] = !hsw_ext_get_count(num, &val, cpu);
+			is_valid[cpu] |= !hsw_ext_get_count(num, &val, cpu);
 			current_count[num][cpu] = val;
 		}
 	}
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index ae6af354a81d..0a03573ebcc2 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -148,7 +148,7 @@ static int mperf_measure_stats(unsigned int cpu)
 	ret = get_aperf_mperf(cpu, &aval, &mval);
 	aperf_current_count[cpu] = aval;
 	mperf_current_count[cpu] = mval;
-	is_valid[cpu] = !ret;
+	is_valid[cpu] |= !ret;
 
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
index 16eaf006f61f..6b1733782ffa 100644
--- a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
@@ -151,7 +151,7 @@ static int nhm_stop(void)
 
 	for (num = 0; num < NHM_CSTATE_COUNT; num++) {
 		for (cpu = 0; cpu < cpu_count; cpu++) {
-			is_valid[cpu] = !nhm_get_count(num, &val, cpu);
+			is_valid[cpu] |= !nhm_get_count(num, &val, cpu);
 			current_count[num][cpu] = val;
 		}
 	}
diff --git a/tools/power/cpupower/utils/idle_monitor/snb_idle.c b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
index 811d63ab17a7..5969b88a85b4 100644
--- a/tools/power/cpupower/utils/idle_monitor/snb_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
@@ -115,7 +115,7 @@ static int snb_start(void)
 
 	for (num = 0; num < SNB_CSTATE_COUNT; num++) {
 		for (cpu = 0; cpu < cpu_count; cpu++) {
-			snb_get_count(num, &val, cpu);
+			is_valid[cpu] = !snb_get_count(num, &val, cpu);
 			previous_count[num][cpu] = val;
 		}
 	}
@@ -132,7 +132,7 @@ static int snb_stop(void)
 
 	for (num = 0; num < SNB_CSTATE_COUNT; num++) {
 		for (cpu = 0; cpu < cpu_count; cpu++) {
-			is_valid[cpu] = !snb_get_count(num, &val, cpu);
+			is_valid[cpu] |= !snb_get_count(num, &val, cpu);
 			current_count[num][cpu] = val;
 		}
 	}
-- 
2.36.1


