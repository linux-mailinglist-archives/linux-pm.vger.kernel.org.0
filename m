Return-Path: <linux-pm+bounces-19513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F659F7937
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C2016AF94
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B61FC7F9;
	Thu, 19 Dec 2024 10:08:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8D433A4
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602904; cv=none; b=X9hy72+5Ebz1ivyEUsbG+n4ZrpcUX1c13nCV2CGJzuQNux7fswPtQlzLxszTLgWF3lOoolSbQOQ5BmIUFlluNhcegWpROUehy7s7KqxLCdO3wBBe/wJ2ASP/aWEQasfz1NijctupeCHrf/WtE00+NihQnADeZVV1aMbnJniL7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602904; c=relaxed/simple;
	bh=extSpE2n5GY6wgZI3kt3im6Mm4avAnO6XH8R8l7YCVI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eBCi0sTSftpNnOoR02yUmNF5HogMdhubxOxqXXYV1UFD0XZJ7brJBHI6OCmGMIJXKfQQf/AeaNsllD5vo+eolQ88DW+v0ci2Kki+e8jtFzZOibfz2QdsaHxFiAH9FeoNAxG8GTjjRflULtsr5seEbEePvagq7+dqj1aTTh0Ig6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4YDQmT27FSzYl4J0;
	Thu, 19 Dec 2024 17:51:21 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Dec
 2024 17:51:35 +0800
Received: from a004.hihonor.com (10.68.27.131) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Dec
 2024 17:51:34 +0800
Received: from a004.hihonor.com ([fe80::30eb:6b4e:cee9:37b4]) by
 a004.hihonor.com ([fe80::30eb:6b4e:cee9:37b4%4]) with mapi id 15.02.1544.011;
 Thu, 19 Dec 2024 17:51:34 +0800
From: shichunyong <shichunyong@honor.com>
To: "sre@kernel.org" <sre@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, yuanzhen 00013066
	<richard.yuan@honor.com>, yangyunmeng 00013317 <yangyunmeng@honor.com>,
	gongxi 00013624 <gongxi4@honor.com>, yuxuesong 00013800
	<xuesong.yu@honor.com>
Subject: [PATCH] power: supply: sysfs: Add manufacturing_date,first_usage_date
Thread-Topic: [PATCH] power: supply: sysfs: Add
 manufacturing_date,first_usage_date
Thread-Index: AdtQOKQB2mHP1I+8TI2PYcb16gLeKA==
Date: Thu, 19 Dec 2024 09:51:34 +0000
Message-ID: <f9250641f7674ee59276539253363d4a@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

manufacturing_date/first_usage_date/state_of_health are the battery data
required by EU regulations that are accessible for end-users.

manufacturing_date is the date of manufacturing of the battery.
first_usage_date is the date of first use of the battery
after the set-up of the device by the first user.
Both dates are the seconds since the epoch (1970-01-01 UTC).
state_of_health(SoH) is a figure of merit of the condition of a battery,
compared to its ideal conditions. The unit of SoH is percent
(100% =3D the battery's conditions match the battery's specifications).

Signed-off-by: ShiChunyong <shichunyong@honor.com>
---
 drivers/power/supply/power_supply_sysfs.c | 3 +++
 include/linux/power_supply.h              | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supp=
ly/power_supply_sysfs.c
index 571de43fcca9..0550073224f2 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -217,6 +217,9 @@ static struct power_supply_attr power_supply_attrs[] __=
ro_after_init =3D {
 	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
 	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
+	POWER_SUPPLY_ATTR(MANUFACTURING_DATE),
+	POWER_SUPPLY_ATTR(FIRST_USAGE_DATE),
+	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b98106e1a90f..c8d8a8bfbf9f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -170,6 +170,9 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
+	POWER_SUPPLY_PROP_MANUFACTURING_DATE,
+	POWER_SUPPLY_PROP_FIRST_USAGE_DATE,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
--=20
2.17.1


