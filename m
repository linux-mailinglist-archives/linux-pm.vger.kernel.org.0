Return-Path: <linux-pm+bounces-11217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACAE9342E4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 22:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88451F21D6F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14CC1822E8;
	Wed, 17 Jul 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIslOM8K"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA91CF90
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246628; cv=none; b=BYHkqxM3YpoH3GiDvwSMaSorf+uTpBoslRqdmds3Xqqypc2rm2uIlFPIRXiXHIanymjYLIY68vLWlBli8JsK2fdCrN4VyC53NEynaOdKjbSHnTeFAODltImob9agvOLFIJyFueGdit52vHFjf9Q3iXidfmpNMMyX8hTX1Zbn26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246628; c=relaxed/simple;
	bh=KGrfaJ5s+0k6XkuiXVwFQK/U93ROKT3s3z3P/ZDCxL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2lo0o9UUtVwfYEXkZBS/m7YKazkozdzU60enPSzCZYhHMVaoExrsVimOdtv0kLTwFFQWZ2fVx7XhU6vYkxr7UbsR97DQvrJmvlhoiiLnFdau3J5bG+hXwHb1iiEQc3LOGcu9ZBX+mWaUG1p5ORBzeffQhVloJy6O/iRDM/wV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIslOM8K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721246626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rW0UG9Yof46y51ZacZBWXQDytJijvjwyuV4pHxrgHQ=;
	b=UIslOM8K3+QjiSY7Nmnc2Aj3ahHSCmMt7MFrcwx0+fRN58newjhkl+6snqF6tm49oWe3BV
	npGqOGrX2R5Q/2HKPYOGaxRa4kzFqDAA9YLWQN20TsIpTmJMZLp3prg/WcGHPS272LUsu9
	748hRtsm6mPlUCj4e1mlQzaVu8TLcZQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-4Txr62dIN263a1cnIpYHIQ-1; Wed,
 17 Jul 2024 16:03:44 -0400
X-MC-Unique: 4Txr62dIN263a1cnIpYHIQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3571A1955D4C;
	Wed, 17 Jul 2024 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A613419560B2;
	Wed, 17 Jul 2024 20:03:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] power: supply: axp288_charger: Round constant_charge_voltage writes down
Date: Wed, 17 Jul 2024 22:03:33 +0200
Message-ID: <20240717200333.56669-2-hdegoede@redhat.com>
In-Reply-To: <20240717200333.56669-1-hdegoede@redhat.com>
References: <20240717200333.56669-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Round constant_charge_voltage writes down to the first supported lower
value, rather then rounding them up to the first supported higher value.

This fixes e.g. writing 4250000 resulting in a value of 4350000 which
might be dangerous, instead writing 4250000 will now result in a safe
4200000 value.

Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index aea17289a178..ac05942e4e6a 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -178,18 +178,18 @@ static inline int axp288_charger_set_cv(struct axp288_chrg_info *info, int cv)
 	u8 reg_val;
 	int ret;
 
-	if (cv <= CV_4100MV) {
-		reg_val = CHRG_CCCV_CV_4100MV;
-		cv = CV_4100MV;
-	} else if (cv <= CV_4150MV) {
-		reg_val = CHRG_CCCV_CV_4150MV;
-		cv = CV_4150MV;
-	} else if (cv <= CV_4200MV) {
-		reg_val = CHRG_CCCV_CV_4200MV;
-		cv = CV_4200MV;
-	} else {
+	if (cv >= CV_4350MV) {
 		reg_val = CHRG_CCCV_CV_4350MV;
 		cv = CV_4350MV;
+	} else if (cv >= CV_4200MV) {
+		reg_val = CHRG_CCCV_CV_4200MV;
+		cv = CV_4200MV;
+	} else if (cv >= CV_4150MV) {
+		reg_val = CHRG_CCCV_CV_4150MV;
+		cv = CV_4150MV;
+	} else {
+		reg_val = CHRG_CCCV_CV_4100MV;
+		cv = CV_4100MV;
 	}
 
 	reg_val = reg_val << CHRG_CCCV_CV_BIT_POS;
-- 
2.45.2


