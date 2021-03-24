Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB601348403
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhCXVok (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbhCXVoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F9C06174A;
        Wed, 24 Mar 2021 14:44:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so35353126ejv.1;
        Wed, 24 Mar 2021 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A96CjrFMTFBzH0FBnki24YuX02XsfjoC/hVWyeOwHlQ=;
        b=iGfYpa2O03sy2L2GYtZoHamI20Wg7B4SG80ShHCAHUfhfJH5YwDGXXoIVIem0b2SRb
         1P9GpnyVdCxrknvBx/Ko8OjFNLzjolWWdyYd27FjxmWTxbAGHVVe6tcbA+74cjDdKnB4
         DerV97GYntkufIG+qZesTyCbPYzjmHICEAUq1dwX/jDu5ZqB6MC/HZxvsZe/mNQG9ZIz
         wGyMLMjLHM1PxT6vYg53Dfk+I46DRX0J7d8W3FI3d05BwWmjQVAKKeDntR2cmEKlbOT6
         QHuUAMUYCPh1AeXa8OZHXMF+E2j6GFtD88N6CAbckmdanNLComy31iUsqcQlxQ3qneyZ
         XizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A96CjrFMTFBzH0FBnki24YuX02XsfjoC/hVWyeOwHlQ=;
        b=HuRZykL/XwPBcJUwebsmXYdPPjF+KUtIhl6Z1Saxw3v4oQeDdhEQiy1B7+1Z3it6PJ
         2sAmPNQdXWiE3ZXPWTU7hDbufO2/DLMYl162eMcSn/v3i7Arb23rOfII8KNvLB6A6ldx
         XBW/soDJjk49mq+IN4Bpuu5DmibLFfJZ6FVzW+Be1kh50tQlmctkPh7gdaETouurLOs0
         MIfbkW5S+AAVLOCnvrDRUprmvNx0POc73D73OCZORaicY0v3eqeZoJy3jOzT3Kg7c0Li
         wikbf4aAeEEqxJVH75j7171t6TOvcW1lpbnkxfZBOfLTt7vD8pbMqWEpS6MO/LAxgR01
         PfpQ==
X-Gm-Message-State: AOAM5321JTyidIpnZgBk9h+p2gpSCVnrGZgPwWqxHYWqHa/akuITA+oi
        gTIFv1PF2Rp5qz5uZtUv8dk=
X-Google-Smtp-Source: ABdhPJxTiXo06fuFJdBWdssTrrTa3r0lIOJ5hn1V5qlXLDFDdk8a06QYlbIOex50jYM7xGIBBUzNgQ==
X-Received: by 2002:a17:907:d1b:: with SMTP id gn27mr5812551ejc.227.1616622250841;
        Wed, 24 Mar 2021 14:44:10 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:10 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/9] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Wed, 24 Mar 2021 22:43:56 +0100
Message-Id: <20210324214404.798-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function compute_intercept_slope hardcode the sensor slope to
SLOPE_DEFAULT. Change this and use the default value only if a slope is
not defined. This is needed for tsens VER_0 that has a hardcoded slope
table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6b582a81358f..6da567de1db7 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -86,7 +86,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
 			__func__, i, p1[i], p2[i]);
 
-		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (!priv->sensor[i].slope)
+			priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
-- 
2.30.2

