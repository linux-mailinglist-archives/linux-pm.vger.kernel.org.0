Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1460D5A0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiJYUjD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYUjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 16:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C7061DBB;
        Tue, 25 Oct 2022 13:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D34DA61B8A;
        Tue, 25 Oct 2022 20:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E56C433D6;
        Tue, 25 Oct 2022 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666730341;
        bh=9BVyvHpCzFYNdZ3nJvRlGSWnz3qxu4Z4JfrHxC45mlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBbuxxY38N33cQ/3BYsV0hJWID/Npq535lOhs3s3GHFA+eOZJkQFwyRO6QGKNvAWw
         4OxvHZVKfIZcDS6cmW7s5k4h/o4eX/8rbBUzRAfMVVaHvRIlmBTTmBFo5A5PPfxvCi
         SBYnWqE4tVNK3GbGFuSShSlqsy3hIirBQOW7HzdkzHY6zorVc3EukzWS3QCe0UmxCl
         1Jf3+j+1RgXXXvRZ+36ky/5VZ+pm3q+3zF+AJGYpJXf8oFXp87XLJFKBnWPl7DHMKU
         AY5ngkYBrZMwHM9C0MtSKZ1rWFYlW93VI7VqsImEml8vJZug+S9SXaWfFxMNzkiXYL
         kpVqdYCkYHWsg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@redhat.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/8] agp/efficeon: Convert to generic power management
Date:   Tue, 25 Oct 2022 15:38:45 -0500
Message-Id: <20221025203852.681822-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025203852.681822-1-helgaas@kernel.org>
References: <20221025203852.681822-1-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Convert agpgart-efficeon from legacy PCI power management to the generic
power management framework.

Previously agpgart-efficeon used legacy PCI power management, which means
agp_efficeon_suspend() and agp_efficeon_resume() were responsible for both
device-specific things and generic PCI things like saving and restoring
config space and managing power state.

In this case, agp_efficeon_suspend() was empty, and agp_efficeon_resume()
already did only device-specific things, so simply convert it to take a
struct device * instead of a struct pci_dev *.

Based on 0aeddbd0cb07 ("via-agp: convert to generic power management") by
Vaibhav Gupta <vaibhavgupta40@gmail.com>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/efficeon-agp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index c53f0f9ef5b0..f28d42319269 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -412,18 +412,11 @@ static void agp_efficeon_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
-static int agp_efficeon_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	return 0;
-}
-
-static int agp_efficeon_resume(struct pci_dev *pdev)
+static int agp_efficeon_resume(struct device *dev)
 {
 	printk(KERN_DEBUG PFX "agp_efficeon_resume()\n");
 	return efficeon_configure();
 }
-#endif
 
 static const struct pci_device_id agp_efficeon_pci_table[] = {
 	{
@@ -437,6 +430,8 @@ static const struct pci_device_id agp_efficeon_pci_table[] = {
 	{ }
 };
 
+static DEFINE_SIMPLE_DEV_PM_OPS(agp_efficeon_pm_ops, NULL, agp_efficeon_resume);
+
 MODULE_DEVICE_TABLE(pci, agp_efficeon_pci_table);
 
 static struct pci_driver agp_efficeon_pci_driver = {
@@ -444,10 +439,7 @@ static struct pci_driver agp_efficeon_pci_driver = {
 	.id_table	= agp_efficeon_pci_table,
 	.probe		= agp_efficeon_probe,
 	.remove		= agp_efficeon_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_efficeon_suspend,
-	.resume		= agp_efficeon_resume,
-#endif
+	.driver.pm	= &agp_efficeon_pm_ops,
 };
 
 static int __init agp_efficeon_init(void)
-- 
2.25.1

