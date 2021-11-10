Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442F244B9A1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 01:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKJAhG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 19:37:06 -0500
Received: from li1434-30.members.linode.com ([45.33.107.30]:46204 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhKJAhF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 19:37:05 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 19:37:05 EST
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 14B1C5DE02F;
        Wed, 10 Nov 2021 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1636503896; bh=fV1/s/8BNEP4rofaEIpdzzOvWDJaKNztJSjH9886HB8=;
        h=From:To:Cc:Subject:Date;
        b=i1NqxdibxkLCEO0qZoDS49QGLASKaFFnzcr73R9A7SVqt+KJNkrsfQkMGag/QEwYc
         oijHyDiD2eVLCiGvnlTxOQENEoT4D5Md3skfoBHDed8wxQmwPpQSLmLoU6kgktCvLK
         fjOQ6K2X+UPV+5wQAyzIMwsgTJ7Ii9ymbMbqKjm0=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dlzn0ko_5TOf; Wed, 10 Nov 2021 00:24:55 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 5C7535DE01D;
        Wed, 10 Nov 2021 00:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1636503895; bh=fV1/s/8BNEP4rofaEIpdzzOvWDJaKNztJSjH9886HB8=;
        h=From:To:Cc:Subject:Date;
        b=h1/QL0rfr0gQusd5Z5tPzpo3dQZv1xUv7ZLujymVUU6iPWN6xL/C8pzdRzqiK4hBf
         tT0fnlPZ52pXSzyhC5OpyDuxXHq+vW70FSa4kImjpTmV1ZvtJC2eGBUF0+ROQ7XpLA
         LJ0d4UnYgoSEgxRErCZL3U7oDJAogQc2v43LTRzM=
From:   Angus Ainslie <angus@akkea.ca>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH] power: bq25890: temperature is also an adc value
Date:   Tue,  9 Nov 2021 16:24:40 -0800
Message-Id: <20211110002440.71404-1-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make sure that a conversion is forced when the power supply is offline so
the temperature is valid.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 945c3257ca93..23a91c5d1f9d 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -388,6 +388,7 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
 	switch (psp) {
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_TEMP:
 		return true;
 
 	default:
-- 
2.25.1

