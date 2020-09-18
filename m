Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70BF26EED2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Sep 2020 04:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgIRCOZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 22:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgIRCOP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Sep 2020 22:14:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8995E239ED;
        Fri, 18 Sep 2020 02:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395255;
        bh=yj/lYPazjcLxTYPDL2xayjRqc9FZe9CiFPn3FykP1nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kncOSEcbLZbSsJb4cvJMvZ8HZAk7kT/DYh5eh9Dl4ftLXyUosJq1umej9ePSWKx8L
         EGF8R9UhCgqNBkEL4LQRE4S7Z+hK1Kl8YMH5kuDhTjfeJ8sIZwXrlyTDZKT80oj3/8
         RTSq44Af3Nse9ObbvMNl8Qb0XGdukh7xwGVnwB9U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 096/127] power: supply: max17040: Correct voltage reading
Date:   Thu, 17 Sep 2020 22:11:49 -0400
Message-Id: <20200918021220.2066485-96-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit 0383024f811aa469df258039807810fc3793a105 ]

According to the datasheet available at (1), the bottom four
bits are always zero and the actual voltage is 1.25x this value
in mV.  Since the kernel API specifies that voltages should be in
uV, it should report 1250x the shifted value.

1) https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 33c40f79d23d5..2c35c13ad546f 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -109,7 +109,7 @@ static void max17040_get_vcell(struct i2c_client *client)
 
 	vcell = max17040_read_reg(client, MAX17040_VCELL);
 
-	chip->vcell = vcell;
+	chip->vcell = (vcell >> 4) * 1250;
 }
 
 static void max17040_get_soc(struct i2c_client *client)
-- 
2.25.1

