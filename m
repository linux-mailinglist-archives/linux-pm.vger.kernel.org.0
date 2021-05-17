Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96812382A36
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhEQKx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:53:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:15120 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhEQKx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621248753; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ktk9/4l31tFn27QOa4xGUJzZ1iKzKiv0sEyV0UpHezmjqVo/fSXouA/szXCmMUSvD9
    1tDw9KQpHF1K2nJwC20MKIfwWB+ItKlXTUuGYYNfEA6Pmm83NPP8OjIYb0VdtWPQjX/5
    zRE7muIp/F/v3PFNsZfeRrURiBkv6yGrL2hZEZjrW4WdEgcYy7UOo7QVJrWBFLBkQUIv
    WQwlh7Srsji20UxuTmBktxtcy+BSEU9XYVgNxDFGDoqA8FSLOlBvMtWOyGRl4I6Tt0ha
    NWcukrtn7QIF0ws6xHjoaCGbRsciXsSgIdyvj9uMJH3KiSZ/zH6khK+HzRc4Vq0TOBIj
    Tbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248753;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8WRh2I4er0L239TZnY1xzYUrDqadMyt5Ik+KZCRstRg=;
    b=FWI00tCPo+BXh3yQaBorg12vH4C+RQnnSZDlBdtBfz9MNnoFB0m/lvp/OYcjHyITjH
    wHmmUlXG8cWzCMzoS6dx9CIZIyI1RprfRUbiY+3AAUhz76FppIQyt2s9JExya78Pi5KU
    4kyAFXWPN0KEGywh1KZ2WcR28Ixdwi1NuBBkSIhIBbhoA6p0vOxnl/XznhOE/jPYb6ca
    v1hc57LQPqaA9QDn/zks8cN+g3mUFGcxI0Tceilc+ccV0cbiJyXMsTih5g4nYHfy3zSU
    SO/WbuBMrhO9C3ClEx3QDzZ7Y0OJzPStPZOZ4xM+RJ8DP8h/48/dQKpLob//aIUBIQZB
    +NDw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248753;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8WRh2I4er0L239TZnY1xzYUrDqadMyt5Ik+KZCRstRg=;
    b=lCAphCBg3fpthH9qM9ysGe3gwXkBKtGV2Hf9OrJA7+ru5ESYdApPpBAO7p4JkLSxZa
    aguvLKIov2Hu9UeYbAlk/baFqgcM5NNxKqVP0agESEwQeDHlw/Vu3qh+lgps9RjLAEyx
    4Dj/NWuLD8NfJPYuyvS+CuyDQjpuyy6SQKLJ/+JZrITBPQ1OwYtTS7xaiXeZ3dIE6MlX
    +BTbl84xyK3ZcX64hLnkC1PIAgvN0eR9lcyXTOcU2/1jsg5PRgMn2mHXoF093TnUWSiw
    wqC41NOTgv1K1hlUdz1L69VG5O7qSQMfWc5uSDfiQYhXIEYbXD3gIHIH7RCX2FdVVs4w
    ys5g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAqW1Va
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:52:32 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/3] power: supply: rt5033_battery: Fix device tree enumeration
Date:   Mon, 17 May 2021 12:51:12 +0200
Message-Id: <20210517105113.240379-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517105113.240379-1-stephan@gerhold.net>
References: <20210517105113.240379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fuel gauge in the RT5033 PMIC has its own I2C bus and interrupt
line. Therefore, it is not actually part of the RT5033 MFD and needs
its own of_match_table to probe properly.

Also, given that it's independent of the MFD, there is actually
no need to make the Kconfig depend on MFD_RT5033. Although the driver
uses the shared <linux/mfd/rt5033.h> header, there is no compile
or runtime dependency on the RT5033 MFD driver.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Fixes: b847dd96e659 ("power: rt5033_battery: Add RT5033 Fuel gauge device driver")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2: Fix stupid typo :(
---
 drivers/power/supply/Kconfig          | 3 ++-
 drivers/power/supply/rt5033_battery.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e696364126f1..20a2f93252f9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -712,7 +712,8 @@ config BATTERY_GOLDFISH
 
 config BATTERY_RT5033
 	tristate "RT5033 fuel gauge support"
-	depends on MFD_RT5033
+	depends on I2C
+	select REGMAP_I2C
 	help
 	  This adds support for battery fuel gauge in Richtek RT5033 PMIC.
 	  The fuelgauge calculates and determines the battery state of charge
diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index f330452341f0..9ad0afe83d1b 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -164,9 +164,16 @@ static const struct i2c_device_id rt5033_battery_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5033_battery_id);
 
+static const struct of_device_id rt5033_battery_of_match[] = {
+	{ .compatible = "richtek,rt5033-battery", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5033_battery_of_match);
+
 static struct i2c_driver rt5033_battery_driver = {
 	.driver = {
 		.name = "rt5033-battery",
+		.of_match_table = rt5033_battery_of_match,
 	},
 	.probe = rt5033_battery_probe,
 	.remove = rt5033_battery_remove,
-- 
2.31.1

