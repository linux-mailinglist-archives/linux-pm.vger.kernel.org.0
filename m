Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741F631E39D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBRA5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhBRA5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A4C0613D6;
        Wed, 17 Feb 2021 16:56:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so813069wrz.0;
        Wed, 17 Feb 2021 16:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aODJnBWLl8hfyAiqJAUoM0/YHMzRBZUe+DHN70LCv5Q=;
        b=jKJjGYIXq/0jUlXrWpSABJl8tOeJVGEUuPma0wgCi0U2AqdLrLNLZACEIcmAGVlQIp
         VCW49ciz+qv3T+Khkjebc+xMqGCP2GHryGxXqPcYsaIeq0Anxksbx7TPM7pTCevp3fuW
         Cd3ZhkZYIxDmObriSjRgSSiy48IuqFD4QsDz61ew9Fwbgn1XOBGfuQfTzBkWzmUWQEd2
         6ZM+xiFgOOk/yNhbZ74FJuxuXn/T8jxM5w1DNWI5m/OuwDqoICFNYpGQqrysH3gNELfw
         AvUqJucCHSYoNWEPNB88ZI2DTOdTq2d12YxtzC9DscVZH3SUDwKENEKwlCSKydP2xvBQ
         VXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aODJnBWLl8hfyAiqJAUoM0/YHMzRBZUe+DHN70LCv5Q=;
        b=NQGbWkrgEo7yL5YfNExw9+lFSYxkfRfUaXhn/nSoc3fQMZw+6mi1j0nRyFxNWP1vkV
         mHzf6qX8Bdb3k7lIJfC5C+VErG1SR+PnHPUZ35Gzs8oAMPy7waSV6Y1wc0VuhlYBGQSX
         Vhr6XhkdiW6tO0O8Jlxc3+koyclfIi6zd/PWBY9jHGv67h+mvkwFYphLrHns0VgoWxYj
         VfXBciMdGvwrav4SH7DQmSSvHmwphdFGdmXCi73mw8lYDDqouFBP2gGihPuFd6sxDQfk
         jyXQL6Z3fmlhmbfZSOSBOrnUBBphkQH9hAYyJtOpKYeIqvaVjlt+ohMKMt2JYAs27pZe
         3v5g==
X-Gm-Message-State: AOAM530UjXsSniBdMHxKvuAHL8Qjqpapw78s2OnTutqtE/HXWvvW+1n1
        FBY0MPHss1WvIUYraBo/T4atvBQut4U=
X-Google-Smtp-Source: ABdhPJxX59xJAGLNDT3G07b2xSLFLXdFQIj+uzqpp0r7VWRHR+1JIlwX4CK5Vvo1jVcEOVrzoGn2zg==
X-Received: by 2002:a5d:50c8:: with SMTP id f8mr1670043wrt.69.1613609781627;
        Wed, 17 Feb 2021 16:56:21 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/8] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Wed, 17 Feb 2021 20:40:04 +0100
Message-Id: <20210217194011.22649-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
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
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index f9126909892b..842f518fdf84 100644
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
2.30.0

