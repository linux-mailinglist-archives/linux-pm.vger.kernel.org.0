Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC31A73B
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2019 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfEKI43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 May 2019 04:56:29 -0400
Received: from shell.v3.sk ([90.176.6.54]:51860 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfEKI43 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 May 2019 04:56:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3E9C8104088;
        Sat, 11 May 2019 10:56:25 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SgZ03tkjHUY6; Sat, 11 May 2019 10:56:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E5B9E104101;
        Sat, 11 May 2019 10:56:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u9iqiHrguB1a; Sat, 11 May 2019 10:56:19 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CC94C104088;
        Sat, 11 May 2019 10:56:18 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] power: supply: olpc_battery: force the le/be casts
Date:   Sat, 11 May 2019 10:56:14 +0200
Message-Id: <20190511085614.29677-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The endianness of data returned from the EC depends on the particular EC
version determined at run time. Cast from little/big endian explicitey
in the routine that flips endianness to the native one to make sparse
happy.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 76311b9a3295 ("power: supply: olpc_battery: Add OLPC XO 1.75 suppo=
rt")
---
 drivers/power/supply/olpc_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 4ccd242fcf72..066ec9a11153 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -326,9 +326,9 @@ static int olpc_bat_get_voltage_max_design(union powe=
r_supply_propval *val)
 static u16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_word)
 {
 	if (data->little_endian)
-		return le16_to_cpu(ec_word);
+		return le16_to_cpu((__force __le16)ec_word);
 	else
-		return be16_to_cpu(ec_word);
+		return be16_to_cpu((__force __be16)ec_word);
 }
=20
 /*********************************************************************
@@ -340,7 +340,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
 {
 	struct olpc_battery_data *data =3D power_supply_get_drvdata(psy);
 	int ret =3D 0;
-	__be16 ec_word;
+	u16 ec_word;
 	uint8_t ec_byte;
 	__be64 ser_buf;
=20
--=20
2.21.0

