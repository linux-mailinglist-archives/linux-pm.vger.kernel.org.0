Return-Path: <linux-pm+bounces-31214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF948B0C550
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 15:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E490816B767
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E771607A4;
	Mon, 21 Jul 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="QO/ILNeI";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="lmstuex2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DE28F53F;
	Mon, 21 Jul 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104987; cv=pass; b=VMJ+4IjtgvBf/7azjdkjh8VTNDV2c12F7AsSD+vIcIKrXFTU/agupHyTrco9v086Kfy3tco9AeVydwZbxelDnC6eNos4no0hcOfjXk6XZ7eJ3gJ8zaoiDT2DbhtSGB2xKzCJarXGVd6piEprUhj5be0Qz1rrthWxEeOCzLRFXa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104987; c=relaxed/simple;
	bh=35cYQVm4zLLoIB57342iho+QScl4DbuVrkRFPA2X2eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gS4Tf2N9DGxbKNa8Yp7cuRCW3OiE6g2z031aLKT5Qqk0/kTL+KYSHfT/UMB0Gs6iQ3mLYPSNIKCIjiCycZutkWZAnqQkH7eVe6Xzg0xNMp7ojzTmM7Dqfw58taa/uxdB8eo0eu2XLcxMJQe795PFJU919zwx9tkMg65DEvtfLPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=QO/ILNeI; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=lmstuex2; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1753101976; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mJh1WY17HpmgjV7HDUlAP1Bh/BhPBIW+FHPa7axDyS16/jnrHUh+M5meG6w6lPuYK6
    sqZKVqXkrF94GWIj2tHOx2axEl2NmeJ+7lF0YhHxh407iTKVoaTFRLxVfkwd7vwcqXM9
    xHBbFZI6gazUWmYo9ImCEcsmlRHy4ky72EVnwi6kc+IZU2gwhXRn5XnDhJkxqQM8OgG1
    lRp9IXEC3c/mZ9UmUQZl9l56lnDvBQyj8Hr0+YKs8SjiEr5nLY6kdQIiGCfi1OIGM44E
    qW4kJB4IPxzAL33GigOG2QOxMc0mQHoWQBw8+9mvQjxedrycpQg339ByWiauK5dfgQLx
    PWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1753101976;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=T0De6Am+nfTD1/T8qRHYoVSqpbNHuCwxHjsiXItzmwA=;
    b=fu9jHWa5LH3jxD+pm56rfm8wZzBtHYnBvIVMUzAsCTwyQ6udgWK2AUoLybSzwly7vB
    Ceq1ZDDae/zJIKY4jzPC0K6i9KI39e3cChuppC2u6ys3wf8JjcMpQGSDK/vDogMuRcAd
    cvU5mXkZRQIVugLd1WtqMkGwjYbzuoXLDit357VL+JwT1MHm4IB2RGJHaLQvoRFPmkTS
    hKze1ilnAiqDlG2Y6szx003mlLxvqh7stB1Aflc8x3Cx87NiqG+QHEk83jvHuMlfqRfz
    RmPHlJMnUePikJRm+Ihacd3k60Z1vBLZP2DlcLALNvGW46fqtaoQz+ax8pII8b3SXiKx
    WCgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753101976;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=T0De6Am+nfTD1/T8qRHYoVSqpbNHuCwxHjsiXItzmwA=;
    b=QO/ILNeIWdVFZisaq+VoQcWIoYG7Bq7fnMJEPqqAa0GIn+5mfy2HoZ9K7q+ZaX4/aN
    JuhCf/76n2RhkoNc6qevV1BSpToxZnKtPj7ti8az/8U8UoidqKQrZ3WbRS4+IbqPUORm
    rE13eQd7uH7yTJrOjkMbh2VFdG9hGehMdMK2IVgw96lnbRkmsXmgYwch4cvaGGY3a+KA
    j9cz+cXEuc9wejUUoAaZBnjaqliwiq7oecQh6ohQ68lZoTt5mSOfPx1u9zwEHeMnUL5+
    p98J5XKSIMezodOWf0IZ+SGgw14wKyJK4TI7Ap4f+IoW9jqu71CSHzw+fRIb57bS4DxG
    NCXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753101976;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=T0De6Am+nfTD1/T8qRHYoVSqpbNHuCwxHjsiXItzmwA=;
    b=lmstuex2SU9y8xFDtxbkpKSm/E/OCCSjWALYFN/SgXMr84M7OUd5XWnD2zIapNrpxE
    0NIs9kGKMacDTwAH0lDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrVi5pbyciNjWBMoAEyQro/p8z/o50zTNRbUr3m"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id Q307a416LCkFEp5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 21 Jul 2025 14:46:15 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>,
	Jerry Lv <Jerry.Lv@axis.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	kernel@pyra-handheld.com,
	andreas@kemnade.info,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
Date: Mon, 21 Jul 2025 14:46:09 +0200
Message-ID: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Since commit

commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")

the console log of some devices with hdq but no bq27000 battery
(like the Pandaboard) is flooded with messages like:

[   34.247833] power_supply bq27000-battery: driver failed to report 'status' property: -1

as soon as user-space is finding a /sys entry and trying to read the
"status" property.

It turns out that the offending commit changes the logic to now return the
value of cache.flags if it is <0. This is likely under the assumption that
it is an error number. In normal errors from bq27xxx_read() this is indeed
the case.

But there is special code to detect if no bq27000 is installed or accessible
through hdq/1wire and wants to report this. In that case, the cache.flags
are set (historically) to constant -1 which did make reading properties
return -ENODEV. So everything appeared to be fine before the return value was
fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, triggering the
error condition in power_supply_format_property() which then floods the
console log.

So we change the detection of missing bq27000 battery to simply set

	cache.flags = -ENODEV

instead of -1.

Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
Cc: Jerry Lv <Jerry.Lv@axis.com>
Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 93dcebbe11417..efe02ad695a62 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1920,7 +1920,7 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
+		cache.flags = -ENODEV; /* read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
 
-- 
2.50.0


