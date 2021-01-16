Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A74C2F8F63
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 22:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAPVOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 16:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbhAPVOF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 16:14:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E6C061573;
        Sat, 16 Jan 2021 13:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Rmv4Ihp0TdcI92yM4qcVe/aLXHiozbrVgcWboXhwYpM=; b=svAjN2bum/EwuKWAxCW+uGqfQJ
        YKecJI8PXqtHVrYOEF/vd4rsgwYTmRzvYS+CtZ94DSGqKS9k5ITdU2zLVD5hx2ZF+tOB5fH3bMYkd
        P49lHS9/uNKDa0XL/B8z8kqmqpl3dQr7hVDAKko9Sa0hXp5h4331hbHhTzwF2vvsNJoMBtmZhQXvd
        mH48IUgsQiwg4MDU8wY/WhuLgVwN7vJv17OGtqtD6lckIYyOuCfqi0fezY6vwgpz40Q7a51HebAyy
        kgZscVrYp4UOLOBZ8LIG7reieotSIvSLXCiqSHWANQC5P2uBwl4D2HlpJtu2x1Cn5JX1yjDVPi5bF
        +PN+fk/Q==;
Received: from [2601:1c0:6280:3f0::9abc] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0sso-0006kP-4q; Sat, 16 Jan 2021 21:13:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolassaenzj@gmail.com,
        Nicolas Saenz Julienne <nicolas.saenz@prodys.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] power: supply: fix sbs-charger build, needs REGMAP_I2C
Date:   Sat, 16 Jan 2021 13:13:10 -0800
Message-Id: <20210116211310.19232-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CHARGER_SBS should select REGMAP_I2C since it uses API(s) that are
provided by that Kconfig symbol.

Fixes these errors:

../drivers/power/supply/sbs-charger.c:149:21: error: variable ‘sbs_regmap’ has initializer but incomplete type
 static const struct regmap_config sbs_regmap = {
../drivers/power/supply/sbs-charger.c:150:3: error: ‘const struct regmap_config’ has no member named ‘reg_bits’
  .reg_bits = 8,
../drivers/power/supply/sbs-charger.c:155:23: error: ‘REGMAP_ENDIAN_LITTLE’ undeclared here (not in a function)
  .val_format_endian = REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
../drivers/power/supply/sbs-charger.c: In function ‘sbs_probe’:
../drivers/power/supply/sbs-charger.c:183:17: error: implicit declaration of function ‘devm_regmap_init_i2c’; did you mean ‘devm_request_irq’? [-Werror=implicit-function-declaration]
  chip->regmap = devm_regmap_init_i2c(client, &sbs_regmap);
../drivers/power/supply/sbs-charger.c: At top level:
../drivers/power/supply/sbs-charger.c:149:35: error: storage size of ‘sbs_regmap’ isn’t known
 static const struct regmap_config sbs_regmap = {

Fixes: feb583e37f8a ("power: supply: add sbs-charger driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: nicolassaenzj@gmail.com
Cc: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
Martin, do you want Reported-by: on this?

 drivers/power/supply/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210115.orig/drivers/power/supply/Kconfig
+++ linux-next-20210115/drivers/power/supply/Kconfig
@@ -229,6 +229,7 @@ config BATTERY_SBS
 config CHARGER_SBS
 	tristate "SBS Compliant charger"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y to include support for SBS compliant battery chargers.
 
