Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95686486C99
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 22:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiAFVrg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 16:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244895AbiAFVqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 16:46:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD74C029821
        for <linux-pm@vger.kernel.org>; Thu,  6 Jan 2022 13:46:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id pj2so2360765pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jan 2022 13:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGqq0UfufzgH1LXDtnLjAQyDmHk5g+0Lk09sKMzlfmI=;
        b=AOWN7v58HvJOqlZ6lHNZHE2A28mPb4zKe2Mj9bTZpwUh+HozXtTE3jJKFaw47lD3eY
         5NtO2Oi1pTx6/Avl2BGK7Xwjzdc8hSPXzduFzhd2fF7rpBHqfzUQDhHs4/BcY7K7tS7F
         0U4tA0tg9yLN38FNIeknPel3KIr+eOw+2+HBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGqq0UfufzgH1LXDtnLjAQyDmHk5g+0Lk09sKMzlfmI=;
        b=A5eih45Qy1l89akvi8FEwmkuU9tnvARe5C8N31PMTx7s69j6cA0BCEvQwaX3F16T1L
         wzFB3vlkv08QwcABlrpK+dBGBeogQK5e0MfgT1Nyphj6C7IIPQRSQhWkGnl60u41tKh/
         v3mCJNDym+F/LmWbvm9UI2IvXGJjM9IjYkCh58fIf7LRVPtfSMUDXX+vfLeqCTTYJqdT
         dM5nm/LNDbbsXv1k1bC9n09IMC4HU87PVMKLwDLVEk+rKIt6oKJSjrSbb/nmDLiqAu18
         2bwbREqUeiUO1barHLQu4oekUrDVHtyJOSoVcdWTN1uA2HfwYFTAmQNNF7B0sf+XXpHG
         gpNQ==
X-Gm-Message-State: AOAM532Pcb7bzS/XI0Z+bTDp36pUPXUEsfT9eiXWdteC+ByaPGnHs4IB
        Xh9SN1Zb/9j3EZbOq7IrG9NAtQ==
X-Google-Smtp-Source: ABdhPJxsrSp0V86crFp4pzNtzJwdoL0M0g2Krz5WE6X1drEmfa7npHt6A/QP0naMp9HjGxQ1EzBxtQ==
X-Received: by 2002:a17:902:ce85:b0:148:d590:5734 with SMTP id f5-20020a170902ce8500b00148d5905734mr60400961plg.1.1641505594793;
        Thu, 06 Jan 2022 13:46:34 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:34 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 27/32] power: supply: ab8500: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:50 -0800
Message-Id: <20220106214556.2461363-28-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220106214556.2461363-1-swboyd@chromium.org>
References: <20220106214556.2461363-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Acked-by: Sebastian Reichel <sre@kernel.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Cc: <linux-pm@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/power/supply/ab8500_charger.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 15eadaf46f14..52d4105e28f2 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3312,8 +3312,9 @@ static const struct power_supply_desc ab8500_usb_chg_desc = {
 	.get_property	= ab8500_charger_usb_get_property,
 };
 
-static int ab8500_charger_bind(struct device *dev)
+static int ab8500_charger_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct ab8500_charger *di = dev_get_drvdata(dev);
 	int ch_stat;
 	int ret;
@@ -3354,8 +3355,9 @@ static int ab8500_charger_bind(struct device *dev)
 	return 0;
 }
 
-static void ab8500_charger_unbind(struct device *dev)
+static void ab8500_charger_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct ab8500_charger *di = dev_get_drvdata(dev);
 	int ret;
 
@@ -3380,9 +3382,13 @@ static void ab8500_charger_unbind(struct device *dev)
 	component_unbind_all(dev, di);
 }
 
-static const struct component_master_ops ab8500_charger_comp_ops = {
-	.bind = ab8500_charger_bind,
-	.unbind = ab8500_charger_unbind,
+static struct aggregate_driver ab8500_charger_aggregate_driver = {
+	.probe = ab8500_charger_bind,
+	.remove = ab8500_charger_unbind,
+	.driver = {
+		.name = "ab8500_charger_agg",
+		.owner = THIS_MODULE,
+	},
 };
 
 static struct platform_driver *const ab8500_charger_component_drivers[] = {
@@ -3663,9 +3669,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 
-	ret = component_master_add_with_match(&pdev->dev,
-					      &ab8500_charger_comp_ops,
-					      match);
+	ret = component_aggregate_register(&pdev->dev, &ab8500_charger_aggregate_driver, match);
 	if (ret) {
 		dev_err(dev, "failed to add component master\n");
 		goto free_notifier;
@@ -3688,7 +3692,7 @@ static int ab8500_charger_remove(struct platform_device *pdev)
 {
 	struct ab8500_charger *di = platform_get_drvdata(pdev);
 
-	component_master_del(&pdev->dev, &ab8500_charger_comp_ops);
+	component_aggregate_unregister(&pdev->dev, &ab8500_charger_aggregate_driver);
 
 	usb_unregister_notifier(di->usb_phy, &di->nb);
 	usb_put_phy(di->usb_phy);
-- 
https://chromeos.dev

