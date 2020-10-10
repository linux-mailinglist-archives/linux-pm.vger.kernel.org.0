Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D289EC0
	for <lists+linux-pm@lfdr.de>; Sat, 10 Oct 2020 08:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgJJG4D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Oct 2020 02:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgJJGzt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Oct 2020 02:55:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8BC0613CF;
        Fri,  9 Oct 2020 23:55:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u21so16263961eja.2;
        Fri, 09 Oct 2020 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+UaYBmG6QYTuuQvyVH4FZK0dvrXTjPLq4147N3N0R0=;
        b=hM92vKB2P3oKkzy0rP8iaW5jGAI+dLc4MXcm7wk7/R5PJAXGRmNpEwwypesQTCuyoG
         6waZ3CdomQtPoYFIMretQdXNLJzLyLcxKtRs+aZ0Xb89bxQOtM8TrPC2nwqIszj5MnqT
         ZbALvZfRI0hfY7Qnv3GbNs1ei+TncQWnuL+SvAi1CvT7LKrH6tlJVaUBVCHHh4QsPtJz
         nXrVojE11swRWj3mWbN8kXbZ12hed+5gijO2figaY2iNBF0Jtd4MM705ixQkO212+D2K
         OHkGBYAm5KV8dOOCG+Tb3VUaXCf5qietX5HJHG3nkRI7wXroCrBFniMIbLzHeBS4csVE
         eONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+UaYBmG6QYTuuQvyVH4FZK0dvrXTjPLq4147N3N0R0=;
        b=nfVyNFN9VHW+1KCgR0CdQK6FS/PYTeaqhksAY6//VfD7ZarMcDb1KAr4Lz9xo6FppE
         v0BdMT2Sn8RgcUwZUxG/7nTh0gGXyZ4PKf04xoctO6dIsksXBawReGKnsChp0MSZogag
         rY4eDCk9jLlrF/RBxcils46OavPuw+ZM70D6BFuFkbLfbQo6YncU/ZaNP86KHrotQNFS
         FLxTjCG9RFDUEMj6GxiLRy8ytIN8Ym5WlPHlzEWGgZfKxbSOIrCgTkxF/jWz5SacddiC
         lyULZWBbEAqLnG58kNrv4s115PXYUJqqkjNaK/5M9ScEknLO0eo/icyE4JJibG3kI6GJ
         brug==
X-Gm-Message-State: AOAM531jrd4pey+yLUM6CWVPbL/tdseE73D6Rr+opZ0wvGBMAJ7xkRjx
        bjBF0zEfs9f9JYpv/jIlSPw=
X-Google-Smtp-Source: ABdhPJwwyrV4a4dzIqmCetFfyccLCe+JBc6nYT4k/y4gl5LS33u093R5QSHGsuTyRO+3izvxlC5HqA==
X-Received: by 2002:a17:906:b004:: with SMTP id v4mr18958102ejy.156.1602312947303;
        Fri, 09 Oct 2020 23:55:47 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id g9sm7540825ejz.23.2020.10.09.23.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 23:55:46 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH] power: supply: ltc2941: Fix ptr to enum cast
Date:   Sat, 10 Oct 2020 09:55:26 +0300
Message-Id: <20201010065526.2466583-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

clang complains about casting pointers to smaller enum types.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 30a9014b2f95e..10cd617516ec2 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -473,7 +473,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 
 	np = of_node_get(client->dev.of_node);
 
-	info->id = (enum ltc294x_id)of_device_get_match_data(&client->dev);
+	info->id = (enum ltc294x_id) (uintptr_t) of_device_get_match_data(
+							&client->dev);
 	info->supply_desc.name = np->name;
 
 	/* r_sense can be negative, when sense+ is connected to the battery

base-commit: 411643e949f4e616f758e2c6079f333b0e704c49
-- 
2.28.0

