Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C7332DC7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhCISEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhCISER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC852C06174A;
        Tue,  9 Mar 2021 10:04:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F2A161F457F9
Received: by jupiter.universe (Postfix, from userid 1000)
        id B26584800C8; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 3/7] power: supply: sbs-charger: drop unused gpio includes
Date:   Tue,  9 Mar 2021 19:04:03 +0100
Message-Id: <20210309180407.650943-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309180407.650943-1-sebastian.reichel@collabora.com>
References: <20210309180407.650943-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sbs-charger does not use any GPIOs, so no need to include
gpio.h and of_gpio.h.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 36a048d687e0..6fa65d118ec1 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -16,9 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/regmap.h>
-#include <linux/of_gpio.h>
 #include <linux/bitops.h>
 
 #define SBS_CHARGER_REG_SPEC_INFO		0x11
-- 
2.30.1

