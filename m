Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F56A7509
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCAUQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCAUQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 15:16:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C2497D3
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 12:15:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az36so9395192wmb.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=S2RD3t39aOcAjADtvbfn2VOvpvaTF/lJry2CokRv1cbcRY9sR8q2wa0e6ifexfGhVP
         6qDOnbMxuegflcU5lSO2YwYpN5dpXp/qjdWxsHaGVCmw6mJXVvWRnaAuEWvPjPrhLVYy
         g3l984PPao4CAPL7k2m068EP0zrDricnkqPUQ8x6IiHtFFsxICFggHpQTctZKtkK3hgq
         xygC8Q4ak+4aXJHv/W3Q2uKRzysV1hORN6vzHFSoR0klSVjYbxUGEgWgjlIpAj964NNE
         pDTKWfRnBgN4S1d2vRCtB04R5xHGlGbRhQiJNNc15ddBm81kD8Au9fnEIvaokSS/yHxR
         runw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=FYEKnVD02s12RjSPrAvepMS6ZY7M+LX39nLoVp37h2x7zrgkR5Ve6Ixxc75urMTnOp
         ZljMb87gcQar6HwA9A6eXhXpca3B9gCueFWdcL+cQeJrFGXbNvNugHx4lwJJM8DEGXgd
         pnlITPhPZyz0Ef0zbiIee1N5gQW+wfnZAWTPvbDJzvUwkSoxZmUvbuoUSOzB8n/1z2zE
         TlciraW06Jblt1ki/AQ+goDTu39mx/sOpENDQeC+rmXPAg06C+0lU1GlIBxVlKXBccho
         Goo+Uo2I3j4nAjQ2ktspvYR7gv+8hco9NZR5GPyMHTUtaLBvo2kALiJxwyC+0AhcpCRP
         YKUA==
X-Gm-Message-State: AO0yUKWSCxgAixirST8vp7Y9AeBmv8P90mt+KFV/DHguZLouC9Hfy5uR
        gM9zD7/6MAhe8q1B3GZWna4Xmg==
X-Google-Smtp-Source: AK7set9Z1MVQyYdm9AeVnKhEPeO6y7ydvQ4G3I3+bUnrRbQlbWRAA2vhkypDegGjRCb7Ey5Kj+Idcw==
X-Received: by 2002:a05:600c:4fcc:b0:3ea:9530:22a6 with SMTP id o12-20020a05600c4fcc00b003ea953022a6mr12712060wmq.1.1677701740585;
        Wed, 01 Mar 2023 12:15:40 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:40 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 11/18] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Wed,  1 Mar 2023 21:14:39 +0100
Message-Id: <20230301201446.3713334-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
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

