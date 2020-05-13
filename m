Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7331D1E3C
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbgEMS5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390397AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C134A2A29D7
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8D60948010D; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 14/19] power: supply: sbs-battery: fix idle battery status
Date:   Wed, 13 May 2020 20:56:10 +0200
Message-Id: <20200513185615.508236-15-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A battery, that is neither charged, nor discharged is not
always Full. If the charger is disabled for other reasons
it might simply be idle and should be marked accordingly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 2a2b926ad75c..e3c685b2c247 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -354,9 +354,9 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
 
 	ret = (s16)ret;
 
-	/* Not drawing current means full (cannot be not charging) */
-	if (ret == 0)
-		*intval = POWER_SUPPLY_STATUS_FULL;
+	/* Not drawing current -> not charging (i.e. idle) */
+	if (*intval != POWER_SUPPLY_STATUS_FULL && ret == 0)
+		*intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 
 	if (*intval == POWER_SUPPLY_STATUS_FULL) {
 		/* Drawing or providing current when full */
-- 
2.26.2

