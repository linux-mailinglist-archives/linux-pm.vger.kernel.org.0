Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A079441CB98
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhI2SRR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 14:17:17 -0400
Received: from h04mx15.reliablemail.org ([185.76.67.208]:28607 "EHLO
        h04mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344347AbhI2SRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 14:17:17 -0400
X-Halon-Out: 3c7786dd-2151-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KIjLywngr8bdrLt5titQeuOYT+bdxPvm9Rv5zh+DvWM=; b=jgEVo5ipGp1OGZM2sHglnTJSFe
        M/Gu77biam8hVIvCykin9gq3cokCAJYrGfxQQE62YmoJLcHVtfDFT0RBFJhzvgZd0MIuRID/TYrbC
        OHIa+/16ogy5FwZeZ4h+00vmu12mfzqzC3SgTCFSJ2+nqiFzzHFoBEAB7CjePC68B+nOW51XmN46w
        lzQd3ANbnSqcDt4ecG341KbggNF6CYoR/ork4/D4D58EmUeGJ83iN1KJAlJjKVmOyCeQsImaq0AE4
        ffNeSLC4nIcOsDhFSE4SeIL4U3Rj5EqiMxGJ61bZ5WJPu20wDm6iNqT0JAtb2CH0lsiMQwQeyI+t1
        PmKu73AQ==;
From:   Henrik Grimler <henrik@grimler.se>
To:     sre@kernel.org, m.szyprowski@samsung.com,
        krzysztof.kozlowski@canonical.com, sebastian.krzyszkowiak@puri.sm,
        hdegoede@redhat.com, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 2/2] power: supply: max17042_battery: fix typo in MAX17042_IAvg_empty
Date:   Wed, 29 Sep 2021 20:14:18 +0200
Message-Id: <20210929181418.4221-2-henrik@grimler.se>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929181418.4221-1-henrik@grimler.se>
References: <20210929181418.4221-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Datasheet gives the name IAvg_empty, not LAvg_empty.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 include/linux/power/max17042_battery.h  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 5809ba997093..32f331480487 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -786,7 +786,7 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) ||
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)) {
-		max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
+		max17042_override_por(map, MAX17042_IAvg_empty, config->iavg_empty);
 		max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
 		max17042_override_por(map, MAX17042_TempLim, config->temp_lim);
 		max17042_override_por(map, MAX17042_FCTC, config->fctc);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index dd24756a8af7..c417abd2ab70 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -78,7 +78,7 @@ enum max17042_register {
 	MAX17042_T_empty	= 0x34,
 
 	MAX17042_FullCAP0       = 0x35,
-	MAX17042_LAvg_empty	= 0x36,
+	MAX17042_IAvg_empty	= 0x36,
 	MAX17042_FCTC		= 0x37,
 	MAX17042_RCOMP0		= 0x38,
 	MAX17042_TempCo		= 0x39,
@@ -221,7 +221,7 @@ struct max17042_config_data {
 	u16	fullcap;	/* 0x10 */
 	u16	fullcapnom;	/* 0x23 */
 	u16	socempty;	/* 0x33 */
-	u16	lavg_empty;	/* 0x36 */
+	u16	iavg_empty;	/* 0x36 */
 	u16	dqacc;		/* 0x45 */
 	u16	dpacc;		/* 0x46 */
 	u16	qrtbl00;	/* 0x12 */
-- 
2.33.0

