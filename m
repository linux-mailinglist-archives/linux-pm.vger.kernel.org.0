Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07A3ED035
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhHPI22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 04:28:28 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37194
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234846AbhHPI21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 04:28:27 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 260AC412B6
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629102476;
        bh=lxDKaysG/aHQwlTNKh0Nbuao0YTQ8x2bzMWqPvbdZ6o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jeZc+nZAlau1V5fVk6nvKy98NudglkKsgkKEqDAxJFS30LWS42A81kN3AsL6Bg4sw
         SbbeVKF72KBRt/9hMSR/s74v/JDX1WM/PIsME/wGHvimfHEQNd1+0kClyY3ffaWpix
         ZckyZ4xQvc1U86y1qFL4J4Ib2h9ykf8jbJni9iGO23wcK/h4P+kO5fXLilriBWWEIo
         Gmq9bMH8hctFER7R/osvTIJCr6uz3YM1JFORHCSvHSkHZ4CeTyqiUXyKI3/b46Xn8Y
         EgreidCC2cA5dI7+g8USMvBCQ3HBh9f81n2N/zATax15qJwFpt/SQIinv4UL47w78N
         Vj5+JD2z2WbpQ==
Received: by mail-ed1-f69.google.com with SMTP id x24-20020aa7dad8000000b003bed477317eso2345726eds.18
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 01:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxDKaysG/aHQwlTNKh0Nbuao0YTQ8x2bzMWqPvbdZ6o=;
        b=Jgp68uScv1It6eNtSYkqrAlAcIkLFROZvoOXO0OJUWKMk4Zv9M/NH0LeeJ9iVLdtIJ
         N0q7By6QO2KsGvLQBNAKugoD3Wrc876c8JdlpWIjzrVyTtdXMkzHQNTVqKCOgbXTPuqr
         iKuvw7VFn1H3yeEHx14j4XqHH7LjXIudtqkQd0m9t+xH55dweOzgOAJUYhDPRWzZN8xf
         PY05JcUSSQ9qGSaoiGDKMPgr79o1C/GSp6yTW8xK6JubLmkm9m3hU/mSfZGvT5TYPG/t
         yYzBga6Igun5sz7Cyzd36p8zx7H/4xUvfxeAWBKAx3FtJcLjzkLZJgDhlgeKMLyFCOII
         kANg==
X-Gm-Message-State: AOAM532/QkyjGH7gM1etgUCnXK7EtFGYevhh2KuMebrtLrGvcsXQsRjG
        87VZad9OvEWLMGy2aZnmBVZO1URac1nFjNlTEa4XFBP8ibJm6j7w7zgwl+yZwVP6+8qWJTTF2yj
        6u89gKsuY6PMg6DDePkEYa9Fe6iVBQmKBYw75
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr15003421ejb.110.1629102475754;
        Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+BOVdere6Fu0M0Ic4QLSp/IuflMOckAgBI2uLtSkJ1OUJq6KxP3xK5gCoc2lA1BHWOYxnbQ==
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr15003404ejb.110.1629102475630;
        Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ay20sm4469605edb.91.2021.08.16.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] power: supply: max17042: handle fails of reading status register
Date:   Mon, 16 Aug 2021 10:27:14 +0200
Message-Id: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reading status register can fail in the interrupt handler.  In such
case, the regmap_read() will not store anything useful under passed
'val' variable and random stack value will be used to determine type of
interrupt.

Handle the regmap_read() failure to avoid handling interrupt type and
triggering changed power supply event based on random stack value.

Fixes: 39e7213edc4f ("max17042_battery: Support regmap to access device's registers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index ce2041b30a06..858ae97600d4 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -869,8 +869,12 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 {
 	struct max17042_chip *chip = dev;
 	u32 val;
+	int ret;
+
+	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	if (ret)
+		return IRQ_HANDLED;
 
-	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if ((val & STATUS_INTR_SOCMIN_BIT) ||
 		(val & STATUS_INTR_SOCMAX_BIT)) {
 		dev_info(&chip->client->dev, "SOC threshold INTR\n");
-- 
2.30.2

