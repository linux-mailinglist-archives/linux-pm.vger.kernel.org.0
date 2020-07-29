Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53814231A82
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 09:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgG2Hn4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 03:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2Hnz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 03:43:55 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFF520838;
        Wed, 29 Jul 2020 07:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596008635;
        bh=jKObMlOsG6jrgJGRXhXHhyX78D9kV4sDJzchO9Ukh8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xy7Y7WnOW2uWpC9ZlaYCwKIFV/kIyz5X6GIB7yVy1f7aXi7bm9K8CIIc8paJhdtqZ
         izh/S+M1WrPzoMOwEyd0Tn/z0rKKezVWpYLTa0D8lmr2I/NfS+mcb/7UxTBHKhWu2n
         UO0rtqzjp/j27buJIZO2wkWSPTzgAMvqYn6qFy2s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] power: supply: Fix kerneldoc of power_supply_temp2resist_simple()
Date:   Wed, 29 Jul 2020 09:43:48 +0200
Message-Id: <20200729074348.28317-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729074348.28317-1-krzk@kernel.org>
References: <20200729074348.28317-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/power/supply/power_supply_core.c:747: warning: Function parameter or member 'temp' not described in 'power_supply_temp2resist_simple'
    drivers/power/supply/power_supply_core.c:747: warning: Excess function parameter 'ocv' description in 'power_supply_temp2resist_simple'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 90e56736d479..ccbad435ed12 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -733,7 +733,7 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
  * percent
  * @table: Pointer to battery resistance temperature table
  * @table_len: The table length
- * @ocv: Current temperature
+ * @temp: Current temperature
  *
  * This helper function is used to look up battery internal resistance percent
  * according to current temperature value from the resistance temperature table,
-- 
2.17.1

