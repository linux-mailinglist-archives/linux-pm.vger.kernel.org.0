Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6905D2620A1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbgIHUNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbgIHUNa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 16:13:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2341A21919;
        Tue,  8 Sep 2020 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596010;
        bh=sNzB6t/5kKkQ+Ltfcjtg8unu1ta56Hhvl+AG2wXjpr8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gsnPn53TiN/dbM/VAPmS/R5HE8LefCbpm8Q2L3CaOSQPbuXnjyhGV39m3PDytut5Y
         I8bggQ+fZLYRv1TN74BCjXucqJboDWBPvN13n6WsTeqs4xEhNwmP/cp7RlHoBlLFqP
         neAeuTRUyfq+38cHhZTD36xl2YRPA3xaEEL5w0i4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] power: supply: bq27xxx: adjust whitespace
Date:   Tue,  8 Sep 2020 22:13:15 +0200
Message-Id: <20200908201319.3567-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908201319.3567-1-krzk@kernel.org>
References: <20200908201319.3567-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 65806f668b1f..2deac3fbb036 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -76,7 +76,7 @@
 
 /* BQ27Z561 has different layout for Flags register */
 #define BQ27Z561_FLAG_FDC	BIT(4) /* Battery fully discharged */
-#define BQ27Z561_FLAG_FC		BIT(5) /* Battery fully charged */
+#define BQ27Z561_FLAG_FC	BIT(5) /* Battery fully charged */
 #define BQ27Z561_FLAG_DIS_CH	BIT(6) /* Battery is discharging */
 
 /* control register params */
-- 
2.17.1

