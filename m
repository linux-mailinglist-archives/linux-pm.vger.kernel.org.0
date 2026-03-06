Return-Path: <linux-pm+bounces-43761-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIeqOfOWqmnJUAEAu9opvQ
	(envelope-from <linux-pm+bounces-43761-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:57:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB4121D848
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 064C130514AA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637D37C91F;
	Fri,  6 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ3BGEdL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDE2DF132;
	Fri,  6 Mar 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787248; cv=none; b=q4wjDFETtQiam11rIczi71azLneCsg/InEQY1A45O6gdS/gN5gg3v9UP2UYeCQ0ZKX+KUHfEJV7E3dT7EVhZYjsVZn9FqAqJqI7TBbAjzG1a0FuGTlZtleT/qkQ2LnWOgmOm04rp5ONGWuBbp5b1h6a4QG5SHFqQuFnAXu/2Bhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787248; c=relaxed/simple;
	bh=qgWuv4mkB26oO+o5wSHFxIMOYCOD8GUcosdl8NeKYrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLJkNbvAetUCMrTI1vZpbVv1KtFUx2Y+pzg9Ny7HDJNvBCaFMHg8YHijemsi1DwwLvy1qMMoSkHn+9/+xboFWBaKqVRvwDkpWUdRrOJwKlK5jpppJz52C1XSJ5CPM5D2wPGD+kygeCsJQG5U6xmYdNnVSRgY1IRdXG2JKPQX9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJ3BGEdL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772787244; x=1804323244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgWuv4mkB26oO+o5wSHFxIMOYCOD8GUcosdl8NeKYrg=;
  b=YJ3BGEdLKDIdZ1uci2WOMezR7hUyXnUT084IQXEUqb+qBUDJaI+sDj7U
   Rfip1xA9Vy3QUPXAE/KnaFKN5gI+r7bZLWIqUy1uJTBRPJdGHVkO+tIiW
   6VimmPSngpv4jtijCBZ+EmG/xCjgv5mAp4RSSodfOa/MJZtVcN5McNMg3
   nnzUWGn+bh80L1xKFKOf0FCAZ6mGFoxfjroOisMXzbszdmhl6u5ya5eN8
   6pZqz2zmbg6hLk3vEvGBDMmDQKFWu0iTrAFNc7taQQgPlxeGMvTM34Rof
   2gcREf7xU4wCON3FK/RnmnvkvJIEk9G75ZsPNmcwu4yvxWnKh72Tl9bSu
   g==;
X-CSE-ConnectionGUID: NHJwwNCATQqLkm6SFfq+Xg==
X-CSE-MsgGUID: 1URFbWMgSxuI4PU9zGEP3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91467256"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="91467256"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:54:03 -0800
X-CSE-ConnectionGUID: x3gg1vidSfahWBM3XR84jQ==
X-CSE-MsgGUID: jxVFhWZCSZGGOddesUmY4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223641505"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.171])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:54:01 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V5 5/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Fri,  6 Mar 2026 10:53:38 +0200
Message-ID: <20260306085338.62955-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306085338.62955-1-adrian.hunter@intel.com>
References: <20260306085338.62955-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFB4121D848
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43761-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email]
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


Changes in V4 and V5:

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
index d803c0b7a64e..b781dbed2165 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -1042,7 +1042,9 @@ static const struct acpi_device_id i3c_hci_acpi_match[] = {
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
index 17f30706eb48..d6bbc3f8cd2a 100644
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


