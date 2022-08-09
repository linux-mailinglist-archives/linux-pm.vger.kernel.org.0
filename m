Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CC358D5D9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbiHII4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbiHII4h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 04:56:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF022526
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 01:56:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso6358961wmc.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=E7W+A8RBq7Usp9JU9F1Ru53gxwOjNDrCjAkC1uG7hB8=;
        b=duOEo4jhZ/rVYKJMgBewxuJ1d2OjLLB769TXL72ui4HlLcAbsyltdnaPxgFHaSeQOp
         T/4Ixk9KUpJLPo8N3EIVlfU5+6ZM77l4+azpSuREEeHjvMFyRzSrzq/arC3dtssTMSvN
         2XO1ZSI1YahN+1jmOO/89WFcXRQ0AB5rC6ce8Vqom2h9FBNQ+gAM/BIYErKSr2+MGuAC
         0gKJyUQT2Vldz713bUkaGWFlzUr9z/Fgy473spa8Lr3BMnOZTXmZhPXKRTtTiybHVCx8
         K6ypLaCEaHHxN+OHVvNBqmpOpSFDoOLBZEXB4Nhrv4Hb3lkCMB0cPqI57M+64vOBu4D/
         arIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=E7W+A8RBq7Usp9JU9F1Ru53gxwOjNDrCjAkC1uG7hB8=;
        b=v1nefWXInL3T23ovZHJC7Oiv+pBjTIt/WiKsMZRlWzaVyyZoYIUT022MXvxkgNq+xj
         O4/SAxQxHAQ1yVaXN+NTpL/2BT5o5jwjH20TX2XsUv00S7zYc4vJxkSJnDr+fUx31koz
         gnqzTWuIw7GrYgXuQuSoFWYhqpmSrLQ3Y2s6Iz+Sso8jZctjVaytysB3VCxLe4/ColFX
         Pw9jXY2lOGrq0x4dhi3fN2Pt8FsM21zPIsJOBtjdi9/l+7LTvoqqScgUrSwuVFB/yJJ2
         VMBKVgN72ufPh80mb5JetfhGhiMiCwVgwZ1WZqOj2k7GUDg52WNyT+TIrgLsC10Filxj
         GQTg==
X-Gm-Message-State: ACgBeo3HoIj4VCbf1B5HQTStnVCNmhMwkAA+BEZYc882m7ez22JXJrXs
        +Uipc+0T6L5VxDClX2DQW/4qwA==
X-Google-Smtp-Source: AA6agR7z1CJ1RF2MrhdQknTLEgot8gRvIjx/js8TvCI9KcAmyLht/K30vPbEOddZTV0NfOKw1c7L1Q==
X-Received: by 2002:a05:600c:5021:b0:3a5:29a9:99b4 with SMTP id n33-20020a05600c502100b003a529a999b4mr9404360wmr.205.1660035394743;
        Tue, 09 Aug 2022 01:56:34 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe705000000b0021f1522c93bsm15746147wrm.45.2022.08.09.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 01:56:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 1/4] thermal/of: Fix error code in of_thermal_zone_find()
Date:   Tue,  9 Aug 2022 10:56:26 +0200
Message-Id: <20220809085629.509116-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

From: Dan Carpenter <dan.carpenter@oracle.com>

Currently, if we cannot find the correct thermal zone then this error
path returns NULL and it would lead to an Oops in the caller.  Return
ERR_PTR(-EINVAL) instead.

Fixes: 3bd52ac87347 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YvDzovkMCQecPDjz@kili
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index c2bb5954b21e..368eb58e97cf 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -368,6 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			}
 		}
 	}
+	tz = ERR_PTR(-EINVAL);
 out:
 	of_node_put(np);
 	return tz;
-- 
2.34.1

