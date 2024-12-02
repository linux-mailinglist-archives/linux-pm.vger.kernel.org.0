Return-Path: <linux-pm+bounces-18387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F889E0D94
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B956A1655B0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39941DF276;
	Mon,  2 Dec 2024 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Th3oikmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C521DEFE5;
	Mon,  2 Dec 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174126; cv=none; b=LmQ+9rFKgEyhQIyuE3sIvet7cgj5FcLT8Fhb0BVHjFSU44j7IUCLrPQNmXJZvYFjJDntKR73J1ft7GM4VIGIfiMZP+P6TKjuvic1LkXaguQxo7qZHzUurZo2873r4CBfr1IIinmXCwFax566+0a0N6bJ/QKomK6BHmPA79TnvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174126; c=relaxed/simple;
	bh=mNc45UUIBnY2zqKfppObvs8Xa0q0wW+mBTnTcKU/KiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rz+tyCRq1AQrm6bFaYqfDlGNCo2g8blxuH3YbFZUSTfmE47wt1Clh9LPUcJcFz80Bys4MLxG+v9/d5jDcA77mnjc2DlpdvIDuzWaKQZuzhetu+WydS1oeGUh0bFcy2gmfe2SQEGcqI5nINIX4czc2hxMrEv7y5uO/cBZVp4Mb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Th3oikmN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B2LFLMh1522480
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 15:15:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733174121;
	bh=dIGwGEg/qk6oFqWm5tCTp6Dcc9dKtv2cgkQO45hArK8=;
	h=From:To:CC:Subject:Date;
	b=Th3oikmN59pAx8RrzrJIJSSZ5bx5y+0p9rxcGzftwTOm6UvxVJF67hgkF8wwpvD9P
	 61Mn9NIYwpXi3q5umw9Vzi3olvZ7v7Yn8olWbl2l7Af4fDRZWOHvIdI1+OrATHxB4E
	 Tx87AstmXhYl2uaPByDFZXeRpWyC0bitAMr1TQ+8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B2LFKMK017202
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 15:15:20 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 15:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 15:15:20 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFKgo099805;
	Mon, 2 Dec 2024 15:15:20 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/5] power: supply: ds2782: Switch to simpler IDA interface
Date: Mon, 2 Dec 2024 15:15:15 -0600
Message-ID: <20241202211519.199635-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

We don't need to specify any ranges when allocating IDs so we can switch
to ida_alloc() and ida_free() instead of idr_*.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/ds2782_battery.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 85aa9c465aa4e..10428d781c18b 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -63,8 +63,7 @@ struct ds278x_info {
 	int			status;		/* State Of Charge */
 };
 
-static DEFINE_IDR(battery_id);
-static DEFINE_MUTEX(battery_lock);
+static DEFINE_IDA(battery_id);
 
 static inline int ds278x_read_reg(struct ds278x_info *info, int reg, u8 *val)
 {
@@ -322,9 +321,7 @@ static void ds278x_battery_remove(struct i2c_client *client)
 	kfree(info->battery_desc.name);
 	kfree(info);
 
-	mutex_lock(&battery_lock);
-	idr_remove(&battery_id, id);
-	mutex_unlock(&battery_lock);
+	ida_free(&battery_id, id);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -387,12 +384,9 @@ static int ds278x_battery_probe(struct i2c_client *client)
 	}
 
 	/* Get an ID for this battery */
-	mutex_lock(&battery_lock);
-	ret = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
-	mutex_unlock(&battery_lock);
-	if (ret < 0)
-		goto fail_id;
-	num = ret;
+	num = ida_alloc(&battery_id, GFP_KERNEL);
+	if (num < 0)
+		return num;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
@@ -439,10 +433,7 @@ static int ds278x_battery_probe(struct i2c_client *client)
 fail_name:
 	kfree(info);
 fail_info:
-	mutex_lock(&battery_lock);
-	idr_remove(&battery_id, num);
-	mutex_unlock(&battery_lock);
-fail_id:
+	ida_free(&battery_id, num);
 	return ret;
 }
 
-- 
2.39.2


