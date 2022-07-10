Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A238056D1A0
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiGJV1I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGJV0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:26:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924015A20
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so3989117wma.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIVAQgjKJeGSe1gmg5bAAUf+sy08/mvTvr//Arvl8d4=;
        b=bwX6DCXV1ANz93kGzRrBmIE/uBbuJYI+xg3LHrquj+GqnzRrXEwv2HZISLJZRSW78o
         GODhKJHDXJfbj9ZT8y+gmA2bXumlAY4BOTyrDf9HbdkC1easWhcVHrvT+W+ZcdMoTRTr
         0UiUeG5ZpH1hqUduzq5ntInHXeWUZec9LwsVNTISLAMTaEp0IGQS/lhesFRQb37jLfNv
         a5eJ9spCAqNawYa2oeQxtgldjk3j89qfJ6M9l03mEfjBnAAcl3qKuVMyT6hpIGP3WQjO
         4JJlkE8MzN5CMvsuggDbJoehMwEB00/3fW6hE0yon1yGp65J0Vwdfjcq9rsQBxQUAGts
         kbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIVAQgjKJeGSe1gmg5bAAUf+sy08/mvTvr//Arvl8d4=;
        b=M1zIwxgJipiw34jmuGxH9Tea+ujl0NVpWRJyFDfiN9rmzbXN23KQmKm9z8sWZP5nJh
         BFgUXaOAqqlGivVhnWfhIgOI8Q9TZqsmASGO4z2h6JC4uAoUAFvvhxcC08q3BtCKHDTi
         hU/FB2Qssoo9vs7nCJ5PZGojlMfpJQ0PUau95AqFy93Eg9PAZSUawXd3xGNtC8s+P27c
         tkh4cgCqUWMCrLI+TQ3IbsWUDt3HzDy+zm14/QN024+VXMtOsc3OaPlJ8VleaPVcC1Er
         CKENgXSkpA8Z9CP/FxtaiSbGt4y66wxdbYTPGNT1YLWatIwaSgtXiCLLo2av2qmKim3I
         t3TA==
X-Gm-Message-State: AJIora9DcLcgTmE2JhvpJ4kuWfbXfSmJlaS7/4qhP03/raZUbTZX8SRL
        ITWlvPij/8gNDZl18r38HNoKhQ==
X-Google-Smtp-Source: AGRyM1uo9Otvut72zMkDjHYnOsl3cCTcguJq1mSCKLu7tr3jw2jx6zah1dNAu0rjKPZTlUupXnCIMg==
X-Received: by 2002:a05:600c:190a:b0:3a2:e8cc:57ca with SMTP id j10-20020a05600c190a00b003a2e8cc57camr383824wmq.118.1657488319230;
        Sun, 10 Jul 2022 14:25:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v1 27/33] iio/drivers/sun4i_gpadc: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:17 +0200
Message-Id: <20220710212423.681301-28-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..7aebfd337871 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_get_temp(void *data, int *temp)
+static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sun4i_gpadc_iio *info = data;
+	struct sun4i_gpadc_iio *info = tz->devdata;
 	int val, scale, offset;
 
 	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
@@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = &sun4i_gpadc_get_temp,
 };
 
@@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
+		info->tzd = thermal_of_zone_register(info->sensor_device,
+						     0, info,
+						     &sun4i_ts_tz_ops);
 		/*
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
-- 
2.25.1

