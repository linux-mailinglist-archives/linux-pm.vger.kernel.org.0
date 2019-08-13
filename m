Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2B8AFBB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 08:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHMGOQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 02:14:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52970 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHMGOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 02:14:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id o4so224778wmh.2;
        Mon, 12 Aug 2019 23:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NFIR6vEfj3gA0CnIitinJSZgtITiQcl6bTsQTiuKALU=;
        b=KWK1Sy9Ts2FXGxgQlrv3AvCMOV2JC9owCMokSL6x7UBu44jQKSd1KeN4K0hl9yswyw
         R7OmXQHMtZLa1AZ+tn6Y4LsUfQT0cv65YgK2qhIRq7WuUdgLpoJCA9zrkGWj0OI9dSru
         jB9V3x4ySzVqrNoiTlzVzno51VW4uI4DAkzmHMt9kZCBuniWrwe55aKRIwTR2tsrEEa3
         R5rH509P56vw8ryIa43Bsh/W5Uep/ZioFom4kPRMg4FDUb/ww0G5ygOw40hDYOcaDitB
         UW8wjBaApmPHFHb2HM9sOKXyN8QGX2RNnTw5wVUsh4TSKuW53rKEf8h8gzhrcWgRTVbS
         Pc0A==
X-Gm-Message-State: APjAAAWYfY+r5p6gCUIrSDN3YbOsqOexaGN5dxkBZ+hY7XOza9SnmNw0
        1YVuo5cuyorINAcRTLIJEqmzb2WkDYg=
X-Google-Smtp-Source: APXvYqwtuzf2pJT5SNEvIvakyWSBZqxPQCHB6nYLyG5IJDWyiBi5dxanS5jR/bkwq6RPe8sWIlsdqQ==
X-Received: by 2002:a05:600c:214c:: with SMTP id v12mr1107560wml.28.1565676853616;
        Mon, 12 Aug 2019 23:14:13 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id s64sm667402wmf.16.2019.08.12.23.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:14:13 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: N900: Remove isp1704_charger.h record
Date:   Tue, 13 Aug 2019 09:13:58 +0300
Message-Id: <20190813061358.17223-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325212737.27322-1-joe@perches.com>
References: <20190325212737.27322-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update MAINTAINERS to reflect that isp1704_charger.h file was removed.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org
Fixes: f5d782d46aa5 ("power: supply: isp1704: switch to gpiod API")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29514fc19b01..2776e0797ae3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11400,7 +11400,6 @@ NOKIA N900 POWER SUPPLY DRIVERS
 R:	Pali Rohár <pali.rohar@gmail.com>
 F:	include/linux/power/bq2415x_charger.h
 F:	include/linux/power/bq27xxx_battery.h
-F:	include/linux/power/isp1704_charger.h
 F:	drivers/power/supply/bq2415x_charger.c
 F:	drivers/power/supply/bq27xxx_battery.c
 F:	drivers/power/supply/bq27xxx_battery_i2c.c
-- 
2.21.0

