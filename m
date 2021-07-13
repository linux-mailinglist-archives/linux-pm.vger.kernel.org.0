Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250173C733B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhGMPcO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhGMPcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 11:32:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4222C0613DD
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u13so11745793lfs.11
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5q425n9ymaCPEVjgvM4iZ7bBThsuqoFN+1RD50teW8U=;
        b=Tj4sP0+yN7IDleqAJWiIE+R0oM1P/yFTSj7PX1wzUikRSNh1pLiGrHlKTQOvICSmXg
         FATMYvrz9cTVpUJ+9YWpvkjG32c9oX5X5EMNNZOVKDh72DnWRM8CxA8xQlnqf+M8EKrB
         Pl9H47gn0B+HDbBOC7EYWQEZQoaEBn2v07V6LpZlcaeOP7QIVRY1ou+ol3HGVy7f8gq5
         tT5A5l+5u1N6+SjgFcM0xaUqEw7cSLzr/NQk8VPNhBWrVadO/6bEun82GI31aboUly0E
         3ftcrbsB1Ss9MJUdZjKIrng932/HgkS93Lg+BDc2b9ZRgvdluoRMaCFUgXY8T4QbN/oX
         yHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5q425n9ymaCPEVjgvM4iZ7bBThsuqoFN+1RD50teW8U=;
        b=J6MXajVyynJk1qVPG106CwPafcGN25wh8/uDJ46nCCWEsE8SBHd9cL7avD0kpnrcuZ
         p+3zjH6zvIygE6FrsDybXeYmP194lc1Br6W3ObaEzkh+RKpitmbHCXOZRKI4QGPnskNU
         zlAJM91UpxK4FjxtjS8uicsDGeXY0n0By+jmsDmTpCe1rPqCwJpbmonvB6VYxYi3mWib
         RGY0a9KdxiYAimxyERvcL1ApHdqKaohJUWzOIUZxmSCGnkVysnj/nH919XXd6zy9Lq4c
         wXxkL5w7Sa4LNu7HiDZkfUG6cSWk8Jx33Qp/2P60kCEUMjpzTZCa0r76pDJZjIjhOof7
         Utvw==
X-Gm-Message-State: AOAM531mdxnu7/vZXtgROZlXmqiH11FFlszpBRc27ogsAYm/1aqmikPg
        pOJI0ZdoB4bW7ODYsjnbPEtjsg==
X-Google-Smtp-Source: ABdhPJwu0JD8zae5qRb2u/MFlQnpQpfYVml4DDbvxXBr0xG/6AeY2ErUlUAwhCmVSCk7fmBDOppTpg==
X-Received: by 2002:ac2:4da5:: with SMTP id h5mr3906366lfe.239.1626190161296;
        Tue, 13 Jul 2021 08:29:21 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d8sm827395ljg.86.2021.07.13.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:29:20 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] power: supply: ab8500: Rename charging algorithm psy
Date:   Tue, 13 Jul 2021 17:27:08 +0200
Message-Id: <20210713152709.871833-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713152709.871833-1-linus.walleij@linaro.org>
References: <20210713152709.871833-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we rename the "abx500_chargalg" supply to "ab8500_chargalg"
as it should be named, the existing supplies are supplying that
supply but that was obviously not working since it had the
wrong name.

Now that the dependency kicks in we get a bunch
of NULL references from ab8500_chargalg_external_power_changed()
so check that the workqueue is allocated before we try to
queue work on it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_chargalg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 8dd66eb18fd5..4ef34f64e9c0 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1275,7 +1275,8 @@ static void ab8500_chargalg_external_power_changed(struct power_supply *psy)
 	 * Trigger execution of the algorithm instantly and read
 	 * all power_supply properties there instead
 	 */
-	queue_work(di->chargalg_wq, &di->chargalg_work);
+	if (di->chargalg_wq)
+		queue_work(di->chargalg_wq, &di->chargalg_work);
 }
 
 /**
@@ -1949,7 +1950,7 @@ static char *supply_interface[] = {
 };
 
 static const struct power_supply_desc ab8500_chargalg_desc = {
-	.name			= "abx500_chargalg",
+	.name			= "ab8500_chargalg",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.properties		= ab8500_chargalg_props,
 	.num_properties		= ARRAY_SIZE(ab8500_chargalg_props),
-- 
2.31.1

