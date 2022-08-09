Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1658D5DA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiHII4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 04:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbiHII4j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 04:56:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8EC2252E
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 01:56:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v3so13632693wrp.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Nioz9jTvIYC3MkuoeeXOKouVDzG9rikhwfoHFhwSrUc=;
        b=S9TVsuzhOehWyZ5xdtK2r1ilTAigVStRKNqjVuKafJ/sYabydAO5C7D0o57Cso5KsL
         3i+3b2buufmLBShKTEMSN1Cd5qYkGP9uzuQnwug7XsKGW4eDgFQkcdSmalaqRSGZjzXi
         r3zNaFGFMCYhOVzImwGkdkhS/7xTlC979GXQzB3E+7J2lnA1YXZ3qWswlzrPoIIMxhgy
         18fn4x60XS01oFeODecUSRZ84aTaf6CPbtWQ7QeGz0tS0CWoxvpN/GkbKSaL4i9SXxws
         ZQpM8OaU+ulM0W+EIsAg/g6nXk6Aj0GT2qPW0OXrLKs8b2jJSzhbiUkHNFLrsK2PhVsV
         uCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Nioz9jTvIYC3MkuoeeXOKouVDzG9rikhwfoHFhwSrUc=;
        b=HrnzaX54/WZbqDDBI7REmrLhy3E1uY4tQzN9pD7UasGQ1hC1WcOrn+K3hydX5vneZl
         o81Z7QGsCzarqvXDngvcTBM02aiDcRexsuibgdCGsev3oFvt1Y+NOEWiypYcp67WCFu5
         Gk3OaFkyn5old3e8v+9SsQcMxjxF32SPTBs5RDqGvdEUn8q20uLxjw3Mtyk8r/fc+TuL
         ldo6lIAjvuXUyw2m+Wypbb3RJHs5O9aLX+qQC9P1IWloesbWF4E1oo1WsTNhBdYjeu9t
         uV8COMXURjKSoEVyl90RSH+Ihesww8tLrLYf7FfhtLQrYCQNsDiYF5Op6C/l41u/ggt/
         BJ7Q==
X-Gm-Message-State: ACgBeo1eRtKGQ3ZCL0jyv8r6NisOVPA8Oyt8rVPHD2EJOOUXldXDAGsM
        OPcKYn4SUQzoCDpNSChAzVZQbg==
X-Google-Smtp-Source: AA6agR7Eeiw5PNfZ+41IJRCAonp78CCNCVne7eY4Y5ynKDBWgjuBMuWBDLcEIrPRmi5qtdEkPldv9A==
X-Received: by 2002:a5d:4945:0:b0:21e:de03:2d11 with SMTP id r5-20020a5d4945000000b0021ede032d11mr13542950wrs.308.1660035395982;
        Tue, 09 Aug 2022 01:56:35 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe705000000b0021f1522c93bsm15746147wrm.45.2022.08.09.01.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 01:56:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 2/4] thermal/of: Return -ENODEV instead of -EINVAL if registration fails
Date:   Tue,  9 Aug 2022 10:56:27 +0200
Message-Id: <20220809085629.509116-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809085629.509116-1-daniel.lezcano@linaro.org>
References: <20220809085629.509116-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The previous version of the OF code was returning -ENODEV if no
thermal zones description was found or if the lookup of the sensor in
the thermal zones was not found.

The backend drivers are expecting this return value as an information
about skipping the sensor initialization and considered as normal.

Fix the return value by replacing -EINVAL by -ENODEV and remove the
error message as this missing is not considered as an error.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Michael Walle <michael@walle.cc>
---
  v2:
   - Change the error message to a debug message
   - Only show an error if the error is not -ENODEV
---
 drivers/thermal/thermal_of.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 368eb58e97cf..3effc729be4b 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -328,8 +328,8 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
-		pr_err("Unable to find thermal zones description\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("No thermal zones description\n");
+		return ERR_PTR(-ENODEV);
 	}
 
 	/*
@@ -368,7 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			}
 		}
 	}
-	tz = ERR_PTR(-EINVAL);
+	tz = ERR_PTR(-ENODEV);
 out:
 	of_node_put(np);
 	return tz;
@@ -642,7 +642,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 
 	np = of_thermal_zone_find(sensor, id);
 	if (IS_ERR(np)) {
-		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
+		if (PTR_ERR(np) != -ENODEV)
+			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
 		return ERR_CAST(np);
 	}
 
-- 
2.34.1

