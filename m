Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C42256FD5
	for <lists+linux-pm@lfdr.de>; Sun, 30 Aug 2020 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgH3SzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Aug 2020 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgH3SzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Aug 2020 14:55:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA45C061573;
        Sun, 30 Aug 2020 11:55:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so4236351ljc.10;
        Sun, 30 Aug 2020 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfkugI/LH5e/fdWRheFGhtoVkFSs2RbzC3QtJXx//30=;
        b=eSLpIkR4N6ywW9V7JdCundGyX+rsmoIUbuxQemwY84A+Nd67XcTfTg0OQkdoi9DaH3
         PiX3MSSoS0lgV/zRFQlsRp3Y7OL1wGrZqPLgYYDNdRKW0VkE6PFTqUo3c4hW2goqotcQ
         Xanmi5x43qhTJLRPWjbf0+VnCbselVkfPxEKX7odWzjr46yFG4uI98s5L+1n3H+aRUzu
         6PUBbK1Rp5u8N7xGRyifGK9eqK+Hwdx0otSUyYydn0Hp52HqOSoAfJ3rnnkGtgFoH0Ny
         Iw7B7fKkIkM0Z6KXX0F0Zz8Mm90Mch0Usi8h9d9vx4UajR3+Qqb9e6KquIkVQ4DwTnpA
         uGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfkugI/LH5e/fdWRheFGhtoVkFSs2RbzC3QtJXx//30=;
        b=HMlpCvaSPGYEe+SUHrgLLJUysn1VlUoea6IPhlxMwqmd5bwDH16e604Mkpu25NT80h
         +IkFBEzGPpFwmRjZQPACJlx+g5fc4ZHU5kdJuFlkewt6jwcvLu6O8jGPFjFHQIWRFeVa
         rMQ6RumPdFLUOfYvbtj7uvF579/jFonydTiZsXjZDtoaybKA9cPc04Y25lfVUMjf8lMd
         pyNZAKoUezRMwPOLETExSzgQM4uG6sASYrUcicA45F/YpSMUrDsg4qjD10VVtMFtwE5k
         P3dnFPAN6g/13H+JX5jU0b6Z2Ra3MRFHM/B/7oKUqz9yaLC0Ekhj0ri7EllR30THug0F
         gU7Q==
X-Gm-Message-State: AOAM532BujqQmHYiIVBwBa2Kw2N/2aLc5wnZUeWcHC4oUHq4IduyPLBK
        LF8MmE7lLZyrHwEOzNCMkU8=
X-Google-Smtp-Source: ABdhPJyTua/0i+etpjIH7cfPsBa9xJiXpna9WtQiXng9CI46B2MDoc8yOJ7cUtJGuciz0gKzZCs5Dg==
X-Received: by 2002:a2e:895a:: with SMTP id b26mr860324ljk.468.1598813704457;
        Sun, 30 Aug 2020 11:55:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n21sm21630ljc.89.2020.08.30.11.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:55:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] regmap: Use flexible sleep
Date:   Sun, 30 Aug 2020 21:53:52 +0300
Message-Id: <20200830185356.5365-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200830185356.5365-1-digetx@gmail.com>
References: <20200830185356.5365-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The multi-reg write function uses udelay(), which is a busy-loop based
delaying function that is not suitable for a long delays. Hence let's
replace the udelay() with fsleep(), which is flexible sleep function that
selects best delay function based on the delay-time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index e93700af7e6e..a417cb1a11dc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2231,7 +2231,7 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
 					return ret;
 
 				if (regs[i].delay_us)
-					udelay(regs[i].delay_us);
+					fsleep(regs[i].delay_us);
 
 				base += n;
 				n = 0;
@@ -2268,7 +2268,7 @@ static int _regmap_multi_reg_write(struct regmap *map,
 				return ret;
 
 			if (regs[i].delay_us)
-				udelay(regs[i].delay_us);
+				fsleep(regs[i].delay_us);
 		}
 		return 0;
 	}
-- 
2.27.0

