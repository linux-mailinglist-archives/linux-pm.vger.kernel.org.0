Return-Path: <linux-pm+bounces-43454-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBkvNAkXpmlWKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43454-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:02:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B61E6331
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FE8A30A3CD3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB4E33A70A;
	Mon,  2 Mar 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnHSPCLz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08431F999;
	Mon,  2 Mar 2026 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490741; cv=none; b=pJ3YH06IjBuj+KRJAxeOJ65eTgNw51i7Uf275VlF9Ow4qHEZzdrRqsHWbkppFZ9iOQBJtzjrTEt7cMfRfkSXC1IphRR934K4L2kZ6DUpRTdEIPFTm3L1NmiODr7iyGBsNmYB9mquuMdcdUcqCM3YTxn9YNjv3YcLUM2s/rG+WG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490741; c=relaxed/simple;
	bh=8M8ybfHaeF78DXiJ1GH+Yp/dQ8vnQhErskTTV74Gm30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4gTA6/mJfbVDx+NxJf8eZntb3TUZ47MlOZ8C6z4lav5Jc3X/WYzqiYYCtM6vLcTExeovMjH8c8U5BkE+K1VmbymaUwBwpbKY9F2U7ylToOwXyNuc4FuFe22NkHuouQ0VGneve3V3WzsK4mOu4PmPX8BtXLpSsU7vF9grSgqRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnHSPCLz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772490740; x=1804026740;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=8M8ybfHaeF78DXiJ1GH+Yp/dQ8vnQhErskTTV74Gm30=;
  b=EnHSPCLzGEvUeEjkJvVoliXKF4Ye+mBedRxw0DTPFlu1RtgsVdxUeCNP
   +lMUK4J9CXicrxlhhwki8OtIG7VUr53tfISiIU5laB6gKEAobOLpZZEE9
   aFQISXClDB3CsOXVOyDkK7L77rBD5ksLJBPAKv3pkWhzpS/igeEV/TOIg
   M2LtckWilAfMeviceD1NhfC5XKLKfdPbzHgGUTQIU0U5JfaKm50n0+iEM
   S59RxI5wSFFZjawaZKY4+fabnt8jY0zUESU07dzdmMsOzOyhTtNjMOwzS
   Y+qSfkN3HR+5UrikO6RRIfojCvUitr3F5SzVmqpxtTlvkE6nowpV7qoci
   Q==;
X-CSE-ConnectionGUID: w/LppoIgQnS+4YdSokJJqA==
X-CSE-MsgGUID: Eqq8CLEzQTGC1OynF2hsjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73554506"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73554506"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:19 -0800
X-CSE-ConnectionGUID: Lo1k+a/lQg+sYy9Mwdkvjw==
X-CSE-MsgGUID: vnRB7zEwSYai4m/+bK3Bow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217793514"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.108.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:19 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/6] platform/x86/intel/pmc: Add support for variable DMU offsets
Date: Mon,  2 Mar 2026 14:32:06 -0800
Message-ID: <20260302223214.484585-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302223214.484585-1-xi.pardee@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC3B61E6331
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[xi.pardee@linux.intel.com,linux-pm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43454-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for handling different DMU Die C6 offsets across platforms.
The previous implementation assumed a uniform DMU Die C6 offset for all
platforms, which is no longer valid.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 2 ++
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 drivers/platform/x86/intel/pmc/core.h | 2 ++
 drivers/platform/x86/intel/pmc/mtl.c  | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 95372a0807acf..4d91ee010f6d0 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -729,6 +729,7 @@ struct pmc_dev_info arl_pmc_dev = {
 	.init = arl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
 	.ssram_hidden = true,
+	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
 };
 
 static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
@@ -742,4 +743,5 @@ struct pmc_dev_info arl_h_pmc_dev = {
 	.init = arl_h_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
 	.ssram_hidden = true,
+	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7670970c995b9..7bd0e1eaa32e2 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1387,7 +1387,7 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_de
 		}
 
 		pmcdev->punit_ep = ep;
-		pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
+		pmcdev->die_c6_offset = pmc_dev_info->die_c6_offset;
 	}
 
 	if (pmc_dev_info->pc_guid) {
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 31fe71b01120b..f09791f866223 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -514,6 +514,7 @@ enum pmc_index {
  * @init:		Function to perform platform specific init action
  * @sub_req:		Function to achieve low power mode substate requirements
  * @ssram_hidden:	Flag to indicate whether SSRAM is hidden
+ * @die_c6_offseyt:	Telemetry offset to read Die C6 residency
  */
 struct pmc_dev_info {
 	u32 *dmu_guids;
@@ -530,6 +531,7 @@ struct pmc_dev_info {
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 	int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
 	bool ssram_hidden;
+	u32 die_c6_offset;
 };
 
 extern const struct pmc_bit_map msr_map[];
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 193ebbe584023..b724dd8c34dba 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -1003,4 +1003,5 @@ struct pmc_dev_info mtl_pmc_dev = {
 	.init = mtl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
 	.ssram_hidden = true,
+	.die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET,
 };
-- 
2.43.0


