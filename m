Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BCC3D7BF9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhG0RQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 13:16:21 -0400
Received: from box.trvn.ru ([194.87.146.52]:55379 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhG0RQV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Jul 2021 13:16:21 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 13:16:20 EDT
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9FB2C41408;
        Tue, 27 Jul 2021 22:06:34 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1627405594; bh=J1QeZY0GGxGmKqHWfK3B8iOjYhKTd83rZqFYkpeUGxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/z31ToftYcAHNl2NmLIapDRICE5pqrSkmgNpdRf7a/ZYp7aRgOiU1TIfG3pKOP7i
         4/DyTth35V81SRx6kNFHXuadSlJrfDhmE7gG0f3n6yp/TQnxGN/SQIj1iFfwLDf/Ex
         NCfaMwWQVHDklFf/GsZ9JprZB1YaQXn8KxAYjZTR/FwIi4xOOjRUHxcQ38XdFvX4IH
         Zc5+G8I7pcZq8+xQgNniwZEYWL4L8SGwiZnbZY6nECjm2lAyR+6H+LAkqypbtZUS2l
         pPz7CbOslZbV+Xvm2grvwvl6byiC+7infAOG1uWpfbh1OMSBOtMenip1Hm/sDhx5Eb
         zrdt+kd0nOVGw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 2/2] power: supply: max17042_battery: Add support for MAX77849 Fuel-Gauge
Date:   Tue, 27 Jul 2021 22:03:45 +0500
Message-Id: <20210727170345.115004-2-nikita@trvn.ru>
In-Reply-To: <20210727170345.115004-1-nikita@trvn.ru>
References: <20210727170345.115004-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MAX77849 is a combined fuel-gauge, charger and MUIC IC. Notably,
fuel-gauge has dedicated i2c lines and seems to be fully compatible
with max17047. Add new compatible for it reusing max17047 code paths.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/power/supply/max17042_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index ce2041b30a06..f28c90ea41b4 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1196,6 +1196,7 @@ static const struct of_device_id max17042_dt_match[] = {
 	{ .compatible = "maxim,max17047" },
 	{ .compatible = "maxim,max17050" },
 	{ .compatible = "maxim,max17055" },
+	{ .compatible = "maxim,max77849-battery" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, max17042_dt_match);
@@ -1206,6 +1207,7 @@ static const struct i2c_device_id max17042_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
-- 
2.30.2

