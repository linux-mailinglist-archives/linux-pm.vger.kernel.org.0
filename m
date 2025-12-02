Return-Path: <linux-pm+bounces-39032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64414C9A061
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 05:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E4453456F7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 04:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E3223328;
	Tue,  2 Dec 2025 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EltibmCi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCD176ADE
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650561; cv=none; b=dwGhnC7XC6RwUUMcDwkGSnidgN+SmR5AVcIUID8VmdijmZ0vxhLeg0mdco1frLJlADNHnrmGl65EDDjBJegt3mo/BY55GqjpOxikk/AG02HeuDYjFZ44Fx1N+MdYxJETAjYeMJwXnhD2kL2y1TNOZDR+2JN8Q5EDRFKZf8tTNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650561; c=relaxed/simple;
	bh=BJ8cgT3Dr2koz1kzBObFsRxUFQoc+HhdZxu0Usv420w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tw/7wG1yVkRALUyp2F2WnugUd/SOpYUSVWfGefmBga4q4u0nGR8tHwWjk96KaQ63fWcyl9szaK45wvRFTYfbFiLh8YWEdoZqF9xI8uOjO922+5RW/fMpQTE+LY8xjw3vXTG1gsgooV34AT0cJ5jEguwIbETZ1smGdYDilrn6EIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EltibmCi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764650559; x=1796186559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BJ8cgT3Dr2koz1kzBObFsRxUFQoc+HhdZxu0Usv420w=;
  b=EltibmCiwTZbYBHV5eRyXHjqL/bxCkq/voW/ydIsn75vf7rCbl+sSU2i
   /zfxRP9u1wUk5bkUQkuZwD8ZbP+v7+jairxhWiBByCBP+HAG+kB/K4IA5
   FLKwmHUGxUj/Mdq3UV4XSTRQNUuyiCyLdU2jiQkTXjbMgB55RrFItrVaB
   LAZXJ7KHzLauIYIm97KGOJ5sZ7d9fp42xuv4FDcqza14Y2xsTJKZ40tK6
   gzGDILxwiXhSRlOB+NOLRC/baFp33p0VNt4XUoEzrlsQc+GeiE4+QSKwA
   XPjXHr8q4yTLlTDb7t4TtTXHVJ3v4G41z6u2mYEKvC/q/03l4fLhQXiZq
   w==;
X-CSE-ConnectionGUID: fXWMB0/gQlio4Jag5DM0dw==
X-CSE-MsgGUID: ZLdPHdxqRH60XSc+M4klaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="65608276"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="65608276"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 20:42:38 -0800
X-CSE-ConnectionGUID: qwLn2PMbQZmLQW1/rRG+6g==
X-CSE-MsgGUID: jE2UjM2GSu6bfK65/mKnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="224960818"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Dec 2025 20:42:36 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpupower: idle_monitor: fix incorrect value logged after stop
Date: Tue,  2 Dec 2025 10:10:12 +0530
Message-Id: <20251202044012.3844790-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cpuidle sysfs monitor printed the previous sample’s counter
value in cpuidle_stop() instead of the freshly read one. The dprint
line used previous_count[cpu][state] while current_count[cpu][state]
had just been populated. This caused misleading debug output.

Switch the logging to current_count so the post-interval snapshot
matches the displayed value.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 8b42c2f0a5b0..4225eff9833d 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -70,7 +70,7 @@ static int cpuidle_stop(void)
 			current_count[cpu][state] =
 				cpuidle_state_time(cpu, state);
 			dprint("CPU %d - State: %d - Val: %llu\n",
-			       cpu, state, previous_count[cpu][state]);
+			       cpu, state, current_count[cpu][state]);
 		}
 	}
 	return 0;
-- 
2.34.1


