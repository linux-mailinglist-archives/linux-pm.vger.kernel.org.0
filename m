Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9053AC76A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFRJbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 05:31:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49274 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFRJbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 05:31:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1luAoW-0004EP-Sw; Fri, 18 Jun 2021 09:29:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp288_fuel_gauge: remove redundant continue statement
Date:   Fri, 18 Jun 2021 10:29:24 +0100
Message-Id: <20210618092924.99722-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
invert the if expression and remove the continue.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 39e16ecb7638..20e63609ab47 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -142,9 +142,7 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
 
 	for (i = 0; i < NR_RETRY_CNT; i++) {
 		ret = regmap_read(info->regmap, reg, &val);
-		if (ret == -EBUSY)
-			continue;
-		else
+		if (ret != -EBUSY)
 			break;
 	}
 
-- 
2.31.1

