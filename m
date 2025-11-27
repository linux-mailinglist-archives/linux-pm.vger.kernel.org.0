Return-Path: <linux-pm+bounces-38765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CF2C8CD00
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 05:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF5B3A63CC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 04:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9030E828;
	Thu, 27 Nov 2025 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvH/BDiY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDA238D5A
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764218882; cv=none; b=VrCLYUvM2pkbyeLp8VJfYZfLMl8yUscFiLuVVoGgQZm6Ie36v6Jow5tkkBPRNqjhDb/pzSu7Pi7HkymRb2CPFSskc5J1vrZBAtWLdojKnkjujGde7AmKBAO6CxM+F0VEYqLQ6KM0nlN/wl1eoP/DQVGnZCCS9WaR/JelApAg9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764218882; c=relaxed/simple;
	bh=/+Sz/XrRakYdsGN4hLMC4sySaRhp4xZ1qgEhnQljr30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GHDAaLA47N1phcP0/nLLH7Qs+c2WCtQgdcjprpTvGXVAgff2yQgbXmhC3aN+oxv1BXWgnDpQagtGzA9SUAXHts1isy6YgYmysvGmNdBp5MAcFnauSJg1jlzotQRqQz1ZcQXtrun3pe5Hn2lcS+VdBym0MIDC0GCSVOK95QuWuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvH/BDiY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764218880; x=1795754880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/+Sz/XrRakYdsGN4hLMC4sySaRhp4xZ1qgEhnQljr30=;
  b=AvH/BDiYRpCQcy0ll2gAhgdxY5MM1oy6d0sQro4teG0MhEAtncx+tmeD
   cxUSEuL416VCgdWe/rydvP7yFvfxbgXWcXAKCSDtDtnSJSVHMpcbH9YOn
   OchTYDPEaTwc6WCpEBT5K0wmtRSRA6tkOm5FavQF00jN49C9/YPyocSoS
   uwVexWshwyVGLsLCwYLg4KO/G4HUcBa7God9K6dB0QfXR/fjGHvvbUlYh
   Vt3amMGRSJc6uVao13rC6ys85z2ye8LDFBNXHKlaq2qwScce1yhZJqdGk
   QxFP8Tjp9JrcE25uhWUZ7QKC/Qvw69BtfR8/TGK74ohoN4sXYUdlY6eK7
   A==;
X-CSE-ConnectionGUID: RQ/AY+d3QTC65Fca7BqR+w==
X-CSE-MsgGUID: gORFDD9RQxSVkL0FIoHeQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66221106"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66221106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 20:48:00 -0800
X-CSE-ConnectionGUID: 2ezeHhW+RQ2rZc1jJAKX1g==
X-CSE-MsgGUID: m5f+H5XzQ/uqf1lyoJsr+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="224085581"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2025 20:47:58 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/cpupower: Use strcspn() to strip trailing newline
Date: Thu, 27 Nov 2025 10:15:36 +0530
Message-Id: <20251127044536.715722-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual newline removal with strcspn() which is safer and
cleaner. This avoids potential out-of-bounds access on empty strings
and handles the case where no newline exists.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/lib/cpuidle.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index f2c1139adf71..6a881d93d2e9 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -193,8 +193,7 @@ static char *cpuidle_state_get_one_string(unsigned int cpu,
 	if (result == NULL)
 		return NULL;
 
-	if (result[strlen(result) - 1] == '\n')
-		result[strlen(result) - 1] = '\0';
+	result[strcspn(result, "\n")] = '\0';
 
 	return result;
 }
@@ -366,8 +365,7 @@ static char *sysfs_cpuidle_get_one_string(enum cpuidle_string which)
 	if (result == NULL)
 		return NULL;
 
-	if (result[strlen(result) - 1] == '\n')
-		result[strlen(result) - 1] = '\0';
+	result[strcspn(result, "\n")] = '\0';
 
 	return result;
 }
-- 
2.34.1


