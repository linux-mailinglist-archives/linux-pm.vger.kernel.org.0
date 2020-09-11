Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79556266413
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgIKQah (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 12:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgIKQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5263722204;
        Fri, 11 Sep 2020 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841656;
        bh=G1H4KBZK6Z5xZfrreS53bo+fWNiN/FdHp8IsoAi5Cf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqjsMpCrIJCJsqErxjAkkQElm0E6h4bYI0AH7V/EZkEJqHnqyx4u2uAenLC0xQ66L
         TIg4mYICvefovMXVR2X3iycArkuYbYAewzFaz9vBPUbP+AFixi758c62yvgZ0aWK/n
         3XnvHzGX4v9gRA7S2NI8aC22PaTSkXqFVbuMa9I4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/7] power: supply: bq2515x: fix kerneldoc
Date:   Fri, 11 Sep 2020 18:27:24 +0200
Message-Id: <20200911162729.3022-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
References: <20200911162729.3022-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix kerneldoc W=1 warning:

  drivers/power/supply/bq2515x_charger.c:189: warning:
    Function parameter or member 'init_data' not described in 'bq2515x_device'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq2515x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 9dcb61ea4cf2..374b112f712a 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -168,7 +168,7 @@ enum bq2515x_id {
  * @device_id: value of device_id
  * @mains_online: boolean value indicating power supply online
  *
- * @bq2515x_init_data init_data: charger initialization data structure
+ * @init_data: charger initialization data structure
  */
 struct bq2515x_device {
 	struct power_supply *mains;
-- 
2.17.1

