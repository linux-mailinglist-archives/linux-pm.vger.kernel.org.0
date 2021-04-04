Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1A3539CF
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhDDUfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhDDUfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E59C061756;
        Sun,  4 Apr 2021 13:35:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b16so10657990eds.7;
        Sun, 04 Apr 2021 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1h0oiEek06TjmRnvW1TJaDu7rsgnhNEzErPgw04aKg=;
        b=WyMg4llpDHhYk+dirmTjlo5L6ARjO9nMv/pG5rQ1cw8aDVQNO1qlsr6IhlD4p6il/5
         7z9jrP0dli2MziQGOf8OJ+94NUO5c4LyVPbl+gJIlc3UgZJqCSH1nfd3f4YNBgH/kjKZ
         np6I9Hyl1P4U8/1C79jVsr6ca/v+GwbOLDR4vNMLrQ5k8XYCJWMb515+rrWYdCUKWhRP
         Ywd4PnkenTYv2k4F3fN60ThHQwW/rLTD63zNs8zfGAr710wbwjQJ/qbZ4EKB5Po85TsR
         0XYRBIIPz82Ga7h91wEdCsbnI91UrGBZFy5QIuh/rSOLAf5NCYdp0a9N/Cvrr77x3QB/
         N7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1h0oiEek06TjmRnvW1TJaDu7rsgnhNEzErPgw04aKg=;
        b=J0yfr5gtnj2SGuGI0UnyANOVQhGEsk2j3yjrtuYP+Ll1eGpG4bfZXg6EZr/bG+i5Tq
         WK3aByXsx090lnLEd/2m6IfrytPv7Ax6zN3R0uDOpuCFUk+xJ1WnBYYDF4z66uyiBve4
         98OB4mJ28ycg2OQd49GC1JAfwNKA8jVCF2znuFZVaZGGFvnr+oB6G3s/bX1Y7ZmGNS08
         OCnwt0Q2d4w9pOJXVg3nEp/mJe59XJCNCrbPE2ElfMQkTxPnXSYhqwgL4CzyiEh4e8pm
         0ioXC6xSxPhG12Pvjk7FiP3s6CbKrxH5kdId3DH/IlA/JGhxm7ffqSSJGDshFNNSpbiL
         p3bA==
X-Gm-Message-State: AOAM531h01lId35427mrAS6YJu+QJ99BJMJJLerBCDRfRa9QSNzTqdnx
        9JIdrkpQTFXfsYjXEdNsXj4=
X-Google-Smtp-Source: ABdhPJy5doSxPDqTSDD1JLI32N/uyQe8L6mCX80MEZp48J03nM50Z4bv0P2nE3kyuMGbnKrRN1spSw==
X-Received: by 2002:aa7:ca12:: with SMTP id y18mr12424381eds.41.1617568507968;
        Sun, 04 Apr 2021 13:35:07 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:07 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v14 2/9] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Sun,  4 Apr 2021 16:48:16 +0200
Message-Id: <20210404144823.31867-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
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
index 9a7e991d4bd2..38b9936def1a 100644
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

