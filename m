Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B211CAE4FB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfIJH7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 03:59:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42898 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfIJH7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 03:59:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so9364350pgb.9
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ICqDZT0+Rww/hGCZQ9/7SaJeWoOs3iDbAih166xoms=;
        b=F/4DbNZMB0nf7DgnHlLG8hechqYzxn49BWwlDiqD6w5zAWKLdtCcwUMdYD1CsqN+Ng
         jzKPub20pUMRPuzTI4YvJD3AiyE28CCh4t/qGp+gjJYenrY9lh/BXg7sRph0NR66KjSF
         k6CBYACYO5XANiHDoc9soi/2ks1/EbDYV2mfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ICqDZT0+Rww/hGCZQ9/7SaJeWoOs3iDbAih166xoms=;
        b=hoVxLVhZ9KbBYJie6UKIYoaFR7hD27jd0cXcOCun/VuEKDawGxBrw0wXvLSTJDroTi
         /zM40muqbEtKCZBB/0wcTUm/MFoaET7AB1chFx/iN0KnFbyBp2G9Rbc57c6T5UZmAgPR
         6ux9/fEWVVoxKeWBcmZ8t3O3VVgTV9Dqwy/jx0n0eszyl6AZFgapCY+eO7x/9NvbkNcx
         sH5VfbSBhTbaOwO7mtKg7EUGBGPMMq/k0fEG52i6GJrH17ohxaamBWXYgnX/5E5xQ2Z/
         Tfo0shxVsLOpTg84choaD8HToo9f+WoKW6gRoZ0RLPIXX5xEsIzxfN1BJ+4JzPrOdFF5
         Slbg==
X-Gm-Message-State: APjAAAWhsernEP8Gmdhxkx6N8jLNttVT1+ut5xNubqqBDWHYURouu2sf
        EzscNwb8vSX4do88ydqg8OnRxQ==
X-Google-Smtp-Source: APXvYqyDn9hO++8SUhAPekxT/ojMiADYLdC41QbV41Z++f9OMrsB5LXCadAWjtEN/hNbyMZ7r2vYLg==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr34260902pfo.122.1568102352293;
        Tue, 10 Sep 2019 00:59:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id c23sm16189538pgj.62.2019.09.10.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:59:11 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Eduardo Valentin <edubezval@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal-generic-adc: Silent error message for EPROBE_DEFER
Date:   Tue, 10 Sep 2019 15:59:07 +0800
Message-Id: <20190910075907.132200-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If devm_iio_channel_get() or devm_thermal_zone_of_sensor_register()
fail with EPROBE_DEFER, we shouldn't print an error message, as the
device will be probed again later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/thermal/thermal-generic-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index dcecf2e8dc8e..ae5743c9a894 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -134,7 +134,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->channel = devm_iio_channel_get(&pdev->dev, "sensor-channel");
 	if (IS_ERR(gti->channel)) {
 		ret = PTR_ERR(gti->channel);
-		dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
 		return ret;
 	}
 
@@ -142,8 +143,10 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 							   &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		dev_err(&pdev->dev, "Thermal zone sensor register failed: %d\n",
-			ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"Thermal zone sensor register failed: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
2.23.0.162.g0b9fbb3734-goog

