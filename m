Return-Path: <linux-pm+bounces-42597-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GiRNeJijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42597-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D7131C07
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFABE30943EB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908E2F1FD9;
	Thu, 12 Feb 2026 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuyE0O8J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF802F363C;
	Thu, 12 Feb 2026 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939058; cv=none; b=YcjYHJ5UqCkIzAJ9RO5TKHe6wMhwHnz6PBxBGO0MwN9ssrA8wMT9YvMwEFzz9UcXC/IAwuQQe2rEBqd6RPzPv1V7oZpa/7A6YxWUSD5GzddP/lgyqvcifmxPeN5soc5alrfMET3CZ6l3IgiPipn1MuPAu6CEz5OhJBEjWZiOF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939058; c=relaxed/simple;
	bh=V1OhDtp8q+SX4bXSX+HrQit+y5xCbDSeaJoQGd7evXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiG1PqFBBcfgRVg/0bC0UxFgJC1RdH02vrL0bfgpqlUXknRS1HEbR8puhwFUs/LGIBIeHANpRUAxKeCeyZQsIyyfNJC7TvfkLjEvKDJmjCsl5tkVwH+8AoGSEhc+dTb5Mpx5vXLOvdrOADTmol71LCvoYH1XAs1+0PG5CSw1+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuyE0O8J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939054; x=1802475054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1OhDtp8q+SX4bXSX+HrQit+y5xCbDSeaJoQGd7evXo=;
  b=JuyE0O8JHcTmycD5a4ZHsDy78elFZmM22oTNMpVeSuZGJS9fGo3DBuwS
   zt7JfcBXjGc1VX1EvAtsgGSWquZvZoeHOgu5vttTm46pA9QqS/mM9gjDi
   WK0NUj5df1ncbzJykDl8cMZXlAOzUUQNsPfQ5xZc4e4YzAtMh4gyr//K+
   ZpXv/Q8Nv1ea9Wx+UaVteigvCFTeCkefbPWBnn1efHbDOGPN6gUFrMZ16
   CfMLsnxtxjLJX5SVfGl3NyPo6o7poqXLfSrzCY5VHMzkEpnrJTXiIIIPz
   B3tcIWKa1hMS0ZmRupZEbRRo5c2UoTxs593Mu1alXCAeiOZXMupuU7nYS
   A==;
X-CSE-ConnectionGUID: w5gDiWNaR62CrHncF2NXZQ==
X-CSE-MsgGUID: czjS8xTLQlifJTNjgUGHIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017448"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017448"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: wkIHYJGeTPqALEKjxi9lPg==
X-CSE-MsgGUID: sB3dqFSLTp6Tz28yPGaNOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845387"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:46 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] powercap: intel_rapl: Simplify rapl_compute_time_window_atom()
Date: Thu, 12 Feb 2026 15:30:36 -0800
Message-ID: <20260212233044.329790-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42597-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 564D7131C07
X-Rspamd-Action: no action

Restructure to use early return for to_raw case, eliminating
redundant assignments and clarifying conversion paths.

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index d37150bab1e2..74a74af8f0ec 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1145,16 +1145,14 @@ static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
 static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 					 bool to_raw)
 {
+	if (to_raw)
+		return div64_u64(value, rd->time_unit);
+
 	/*
 	 * Atom time unit encoding is straight forward val * time_unit,
 	 * where time_unit is default to 1 sec. Never 0.
 	 */
-	if (!to_raw)
-		return (value) ? value * rd->time_unit : rd->time_unit;
-
-	value = div64_u64(value, rd->time_unit);
-
-	return value;
+	return (value) ? value * rd->time_unit : rd->time_unit;
 }
 
 static int rapl_check_unit_tpmi(struct rapl_domain *rd)
-- 
2.43.0


