Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF349EBEC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiA0UDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 15:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbiA0UCe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 15:02:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A92C061777
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 12:02:31 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y17so3686466plg.7
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=riumb/7yMkcFbw4RrpVGufoj0gjKUJSuK0Qg2XknZ7c=;
        b=NpYO5ID7f28ORexqnHkzZ0M54adxGnU0hRqq3qMqQyrYGblQq3T7AbkbyeSwkleWwX
         1tdKASzL3lfB1QiEImyl7I5sFgEJAzg5lhJ31c07BZMxspqw1wEXyCWCACCBDKj4GvBM
         Mku2sKRUm6mYUtIPaoIcno6DGaPIftBeAqDeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riumb/7yMkcFbw4RrpVGufoj0gjKUJSuK0Qg2XknZ7c=;
        b=spw5/NJjWeoMM+LahKnwQP9sSv2SVGgz3IRUhbhfymLHTcbjva4XYgw47oS7tnvaoc
         WfvMKiVsDeJxVsbOdAqfyHMFJzz2kAlfSkrMyCprEyFFiYDE5F9Q7dQ+dLd6EAUwV+pZ
         ti2WlGmAlVCjsoAqCHZHKeXAtsCL/ZGFb6ARSrKE4T/hl7usK700MObUyZbpOgrSCsm4
         SmI4FVGIZU4mIWX3PCHB3sZ397aQpOz4oxIS6Bncei366iFwr8XDYC2vjM+jcqAmpIpt
         /Z25+qOCLHN5eWTyRkNiUfwJgwj4r7XysgYYaEy6M74It+X0zX7L7q+XMBhuWAkGwg3z
         cKvQ==
X-Gm-Message-State: AOAM532V3tODdbrtQKIjLpsv/HXN+mhL8m7azrE7Rs4ZWspFhaUDsoyD
        iyWAnjvpuGACp9PKVFxSvs+lqQ==
X-Google-Smtp-Source: ABdhPJwWoTTDM63H2gCdds/RxYfOFR7pmlktYW6DhFTALTQitolMZJK4DIvXjvtcObjDsy8ZXAWysA==
X-Received: by 2002:a17:902:7ec1:: with SMTP id p1mr4549151plb.159.1643313750817;
        Thu, 27 Jan 2022 12:02:30 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:30 -0800 (PST)
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
Subject: [PATCH v6 27/35] power: supply: ab8500: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:33 -0800
Message-Id: <20220127200141.1295328-28-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
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
index ce074c018dcb..e3164e8335ca 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3335,8 +3335,9 @@ static const struct power_supply_desc ab8500_usb_chg_desc = {
 	.get_property	= ab8500_charger_usb_get_property,
 };
 
-static int ab8500_charger_bind(struct device *dev)
+static int ab8500_charger_bind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct ab8500_charger *di = dev_get_drvdata(dev);
 	int ch_stat;
 	int ret;
@@ -3377,8 +3378,9 @@ static int ab8500_charger_bind(struct device *dev)
 	return 0;
 }
 
-static void ab8500_charger_unbind(struct device *dev)
+static void ab8500_charger_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct ab8500_charger *di = dev_get_drvdata(dev);
 	int ret;
 
@@ -3403,9 +3405,13 @@ static void ab8500_charger_unbind(struct device *dev)
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
@@ -3694,9 +3700,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 
-	ret = component_master_add_with_match(&pdev->dev,
-					      &ab8500_charger_comp_ops,
-					      match);
+	ret = component_aggregate_register(&pdev->dev, &ab8500_charger_aggregate_driver, match);
 	if (ret) {
 		dev_err(dev, "failed to add component master\n");
 		goto free_notifier;
@@ -3721,7 +3725,7 @@ static int ab8500_charger_remove(struct platform_device *pdev)
 {
 	struct ab8500_charger *di = platform_get_drvdata(pdev);
 
-	component_master_del(&pdev->dev, &ab8500_charger_comp_ops);
+	component_aggregate_unregister(&pdev->dev, &ab8500_charger_aggregate_driver);
 
 	usb_unregister_notifier(di->usb_phy, &di->nb);
 	ab8500_bm_of_remove(di->usb_chg.psy, di->bm);
-- 
https://chromeos.dev

