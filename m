Return-Path: <linux-pm+bounces-8041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107518CC217
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B1A1C20CAD
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362213E03E;
	Wed, 22 May 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+4fKAbz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990C442F
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384456; cv=none; b=RwyzEdvDq6aG/RADzAr/g5J/6Ru9mIaUJBujSFtpASPt8FaEwU+iXyKSzlBAcBfVD6YaC/5A5M+gQq1ydVS1EBVjBMwZw/HCoMjNXv80EJ2k4El3ZCQoTrBZDg0KIxOTACowAH10T1rMvOjX46BpgfXmxo8kr9+CO02pywOYgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384456; c=relaxed/simple;
	bh=trbpxzKCCOs2w9bqUumSDSAjnj/dXdofVKeKQE2WMnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CrKKnQoea0jgy6AOjmWhBUyVQMmxAKYv/LQSMHyFc1X5ViXiyOsPmvqMpAnEmWR9UetQJ5OftXcL8PJ3lwyc4EpD37Eerklkhw9NpIG3wIsps1vOYkGskYT/r67efbdBTcHqPH/cmEXfddFT6nmXbo18xZHEfX33fUcY/QjFt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+4fKAbz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716384454; x=1747920454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=trbpxzKCCOs2w9bqUumSDSAjnj/dXdofVKeKQE2WMnw=;
  b=G+4fKAbzU+xF1CAvEdgd6zTvgEHPh5M7jnpgAawecbo0GMdxX0gf9cqW
   ukJ/27GbcfmOlYPLuovPQuEendHcGGx8g6j3MNxpjLP2bXgPeth4AC6Tx
   8TYC9xrPHS8ztn9/RgJJzA8MrL4j/aOdtxYJUUBfXYzhnCUumCCW0cz1J
   3X64a2ndNjhKmZWMtVwZoYiYQmhaHLaImJzgj3+QQZ/CEioh1DYk+NntW
   8p5JC84Q4H/JGD1S3OdeqZqJOy5q+n8IFic67tmVGyGBmAOZVm2cK0z6A
   PGkumeBUpSU6//AzxdLL/yOY37KXELN5Ga2cd+Mo3CjuRAqq5zSb9qm+0
   Q==;
X-CSE-ConnectionGUID: 3o3J6JJ5QaajnlM0Nvjk/w==
X-CSE-MsgGUID: 2LMZKlojQKKMcRSNb8914A==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12472370"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12472370"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 06:27:33 -0700
X-CSE-ConnectionGUID: 4ZmmLXmbSyi5lNNEXgifRw==
X-CSE-MsgGUID: s1vlZNbHRtSk7hGA+7n1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33402917"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa009.jf.intel.com with ESMTP; 22 May 2024 06:27:32 -0700
From: Adam Hawley <adam.james.hawley@intel.com>
To: len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Fix unc freq columns not showing with '-q' or '-l'
Date: Wed, 22 May 2024 16:27:21 +0300
Message-ID: <20240522132721.284785-1-adam.james.hawley@intel.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 78464d7681f7 ("tools/power turbostat: Add columns for clustered
uncore frequency") introduced 'probe_intel_uncore_frequency_cluster()'
in a way which prevents printing uncore frequency columns if either of
the '-q' or '-l' options are used. Systems which do not have multiple
uncore frequencies per package are unaffected by this regression.

Fix the function so that uncore frequency columns are shown when either
the '-l' or '-q' option is used by checking if 'quiet' is true after
adding counters for the uncore frequency columns.

Fixes: 78464d7681f7 ("tools/power turbostat: Add columns for clustered uncore frequency")
Signed-off-by: Adam Hawley <adam.james.hawley@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8cdf41906e98..2368194751dc 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5695,9 +5695,6 @@ static void probe_intel_uncore_frequency_cluster(void)
 	if (access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00/current_freq_khz", R_OK))
 		return;
 
-	if (quiet)
-		return;
-
 	for (uncore_max_id = 0;; ++uncore_max_id) {
 
 		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", uncore_max_id);
@@ -5727,6 +5724,14 @@ static void probe_intel_uncore_frequency_cluster(void)
 		sprintf(path, "%s/fabric_cluster_id", path_base);
 		cluster_id = read_sysfs_int(path);
 
+		sprintf(path, "%s/current_freq_khz", path_base);
+		sprintf(name_buf, "UMHz%d.%d", domain_id, cluster_id);
+
+		add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
+
+		if (quiet)
+			continue;
+
 		sprintf(path, "%s/min_freq_khz", path_base);
 		k = read_sysfs_int(path);
 		sprintf(path, "%s/max_freq_khz", path_base);
@@ -5743,11 +5748,6 @@ static void probe_intel_uncore_frequency_cluster(void)
 		sprintf(path, "%s/current_freq_khz", path_base);
 		k = read_sysfs_int(path);
 		fprintf(outf, " %d MHz\n", k / 1000);
-
-		sprintf(path, "%s/current_freq_khz", path_base);
-		sprintf(name_buf, "UMHz%d.%d", domain_id, cluster_id);
-
-		add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
 	}
 }
 
-- 
2.43.1

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


