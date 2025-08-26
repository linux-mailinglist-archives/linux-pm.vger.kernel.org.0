Return-Path: <linux-pm+bounces-33080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444AB354DA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E42683833
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E032F60A5;
	Tue, 26 Aug 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ+Kt22d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D82D0629
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191370; cv=none; b=S8JiglvXAixfhaQ6Vkm/bYkmywHESrofa35V2U5b58y3ouqsKtfVdCk1uBVsyCTVQUiMJ/TC46PpVISRrOA/kOn9D1s3ivZMREURmATRdQMp5ezx6lCzqWmLy+NUFBXhdl8bL+JIr5MIMJt6jbwjVHaBWNIVBM0QHyR0lCtCl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191370; c=relaxed/simple;
	bh=vFDhDVMHeSWFdBiWuHeiXggkBHH/jJYQeEa2/k8lpMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJ/h/q1O9QIsLFf3qQsgqiO0kEwsG/seTTQXPBBZMgyyRCeMY4r5lSxKMrW4VD6Og5xkXldqwohM3OiLIattfXuAmIOS5yV/aQpXIxgee9gN8td4sKs75uxFHEBjCQJq9TcsgKIV9mbzu12SHE80Ai2d8c8rJP5RvwlpCS9XO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ+Kt22d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756191369; x=1787727369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vFDhDVMHeSWFdBiWuHeiXggkBHH/jJYQeEa2/k8lpMQ=;
  b=kZ+Kt22dBwBW/YbLCsl73+MKqhIXPzCzVa+xEbbVqGHUIJDvOOadvVym
   EEHfjCQ1BMEkbmXMzsnULk1OaeKn8jn4n24pWrsZ/KayMotsMECi3h6VZ
   xLYKBeTHIZ1GBWRraD7bjVGr/Bl4aGtdLuyVcRqdBSYiol5m+80rhzVHS
   vfdWBtiBF1mhLUBNClQdGTtoNQmuZeqNNbvMqStSr61GqobkCN8eSCtut
   OoK9NkeocbF69pZ+hYJMWt1G9oQ/cTT1g1qF2zeJ9bB+V3RWKwX/hDY0c
   fgw+ihknReHv5S9Z6DfxOHGgtkOuW6tPtHxMQSi8zYeFGyoINoawRGvlp
   Q==;
X-CSE-ConnectionGUID: n1y9laCOT+ixTwMm5g93Uw==
X-CSE-MsgGUID: cSJbfDkDTUGD27mJn4z7TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69010802"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69010802"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 23:56:08 -0700
X-CSE-ConnectionGUID: JtSECJnrTmu/WgpqWihzqA==
X-CSE-MsgGUID: 5C6wvqzbRgKCq7i+Lc9NkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173683406"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa003.jf.intel.com with ESMTP; 25 Aug 2025 23:56:06 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/cpupower: Fix incorrect size in cpuidle_state_disable()
Date: Tue, 26 Aug 2025 12:24:40 +0530
Message-Id: <20250826065440.2908389-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect size parameter passed to cpuidle_state_write_file() in
cpuidle_state_disable().

The function was incorrectly using sizeof(disable) which returns the
size of the unsigned int variable (4 bytes) instead of the actual
length of the string stored in the 'value' buffer.

Since 'value' is populated with snprintf() to contain the string
representation of the disable value, we should use strlen(value) to
get the correct string length for writing to the sysfs file.

This ensures the correct number of bytes is written to the cpuidle
state disable file in sysfs.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/lib/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index 0ecac009273c..2180e63c963a 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -244,7 +244,7 @@ int cpuidle_state_disable(unsigned int cpu,
 	snprintf(value, SYSFS_PATH_MAX, "%u", disable);
 
 	bytes_written = cpuidle_state_write_file(cpu, idlestate, "disable",
-						   value, sizeof(disable));
+						   value, strlen(value));
 	if (bytes_written)
 		return 0;
 	return -3;
-- 
2.34.1


