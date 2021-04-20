Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E539365F50
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhDTSeg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhDTSef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F6C06138A;
        Tue, 20 Apr 2021 11:34:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so46254230edt.13;
        Tue, 20 Apr 2021 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsKSaKVr8eqOkpvXK9OW60ORfpfmzSRm1tZjKRVxrds=;
        b=d4rHJtqKlz16XoOUweOadeJsl83KmgaprZcKHJKwzLvadt3lMmoCwF17aP22OwVK8g
         2/9ndF+dTV9eE2h+3jW6kWwCU/tpctjiQtuuV78FD2JoFj1IyjMgeLKIXMDcewvmC6qI
         71C+/qZlTjnX47wuZYhua8qt2nfrpExvgX3Jd7NNYdLLIydrZ1n7ONj4i10JLWzuU0qX
         fCjvmnM5ZJr2lyajlSpf3e8UAcy7+Z8afoUopFQ8LBwJbd2Y3RYsKibMu+QwE2prqiNa
         dVbRiyA4H3U3vVycZnn59mRqSKtI7CUrlyROEHrqjb0Z5IOXb2SzFVAqzLNZg+Ch7Ilj
         XrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsKSaKVr8eqOkpvXK9OW60ORfpfmzSRm1tZjKRVxrds=;
        b=brp/h8claMexACl6ueNWiMfhXLPzB/vpkbxzRhPCMf0Jx6JDDbXBXkaa4IWkp8GNak
         5aytZJ2RpPIgK1Sso8QIhgCYxB4GsWFpFJzWvObnccqEYVWE8nRTOf01drAQ+zYb5hNP
         YNd/irTn+e73ZXj8FA1ZPxERSjMsjjj6U8nOMuLMRFoiqZf7/Xz0nWZcJCyClcNp+1pO
         shnRyrhQASRU/kClSsfFH8VBJxp/lEuI9O4C6+8I8GkAgihlcPw4Vc0nkeO+2fgtzQtB
         9IfP1snzoP3eYS0+iF0brSGJkTWeapYnKEvm10TKin6hQLdKXPM5eUyMqAR7qplch2Z1
         gXMw==
X-Gm-Message-State: AOAM5333D3f+VSVAEjRatY0gJWWONrWOkkeCnAxMdX3SUW+Nu5H91rpo
        8s9kdZrHS7TFmdzaKkMxtH8=
X-Google-Smtp-Source: ABdhPJwVnvlTj/f73js9LWNlyL9kTBLX28ndldorz4gVTC2TLUP3EsIuATQ2N6wfNhOe7Em877HZ/g==
X-Received: by 2002:a50:eb0d:: with SMTP id y13mr6090392edp.326.1618943641591;
        Tue, 20 Apr 2021 11:34:01 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:01 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 1/9] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Tue, 20 Apr 2021 20:33:35 +0200
Message-Id: <20210420183343.2272-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
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
index 8d3e94d2a..562c438ff 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -85,7 +85,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
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

