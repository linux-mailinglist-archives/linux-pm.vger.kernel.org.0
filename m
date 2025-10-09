Return-Path: <linux-pm+bounces-35845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C3BC9B00
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDDA3AD210
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9C2EBBAD;
	Thu,  9 Oct 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="Ik+wlWKL"
X-Original-To: linux-pm@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.mt-integration.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762F2E7F11;
	Thu,  9 Oct 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022330; cv=none; b=k3fxPx4y5qFgv6GNdhlbHkfiRm7j7gnZemGPacnkLU9SnfmIhwXWL5f1tzT5R9BUnR35WKqNjZB/U2tkUQVX+tNrtNy0KuZgmv/Sj4AJGHh2yFj3GkSyEC6IQyVvLlx2Tjk/YJCk0FfmVaXCHgpmtp7eClRxD/CdM+V4VDI2P5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022330; c=relaxed/simple;
	bh=DGaxTqHCEpRmASpdJegBw8szazWyfuFr/h0fm5ceho4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWWsXfGAt/fpe4w7E3vago6qCIkyRrLE61LR32D9C984/s8SbjW4Ty5jQQ7WHhaONDLsc236B+RRvG9N2zHIyJOpoKEyR1r2NIQDV00CGw8HNE/I8pow6T5uGkAGoYyO/1mTy+B5AwAdYBz1AMEroIehZYJAcKzKf4RYYhzUszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=Ik+wlWKL; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id BD0D41E003A;
	Thu,  9 Oct 2025 17:55:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru BD0D41E003A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1760021730; bh=wReObIcZCXOxdSeUBytQEFOKlR754QX/WDublcqrqYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Ik+wlWKL9U9g/OodfFkiUKRXDB6CgJ6n2f0mRvKQ8xUxjfa5VDw1gzapzKSU0eYUQ
	 RWD/CV3H8Id9MNcOMcX57efv15O4ZEvp29+Wyrcq51OmeckwlabTt/nbRacUfdfLRa
	 iQUWBeSz2uItSHq/SYb6F1hZ5DDrKO2e3urmGEA4CvY6x6yO1gmgqfjVenqdCEjoP2
	 +R7OK6kIHe2ez1xw4j2JKivFq9oLQQtZpMqPDViLZ8QgQFT4u59X3a09z1VdFDdw4p
	 ptTi9SqnMHaqaNZ1/egadryD1V52GINJpRPtLxdQQawNI3UirmsF+/+a7V+KSrcufO
	 xj6vjSFEZyReQ==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Thu,  9 Oct 2025 17:55:30 +0300 (MSK)
Received: from deb16-01-masimov-t-build.mti-lab.com (172.25.20.25) by
 mmail-p-exch02.mt.ru (81.200.124.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 9 Oct 2025 17:55:29 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Sebastian Reichel <sre@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, ChiaEn Wu <chiaen_wu@richtek.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@mt-integration.ru>
Subject: [PATCH] power: supply: rt9467: Prevent using uninitialized local variable in rt9467_set_value_from_ranges()
Date: Thu, 9 Oct 2025 17:53:08 +0300
Message-ID: <20251009145308.1830893-1-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch01.mt.ru (81.200.124.61) To
 mmail-p-exch02.mt.ru (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 70 0.3.70 b6780c1b68d463c8db5ef264290dd79bdbaaf842, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ksmg02.maxima.ru:7.1.1;81.200.124.62:7.1.2;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196957 [Oct 09 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/09 12:30:00 #27896373
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

There is a typo in rt9467_set_value_from_ranges() that can cause leaving local
variable sel with an undefined value which is then used in regmap_field_write().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
 drivers/power/supply/rt9467-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index fe773dd8b404..ee311c0af7f7 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -376,7 +376,7 @@ static int rt9467_set_value_from_ranges(struct rt9467_chg_data *data,
 	if (rsel == RT9467_RANGE_VMIVR) {
 		ret = linear_range_get_selector_high(range, value, &sel, &found);
 		if (ret)
-			value = range->max_sel;
+			sel = range->max_sel;
 	} else {
 		linear_range_get_selector_within(range, value, &sel);
 	}
--
2.39.2


