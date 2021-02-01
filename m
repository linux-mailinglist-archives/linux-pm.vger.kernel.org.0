Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45130A17F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 06:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhBAFh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 00:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhBAF0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 00:26:18 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CACC061794
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2021 21:26:00 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o16so11287055pgg.5
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2021 21:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91o0myz+OYjbq2S4/NdrE8Isv+oJfr2OuqWuu9fDksw=;
        b=N2xMkSOUSAc+oT9FQfwpQA7uPggfFo3pOTROUEvkANVwa4TGZKn35uTePU6O4h170e
         enucBKq6/cNO/7kddk8PCsI3jof1d3JzeY+lMUjhPchI16p8QKT7EzZZhs8ojH816dYU
         FAIGbPl5+fvB2CcaQsHM04t621XCTiHlq0qsw1gOO4cocgd/4+AafFrqXrMmvARmxlE+
         agQCra2fX0Lzkzv9hR6L0P2lqjDM9RSVmk7d5+vI/FaiOeYRBrtImtwfTI+yavPlE4iy
         VVCRAaeBJMjaN3BdWYz5gQBu3awpTpY5DTikwmtKeDmScxkDuXxdcaZAHKnCTq+pa2h8
         ws1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91o0myz+OYjbq2S4/NdrE8Isv+oJfr2OuqWuu9fDksw=;
        b=sBznjE6DNU9aKxgaHUH2CDg4Iy7r/nwZbgr4vrGkQ9CZs6aVu6njgSFF1C1zJWYs4I
         UydYqbFb08ySz8P+OxrEu1ZJCjeJVXRwsx7sFLfBlSulJ8kJdp+l7VTeoi+HRSB4gwzu
         /r7ZvJ7JqL+pUX5/NN6mSLi1MWnDBrr8dELTc6DicXq0dMYGUM4I5NusCuoS+Z7/KOQq
         UsDal3akXW7y8pY16n6UJ+Vi6Pdf6veencHqBQgZJE3CLZhcSxDhGvN2Moj0sjzyquRT
         wav9MiDvarmpH6n+dVji/qWgCbLYNIZAFK6jJHhfXM1fNgWQk/G/TrrzoOuBCLv9E+gc
         RSyw==
X-Gm-Message-State: AOAM5304RLkziB7UGfGv8YlBJEly66Y7cW1t7734sDK41O/YM35Vh8mM
        ZnnHqz/ED87+y58Bo4PfwbCCdpOLs6shVA==
X-Google-Smtp-Source: ABdhPJzUcPTHQA8k77ijiYBqvC+F8P5F2wA4IqcVKAkZvWaObGn2gG7KuPiDK+7DeYtTGwy1NTzduA==
X-Received: by 2002:aa7:842b:0:b029:1bf:3390:5c82 with SMTP id q11-20020aa7842b0000b02901bf33905c82mr14315509pfn.36.1612157159550;
        Sun, 31 Jan 2021 21:25:59 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y16sm16385433pgg.20.2021.01.31.21.25.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 21:25:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Fix "foo * bar" should be "foo *bar"
Date:   Mon,  1 Feb 2021 10:55:53 +0530
Message-Id: <2f66b83d10ed4a1c4523b7263f8a29097622858c.1612157127.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix checkpatch warning:

ERROR: "foo * bar" should be "foo *bar".

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 25e47ab937b9..c6c7d73eb015 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -148,7 +148,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
+struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
@@ -347,7 +347,7 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name)
+static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.25.0.rc1.19.g042ed3e048af

