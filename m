Return-Path: <linux-pm+bounces-43014-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FKMLUUdnGkZ/wMAu9opvQ
	(envelope-from <linux-pm+bounces-43014-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:26:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F8C173E10
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E00430876B5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604DC354ADF;
	Mon, 23 Feb 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nm+KQdxR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CE355813;
	Mon, 23 Feb 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838466; cv=none; b=ihMOayAS41eqxPeX/q1Me7P3mBubVlIGGrFzC8cYQF8YUjdLFsOjw/0TFuP22yIjCd56hyiNftXe7i1xVHlR6qAIx4hmUMsWPrxqnYZD6wbBzSgX0dSujM03FPuKPcwjkIBYyN+BuHpS5sC/xqHOeTTrR4Owgs1pupo2rAO/BdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838466; c=relaxed/simple;
	bh=G/Byvr4Il4mkxD28lxY27/H762+nRi1J5nNY6JBPWOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYqBcSxkZgdoCDE2cDk99WQJKSw1ww8QQKMcg+dQ1nPv2aRX48hO+zGNZiE8VSRo9iH5Ijpfd5XEyqUK1i0Om3PlpE+HEsSl3TwvElRfWkfiXUZno27PN5f03U001mz8sE1q++k67ABr60U6V82pbsC4JOrT9fMtLt/2364V43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nm+KQdxR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771838464; x=1803374464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/Byvr4Il4mkxD28lxY27/H762+nRi1J5nNY6JBPWOw=;
  b=Nm+KQdxRUUKKeYVeslSHgbV6yONeztVuJxe3xFT53q8PuSqbxdlxI0cL
   F+ubafK8TBk3roxCHmDTILEY69uI7Ai4ZYjqviC/p2iNn5apUHHGkiNXI
   8lz7lFyhDODqhPqxIkbXHt1xr+kCfLV1J4KIYMCxl1xAbk1DhWo3YEDit
   qDPWXpdEpXyYvEdUxXaD1Bf3Ct3K7ZS+W+qxfmjN5kWbc3T/nymlN0eB4
   q+cD8fkGYC3ruT7TKR0td/iMQzht/vs5O6l4QCDw7yTouXXl9iAMGIfRG
   v/u0uQlm5kpzN7Q3YyMfj2u8GwB276bLCxtbQ0UVqMkeUtrScoUOznllM
   A==;
X-CSE-ConnectionGUID: VAWa/IRMTyaVmHZpRt8EYQ==
X-CSE-MsgGUID: NhhJltEXT66aqRGptmSQww==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72928723"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72928723"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:21:04 -0800
X-CSE-ConnectionGUID: Ys3W9MmrQ6q53IeaCnFEpA==
X-CSE-MsgGUID: GN4DscWzSquUMhuUGzrf2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215346118"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:21:03 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V4 5/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Mon, 23 Feb 2026 11:20:41 +0200
Message-ID: <20260223092041.104689-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223092041.104689-1-adrian.hunter@intel.com>
References: <20260223092041.104689-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43014-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5F8C173E10
X-Rspamd-Action: no action

Intel LPSS I3C controllers can wake from runtime suspend to receive
in-band interrupts (IBIs), and they also implement the MIPI I3C HCI
Multi-Bus Instance capability.  When multiple I3C bus instances share the
same PCI wakeup, the PCI parent must coordinate runtime PM so that all
instances suspend together and their mipi-i3c-hci runtime suspend
callbacks are invoked in a consistent manner.

Enable IBI-based wakeup by setting HCI_QUIRK_RPM_IBI_ALLOWED for the
intel-lpss-i3c platform device.  Also set HCI_QUIRK_RPM_PARENT_MANAGED so
that the mipi-i3c-hci core driver expects runtime PM to be controlled by
the PCI parent rather than by individual instances.  For all Intel HCI PCI
configurations, enable the corresponding control_instance_pm flag in the
PCI driver.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V4:

	None

Changes in V3:

	Add Frank's Rev'd-by

Changes in V2:

	Retain HCI_QUIRK_RPM_ALLOWED
	Amend commit message accordingly


 drivers/i3c/master/mipi-i3c-hci/core.c             | 4 +++-
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 149b3fad34b5..d19be1d276b5 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -1005,7 +1005,9 @@ static const struct acpi_device_id i3c_hci_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
 
 static const struct platform_device_id i3c_hci_driver_ids[] = {
-	{ .name = "intel-lpss-i3c", HCI_QUIRK_RPM_ALLOWED },
+	{ .name = "intel-lpss-i3c", HCI_QUIRK_RPM_ALLOWED |
+				    HCI_QUIRK_RPM_IBI_ALLOWED |
+				    HCI_QUIRK_RPM_PARENT_MANAGED },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, i3c_hci_driver_ids);
diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index ed0efed17726..54a2176ca79d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -200,6 +200,7 @@ static const struct mipi_i3c_hci_pci_info intel_mi_1_info = {
 	.id = {0, 1},
 	.instance_offset = {0, 0x400},
 	.instance_count = 2,
+	.control_instance_pm = true,
 };
 
 static const struct mipi_i3c_hci_pci_info intel_mi_2_info = {
@@ -209,6 +210,7 @@ static const struct mipi_i3c_hci_pci_info intel_mi_2_info = {
 	.id = {2, 3},
 	.instance_offset = {0, 0x400},
 	.instance_count = 2,
+	.control_instance_pm = true,
 };
 
 static const struct mipi_i3c_hci_pci_info intel_si_2_info = {
@@ -218,6 +220,7 @@ static const struct mipi_i3c_hci_pci_info intel_si_2_info = {
 	.id = {2},
 	.instance_offset = {0},
 	.instance_count = 1,
+	.control_instance_pm = true,
 };
 
 static int mipi_i3c_hci_pci_find_instance(struct mipi_i3c_hci_pci *hci, struct device *dev)
-- 
2.51.0


