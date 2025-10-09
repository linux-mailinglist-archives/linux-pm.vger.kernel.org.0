Return-Path: <linux-pm+bounces-35844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F82BC99D7
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3967B4EE467
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5142E9EC0;
	Thu,  9 Oct 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="M+rGe2+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7A42065;
	Thu,  9 Oct 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021264; cv=none; b=Vtu99ZxqrReDkvmrYlBZSoG8vNo5OcWL1t9mIlIn3BMeMkWeISchf4XOx23bGAVunfFid0RftOTAsQM3F/xBVjdSdGMro3kT+I5SwMXwmWrgO16/ToDAO+SmeuivAlOJWMzAEK51Y3hCIbpVeqabecWgKx+hFZllJrvBvdqCQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021264; c=relaxed/simple;
	bh=VePz2axXoiyDNjNFb+A3qT/xZdiq1xZa3EranYJc10M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eBh6ewQNgDgpJnKRH86GtJHT/+skfjm/eHGqxbW+Q3SM0kAHoaBc2ZxZPg9lkuCZyYxeY+tW8Or2s9sDF24542+7HtV6X6/XdWfr9+kPyjrHIxV9bgGSbUHK1VbSHLXOUmbR0dS5RaVIM5p+FyO5yRZV77ixrxZNfeP99whgdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=M+rGe2+Y; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id B0809C0022;
	Thu,  9 Oct 2025 17:47:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru B0809C0022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1760021259; bh=D2rHk3ymbgFlmulpPybvwHaHqkMrV82P8a6aU9VNJyE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=M+rGe2+Y6/3EDmq6RO9dsgcbcwYqg2KG3Fs7KJEg2I6DxqRnwuV48QDpBUOQvGZZ1
	 mfe23rcVHt9gkloMnmznRLr9fUCno67xHN8b/IQB6xPiR1WiVkYJgDiOEHIQM1NKNL
	 Kd+siKi4Bo8ePecUwZdmHgcR4BqK/rlaSSxksbZySOCMS6H5VIHOPifEzZhOjrUW3G
	 pr8/c9KDuNQZXsJLoCqwt1oIbmwzv9SLqHHKgF+WHYdRJ6amNuhTKY1zh5tSk9xoB9
	 tmgiiq04H7ncVceEBJEFSvhDDaz+AMvnW7NV4cW3SocRpMsSmTEzL1+dRqFSqTZKD0
	 zI+CCMT4gKY3g==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  9 Oct 2025 17:47:39 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 9 Oct 2025 17:47:38 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Sebastian Reichel <sre@kernel.org>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, ChiaEn Wu
	<chiaen_wu@richtek.com>, ChiYuan Huang <cy_huang@richtek.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2 1/1] power: supply: rt9467: Return error on failure in rt9467_set_value_from_ranges()
Date: Thu, 9 Oct 2025 17:47:24 +0300
Message-ID: <20251009144725.562278-1-i.abramov@mt-integration.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 70 0.3.70 b6780c1b68d463c8db5ef264290dd79bdbaaf842, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196955 [Oct 09 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/09 12:30:00 #27896373
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

The return value of rt9467_set_value_from_ranges() when setting AICL VTH is
not checked, even though it may fail.

Log error and return from rt9467_run_aicl() on fail.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
v2: Fix an incorrect Fixes tag.
 drivers/power/supply/rt9467-charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index fe773dd8b404..b4917514bd70 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -588,6 +588,10 @@ static int rt9467_run_aicl(struct rt9467_chg_data *data)
 	aicl_vth = mivr_vth + RT9467_AICLVTH_GAP_uV;
 	ret = rt9467_set_value_from_ranges(data, F_AICL_VTH,
 					   RT9467_RANGE_AICL_VTH, aicl_vth);
+	if (ret) {
+		dev_err(data->dev, "Failed to set AICL VTH\n");
+		return ret;
+	}
 
 	/* Trigger AICL function */
 	ret = regmap_field_write(data->rm_field[F_AICL_MEAS], 1);
-- 
2.39.5


