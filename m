Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEA2CF899
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 02:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgLEB0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 20:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgLEB0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 20:26:19 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7210C0613D1;
        Fri,  4 Dec 2020 17:25:38 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id p21so4596066pjv.0;
        Fri, 04 Dec 2020 17:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/qs0KrUGn0HCwSUP9qTJw2ZweL4QHDPihwqXZL4hgU=;
        b=AVcstja1ZuPPKucB5nij/cu4ed/ZhaXc/1wddhL0KbZoaRbunSLvhgtGGjf/S41IR8
         Zip0xONb3cYPZhuN/oApgsGTNvhkoOtm/LVaD+KvGQ7ES/R8aM/JqzcZSDH7RLLvJ9ED
         Un3a30B1qd7JhaIhD0PZJ2aIgAdFh7CU4rSqIiQbq7/uKRla0wBVKRB7V8tac4xAgm3P
         CenahyNoRbyvNlJTVNshIXp1NkIWMVukDdqqVX0rObR7OwlOoM8W3JTJgvACTyxdWmis
         oDZhqUMpJp++oQaKR4zIrCjjC0JMXzxL17YAiPcMzu9ZT6WkQNcQS2DUUDWLbFExoGGV
         9b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/qs0KrUGn0HCwSUP9qTJw2ZweL4QHDPihwqXZL4hgU=;
        b=GN14X3WZldbINsniHtNkvDhUUJrk6QJJ5b+ypAiq+Aee/gb4yvAuKwsjYcU8b4ToI4
         l1sPelHIM8J0CnM+QwjblLtasoXnSMSx/VUsTbVK3QfzY7L/aQbnKa110fAvz5A0+BU6
         U70DtEYa9F/6jrorZ+gm5Yiow4Iw3HJPBJWNv0VSDHf5Ozv26bMfFIhcbhmvoeg18KVc
         P5kVTKkfUMPZqeeIqRPxS5wzYpI8OqWTRdheuuBAQyQ/bLoY1bmT57wwzXukGW4FcJM2
         f1ZHX9CKFmP8YIFB3NmEkzqJlRt15M5In6wUN8sIH0nl8lm8nwR7beYrFpt48Bdhww+h
         X14A==
X-Gm-Message-State: AOAM531DXXHUIACc4/z2cGxRNAyAV08+ek7lyBzqAFk3b7x0HlJpqfyS
        2GczdeP8go9Mjh3U5TnJ+z8=
X-Google-Smtp-Source: ABdhPJxZLHd2KbqVbaEFUxWXsulEuMvZwa02EPeBAZx1L8JLJHE5/37+gO+iI7XlFw9eb8eEOXdT2Q==
X-Received: by 2002:a17:90a:d586:: with SMTP id v6mr6627717pju.103.1607131538460;
        Fri, 04 Dec 2020 17:25:38 -0800 (PST)
Received: from masabert (oki-109-236-4-100.jptransit.net. [109.236.4.100])
        by smtp.gmail.com with ESMTPSA id q23sm6207399pfg.18.2020.12.04.17.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 17:25:37 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id 4910023603B2; Sat,  5 Dec 2020 10:25:36 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] power: supply: Fix a typo in warning message
Date:   Sat,  5 Dec 2020 10:25:32 +0900
Message-Id: <20201205012532.1196962-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch fix a warning messages in power_supply_sysfs.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index a616b9d8f43c..92dd63171193 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -402,7 +402,7 @@ void power_supply_init_attrs(struct device_type *dev_type)
 		struct device_attribute *attr;
 
 		if (!power_supply_attrs[i].prop_name) {
-			pr_warn("%s: Property %d skipped because is is missing from power_supply_attrs\n",
+			pr_warn("%s: Property %d skipped because it is missing from power_supply_attrs\n",
 				__func__, i);
 			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
 		} else {
-- 
2.25.0

