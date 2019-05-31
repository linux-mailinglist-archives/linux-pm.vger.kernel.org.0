Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B291B3061A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEaBQ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 21:16:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39842 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEaBQ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 21:16:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so5072507pfe.6;
        Thu, 30 May 2019 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkXZr4gT4mBUwoanTukqm6IXAK3o1gCJNcNnJlAMMm4=;
        b=h2xvqJcOF8uE6auLZkxTC0EhAuzhcd5262Jhn1jnrUcCrNS+gfAVIURW17Og1J7dwT
         +37coHGSd2AzXdW/z8M+fdA1eYX8RV4/ctssgWkxOpHwuKeB1icmWh1PuI7lB++mjM99
         7yqz2jwp3HP6CxeoTbdiLR3c8aQIf25RxRahQ7lW0KG+AKGabmSlLyjiIQGthH/Z547F
         juY+6Aoxfx6EZTbJPTVsg5tJDsUuH7UFnMgUGDL0phxPNn9xloSXUujGYS87uFzA6DCZ
         NyrLg6kNY/3KzBnApb32BTOeISVg7J5i/d5iUDSVJJdFPym8CMTMNyEXNy0NttzZDSof
         M5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkXZr4gT4mBUwoanTukqm6IXAK3o1gCJNcNnJlAMMm4=;
        b=Z5oE678fLWegvxgPDIdwXF//Lx+U8rErKh+/i+fEe1YTclEJ8Abe+pcfRBvHCOSblu
         pa4AeZvtDEg6UcWu3vKjRKECm5zrBn8tokPnwHmzZ9f9+4oQYFifC0SOTe6/rpD2m1/U
         KJeJhSvUZAVqMkomCVY1ztG41vSoGw2H24w4wbXPQZGOz0lApzLGT+H7WZPpUWlwAwne
         Y3Lpi7YinUR+4/9X9rc9pSMSudNfFQnDPagCCPiLg+dvj1kczUnaavTbUZsXUEFjpHR3
         IzvV33lAOO5Mwi47LWfL1YhgkU8bYYMPMkYBx3Zb0dOy1vwtLGPtEoe/RT4u3rzmqBKg
         X1cQ==
X-Gm-Message-State: APjAAAXDv4asU9xGepiYeTVq60G33an5VvVh4UcaZfqWGLkBKp8HSHEn
        MQzz2c/wBwQBHMq81V+VIQ4xlJerDIo=
X-Google-Smtp-Source: APXvYqx/2G+SnCGOuiJy/UIyLCLuatwBaN5PI8MEL1r7ABivjbAmwKrVcgL9EXf3zDmKAl6RCmAGhA==
X-Received: by 2002:a63:f402:: with SMTP id g2mr2992989pgi.197.1559265415541;
        Thu, 30 May 2019 18:16:55 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v93sm3807335pjb.6.2019.05.30.18.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 18:16:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] power: supply: ucs1002: Add HWMON interface
Date:   Thu, 30 May 2019 18:16:20 -0700
Message-Id: <20190531011620.9383-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531011620.9383-1-andrew.smirnov@gmail.com>
References: <20190531011620.9383-1-andrew.smirnov@gmail.com>
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
 drivers/power/supply/ucs1002_power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 1c89d030c045..ebe84f1ca42f 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret = devm_power_supply_add_hwmon_sysfs(info->charger);
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

