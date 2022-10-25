Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6E60D61B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiJYVZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJYVZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 17:25:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA4184E52;
        Tue, 25 Oct 2022 14:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98E45B81F14;
        Tue, 25 Oct 2022 21:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04236C433C1;
        Tue, 25 Oct 2022 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666733130;
        bh=DEGdbtQfxFm6mrAmG/COgWG2NEG9FmYT+rFk7kh1Lsg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZEmUSLDbl7PXWRU2z42RwCORzAB5ikfZUFyawsFsxaBY5YR5fRCRuZ99MIfgpqbeg
         M1bfDhh7sbfcd7JET0GIBQBR6M/OTyfIwx0JPD/D2zWPcMZZaTVZRuFjnDPGS3AdHC
         MhpBYdOEt8TvvtZxPhrBExZE7kLheFxEk3gP4yrBCgLsnIWMqaDFbX4wEfTAj87bzX
         Q1/wIfZmjJiIVm9kmtBSbF4tyurM6jpKOkMbU0bKCEUCzOAPyv05DPrRPPuFnk7WR3
         qHMD6SgTFbaDEZswnqdWMH8vel59rpQRQENUhyVCNTS+npGghEjyJGL2ra2mM09fe+
         VvRjT6mH8M2gg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] firewire: ohci: convert to generic power management
Date:   Tue, 25 Oct 2022 16:25:21 -0500
Message-Id: <20221025212521.686779-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Convert ohci from legacy PCI power management to the generic power
management framework.

Previously, ohci used legacy PCI power management, and pci_suspend() and
pci_resume() were responsible for both device-specific things and generic
PCI things:

  pci_suspend
    software_reset()                    <-- device-specific
    pci_save_state(pdev)                <-- generic PCI
    pci_set_power_state(pdev, pci_choose_state(pdev, state)) <-- generic PCI
    pmac_ohci_off(pdev)                 <-- device-specific

  pci_resume
    pmac_ohci_on(pdev)                  <-- device-specific
    pci_set_power_state(pdev, PCI_D0)   <-- generic PCI
    pci_restore_state(pdev)             <-- generic PCI
    ohci_enable()                       <-- device-specific
    ...

With generic power management, the PCI bus PM methods do the generic PCI
things, and the driver needs only the device-specific part, i.e.,

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      pci_pm_suspend                    # PCI bus .suspend() method
        pci_suspend                     # dev->driver->pm->suspend
          software_reset()              <-- device-specific
          pmac_ohci_off(pdev)           <-- device-specific (DIFFERENT ORDER)
    suspend_enter
      dpm_suspend_noirq(PMSG_SUSPEND)
        pci_pm_suspend_noirq            # PCI bus .suspend_noirq() method
          pci_save_state                <-- generic PCI
          pci_prepare_to_sleep          <-- generic PCI
            pci_set_power_state
    ...
    dpm_resume_end(PMSG_RESUME)
      pci_pm_resume                     # PCI bus .resume() method
        pci_restore_standard_config
          pci_set_power_state(PCI_D0)   <-- generic PCI
          pci_restore_state             <-- generic PCI
        pci_resume                      # dev->driver->pm->resume
          pmac_ohci_on(pdev)            <-- device-specific (DIFFERENT ORDER)
          ohci_enable()                 <-- device-specific
          ...

N.B. This changes the order of pmac_ohci_off() and pmac_ohci_on().
Previously, pmac_ohci_off() was called *after* pci_save_state() and
pci_set_power_state(), and this change calls it *before*.

Similarly, pmac_ohci_on() was previously called *before*
pci_set_power_state() and pci_restore_state() and this change calls it
*after*.

The code in pmac_ohci_on() and pmac_ohci_off() was added by ea8d006b91ac
("firewire: fw-ohci: PPC PMac platform code").

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

v1 was posted at https://lore.kernel.org/r/20200720150715.624520-1-vaibhavgupta40@gmail.com

Changes from v1 to v2:
  - Convert from SIMPLE_DEV_PM_OPS() (which is deprecated) to
    DEFINE_SIMPLE_DEV_PM_OPS() and remove __maybe_unused annotations.
  - Expand commit log.

 drivers/firewire/ohci.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 17c9d825188b..f3cceca51e59 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3165,7 +3165,6 @@ static int ohci_set_iso_channels(struct fw_iso_context *base, u64 *channels)
 	return ret;
 }
 
-#ifdef CONFIG_PM
 static void ohci_resume_iso_dma(struct fw_ohci *ohci)
 {
 	int i;
@@ -3183,7 +3182,6 @@ static void ohci_resume_iso_dma(struct fw_ohci *ohci)
 			ohci_start_iso(&ctx->base, 0, ctx->sync, ctx->tags);
 	}
 }
-#endif
 
 static int queue_iso_transmit(struct iso_context *ctx,
 			      struct fw_iso_packet *packet,
@@ -3789,39 +3787,24 @@ static void pci_remove(struct pci_dev *dev)
 	dev_notice(&dev->dev, "removed fw-ohci device\n");
 }
 
-#ifdef CONFIG_PM
-static int pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int pci_suspend(struct device *dev)
 {
-	struct fw_ohci *ohci = pci_get_drvdata(dev);
-	int err;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 
 	software_reset(ohci);
-	err = pci_save_state(dev);
-	if (err) {
-		ohci_err(ohci, "pci_save_state failed\n");
-		return err;
-	}
-	err = pci_set_power_state(dev, pci_choose_state(dev, state));
-	if (err)
-		ohci_err(ohci, "pci_set_power_state failed with %d\n", err);
-	pmac_ohci_off(dev);
+	pmac_ohci_off(pdev);
 
 	return 0;
 }
 
-static int pci_resume(struct pci_dev *dev)
+static int pci_resume(struct device *dev)
 {
-	struct fw_ohci *ohci = pci_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 	int err;
 
-	pmac_ohci_on(dev);
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	err = pci_enable_device(dev);
-	if (err) {
-		ohci_err(ohci, "pci_enable_device failed\n");
-		return err;
-	}
+	pmac_ohci_on(pdev);
 
 	/* Some systems don't setup GUID register on resume from ram  */
 	if (!reg_read(ohci, OHCI1394_GUIDLo) &&
@@ -3838,7 +3821,6 @@ static int pci_resume(struct pci_dev *dev)
 
 	return 0;
 }
-#endif
 
 static const struct pci_device_id pci_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_FIREWIRE_OHCI, ~0) },
@@ -3847,15 +3829,14 @@ static const struct pci_device_id pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, pci_table);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(pci_pm_ops, pci_suspend, pci_resume);
+
 static struct pci_driver fw_ohci_pci_driver = {
 	.name		= ohci_driver_name,
 	.id_table	= pci_table,
 	.probe		= pci_probe,
 	.remove		= pci_remove,
-#ifdef CONFIG_PM
-	.resume		= pci_resume,
-	.suspend	= pci_suspend,
-#endif
+	.driver.pm	= &pci_pm_ops,
 };
 
 static int __init fw_ohci_init(void)
-- 
2.25.1

