Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88A921AA04
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGIVvs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIVvq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:51:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FAC08C5CE;
        Thu,  9 Jul 2020 14:51:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so2980871edb.13;
        Thu, 09 Jul 2020 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MapCcG3rDVQikXJqKbCdGCP4OroaHsdmgZ0eMywfhvo=;
        b=kxo+kEZr81rysbBpDW6FaEaWc84eFtf3WZtESLQTgJhmcioiOJNCN07LoVYtw3ty9m
         aOV8ViwYJs/ZYM1SFNxvCPP8rW/qI9Kt13Ij+ir4FaSMdgMNjT0ZSN+YNsEqGyPCZ7lb
         rZEYyGNCYc54RWDkk5qv8I1PlTL/QiyQoXxKS3wUPXHhESZ8w/RD6sLp6D5aOTU+mf2o
         EM0QWKmHG+T0u+blNHTf3mrJfLNvAG2WqJVyTCHb+qT8hE7eHc7zKnVZJpUjUctPMX70
         tPWWWKMW7J5gpk4kMyGKv8nOCaSohIU+YEUS9fUWIywehEOiuaBWpnoIary3ZLtdzmbe
         wqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MapCcG3rDVQikXJqKbCdGCP4OroaHsdmgZ0eMywfhvo=;
        b=WfY8SJ1xGsr6V6GcVOoXyRk/x31lWNFmEaePovHy2FOrHZMOWnGZclDUe+f8hb/wi8
         avPHaXr7MH5Md6cy3NupsA2cRz551wrnZB74pA36eAO099SWEQdxIPqmx8+MRQ+6Aqnl
         zSz6rRZkGsvftIJYIoTDV1RsBqVxHoQEmn2hTjm73T72m9CuH2cGC02dSTHT6dIdHxf3
         XTWvDq62i9V/EWEO5f7j4JWtX1JlBJ3an8j/xT50WzNMihglUeAJPcfjQX0NCPw6yaM0
         zkg+poyUVdybLmdsSoLJrvZE02vFkmvROsHS7xFi9bMvmKznhTq3CouQaRbjZzgpVDLq
         Pc7Q==
X-Gm-Message-State: AOAM532nDOgRC7TDjScAxJaGKdvbSKa77OEcJiOaUKjOqGEpdfGypgs4
        7rkOZVuJy/Decb0ei3wl1NteG27+eeI=
X-Google-Smtp-Source: ABdhPJyYiQY3Yg+GVngUKq8upYFLSVlPdZN7M3IOkn6T6KYxUqF4vxpJrpXMojoLP5kf1UftjSSbdg==
X-Received: by 2002:aa7:da8a:: with SMTP id q10mr12000439eds.139.1594331504896;
        Thu, 09 Jul 2020 14:51:44 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id e16sm2498260ejt.14.2020.07.09.14.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:44 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drivers: thermal: tsens: load regmap from phandle for 8960
Date:   Thu,  9 Jul 2020 23:51:31 +0200
Message-Id: <20200709215136.28044-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709215136.28044-1-ansuelsmth@gmail.com>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devices based on 8060 tsens driver (ipq8064) use the reg of the gcc
driver. Permit to load the regmap from a syscon phandle instead of fail
as the reg are already used by another driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 2a28a5af209e..890baf1b5542 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include <linux/thermal.h>
 #include "tsens.h"
 
@@ -168,8 +169,12 @@ static int init_8960(struct tsens_priv *priv)
 	u32 reg_cntl;
 
 	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
-		return -ENODEV;
+	if (!priv->tm_map) {
+		priv->tm_map = syscon_regmap_lookup_by_phandle(
+			priv->dev->of_node, "regmap");
+		if (IS_ERR(priv->tm_map))
+			return -ENODEV;
+	}
 
 	/*
 	 * The status registers for each sensor are discontiguous
-- 
2.27.0

