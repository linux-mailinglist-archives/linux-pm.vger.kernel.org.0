Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84740EC8DD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfKATHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:07:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37047 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so11684900qkd.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVfSPJ9zvMnUU5ly0+xbA4vuN0APYA1A0PaPALobUlo=;
        b=SBj7at5RDnaViDCsq1YnwgGzXDla0NhUa/yFYA11hNExkymPOVnJyUGsnnRv1YcQAb
         G543MMkGozOejW9CbEyLRCWf392g7zPthhOU/+yfQp/EIeyQCF2PjoxQxILsCF8sOlhs
         1LP2HDAvV1CSBUOboUkNWUnZCb8neUV80awYaybu2tJ0Q59ESuInkOL02eWy18i9uMFV
         dZE+Lks6+GxjzpM84M7/IjAlwIZyfAquvO46fNk9YLc6Ahtg4lv/j28LdcGB/5fncOv3
         YWlef4RluZuwp40fE2I0yNKZOIAQYlZJnpedZHORM8EmeK8sa2LD02Ffrr7rm4ls4vvG
         e2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVfSPJ9zvMnUU5ly0+xbA4vuN0APYA1A0PaPALobUlo=;
        b=tBkir/ZOJ6HzxCO+xFnAP2dg+bvUajZs4AxqGHySZy7SethQVjztksh/bf2zzVleyj
         xOJlQOkgZTEGrkyVD4OrQS9rfQ5HglQMzUnDRdgHG+6r40JkzCeOJQgzgLp1FRzOP5VO
         DDerk40TzO3+aTWILbv6quzso89KFAFxd6bWZRw3Y5EsP3xSi/n7MePLuzRTgdmjFDB7
         t1uwdsVHMMx8IaSqtM0I+gO2m6Msb7mpoeCh9yiQSLKjy3z1ev58ebjMlZ2sF0PGpEPs
         C3hkTniyYJmpqGaMp7aLvZNOLq6dXx429p1kv1j1dfzPs2PYkXuipoespnAFKm7/0NGj
         oH6g==
X-Gm-Message-State: APjAAAX1kfRUuRkyGiRZqaZuqMJiWbK0TZSJ5mLHSuNEnVbxouKOKsM9
        H1Z08AYKe3IlFa33ggyXQnw=
X-Google-Smtp-Source: APXvYqyqB1nZnfWC7XHJxvyyNNXzFu93iEIwir609A5iiDbXec5XOQIhvK/Oi1AY73GIA68QXCHJgg==
X-Received: by 2002:a37:6ec3:: with SMTP id j186mr11949468qkc.473.1572635251963;
        Fri, 01 Nov 2019 12:07:31 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:31 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 3/7] power: supply: sbs-battery: add force_load as a dts property
Date:   Fri,  1 Nov 2019 15:07:01 -0400
Message-Id: <20191101190705.13393-3-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This extends the behaviour of the existing module param so that system
integrators can specify the flag in device-tree.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f9e8c14ac830..f92b98d900d2 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -814,6 +814,7 @@ static int sbs_probe(struct i2c_client *client,
 	struct power_supply_desc *sbs_desc;
 	struct sbs_platform_data *pdata = client->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
+	bool force_load;
 	int rc;
 	int irq;
 
@@ -858,6 +859,9 @@ static int sbs_probe(struct i2c_client *client,
 	}
 	chip->i2c_retry_count = chip->i2c_retry_count + 1;
 
+	force_load = of_property_read_bool(client->dev.of_node,
+					   "sbs,force-load");
+
 	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
 			"sbs,battery-detect", GPIOD_IN);
 	if (IS_ERR(chip->gpio_detect)) {
@@ -890,7 +894,7 @@ static int sbs_probe(struct i2c_client *client,
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!(param_force_load || chip->gpio_detect)) {
+	if (!(param_force_load || force_load || chip->gpio_detect)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
-- 
2.23.0

