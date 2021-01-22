Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D830079E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbhAVPm6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbhAVO4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:56:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECFC06178B;
        Fri, 22 Jan 2021 06:56:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so5376042wrz.0;
        Fri, 22 Jan 2021 06:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TJ+/IkMxCE3Me3OscF6ay8YRP3qL8IEtjgxoP99DSE=;
        b=cxHyY/FVCw/X5svm8Qu0VnrrVJEGOazWmHO4CB17IYWyA0fsxqZCY/QYNy4YyKEJeT
         aU20Dlyb1VDlfbF+gMPP5TE8Ng/d6b9PrI+8QkXqpjYuN2sLY6Hf+B3RpM0jowo9Mn/g
         9IPbvXl9il4Xj79wsvAnFlb/Ej5O3/VqrU3o7AjIdJ0ImxLWtODdGkYqmaOn/3VPcabf
         336K5SklrCsdAyxbvvs9nYi2EwbbZ8IZtYhEDJVyJ6NGFMZ2mR8Hh8jgMT5uWyir+RK2
         1BOJ7Mi7KTHEH6hZePGKlFvWXy056xPJ8lVtATmVHaGCW5pODM8KMJytqR6DL790PnLg
         0y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TJ+/IkMxCE3Me3OscF6ay8YRP3qL8IEtjgxoP99DSE=;
        b=WiaPrGs8OihYOZMPc9lQJ4Hwq9tB7TsNtmlCdOLS4O/C2HrcwNGW/tr7FpOX91usRN
         Xm2nJZvxUspuuJuQlCP958oz8IvCyLFPIIOGyDpcwXIffNJ0xn5lovdVpgAl8hhSPo8q
         H56JKZxD/MWSBf9cY9lTIByHnjEse6OOsBT3KWy1/wS42bTAn5UNN14BDSLzFD+ltaRn
         B3Ml61an0ZZ3utpC6sdVFwwsD8tPaVwfEtloeNV+jQ51KS2zwk1eO6ycIaHJvrnGx+CV
         5dM8SzDZZcFhuG5r2IfWcEXMSu9DVHGQSGgC7omEZJePqg6+ijPgOr6uO5BeKrWfQc2e
         0x0g==
X-Gm-Message-State: AOAM532RbKXd4P9UPe8ge9xxp0Mh2u571CIpgiiyBiuCxlDu7dbDroZ9
        a7WpbLnLl68D07UAE6tqiGUdkAggk5c=
X-Google-Smtp-Source: ABdhPJzsO04XZDJRgeeAPrSvIZafo4LUEtAla8FgFzhnj7krLNREArmsRUIzWiFcTUHpdgQerj0epg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr4744207wrn.79.1611327369963;
        Fri, 22 Jan 2021 06:56:09 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:09 -0800 (PST)
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
Subject: [PATCH v9 2/8] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Fri, 22 Jan 2021 15:55:51 +0100
Message-Id: <20210122145558.4982-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
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
index eaeaa1d69d92..dd9b41157894 100644
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
2.29.2

