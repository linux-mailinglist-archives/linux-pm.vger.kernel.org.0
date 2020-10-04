Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3F282E2D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgJDWqS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Oct 2020 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDWqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2020 18:46:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F1C0613CE
        for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2020 15:46:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5E07028DA94
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1F53D48010E; Mon,  5 Oct 2020 00:46:14 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>,
        Vicente Bergas <vicencb@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] power: supply: sbs-battery: chromebook workaround for PEC
Date:   Mon,  5 Oct 2020 00:46:01 +0200
Message-Id: <20201004224601.420786-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks like the I2C tunnel implementation from Chromebook's
embedded controller does not handle PEC correctly. Fix this
by disabling PEC for batteries behind those I2C tunnels as
a workaround.

Reported-by: "Milan P. Stanić" <mps@arvanta.net>
Reported-by: Vicente Bergas <vicencb@gmail.com>
CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Fixes: 7222bd603dd2 ("power: supply: sbs-battery: add PEC support")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Hi,

This is compile-tested only, since I do not have a chromebook at
hand. Please test if this fixes your issue.

-- Sebastian
---
 drivers/power/supply/sbs-battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 13192cbcce71..b6a538ebb378 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -279,6 +279,12 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 	else
 		client->flags &= ~I2C_CLIENT_PEC;
 
+	if (of_device_is_compatible(client->dev.parent->of_node, "google,cros-ec-i2c-tunnel")
+	    && client->flags & I2C_CLIENT_PEC) {
+		dev_info(&client->dev, "Disabling PEC because of broken Cros-EC implementation\n");
+		client->flags &= ~I2C_CLIENT_PEC;
+	}
+
 	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
 		"enabled" : "disabled");
 
-- 
2.28.0

