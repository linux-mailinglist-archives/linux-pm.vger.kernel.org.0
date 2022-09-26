Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C605EAA52
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiIZPUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiIZPTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:19:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D57C1D1
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l8so4591250wmi.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XrpGuF2vxbaEuk6VfKG2/A6XesW21KLMiogPr2+Ux0s=;
        b=wWv1m+XXCoVQHb8PDskWeYfQYLfcMm1SCoVxR85JW/Ecblj4tvHkHfBE5gF13woWHW
         uGnvaL5vR1TiZeybhAcNf45ADUOyIierTlgELJRA30Qb2AD+9Cmt2TxTbfvsXf8/O4ti
         C2j7OY68Wg3u8lyMynjHPw/7ts8QcXTAs0pcDZNewijPNrpt7Fx2uskzRbZt8qIprK0r
         wKpXiNHKmOg8uWn5WfJGP7UloBuHgkVNYeLOtNiTR6unUWICLMaoDM9QIJDnUVtv7TGf
         hVy+AyEhmtH9nMzAv1pt29EyYAAgCoJ8N4dvLOepmayWa+z+YJRBCU9kn2Fyq+5v1jBB
         eKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XrpGuF2vxbaEuk6VfKG2/A6XesW21KLMiogPr2+Ux0s=;
        b=aLSqn3nl4QmznTARB3aOzbeKm/5FQJDZmiXmESwB+nqlwmUv+4EXMQych2hcKrGSDJ
         f0WnV0eK+EBh7AOjg8x32+RzhzSKu345O6xdXXImSv2CShQbKbQfW0bZaM4eWRuocfsk
         l6ZIYsgbXePmoMQL1tyYNIBN8udnRuq1qIgtjgeVUVlA0HPSUwlVsZMNbWbgdf+u+pQH
         TeZJPq8PL7POa2RcFlFLGX27k+eHouIpyrfHQcc5aXnnzO+zqSOaclVb8s0TJ2p/Djj+
         1dRIidKWCcVysjfyDTBOPBGWibCZYQAc3NKCK5SLFVUGPkbk6upTLv7d0m3LT6bpfH/u
         XvLA==
X-Gm-Message-State: ACrzQf1LAR2jnV3HGbD6yLtkvGZvtD9ZC9F6oWU7ihnA97k7tP2xrTLE
        eq9rg5QhNegPG/A7obGKZFXiOw==
X-Google-Smtp-Source: AMsMyM4XD9QOxU0BEk9+OLqsbpu/aWVwF7Yy9OQHxWQNqCOXN85C7JYpF2F4vQjYYL6iva8Dwj5c7g==
X-Received: by 2002:a05:600c:3c89:b0:3b5:e3:bd0f with SMTP id bg9-20020a05600c3c8900b003b500e3bd0fmr15666943wmb.199.1664201199365;
        Mon, 26 Sep 2022 07:06:39 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v5 16/30] thermal/drivers/rcar_gen3: Use the generic function to get the number of trips
Date:   Mon, 26 Sep 2022 16:05:50 +0200
Message-Id: <20220926140604.4173723-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 4c1c6f89aa2f..4ef927437842 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -529,7 +529,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret)
 			goto error_unregister;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
+		ret = thermal_zone_get_num_trips(tsc->zone);
 		if (ret < 0)
 			goto error_unregister;
 
-- 
2.34.1

