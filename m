Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32206A3518
	for <lists+linux-pm@lfdr.de>; Sun, 26 Feb 2023 23:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBZW41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Feb 2023 17:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjBZWzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Feb 2023 17:55:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276151A4BA
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l25so4426429wrb.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G2AExiy4m1JD3VdlFvbqMiJd37t4DGUXITJCS9H4qI=;
        b=pxoj8LH76UCWOvpu+joi5qun8KjfDjYuYrKonUey/icQQfWFMlmNYyAej8zms6M7uk
         mv9HJqzgF+YBGkOjVLtdnOwYjzuYd4v6bUeha/htprPlI71Jdbe8zqqnpfkN/VpIxten
         JM+MXaFB5/z3Wf1cnGWro0y5lk85K4UCaG5hHOZRErsHoy2XrxMxwVybgLWfNKTyOBiP
         2/d8s3Mqip6n5twohuw+QLZXQTP9T9IMFx1/I0AFj5XftbLSBCQBG8Ppv/9z96rddmqy
         Fuc5AQZ/YV/IH72ik+OWUERExy1ltUny6YLOLs//Pd/L/bygRji72EaIyrHpcgE5k6qf
         wJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G2AExiy4m1JD3VdlFvbqMiJd37t4DGUXITJCS9H4qI=;
        b=mUcNIAlmXORuI5ue03Doz1j0O0Cy65Ksdr9S0aYl1Mb+aSp0BV/U/m7HUmXd4C1z1E
         upZlDYWzgymBCS68E0UsPBO6+c2G2j8X0QD2tQT9VY8NoLIFic6kOksI9V9unXKpO1f0
         xgPFUczDeYyNyz6JoDAomtMX3iXm13/42sQVoZo3vSorw7Emawf4z7zYuB86GF+K/4KA
         VnL7A6sBMiVilpCNZLzZVSiTNLqOOR2ulPtuM70FVwwB/Z7zsfgWLvXW8xJjnBqi0wUP
         22HscCFWwV17JI2JSOzKKji+j0rFaHBMGs9qFbMBtsToQFQpkAGRLi6ynP55VUAqjUGV
         Ibzw==
X-Gm-Message-State: AO0yUKVnRGX2qYC1M+Nn1thxjgEDJAz36jtZwWXG2kcBsJ0ZC/S9Z44C
        CkaMpfZeg/Hyb0FdTh8tBQNrqg==
X-Google-Smtp-Source: AK7set8wG5KNcUAuqYajmZYqUZzq90poXajeHyiBNdHj9Vb+RfJ3LGHzWpzNN3rlxKtj/jSPe9UU7A==
X-Received: by 2002:adf:fc0e:0:b0:2c5:98f2:5b1d with SMTP id i14-20020adffc0e000000b002c598f25b1dmr16746929wrr.63.1677452117251;
        Sun, 26 Feb 2023 14:55:17 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:16 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 15/20] thermal/hwmon: Use the thermal_core.h header
Date:   Sun, 26 Feb 2023 23:54:01 +0100
Message-Id: <20230226225406.979703-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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
Acked-by: Guenter Roeck <linux@roeck-us.net>
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

