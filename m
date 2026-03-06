Return-Path: <linux-pm+bounces-43759-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHAdGmaXqmmIUAEAu9opvQ
	(envelope-from <linux-pm+bounces-43759-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:59:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD721D8A1
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C199C30ABF41
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A937C0FD;
	Fri,  6 Mar 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVP5ninl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A342D9EFB;
	Fri,  6 Mar 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787243; cv=none; b=begCn/QB7qxtvlSLbbHLmxzelPb5GIr6lRny9CimO9Ym/egbgo/4V8W6HzSWPEXpyM38/vjOhm/Z2YWf9nM/kDDiDn/iWL/wR0GoDcklTDsCmJZD2PaZGQ3OUY/t0VLficPUp9fb3MoY/cihqitgZ769cgA8Ob4R1hZNrYAw6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787243; c=relaxed/simple;
	bh=2TPppUaJ68o9IXGsmLBrAN+ZgrR/oOK6H1OCUtq2zYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBdP8g/h6QkhKo9ndxTADo7fbKxzPLWnixt7s63ciqSLoDQ2US+SzXvB1vlw8OhteA9mLBdo2NBYBq4Nn7PSXXwTYsaaYTpEb3oM0pqQo/iLUVz4G02aUFy7goRnpYmAOom5cF1JNg2lJokAHaSoSe9ELDNP3W2ho5+FsKpDyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVP5ninl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772787240; x=1804323240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2TPppUaJ68o9IXGsmLBrAN+ZgrR/oOK6H1OCUtq2zYw=;
  b=PVP5ninlVisY4w3Wa+0RmEHBYs/DUU9Ub/PAbm+sv8kUEba+Y6dQf0Mt
   oMs/V0AqgaM+azzC6opOjQa2QKgt0cEvA5gS55neivsKkMigwGF7BCEpZ
   5TKamc/VfZdsBkF3lFKzMTyPOQiHhR+CL6A9DU+4FToqNBVMjmj3sA1oh
   erabuxPWQcC7yT0sLACF2Mwdzz16HYTVjODz2lIZBwA1aLxAH4+5oTBQm
   RU43VPCEgxfrF+VGvW7fpmOolNFwwAcpR9m+uvLRAI7r5Z2luKBqQgBvZ
   W3GxUj+fsHtkoCr9QBXugpDwobAM2Vjw2/aJmphr9izaMCUNkxgkUegZf
   w==;
X-CSE-ConnectionGUID: SljFq5DZRhu2hv/rM5CSiA==
X-CSE-MsgGUID: BSCEtlxeT+WWNwKZjxPkjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91467239"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="91467239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:53:59 -0800
X-CSE-ConnectionGUID: +YdkYsyYS9+S3ZC37ipvuQ==
X-CSE-MsgGUID: n1dEhomqT1aSyH9FFhWP+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223641487"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.171])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:53:57 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V5 3/5] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Date: Fri,  6 Mar 2026 10:53:36 +0200
Message-ID: <20260306085338.62955-4-adrian.hunter@intel.com>
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
X-Rspamd-Queue-Id: C8FD721D8A1
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
	TAGGED_FROM(0.00)[bounces-43759-lists,linux-pm=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
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


Changes in V5:

	Re-base on top of v7.0 fixes series:
		https://lore.kernel.org/linux-i3c/20260306072451.11131-1-adrian.hunter@intel.com/T

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
index 54d5492545ef..d803c0b7a64e 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -759,7 +759,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
 	return 0;
 }
 
-static int i3c_hci_runtime_suspend(struct device *dev)
+int i3c_hci_rpm_suspend(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
@@ -776,8 +776,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i3c_hci_rpm_suspend);
 
-static int i3c_hci_runtime_resume(struct device *dev)
+int i3c_hci_rpm_resume(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
@@ -800,6 +801,27 @@ static int i3c_hci_runtime_resume(struct device *dev)
 
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
@@ -844,8 +866,6 @@ static int i3c_hci_restore(struct device *dev)
 	return i3c_hci_resume_common(dev, true);
 }
 
-#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
-
 static void i3c_hci_rpm_enable(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 02cab3b3bc6f..f17f43494c1b 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -151,6 +151,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
 #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
 #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
+#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
@@ -161,4 +162,9 @@ void amd_set_resp_buf_thld(struct i3c_hci *hci);
 void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
 int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
 
+#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
+
+int i3c_hci_rpm_suspend(struct device *dev);
+int i3c_hci_rpm_resume(struct device *dev);
+
 #endif
-- 
2.51.0


