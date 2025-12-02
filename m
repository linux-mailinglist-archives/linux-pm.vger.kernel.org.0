Return-Path: <linux-pm+bounces-39038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1DC9A609
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 07:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22473A2DE8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB72FFDED;
	Tue,  2 Dec 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjhyzfux"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2C2FD668
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764658591; cv=none; b=fS6k8874MUBfI6GNIxIDzd906CprPfXXSJtuB2n93+lTHZu7UJa8yTPO0sIrt8wJIb1wKRSqiqMT/qzeCy6lj/9rwhsanyVXL19PS7vz/QwdgWQWevW1JSmzq1hAf1/WajL/XpboOVYV4/DGHOZolKDXziGLxUhO4lyWIY8trkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764658591; c=relaxed/simple;
	bh=y9TedOtGrb+q2Jj9dc5gWhJV6kcy8dyS9g3hMk3HjDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KqsOa7CEGrt7/WVWMIgGtsd12OQtaSDXRYkjwDXpNGMBnP4F8a1Q+mx6yQCInzO/TCS6ozcmrJROw/vbig0o5Tfrj5rvatXvaC8QKlITg8+Ihwt+a0XkjZV62BnTlOyM6D0oalKA+F7mN00YwoAPM4zkHpy3f01jo31u/CLYJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjhyzfux; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764658590; x=1796194590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y9TedOtGrb+q2Jj9dc5gWhJV6kcy8dyS9g3hMk3HjDg=;
  b=mjhyzfuxCs9HTd9vSDU4A5GebcqlWND0P2GLMprjK1/zh6Afh5dsU4a2
   PUFAQQFswldq0UolN68rShdjpYC4ZBZgBcGvoPWea9u0TjSi22Kn9JMPl
   ZF6YQdAxaIEE3zW0E3EvY3TMe8c83ys/VtovX4z9RhP+G1I5XLcqiJgmA
   rGpA6Icd10n9VM9yvwpqJ/TIjaSIlReii2SiPJzfM5zUHS3IcYzBzVNsl
   O4fFI27Vzu4pK4+Tt1I75bVoU2kAVCUBbQV9w/ZLJGq58wT3aburPil8b
   6roxGlwTtIqi3qfLNcCnocvr1UEy1Sm236I4UNSzH/8/RmdZQABct+qjO
   Q==;
X-CSE-ConnectionGUID: v9T7LvZ3TdyqX/Ee+tvqgw==
X-CSE-MsgGUID: KvVBnhOsQ9uVF7osBhaq9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70465857"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="70465857"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 22:56:29 -0800
X-CSE-ConnectionGUID: B5Q9/ZZaTQul0MR25tVZJg==
X-CSE-MsgGUID: xy0oKEaIS+20vVVAwiax2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="194180060"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 01 Dec 2025 22:56:27 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power cpupower: Show C0 in idle-info dump
Date: Tue,  2 Dec 2025 12:24:03 +0530
Message-Id: <20251202065403.1492807-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`cpupower idle-info -o` skipped C0 because the loop began at 1:

  before:
    states:
      C1 ... latency[002] residency[00002]
      C2 ... latency[010] residency[00020]
      C3 ... latency[133] residency[00600]

  after:
    states:
      C0 ... latency[000] residency[00000]
      C1 ... latency[002] residency[00002]
      C2 ... latency[010] residency[00020]
      C3 ... latency[133] residency[00600]

Start iterating at index 0 so the idle report mirrors sysfs and
includes C0 stats.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpuidle-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index e0d17f0de3fe..81b4763a97d6 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -111,7 +111,7 @@ static void proc_cpuidle_cpu_output(unsigned int cpu)
 	printf(_("max_cstate:              C%u\n"), cstates-1);
 	printf(_("maximum allowed latency: %lu usec\n"), max_allowed_cstate);
 	printf(_("states:\t\n"));
-	for (cstate = 1; cstate < cstates; cstate++) {
+	for (cstate = 0; cstate < cstates; cstate++) {
 		printf(_("    C%d:                  "
 			 "type[C%d] "), cstate, cstate);
 		printf(_("promotion[--] demotion[--] "));
-- 
2.34.1


