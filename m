Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F256932E58B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 11:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEKBP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 05:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCEKBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 05:01:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B2C061574
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 02:01:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v5so2561949lft.13
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 02:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBTu7vmXsav5wd+6KRVkYdgBe5MwHbNbHuTYnq2On9k=;
        b=QUcHgL2sprTHVHUULWMBA0DY+ndZxZXsRl/oILgkXahRJt60L4jhvSDDGJqUxEa/yV
         2v94/eLpB+qmybeIc6eEzjsENv68lB+PTCfEohlgRtqHlaJ61/OUnYfhqAiSackNHjD9
         IZkG3wF8OV2Nat1pxVelL+BBzrsmUUenm2T6QLHuVkZ9x2h/ezQnfrC7dIKIsayN+aPv
         Mr6oY/7CE+61RwFcdtII6Od+pupQyNhGSrxwgR9prCtsYpShJo27ophOo565ZGsVyZ/o
         UO3hUqRICuK6GK8ACGF+nnXjabwvbwSdzD8Y9DF2miX+C5+KwGP9Kv+U7sVLuFwlzKNZ
         xsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBTu7vmXsav5wd+6KRVkYdgBe5MwHbNbHuTYnq2On9k=;
        b=QHIBBEHjU96azLln2lvSgrYcNm1cB2yxFQmEhRuvAeZlnvJaGsIQbUr9s9wPmw7qGy
         50Gk+RFkLC16kqkn3OaQVix7OpsmRzsLILTAmKRvgBg4ywpZZmVvLFm2NDs3gkT7g7R4
         idARF8nslK9HgZ7f4KNFidKta+hIUkRfwAe3J/w/RrsrwEyNOmnCmo7ZAqBaejVeejJ/
         GOXl6AinpnoUZYYDZpZjCGy50GqzEh2xMzlOdA4sRRDC977+gAGS6ChwSrkmPj1fM6AH
         U9T62Im39QowSH48E1nLPozHjqegdlva+z+g5VrsDqV92GRVTZm7fVSm3iY/9p+ERYCX
         Ni8g==
X-Gm-Message-State: AOAM530zqdLPGNGFQLqq23vozTMtluXM64gXQSa9rMw+3aF6a3k9Kh1m
        ZHssgnur2Mh1Xdc3QUIsg9mxuNvB5MTvfQJN
X-Google-Smtp-Source: ABdhPJy9ew15APujEepj9KNiq34S9EaszC6ByhByjeOp55r/Tcv5pH4E0/lvRMC9MTF0yRaPx7lJvw==
X-Received: by 2002:a19:7413:: with SMTP id v19mr5102239lfe.228.1614938472409;
        Fri, 05 Mar 2021 02:01:12 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id q17sm242432lfu.108.2021.03.05.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 02:01:12 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: z2_battery: Drop unused variable
Date:   Fri,  5 Mar 2021 11:01:08 +0100
Message-Id: <20210305100108.2036203-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The kernel test robot reports an unused variable in the
Z2 battery code caused by a recent commit.

Fixes: a3b4388ea19b ("power: supply: z2_battery: Convert to GPIO descriptors")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/z2_battery.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/z2_battery.c b/drivers/power/supply/z2_battery.c
index b1508fe70e5e..7ed4e4bb26ec 100644
--- a/drivers/power/supply/z2_battery.c
+++ b/drivers/power/supply/z2_battery.c
@@ -90,9 +90,6 @@ static void z2_batt_ext_power_changed(struct power_supply *batt_ps)
 static void z2_batt_update(struct z2_charger *charger)
 {
 	int old_status = charger->bat_status;
-	struct z2_battery_info *info;
-
-	info = charger->info;
 
 	mutex_lock(&charger->work_lock);
 
-- 
2.29.2

