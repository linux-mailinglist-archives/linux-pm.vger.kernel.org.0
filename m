Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479FD15A273
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBLHze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 02:55:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50221 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLHze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 02:55:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so536650pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2020 23:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VF571MMcb1F1isbPRkdGPyOV5FtumBnPxlJ+7Ql/2kk=;
        b=M8jzit6j9QXHldQW1vziSBuVrDgF9wRu9w6NmWC+sZyaJWtUZhgeLAMF0x14pFwBw5
         5oa/2v1y+DHBalrUVcSKiPaFQ84SEcBZsZTek9oGPffflAIEjDSjPW48ml5l6ZL/YIh4
         +EovNwMX9O57bPiJv5hzJijmEHFPoa24QMq0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VF571MMcb1F1isbPRkdGPyOV5FtumBnPxlJ+7Ql/2kk=;
        b=uNQl8LclvO0IEh0UC1sF+bP131Cum5WuqsOM3QuQeaZvLOVDh0DZW0YVbRQ8zoYfW8
         va29a3gdnbP9cX1MIdipGTNjbUxbGLm91IgyD1nM8kt3YZfotNmqwW9KBXwRCcjAhATt
         Qs2JxCG1nCsnE9C0Njq7JkpfiaO8aazTE4fXelA33remKG5XXtRY91CNb/YaZamrNUdI
         sMmwA0t7Em6WCWH7w+MD0w3yBM8dPKg0NswEq4RZHQhjisoCHvZn3Nn4/3bxhnJMLdSf
         7IJ8+3Q/ENAYA69Dey/RsVrHfTgfOrRcGbnsz6a/2K3RSBgfUN6sa379akRI4qoppE1P
         UUCw==
X-Gm-Message-State: APjAAAUI1eprJK7yjO0SGWzajEVjbz6O9D5bvwtBIhgyByI9MbFTwYun
        5dvvzFNBDZPc5KuLjKlVH4Ot96dYW18=
X-Google-Smtp-Source: APXvYqyq4WY8bw9Txax+nA+0rPTTt8AqEwN517kv3Z9JDxtZ0o94aydwMwtjJghKRwSJ7soeTjt94g==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr8410462pjo.79.1581494133278;
        Tue, 11 Feb 2020 23:55:33 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id u126sm7049918pfu.182.2020.02.11.23.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:55:32 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / OPP: Add support for multiple regulators
Date:   Wed, 12 Feb 2020 15:55:29 +0800
Message-Id: <20200212075529.156756-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP table can contain multiple voltages and regulators, and
implementing that logic does not add a lot of code or complexity,
so let's modify _generic_set_opp_regulator to support that use
case.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

This is required to add panfrost support for the Bifrost GPU
in MT8183, see this patch:
https://patchwork.kernel.org/patch/11369821/

 drivers/opp/core.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ba43e6a3dc0aeed..ea4a12a8932014f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -650,6 +650,24 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
+/*
+ * Set multiple voltages. The caller is responsible for restoring all the
+ * voltages if the function fails.
+ */
+static int _set_opp_voltages(struct device *dev, struct regulator **regs,
+			struct dev_pm_opp_supply *supplies, int count)
+{
+	int i, ret;
+
+	for (i = 0; i < count; i++) {
+		ret = _set_opp_voltage(dev, regs[i], &supplies[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 					    unsigned long freq)
 {
@@ -671,18 +689,13 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 				      struct dev_pm_opp_supply *old_supply,
 				      struct dev_pm_opp_supply *new_supply)
 {
-	struct regulator *reg = opp_table->regulators[0];
+	struct regulator **regs = opp_table->regulators;
+	int count = opp_table->regulator_count;
 	int ret;
 
-	/* This function only supports single regulator per device */
-	if (WARN_ON(opp_table->regulator_count > 1)) {
-		dev_err(dev, "multiple regulators are not supported\n");
-		return -EINVAL;
-	}
-
 	/* Scaling up? Scale voltage before frequency */
 	if (freq >= old_freq) {
-		ret = _set_opp_voltage(dev, reg, new_supply);
+		ret = _set_opp_voltages(dev, regs, new_supply, count);
 		if (ret)
 			goto restore_voltage;
 	}
@@ -694,7 +707,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 
 	/* Scaling down? Scale voltage after frequency */
 	if (freq < old_freq) {
-		ret = _set_opp_voltage(dev, reg, new_supply);
+		ret = _set_opp_voltages(dev, regs, new_supply, count);
 		if (ret)
 			goto restore_freq;
 	}
@@ -708,7 +721,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
 	if (old_supply)
-		_set_opp_voltage(dev, reg, old_supply);
+		_set_opp_voltages(dev, regs, old_supply, count);
 
 	return ret;
 }
-- 
2.25.0.225.g125e21ebc7-goog

