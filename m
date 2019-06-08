Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347D839CCB
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 12:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFHK4x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 06:56:53 -0400
Received: from sauhun.de ([88.99.104.3]:51870 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfFHK4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Jun 2019 06:56:52 -0400
Received: from localhost (p5486CBCC.dip0.t-ipconnect.de [84.134.203.204])
        by pokefinder.org (Postfix) with ESMTPSA id 049023E4771;
        Sat,  8 Jun 2019 12:56:50 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/34] power: supply: max14656_charger_detector: simplify getting the adapter of a client
Date:   Sat,  8 Jun 2019 12:55:58 +0200
Message-Id: <20190608105619.593-20-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/power/supply/max14656_charger_detector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 9e6472834e37..f27b780d2c02 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -251,7 +251,7 @@ static void stop_irq_work(void *data)
 static int max14656_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	struct power_supply_config psy_cfg = {};
 	struct max14656_chip *chip;
-- 
2.19.1

