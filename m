Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1E4B97E2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 05:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiBQEvz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 23:51:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiBQEvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 23:51:54 -0500
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 20:51:39 PST
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 222AE1D30D
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 20:51:38 -0800 (PST)
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
        by gw2.atmark-techno.com (Postfix) with ESMTP id 4DC1420D64
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 13:41:48 +0900 (JST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 5307720D51
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 13:41:47 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 62-20020a17090a09c400b001b80b0742b0so2418759pjo.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 20:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKsjr+x4bYzy8xFM4/3x570D+BJpN9nVsFl77PyeRNg=;
        b=MZkZx1kfmZLtKoLOAlD00o4E53NSl9BuzkRXu8F6Ol15A3DAI1J3c+6kgNEB7BA0cf
         LTRRlkN8GzVLza3pucKajuEc3KTLhiyFXB7soYRuA2qO827QAFXJxPwEsbFDztmz0xDx
         SYx/Sr4vHbVUmbz12onTuvqfvGF03woKVLw6v22dQ7Ok35Hirrv6A2ynONMoFl0/oJeU
         zgfxWAc/d5gT9s09ikK84Z21zKUFKnFiHBsm+BHkNjZC+tiYiyQIPlj1dRhPFaCGenN9
         ukoroKLxirY2iwQp4tR85dgOrkFS86nGv7yGkr3QsV3wlVrwhcM2Vz8Jqa+J3sMVn271
         gv0w==
X-Gm-Message-State: AOAM532WsNA7/drKSmoTpJTTp3+nh3OxGPUL+y0yEE9f4viyMnhZxEab
        wiYE7DdB5aBha5hzv9nkReyG/vuOy2RkDTg2mmfEuSi4Kr26UnK/ceV5iygI3+RScTBCQXi7a89
        rlgGXJmryVPGmKF2b1yxN
X-Received: by 2002:a17:902:9a8e:b0:14d:ae35:19f9 with SMTP id w14-20020a1709029a8e00b0014dae3519f9mr1269994plp.66.1645072906409;
        Wed, 16 Feb 2022 20:41:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYHbGg95GLg8jdxKJTeG6Rw5yCJLRLB3wzOYl/Ms2jX2K8wdo8xn1KWLpPl3U31H77CuOH3A==
X-Received: by 2002:a17:902:9a8e:b0:14d:ae35:19f9 with SMTP id w14-20020a1709029a8e00b0014dae3519f9mr1269975plp.66.1645072906139;
        Wed, 16 Feb 2022 20:41:46 -0800 (PST)
Received: from pc-0115 (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id j15sm48674401pfj.102.2022.02.16.20.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 20:41:45 -0800 (PST)
Received: from martinet by pc-0115 with local (Exim 4.95)
        (envelope-from <martinet@pc-0115>)
        id 1nKYbv-008JBg-6L;
        Thu, 17 Feb 2022 13:41:43 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Petr=20Bene=C5=A1?= <petr.benes@ysoft.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH] thermal/drivers/imx: add missing pm_runtime_put on error path
Date:   Thu, 17 Feb 2022 13:41:32 +0900
Message-Id: <20220217044132.1980370-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211117103426.81813-1-o.rempel@pengutronix.de>
References: <20211117103426.81813-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We took a reference so need to put it back when imx_get_temp() returns
EAGAIN.

Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
stumbled upon this merging our stable tree, but I don't actually use
imx-thermal so haven't tested it.

 drivers/thermal/imx_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 16663373b682..641f90f9c750 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -265,6 +265,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	if ((val & soc_data->temp_valid_mask) == 0) {
 		dev_dbg(&tz->device, "temp measurement never finished\n");
+		pm_runtime_put(data->dev);
 		return -EAGAIN;
 	}
 
-- 
2.34.1

