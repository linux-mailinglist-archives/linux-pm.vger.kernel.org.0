Return-Path: <linux-pm+bounces-34820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F52B7CFDD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAB63A507B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 05:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFF264609;
	Wed, 17 Sep 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mD5opI51"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2261A9FAA
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085802; cv=none; b=p40hSyoXpHKqrjip/vb48fg2BAXc7FklOKr7+Gv7NDvJjwROIfgvP11Xo6PuuAQ7HGgyoNssuvBXaRWGcMqjJjFwaytpKEhqSK0ubOZ7oFRV9Wpt5FqrO0MB6028wFE49+kQUV4zNe1mXVzl0U7ekHktD0/MXLyyQfqKqlxrb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085802; c=relaxed/simple;
	bh=K87NnOC7QVkRmrW5+4RLFdDooFM0hmGxu0n6SzkBMYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euhhEDI410QwG01a7PlUu9+vfFZyBJCRtbkgZysSEpXNye9Q3UV03zjqCnCawEO0kwmUQ0PK+G1Ny+KsihoJtLkRCamxalLPC3aLeXVXOCPaZNQQgJlNrB/KXJGLGVyn7r5EcMh0romPQCjJHUVwNuQ2UhD/6yhpvAHvk78qdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mD5opI51; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758085800; x=1789621800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K87NnOC7QVkRmrW5+4RLFdDooFM0hmGxu0n6SzkBMYY=;
  b=mD5opI51lIBjvaoQ2xzT5aYjfRBwFRXcXEQgNCu/Dl7UCiu7dxAnhIkg
   Rdk5pI70SQKZBbbVzg3iqxlp+blyJU+4UgdMHm0T9H0bhfSQX8mxzFCBs
   0k6l3+C+NDcCFXCfwqTw6SUGXl8x4vXFDn7cu1VEbtf4cTt8CmE62FqFn
   1HtUemcwmt/YHmdP/A6pKhIZ8kfmTikWE5a6y9iLBJYkDVp4ZdQeup4EM
   VQ3AdDuVOEfQ84/+7fKwsD2psUewer7ufh4FjpVrZj9XWW6EoTdNguntk
   DKoUtIcM2dKslr9v1gBiXl/JTP7Sc/Qtw6RCK7M9ERabdppcc7Hf5V5mj
   Q==;
X-CSE-ConnectionGUID: 1gnTAo0xRZmJtA4TM/w/bg==
X-CSE-MsgGUID: zPhFSNq9QwGNNzY1oUSYZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="77989574"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="77989574"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:10:00 -0700
X-CSE-ConnectionGUID: OSQq0nO+RJeuOzDQGzQjIA==
X-CSE-MsgGUID: PKEwTUkVTaOuSpqLFBwJ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="212287781"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 22:09:58 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] tools/cpupower: Fix incorrect size in cpuidle_state_disable()
Date: Wed, 17 Sep 2025 10:38:20 +0530
Message-Id: <20250917050820.1785377-1-kaushlendra.kumar@intel.com>
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
representation of the disable value, we should use the length
returned by snprintf() to get the correct string length for
writing to the sysfs file.

This ensures the correct number of bytes is written to the cpuidle
state disable file in sysfs.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Use snprintf() return value instead of strlen() for better efficiency

 tools/power/cpupower/lib/cpuidle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index 0ecac009273c..f2c1139adf71 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -233,6 +233,7 @@ int cpuidle_state_disable(unsigned int cpu,
 {
 	char value[SYSFS_PATH_MAX];
 	int bytes_written;
+	int len;
 
 	if (cpuidle_state_count(cpu) <= idlestate)
 		return -1;
@@ -241,10 +242,10 @@ int cpuidle_state_disable(unsigned int cpu,
 				 idlestate_value_files[IDLESTATE_DISABLE]))
 		return -2;
 
-	snprintf(value, SYSFS_PATH_MAX, "%u", disable);
+	len = snprintf(value, SYSFS_PATH_MAX, "%u", disable);
 
 	bytes_written = cpuidle_state_write_file(cpu, idlestate, "disable",
-						   value, sizeof(disable));
+						   value, len);
 	if (bytes_written)
 		return 0;
 	return -3;
-- 
2.34.1


