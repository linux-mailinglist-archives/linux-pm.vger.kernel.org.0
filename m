Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9A58E26D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Aug 2022 00:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiHIWGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 18:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiHIWFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 18:05:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF15BC22
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 15:05:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q30so15718723wra.11
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ME7U3FPobKax1KYwLl1XPXCJbdioC2XXIlGU9MgSMCM=;
        b=AIwaIKyUSk71dsbeRWyNOHNl0rH1HMHpN5A/4SEtFr3f36+EXXcPbMz5QElDntdDqj
         lGsLljvNfv5u8GvPucPOF0SPBq1e2CdtKmikEZYEYYj5FGWi/R01dj0Bx+6XpGRh2FVF
         AEo1ppEhb6AdKpgwaPwFHOuu02KPWcjLATTv4OQi3XSgUIw1471vxV//w/WlSA6IILDS
         vjveXFYY9Z58dnfLZfDk1LRYjjlAxOGj6UsC1X++oM83FtZvZRzRtkqPYYcxqiFDVIsc
         mx9SiWDekV5natM+1D3gZnFY61OO6s2zUMbJC4eiAIE28ETC9rerePguzqbgxfXKsSTt
         I8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ME7U3FPobKax1KYwLl1XPXCJbdioC2XXIlGU9MgSMCM=;
        b=iMEgdSe+BI3t0UqotvkCUZm7sxmaVRoOg1VsV8CpCCgKDkXyloTwGNUzf3c2yYtrRj
         U8ro7KCwpPqptxPWnsDE6jvdAxub6lrhvQx7atmdedDa9Gv20UGJrJSYgfTTRJCrC1/x
         uTb8gdqKMwODfVenNMM8oRHkkNIwnq0/62JeGPMC4pclcjNSK+ggfjIRNQ1kZ69Z8cWr
         UiJrfjjZSZfw9ilR9kPI87zR4RY8M2QjlhKGm4mzJ5NnZt+3wh+oxBOd19Cjc6muVNmS
         FukQaXbACxceCi3pRurz1/8hd4rkewPcg7r+lfAS9E1GUKgcV8OOOHUyqx7P/FkadGpS
         mSXQ==
X-Gm-Message-State: ACgBeo1k+bGF3BxGPjwWa/3VzRjYuUlZd4eSw1Jf+128PA/MpQC3rlGQ
        2TFofARy1o3mCw7U7uahWTrcHEmplUms+A==
X-Google-Smtp-Source: AA6agR4nhJw1P8909w3i5RuVBXtWc/pf3Uc0ZiMHJ2uIWaxBL13m4Qc3X+C5zA4z1Gk3B3ilEX3CZQ==
X-Received: by 2002:adf:f282:0:b0:221:7a12:7a48 with SMTP id k2-20020adff282000000b002217a127a48mr12287080wro.459.1660082716783;
        Tue, 09 Aug 2022 15:05:16 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:16 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v2 15/26] thermal/drivers/rcar_gen3: Use the generic function to get the number of trips
Date:   Wed, 10 Aug 2022 00:04:25 +0200
Message-Id: <20220809220436.711020-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
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

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 40ec63ad0a1b..6a6aaad2bcac 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -525,7 +525,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
+		ret = thermal_zone_get_num_trips(tsc->zone);
 		if (ret < 0)
 			goto error_unregister;
 
-- 
2.34.1

