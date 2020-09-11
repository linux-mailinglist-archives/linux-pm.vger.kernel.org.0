Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B4266410
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIKQai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 12:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgIKQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C56221EB;
        Fri, 11 Sep 2020 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841654;
        bh=iVrTsu1h/6XlgdpG7zNyUdsnzo/x/58Z/4c9hRJI3iM=;
        h=From:To:Cc:Subject:Date:From;
        b=p5w4DH3NWmRDXCmqROyjGb503AOrxeMLr3ldg0FtnhVLzvq4sRSHrK83BXXPNaxzZ
         Pd7c9Hq1BTErlyyx7oIMPEDJ3fCaKoOiOZM2uRdSyo5bEzOPoRcmOcGe/cmCAyBIzY
         bvQzUzzXqOCedLTOKikBMlt/6Ck/CdlDZDDRJN5g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/7] power: supply: bq24257: skip 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 11 Sep 2020 18:27:23 +0200
Message-Id: <20200911162729.3022-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI, the
struct acpi_device_id becomes unused:

  drivers/power/supply/bq24257_charger.c:1155:36: warning:
    'bq24257_acpi_match' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq24257_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 8e60cb0f3c3f..96cb3290bcaa 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1152,6 +1152,7 @@ static const struct of_device_id bq24257_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, bq24257_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id bq24257_acpi_match[] = {
 	{ "BQ242500", BQ24250 },
 	{ "BQ242510", BQ24251 },
@@ -1159,6 +1160,7 @@ static const struct acpi_device_id bq24257_acpi_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bq24257_acpi_match);
+#endif
 
 static struct i2c_driver bq24257_driver = {
 	.driver = {
-- 
2.17.1

