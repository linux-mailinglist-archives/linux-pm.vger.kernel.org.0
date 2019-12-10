Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7049511846F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLJKI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 05:08:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45266 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfLJKI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 05:08:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so19267184wrj.12
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmXraLxcHSpW35myu7I+B9nstgq5MxK4V2VimsmMd8Q=;
        b=vmvwmGEPJaOfpVKMoAgpHwHqH4DSZ1j/trCMbExQ9xzY7fEc8MS71UlD/1JVFPgsWZ
         eRnqvF9UeBzTz6JnU/C/H/o8uwNN8vNOD9ywUFJSqgBOfNZ1hcnaymzmzdeRd5xP7PUu
         SZFChz+Ig08dPyNYi3sLXiO8Vr7sQAKi/F1YI3QSccR6jy9ccSJCCRqgrSPEgRs292I9
         7V8opH/42799pk0/tj+I1JkkrZQwgSvxPJNcQMb22jgUbq2KTvDg1du8saN5Pz4evSg2
         FaYnpXmykU+u9Wirep/HHn5hHlFGG7M0iW8YD9ZgbpvVSdcfCkam2RZzv+sK57/iIdGr
         NYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmXraLxcHSpW35myu7I+B9nstgq5MxK4V2VimsmMd8Q=;
        b=FySGHY/CJfNHY031sEaiCswybHqOt2Oyweylrh9OsZlSPJzkAvLaK2F5/NbgpJxz8g
         hn7gExa3FNhwKiGdoUz4aIAK7CjcaD35xip90AfXED7haW3Z6Mnt6R4WuUPFpXx3UfV0
         Upw1rGRAmk385O49NNx6lT3lmtXrIzsBBoX5gxQaUVQT/cldqW6TPhs5+6uffcv4Jabg
         PuLZqb6+W9a7+w1YRRSokDZvX5uQ6zeeA0JMhisEmOyEtmslym/m/dYc8sizWSWLEkds
         YyUj3Qpdy/rPJjmqV4yTD1wIbplJ8Z9l9FPmzhiI2JVLIspNc/8sUV8n8r9rCftUdl8V
         KrWw==
X-Gm-Message-State: APjAAAWmNKHajF57gkJ/5SJbuQgDqKafYVHfL5r/Ci/uVmBTYZOY3cBT
        JEBUyplfnmoZEP7qQnZquqIjlw==
X-Google-Smtp-Source: APXvYqxXggVqtg2wLF1aAKh1TnH7Vc3phZwAUgHw1rAwoN2bqO5sh1FHO27U1ggc2547SbjFzD9jrg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr2234029wrq.176.1575972537067;
        Tue, 10 Dec 2019 02:08:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k13sm2642109wrx.59.2019.12.10.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:08:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] power: supply: max77650: add of_match table
Date:   Tue, 10 Dec 2019 11:08:55 +0100
Message-Id: <20191210100855.11252-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the charger driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/power/supply/max77650-charger.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index 5f9477c5cf5a..d913428bedc0 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -354,9 +354,16 @@ static int max77650_charger_remove(struct platform_device *pdev)
 	return max77650_charger_disable(chg);
 }
 
+static const struct of_device_id max77650_charger_of_match[] = {
+	{ .compatible = "maxim,max77650-charger" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_charger_of_match);
+
 static struct platform_driver max77650_charger_driver = {
 	.driver = {
 		.name = "max77650-charger",
+		.of_match_table = max77650_charger_of_match,
 	},
 	.probe = max77650_charger_probe,
 	.remove = max77650_charger_remove,
-- 
2.23.0

