Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5C85F43
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbfHHKKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 06:10:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45367 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389774AbfHHKKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 06:10:44 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id b3a161ced17e49cd; Thu, 8 Aug 2019 12:10:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-nvme <linux-nvme@lists.infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled_mask()
Date:   Thu, 08 Aug 2019 12:06:52 +0200
Message-ID: <3714448.mG7dE8Q3Fs@kreacher>
In-Reply-To: <1921165.pTveHRX1Co@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a function returning the mask of currently enabled ASPM link
states for a given device.

It will be used by the NVMe driver to decide how to handle the
device during system suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  * Move the PCI/PCIe ASPM changes to a separate patch.
  * Add the _mask suffix to the new function name.
  * Add EXPORT_SYMBOL_GPL() to the new function.
  * Avoid adding an unnecessary blank line.

---
 drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
 include/linux/pci.h     |    3 +++
 2 files changed, 23 insertions(+)

Index: linux-pm/drivers/pci/pcie/aspm.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/aspm.c
+++ linux-pm/drivers/pci/pcie/aspm.c
@@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
 module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 	NULL, 0644);
 
+/*
+ * pcie_aspm_enabled_mask - Return the mask of enabled ASPM link states.
+ * @pci_device: Target device.
+ */
+u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(pci_device);
+	u32 ret;
+
+	if (!bridge)
+		return 0;
+
+	mutex_lock(&aspm_lock);
+	ret = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
+	mutex_unlock(&aspm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcie_aspm_enabled_mask);
+
 #ifdef CONFIG_PCIEASPM_DEBUG
 static ssize_t link_state_show(struct device *dev,
 		struct device_attribute *attr,
Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -1567,8 +1567,11 @@ extern bool pcie_ports_native;
 
 #ifdef CONFIG_PCIEASPM
 bool pcie_aspm_support_enabled(void);
+u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device);
 #else
 static inline bool pcie_aspm_support_enabled(void) { return false; }
+static inline u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
+{ return 0; }
 #endif
 
 #ifdef CONFIG_PCIEAER



