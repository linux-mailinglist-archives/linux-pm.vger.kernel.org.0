Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBA6B8ECC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCNJca (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCNJc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 05:32:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A94570A5
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 02:32:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u5so15914247plq.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678786343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQBaP6NNs1+swFBxxR3m2gMTZaTzSsPIhqbxCO9Jwuc=;
        b=KEUhY5Lnh3J0DfiMK/EIpX4abofPH1BNKrhl7lM+LBfivflYuX7vmODvAnf9+hFFFN
         1EjfpCxBU+y2SMGhQd0cgFV/41bFJzmo2HvS+s7M4IcOc3KnroS5/27+X9wvRQtfS+5G
         t5T5t4SGEfzJZHlgULAmcqmwvhNfytBPGmuHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678786343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQBaP6NNs1+swFBxxR3m2gMTZaTzSsPIhqbxCO9Jwuc=;
        b=mJhdy4OBhV2/brrkfrxWHHo1ZsWRFSZIAXDrZvAXP8zdPfjlQmK1PTEm+IcghU2Y1u
         ToqdASdh4YKQWlTEIaCqaUupKUrcgY5rYkJ1hHrdSwaSKu74CjZUkZ7SMfT4esx7tP3n
         3HnSoDWQAgMdatxdwgZtsdPUwIUasG737/bmbx49dfWYaGzbXG1C+tW0zATdhZFA4iLS
         rJJeVlIjZhb/1pB+JHVpiw9iiyolc3IG2NDrPD0aFOE6h0td907IA1lrjB+uYa/H91+9
         CSXoHF3Pie88jyMOgzAnX/JgJaZTKnNnHchmEtW3767IWvVNrQ/a2J6qkWzZvd19/BwT
         3Aog==
X-Gm-Message-State: AO0yUKUDYv6u9bvSK2DTaBPo05biHTGi7Wto/T9RqMl7YUi0VDoelWsT
        tL9qx9lPZwAHdNr5cZolUkCHdQ==
X-Google-Smtp-Source: AK7set/DIpXFg0newybBhwUu3htmas9rXlgHCKNwPgT0x6mYJsVvNIA4lbPT2rnDfNRIEmKjoj8xgg==
X-Received: by 2002:a05:6a20:bb29:b0:d5:9a0c:ef31 with SMTP id fc41-20020a056a20bb2900b000d59a0cef31mr698214pzb.62.1678786342779;
        Tue, 14 Mar 2023 02:32:22 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:99b4:e339:ed01:f0c1])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78e58000000b00593e4e6516csm1158851pfr.124.2023.03.14.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:32:22 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Register thermal zones as hwmon sensors
Date:   Tue, 14 Mar 2023 17:32:13 +0800
Message-Id: <20230314093213.2450396-1-wenst@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0557d1c61b9e..15f317c42718 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -19,6 +19,8 @@
 #include <linux/thermal.h>
 #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
+#include "../thermal_hwmon.h"
+
 #define LVTS_MONCTL0(__base)	(__base + 0x0000)
 #define LVTS_MONCTL1(__base)	(__base + 0x0004)
 #define LVTS_MONCTL2(__base)	(__base + 0x0008)
@@ -996,6 +998,9 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 			return PTR_ERR(tz);
 		}
 
+		if (devm_thermal_add_hwmon_sysfs(dev, chip->tz_dev))
+			dev_warn(dev, "zone %d: Failed to add hwmon sysfs attributes\n", dt_id);
+
 		/*
 		 * The thermal zone pointer will be needed in the
 		 * interrupt handler, we store it in the sensor
-- 
2.40.0.rc1.284.g88254d51c5-goog

