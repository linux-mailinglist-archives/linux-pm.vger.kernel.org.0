Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5210733122C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHP3r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 10:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhCHP3l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 10:29:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F12C6526A;
        Mon,  8 Mar 2021 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615217381;
        bh=n4ZjPMWSBwDBwg/gyfzEkY2KhR5GTgDq57IHPhhJFfc=;
        h=From:To:Cc:Subject:Date:From;
        b=cLML5E8iOaNbsLI26oYs5nz+cTUCNzuGuk8Qjtl+hrGUYaBrnM5a2agn0P1hY+/Dj
         lXA9eDd+hoAomMEEOts0xtSe0zZLl0E5oYyOnLSbm+UQYyKe66xW3cFcrByuKmIloj
         YSrW9Sdy+WF08y3JN9Awx6xRbdDxBDRUEOjJvklMnnHA3FCuBVx78+6UnVVsYxE8mr
         y1czW/oGe1r97x4j9x5GTcczRs+E1++rrwH//pRyVjS1AYbgigCajNjytf1fdFjzBq
         zbmMH1mZuTt8f8K9/n3LbALcbaAmPN9OYPi9p6YzClAWhJXVQFlGJz9Xsq295xS6EP
         /DCFjFc1ZqQlg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max8997_charger: make EXTCON dependency unconditional
Date:   Mon,  8 Mar 2021 16:29:05 +0100
Message-Id: <20210308152935.2263935-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some of the extcon interfaces have a fallback implementation that can
be used when EXTCON is disabled, but some others do not, causing a
build failure:

drivers/power/supply/max8997_charger.c:261:9: error: implicit declaration of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-function-declaration]
                ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
                      ^
drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm_extcon_register_notifier'?
include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' declared here
static inline int devm_extcon_register_notifier(struct device *dev,

I assume there is no reason to actually build this driver without extcon
support, so a hard dependency is the easiest fix. Alternatively the
header file could be extended to provide additional inline stubs.

Fixes: f384989e88d4 ("power: supply: max8997_charger: Set CHARGER current limit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 006b95eca673..6cce17e1d47a 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -555,7 +555,7 @@ config CHARGER_MAX77693
 config CHARGER_MAX8997
 	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
 	depends on MFD_MAX8997 && REGULATOR_MAX8997
-	depends on EXTCON || !EXTCON
+	depends on EXTCON
 	help
 	  Say Y to enable support for the battery charger control sysfs and
 	  platform data of MAX8997/LP3974 PMICs.
-- 
2.29.2

