Return-Path: <linux-pm+bounces-42595-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEnSMbdijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42595-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF6131BAF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79AB33021BBD
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD692F363B;
	Thu, 12 Feb 2026 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHqrrCOn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B52EC569;
	Thu, 12 Feb 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939053; cv=none; b=JuGi1ImpVv0TfqxoCbH0oPF2THl2/5JBzwsGVOa+qDy+MptwDKEu4o+6LTwCOkRcTTXsekZdBBXrmigr1/W1FGcKDQjbFq+JrY/e4PefiW3BDxGGuODS3xQG9jC93V26UCW2WFnq8mBlrLtmRe8rIKmnGdibsvc0ICXYjsgpkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939053; c=relaxed/simple;
	bh=o5mP3H1sKWr5Df5LK336P/ufsHt0m/j9IjCBKi5hpEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO9XrTChkzGya1FPHlORiERtZPLdLmaXXr6+Rvtri+YgoL1I2phBG94bnM2OMH5mn5pRRdWhxAfNK9AmvogKedbNmpvcmtBEneKd8KZLinhsscIielezSi/lWfKvz+qqWowXY2I74pGbtg+Q3w4KLN3MZvzz5SE7J7Jm03zDfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHqrrCOn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939052; x=1802475052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5mP3H1sKWr5Df5LK336P/ufsHt0m/j9IjCBKi5hpEU=;
  b=cHqrrCOnYHAhgDKq3BkIiVXfwfF9BnK5ODcal0EVLv1X9g6NcXkuridy
   FxHwmTLvLEc9tlqqHe2hwQjHSCxb+dpRHum/xDnIa1ADaImSQjiK9C8ql
   Iozvfkuw+U2MIHPh2ytG5Vnvp7XGlJ9/HUPoThLja775hruIF60yXwIqj
   8MOdDFUGsYS1lI9WNMduuXUxCMejQjfhP4lP6FW7j0Tl7cLly06WK3WPR
   NJoc8/tc9oibg1N7tGYRp61E/irK+4mNqJFX1bpDNAOiT5WIJJqmPAvHD
   2c/sUsavmrkBcPbxLtcAA7guBPerOIvGin01nRj/cukE1+lFNYQv9WA7S
   g==;
X-CSE-ConnectionGUID: M2x+zZvDR8qNq7iNy1iJnQ==
X-CSE-MsgGUID: HqpsaDKfTYiK4Lzre6X8bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017431"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: bRIqQVXkTxW6ioPqrtyKZg==
X-CSE-MsgGUID: je3qfL7dQj2EystYE1BxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845410"
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
Subject: [PATCH v2 10/12] thermal: intel: int340x: processor: Move RAPL defaults to MMIO driver
Date: Thu, 12 Feb 2026 15:30:42 -0800
Message-ID: <20260212233044.329790-11-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42595-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 6ECF6131BAF
X-Rspamd-Action: no action

Previously, the MMIO and MSR RAPL interfaces shared the same set of
RAPL defaults provided by common code. However, unlike the MSR
interface, the MMIO RAPL interface does not require CPU-specific
variations in its default handling. Keeping the RAPL defaults in
the RAPL common driver therefore provides no additional benefit.

Move the MMIO defaults into the MMIO interface driver. This change
includes the following updates:

  * Introduce a MMIO-local rapl_defaults instance with the appropriate
    default callbacks.
  * Assign the MMIO-specific rapl_defaults to priv->defaults during
    MMIO driver initialization.

No functional changes are expected.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_rapl.c        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e56b18aeda71..5dbeb0a43c8c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -19,6 +19,13 @@ static const struct rapl_mmio_regs rapl_mmio_default = {
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
+static const struct rapl_defaults rapl_defaults_mmio = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+};
+
 static int rapl_mmio_read_raw(int cpu, struct reg_action *ra, bool atomic)
 {
 	if (!ra->reg.mmio)
@@ -67,6 +74,7 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 
 	rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
 	rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
+	rapl_mmio_priv.defaults = &rapl_defaults_mmio;
 
 	rapl_mmio_priv.control_type = powercap_register_control_type(NULL, "intel-rapl-mmio", NULL);
 	if (IS_ERR(rapl_mmio_priv.control_type)) {
-- 
2.43.0


