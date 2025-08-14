Return-Path: <linux-pm+bounces-32369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CDB25D58
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7357FB60EC7
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D6265CAB;
	Thu, 14 Aug 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="mnqWS4xa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7B23AB90;
	Thu, 14 Aug 2025 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156437; cv=none; b=TrGR2Nrp89PKnc7iORGEP1OnD3/WT8J3n0AtaJmrGanX0kF/1Wp7LpV0g8yMYrUMX1SiUgVNb9FmH9AnWutWaMPTptrvncn1lFdAcnQYvRhMznGUPT4F+SRS8NDZLejvQ5G2jcL/MmRjg66VsgK4SKeYWB6WeYTX2fjlp6i3mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156437; c=relaxed/simple;
	bh=5oeepojmBcNgggJVtg0k5VSLGo5qe1E2+hYtB3Eyj34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvc8qkoGAkz7tMeg0Kv1p6xwFRs3mdaz+PSBTzP94uy+aC03DCXzdt/MA1bajICKCPt2KhXzE0r1lW4RH4DBkZCYzX+2gOHiyZrxlLSAiJ3xhS09a9ChIPXmY6DdblwQglsT88k8SHVJVMZj7ZKoUUYWnK9/Fx8LbeI4Qp1tAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=mnqWS4xa; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1755156426;
	bh=nFc7sXSxrxXrn9CbhO94nNCIuL9JOjq3fHd1XbxNFLE=; l=1888;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mnqWS4xacZEDM1se5FXSK9Kmn+vpN4A7vThWQ8fI1iriHcyfmVr/icD5VebX2ML1H
	 tlKDySDTewt714Q3PZ4azsHCqlwR8Nggl0zzQ/zgqPtZAkWAbyhdTAmwKM1C6/Qc6h
	 aaf+8Iza57APnrPeKQaPCMKOJsNbx3rViNgykGz9efTdFjMVlHTvYXsGlymJpCd5bW
	 BsrUD5lR4sMGf5UUwIKTR1oilwksSwSkM4eC+D1DFrDUzJ/YvTbSjyg4KmgZoYVoP/
	 UM2ipNme3nFgD5E3rbjAOydp0AuU22l4ZaTCZKG//NdbpU2KBp+T1oSU4kZauoUdMR
	 rXifSpxtmY5Eg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(817461:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 14 Aug 2025 15:26:52 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 15:26:52 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 14 Aug 2025 15:26:52 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, ChiYuan Huang
	<cy_huang@richtek.com>
Subject: [PATCH RESEND^2] power: supply: rt9467: Add properties for VBUS and IBUS reading
Date: Thu, 14 Aug 2025 15:27:41 +0800
Message-ID: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1755156213.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Since there's the existing ADC function, add properties 'VOLTAGE_NOW'
and 'CURRENT_NOW' to report the current VBUS and IBUS value, respectively.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/power/supply/rt9467-charger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index e9aba9ad393c..998b56e81cd7 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -633,7 +633,9 @@ static int rt9467_psy_set_ieoc(struct rt9467_chg_data *data, int microamp)
 static const enum power_supply_property rt9467_chg_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
@@ -656,6 +658,8 @@ static int rt9467_psy_get_property(struct power_supply *psy,
 		return rt9467_psy_get_status(data, &val->intval);
 	case POWER_SUPPLY_PROP_ONLINE:
 		return regmap_field_read(data->rm_field[F_PWR_RDY], &val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return rt9467_get_adc(data, RT9467_ADC_VBUS_DIV5, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		mutex_lock(&data->attach_lock);
 		if (data->psy_usb_type == POWER_SUPPLY_USB_TYPE_UNKNOWN ||
@@ -665,6 +669,8 @@ static int rt9467_psy_get_property(struct power_supply *psy,
 			val->intval = 1500000;
 		mutex_unlock(&data->attach_lock);
 		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return rt9467_get_adc(data, RT9467_ADC_IBUS, &val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		mutex_lock(&data->ichg_ieoc_lock);
 		val->intval = data->ichg_ua;
-- 
2.34.1


