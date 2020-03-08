Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BA17D68C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCHVwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 17:52:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42199 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHVws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2020 17:52:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so6031986lfe.9;
        Sun, 08 Mar 2020 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfPInF29HyA+ns2MPE9iODlTeIAJJSC5Tqib3KT01eM=;
        b=MLC8yrSnJQEZ/PT1RSVAxboE1gfXel4xvUY7foQIRA7mC9QC3k8ty525GvFN8YrYJB
         +iGtnyky/puZI+uJcT6bWLlkk0Hi9UmRkxuwtT8eci/1rP9bRzKFR6I8AVluhrqZYnp0
         wj6k3wMF8ajc/f916NJ6G3H5RUj+g3l1tDZK7rBlygw2LwdhtI+WmOpYJusgHRa11EJ8
         VzxIxD+zJcYhcq4mxB9Mb4K4e91K1DeKyrZ8eJpVJCX1+9p2qYLzSqde9EqURNWABrNG
         6RKGFdqw2hLlGkIIGV0gmM6KfwlqXQRMz5GIznXvcDkvEWHPcqTuh3jx5rE5Q9t3kpWD
         5AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfPInF29HyA+ns2MPE9iODlTeIAJJSC5Tqib3KT01eM=;
        b=MYPTMKKqZ5ezTwQ3rJmTHIaC4LLhEJwe+QJOYVesZv6vrUpAn0niAjUcrO+QBt6CNI
         VaShhwZBwxBB8W5xGGRnAqqHR0W7f87dMPopqq+zoApNeCu2porWgBAoqFq+4m6D+19R
         DOTbly3wJYM5C8Z9C0xk5ptBPCZfUTNdmrFqcc22By3RGsO28zHnAl5mJQ5i0bwk5Wb2
         uryoJKGrEnBWPblCF81qM08QojqDCL0aW9P+xwZdqzh9XuZTz3j58YJ3lGYJIkWwWFKm
         1U9ihPFGzh+3Y5GR3cw99Mn4K+WVsiepupb1/GD2sU/c+N1Hetj119pSSKCeQd71fiUI
         5QfQ==
X-Gm-Message-State: ANhLgQ03yBiM2Y8GWyPpPUpOn/D/ry3q0iIZkLHWXPrLliEJAGbqJ1d0
        Ih35ERmQ336yWzLBc61xRY0=
X-Google-Smtp-Source: ADFU+vs4ORZYGJJG2HHeQFEH4DyLn8GTv8J+rLm2mAC6rJn8Whn+qjkuzVXKrAk47AiglMi9qUERTg==
X-Received: by 2002:ac2:4a84:: with SMTP id l4mr7452588lfp.217.1583704366401;
        Sun, 08 Mar 2020 14:52:46 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id x11sm19001540ljj.47.2020.03.08.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 14:52:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] power: supply: bq27xxx_battery: Silence deferred-probe error
Date:   Mon,  9 Mar 2020 00:51:43 +0300
Message-Id: <20200308215143.27823-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver fails to probe with -EPROBE_DEFER if battery's power supply
(charger driver) isn't ready yet and this results in a bit noisy error
message in KMSG during kernel's boot up. Let's silence the harmless
error message.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 195c18c2f426..664e50103eaa 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1885,7 +1885,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
-		dev_err(di->dev, "failed to register battery\n");
+		if (PTR_ERR(di->bat) == -EPROBE_DEFER)
+			dev_dbg(di->dev, "failed to register battery, deferring probe\n");
+		else
+			dev_err(di->dev, "failed to register battery\n");
 		return PTR_ERR(di->bat);
 	}
 
-- 
2.25.1

