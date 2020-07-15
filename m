Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983E12217F5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGOWph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGOWpg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDC8C061755;
        Wed, 15 Jul 2020 15:45:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so4707833wrm.4;
        Wed, 15 Jul 2020 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQxWpRgQb3Xq+P5ehR8ew7q9vK97Ab3OJ4StJNb/DKE=;
        b=Cc3Q0MhlbMUqI2mmJ4bjZ179I+46uu9zKgkpNPgpJOm3L/hq/V0QhAJdofKy6Z2OVT
         eL+NI6Nl9UeopwhGW+y7+LPnEJjBE2wi4hri9+3ivsQ+LoBV7yxSWNFCogPIlVcWAfCi
         pArSktSFfGpBXCXIIQzVOMUrh41iHsFQin8wP1ep2mhNzAB9h9oJDDVssuyUVe5aSAMA
         bSkP9E8pPkJ1d4A38mwCK6THKgNXYBj9hbw+OHYiKQZvTFOc63rXufRT9DGc4OBTfXUh
         TwQ+cLWaKUYkXRbIHGiBeaND5vfo4jGERYu5MUGeOspSoWVi1kH0vyV7a/EBhykNVUu0
         U8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQxWpRgQb3Xq+P5ehR8ew7q9vK97Ab3OJ4StJNb/DKE=;
        b=saRxwr8MjYBbUN66wYevt4LptoYoqN5Mh2c76qu7HtaVPKbpZh3deevooSf4MSS2B2
         jVVSLqlRBlgVC4LHlNiCInZffrFu3IACBkrGHgA3J5nHOHGtCFLBGcZMHqR3eE8nlt7G
         pOBv2zaMkspygT8S2Vj9bH3hoxxv6Ca77NY/AnTu48jo2QAxXtn1YMw+mM/jjtUuuFgg
         nFZAB9a29ES3ldz6ItrzzM6ynLrQvHsLqrteayJpctCa9KN7E1nUvrJUkdaRlWnicgP0
         fV9PscJcPfKkvll+zMohddmGRI74RZe0ofNGXt9hxUkrvoY2d+cedjjoWThhlpZSS4gK
         ewfA==
X-Gm-Message-State: AOAM5337E+u6valFzzKtrwxWLbff7Xt3tSUbqllzRdC2KZ32Jpj1t/16
        HnIEL5SeiyWdN2Bh4YSZ/zU=
X-Google-Smtp-Source: ABdhPJynPlfZ8E65vRGR15Zc/F3arwLCSga7YwW6ZqouIkPDIQavfVH4Qflw3E24rqBWyWnXdKz/EQ==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr1939480wro.201.1594853134203;
        Wed, 15 Jul 2020 15:45:34 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 1/7] ipq806x: gcc: add support for child probe
Date:   Thu, 16 Jul 2020 00:44:56 +0200
Message-Id: <20200715224503.30462-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715224503.30462-1-ansuelsmth@gmail.com>
References: <20200715224503.30462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for child probing needed for tsens driver that share the
seme regs of gcc for this platform.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index a8456e09c44d..d6b7adb4be38 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3089,7 +3089,7 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	regmap_write(regmap, 0x3cf8, 8);
 	regmap_write(regmap, 0x3d18, 8);
 
-	return 0;
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 }
 
 static struct platform_driver gcc_ipq806x_driver = {
-- 
2.27.0

