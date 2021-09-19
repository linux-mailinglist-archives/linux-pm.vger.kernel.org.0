Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C9410D41
	for <lists+linux-pm@lfdr.de>; Sun, 19 Sep 2021 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhISUQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Sep 2021 16:16:26 -0400
Received: from h04mx15.reliablemail.org ([185.76.67.208]:25313 "EHLO
        h04mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhISUQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Sep 2021 16:16:26 -0400
X-Halon-Out: 6b4b0632-1985-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ej6wDNMSbiRyM7NQXz7W5SiGUOAZUPKpKRcmJRuBGnk=; b=VeZkz8rVME9DtouD5YomEn1FtZ
        mSKyKlTF0NkxPfxAlrtrIwa9MbJVfEObr4mcw3oQ2E5v2vJC9hPDgLJEVuNe7Lq1i7EeNVzMsMQ15
        LFDaEwiZa1h4cL0+NOehEM8S1MEmwXEff+P2UCSm4n22NfrhHLG0QR/A4wsv+uJwupQS6mCbP55d3
        5OleykHM3P5GqI6u0dB5NGRJ7HoubN2X4kGCVLJw5Hpg720NdacVvs9/1cuc/c+NmOC+A7k/07XG4
        nIR81gck+EKifpriMo0oCDwES38CcRM88UMn+Hhvlfk5fk8tqt4ym/WqqNDvRbtBhvo5SwMuX3rkP
        zRMEHhUg==;
From:   Henrik Grimler <henrik@grimler.se>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 1/1] power: supply: max17042_battery: use VFSOC for capacity when no rsns
Date:   Sun, 19 Sep 2021 22:07:37 +0200
Message-Id: <20210919200735.142862-2-henrik@grimler.se>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919200735.142862-1-henrik@grimler.se>
References: <20210919200735.142862-1-henrik@grimler.se>
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

On Galaxy S3 (i9300/i9305), which has the max17047 fuel gauge and no
current sense resistor (rsns), the RepSOC register does not provide an
accurate state of charge value. The reported value is wrong, and does
not change over time. VFSOC however, which uses the voltage fuel gauge
to determine the state of charge, always shows an accurate value.

At least one max170xx driver, found in Asus' Z00D kernel [1], chooses
how to get the capacity based on if current sense is available or not.
Lets change the mainline driver to match the Asus Z00D driver's
behaviour and thereby fix so that correct state of charge values are
obtained on Galaxy S3.

[1] https://github.com/LineageOS/android_kernel_asus_Z00D/blob/c7ab0e3ec5b5/drivers/power/max17042_battery.c#L1103-L1105

Suggested-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/power/supply/max17042_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 622bdae6182c..7233670978d0 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -317,7 +317,10 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = regmap_read(map, MAX17042_RepSOC, &data);
+		if (chip->pdata->enable_current_sense)
+			ret = regmap_read(map, MAX17042_RepSOC, &data);
+		else
+			ret = regmap_read(map, MAX17042_VFSOC, &data);
 		if (ret < 0)
 			return ret;
 
-- 
2.33.0

