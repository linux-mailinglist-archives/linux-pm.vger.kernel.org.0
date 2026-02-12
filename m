Return-Path: <linux-pm+bounces-42590-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHM7JLhijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42590-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5C131BB6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34C4307B7FB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2942DE6F3;
	Thu, 12 Feb 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPuXaljA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600E22068F;
	Thu, 12 Feb 2026 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939050; cv=none; b=WmCGDDBF8pkwLVMS2XU1lT1Y1DOT9saQXOLYOxkcvHEaNi57ixBKMcCOnphrJuzk+bgXkHmNSfvT5D2amWWnriCp2CbuE/GZCGfkjXmlMyGsaLkcgjZf9LP6/6k6nhkp8GbhiMqNnPbZErRJgBzY9MIazAFawza2MBXI6Q07KxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939050; c=relaxed/simple;
	bh=ehCMrUpJBBUjXmImpjoZQ1xX5uAU4KH4QUr0E5ZB5tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4sLH/HTYcXABDtatlcuNGg4BUTikzd+0te3I7bvUEn7khLjqBdyd6H0ZyRtWAuB8GDbwdIs4hvV0FKe7EsLc+mhnk+L08ciZguxWkGuBLvaKe9fzjKwg3kohDIwE0JObCIhPTFnKxMy21mBWyHHowQfIazvNwbr+xswACiwnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPuXaljA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939049; x=1802475049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehCMrUpJBBUjXmImpjoZQ1xX5uAU4KH4QUr0E5ZB5tk=;
  b=BPuXaljAzJdGpPxHYQwqfl0L4gK/OGGhoXm89u5Ix1Df1t7VtU1SdEMA
   SJgxdHDo98yrAKm9UaTXzQ9iWgPxMDL03ZWCeXaKvuOjS6EiAo+1wSsi3
   iJBdIynlOXKHy6UAehqniwamtQlLdbbuxkwzG44gHzkwklQLrlwnKbw73
   OBkw9MUtL59X/hbNLKW/+ToPcLX3grhNA6kYAeac8k2ILN7NAbxYV/4qB
   13JlIysL9nmfGc+U+Z6HKnLVmo/JQoEWxExE0tIJZfN3N5lRKBesuohh6
   cmEhvBt0JgbeCe12o02KIgoXQHfH8QHfD5YaLZYJTjNLNY33eBF3w6v+1
   g==;
X-CSE-ConnectionGUID: GbDRql7aS72ztyw+wba11Q==
X-CSE-MsgGUID: oUVTcrzlR1OxHzA62qUudw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017412"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017412"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: qA9oW6zZRi6onYkTKW1leQ==
X-CSE-MsgGUID: kfsYh3nmR6qwXAo4vn1iRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845383"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:45 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] powercap: intel_rapl: Remove unused TIME_WINDOW macros
Date: Thu, 12 Feb 2026 15:30:35 -0800
Message-ID: <20260212233044.329790-4-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42590-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7B5C131BB6
X-Rspamd-Action: no action

Remove TIME_WINDOW_MIN_MSEC and TIME_WINDOW_MAX_MSEC as they
are not used anywhere in the code.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 12f2d6de0541..d37150bab1e2 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -117,9 +117,6 @@
 
 #define RAPL_EVENT_MASK			GENMASK(7, 0)
 
-#define TIME_WINDOW_MAX_MSEC		40000
-#define TIME_WINDOW_MIN_MSEC		250
-
 enum unit_type {
 	ARBITRARY_UNIT,		/* no translation */
 	POWER_UNIT,
-- 
2.43.0


