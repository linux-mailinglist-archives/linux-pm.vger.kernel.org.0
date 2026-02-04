Return-Path: <linux-pm+bounces-42053-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDgREIEqg2maiwMAu9opvQ
	(envelope-from <linux-pm+bounces-42053-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:16:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E2BE4FAC
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D60B302FA93
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4326F3E95AC;
	Wed,  4 Feb 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZWmjeg/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8D3D1CCC
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203649; cv=none; b=eQPjd7R9I02Dzmaakhephm2Re5mj2XPtwP1syCGOv44yWLSZb6T7E2QOUZklBo04U5otGbQH5eiK9QeDU55DC39rQUrC+Cv1iAU7SLj/hTgBLQzbfUOWfnyHyVdJ0rUnSfDL2h5ocLLDhi3uxaj4hgTFeTrnIXmTL8DJ7Gp8idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203649; c=relaxed/simple;
	bh=kvI7oFxsImXNZpuyTR036sqYTCtbb2jnQnMLNJ6919k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q0OCcnWF+CmRP6svjWifvPpn3DQlfnL9s6T41sQIO9OW1WeEk6SKgzlLrU8YqeeTTYEEGAwsDQ1od2Upv3Xyp1O/Oeq4jhvGqKyRLWjXYeNHtLktFAKsyIqFmbKv1MkgOqJ/zOSK2gglftZX+r9GisIgobsBRC0EXI5gMMtNW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZWmjeg/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770203649; x=1801739649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kvI7oFxsImXNZpuyTR036sqYTCtbb2jnQnMLNJ6919k=;
  b=BZWmjeg/phzXBPhtqOZhArWKs/Y8EGCgoiJUzfmq3IzZ0ex79erXobYA
   1TrrPH3XlLmqiJ7/JwbTdg+B49Otg4pSUHs69PUGkWZtRbLuHZ72U+lQv
   lkl1IgZApvP+h/UCN7s5Z4xhxC+2s4m0JRBcCvGC1fgy5DelIj7dekKp6
   w662lC4lPW29dRpLwZNXJ91bZHvb7XuxCyfe4wnTMKc2bzNDkUQLD6yBM
   4ufs9kOspE9pWUKlMSXELlv3oHbgQs9dNA7NQWEVGbElZ2sPgkFzVoztN
   cuuHLI0WEaoIjEPkDymmjGfK1A1C/MMgoRGBom/YdT2Y8eNC8LIxZzzsc
   A==;
X-CSE-ConnectionGUID: HIGb/9GcS+mbmKii4zztKQ==
X-CSE-MsgGUID: gkYbIKWWQfCvJ4ygiWKjdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70405977"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="70405977"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:14:08 -0800
X-CSE-ConnectionGUID: OM0TpsyQQ0aIrmTq0yQcTA==
X-CSE-MsgGUID: vtvQmz+KT5iUFa/OJyV3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209739134"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa006.fm.intel.com with ESMTP; 04 Feb 2026 03:14:06 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpupower: Remove incorrect EPP dependency in get_latency()
Date: Wed,  4 Feb 2026 16:41:04 +0530
Message-Id: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
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
	TAGGED_FROM(0.00)[bounces-42053-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 91E2BE4FAC
X-Rspamd-Action: no action

The get_latency() function incorrectly called get_epp() and
returned error if EPP (Energy Performance Preference) was not
available, even though transition latency and EPP are completely
independent CPU frequency features.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 5fe01e516817..4a9172f4599f 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -459,9 +459,6 @@ static int get_latency(unsigned int cpu, unsigned int human)
 {
 	unsigned long latency = cpufreq_get_transition_latency(cpu);
 
-	if (!get_epp(cpu, false))
-		return -EINVAL;
-
 	printf(_("  maximum transition latency: "));
 	if (!latency || latency == UINT_MAX) {
 		printf(_(" Cannot determine or is not supported.\n"));
-- 
2.34.1


