Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A656492D
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGCSbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jul 2022 14:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiGCSbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2022 14:31:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8EC38AB
        for <linux-pm@vger.kernel.org>; Sun,  3 Jul 2022 11:31:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f2so5054631wrr.6
        for <linux-pm@vger.kernel.org>; Sun, 03 Jul 2022 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7tkBePSX5yj0NYkrN882NXSd6Nnb35TSjkjDJbwv98=;
        b=OON/Z7AAVnyojhsr41KEKcatST2zK4gWTUcHL1cZ/7LMyF0HO36KXoI8zqlqrmomcq
         hvFKBGqufPChB65qZ5rc+IK/KXhwyKE6U6e9W8IAaSf4w602kjXp+esQxUZXdCaThAft
         OtsUAhD8B06Xow+9XQtSgpTaXeoZYfUTHuFcC3X2Kj6Lisk1i+9cOyMVmNMxU21EqQL0
         U5kSlzER5281yybwwkF/FXoCuREZbOz6b3YvQ+omlP9wPpNiAeqXJiWmbwcb33ZbTsgc
         KkHQmyxcg4hFcmcz514grNq0xTxx+e94IvdxZvNx2Rxx160DP6hEm2XF+QcbbiyQmB5z
         5Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7tkBePSX5yj0NYkrN882NXSd6Nnb35TSjkjDJbwv98=;
        b=XJvsqDxXrPcV7p6WUd59gQz1U2xA1FEH/Q68Orzdz7AlM56mdNn/6s5aUHgobK99aW
         f0sbgt5dFHfA3hFMxQQaLeTedD4DR7/ZHW5s9JRS8iowuXp4i7NM9WQOW990aALJdPnw
         vWaoaDEnRGXhW6eNU4HVEa1VYm3ygM79cyzQT3iVWI15Re36iCuE9vgYT+RhDZ5herRH
         qS5gqIceLv/U8wRF6w+Igmzb7rCBi1wNbhYJWkZ1AzZQBdUreWSYcaUEVqw7AV6hyleU
         SBA5hDqbMX9vo5RDSzOHeRHjEXZxspPSLp7UpcIXD0h7DqGtBvIq5w9aD4X0kC1qQRbL
         2SsQ==
X-Gm-Message-State: AJIora+UwYHVlddNCvWQ0fTCRlJP3O+m50f4l5dw8mDeNgdfjrhWWIGg
        TfUIX0POeYN2sFalfjaRWDoi6w==
X-Google-Smtp-Source: AGRyM1vQL3HGL0Vws9udKWsxWTNMjoaqHFdx81oodzRiBuGENGX+2oa2qUlISSQdiYlH03PGZqXPsQ==
X-Received: by 2002:adf:9d82:0:b0:21a:3906:59cc with SMTP id p2-20020adf9d82000000b0021a390659ccmr23609554wre.289.1656873091448;
        Sun, 03 Jul 2022 11:31:31 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:31 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Date:   Sun,  3 Jul 2022 20:30:52 +0200
Message-Id: <20220703183059.4133659-6-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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

Different functions are exporting the symbols but are actually only
used by the thermal framework internals. Remove these EXPORT_SYMBOLS.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..f4c1e87ef040 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -39,7 +39,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
@@ -228,7 +227,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 	mutex_unlock(&cdev->lock);
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * thermal_zone_get_slope - return the slope attribute of the thermal zone
-- 
2.25.1

