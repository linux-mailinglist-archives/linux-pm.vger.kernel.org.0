Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEA767AED1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 10:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjAYJvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 04:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjAYJvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 04:51:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78F3ABE
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 01:51:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so16426288wrz.12
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 01:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCD+Tet020QcCYVXiaAHhZ6T43mxf9NGXvGcAhM5Bko=;
        b=evdFUzWQ1Z6fmorAAHX/2rx1JsI1ucqR/2YMkGAAzJFPBQG40c0oaoquu3sfWeDTD9
         3bbW4b1CwJW2ZtdWk1rskgF9jbFqKw3nADhOCTcIMfnjYXu6ZIy189AvlcMMHgvDfJzY
         9afQYjTJqO9rdAxD9pEToliDpS2q7owdH91h9+JBz1LbNAll9s6Hgdia7e+DWdO+w3y4
         Sa0NSD8NOfnnL+oK/62NjEgHOpuCEJCGAlnK5JxTKv14/TerzMWhOLbvVwhYti7mQztX
         CFEwt9AP2Kw+GhKwzuBAxI734uWRGbh4f9+9kYKnBVb02juwMrhdxeOFZh5DSK7RuYiZ
         KJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCD+Tet020QcCYVXiaAHhZ6T43mxf9NGXvGcAhM5Bko=;
        b=IR/TBsCJYhTTPdPMGEPnt+NOJGZVOrre4+FUoaI7ex9uBssOeEqhdAAGnnKt53ji5k
         q0Dlb+7glj9wDO8fjsrxkx9LvJTHywLtBOJfpCpC9A79FPiuX0tfFrk7EiP6mCpj4a1c
         LxJUWrfwQ9g2x7ExKDRSdHkniZrcMd3Xwjx6aofnE3BkXzGuxtYjxkJpFNFAeaZ7V2fT
         RenzPDidgF11r+GTDgDLAj3ntVFNskWXQ6vUVA6uehYvqWvLUIx4qzWel13eEF5UU440
         APbbb2aU6jaX3Q8cCCaur+5X20uvSyChGvX7n15OiG6H1PSNcbzKSmB2o6/njIXVHNH7
         N+BQ==
X-Gm-Message-State: AFqh2kqlmlOWHoiqghm16uWLaguRkE7nthzcCipOSadBt1IdNWKrM6Zv
        l44EAvBoUnLse4zdvHFi5ZUYKA==
X-Google-Smtp-Source: AMrXdXtW4LbC59RXC+dBFm0EBBki8tu4RWZohenwoLSN2vVO4YuGlip37uSG6yoG1MbxuFzynf8qPw==
X-Received: by 2002:a05:6000:1e18:b0:2bc:846a:8ead with SMTP id bj24-20020a0560001e1800b002bc846a8eadmr29665011wrb.37.1674640266621;
        Wed, 25 Jan 2023 01:51:06 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id j26-20020a5d453a000000b002bdf3809f59sm3955072wra.38.2023.01.25.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:51:06 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 25 Jan 2023 10:50:33 +0100
Subject: [PATCH v8 5/5] thermal: mediatek: try again if first temp read is bogus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v8-5-23e8fbb08837@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674640259; l=905;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=SvQ8R3apCWGsjdAHgfNQVmNogbxTjihw270BNNJBqk0=;
 b=pkHFI5a45MlA9rGXHv3vKkA9DV+cFpeLSRC2m5W4FWHIP47gcqAI0gZg8YNrfVLt5u+BTkZkthhA
 AcisRwV0A8EpqInMTUpFXoe4B4+xb7FfJNqyqIZ9hzAgaCL0DM3w
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In mtk_thermal_bank_temperature, return -EAGAIN instead of 0
on the first read of sensor that often are bogus values.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index b8e06f6c7c42..e7be450cd40a 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -736,7 +736,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 		 * not immediately shut down.
 		 */
 		if (temp > 200000)
-			temp = 0;
+			temp = -EAGAIN;
 
 		if (temp > max)
 			max = temp;

-- 
2.39.1
