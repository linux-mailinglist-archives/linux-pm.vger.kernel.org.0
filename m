Return-Path: <linux-pm+bounces-40704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CAD17443
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 09:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951F4301EC7E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 08:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12C37FF5F;
	Tue, 13 Jan 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Smo0LM5a"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474B37FF5B
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292545; cv=none; b=OSEtqYJBOXtCBHoj10J2R5uDvUtnsAu2v4m4ZZ0wjckA207E/1Z/lxwuPRbo2xsfaHzbxHZD9tHUMO6DMSF5kwEDjZVYxQ92MdNJDV01+1GMkUkzLqrwhAgtH6Ev0Jvt/2VzBupk3n/ER+N1heO/RijlevJP1pCFOc1krOxdxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292545; c=relaxed/simple;
	bh=QYy017ud3X2P8zyxkN25/LzHClPAXOl0t8j6t1rie7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftx2G5yMYI0saAnKA6O9fcaPjcQypwc/uj+YstGdTTUiGraDkyYTzPqJa8PBdokeDpzFSm22x/+67Um0xGMpiWgkKRXEQM+MwmlRkAT+zlC0pC1obGsykF1KV7GLGzZjbxWKYvhcQZaSgpYdV+DWwB+aCGNc9yD1IL8hd0wtc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Smo0LM5a; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768292532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=In6W7QGhm3hj4MpGLTokEuKe9UtWFKLeItnsJKhhMtI=;
	b=Smo0LM5aT8zumZTrS7MKh3ETKajkG2popBoIZJQlSrTTXPLWdihPVlqpJrh3Ix9ibPI40F
	+m/V047SY3t2OGU/iHl1oozpP7/V8gje9sXvD+4OMd01GPyzYqy3VVL14vLv8u1hp8tNGV
	TyVpPnoWBIm++Nufp5N2yQ/D7Xsx0Po=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: Use sysfs_emit in sysfs show functions
Date: Tue, 13 Jan 2026 09:21:26 +0100
Message-ID: <20260113082130.789891-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred to format sysfs output as it provides better
bounds checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/intel/therm_throt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index debc94e2dc16..44fa4dd15dd1 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/sysfs.h>
 #include <linux/cpu.h>
 
 #include <asm/processor.h>
@@ -144,8 +145,8 @@ static ssize_t therm_throt_device_show_##event##_##name(		\
 									\
 	preempt_disable();	/* CPU hotplug */			\
 	if (cpu_online(cpu)) {						\
-		ret = sprintf(buf, "%lu\n",				\
-			      per_cpu(thermal_state, cpu).event.name);	\
+		ret = sysfs_emit(buf, "%lu\n",				\
+			per_cpu(thermal_state, cpu).event.name);	\
 	} else								\
 		ret = 0;						\
 	preempt_enable();						\
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


