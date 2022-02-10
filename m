Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5804B1363
	for <lists+linux-pm@lfdr.de>; Thu, 10 Feb 2022 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiBJQs3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Feb 2022 11:48:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244788AbiBJQs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Feb 2022 11:48:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE40122
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 08:48:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q7so10567334wrc.13
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLS576zRiyX8cEFCSbEsgtddD+sDLikqn6zU/1oJf8w=;
        b=F+zihJjTwanF71H/D7ekBj3wU+Z2b52PbghTEMCSmcOrTiH4PgBQHiDD+hXz68ypHP
         L7Qab60Rg495sc5am43DY+CBcqGfjj0CdVzZTiFbvxvhVKpjLmS8INCDGOTjthlD/1qw
         u3sGYXfa8JajcntQa4ZCQAQ0i6YUqAHENq5WZ4v+e3ELGKtJPOvdFCha0x5l5V/5BD0w
         UmInuD8BBguT1bWO2GLwYUjbvnm/X7wgxT3OmC9eBsXrHbqJe5Q7qRUO7Ze4PC9lwkwa
         Pjp+3IWFRNqf0YPk8FBPwbC+24DYbudQQFgeqqeJzAZKvZIl161TOjly//C/jy7F2eU1
         Khow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLS576zRiyX8cEFCSbEsgtddD+sDLikqn6zU/1oJf8w=;
        b=tN1ZAIkyM8szB2HK8/nH6rrpoRrSIJo87ZJt/U2nmlF8Z/LVeIzcNe5l45oflaJHLT
         USaB5nJb63ox0n1CVRIDX0Ylh1+0QP9xM/crd3pnQQ6VlbrxjGnRSyUBmp4+nPzRr7dM
         qJ0N9UpOeE01O5ZVIN1eP/o2FGwtRaC+u1J+4F6qyE962B6d4aWEBJTczqSEKwqXMqdg
         b37YtVAwJwJIYntTpVWOXD54eGH3t5PWbvBXOLS/NCtDypE9DgaKTi/2+qPIof73mWG3
         solcrFdE4PbjT2Pf0p90lYkbKIF1idYaa3r1flW/cbfRR7CIdz3iddKy+WBvpPyATFbp
         Km/A==
X-Gm-Message-State: AOAM5309IxUS/94PbBHpEPTJ1vhcjM/InzIPo2CWy2EFMqj0dQZ+LXDE
        pKjUdhggvvgAs3Tol0kpjNcbRxuQJSwJ1w==
X-Google-Smtp-Source: ABdhPJyFIO3FkvNhELbMWyISu/O1KiJzBnlOUFk+mthkcVHN3yHFF62iPajbwsCkPx8ilc0eXtRWCg==
X-Received: by 2002:adf:dd41:: with SMTP id u1mr7343463wrm.253.1644511706802;
        Thu, 10 Feb 2022 08:48:26 -0800 (PST)
Received: from localhost.localdomain ([37.169.15.245])
        by smtp.gmail.com with ESMTPSA id p3sm2047003wmq.40.2022.02.10.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:48:26 -0800 (PST)
From:   Massimiliano Minella <massimiliano.minella@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>,
        Massimiliano Minella <massimiliano.minella@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH] thermal: k3: Add hwmon support
Date:   Thu, 10 Feb 2022 17:47:47 +0100
Message-Id: <20220210164756.3489848-1-massimiliano.minella@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose the thermal sensors on K3 AM654 as hwmon devices, so that
temperatures could be read using lm-sensors.
Use devm_add_action_or_reset() to unregister the hwmon interface
automatically.

Signed-off-by: Massimiliano Minella <massimiliano.minella@gmail.com>
---
 drivers/thermal/k3_bandgap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 35f41e8a0b75..94678085dd5c 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -16,6 +16,8 @@
 #include <linux/thermal.h>
 #include <linux/types.h>
 
+#include "thermal_hwmon.h"
+
 #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
 #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
 #define K3_VTM_TMPSENS0_CTRL_OFFSET	0x80
@@ -149,6 +151,13 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
+static void k3_hwmon_action(void *data)
+{
+	struct thermal_zone_device *zone = data;
+
+	thermal_remove_hwmon_sysfs(zone);
+}
+
 static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
@@ -219,6 +228,19 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			ret = PTR_ERR(data[id].tzd);
 			goto err_alloc;
 		}
+
+		data[id].tzd->tzp->no_hwmon = false;
+		ret = thermal_add_hwmon_sysfs(data[id].tzd);
+		if (ret) {
+			dev_err(dev, "thermal failed to add hwmon sysfs\n");
+			goto err_alloc;
+		}
+
+		ret = devm_add_action_or_reset(dev,
+					       k3_hwmon_action,
+					       data[id].tzd);
+		if (ret)
+			goto err_alloc;
 	}
 
 	platform_set_drvdata(pdev, bgp);

base-commit: e5b54867f47f765fcb439e09ed763b5de617af3e
-- 
2.25.1

