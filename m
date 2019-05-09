Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E218A20
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEIM4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 08:56:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEIM4h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 08:56:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so1292338pfo.5
        for <linux-pm@vger.kernel.org>; Thu, 09 May 2019 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HpTewxiim19d7oKXXVsZ1kcLd1qCPkwllFbArifBlM=;
        b=DCYqb0zLOH1x6pFvn/tFs5h9P6Sub/PNF6wmobp5sT/9oUP/ZDBvaGq32unTTNZ5ne
         i75pHJL4LfvvgkRUvGKdX2X5kOvxpuKfLxVG/hy9dTU6mTAIf3oVYkNLiBvlcghez83/
         DrKyhAlZAC2A8v0CPusuiS3Fmogy5+6VUb20g0ELIUVq0+fviUEtMq6WlAAxBKdoASAL
         9OZ+Xfb5FWkEjAxz1YLqM9y1Rvoigmf5PaBwLYnYg1DXwYhjqpjlyK99A6c8Rvt2PQzg
         vUlmgLJBnwSkVt/nEJy5bwXxJAaFhH64HJ8n+IqQUSGwQjUEZS2AX3FrhUqmVRvk3ldI
         Z2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HpTewxiim19d7oKXXVsZ1kcLd1qCPkwllFbArifBlM=;
        b=hZUD0s1sTImLzOzGOWPHvKEoEBvMlmjYAFCQih1XEQcaM9M8mrswYLpjMm13QwF52b
         tktrDNG6hcZmRmVJc+LFbAQ9LhF5IvFeXWravwv52NpS+FvfoqhndniXRNGNN7gSf6gV
         RFUptjhhj9HoIrg5c+v3e/egZ283L80NOAEmhWQ/itJwk34tRlbIUCmuu/cGZqIIn6jy
         WWylwmUXToSWiOyBTeD+Iog5oi/oyCV5gHGjZP/uy3tvWOblnHZ2kSmNXEsk9jTHEKxD
         XYRxuv3O4wDGrc5ulPwfQ08z1zg5rAdsS4L0Qvy20q5yXvTCjksYNN6ak5BLYVPfSu6G
         5/mQ==
X-Gm-Message-State: APjAAAVrQVEkteSXYIgUmp42S/bEwlRhdtbh1SPD3nw0Pv8SioQwpmJc
        eGbTzjzX+OaBf+QePz+PC3y25g==
X-Google-Smtp-Source: APXvYqwISlQAr3NUrG/IIUdBbUHdL/M/6knorFKWD7dyKfKF1nZ9H/53/Mjp6kYgI2AQ24QogRY63Q==
X-Received: by 2002:a63:2ad2:: with SMTP id q201mr5191410pgq.94.1557406596192;
        Thu, 09 May 2019 05:56:36 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e8sm3855676pfc.47.2019.05.09.05.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:56:35 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] power: supply: ucs1002: Fix wrong return value checking
Date:   Thu,  9 May 2019 20:56:14 +0800
Message-Id: <20190509125614.28921-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix wrong return value checking for devm_regulator_register and
devm_regmap_init_i2c. This looks like a copy-n-paste mistake.

Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
This patch replaces my previous patches:
[PATCH] power: supply: ucs1002: Fix checking return value of devm_regulator_register
[PATCH] power: supply: ucs1002: Fix checking return value of devm_regmap_init_i2c

BTW, I though Fixes tag is mainly for backport stable commit which is not this case.
Anyway, added fixes tag base on the comment of Enric Balletbo i Serra.

 drivers/power/supply/ucs1002_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index d66b4eff9b7a..1c89d030c045 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -508,7 +508,7 @@ static int ucs1002_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	info->regmap = devm_regmap_init_i2c(client, &regmap_config);
-	ret = PTR_ERR_OR_ZERO(info->charger);
+	ret = PTR_ERR_OR_ZERO(info->regmap);
 	if (ret) {
 		dev_err(dev, "Regmap initialization failed: %d\n", ret);
 		return ret;
@@ -592,7 +592,7 @@ static int ucs1002_probe(struct i2c_client *client,
 
 	rdev = devm_regulator_register(dev, info->regulator_descriptor,
 				       &regulator_config);
-	ret = PTR_ERR_OR_ZERO(info->charger);
+	ret = PTR_ERR_OR_ZERO(rdev);
 	if (ret) {
 		dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
 		return ret;
-- 
2.20.1

