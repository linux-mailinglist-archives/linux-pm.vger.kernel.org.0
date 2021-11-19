Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2150457645
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 19:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhKSSVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 13:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhKSSVt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 13:21:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5EDC061574
        for <linux-pm@vger.kernel.org>; Fri, 19 Nov 2021 10:18:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b40so47224927lfv.10
        for <linux-pm@vger.kernel.org>; Fri, 19 Nov 2021 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/g0rdWvTQxZyyLJRjfHS8Hj4b286itInuHRieekBvs=;
        b=w0vLYU+Dp+O1fJ7H/up33qLWce4xYVnVA9NOO/ilSNLJ1KNfkOT+CeIMwK6NqPgKkX
         R7ei9uyFszCIXLcRisO74UowwMim7vYUZYfB1VpLrX+ds6puWDFi6Lfr1ajjx4cMMqa3
         xzlfmrF7SNhyTo2KEeXqQTs7K880Qa8Q+tHHCFEhetPsdJQHVWCJYhVjfycfn9Ow3Qii
         SY8MfNE7ZBgxjjKO0ADm6u5lGVQ3No95N/cOnLD/Sz/gBsn5MfiWvHfToluXENbv6a9i
         MnWYnPlwepN/19XNwsyqoR6tVqyhyl7G0Ur8N7X/9QVI/dwmLr8xDOuM7Rli0BH2GpUO
         +RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/g0rdWvTQxZyyLJRjfHS8Hj4b286itInuHRieekBvs=;
        b=No1duyzkKBZu1CnuCW7U7GGc5d1TjqSHTsOSrjmrzlDvo+rCOnpX3Er79ufR6fmxEH
         ua9gZFY82KS57QCvCJK/CKDoxTKKwgenNLy8NTCMDNVFEOj/vlUSIYYmthE8nKL3rzFU
         VTYe+WwIYKLOkK0bIBZm+EoVMngC3AcHd0/jhe6PX2/o2GU1W3F23sWZDinIA5x93HE5
         YlUMX0vawb4zillX5n26btUTpQ2dTMhPU2pZMhljXeGN0Yd1n/f1Y8bhB9JAtSVzt/xa
         osl9E5y8iAbOdDBVcrakzsyk4vOpzj4hv952RYsEgzIvT2NRwrBfkjTZoJpJQ6QpNA//
         7dcg==
X-Gm-Message-State: AOAM531NwWtuF3wPBszeWy9sqasY/ppC8MgjHQH1YAEntoBERB4HcZ6j
        1ZtoV3ML/6YAC77SfLdwollNGw==
X-Google-Smtp-Source: ABdhPJzFtTiorJEdmD1qjvg9aRv8T627ylf7hh9uNOIYeqPrLXg6QFdVn74jfWvTzXy1UE+eCHLJ9A==
X-Received: by 2002:a05:6512:1101:: with SMTP id l1mr15732178lfg.343.1637345925692;
        Fri, 19 Nov 2021 10:18:45 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id a1sm55281lfc.92.2021.11.19.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:18:45 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Quentin Schulz <foss@0leil.net>
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: [PATCH] power: supply: axp20x_battery: properly report current when discharging
Date:   Fri, 19 Nov 2021 21:18:35 +0300
Message-Id: <20211119181835.441233-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As stated in [1], negative current values are used for discharging
batteries.

AXP PMICs internally have two different ADC channels for shunt current
measurement: one used during charging and one during discharging.
The values reported by these ADCs are unsigned.
While the driver properly selects ADC channel to get the data from,
it doesn't apply negative sign when reporting discharging current.

[1] Documentation/ABI/testing/sysfs-class-power

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 drivers/power/supply/axp20x_battery.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 18a9db0df4b1..4ed01777035b 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -186,7 +186,6 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 				   union power_supply_propval *val)
 {
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
-	struct iio_channel *chan;
 	int ret = 0, reg, val1;
 
 	switch (psp) {
@@ -267,11 +266,11 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 			return ret;
 
 		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
-			chan = axp20x_batt->batt_chrg_i;
-		else
-			chan = axp20x_batt->batt_dischrg_i;
-
-		ret = iio_read_channel_processed(chan, &val->intval);
+			ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
+		else {
+			ret = iio_read_channel_processed(axp20x_batt->batt_dischrg_i, &val1);
+			val->intval = -val1;
+		}
 		if (ret)
 			return ret;
 
-- 
2.25.1

