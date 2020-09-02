Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14AB25A93D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBKRB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 06:17:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49357 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIBKQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 06:16:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kDPp2-0005hd-M7; Wed, 02 Sep 2020 10:16:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: fix spelling mistake "unprecise" -> "imprecise"
Date:   Wed,  2 Sep 2020 11:16:56 +0100
Message-Id: <20200902101656.57676-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/rn5t618_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index 424d2817bee5..dee520f0fdf5 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -487,7 +487,7 @@ static int rn5t618_power_probe(struct platform_device *pdev)
 		 * gauge will get decalibrated.
 		 */
 		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now\n");
-		dev_info(&pdev->dev, "Expect unprecise results\n");
+		dev_info(&pdev->dev, "Expect imprecise results\n");
 		regmap_update_bits(info->rn5t618->regmap, RN5T618_CONTROL,
 				   FG_ENABLE, FG_ENABLE);
 	}
-- 
2.27.0

