Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FD3B2B37
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhFXJVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhFXJVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:21:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C7C061756;
        Thu, 24 Jun 2021 02:18:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f30so9153420lfj.1;
        Thu, 24 Jun 2021 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXfOM6leRUQqiZ6AFWwroCwvOGjuryrfMXxJydNy138=;
        b=einnfXZf7ii7QJx6TtS31VgK5ZNpYU/8FyhQydjGvH05VJVt1Fe56oZu+hoR4NerQ+
         Y3RvVVU1SB/Y4h3mCDcJYa//JHH9+Iu1qJ9jCVNI2rn2n12fJaTb3mm3GGqKeqYykSEr
         5PTeJeT2EIe80HHRMOmU1npz2Y3yYu4/XbNY2+CYBMuT7GR7yNDfyG0/B0UDtalCKKJg
         tOujS0x8k0T+wWX0xjhUNoroBk2VJAOWLA9lGk0luUX6cN9TveuFLW/vo557fwyA8O2+
         6T5Y9+Zu3Zw1UywKLulIsNQgSzY4SccBCvfqz8BSdQOndk8MuPiQXaC6B5mkOD7Lb72T
         SQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXfOM6leRUQqiZ6AFWwroCwvOGjuryrfMXxJydNy138=;
        b=kK0IBG354aEqyNijmpZ/dgi253okOlRt/0GcloIKkUZTXqSa55z4H2cBpdd7bCETQs
         BpF5ifhGI3dCVj46m2hTFH1mT90EuxuDGaEHepo6QX7mVdCwNB4JXWxe1L4DBhIHNmai
         pDV9MdmkLGFarC6niFTGefPfdCBT2JyXOR3YPjYweIUtvh5Kyw48e5WXHv7+HruLC/KA
         MQxYS2I0hto4dfsVrObxaxboUM+8hbPedO3Jbx2+GHx09w1AwpB2KrW/FbdOrZ//NX5S
         kkEbCgeZ13FlGW6Pa3/QXk6DL3i0cdfAZx83G5E9Gx9d7fKL9/9TdMa+Y/n0n1jBJ48V
         L2Aw==
X-Gm-Message-State: AOAM5321n7FfdbCh5+5peIVyMk0qpabPnJRqZcPJ5BdBJ7SHxgeP1sGR
        fp9AvV9gqVLnldWwnqwXNtA=
X-Google-Smtp-Source: ABdhPJxe79tfNAU9V/IgOi1WykGvXxyfL0E4yl5Eut/WPsbOWE+91CSHDj3tbIYXTECe9bdMg7yqtg==
X-Received: by 2002:ac2:5d22:: with SMTP id i2mr3113433lfb.371.1624526333340;
        Thu, 24 Jun 2021 02:18:53 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id l15sm234012ljc.35.2021.06.24.02.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 02:18:52 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Daniel Gonzalez Cabanelas <dgcbueu@gmail.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: reset: linkstation-poweroff: add new device
Date:   Thu, 24 Jun 2021 11:18:12 +0200
Message-Id: <20210624091813.42334-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624091813.42334-1-paweldembicki@gmail.com>
References: <20210624091813.42334-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit introduces support for NETGEAR ReadyNAS Duo v2.
This device use bit 4 of LED[2:0] Polarity Control Register to indicate
AC Power loss.

For more details about AC loss detection in NETGEAR ReadyNAS Duo v2,
please look at the file:
RND_5.3.13_WW.src/u-boot/board/mv_feroceon/mv_hal/usibootup/usibootup.c
from Netgear GPL sources.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/power/reset/linkstation-poweroff.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/reset/linkstation-poweroff.c
index cb5a32f852c1..5afe3ef23395 100644
--- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -19,6 +19,7 @@
 #define MII_MARVELL_PHY_PAGE		22
 
 #define MII_PHY_LED_CTRL		16
+#define MII_PHY_LED_POL_CTRL		17
 #define MII_88E1318S_PHY_LED_TCR	18
 #define MII_88E1318S_PHY_WOL_CTRL	16
 #define MII_M1011_IEVENT		19
@@ -29,6 +30,8 @@
 #define LED2_FORCE_ON					(0x8 << 8)
 #define LEDMASK						GENMASK(11,8)
 
+#define MII_88E1318S_PHY_LED_POL_LED2		BIT(4)
+
 struct power_off_cfg {
 	char *mdio_node_name;
 	void (*phy_set_reg)(bool restart);
@@ -76,11 +79,48 @@ static void linkstation_mvphy_reg_intn(bool restart)
 		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
 }
 
+static void readynas_mvphy_set_reg(bool restart)
+{
+	int rc = 0, saved_page;
+	u16 data = 0;
+
+	if (restart)
+		data = MII_88E1318S_PHY_LED_POL_LED2;
+
+	saved_page = phy_select_page(phydev, MII_MARVELL_LED_PAGE);
+	if (saved_page < 0)
+		goto err;
+
+	/* Set the LED[2].0 Polarity bit to the required state */
+	__phy_modify(phydev, MII_PHY_LED_POL_CTRL,
+		     MII_88E1318S_PHY_LED_POL_LED2, data);
+
+	if (!data) {
+
+		/* If WOL was enabled and a magic packet was received before powering
+		 * off, we won't be able to wake up by sending another magic packet.
+		 * Clear WOL status.
+		 */
+		__phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_WOL_PAGE);
+		__phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
+			       MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS);
+	}
+err:
+	rc = phy_restore_page(phydev, saved_page, rc);
+	if (rc < 0)
+		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
+}
+
 static const struct power_off_cfg linkstation_power_off_cfg = {
 	.mdio_node_name = "mdio",
 	.phy_set_reg = linkstation_mvphy_reg_intn,
 };
 
+static const struct power_off_cfg readynas_power_off_cfg = {
+	.mdio_node_name = "mdio-bus",
+	.phy_set_reg = readynas_mvphy_set_reg,
+};
+
 static int linkstation_reboot_notifier(struct notifier_block *nb,
 				       unsigned long action, void *unused)
 {
@@ -109,6 +149,9 @@ static const struct of_device_id ls_poweroff_of_match[] = {
 	{ .compatible = "buffalo,ls421de",
 	  .data = &linkstation_power_off_cfg,
 	},
+	{ .compatible = "netgear,readynas-duo-v2",
+	  .data = &readynas_power_off_cfg,
+	},
 	{ },
 };
 
-- 
2.25.1

