Return-Path: <linux-pm+bounces-41707-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEzYA5ule2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41707-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:23:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0F3B3880
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F9A309F1F7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B12F5A35;
	Thu, 29 Jan 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hC4/wz3J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51183291C10;
	Thu, 29 Jan 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710751; cv=none; b=t7J6bYZWKb2TMBt7J4z5iiLspwJLBHKYWG2DeuNpMb7WeE67dyp8gY/fdj/tEm8sfQIQpfaUBPSBzsyvS14Fx0xoJnaK/YbjdPZdeZdjeCfvbTP8khJLsNC6mWiAYjwyC8fykLRQUFwgsV+cHBq+SnZWrvuQ6F6lWMHvxlMglBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710751; c=relaxed/simple;
	bh=w7Meq2vOvdBRZgQHH+Eb77Z8XpjX4o1PXJQZknXYpy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPiAAGZpklwla/VLKTttgpTaY0PDOkBP3bx5yuM9eQutW+d1M1YhWySFP5krFqntmwRuXYwJy2iOwVihkguY3LEqe+i8VxkgcQo6IgRlTgERD+guS1F7vnnMyZc24laKal69mSxuzUtChXSdh0/5d/LwTxpNBZ+4WebBhaiDfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hC4/wz3J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710749; x=1801246749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7Meq2vOvdBRZgQHH+Eb77Z8XpjX4o1PXJQZknXYpy8=;
  b=hC4/wz3Jy6IYbjJtMqVdoVVMI1uAO6/6jovlFjZje/1YdBuoJa+ZCJIZ
   p3HgQxxTq+jYurvKuXOmza5HOOFuGY0eHGDIwUZUfGCgY54q8F4fmJfEA
   UpPZ6dgoHf4WUWS97RO9Q4Wsw2s9iCDyiuOrTg2G9xGpaQNrcRFyOCugD
   65RjTk1hyIYeCOHGHcYnzu7+cxTl8aY3qGBgBwi0DvxabUB+nUQBRDZ76
   jj2BPDCWh4WXyVC4QKstcMGrSif+RIA00LqsKDbxrqZpWIig4ezrNUito
   GjY13kdIU2RyZigV9mg6BPEnoFtpQvbu/tQ4OjqtosTqebf3cVTHG5mJe
   w==;
X-CSE-ConnectionGUID: 3q40UdjURRmQ0yJmOEHfJA==
X-CSE-MsgGUID: W0W60u2CQTSPpjj3ihuHdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158313"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158313"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:09 -0800
X-CSE-ConnectionGUID: ewWpuvxqT2qGyQ9n6oBChw==
X-CSE-MsgGUID: Q9gkBaHZQ92Qr1PSv7/t/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255315"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:06 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 7/7] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Thu, 29 Jan 2026 20:18:41 +0200
Message-ID: <20260129181841.130864-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129181841.130864-1-adrian.hunter@intel.com>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41707-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 6A0F3B3880
X-Rspamd-Action: no action

Intel LPSS I3C controllers can wake from runtime suspend to receive
in-band interrupts (IBIs), and they also implement the MIPI I3C HCI
Multi-Bus Instance capability.  When multiple I3C bus instances share the
same PCI wakeup, the PCI parent must coordinate runtime PM so that all
instances suspend together and their mipi-i3c-hci runtime suspend
callbacks are invoked in a consistent manner.

Enable IBI-based wakeup by setting HCI_QUIRK_RPM_IBI_ALLOWED for the
intel-lpss-i3c platform device.  Replace HCI_QUIRK_RPM_ALLOWED with
HCI_QUIRK_RPM_PARENT_MANAGED so that the mipi-i3c-hci core driver expects
runtime PM to be controlled by the PCI parent rather than by individual
instances.  For all Intel HCI PCI configurations, enable the corresponding
control_instance_pm flag in the PCI driver.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c             | 2 +-
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index cb974b0f9e17..67ae7441ce97 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -992,7 +992,7 @@ static const struct acpi_device_id i3c_hci_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
 
 static const struct platform_device_id i3c_hci_driver_ids[] = {
-	{ .name = "intel-lpss-i3c", HCI_QUIRK_RPM_ALLOWED },
+	{ .name = "intel-lpss-i3c", HCI_QUIRK_RPM_IBI_ALLOWED | HCI_QUIRK_RPM_PARENT_MANAGED },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, i3c_hci_driver_ids);
diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index f7f776300a0f..2f72cf48e36c 100644
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


