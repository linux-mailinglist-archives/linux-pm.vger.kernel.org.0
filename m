Return-Path: <linux-pm+bounces-43012-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM1eIQ4dnGkZ/wMAu9opvQ
	(envelope-from <linux-pm+bounces-43012-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:25:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9E173DD6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65EFC307108A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833F350A39;
	Mon, 23 Feb 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKGUQSVc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4334F48A;
	Mon, 23 Feb 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838462; cv=none; b=BCXoX1ZCDIxI1+whjOSyHMouZJx7umHKtivDBnQYm2uDzkbx9eOLIchEdHaGztv5IDXg9PHDq+884KfC4mq+5TSGbTvkuIHzRd5cxq1CQCWnxpUGc5WzbZPo6MPZzjyCapTixkucvjw7tIpoXKO4zkuEKQoofFfMfvdXNB5/Ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838462; c=relaxed/simple;
	bh=qQRb9bfhKdX4X9TIqUYJrwXl9ceosYCjbpsACy7+14c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0k+i8+ndlLqS9fiF91tF3w/pEDhsTRymrPBWXxTWBJ+0b9YSqUBDWYptiDk/Si6pGkNUvtMtvDeh3dzJsf3I1YVyiQTQ+C/JVC/v6YSgSPbuEOJw6whs1e1THDieLgWQUyqD1mmJ5nEwAeK3oWOu7u8gGHj7DmwAlNaJvbckWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKGUQSVc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771838460; x=1803374460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQRb9bfhKdX4X9TIqUYJrwXl9ceosYCjbpsACy7+14c=;
  b=IKGUQSVcDiJP1Ym26bmJL63eAeF2b3TxmpmF1028IfxXiZsOYXcgJimY
   /JeTIGCzq1Cn6uoFb644ABu+GHe0AN/sRc1yBsDkeJ3HgEttigKH+a/qD
   j/EmmsFSkshh1dV8TxFSLfvYcVwmWT6fhDX1yKj4bs+yJXuiZvfjwNMqi
   Z0MZVHkcqL1pjCHdBxEHBF6rju3A13yOiWCe8h0uuLdtaSic2g3qboCF7
   advvf7HLvtgidprHd+h8XtFJx/JiiLD7LAg/0PGJKNrZWL5IS6fbZGB6P
   0v2zA6lxF22z3MBd+DQOeshDTiKV5rvluJmjyFc7oR38a2aBi8VBKW3Ls
   A==;
X-CSE-ConnectionGUID: hZbWUMgYTAKtTAd5JasVYQ==
X-CSE-MsgGUID: bNV+mRaTTTu/ap/Nnquxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72928703"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72928703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:21:00 -0800
X-CSE-ConnectionGUID: Ri6WhXnnSwK88LN2wI6MJg==
X-CSE-MsgGUID: xXYuhnpyQQ+AHUq9hvyBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215346078"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:20:58 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V4 3/5] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Date: Mon, 23 Feb 2026 11:20:39 +0200
Message-ID: <20260223092041.104689-4-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43012-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACD9E173DD6
X-Rspamd-Action: no action

Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
where a single parent device hosts multiple I3C controller instances.  In
such designs, the parent - not the individual child instances - may need to
coordinate runtime PM so that all controllers runtime PM callbacks are
invoked in a controlled and synchronized manner.

For example, if the parent enables IBI-wakeup when transitioning into a
low-power state, every bus instance must remain able to receive IBIs up
until that point.  This requires deferring the individual controllers'
runtime suspend callbacks (which disable bus activity) until the parent
decides it is safe for all instances to suspend together.

To support this usage model:

  * Export the low-level runtime PM suspend and resume helpers so that
    the parent can explicitly invoke them.

  * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, allowing platforms to
    bypass per-instance runtime PM callbacks and delegate control to the
    parent device.

  * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
    by parent-managed PM implementations.

The new quirk allows platforms with multi-bus parent-managed PM
infrastructure to correctly coordinate runtime PM across all I3C HCI
instances.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V4:

	Add Frank's Rev'd-by

Changes in V3:

	None

Changes in V2:

	For HCI_QUIRK_RPM_PARENT_MANAGED case, change from
	disabling runtime PM to instead causing the runtime PM
	callbacks to do nothing


 drivers/i3c/master/mipi-i3c-hci/core.c | 28 ++++++++++++++++++++++----
 drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index ec4dbe64c35e..149b3fad34b5 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
 	return 0;
 }
 
-static int i3c_hci_runtime_suspend(struct device *dev)
+int i3c_hci_rpm_suspend(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
@@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i3c_hci_rpm_suspend);
 
-static int i3c_hci_runtime_resume(struct device *dev)
+int i3c_hci_rpm_resume(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
@@ -768,6 +769,27 @@ static int i3c_hci_runtime_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i3c_hci_rpm_resume);
+
+static int i3c_hci_runtime_suspend(struct device *dev)
+{
+	struct i3c_hci *hci = dev_get_drvdata(dev);
+
+	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)
+		return 0;
+
+	return i3c_hci_rpm_suspend(dev);
+}
+
+static int i3c_hci_runtime_resume(struct device *dev)
+{
+	struct i3c_hci *hci = dev_get_drvdata(dev);
+
+	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)
+		return 0;
+
+	return i3c_hci_rpm_resume(dev);
+}
 
 static int i3c_hci_suspend(struct device *dev)
 {
@@ -812,8 +834,6 @@ static int i3c_hci_restore(struct device *dev)
 	return i3c_hci_resume_common(dev, true);
 }
 
-#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
-
 static void i3c_hci_rpm_enable(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 819328a85b84..584ee632b634 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
 #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
 #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
+#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
@@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
 void amd_set_resp_buf_thld(struct i3c_hci *hci);
 void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
 
+#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
+
+int i3c_hci_rpm_suspend(struct device *dev);
+int i3c_hci_rpm_resume(struct device *dev);
+
 #endif
-- 
2.51.0


