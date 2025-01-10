Return-Path: <linux-pm+bounces-20195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22795A08F5D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1846F3AA3CB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FE20C02F;
	Fri, 10 Jan 2025 11:27:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE720C49F
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508451; cv=none; b=LmPF6MsAccuIyTGN5loMYHI1BFwMgJl36sslEuLiHAM8UqWTY+AXcMTLOsr18stE8GtDyo3UGAF1Wx+jCln7O0qT8rBuXp+39giZdqth2ixvTpQ8aK+7EzdvZksjqdWahpMO9dWn5Z8CuRNYeO06ucSPH34huDe2armDtGIG0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508451; c=relaxed/simple;
	bh=AuTHtZpdzWZFaWJ8xRjgtg2IfDRiTvj6Ov4rDR9gdow=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JLagVP6ZLcdmLXtYUOHcExOn9IasMcJIeMsQp4pvUkjY0QBOigqsWynYBa+zJiQyKz4THg1AHtPg2V5whtpzcMQ5o1wJOlKbVOm8hl64yc2QSyIQTsnwQXy5ecgEi2XR8QwwikuoTIdREvtqlHpIREx0eLHSdNTt1RLk2w8vzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4YTzW14hHTzYlDhm;
	Fri, 10 Jan 2025 19:11:41 +0800 (CST)
Received: from a006.hihonor.com (10.68.23.242) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Jan
 2025 19:12:09 +0800
Received: from a004.hihonor.com (10.68.27.131) by a006.hihonor.com
 (10.68.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Jan
 2025 19:12:09 +0800
Received: from a004.hihonor.com ([fe80::d0f4:9864:20bc:c407]) by
 a004.hihonor.com ([fe80::d0f4:9864:20bc:c407%4]) with mapi id 15.02.1544.011;
 Fri, 10 Jan 2025 19:12:09 +0800
From: shichunyong <shichunyong@honor.com>
To: "sre@kernel.org" <sre@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, yuanzhen 00013066
	<richard.yuan@honor.com>, yangyunmeng 00013317 <yangyunmeng@honor.com>,
	gongxi 00013624 <gongxi4@honor.com>, yuxuesong 00013800
	<xuesong.yu@honor.com>, shichunyong <shichunyong@honor.com>
Subject: RE: [PATCH] power: supply: sysfs: Add
 manufacturing_date,first_usage_date
Thread-Topic: [PATCH] power: supply: sysfs: Add
 manufacturing_date,first_usage_date
Thread-Index: AdtjT/+X2mHP1I+8TI2PYcb16gLeKA==
Date: Fri, 10 Jan 2025 11:12:09 +0000
Message-ID: <ed82ec55afed40448c70831f1991f6c1@honor.com>
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

Please help to review, thanks.

-----Original Message-----
From: shichunyong 00013399=20
Sent: 2024-12-19 17:52
To: 'sre@kernel.org' <sre@kernel.org>
Cc: 'linux-pm@vger.kernel.org' <linux-pm@vger.kernel.org>; yuanzhen 0001306=
6 <richard.yuan@honor.com>; yangyunmeng 00013317 <yangyunmeng@honor.com>; g=
ongxi 00013624 <gongxi4@honor.com>; yuxuesong 00013800 <xuesong.yu@honor.co=
m>
Subject: [PATCH] power: supply: sysfs: Add manufacturing_date,first_usage_d=
ate

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


