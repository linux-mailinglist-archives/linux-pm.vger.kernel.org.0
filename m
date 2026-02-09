Return-Path: <linux-pm+bounces-42376-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJXVGipximnPKQAAu9opvQ
	(envelope-from <linux-pm+bounces-42376-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:43:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2CB1156C7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 668873007217
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59C32B9A3;
	Mon,  9 Feb 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0XYCUdc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99B30E856;
	Mon,  9 Feb 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770680599; cv=none; b=CLsLkqFXtsgs36vKGAWdEvNtlcfQhpBP5rTSa/lESbDN55SPHKzpJ/cAilX7BGTKn0xv61DhHdo1EvJ3Er0Ptn5hW2AMYlsurC1tKByIGDDZ+CR0tn/iEltU/ZUTU01y/JYjghGwXD3L4hk9CZdIwc/WExitdc0yhW25TnNzg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770680599; c=relaxed/simple;
	bh=9rjG/Kbu/YsxHY9tx251K6jkXVIssYxBxMh1ueDsyTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7LpHo0OgXHERi5RViumG5iDaDgLrvNp2HD8KjYjCTvqDgN7gsWy2ZjyZLQ19koU8Qivnfjb7tCl/qjbCo4jtQacrxSdU23ix+/EywuWOg+snIU34hGsCzbWttqgpkJmlfZsix5C+998zyv/sq8wEqNmU6KYlXtGwP/jjwKn8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0XYCUdc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770680598; x=1802216598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rjG/Kbu/YsxHY9tx251K6jkXVIssYxBxMh1ueDsyTQ=;
  b=W0XYCUdcyQB45GKMv24/AjHX5XB1Yk9H5hLYjyc+UJK3fRE03K1YVrea
   4tN+QtHcDrTIOC9EzKdLBp4K/q9tRJT61WsJc3WcWdls06AG3dAI1ZBDB
   Tf0/YmdgxJpel8LDYRImwWn0rGLErtcwqjRmmGFD8TgFtAKiT+cSaMBD3
   aQDBSVtuQ7zHh3QUERZj6Q7NyaA3HYirTmYJuiUCtOsyPY/GTABQ9wCuW
   8/QprnzaQG7rJu6kCZOLEwZ/ICDa49587Tq69fZtz/Z+9JczDHY9O9St/
   TU61Lcw1itrUzXWk5W9BjEHkZ6ca4C/mJOigaM5N8Y5zbnMnfJhGo37FW
   g==;
X-CSE-ConnectionGUID: KEZ82M1lTTaAnBDlYHCNJw==
X-CSE-MsgGUID: R+Wg4b5zQi+yhWoD0cTe9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89385237"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89385237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:43:15 -0800
X-CSE-ConnectionGUID: TXRWXYcQRHuq/nzAUVQefw==
X-CSE-MsgGUID: zecB/osGSlChxq48gGHQyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="242351920"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:43:15 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] powercap: intel_rapl: Expose all package CPUs in PMU cpumask
Date: Mon,  9 Feb 2026 15:43:10 -0800
Message-ID: <20260209234310.1440722-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42376-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 9D2CB1156C7
X-Rspamd-Action: no action

Currently, the RAPL PMU cpumask only includes one CPU per package
(typically the lead_cpu) for both MSR and TPMI interfaces. This
forces tools to pin their operations to that specific CPU, even
though package-scoped registers are readable from any CPU within
the package.

Change the cpumask to include all online CPUs in each package. This
allows tools like perf and turbostat to read RAPL events from any
CPU in the package without requiring special handling to find and
use the designated lead_cpu.

The change refactors get_pmu_cpu() into set_pmu_cpumask() which
populates the cpumask with all CPUs belonging to each RAPL package
instead of returning a single CPU.

This improves flexibility for userspace tools while maintaining
correctness since package-scoped RAPL MSRs are architecturally
accessible from any CPU in the package.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Furquim Ulisses <ulisses.furquim@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3705d0608a0f..539625531709 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1590,23 +1590,21 @@ static struct rapl_pmu rapl_pmu;
 
 /* PMU helpers */
 
-static int get_pmu_cpu(struct rapl_package *rp)
+static void set_pmu_cpumask(struct rapl_package *rp, cpumask_var_t mask)
 {
 	int cpu;
 
 	if (!rp->has_pmu)
-		return nr_cpu_ids;
+		return;
 
 	/* Only TPMI & MSR RAPL are supported for now */
 	if (rp->priv->type != RAPL_IF_TPMI && rp->priv->type != RAPL_IF_MSR)
-		return nr_cpu_ids;
+		return;
 
 	/* TPMI/MSR RAPL uses any CPU in the package for PMU */
 	for_each_online_cpu(cpu)
 		if (topology_physical_package_id(cpu) == rp->id)
-			return cpu;
-
-	return nr_cpu_ids;
+			cpumask_set_cpu(cpu, mask);
 }
 
 static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
@@ -1883,7 +1881,6 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct rapl_package *rp;
 	cpumask_var_t cpu_mask;
-	int cpu;
 	int ret;
 
 	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -1895,9 +1892,7 @@ static ssize_t cpumask_show(struct device *dev,
 
 	/* Choose a cpu for each RAPL Package */
 	list_for_each_entry(rp, &rapl_packages, plist) {
-		cpu = get_pmu_cpu(rp);
-		if (cpu < nr_cpu_ids)
-			cpumask_set_cpu(cpu, cpu_mask);
+		set_pmu_cpumask(rp, cpu_mask);
 	}
 	cpus_read_unlock();
 
-- 
2.43.0


