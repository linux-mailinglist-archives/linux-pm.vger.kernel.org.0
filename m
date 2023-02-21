Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED08669E71B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Feb 2023 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjBUSJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Feb 2023 13:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjBUSIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2023 13:08:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD72D172
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:08:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az11-20020a05600c600b00b003dc4fd6e61dso4307497wmb.5
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj/XCNr0kaZT/9prwrgZXIPale3VaDSnJ0X65XmdswI=;
        b=XwmPT1cE2nvf4O6nZ7Jcn9NWxEhhKq8cES62hT/lwPGstslb7e+KXTwdtqLIpS/oC9
         85BpYqEiZBeZHZcLH3oDkBHB77rm1rcgoF8CPMGd1vqjzf2HmY0WbRObqvA1GKetsFX7
         izGoLCvgO6LkZOue/YiPaKJFl4kXbNjk1b/MUA4aNu7wSa2Xafu+eZ8lMIFPiGal752x
         dRrg5LduwxleF3zrr3rduwHRbuPJUM1WBmo29emhxCpGPaGqmBKQ8KD3cpePQh1rEpWO
         X6uA95V4i+ZcxitasUAd0mJyjKOHgGqmTvQIkOEmcuUY1uD7XVlA8LuRnXTbtecaWvUx
         dsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj/XCNr0kaZT/9prwrgZXIPale3VaDSnJ0X65XmdswI=;
        b=ekmUH/rXnUXAVCbuxgGtgrzBrPiIFjFprQwlcGBodorlfICZRBCKPwYe4204J8DvU8
         4K16Ztd28jUxdzVUDH4+UMqC392UYCZpWpZdSBIq8ID/w5ks7NUk0J6tc300VgAIfLqc
         4B7BCa99V90ROzvmk4jXaIMbf2uS3FzJJVKm3tDdua7VvquNirfp2zbCrN2yaIEUaELA
         yo2XSmLRtkVw1falpaMVgWP+7etCtJ4+5zIDROxD4h4ahkckIzUMxcXz0cYCK0a1fSCu
         2YDPrOxM/8rm/jBpS4xaanCsz1DroJrUrlMGl+6HVPtUUK8yL7O8zO2T2+YK554zl+GD
         HJPA==
X-Gm-Message-State: AO0yUKWA2W+sU8Bvhs+69TbK2gsCPqHxIWj7lQ6YPxe7ZCeNqxpoVigf
        6m+SCvyvKyrFM4OU8Vtt+Mjj0A==
X-Google-Smtp-Source: AK7set+3j0fBOa8sEmacj7NTkstFaKrp6ySEpStMKmFaiEaZ62EbWgZAb8XrU6TzB+fa7X3/JWwQlA==
X-Received: by 2002:a05:600c:1652:b0:3e1:12d1:fde0 with SMTP id o18-20020a05600c165200b003e112d1fde0mr4218250wmn.6.1677002885486;
        Tue, 21 Feb 2023 10:08:05 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:08:05 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 11/16] thermal/hwmon: Use the thermal_core.h header
Date:   Tue, 21 Feb 2023 19:07:05 +0100
Message-Id: <20230221180710.2781027-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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

The thermal_hwmon is playing with the thermal core code
internals. Changing the code would be too invasive for now.

We can consider the thermal_hwmon.c is part of the thermal core code
as it provides a glue to tie the hwmon and the thermal zones.

Let's include the thermal_core.h header.

No functional change intended.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index bc02095b314c..c59db17dddd6 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -17,6 +17,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_hwmon.h"
+#include "thermal_core.h"
 
 /* hwmon sys I/F */
 /* thermal zone devices with the same type share one hwmon device */
-- 
2.34.1

