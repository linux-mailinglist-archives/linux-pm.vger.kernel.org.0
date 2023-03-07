Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1502B6AE0C3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCGNiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 08:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCGNiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 08:38:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C24EC7
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 05:38:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j2so12128121wrh.9
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 05:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdJDrqqtlUNFE/DFGXP1EExWYwWTrZ4sgoVgCOKRcHw=;
        b=V4DzUa/CJXmEKyz8Xpy8/QGIKXBudu8ASEL6k8YrDJZSBCz38x5ZOffeZtMUdO57ki
         ITJyzDUh1dSdl8jwqFsAXbKJwIkdCxzK52vv1w3ry+4IgzfMQ7NpjyrwZyoj/9KFpGRf
         e35A86LQwKNWwcNbSCrCCHdHghj0uj5f5EYTQ/eefhnk1XIuhrNifsMUylxxf5OiWN60
         M/aUUCIWGaINg+xt7BMcqrewBKIv2hSmM97nsqNxjEOAUZiAMsSjGFBVIgE8G/708Xh+
         W0TiVoin/cQPePlabFlMqdwQftivwZqIYmq3lMpkQ9xkG9gEzBMkhA0C/yFM+K34lIUb
         x0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdJDrqqtlUNFE/DFGXP1EExWYwWTrZ4sgoVgCOKRcHw=;
        b=wuBKW8RnMjekpAMy/4Xy0kjLY8wwDphW+CLRu0APEiovHGG8TOKoFIs2oYfL0FzzJ9
         XgMoAJe6SupxSzAGMAPqwdQK9Ysyl6kd5y2zbjZO0gLBhEttEOxcrk/px/UW6PmTFHV4
         YXMXD2d+TScSSC5Bj1QwDgF9PumcOnqZ2VrpBQfPUD5YCCoEICXulDs9rcHb8tFlGePv
         xxL5FcCHxQ5+Lh4kn1jgFxr0YLFWDjfdX8l+PNEmeXoU5u57d2PAhs45JCTjT0luN0Tr
         myLUnFGqW8ozSOoOGJtS2Vqmx6561Y6PXzeLgtiqNopL1t9L6bUUcguZ/8kcP02A6zrG
         cBiQ==
X-Gm-Message-State: AO0yUKWrqbVHSPqkIBx7IPLNarnRWOhhI/+eiijf0woimmi7x8XEV3tu
        8JkFyPucDZ9FHrQkjOo+Iq11jQ==
X-Google-Smtp-Source: AK7set9/G2RCKujNj/awqunJtgb4/HR/pw5Zjft48/44xtwqy0fHRIBEntFMik1v/yB+mPnrmmq9Cg==
X-Received: by 2002:adf:f70d:0:b0:2c7:c9e:2c41 with SMTP id r13-20020adff70d000000b002c70c9e2c41mr9490477wrp.57.1678196280284;
        Tue, 07 Mar 2023 05:38:00 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:37:59 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, Keerthy <j-keerthy@ti.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 06/11] thermal/drivers/ti: Use fixed update interval
Date:   Tue,  7 Mar 2023 14:37:30 +0100
Message-Id: <20230307133735.90772-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the TI thermal driver sets the sensor update interval based
on the polling of the thermal zone. In order to get the polling rate,
the code inspects the thermal zone device strcuture internals, thus
breaking the self-encapsulation of the thermal framework core
framework.

On the other side, we see the common polling rates set in the device
tree for the platforms using this driver are 500 or 1000 ms.

Setting the polling rate to 250 ms would be far enough to cover the
combination we found in the device tree.

Instead of accessing the thermal zone device structure polling rate,
let's use a common update interval of 250 ms for the driver.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0c8914017c18..430c4b43151f 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -23,6 +23,8 @@
 #include "ti-bandgap.h"
 #include "../thermal_hwmon.h"
 
+#define TI_BANDGAP_UPDATE_INTERVAL_MS 250
+
 /* common data structures */
 struct ti_thermal_data {
 	struct cpufreq_policy *policy;
@@ -159,7 +161,6 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 			     char *domain)
 {
 	struct ti_thermal_data *data;
-	int interval;
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
@@ -177,10 +178,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
-	interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
-
 	ti_bandgap_set_sensor_data(bgp, id, data);
-	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
+	ti_bandgap_write_update_interval(bgp, data->sensor_id,
+					 TI_BANDGAP_UPDATE_INTERVAL_MS);
 
 	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
 		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
-- 
2.34.1

