Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F72C26640A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIKQaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 12:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgIKQ2E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:28:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19BC22208;
        Fri, 11 Sep 2020 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841666;
        bh=Sx4EuGaHyHb+oW4aw/xTYThAtAnevqos0vAP/q03wt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1LS9l5vpU3gl6gR7bZMSzrnswJXsY1IESrsIRwWFpsrHiG8Oli9hSUZSGR+mlaRx
         mZPsdD8ZQc6lZgeNNvnJa1VkdAvVZ4VC4jJEmEzw7PAbqrH/0gdeKthCKTG0iEUElJ
         r41d5Fj1CLvPAuBx+1pk6WC/AFQkh61Aeb+0G5Jg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 7/7] power: supply: pm2301: drop duplicated i2c_device_id
Date:   Fri, 11 Sep 2020 18:27:29 +0200
Message-Id: <20200911162729.3022-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
References: <20200911162729.3022-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver defines two of 'struct i2c_device_id' but uses only one:

  drivers/power/supply/pm2301_charger.c:107:35: warning:
    'pm2xxx_ident' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/pm2301_charger.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 787867805944..2df6a2459d1f 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -104,11 +104,6 @@ static int pm2xxx_charger_current_map[] = {
 	3000,
 };
 
-static const struct i2c_device_id pm2xxx_ident[] = {
-	{ "pm2301", 0 },
-	{ }
-};
-
 static void set_lpn_pin(struct pm2xxx_charger *pm2)
 {
 	if (!pm2->ac.charger_connected && gpio_is_valid(pm2->lpn_pin)) {
-- 
2.17.1

