Return-Path: <linux-pm+bounces-3777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA7850F39
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56741F216A1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86D5235;
	Mon, 12 Feb 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/Kiv5GF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB844FBFC
	for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728421; cv=none; b=p/UVfJrMo1CY5NYIoyUcf1hxRupUqanZ6yQ16aXRFTXOpvd+O1K0PtBpJAaZjKyLW9200D1OJ9idrXCXqbGEIAExEweYLFIPTF+vAH/TAQJqBrI+9z+FEOaa07M6LUEvVhtU9bAWwOcCL8PHHx8AcVwUWfstzMtEyqdgZGdwGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728421; c=relaxed/simple;
	bh=v1Bf09BO5/eogjE+GPtFhZQEgOuybwCpWWW15eOCeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ns/q+rTrEb/E0CIUgj/NuWnV7GOXqou7b6T0kay5hW6DA+1HCVW/9msIpSbKojNB1XCCxuuAJCD65f1jOysULpyEX4FZc9wE+LlvVHgchiupQuwegXla9C5nMJct2c3skh2sPwvcriTNmRtaI7vJJzV7AxdGz8/Q9kgktY/9X4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/Kiv5GF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707728418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zNWnZWLepCf5/bKiHycs304BQ2YBWV2Wh36u5RzJTeQ=;
	b=U/Kiv5GFYZ2TnJu2Fy0I9OyQZR+d7cnbT0mUcYHdcZkIcXqTW/Ee8e0LF8cIDEL3JGX3oA
	gPL0AtdHsF+YSP2HMtZ6QNAaRKnMVFDgxJs5e2HcBroowkc0Ix5VINpG4gC99V48i4iM7c
	01MfubSyejCIBlw/0GewFGqyzbxaFGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-xSlsM-SKMFKDzNp2s3G1vw-1; Mon, 12 Feb 2024 04:00:16 -0500
X-MC-Unique: xSlsM-SKMFKDzNp2s3G1vw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6836B868A10;
	Mon, 12 Feb 2024 09:00:16 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABFCF530390;
	Mon, 12 Feb 2024 09:00:15 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: axp288_fuel_gauge: Add STCK1A* Intel Compute Sticks to the deny-list
Date: Mon, 12 Feb 2024 10:00:14 +0100
Message-ID: <20240212090014.13719-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Besides the existing STK1A* Cherry Trail based Intel Compute Sticks
already on the deny-list, Intel also made Bay Trail based Compute Sticks
which have a product name of STCK1A* and wich also report a non
existing battery with a random battery charge.

Instead of adding 3 new deny-list entries for the 3 variants of the STCK1A*
sticks consolidate the 2 Cherry Trail STK1AW32SC and STK1A32SC variants
into a single entry with a partial match for STK1A* and add a single new
STCK1A* match for the Bay Trail variants.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 3be6f3b10ea4..967a26096485 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -550,18 +550,20 @@ static const struct dmi_system_id axp288_quirks[] = {
 		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
-		/* Intel Cherry Trail Compute Stick, Windows version */
+		/* Intel Bay Trail Compute Stick */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
+			/* Partial match for STCK1A32WFC STCK1A32FC, STCK1A8LFC variants */
+			DMI_MATCH(DMI_PRODUCT_NAME, "STCK1A"),
 		},
 		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
-		/* Intel Cherry Trail Compute Stick, version without an OS */
+		/* Intel Cherry Trail Compute Stick */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
+			/* Partial match for STK1AW32SC and STK1A32SC variants */
+			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A"),
 		},
 		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
-- 
2.43.0


