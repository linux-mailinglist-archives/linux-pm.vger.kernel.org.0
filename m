Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7CA382A2E
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEQKvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:51:36 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:31153 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhEQKvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621247895; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g1CzACgygpB2LJBtEi9/uYDOgzTgnbSo0tOBjj8A/K9xAfvByws9wmki3cYsN300Q7
    IrpfsDFpPlA/FTeAPjYDFf3xJ9aKq9O6DgIGJ+Eqe2lyTnLrlMY/9hp7pYj4ms8tJSXG
    AppbeVM4hPUeEYvBzWJHx56zHK88fMEZmzkp/cAcyCdoXEyFTJUWU38af4CXpr01pBd9
    9QPJGWwK9ktKdT9Z3s+otUwMol4vrlF9JVtxqoWHtIkbqt5MhoGI9tK0Re5rJa68M5ry
    L9ErsGJLg2fMMQzM2QDE7RudX6EGOk6xpD71ftcxGawyO83b8bQ6Yt4qTktIAT/qXih8
    CKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247895;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7Nor9nt12asw5p5vSFrS8u2jY2UsEIJihijZJn6Qtys=;
    b=PtgjFPVMLROAB8DfOVtEjXn996gZfeWJGo7gKvYG2u27An3KJ8/MY1FPWyjI1jHwXb
    KSJjggcLqDMcBKu3rPIZicr7XH2VdG+iJ/y8RFlVOtfY5Tnv0bCGrWBRNnlwGWr9Egwy
    YZRAVwI+MpxyCtj3QNTA9t3Ym1suMeJHz265O1GJ97J53OFC8PcNb71d6U0O8Jd8rdah
    hHNPb7B1tYHZo4c56369Fh+izBhjUnlUaOjBu6HdPYE29XvgsXyBiMl0Fz5DsatUfhMz
    oYHwpKULKI/851Gwo7D94ZjV5w2yfhyywcKYtpkIRISxwiVNJ0St7lURkGvgxsLRhKqU
    ejDg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247895;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7Nor9nt12asw5p5vSFrS8u2jY2UsEIJihijZJn6Qtys=;
    b=G3drqqlFUGVBAfg4ieJCUbGLtFzQgr795cmlrd5aKF3XlEwS8pw2oLXTlwG7E5+7bl
    xCh/U2aPatOuYvKQZLwostWwkpbCs4bpHwYjwofwodEJCNK8SLohMdDSX06gGvu/khCd
    veHTd7DFqumiYVeJAmNqQf4Wbyginxtp3SJAumPdAm7XeZqu/CB7y0IMHP0gXWCxT9/u
    L8jJE6wgDsLlNRA+oa83LAlJNou0ZeU8k03aIH605hR72hfxdzT28JFbiVPXQ3iYl/Gc
    w2SYzNC22+OuyZdl+Zfent0HxsZqRh3AhVQJPOzTqniJNZAiHLzn6QZGRDb+XGH+3oGo
    YiEg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAcE1PT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:38:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/3] power: supply: rt5033_battery: Fix device tree enumeration
Date:   Mon, 17 May 2021 12:35:53 +0200
Message-Id: <20210517103554.168159-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517103554.168159-1-stephan@gerhold.net>
References: <20210517103554.168159-1-stephan@gerhold.net>
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
index f330452341f0..11eb9ad66ea9 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -164,9 +164,16 @@ static const struct i2c_device_id rt5033_battery_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5033_battery_id);
 
+static const struct of_device_id rt5033_battery_of_match[] = {
+	{ .compatible = "richtek,rt5033-battery", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5033_battery_dt_match);
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

