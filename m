Return-Path: <linux-pm+bounces-13614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D845196C771
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C58B22262
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B61E6DDF;
	Wed,  4 Sep 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lhQH1abU"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE51E6DC5;
	Wed,  4 Sep 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477954; cv=none; b=VVv5/TO2J2hlsOT06UVwrlz8ITvG8VOO0o7UiKMUzSKKHxw2yHloB6HR5hNNMWCWRRJUjNdoL2HVw9Jey21G7Bqu+ApU1dN3VL5SmwkqIwOLDho6g2YvjTujP8aQLIfBikRUO0nq7dFPiz4xM5tiiaWlwJm7PGhLurDTQKSqiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477954; c=relaxed/simple;
	bh=1qFuHiGvcngQBCI1NgBkTkcdy4K1lH92ip/hhc7BDJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VStfw6+Mr4ySfkn7rumvAy9q4gGffhcPmKorbd9HHawve3xr50u94IbWBIf8Hy3GHP+hrMAhPDejyxUzbQuhLQsj+7+AsoQz7Mgb0n4QC/3+9RBt2SzbejSuSSn7Qt5lQaBEh5YdgOuK2Vb5Z/2W1QHjb+ZL7jLGHbnPNuGMbSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lhQH1abU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477950;
	bh=1qFuHiGvcngQBCI1NgBkTkcdy4K1lH92ip/hhc7BDJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lhQH1abUdyfvDjezyT0yZh1wp3Qii3m7tOMm6L3LBG8bVOjQaE0V9hhKTY7Insmv/
	 UDgIKSPoQdfntekVHfuPoW532wBehdV3ixthYMfEtoRn+1kG3D/Ph6BMI8BGkluTgt
	 K8EmH+ciytHA8W6pRDrarAfC3NyjrRVxZ5DzwwJA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:37 +0200
Subject: [PATCH RFC v3 4/9] power: supply: sysfs: register battery
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-4-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=1586;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1qFuHiGvcngQBCI1NgBkTkcdy4K1lH92ip/hhc7BDJc=;
 b=wmtOZoyYq5meEWGN7VOBId6j+M3aTnjFqezy4K23vtTrY3rCZgyBeBgfRzYPknac7R9B6p+Jp
 HP7krbONEGKDtsbVnBRWObjPBK7Wa2yPS8wT2pWHIQ9ZEfyw2tc9vC6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of only registering properties from the psy_desc itself,
also register the ones from the battery.
Use power_supply_has_property() for this test which makes the logic also
easier to read.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 3e63d165b2f7..4ab08386bcb7 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -367,7 +367,6 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = dev_get_drvdata(dev);
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
-	int i;
 
 	if (!power_supply_attrs[attrno].prop_name)
 		return 0;
@@ -375,19 +374,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	if (attrno == POWER_SUPPLY_PROP_TYPE)
 		return mode;
 
-	for (i = 0; i < psy->desc->num_properties; i++) {
-		int property = psy->desc->properties[i];
-
-		if (property == attrno) {
-			if (power_supply_property_is_writeable(psy, property) > 0)
-				mode |= S_IWUSR;
-
-			return mode;
-		}
-	}
-
-	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
+	if (power_supply_has_property(psy, attrno)) {
+		if (power_supply_property_is_writeable(psy, attrno) > 0)
+			mode |= S_IWUSR;
 		return mode;
+	}
 
 	return 0;
 }

-- 
2.46.0


