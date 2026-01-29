Return-Path: <linux-pm+bounces-41706-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOA7N4ale2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41706-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:23:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33FB3870
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F08F309776D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619632D94BA;
	Thu, 29 Jan 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUWTOdaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECD2EC559;
	Thu, 29 Jan 2026 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710749; cv=none; b=kOvKgJYnIE1/4VQogD085rgA6a6qCwn90d+WsfBwgdGySO0sucxucLOlGXtDsM7BlHkXDq83/O9mBOQs2j9RTqR4Zf+fXOmJdCK2pYjhs9uev6MuMjfXNQBkwCtljnPeaxBLkwcK4rBLZ9fluk9LNSwkUlziW3o5xvWFAo6pUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710749; c=relaxed/simple;
	bh=FvGsEFvSio7RVlbQNqHfD88CcH9KEbCthWMDWmb30mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4NNYKsQlSRZ/vDOswE2V2UkwOIMXK1iQJXj+hB9k2N0Ild8lcfpO20XSez/6mQd48Tl+34MBrGxX6uomufbnBMK3haFjUzmVLv5yRz8UglYfDfxM1Bz3mFZPOfbtxWNFnE7B1IpVmqwl6WSsyBOMfZyvoVxZfWVOSWjsCMR+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUWTOdaI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710745; x=1801246745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FvGsEFvSio7RVlbQNqHfD88CcH9KEbCthWMDWmb30mI=;
  b=fUWTOdaIm2ZN7IUZTIJHc/nl2Vhef4sFaNWHoOViEWj/FASlEi5qorOi
   r0cItqLN5uKp3YzfMHMeKqArZYlmNgDGB5aoxbNPVN9ZwfhpoVG+66b31
   xRW7vse/vNeY+cFR2UY07DXP9zqaw951GsoY5EEju3RrNAiqqAeM6CdY5
   /3zdjM8gUtZ5Y/u9RtwAaitdpiAZzbO2SIkoeqagIFz+DQk16I53Y29/V
   /8JO/4Txvkz266MdmeIPP8QPXmb/VVYMmzzUjlOgP3OQ4/mPQCxicFQFN
   conyqbQ79n7tHeFdIThnPjo4M0FsHUbxzhp3JwKgTN5oqRzQ7y6ghgA5E
   g==;
X-CSE-ConnectionGUID: VSH9IuHoTMacdAKI61pEmw==
X-CSE-MsgGUID: QhFWryidQe2r5FqNmY/3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158297"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:05 -0800
X-CSE-ConnectionGUID: lCsLGKXRSg+yvE8TH/VaqA==
X-CSE-MsgGUID: L9t24EcPR8mNFQ934HCgCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255305"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:03 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Date: Thu, 29 Jan 2026 20:18:39 +0200
Message-ID: <20260129181841.130864-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129181841.130864-1-adrian.hunter@intel.com>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41706-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 5A33FB3870
X-Rspamd-Action: no action

Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
where a single parent device hosts multiple I3C controller instances.  In
such designs, the parent - not the individual child instances - may need to
coordinate runtime PM so that all controllers enter low-power states
together, and all runtime suspend callbacks are invoked in a controlled
and synchronized manner.

For example, if the parent enables IBI-wakeup when transitioning into a
low-power state, every bus instance must remain able to receive IBIs up
until that point.  This requires deferring the individual controllers’
runtime suspend callbacks (which disable bus activity) until the parent
decides it is safe for all instances to suspend together.

To support this usage model:

  * Export the controller's runtime PM suspend/resume callbacks so that
    the parent can invoke them directly.

  * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
    parent device as the controller’s runtime PM device (rpm_dev).  When
    used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
    instance’s system-suspend callbacks from using
    pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
    PM is managed entirely by the parent.

  * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
    by parent-managed PM implementations.

The new quirk allows platforms with multi-bus parent-managed PM
infrastructure to correctly coordinate runtime PM across all I3C HCI
instances.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
 drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index ec4dbe64c35e..cb974b0f9e17 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
 	return 0;
 }
 
-static int i3c_hci_runtime_suspend(struct device *dev)
+int i3c_hci_runtime_suspend(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
@@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
 
-static int i3c_hci_runtime_resume(struct device *dev)
+int i3c_hci_runtime_resume(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
@@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
 
 static int i3c_hci_suspend(struct device *dev)
 {
@@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
 	struct i3c_hci *hci = dev_get_drvdata(dev);
 	int ret;
 
-	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
-		return 0;
+	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
+		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
+			return 0;
 
-	ret = pm_runtime_force_resume(dev);
-	if (ret)
-		return ret;
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
 	if (ret)
@@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
 	return i3c_hci_resume_common(dev, true);
 }
 
-#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
-
 static void i3c_hci_rpm_enable(struct device *dev)
 {
 	struct i3c_hci *hci = dev_get_drvdata(dev);
@@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
 		hci->master.rpm_ibi_allowed = true;
 
+	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
+		hci->master.rpm_dev = pdev->dev.parent;
+		hci->master.rpm_allowed = true;
+	}
+
 	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
 }
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 819328a85b84..d0e7ad58ac15 100644
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
+int i3c_hci_runtime_suspend(struct device *dev);
+int i3c_hci_runtime_resume(struct device *dev);
+
 #endif
-- 
2.51.0


