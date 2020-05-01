Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711E51C191D
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgEAPLV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:11:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:25543 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbgEAPLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 11:11:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DG126KGyzLn;
        Fri,  1 May 2020 17:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588345878; bh=6AxS1CfoogQpoe8cy7spMNPhnnOirl0mqEZf/CePzBE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Y0dO+r5AE68NUPxWe0fVcGJWsJU/jdfj9+ju3qBMdolFI0pnDUqhuaBhsANu9sMX3
         LfrYyDmhKq1ijB39KazbGQHSs583kXY25aBuXhHG60Slp5Sz3ONdpCN28OdZAErEXj
         CyiOh2wvugKs5NUBR9uCKD0qDtTAVu+5O14bixsAWftH+2kmneAKHprVMgSr5WV/AM
         TIcRaapCl/0clL9lKK9dP9JptY0FuNpFXZYLTaLNvZHQNutzGGJuki/UjaL7tGNUz8
         ZWtokM0evlMwv/UaM2G7zP6EEwR0hFuQnU+vm9c/AkZmmAIMOf+fpk1wgjLBo4GHXn
         5K/qD6zB7bCVg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 17:11:18 +0200
Message-Id: <79bec8125df260bdae294345bd7773dc3dd9c434.1588345420.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 1/4] power: supply: core: tabularize HWMON temperature
 labels
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rework power_supply_hwmon_read_string() to check it's parameters.
This allows to extend it later with labels for other types of
measurements.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: split from fix temperature labels
v3: remove power_supply_hwmon_read_string() parameter checks
    as it is internal API (suggested by Guenter Roeck)
v4: remove unreachable() as it triggers compiler bugs
---
 drivers/power/supply/power_supply_hwmon.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index af72e5693f65..f5d538485aaa 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -13,6 +13,11 @@ struct power_supply_hwmon {
 	unsigned long *props;
 };
 
+static const char *const ps_temp_label[] = {
+	"temp",
+	"ambient temp",
+};
+
 static int power_supply_hwmon_in_to_property(u32 attr)
 {
 	switch (attr) {
@@ -180,7 +185,20 @@ static int power_supply_hwmon_read_string(struct device *dev,
 					  u32 attr, int channel,
 					  const char **str)
 {
-	*str = channel ? "temp ambient" : "temp";
+	switch (type) {
+	case hwmon_temp:
+		*str = ps_temp_label[channel];
+		break;
+	default:
+		/* unreachable, but see:
+		 * gcc bug #51513 [1] and clang bug #978 [2]
+		 *
+		 * [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51513
+		 * [2] https://github.com/ClangBuiltLinux/linux/issues/978
+		 */
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.20.1

