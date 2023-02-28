Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23856A57E4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 12:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjB1LYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 06:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjB1LYK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 06:24:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B238E392
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l1so6285572wry.12
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=GBsd0NXNUhijxeivp3xGCAeUf73T7L6PKR4bCS5NvI/hSzveAraHZExaJQ6eSdvL0p
         CCk/GCypFfO/BKSb8RDnPRl43C4TTnUrHGeG0YiJ6qYWLdvpH9IqnHDBELKadVvv+fdW
         zmEt7DqPl7XIK1GVjZ9SRo51pthKNx3qye9N5MsR+x2SWD7ccn49oggJYYQr2ddjz2r4
         r5yvaZ8KGHhywMSJrWS9a0qRxxCWOrNKnDL136X558eLDSldq7nd2dAUGVW7CBuhO0d3
         cFBF11QxpLcnLF70DFiFjUyDU0WikxilpXJDwe9A6A754G2sb5YOnSm1mQgO+a3qkc1x
         JTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=7VhMMHrXme9DAwbb50IZ5ZxXzg1z8Q7Y/2jLu21MQ8bArzlSwPX3dJUQQnkX2r93YR
         AkkHugXIgagDY+GR4Kg7t4vEkzqOLXY94eFm2Es8aZiCC9EexpET68/e032qveqWcYly
         YqUr/PRIHe2Epf+r51IDWG8aCs8RWesTpzoMPnM4mq0cJBWTY+rEZL+OvMQcoCDMcdbC
         f9b2rdmZ76No+PC66J1L1RSkzF0LZK1ToM4dHIVg5CZa2HhiKW10pVu5WWvUpjFknGq3
         JncEX/jbmtPFa6n5/j0vK8ywuQ/KJbOITfSrMYXY/tGw3kZAthWDXFD4HGY4WzlJVi6C
         GFsg==
X-Gm-Message-State: AO0yUKUDJb/QTCRMJ5jnpqMxQlMeBm2mcrEPoaxCV8Dk20ae1PmuQTHm
        KBAo3E7rCH3g5RSMnTwsbuFryCqz6nV4BX10Xig=
X-Google-Smtp-Source: AK7set/Ed4065AhzmY6aCza8xR3sE1ZRpBzfxfCB21rhprs5f/Z6scpfE2HJxOG/un2wkPzfUvhwPA==
X-Received: by 2002:adf:e545:0:b0:2c7:cdf:e296 with SMTP id z5-20020adfe545000000b002c70cdfe296mr1758873wrm.66.1677583410296;
        Tue, 28 Feb 2023 03:23:30 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:29 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 11/19] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Tue, 28 Feb 2023 12:22:30 +0100
Message-Id: <20230228112238.2312273-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the spear associated device instead of the thermal zone device
which belongs to the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 653439b965c8..6e78616a576e 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -137,7 +137,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spear_thermal);
 
-	dev_info(&spear_thermal->device, "Thermal Sensor Loaded at: 0x%p.\n",
+	dev_info(&pdev->dev, "Thermal Sensor Loaded at: 0x%p.\n",
 			stdev->thermal_base);
 
 	return 0;
-- 
2.34.1

