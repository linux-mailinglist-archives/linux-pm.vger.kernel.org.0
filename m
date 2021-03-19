Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB34342446
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCSSP4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCSSP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE20C06174A;
        Fri, 19 Mar 2021 11:15:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u5so11195604ejn.8;
        Fri, 19 Mar 2021 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A96CjrFMTFBzH0FBnki24YuX02XsfjoC/hVWyeOwHlQ=;
        b=lR+sCBO+kPdLOIMk3Whdm1uElZq/eN0dGnWH3duwpCO2+2dqBht1tO1mkiubB3ODak
         GtI3JWvqkkStqv1EFbPjIrFfHeuXCvvD/kr2Dmqqn4mBfJE+NWnh0/+iOWRLOinkP+RG
         MgZ6cBgBKvdyNO7gycJfo4nR3ME5IYXItRCplHOk6/ajNprsWts5tMCj4Gd28f3u+T17
         nETFSvCQZ58fzTfj1kud7JJ5riREpEuFSS/IQlbvk8gqKEYxB7iCHCXQJhu+LHEDgyrp
         0EFemzvM6KdHEkykgC1JUS8+V6zTmCsbx8eyZGT1YeDH43fwoxlGeMzZhg5Pu6R1VUkL
         y8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A96CjrFMTFBzH0FBnki24YuX02XsfjoC/hVWyeOwHlQ=;
        b=fSj8OXpMwOmaqy1ciCKWl0lpnBhP23BbshP55hd1Vj2JfGZAdAUOstNJc4PErOnGMI
         5HH0NHG/cEbXra2mmmI6LrQfTBXQL8MNtcqUS1ovW2Q7ib8HDjah9r54Pd654rjiMNtU
         j/3Y5ux31pj7cw5IlJzINfq3NzgqQXYZnX+OrYOYy1ue4MAxuDnNi8/hU598uF7VKVew
         OE/cYhw4dtElO4AOuLjzROEc2uGtv7bB+LOydW2qP6hy26FzAikVu/NyuTrYymsR4jLV
         +kdQ8yJp1K1kdY8+XULfx/VrI29RqMt41kjTlyMXjp79n8EdMdBgqTmhGRwL+8R9dpLk
         C7Ow==
X-Gm-Message-State: AOAM533z4NjADrQTRQO2D5tLeM9IjJ2cz3n9TbvZp/16IWbQ93GXOqAC
        44WCnQX0uCH/r+46EPX+l7At4dmMxUI=
X-Google-Smtp-Source: ABdhPJx8KZak8cJuZTQRpw0NOf7Aysh0YsAnPVodEumaObBopKNm1fQXfzvzctyV+KB6s+yddiGCwg==
X-Received: by 2002:a17:907:7249:: with SMTP id ds9mr5960645ejc.9.1616177726047;
        Fri, 19 Mar 2021 11:15:26 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:25 -0700 (PDT)
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
Subject: [PATCH v12 2/9] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Fri, 19 Mar 2021 19:15:05 +0100
Message-Id: <20210319181512.7757-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
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

