Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAE3018B0
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWWUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbhAWWUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:42 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF5C061351
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:34 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id i17so10808777ljn.1
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28GEYQroX9iLNa89d1Np8JOfxiq6yVf6jznvYobgB2M=;
        b=BTxKVf6x9tkaiDII85SLMqC5J5Az/1TLxrjxydQ9GYNYmCdAGFiQBXTYte9V+OI+fy
         9VdGs9TcBDAhxJ+5D6nzq3iowB2hV6IjdlKjQIoKWaEGHoAf6Risro8n4rOdXMZz9zQs
         p7sD2juSc/O5lXj9GhHNuIYTgb7hw8izL0jYddJgX0YVNNFCiPC35jm8pbTTE1OU/bga
         1GvwRehRyqhAJ46geb/JXng9QBp7u3ZAmA1qi9eGeNf55tcLauECnM7qd+l6S2fAEmb3
         HK1/Vf0Djs3SfJ+JKD9YuWpdqe67KuYsEi+8Ictd7Yy6HNvS6t1AamrklqMe+3CIFqd0
         C0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28GEYQroX9iLNa89d1Np8JOfxiq6yVf6jznvYobgB2M=;
        b=mV5m2w9JvyUpbN8nkyoWq4qCUr451z8UtURr474xVMmmO8be1Hk9yp/5QLe61MLfBC
         sp+ILkXvpQID07PAuSocyfFwE4dw6bzv/FpEICeo3r1YgDGQV43JBBVuzlDuNcXCY9R+
         GSHBYOnyKk9+XZZV0Moe3vRrm8Jgx7m/CZ815JHW/cp6eNzYruiQJplmQMhyeBFC/81R
         1vrpLp6AX0uyCtLmrIQBuwNjPLKRvl8y6NvtsKaOgPkr/s8aKa9/gtuLDDOZk08FIyEL
         l+5Datcfr7ypE6SZNeAaesBsqQKa6u9ErysZ7e9TSLGyyfGx8kRNVmSCrL/ETiptGCbU
         gN3Q==
X-Gm-Message-State: AOAM531e6mZzzatvmwa19r8EEn4huBKLG36Yjm0X1W7hQ4Y7EI5FYMWP
        OcbCmeFjqQsE5yuYpoh5Gl6BvA==
X-Google-Smtp-Source: ABdhPJzrX/E156+ihZTDkdj+SOsFEjBxHYml34brLEdq3p867NJrbRZJbDAdt1buQv6qxH7p/y7UDw==
X-Received: by 2002:a2e:3201:: with SMTP id y1mr1442981ljy.12.1611440372881;
        Sat, 23 Jan 2021 14:19:32 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/10] power: supply: ab8500_bmdata: Use standard phandle
Date:   Sat, 23 Jan 2021 23:19:08 +0100
Message-Id: <20210123221908.2993388-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Look up the battery using the "monitored-battery" phandle
as is nowadays a standard DT binding. The actual bindings
for these charger elements are not upstream so let's sort
out this mess by conforming to the standard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_bmdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index c2b8c0bb77e2..258f399eaf37 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -499,8 +499,7 @@ int ab8500_bm_of_probe(struct device *dev,
 	const char *btech;
 	int i;
 
-	/* get phandle to 'battery-info' node */
-	battery_node = of_parse_phandle(np, "battery", 0);
+	battery_node = of_parse_phandle(np, "monitored-battery", 0);
 	if (!battery_node) {
 		dev_err(dev, "battery node or reference missing\n");
 		return -EINVAL;
-- 
2.29.2

