Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7A5E028
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGCIsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 04:48:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39258 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGCIsQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 04:48:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so1416447wma.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OD3A1MbQ7x1GxTFq+WXLwGT5ErpHAmVY1ZLw97KnU0=;
        b=CQmgJnIFjAR6wf7MolyDYds+79eh+zkANb3YrAqvbQnKzPJYmPqEt0ODt0kSQEAxrs
         41NpA4b1p756Ps8Q9ZhU/63RfoC8RFqnf8lUXbtY2cOta1kioHl1jhleC4maSY6xQ3KS
         Y571q8u+tBSJly4nJKjQAjkNPNHsDwWVrEeTZEJPO5jc7+pDtmKpNsMjVIgWe5TEDYq1
         gmnUcJIS1IDk37zBEd+kMf1I/UpxolEiUMalLjO40uzMdgzrLe5Ty/GarR9oZRQv4751
         jFJBo2QDD/IlKrmACGyHEJhxBI/A0yIBzEdBczwU6UYcfPUUuqe63d4YpX+8VYA1f7iX
         AteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9OD3A1MbQ7x1GxTFq+WXLwGT5ErpHAmVY1ZLw97KnU0=;
        b=At7dBKeZSYJ7QK69aTUyLTvk6JWH0nT+FL6C55fYwU55t30aXwj9MpQwGDGKdxHmSH
         WkK0rHK/WwR2PZQR4iWoMaw+eu8AwDhqOh3l1dVedyTOBrgpltlB9yWbahmuWw2RG4Y1
         eADllgsgv8tEZ5XdPKvB3ZQ2fiBMnh1CKp3WLkUDptfcZTpPPVaKjh12dA0JE4AbE8ne
         n+YiVQVB12hU3SaNQWtck0CJ+5ENkqqk3TNdyGiKQMnkFFJTzyQRkYhIvN2t+F8H61fM
         1HWpQfNler4RB2dGZDZ0qANhW5sfvqS5sbvOiN9grEio87tqxuvYvUrpFROOXa534NoE
         vqgQ==
X-Gm-Message-State: APjAAAXPIeCt6ug4sEf9T9Zj6uw3UKJwE/J7eLZTbVPvOn+N3322kt/p
        5Ybm6QToLHA80ETgzlaezWg=
X-Google-Smtp-Source: APXvYqx36i74x4LxYOoggQEqJ6vJTnZruf8ZDMETTVOVN3VjV9+o5eH1nyCFajyASdMlc9S/YFxuKw==
X-Received: by 2002:a7b:c356:: with SMTP id l22mr7006863wmj.97.1562143694720;
        Wed, 03 Jul 2019 01:48:14 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 66sm1627363wma.11.2019.07.03.01.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 01:48:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] power: supply: max77650: add MODULE_ALIAS()
Date:   Wed,  3 Jul 2019 10:48:10 +0200
Message-Id: <20190703084811.9582-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Define a MODULE_ALIAS() in the charger sub-driver for max77650 so that
the appropriate module gets loaded together with the core mfd driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/power/supply/max77650-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index e34714cb05ec..5f9477c5cf5a 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -366,3 +366,4 @@ module_platform_driver(max77650_charger_driver);
 MODULE_DESCRIPTION("MAXIM 77650/77651 charger driver");
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:max77650-charger");
-- 
2.21.0

