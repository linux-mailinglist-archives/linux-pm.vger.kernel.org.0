Return-Path: <linux-pm+bounces-42036-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKS7HzHYgmnCcwMAu9opvQ
	(envelope-from <linux-pm+bounces-42036-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:25:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1947E1EC9
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99C3F301681B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DB3590BB;
	Wed,  4 Feb 2026 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI0aEoLT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FB8460
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182699; cv=none; b=ikYnE/GKgVKZZIxpIE7F0eBfY6G2PRRiWc7pUayrMV4FkJD3GqHINoNlhumwVTvAzn2/e07wDpsGruhJWLJiwxcK3+LsxvXiXSlMhVuep1JPTl2RUoOykeGMLzYFpjtNFjG8ILX6atqee4aghVraGsnqv9vNpWbQEEfRsXoUPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182699; c=relaxed/simple;
	bh=e7Xdp08cgT3/DGtVRxBZ2OKzkA2puvdCLzfKUz41I+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRd3I586PgaD074I4BGe3VZvKQjwc/GAa+nNUQzSQVwkxuMyFB/Lopli9sma8+MVsIm7CcIgArQf7t6hGVnZ/uj76r0GTCSrAqnBdegkKKedVf9NsytnuQVvczvF9wDi8VcHJy98Ziq3kKk5J8AFaFM3egvKBVWwVnPXe7JSTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI0aEoLT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770182699; x=1801718699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7Xdp08cgT3/DGtVRxBZ2OKzkA2puvdCLzfKUz41I+c=;
  b=KI0aEoLTtmk5NPWcwG1nydLEMeKzMXV7004EWVMAMBDUbgoxLkek8jza
   lw8FQbTqZuMXpWa/6PnJHFgI/CAEpc8TzMezxcWMyrwy5bTo1BUG1g76B
   FWbGsKPTWLWJX3MpSaMqhfU4ELwlhIXQq4Vq6LNmtzQsgP897i63HRr86
   SNyp7HT0pHffKrbxdzlXO3VFdi6G4Q03irt7PwFM3ctxF5dradBreYejQ
   n1aRbaaDXFLq5KDVI6oxfql+zjF8NVMe7aYQxJsF70HFW27MMPKHbcKXo
   FdOSy9NsyUs5IkHGpIGTQLPt3px4cFqLXq9f0oqHN0a+zLM1o+l3czvWI
   A==;
X-CSE-ConnectionGUID: IsJ5ipsMSkqP1pmKtS3GDQ==
X-CSE-MsgGUID: PdIghmELREaEyVCZ9QMXqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82795517"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82795517"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:24:58 -0800
X-CSE-ConnectionGUID: XA9JfWl4ROeThkeJO41CpA==
X-CSE-MsgGUID: H4qtw1bCTIe3YRI2iQOciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214543271"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Feb 2026 21:24:57 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH 3/3] cpupower: fix memory leak on execlp failure
Date: Wed,  4 Feb 2026 10:51:42 +0530
Message-Id: <20260204052143.3281063-4-kaushlendra.kumar@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42036-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1947E1EC9
X-Rspamd-Action: no action

Free allocated page string when execlp fails to execute.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpupower.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 3d3c5768c5d7..b74b4d19d95f 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -99,6 +99,9 @@ static int print_man_page(const char *subpage)
 
 	execlp("man", "man", page, NULL);
 
+	/* execlp failed */
+	free(page);
+
 	/* should not be reached */
 	return -EINVAL;
 }
-- 
2.34.1


