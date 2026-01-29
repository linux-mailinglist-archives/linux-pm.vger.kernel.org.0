Return-Path: <linux-pm+bounces-41708-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM69IKmke2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41708-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:19:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B093B37E4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A62B2300FFAE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3B2F6168;
	Thu, 29 Jan 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtXYaa/y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F012F7478;
	Thu, 29 Jan 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710751; cv=none; b=Rzep9B3EbLr3zqLj6maulMijEaMHAavFVhzRCkHvJADj8gfHRsUodXoTbhJLNmOjyfsPnnJydKPiiw9NBaYB2yyLyoaz62C1ReWtXDyTJpM+pYOAmhJlRyIvZWgi+N2ROonR/2OXMNJ4GXXi2uHhoEWgqDUUsAxYUfw7KBJ73YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710751; c=relaxed/simple;
	bh=AWlIhdshhmjS73wOeHEVcHwr+5JYfpWGb0oWfu2v+PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkYPzBvokCjTeUx3zOdTLYOnKmocQs+xU7m8XY7t7Os4mZkoG9zDYMH3N7lLSG6WtceO5KF0dV7LR7344G414Pd3WjiYtz+IHh92gwJAhCM+r3b8OTbsua1+zWYEUpYFeH3r8raXHMmNfm0sNVIa0/Juvqc3X0C6mG0zZRVWWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtXYaa/y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710747; x=1801246747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AWlIhdshhmjS73wOeHEVcHwr+5JYfpWGb0oWfu2v+PU=;
  b=RtXYaa/yLJ84AGpwoTKGGW0pSoTctYRYzjIZbBfww98OE/AL9k7fLweZ
   UqfbfU7Opvu1ba8d3eFz+u0zHBg8BD/+nQDk0Jxr9/nkPdxVephXaOP0I
   CdPSuOuMZfD9IlaktJdnf6s6wINXThpH6YUz9VhR2Ds9jKIHL+qA5T111
   7YtKcxVxcggFXQH9Te7dVSUx0VoJJr8msjg3NrkM/mFk41FVZPxGjrSl5
   9TtrOxU3djcc3tBYfreJd/J4dD5bU/QwafCEaIjT5NU1Qn5J74gvWRTnJ
   F2jHuNWG2iSrm5+/Te0GPXCWqmtHxcK3HcTy6Uu6a/fT7x7UglBnI4y9I
   A==;
X-CSE-ConnectionGUID: KzJm1VBoTWaqMehEaU7njQ==
X-CSE-MsgGUID: E+RKMoT/QFiz+2W1JQntqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158306"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:07 -0800
X-CSE-ConnectionGUID: UUrurI4bRpupyvvFbJW5Pg==
X-CSE-MsgGUID: mNkDKfuCTLC+4h/hhfY57Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255311"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:05 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 6/7] i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
Date: Thu, 29 Jan 2026 20:18:40 +0200
Message-ID: <20260129181841.130864-7-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41708-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 2B093B37E4
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

  * Add runtime PM and system PM callbacks in the PCI driver to invoke
    the mipi-i3c-hci driver’s runtime PM callbacks for each instance.

  * Introduce a driver-data flag, control_instance_pm, which opts into
    the new parent-managed PM behaviour.

  * Ensure the callbacks are only used when the corresponding instance is
    operational at suspend time.  This is reliable because the operational
    state cannot change while the parent device is undergoing a PM
    transition, and PCI always performs a runtime resume before system
    suspend on current configurations, so that suspend and resume alternate
    irrespective of whether it is runtime or system PM.

By that means, parent-managed runtime PM coordination for multi-instance
MIPI I3C HCI PCI devices is provided without altering existing behaviour on
platforms that do not require it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../master/mipi-i3c-hci/mipi-i3c-hci-pci.c    | 154 +++++++++++++++++-
 1 file changed, 150 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index bc83caad4197..f7f776300a0f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
+#include <linux/i3c/master.h>
 #include <linux/idr.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -20,16 +21,24 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 
+#include "hci.h"
+
 /*
  * There can up to 15 instances, but implementations have at most 2 at this
  * time.
  */
 #define INST_MAX 2
 
+struct mipi_i3c_hci_pci_instance {
+	struct device *dev;
+	bool operational;
+};
+
 struct mipi_i3c_hci_pci {
 	struct pci_dev *pci;
 	void __iomem *base;
 	const struct mipi_i3c_hci_pci_info *info;
+	struct mipi_i3c_hci_pci_instance instance[INST_MAX];
 	void *private;
 };
 
@@ -40,6 +49,7 @@ struct mipi_i3c_hci_pci_info {
 	int id[INST_MAX];
 	u32 instance_offset[INST_MAX];
 	int instance_count;
+	bool control_instance_pm;
 };
 
 #define INTEL_PRIV_OFFSET		0x2b0
@@ -210,14 +220,148 @@ static const struct mipi_i3c_hci_pci_info intel_si_2_info = {
 	.instance_count = 1,
 };
 
-static void mipi_i3c_hci_pci_rpm_allow(struct device *dev)
+static int mipi_i3c_hci_pci_find_instance(struct mipi_i3c_hci_pci *hci, struct device *dev)
+{
+	for (int i = 0; i < INST_MAX; i++) {
+		if (!hci->instance[i].dev)
+			hci->instance[i].dev = dev;
+		if (hci->instance[i].dev == dev)
+			return i;
+	}
+
+	return -1;
+}
+
+#define HC_CONTROL			0x04
+#define HC_CONTROL_BUS_ENABLE		BIT(31)
+
+static bool __mipi_i3c_hci_pci_is_operational(struct device *dev)
+{
+	const struct mipi_i3c_hci_platform_data *pdata = dev->platform_data;
+	u32 hc_control = readl(pdata->base_regs + HC_CONTROL);
+
+	return hc_control & HC_CONTROL_BUS_ENABLE;
+}
+
+static bool mipi_i3c_hci_pci_is_operational(struct device *dev, bool update)
+{
+	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev->parent);
+	int pos = mipi_i3c_hci_pci_find_instance(hci, dev);
+
+	if (pos < 0) {
+		dev_err(dev, "%s: I3C instance not found\n", __func__);
+		return false;
+	}
+
+	if (update)
+		hci->instance[pos].operational = __mipi_i3c_hci_pci_is_operational(dev);
+
+	return hci->instance[pos].operational;
+}
+
+struct mipi_i3c_hci_pci_pm_data {
+	struct device *dev[INST_MAX];
+	int dev_cnt;
+};
+
+static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
+{
+	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
+}
+
+static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *data)
+{
+	struct mipi_i3c_hci_pci_pm_data *pm_data = data;
+	int ret;
+
+	if (!mipi_i3c_hci_pci_is_mfd(dev) ||
+	    !mipi_i3c_hci_pci_is_operational(dev, true))
+		return 0;
+
+	ret = i3c_hci_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	pm_data->dev[pm_data->dev_cnt++] = dev;
+
+	return 0;
+}
+
+static int mipi_i3c_hci_pci_resume_instance(struct device *dev, void *data)
 {
+	struct mipi_i3c_hci_pci_pm_data *pm_data = data;
+	int ret;
+
+	if (!mipi_i3c_hci_pci_is_mfd(dev) ||
+	    !mipi_i3c_hci_pci_is_operational(dev, false))
+		return 0;
+
+	ret = i3c_hci_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	pm_data->dev[pm_data->dev_cnt++] = dev;
+
+	return 0;
+}
+
+static int mipi_i3c_hci_pci_suspend(struct device *dev)
+{
+	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
+	struct mipi_i3c_hci_pci_pm_data pm_data = {};
+	int ret;
+
+	if (!hci->info->control_instance_pm)
+		return 0;
+
+	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
+	if (ret) {
+		if (ret == -EAGAIN || ret == -EBUSY)
+			pm_runtime_mark_last_busy(&hci->pci->dev);
+		for (int i = 0; i < pm_data.dev_cnt; i++)
+			i3c_hci_runtime_resume(pm_data.dev[i]);
+	}
+
+	return ret;
+}
+
+static int mipi_i3c_hci_pci_resume(struct device *dev)
+{
+	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
+	struct mipi_i3c_hci_pci_pm_data pm_data = {};
+	int ret;
+
+	if (!hci->info->control_instance_pm)
+		return 0;
+
+	ret = device_for_each_child(dev, &pm_data, mipi_i3c_hci_pci_resume_instance);
+	if (ret)
+		for (int i = 0; i < pm_data.dev_cnt; i++)
+			i3c_hci_runtime_suspend(pm_data.dev[i]);
+
+	return ret;
+}
+
+static void mipi_i3c_hci_pci_rpm_allow(struct mipi_i3c_hci_pci *hci)
+{
+	struct device *dev = &hci->pci->dev;
+
+	if (hci->info->control_instance_pm) {
+		pm_runtime_set_autosuspend_delay(dev, DEFAULT_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_use_autosuspend(dev);
+	}
+
 	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
 }
 
-static void mipi_i3c_hci_pci_rpm_forbid(struct device *dev)
+static void mipi_i3c_hci_pci_rpm_forbid(struct mipi_i3c_hci_pci *hci)
 {
+	struct device *dev = &hci->pci->dev;
+
+	if (hci->info->control_instance_pm)
+		pm_runtime_dont_use_autosuspend(dev);
+
 	pm_runtime_forbid(dev);
 	pm_runtime_get_sync(dev);
 }
@@ -299,7 +443,7 @@ static int mipi_i3c_hci_pci_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(pci, hci);
 
-	mipi_i3c_hci_pci_rpm_allow(&pci->dev);
+	mipi_i3c_hci_pci_rpm_allow(hci);
 
 	return 0;
 
@@ -316,13 +460,15 @@ static void mipi_i3c_hci_pci_remove(struct pci_dev *pci)
 	if (hci->info->exit)
 		hci->info->exit(hci);
 
-	mipi_i3c_hci_pci_rpm_forbid(&pci->dev);
+	mipi_i3c_hci_pci_rpm_forbid(hci);
 
 	mfd_remove_devices(&pci->dev);
 }
 
 /* PM ops must exist for PCI to put a device to a low power state */
 static const struct dev_pm_ops mipi_i3c_hci_pci_pm_ops = {
+	RUNTIME_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume)
 };
 
 static const struct pci_device_id mipi_i3c_hci_pci_devices[] = {
-- 
2.51.0


