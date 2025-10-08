Return-Path: <linux-pm+bounces-35816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B6BC53CF
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0B694F86DA
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B2285C83;
	Wed,  8 Oct 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="HeAdt0qC"
X-Original-To: linux-pm@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2B285CAD;
	Wed,  8 Oct 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930633; cv=none; b=fFOYZgiT1qP73o/D58k7m+K+DN+6By6BGTiKgCsmLFBdShpZvWTXffebKYp60xp1PQqaM8q3iwO8OZDV48AJIkHVaHgy2KtLPBYqR7gBRUC88n/Ogyvqd435LY7sqqkMmi3D6Ebny/fdUJdCUIkD0JnvwoKfopoK8AIoeCrFcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930633; c=relaxed/simple;
	bh=hlVYUy3P6BSlf4FEPSlIuLygUtVLUMPzXgCP+Lr8i4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MIAezdax5oCcROdFxnrUWgA8h+CFZvBJnpcCGVzkCNeebFSAwzI7Ze9BCMTJq9VgggxA0XVKfI2XEIo/asc+IagoP2Xb+rlIRuasGwHymNF8s4IHYlfHHxsS+CuJEFYtk5IuN3IJu/+ppgg1NxMlAEWYvOfegAI179sohObyoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=HeAdt0qC; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id B6FBDC0018;
	Wed,  8 Oct 2025 16:37:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru B6FBDC0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1759930626; bh=8NrFbemJMQpyQnN2QJdvsYbMfmpY6k0fZOgMiygtL+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HeAdt0qCdRrPlAi9IouSBhAqNFVPUMWUo50o5RqbNoo7NRF4cGLIeBmXVeCbsFlpW
	 yqbd8MMXIO+w70/Xt6bZWAEvYiDEjxo1qG4PS7LFKHBx6Mm8hpO4tZnnAzdqPesvuz
	 SjEzRG6H5ctZNIkCvfuwWEM6cJAg8QuT7itiCcit1ZD+tegsfV2VOnfMq6NsALsIHM
	 gEr2pHr5tM4h+8656ni4VXKal7sdS6/NNP717SKFp+dBII+0KJSFfdyAn6QKe/UVca
	 pUTBVNSI5XmV8Y2rkJ0HY+3wgTF1Bz0MyNEJZHLF1D3sMHqtE1XjwOzACxX3/OcPhX
	 se7thMgpC817Q==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 16:37:06 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 16:37:05 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Iskren Chernev <me@iskren.info>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Krzysztof Kozlowski
	<krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Matheus
 Castello <matheus@castello.eng.br>, Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 1/1] power: supply: max17040: Check iio_read_channel_processed() return code
Date: Wed, 8 Oct 2025 16:36:47 +0300
Message-ID: <20251008133648.559286-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 69 0.3.69 3c9ee7b2dda8a12f0d3dc9d3a59fa717913bd018, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1, {Macro_SMTPFROM_NOT_MATCHES_SMTP}, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196902 [Oct 08 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/08 08:37:00 #27892411
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Since iio_read_channel_processed() may fail, return its exit code on error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 814755c48f8b ("power: max17040: get thermal data from adc if available")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/power/supply/max17040_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index c1640bc6accd..48453508688a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -388,6 +388,7 @@ static int max17040_get_property(struct power_supply *psy,
 			    union power_supply_propval *val)
 {
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+	int ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -410,7 +411,10 @@ static int max17040_get_property(struct power_supply *psy,
 		if (!chip->channel_temp)
 			return -ENODATA;
 
-		iio_read_channel_processed(chip->channel_temp, &val->intval);
+		ret = iio_read_channel_processed(chip->channel_temp, &val->intval);
+		if (ret)
+			return ret;
+
 		val->intval /= 100; /* Convert from milli- to deci-degree */
 
 		break;
-- 
2.39.5


