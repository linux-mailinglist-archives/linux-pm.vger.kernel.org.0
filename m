Return-Path: <linux-pm+bounces-42037-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDKJHznYgmnCcwMAu9opvQ
	(envelope-from <linux-pm+bounces-42037-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:25:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC1E1EDE
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E6B305DA74
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 05:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54DF357A20;
	Wed,  4 Feb 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGRs32Pn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F48460
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182703; cv=none; b=AqVT87ftv8/20YzK5nKolXiaLeMicNHJGr12/r3oxirXRByBAWhVOv4jx9LZDXmXmisEFy2GIhuJghsHoUrjd8Dhop1gE3cFkLzIclxjm40lLC3k8I0hTuACisBfwP/Gy8EfHibj3GClUK94nCXjIJ+InsmRVfWVHzCfT549KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182703; c=relaxed/simple;
	bh=KW9FX4bGDqFaflbS5JDbDlQguKJVlkU0laWJCDl6nzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epuZQJnZzVuKUXJ1adv29qJ9e88gHXs8v/pjirq8tPrxm8HNv8d7bQow6x85ehdhVr+I9CzrZchsgCenRBz0dk9YW/c31UKQwOfR1cyLzt8n1s4dh5tcXwdZrXzPHjFr+RG1jlv3TNsYbUodeCNuaZksSUER2oJLf6CpIadJkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGRs32Pn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770182703; x=1801718703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KW9FX4bGDqFaflbS5JDbDlQguKJVlkU0laWJCDl6nzA=;
  b=mGRs32PndkT0JV++vnonKKVuG2HdDVeiuOq8Us0FEVv5pKeGHZedmf7P
   Dh9uRbEGOnlm78XzYCbOII4Nj11YfyJy5BwykJh3iCC0Iof8BLb4jh+xS
   l4AkZMzgrWi319+H7lPzzxXTzAJ7dTR/KZoDIuTBbyGGXZM3Yt7ggJQcC
   P0276mEWwrNTueSLUEzJUDdwltinV6pE/TEWNp7zmeryLozekJo1b2Aus
   ti30ruNVDCaG6taVf3KvD0T1CKulyRWmPQcjnuAGg4/9gxY2NplqW8Slc
   IHHPBZITUzVRBbotEhXTJtw4BRpQjQb4kru2jkT0M71i11xKcPgwaDtaV
   Q==;
X-CSE-ConnectionGUID: FK7JUk6cSaKaQwOFJ7MuTg==
X-CSE-MsgGUID: R9wNSSO1Ruyp3fMGkHtQow==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82795522"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82795522"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:25:03 -0800
X-CSE-ConnectionGUID: j61OfFUzQdW64cEA8ZZj+Q==
X-CSE-MsgGUID: F8fCDkrvQHajaqt+3DTTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214543304"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Feb 2026 21:25:01 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/cpupower: Avoid out-of-bounds access on empty strings
Date: Wed,  4 Feb 2026 10:51:43 +0530
Message-Id: <20260204052143.3281063-5-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42037-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 1CCC1E1EDE
X-Rspamd-Action: no action

If sysfs_get_idlestate_string() or sysfs_get_cpuidle_driver() returns
an empty string, accessing result[strlen(result) - 1] causes an
out-of-bounds access at result[-1].

Add length check before removing the trailing newline to prevent this.
Also avoid redundant strlen() calls by caching the length.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/lib/cpuidle.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index f2c1139adf71..9b7a420a489c 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -193,8 +193,9 @@ static char *cpuidle_state_get_one_string(unsigned int cpu,
 	if (result == NULL)
 		return NULL;
 
-	if (result[strlen(result) - 1] == '\n')
-		result[strlen(result) - 1] = '\0';
+	len = strlen(result);
+	if (len > 0 && result[len - 1] == '\n')
+		result[len - 1] = '\0';
 
 	return result;
 }
@@ -366,8 +367,9 @@ static char *sysfs_cpuidle_get_one_string(enum cpuidle_string which)
 	if (result == NULL)
 		return NULL;
 
-	if (result[strlen(result) - 1] == '\n')
-		result[strlen(result) - 1] = '\0';
+	len = strlen(result);
+	if (len > 0 && result[len - 1] == '\n')
+		result[len - 1] = '\0';
 
 	return result;
 }
-- 
2.34.1


