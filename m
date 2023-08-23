Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06334785EAA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjHWRdv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjHWRdv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 13:33:51 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39265E7D;
        Wed, 23 Aug 2023 10:33:49 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-570e8bee8b5so456160eaf.1;
        Wed, 23 Aug 2023 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692812028; x=1693416828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4cJYvOwVGAT7gylUsZ1uwHj3O046erDYBL6A2R2npE=;
        b=p/AjONNI3yNa8Lxk7pepQKxsKZ2JpxUkpdjOvtZegDnF8c9vnKCLWcmgxPTUbsSOtD
         2nPdVT3ykiAfdfFIqtqqDXWjOHBuwGT1v4SI5o39u9ZkhbI6bQA5D5Oogb8IT2o1dDKM
         wY/0hZX9kkzSapDIK2E+eDAKpKgyTCW+UsGqI75gJrMnfqXXrbE3DQYovOhMu42EVX/b
         uujmy47HyNgjfrg3xQpk82Dzn1TYacux1yG/kj2B6Gt6NCUbLKUmeMC2HkDfKnXjLdh8
         GxCQqibHiUSj5v2GsY9eZHzRkXSppU28cVluAJaQDxgroF/CSK7hPP2tP6rUYqP9CloG
         DGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692812028; x=1693416828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4cJYvOwVGAT7gylUsZ1uwHj3O046erDYBL6A2R2npE=;
        b=fXc0nzBxvrudAEe7HczRW/eYVGuNwYykpjSLRhqyL4AXI4eBFU842BYaL2wSnlkUYe
         bhkCRxO6mcDkzvpJCukWja2H1sE7Ws0XfiTq/FW/Q4MsyzHFUVqg9QHUeXu0zWHpV2ka
         UpAWkoXBdZDJmY6uuCKsEL1o2Q61u1a5JBqwor1wb1AUnfKAE57O/TqVi7beIQfwTBSV
         4uNZoaaPAeOOOWRdiUj78I1Wf02OdiuoyaoKoIro8DCJ29u5IivNGW3CJ6HfDfeCDZZ1
         NNBf9Ck5JKvtSRU0/E1BDWOqKEX+7Or06QlNFqpJ0irxegurjsyoiyAjiUYxrxPcMSj7
         jz+A==
X-Gm-Message-State: AOJu0YzgAdP0TIMQNe6UPTJ8JpgT13qbK3476J0n2dy3tfhRLoJGhX82
        r9+SUm9fx3e7xspqcvLgbCM=
X-Google-Smtp-Source: AGHT+IFaHhepcwQ/qBMADUaJ7iHVJXjC2K99w1cY7XtwVrBoPCYZMV1KQmqvTvCn+X7JIWY5Y5q/gg==
X-Received: by 2002:a4a:d137:0:b0:571:1906:47f0 with SMTP id n23-20020a4ad137000000b00571190647f0mr1884917oor.1.1692812028341;
        Wed, 23 Aug 2023 10:33:48 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
        by smtp.gmail.com with ESMTPSA id a1-20020a4aae41000000b0056d361ca33fsm5949943oon.16.2023.08.23.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 10:33:47 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] thermal: imx8mm: Allow reboot after critical temperature
Date:   Wed, 23 Aug 2023 14:33:34 -0300
Message-Id: <20230823173334.304201-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823173334.304201-1-festevam@gmail.com>
References: <20230823173334.304201-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Currently, after the board reaches the critical temperature, the system
goes through a poweroff mechanism.

In some cases, such behavior does not suit well, as the board may be
unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce the 'nxp,reboot-on-critical' property to indicate that the
board will go through a reboot after the critical temperature is reached.

When this property is absent, the default behavior of forcing a shutdown
is kept.

Tested on a imx8mm-evk board.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/imx8mm_thermal.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e89b11b3f2b9..cc95a1416976 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
+#include <linux/reboot.h>
 
 #include "thermal_hwmon.h"
 
@@ -91,6 +92,7 @@ struct imx8mm_tmu {
 	void __iomem *base;
 	struct clk *clk;
 	const struct thermal_soc_data *socdata;
+	bool reboot;
 	struct tmu_sensor sensors[];
 };
 
@@ -146,8 +148,23 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return tmu->socdata->get_temp(sensor, temp);
 }
 
+static void tmu_critical(struct thermal_zone_device *tz)
+{
+	struct tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct imx8mm_tmu *tmu = sensor->priv;
+
+	if (tmu->reboot) {
+		dev_emerg(thermal_zone_device(tz), "%s: critical temperature reached\n",
+			  thermal_zone_device_type(tz));
+		kernel_restart(NULL);
+	} else {
+		thermal_zone_device_critical(tz);
+	}
+}
+
 static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
+	.critical = tmu_critical,
 };
 
 static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
@@ -313,6 +330,8 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	if (IS_ERR(tmu->base))
 		return PTR_ERR(tmu->base);
 
+	tmu->reboot = of_property_present(pdev->dev.of_node, "nxp,reboot-on-critical");
+
 	tmu->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tmu->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk),
-- 
2.34.1

