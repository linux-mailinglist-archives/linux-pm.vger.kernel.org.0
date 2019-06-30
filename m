Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1645F5B04C
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2019 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfF3PDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 11:03:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33918 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 11:03:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so11928229qtu.1;
        Sun, 30 Jun 2019 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWe1N3LG/0qF/4OtUPg5KudfEZRgRNv8F1jllSBzO58=;
        b=ffrROOTrYan4x30i16kRzeRZh0cNY1tR6zoQHYUxePgn0RD9arBQo0wHXqQS24AEO6
         z/yAVqI8q8G78Fg6d+1EUBN8UmExk2L1ugT6WNCVJALHVq01478i2+l1I2OsTqluOTvA
         hnUGXEUyh87ggaQ3r/9ItW5b4I1Kwg9/BxMmb+QqZfOz9+FOqBAvZwzWf6ScwuaMYKAo
         FQHpWCWZ8a8g/vHHXP38B6zewBop6StVjcS7RpIqxbEZlvtQHBQp0LLU8yWS7KWrdxue
         /Be2CIgOEwZ7ZYds7RkxeMFKCKVGQlqgebZ+v8Fs5+o6G3Ci8sa/+d+uWVzXQkc8J1nt
         D3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWe1N3LG/0qF/4OtUPg5KudfEZRgRNv8F1jllSBzO58=;
        b=C9fIaLsLPzbfWfK5B6MQY1WGvN2/N+OJcz/M5CGlikRXWXU3xHP1N/g2LDX1xdkj9O
         7gcYBZiaGTAwK/wcIeQ6DGuV65EYCOUzG5mWYnpkr7yyxIM1o2GUcMM8uHUFyWodyw6I
         E645DS+u/R5onaCi7n7vlEBfW6nJIZE6Dq3boIwr1+HzvtCCGvvJNCfX5A0+UDx5/9DZ
         WwtBFnXk84rpjTtWaQdcQF8CsgobiGC6vEJzSMCdkpVlDt3pMCUmARhu1Fj8iAPbUR43
         kU2otdPRs8iKETzxFdOOghRY74qN6iiW5PB9xgkX/XDY+Ju9zr+7tv28wFsMAKUf/DVn
         GZlg==
X-Gm-Message-State: APjAAAVLxdlcDVA47XlUiTXgg43NzN4ZuiQ/wtKXkzmnr2Kp3ftP7O3B
        TZoEsaJqfiFSFFc47fd54L8=
X-Google-Smtp-Source: APXvYqw+jlFz4lc9QWDni/7uD8aWjy+oIsfuvaIWeBwdqBoQFL00TSoQqCRML6G+VV/wap1Zdd6izw==
X-Received: by 2002:ac8:2b51:: with SMTP id 17mr16313957qtv.206.1561906994849;
        Sun, 30 Jun 2019 08:03:14 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id l40sm4242251qtc.51.2019.06.30.08.03.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 08:03:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/bridge: ti-sn65dsi86: support booloader enabled display
Date:   Sun, 30 Jun 2019 08:01:43 -0700
Message-Id: <20190630150230.7878-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630150230.7878-1-robdclark@gmail.com>
References: <20190630150230.7878-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Request the enable gpio ASIS to avoid disabling bridge during probe, if
already enabled.  And if already enabled, defer enabling runpm until
attach to avoid cutting off the power to the bridge.

Once we get to attach, we know panel and drm driver are probed
successfully, so at this point it i s safe to enable runpm and reset the
bridge.  If we do it earlier, we kill efifb (in the case that panel or
drm driver do not probe successfully, giving the user no way to see what
is going on.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 7a046bcdd81b..8bdc33576992 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -257,6 +257,12 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge)
 						   .node = NULL,
 						 };
 
+	if (gpiod_get_value(pdata->enable_gpio)) {
+		pm_runtime_enable(pdata->dev);
+		ti_sn_bridge_resume(pdata->dev);
+		ti_sn_bridge_suspend(pdata->dev);
+	}
+
 	ret = drm_connector_init(bridge->dev, &pdata->connector,
 				 &ti_sn_bridge_connector_funcs,
 				 DRM_MODE_CONNECTOR_eDP);
@@ -813,7 +819,7 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 	dev_set_drvdata(&client->dev, pdata);
 
 	pdata->enable_gpio = devm_gpiod_get(pdata->dev, "enable",
-					    GPIOD_OUT_LOW);
+					    GPIOD_ASIS);
 	if (IS_ERR(pdata->enable_gpio)) {
 		DRM_ERROR("failed to get enable gpio from DT\n");
 		ret = PTR_ERR(pdata->enable_gpio);
@@ -843,7 +849,9 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	pm_runtime_enable(pdata->dev);
+	if (!gpiod_get_value(pdata->enable_gpio)) {
+		pm_runtime_enable(pdata->dev);
+	}
 
 	i2c_set_clientdata(client, pdata);
 
-- 
2.20.1

