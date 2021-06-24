Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318763B2B34
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFXJVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhFXJVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:21:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E5CC061574;
        Thu, 24 Jun 2021 02:18:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x24so9029663lfr.10;
        Thu, 24 Jun 2021 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3Xs22v9YodibxgfhDWCF12VK+jYjhqQdkvlmNgIQsQ=;
        b=tAb1yuC1N4ve1hdrHxEzX4/lqYOF7Hg11/RQ4tyJHC4blsQ9bvQHjJ3si4OodGdXzf
         lOJbxJxNE3Vnk0VWuKb7/s5D4P+rtK+Q28AYg3eGyt+BGeKc4mxx1kb+cJB9CS/NV62I
         99Yr9FXmcZZDxrjDcTiw9bsLz11lJDPwq+f99NJxjqXM6iy59k2qW183wdvn0DGlwWo+
         tgz1Pm7mFbvap/WTSmSnnfnXbDuOkHAiaM+jMWx3CwDCJfjbJ5VmGcPeIN0WQri977+O
         PcpSdq2EX6bKXQvwetrugI+nLkuGTO7vpN0m0ZyD+FmcZ6CGsibmY6nF++8BR3/oeCQh
         adSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3Xs22v9YodibxgfhDWCF12VK+jYjhqQdkvlmNgIQsQ=;
        b=R2UA66RUmZ0whZOxHzB7yJTWewEwDwtZnw/Nd6hMsCDGc2u35DUjsT5qJwCEKnhZWU
         v0/L4IGwMec/pzb5k3xpvP9DA+lfj9LLCDvZQlNTG0faeLp8Fs2A5RZfNjni7ff2NPaz
         A9HKGt9qp0iLz5O+I/jHsLBsqQY4ennoSXrSG8RaozhvJALJKTVzENWjZx6EPLesASRA
         5whi4hcdq4Lj+53A/D7ZDMcIt8Rc74hFZBXJN/sGLBLnwqv/C86lKP+QptOQF/Qnx4v3
         qPo7/m5cRiijmTHPbWWchlgaXlgrra2C4uPYPMFPySFshqi5OLeYjBun9ODjlL/yPCrW
         0dWQ==
X-Gm-Message-State: AOAM5325DjAlMqhH+7c30WV3qII7PSaqSUjuDTlHMDrym5mrEG8p9mJS
        jK/4dCreIlPpPlfn41DvU4Y=
X-Google-Smtp-Source: ABdhPJxrmwO3XfwebWb1k0Q7utcGo45C3joBKBUqYNkBTmSZHt7mlcRl2aPoRQgNaCi27CkFpz5gYg==
X-Received: by 2002:a19:5e16:: with SMTP id s22mr3267356lfb.614.1624526321660;
        Thu, 24 Jun 2021 02:18:41 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id l15sm234012ljc.35.2021.06.24.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 02:18:41 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Daniel Gonzalez Cabanelas <dgcbueu@gmail.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: reset: linkstation-poweroff: prepare for new devices
Date:   Thu, 24 Jun 2021 11:18:11 +0200
Message-Id: <20210624091813.42334-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit prepare driver for another device support.

New power_off_cfg structure describes two most important things: name of
mdio bus and pointer to register setting function. It allow to add new
device with different mdio bus node and other phy register config.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/power/reset/linkstation-poweroff.c | 35 ++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/reset/linkstation-poweroff.c
index f1e843df0e16..cb5a32f852c1 100644
--- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -29,11 +29,21 @@
 #define LED2_FORCE_ON					(0x8 << 8)
 #define LEDMASK						GENMASK(11,8)
 
+struct power_off_cfg {
+	char *mdio_node_name;
+	void (*phy_set_reg)(bool restart);
+};
+
 static struct phy_device *phydev;
+static const struct power_off_cfg *cfg;
 
-static void mvphy_reg_intn(u16 data)
+static void linkstation_mvphy_reg_intn(bool restart)
 {
 	int rc = 0, saved_page;
+	u16 data = 0;
+
+	if (restart)
+		data = MII_88E1318S_PHY_LED_TCR_FORCE_INT;
 
 	saved_page = phy_select_page(phydev, MII_MARVELL_LED_PAGE);
 	if (saved_page < 0)
@@ -66,11 +76,16 @@ static void mvphy_reg_intn(u16 data)
 		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
 }
 
+static const struct power_off_cfg linkstation_power_off_cfg = {
+	.mdio_node_name = "mdio",
+	.phy_set_reg = linkstation_mvphy_reg_intn,
+};
+
 static int linkstation_reboot_notifier(struct notifier_block *nb,
 				       unsigned long action, void *unused)
 {
 	if (action == SYS_RESTART)
-		mvphy_reg_intn(MII_88E1318S_PHY_LED_TCR_FORCE_INT);
+		cfg->phy_set_reg(true);
 
 	return NOTIFY_DONE;
 }
@@ -82,14 +97,18 @@ static struct notifier_block linkstation_reboot_nb = {
 static void linkstation_poweroff(void)
 {
 	unregister_reboot_notifier(&linkstation_reboot_nb);
-	mvphy_reg_intn(0);
+	cfg->phy_set_reg(false);
 
 	kernel_restart("Power off");
 }
 
 static const struct of_device_id ls_poweroff_of_match[] = {
-	{ .compatible = "buffalo,ls421d" },
-	{ .compatible = "buffalo,ls421de" },
+	{ .compatible = "buffalo,ls421d",
+	  .data = &linkstation_power_off_cfg,
+	},
+	{ .compatible = "buffalo,ls421de",
+	  .data = &linkstation_power_off_cfg,
+	},
 	{ },
 };
 
@@ -97,13 +116,17 @@ static int __init linkstation_poweroff_init(void)
 {
 	struct mii_bus *bus;
 	struct device_node *dn;
+	const struct of_device_id *match;
 
 	dn = of_find_matching_node(NULL, ls_poweroff_of_match);
 	if (!dn)
 		return -ENODEV;
 	of_node_put(dn);
 
-	dn = of_find_node_by_name(NULL, "mdio");
+	match = of_match_node(ls_poweroff_of_match, dn);
+	cfg = match->data;
+
+	dn = of_find_node_by_name(NULL, cfg->mdio_node_name);
 	if (!dn)
 		return -ENODEV;
 
-- 
2.25.1

