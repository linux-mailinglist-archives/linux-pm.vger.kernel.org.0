Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55137332DC4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhCISEo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35246 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhCISES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F2E861F45819
Received: by jupiter.universe (Postfix, from userid 1000)
        id B87934800DD; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6/7] power: supply: sbs-manager: update gpio include
Date:   Tue,  9 Mar 2021 19:04:06 +0100
Message-Id: <20210309180407.650943-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309180407.650943-1-sebastian.reichel@collabora.com>
References: <20210309180407.650943-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sbs-manager implements a GPIO chip, so include the proper
gpio driver include instead of the legacy gpio.h.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index bd2af3ef1021..71ec8f74f835 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -13,7 +13,7 @@
  * Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-- 
2.30.1

