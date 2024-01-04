Return-Path: <linux-pm+bounces-1860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02FB824843
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E291C22628
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7992728E06;
	Thu,  4 Jan 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMmSXH79"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3324B3C
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704393328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFIkNOXqwcpkDtz3XG8K5bziHIIuRkX3gUg64pqgoDo=;
	b=GMmSXH79CLPusJ80GX0MtTxj9rXinzpSLAR+E45iSbVND4NajxCr/SsIx1Eiq3YCBZ5D1H
	mTj2/dQRJwZLiyro5dntF02BpMjiYPQBNSqxzKWKj7nuHguCZoXW8QPsWmP4ffLZ2MMbtA
	uQDwueq18rHvuA87R2sa+7vrIzoL0bc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-wTh9vSX7PlSycRc3C-jKLw-1; Thu,
 04 Jan 2024 13:35:27 -0500
X-MC-Unique: wTh9vSX7PlSycRc3C-jKLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00BCA280C292;
	Thu,  4 Jan 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5630C3C27;
	Thu,  4 Jan 2024 18:35:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] power: supply: axp288_charger: Lock axp288_chrg_info over axp288_charger_enable_charger()
Date: Thu,  4 Jan 2024 19:35:15 +0100
Message-ID: <20240104183516.312044-2-hdegoede@redhat.com>
In-Reply-To: <20240104183516.312044-1-hdegoede@redhat.com>
References: <20240104183516.312044-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Modify axp288_charger_extcon_evt_worker() to hold the axp288_chrg_info.lock
mutex when calling axp288_charger_enable_charger().

This is a preparation patch for adding charge-inhibit support.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 3c442114d55b..a327933cfd6a 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -633,8 +633,8 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 	/* Offline? Disable charging and bail */
 	if (!(val & PS_STAT_VBUS_VALID)) {
 		dev_dbg(&info->pdev->dev, "USB charger disconnected\n");
-		axp288_charger_enable_charger(info, false);
 		mutex_lock(&info->lock);
+		axp288_charger_enable_charger(info, false);
 		info->valid = false;
 		mutex_unlock(&info->lock);
 		power_supply_changed(info->psy_usb);
@@ -662,13 +662,13 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 
 	/* Set vbus current limit first, then enable charger */
 	ret = axp288_charger_set_vbus_inlmt(info, current_limit);
-	if (ret == 0)
-		axp288_charger_enable_charger(info, true);
-	else
+	if (ret)
 		dev_err(&info->pdev->dev,
 			"error setting current limit (%d)\n", ret);
 
 	mutex_lock(&info->lock);
+	if (ret == 0)
+		axp288_charger_enable_charger(info, true);
 	info->valid = false;
 	mutex_unlock(&info->lock);
 	power_supply_changed(info->psy_usb);
-- 
2.43.0


