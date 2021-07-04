Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9E3BAE29
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhGDSFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhGDSFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD131C061762
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 11:02:29 -0700 (PDT)
Date:   Sun, 04 Jul 2021 18:02:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tirOCfnW11XWBGwzxDFP2aTefJMcvc9TeXU95XeeME=;
        b=X3n8Q0lxLuOanUBtkHnzNt3VSrE1Pf8bw3k4tK9GFDgO8DjW0d+FJyJHNhE5yRmfV1S7o2
        gKyB/e/oc8YyZsTQaDjhSgBNqi0tjw5HDUYPMsiFEECYwLq0M7s4xf+2laeX009LwE5Q2Y
        bafzSGFgddPkulMh8PZWcaqfkzDilrabjxxrS7qkluJONyIJOtQSt6IVwVHSeRPRTQ80g3
        X7QTi37NJZ41XlcMX00MT72o45nfMxMjDR1VWvf6Et88fysVDCpCK1FmqoUyGYNeVYkMd+
        2EOkQCsYzbEbLZzTHtaay3ylvbOKDyJiaM3ioSE74G7DUqpZAFjdYVqd+aYnSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tirOCfnW11XWBGwzxDFP2aTefJMcvc9TeXU95XeeME=;
        b=zL3Xyoa2h6SO4+SdZYsA2N6AHYLde5ylVAw+x8CLUDLQWMDVnkXwC6GfMBnAnUaUbIhO0q
        MrUmCVocYUB3yeBQ==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/int340x/processor_thermal:
 Fix warning for return value
Cc:     kernel test robot <lkp@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210628183232.62877-1-srinivas.pandruvada@linux.intel.com>
References: <20210628183232.62877-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162542174558.395.2511638474464107483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ad079d981db6a4047b60c576df6430bed36bcd7d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ad079d981db6a4047b60c576df6430bed36bcd7d
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Mon, 28 Jun 2021 11:32:32 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

thermal/drivers/int340x/processor_thermal: Fix warning for return value

Fix smatch warnings:
drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c:258 proc_thermal_pci_probe() warn: missing error code 'ret'

Use PTR_ERR to return failure of thermal_zone_device_register().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210628183232.62877-1-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index ad7e2e3..11dd2e8 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -254,8 +254,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1, 1, pci_info,
 							&tzone_ops,
 							&tzone_params, 0, 0);
-	if (IS_ERR(pci_info->tzone))
+	if (IS_ERR(pci_info->tzone)) {
+		ret = PTR_ERR(pci_info->tzone);
 		goto err_ret_mmio;
+	}
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
