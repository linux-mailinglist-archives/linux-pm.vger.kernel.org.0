Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80A58A3A9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 00:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiHDW4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiHDWys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 18:54:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7D74CDC
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 15:53:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so1318445wra.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y6LxKgZwFvrUFcWeNV79IxBK5DkuqAc3CHWOKwe+2Kg=;
        b=Id7pKweYUatJROorXv8gDRF6wOlhQYhoHYCgkiawGsi5z1/06p2q/2zVrrHjJJLL4+
         cJfswWG9mCrhUj4ZKuNWoNX+fC3638GGqxxqmIHqJuDNziuEQDGjr1cuz2jISKJ/+Pzg
         SsYoEZKBeEUadva58HJM/00F5Gh0GPeOXzh8JeMgu4SsRXGxwRBnpLCuo/oc96bWpYzI
         ySepH49uraSqsJ6f9l/pvVNlVjG7QMvT/1ouzlRSMPHFQfNzDQDmzcG0wO75Dr7zSxOE
         squ2SZkwzow4QkW3fPr4qWvxZcpQp9QhCeRFPWDXYmHYQFmouYPcmcEv6srclO7gAg41
         wF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y6LxKgZwFvrUFcWeNV79IxBK5DkuqAc3CHWOKwe+2Kg=;
        b=dDA7OlHvuMEkZpM0MMzGugf5kWyEm3b3Y+f1S5ajKII6/W2rURJQckKNN/r0TAgG3m
         PpW95fVh3h2SffXUl9S8nvtYN0gtZFhf7W6cvsc8v624hwSnzXR/U4d+1bgA7Thk9JuQ
         gi+pRtTWCJI+vJXFEhmLhBd9VYNWQRA9r2mkOI7conGMRp5vA7W4QYL3fTcV8WIQR69G
         f8NpkWDTkGU81HRrZN7TGZAFk5Rr9fZKrq5mnjTiyKzUZWqc5idNrM+m/aa2nwFbTyNs
         Kj7SD7aszarqLIrjskNL4iMsLugROYm5GU7Ek9cvpcJqMN8NwLMgLr5SUtLenwEryNiX
         3MMQ==
X-Gm-Message-State: ACgBeo3Juyqyi+nfKOV6cn+pSIUgQgn8JNBhaLNEAxI8Jwojdlga/Dzb
        RAw9k6jDFLQ+o/inRgG+1qVsFQ==
X-Google-Smtp-Source: AA6agR6C7kB9euhycbz6D2Hp/WjyYK2+u2NklN5QEy26sFT93OJIpIYnk3FMTGQ8ir7oO6wiI2oZYA==
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr2560700wrp.159.1659653587248;
        Thu, 04 Aug 2022 15:53:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:53:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v5 30/33] regulator/drivers/max8976: Switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:46 +0200
Message-Id: <20220804224349.1926752-31-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8973-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index cb7e50003f70..61211c462b1a 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -447,9 +447,9 @@ static int max8973_init_dcdc(struct max8973_chip *max,
 	return ret;
 }
 
-static int max8973_thermal_read_temp(void *data, int *temp)
+static int max8973_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max8973_chip *mchip = data;
+	struct max8973_chip *mchip = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -478,7 +478,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static const struct thermal_zone_of_device_ops max77621_tz_ops = {
+static const struct thermal_zone_device_ops max77621_tz_ops = {
 	.get_temp = max8973_thermal_read_temp,
 };
 
@@ -492,8 +492,8 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 	if (mchip->id != MAX77621)
 		return 0;
 
-	tzd = devm_thermal_zone_of_sensor_register(mchip->dev, 0, mchip,
-						   &max77621_tz_ops);
+	tzd = devm_thermal_of_zone_register(mchip->dev, 0, mchip,
+					    &max77621_tz_ops);
 	if (IS_ERR(tzd)) {
 		ret = PTR_ERR(tzd);
 		dev_err(mchip->dev, "Failed to register thermal sensor: %d\n",
-- 
2.25.1

