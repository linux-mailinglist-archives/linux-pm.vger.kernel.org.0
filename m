Return-Path: <linux-pm+bounces-42035-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMt3ITTYgmnCcwMAu9opvQ
	(envelope-from <linux-pm+bounces-42035-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:25:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E28E1ED7
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8967306224C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B8357A20;
	Wed,  4 Feb 2026 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjpY0hrG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D28460
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182696; cv=none; b=RfBmSKYMLH/BBjxELbxaiFx+aOkEx6bnxSLn5NyccBw5C9yHZrFickKbOEJsHUBRiR/ZITNGfNbUhM2HH95p9bvQM4oFMejZ+Q31Md0zU9uRVBUPrORzT4jdvzbDerIlb6eNgKvxFroIWUPwkPc6Fx6fnO9mxAF6jbYrDxzlnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182696; c=relaxed/simple;
	bh=GkQrDjhcaqdWpWAkoVMQASyvq/PZUzQ5Sn3wqGxREKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOt6G4yvO6dI/N2QfzBuF2LXP7lVax0quvsGnj1dqm/Qu35qKwuQO5suQ5oCu6qgAlPm+9G0GCBnkynnNprqSXPkUGlvSTkj+mTlvYwEAexvGNSUOmgf5MV7ODBJSBssJDKXv+JLVAD8BYMQ4awBenKfnCv4aur90BvugVWRQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjpY0hrG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770182695; x=1801718695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkQrDjhcaqdWpWAkoVMQASyvq/PZUzQ5Sn3wqGxREKo=;
  b=jjpY0hrGWQcoa13c4jGOG21e69JWMnsKWWRv/78xbzy8Z2Wy4WRAffCr
   r0W8VywVfKKE/kKTly0vMfMzkIJiZANVjqrGJ0KwM3BWixInDz4LFc0mV
   2LeUMX7qXdnM0UMysztOeOqIvuIEMJogDDtPx5zsCwNdQ9Qmvxkbw7xpV
   gJfnRvShVIMt5NLnAipTZWz8EYszXoBc9h4PgZ4IAVZHr37fsrFAm091c
   KVXUF7r60oGOvQlR2yxzL27gJEoiBTgGjmNuMceRE9li9NHGChe3sEWi2
   Sr92Ml9pUNUoMsQy3Yrs9GAlVFC447NN4llC3Gx8hWa3qx49QKC3rVScB
   Q==;
X-CSE-ConnectionGUID: HeSIb3bbSm+gA3Whf05Sng==
X-CSE-MsgGUID: SymacAEGQNyhOWbcN6WVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82795505"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82795505"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:24:55 -0800
X-CSE-ConnectionGUID: uePMOxHDQVCINlYq1MShyg==
X-CSE-MsgGUID: MzUicamCRV2ppRFpUJhkxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214543246"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Feb 2026 21:24:53 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH 2/3] cpupower: Fix memory leaks on early exit paths
Date: Wed,  4 Feb 2026 10:51:41 +0530
Message-Id: <20260204052143.3281063-3-kaushlendra.kumar@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42035-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D0E28E1ED7
X-Rspamd-Action: no action

Add cleanup_resources() helper function to properly free
globally allocated bitmasks (cpus_chosen, online_cpus,
offline_cpus) before calling exit().

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpupower.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 9ec973165af1..3d3c5768c5d7 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -172,6 +172,17 @@ static void handle_options(int *argc, const char ***argv)
 	*argv += new_argc;
 }
 
+static void cleanup_resources(void) {
+	if (cpus_chosen)
+		bitmask_free(cpus_chosen);
+	if (online_cpus)
+		bitmask_free(online_cpus);
+	if (offline_cpus)
+		bitmask_free(offline_cpus);
+	cpus_chosen = NULL;
+	online_cpus = NULL;
+	offline_cpus = NULL;
+}
 int main(int argc, const char *argv[])
 {
 	const char *cmd;
@@ -193,6 +204,7 @@ int main(int argc, const char *argv[])
 
 	if (argc < 1) {
 		print_help();
+		cleanup_resources();
 		return EXIT_FAILURE;
 	}
 
@@ -208,6 +220,7 @@ int main(int argc, const char *argv[])
 	base_cpu = sched_getcpu();
 	if (base_cpu < 0) {
 		fprintf(stderr, _("No valid cpus found.\n"));
+		cleanup_resources();
 		return EXIT_FAILURE;
 	}
 
@@ -230,17 +243,14 @@ int main(int argc, const char *argv[])
 		if (!run_as_root && p->needs_root) {
 			fprintf(stderr, _("Subcommand %s needs root "
 					  "privileges\n"), cmd);
+			cleanup_resources();
 			return EXIT_FAILURE;
 		}
 		ret = p->main(argc, argv);
-		if (cpus_chosen)
-			bitmask_free(cpus_chosen);
-		if (online_cpus)
-			bitmask_free(online_cpus);
-		if (offline_cpus)
-			bitmask_free(offline_cpus);
+		cleanup_resources();
 		return ret;
 	}
 	print_help();
+	cleanup_resources();
 	return EXIT_FAILURE;
 }
-- 
2.34.1


