Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75EE1A6C1F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgDMSjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733019AbgDMSi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 14:38:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F957C008749;
        Mon, 13 Apr 2020 11:38:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F06E22A12DF
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4F0404800EA; Mon, 13 Apr 2020 20:38:55 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 1/4] power: supply: core: Constify usb_types
Date:   Mon, 13 Apr 2020 20:38:50 +0200
Message-Id: <20200413183853.1088823-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

usb_types is a list of USB types supported by the
hardware, which does not change at runtime. Let's
mark it as const for improved security.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b..45dafc1820ff 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -78,7 +78,7 @@ static const char * const power_supply_scope_text[] = {
 };
 
 static ssize_t power_supply_show_usb_type(struct device *dev,
-					  enum power_supply_usb_type *usb_types,
+					  const enum power_supply_usb_type *usb_types,
 					  ssize_t num_usb_types,
 					  union power_supply_propval *value,
 					  char *buf)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index dcd5a71e6c67..0392c9cc8f1c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -223,7 +223,7 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
-	enum power_supply_usb_type *usb_types;
+	const enum power_supply_usb_type *usb_types;
 	size_t num_usb_types;
 	enum power_supply_property *properties;
 	size_t num_properties;
-- 
2.25.1

