Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC32D7647
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391594AbgLKNKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436591AbgLKNJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:46 -0500
Date:   Fri, 11 Dec 2020 13:09:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glvrnwvZ8QkbHM3ywC0TidLWf+rXgmoaRgtgKx7UakU=;
        b=ypy3DqOD7d/DpsddeRvJhpweeec7sHV7N3GNfttakbwKrvP62vbygbfRRVchjBirALSNZs
        pABowcrnjxgYhmX8xp5b4e9EiHxI3jF2HTQ2uxu9GCp+cXzzrR+Fjzazhc77xpPjQtqErt
        TZDmrU8oLxC4MQbp/PirNP9Gts8bTLollUGh8taBIFBJMWrLS0numNph1QhQiA6iyECHGV
        VSbh3Nwh3q0KBtXeJc3I8CuZDB30qHgPm1BGJKtMdb0r2Pq8+2BmE8370ExJkUGL41irD9
        nTpaThAR6qhBN5Xa91VcEkI+t60jnhTaxGOnuzIk9bmN6LH6uJ96QrTvbygZMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glvrnwvZ8QkbHM3ywC0TidLWf+rXgmoaRgtgKx7UakU=;
        b=VGMLppQHznmJ7VHIpohcNisTb5gye7hgW0h0klhDH7NsN/ZVeOLjHRi4rtYc4DJSoOmibO
        jlmBOhBNB0Q3ZCBw==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: int340x: processor_thermal: Add
 AlderLake PCI device id
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201126171829.945969-2-srinivas.pandruvada@linux.intel.com>
References: <20201126171829.945969-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160769214246.3364.16793971436856295094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     df2537f910400cd4f90d2ecb40a0a1a204d8470c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//df2537f910400cd4f90d2ecb40a0a1a204d8470c
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 26 Nov 2020 09:18:27 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Dec 2020 12:29:48 +01:00

thermal: int340x: processor_thermal: Add AlderLake PCI device id

Added AlderLake PCI device id to support processor thermal driver. Reuse
the feature set (just includes RAPL) from previous generations.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201126171829.945969-2-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 5b8dc5e..589ac7d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -566,6 +566,7 @@ static int proc_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index e20d142..4521457 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -9,6 +9,7 @@
 
 #include <linux/intel_rapl.h>
 
+#define PCI_DEVICE_ID_INTEL_ADL_THERMAL	0x461d
 #define PCI_DEVICE_ID_INTEL_BDW_THERMAL	0x1603
 #define PCI_DEVICE_ID_INTEL_BSW_THERMAL	0x22DC
 
