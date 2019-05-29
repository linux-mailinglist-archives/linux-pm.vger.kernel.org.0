Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B22D5FD
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE2HLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 03:11:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40872 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfE2HLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 03:11:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so657123plb.7;
        Wed, 29 May 2019 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qigX1mJNTElLHAS9uWeOS6rmTLOEOvDTk1cuKvKYM4=;
        b=Ex6AyfvK8A1cFi8X4iMds24aE6z3i/KWLhxOPOya0hzGAJzl++SeV8LRbuS2OaxVn9
         tmY35aPfTZzQy5pLEKRViYMS2HDWWvAEpHCawxD4w503h65weXl7oGYd4qi0AmmV+azl
         13xtQhwA3Q8sq0yybTObP2bs6VqkUsyyfwCEYOqqlCCdKzQQE5CFgFWuF9d4BVw8ltr2
         +EXi9OE1jnqhqiIydg1ym6Gg2mDJzHv++spL/OixOjYPk4i289YEyMZdyRgxZnzKKpfq
         4zYCd1BlM/UKYsMCZ8Zd2stMdPigCJpDTolSPXzrdMYsclw+U3Z6cxHnVwVyYCGRmfCv
         1WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qigX1mJNTElLHAS9uWeOS6rmTLOEOvDTk1cuKvKYM4=;
        b=WDlAdhKcsKPm5Vcu8aWFmF5KMDL3ecZyDWiIRXEJsaB/wYNQrizUzuND6vjecTaQbM
         4EOGj2nukh3tLMItVUTVelnJMfMijrTsn36r8JBHzQho/oszRECqoaN5aVyke2hdRtBV
         r/Hkr7h5bcSo5mdydSZJH9TIk0yNW/J+Av6C/Thw1T+ATlm/7KqF46DIDgZ1GI265N5g
         urQgeXkBIDnn09FGbwj4ga8JKPB5FziVI+Ur0EF11+kseowGVdXZvpMsy56Pl1u9aCfv
         Sjajo2NQFZzdYuxBLBLmdsZu2bP29+6Tk5t35C5e0vqYr1gT0XxvGOCvg03+l9ll0Men
         Vucg==
X-Gm-Message-State: APjAAAWfPnqc5xWr+z5pvwPHvrDosesWbyVHp4Xi1Tc00YWy+9yb+t7E
        F4m4Rk30h9DRPDFfutQP1Jgh3+qXlK4=
X-Google-Smtp-Source: APXvYqx8FD5B0sMQ8Jni2x7WsXqeLZatQCCizEvafp2Qq4ANhjXD+zILaltPXLv9vbhdXmofYrt2qw==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr142351041plb.280.1559113889861;
        Wed, 29 May 2019 00:11:29 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u20sm18083307pfm.145.2019.05.29.00.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:11:29 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: ucs1002: Add HWMON interface
Date:   Wed, 29 May 2019 00:11:12 -0700
Message-Id: <20190529071112.16849-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529071112.16849-1-andrew.smirnov@gmail.com>
References: <20190529071112.16849-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose current sensors found on UCS1002 via HWMON.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/ucs1002_power.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 1c89d030c045..1faf2ef7d3f0 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -491,7 +491,7 @@ static const struct regulator_desc ucs1002_regulator_descriptor = {
 static int ucs1002_probe(struct i2c_client *client,
 			 const struct i2c_device_id *dev_id)
 {
-	struct device *dev = &client->dev;
+	struct device *hwmon, *dev = &client->dev;
 	struct power_supply_config charger_config = {};
 	const struct regmap_config regmap_config = {
 		.reg_bits = 8,
@@ -571,6 +571,13 @@ static int ucs1002_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	hwmon = devm_power_supply_add_hwmon_sysfs(info->charger);
+	ret = PTR_ERR_OR_ZERO(hwmon);
+	if (ret) {
+		dev_err(dev, "Failed to add hmwon attributes: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regval);
 	if (ret) {
 		dev_err(dev, "Failed to read pin status: %d\n", ret);
-- 
2.21.0

