Return-Path: <linux-pm+bounces-14654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22D79855B2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F5B20F74
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1109D15B0FF;
	Wed, 25 Sep 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="oWlpPDJ1";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="lXNmIS/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528C158D8D;
	Wed, 25 Sep 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253678; cv=none; b=VCS3LtUkSJw1+V3XsZngiiEVetmVJubmbmY0WdulVjHs7Y5AL5RkXmwdYiR5gRgzZKhj83Ypt7Zl0WL/IDQml5H6fmcyrXUkNAJVPKcMMzxcrv+d7G1UBZl4U+kY9bDWkogZ9ZmWkUvI4RABMp6aifXDiIzv02/qibi0PvmsR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253678; c=relaxed/simple;
	bh=hG2GUbm3yiSgMz+SgpzUWv5SUgrpVENjU8/tkhb8kY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP1eBcw7afFhBrOeUXNmMYjUM3tyltdcyqokeIhCqjJlDW306ovbO42Cu9ewRcjeBt9arK1zNWkZ9wjvC7tcJ+zD/WhH5UvgVgqCwe23SLdlnDBcgKzdVXB9EqJZo8THEdj2+2UmVs0KOrtFBR0e9Fc27L6zhUxR/9TwXRyWEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=oWlpPDJ1; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=lXNmIS/b; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1727253673;
	bh=77wqm6qbVAW23ObIDiogsupfm9Sxgz3rpNFpYbVnXws=; l=2463;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oWlpPDJ1PdAFFOvaDnZS3r2C3k6TPsDRdcpazlWbv5g29kH/tX+4RkYOn1TWj2I9+
	 HPeBSfpOaPq7i2gUgq5dLNsPxXDTdhNf86dWR+2Skv6Y51Ghk4vYlevUpyuYP4ghro
	 RqTq7f93NwHb9l8k13ZjcmArQqjozYFjidlzETcQjKnpVUB9aKpGyEh2JTyqFiAc2S
	 jWH5QzpYfkWt6WGldw0zZ5KmeMuID6mfjogQ5y4YER1a/hsIcZ6e0iWjyGwURVvNYn
	 CwrzaQX/9MjLLcr3npbo9ZoeV6IhNESdPtlw7JBkKiHwdEbsMaCvm7d0pYrczB1IDd
	 RZW4+jOlfLuGw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3190219:0:AUTH_RELAY)
	(envelope-from <prvs=1995EE0AA0=cy_huang@richtek.com>); Wed, 25 Sep 2024 16:41:12 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1727253672;
	bh=77wqm6qbVAW23ObIDiogsupfm9Sxgz3rpNFpYbVnXws=; l=2463;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lXNmIS/b9Hm1rBn0F6XauWsIlWCbyCdSULK/An9tdWe8WWmwgQeHZAohP3hNZUs61
	 JLKaxarZdIVBXPVtrYYlg/A+wJo46uWqiRX+jJ3XZYI2l2oX863nbZ3SCtAUjRVNFR
	 6ZbvnB5RP3MIv8R2AdufoHRqqZY80VMVxfl+h8Un9JzCakMhn9NqabUPp/a2H8nIGe
	 wYchmtDHffHEcGss0ivw0YhGVrtERKfOSx9T8k5ww9O1sFW2CJ1u59uvQybxtGW8Kl
	 xaMQuEQVs2eqjmojmYShbI4tmcSxWzwX28DgEcilVAGz5vTuROdx0cxARtwYjh5ONe
	 vCC0qYaVVOrZA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1322962:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 25 Sep 2024 16:33:17 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Sep
 2024 16:33:16 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 25 Sep 2024 16:33:16 +0800
From: <cy_huang@richtek.com>
To: 'Lucas Tsai ' <lucas_tsai@richtek.com>, Sebastian Reichel <sre@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] power: supply: rt9471: Use IC status regfield to report real charger status
Date: Wed, 25 Sep 2024 16:32:59 +0800
Message-ID: <67ba92bb4a9c51d9cafadab30b788a3a2c3048e1.1727252762.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1727252762.git.cy_huang@richtek.com>
References: <cover.1727252762.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Use IC status regfield to rewrite the 'get_staus' function. The original
one cannot cover some special scenario like as charger OTP or JEITA case.

Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger driver")
Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/power/supply/rt9471.c | 48 ++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index 730b252b4900..67b86ac91a21 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -139,6 +139,19 @@ enum {
 	RT9471_PORTSTAT_DCP,
 };
 
+enum {
+	RT9471_ICSTAT_SLEEP = 0,
+	RT9471_ICSTAT_VBUSRDY,
+	RT9471_ICSTAT_TRICKLECHG,
+	RT9471_ICSTAT_PRECHG,
+	RT9471_ICSTAT_FASTCHG,
+	RT9471_ICSTAT_IEOC,
+	RT9471_ICSTAT_BGCHG,
+	RT9471_ICSTAT_CHGDONE,
+	RT9471_ICSTAT_CHGFAULT,
+	RT9471_ICSTAT_OTG = 15,
+};
+
 struct rt9471_chip {
 	struct device *dev;
 	struct regmap *regmap;
@@ -255,31 +268,32 @@ static int rt9471_get_ieoc(struct rt9471_chip *chip, int *microamp)
 
 static int rt9471_get_status(struct rt9471_chip *chip, int *status)
 {
-	unsigned int chg_ready, chg_done, fault_stat;
+	unsigned int ic_stat;
 	int ret;
 
-	ret = regmap_field_read(chip->rm_fields[F_ST_CHG_RDY], &chg_ready);
-	if (ret)
-		return ret;
-
-	ret = regmap_field_read(chip->rm_fields[F_ST_CHG_DONE], &chg_done);
+	ret = regmap_field_read(chip->rm_fields[F_IC_STAT], &ic_stat);
 	if (ret)
 		return ret;
 
-	ret = regmap_read(chip->regmap, RT9471_REG_STAT1, &fault_stat);
-	if (ret)
-		return ret;
-
-	fault_stat &= RT9471_CHGFAULT_MASK;
-
-	if (chg_ready && chg_done)
-		*status = POWER_SUPPLY_STATUS_FULL;
-	else if (chg_ready && fault_stat)
+	switch (ic_stat) {
+	case RT9471_ICSTAT_VBUSRDY:
+	case RT9471_ICSTAT_CHGFAULT:
 		*status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	else if (chg_ready && !fault_stat)
+		break;
+	case RT9471_ICSTAT_TRICKLECHG ... RT9471_ICSTAT_BGCHG:
 		*status = POWER_SUPPLY_STATUS_CHARGING;
-	else
+		break;
+	case RT9471_ICSTAT_CHGDONE:
+		*status = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case RT9471_ICSTAT_SLEEP:
+	case RT9471_ICSTAT_OTG:
 		*status = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		*status = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	}
 
 	return 0;
 }
-- 
2.34.1


