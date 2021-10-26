Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DDA43A8B4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 02:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhJZADk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbhJZADg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 20:03:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137F0C06122C
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 17:01:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w16so395105plg.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JAo2MaGppQnqjiILYakqrQo0dvp6TO6MPFSMqu2Msw=;
        b=PYjqBgBuC4Ln3ClxVTkBrUeIYtIzbr3/5t+stBdwqdI5JN2yqaozNc3LTXIWEmp43Y
         6PHTQ4PjUxKD5uPJ1pH5iA38AouWfjyJQePxoiYsvWR9QQ5fP9IZR6rgjj9GCecp9Z+u
         XVoZw9JtkZ0XlO8+AVypz02I0Tiq/Y4wGz3rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JAo2MaGppQnqjiILYakqrQo0dvp6TO6MPFSMqu2Msw=;
        b=78Icwtif7nuleFg69Z50JCjRqZiUqYIoR76Y9Rl+XZnGldmdt4BJfbaNZx5y8vQ5tz
         UqoQt96I3q7GnsR2XfesbMIft5LKW+aZagD6/me9aV4NR+Ja6TPycB2hdhiWf+EIAWGD
         ZGK0kZPNG51NNgi0coFVsB71ByGt/WcjJxf8lbILyFlbMA7NfXtFl8wBEC+ATwjGvU5B
         cgnF19Uvsxmb8c2+Eqz7QAgq0izzEZZPvZXfmu7sbB9VAAgEDzbh4gaCOJvedRcFwmT9
         snPfaGQKO6drc5ODsjyPflZ+TZzxxyJ1K1D5p8ZxhqroFa7rQ9eze7q9fgDGSFL2atL2
         HpHQ==
X-Gm-Message-State: AOAM531U67NTVg2v5WfpfZ1aHiu13Ol9kXT1SdirqZ5nZ8wkkB6F/807
        7M+Vn0f8swNCSiXbtltloC54+Ke53uM=
X-Google-Smtp-Source: ABdhPJwA9n3Ot/w9JjBI5C4NrIIH8c4zADKFZcKc6vhKDtEfh02R2LlRSa/uKHdcQQORxarG90RPxw==
X-Received: by 2002:a17:902:ecc5:b0:140:4db1:e74 with SMTP id a5-20020a170902ecc500b001404db10e74mr9949902plh.10.1635206471632;
        Mon, 25 Oct 2021 17:01:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f5e3:5eb1:d5ee:6893])
        by smtp.gmail.com with ESMTPSA id b7sm9900747pfm.28.2021.10.25.17.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:01:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 29/34] power: supply: ab8500: Migrate to aggregate driver
Date:   Mon, 25 Oct 2021 17:00:39 -0700
Message-Id: <20211026000044.885195-30-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026000044.885195-1-swboyd@chromium.org>
References: <20211026000044.885195-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Acked-by: Sebastian Reichel <sre@kernel.org>
Cc: <linux-pm@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>
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

