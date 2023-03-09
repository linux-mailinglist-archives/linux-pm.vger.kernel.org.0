Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3366B1FFC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 10:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCIJ2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 04:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCIJ2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 04:28:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A65D8AB
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 01:28:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k37so695547wms.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2023 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678354118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcGx4aXFMGk9frr8lRdRWgHBNAcfS5az84l0THU0sOA=;
        b=iIRdp1V9x4ezfgFrAzbTLkkLE9LA3+EGI2x/sDlKAzubklLkFSd1URVKMbRJU05BOJ
         WaDYfK8g2ckNQqyLd7zgsLKOckAAQ2qZne9bdqbbcbw+BmzgfaM4UOi8g1XMnl8S383M
         hlSXR/wmOs/qy/Q76QXA4/0J1Cuqxg2OzL94d0D9SpSpln9i/BMwSLcw0QJQIVEhkIK2
         w2jD5KL7cBlaPje33MUF4LgLp7rDrSl3Viz40kUlM3IMqSoXvrzTZJqiw24JfqgLR/B5
         Fx3JSD6MDAhKEgHyGRfnGLm8f2k8i+o+QeVRWrvYvwMv3wP4ATjtqiaVFd+c5SDoKuYs
         kU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcGx4aXFMGk9frr8lRdRWgHBNAcfS5az84l0THU0sOA=;
        b=YE0LZwEy0exu/Ggql7yQn7wMAxHC0lf7idQaWiXgB/XSgjaUhPuAJjWk/LIKUF2UAg
         4GIYjbCFi4/n+5jIcGY2x/Oy3H4NpcWsoDiGHWJpkDSmgPQ31ekmAghGrHx3ZGyyuDP3
         0FNXDylKMZONuilj3kYy3gzUj27NA61ruJicqoi85yuLHhmKbFTV/6KMsYAkyC+TkewV
         cTHIKVnXZ7V9AN4CgohlYAt2r1J8+gjbYoCcztvnlcpAlKfi98aFkNDSNk3m3Fpn5qpM
         le2863CDFKz66wM4y5+SfYYgc0PU+g0FVM2X8gqv9EZZ7+x17d1BZlv+fKlA+8Tiz5u/
         sr2Q==
X-Gm-Message-State: AO0yUKVwKwkZZkoBrsIpe23lpThrAaxV09LxEaJRMIFOwV1ymyu70dFu
        rhwCn5eeN1Vk5gbu3wORYXclEQ==
X-Google-Smtp-Source: AK7set+By9EwomiJf5i1g8bGGFMzDBsr1VRRx7TXY8qeoGJsWAg9TiHaBltIM1IfQPpPOFHAV4GN5w==
X-Received: by 2002:a05:600c:1c20:b0:3dc:5b88:e6dd with SMTP id j32-20020a05600c1c2000b003dc5b88e6ddmr20167527wms.10.1678354118182;
        Thu, 09 Mar 2023 01:28:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003e209186c07sm1888894wmi.19.2023.03.09.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:28:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v2 2/2] thermal/drivers/imx: Use the thermal framework for the trip point
Date:   Thu,  9 Mar 2023 10:28:21 +0100
Message-Id: <20230309092821.1590586-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
References: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework provides an API to get the trip related to a
trip point id. We want to consolidate the generic trip points code,
thus preventing the different drivers to deal with the trip points
after they registered them.

The set_trip_temp ops will be changed regarding the above changes but
first we need to rework a bit the different implementation in the
drivers.

The goal is to prevent using the trip id but use a trip point passed
as parameter which will contain all the needed information.

As we don't have the trip point passed as parameter yet, we get the
trip point using the generic trip thermal framewrok APIs and use it to
take exactly the same decisions.

The difference with this change and the previous code is from where we
get the thermal trip point (which is the same).

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  V2:
    - Remove extra tab inserted in the previous version
---
 drivers/thermal/imx_thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 69ed482167f7..13c56e45cdbc 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -330,26 +330,29 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
+static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip_id,
 			     int temp)
 {
 	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
+	struct thermal_trip trip;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(data->dev);
 	if (ret < 0)
 		return ret;
 
+	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
+
 	/* do not allow changing critical threshold */
-	if (trip == IMX_TRIP_CRITICAL)
+	if (trip.type == THERMAL_TRIP_CRITICAL)
 		return -EPERM;
 
 	/* do not allow passive to be set higher than critical */
 	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
 		return -EINVAL;
 
-	trips[IMX_TRIP_PASSIVE].temperature = temp;
-
 	imx_set_alarm_temp(data, temp);
 
 	pm_runtime_put(data->dev);
-- 
2.34.1

