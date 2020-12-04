Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF42CE625
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 03:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLDC5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 21:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgLDC5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 21:57:30 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE176C094264
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 18:55:42 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so4893826ljo.11
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 18:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pm8KWurwPbsiA2+0aZke00zkEXKFA8bztpS1CwLqd5E=;
        b=Z+nskjOPjApEuAj+N17fYTek4itpeFVt9PR47He//27Dc4ge/6SXhO6JdrxkScCFC8
         Wxno+B4Q5sz7NGczbgEMt2TYMCjqUYyQIbdUA1TilccGRFmXk5+5CLwyx9T7wN03OAGX
         sCiGH7ZC9n9F953a+LF9vWP6So8l7+wopmrlD3lpC+LCuFjqih4sQ4XUuo0mdWKc7b8+
         YLyWlhqxNo1fO9xFGzvmEo8zX/OfCJ567MOar1eH8DYsObsAwY/x5tiFyTr7VQOvMpBa
         stOrUQeM+k3S3PlRaW5VdUhoaJZVbFGzzSdn6+LArw09bCvioaznBD6c870H703y2qWU
         IHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pm8KWurwPbsiA2+0aZke00zkEXKFA8bztpS1CwLqd5E=;
        b=i8I0VH+rZu32NfJZGk9XLHDlF7wKqXcwYdk7hj37zQKK37BjHVoleKawzcUB9XBmj0
         17I8rvY0U4H3wy5lgFgYKfVB90O05g9Bf0G8bmqx4uyGWT616s0Se8h/mgOaTugVkEjC
         CGZQuGcebX9kXIE/htugFf6zKh1N2T3wX4KohPMMH6Md4MniIfXj+HVT8i0MjxGNpYTd
         +m3YccDynZO2SWiyunlrXehiIds9uLq9+5lxpGqDoIiD3HFCltruTOgmGUhabsb+5tye
         k16A1CJMf2Lng5Zkjz4pQhIQYdYz9Jj2986sKnH79MLqazXipdMa+i9MSYg6eScUrmuI
         ETkw==
X-Gm-Message-State: AOAM533GgW++EckX0LUr5q2QhgFq6ZscKa0ykwCKcwjitnazMMN7iaJ2
        dh+3j1ZnG2agne2HlFs/LlMcnw==
X-Google-Smtp-Source: ABdhPJxSLvlF9FTFV87bTt2wRohWnkFN5JJhhEN3OYyQwkIo1OsSXRFyR1eYqUJJjOHwhxRFwERMdA==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr2503832lja.192.1607050541253;
        Thu, 03 Dec 2020 18:55:41 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:40 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v10 11/15] iio: adc: qcom-vadc-common: scale adcmap_100k_104ef_104fb
Date:   Fri,  4 Dec 2020 05:55:05 +0300
Message-Id: <20201204025509.1075506-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Scale adcmap_100k_104ef_104fb temp values by the factor of 1000 to
remove extra multiplication in qcom_vadc_scale_therm().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c | 70 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 441843827f05..8682cf1e213f 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -23,40 +23,40 @@ struct vadc_map_pt {
 
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
-	{1758,	-40},
-	{1742,	-35},
-	{1719,	-30},
-	{1691,	-25},
-	{1654,	-20},
-	{1608,	-15},
-	{1551,	-10},
-	{1483,	-5},
-	{1404,	0},
-	{1315,	5},
-	{1218,	10},
-	{1114,	15},
-	{1007,	20},
-	{900,	25},
-	{795,	30},
-	{696,	35},
-	{605,	40},
-	{522,	45},
-	{448,	50},
-	{383,	55},
-	{327,	60},
-	{278,	65},
-	{237,	70},
-	{202,	75},
-	{172,	80},
-	{146,	85},
-	{125,	90},
-	{107,	95},
-	{92,	100},
-	{79,	105},
-	{68,	110},
-	{59,	115},
-	{51,	120},
-	{44,	125}
+	{1758,	-40000 },
+	{1742,	-35000 },
+	{1719,	-30000 },
+	{1691,	-25000 },
+	{1654,	-20000 },
+	{1608,	-15000 },
+	{1551,	-10000 },
+	{1483,	-5000 },
+	{1404,	0 },
+	{1315,	5000 },
+	{1218,	10000 },
+	{1114,	15000 },
+	{1007,	20000 },
+	{900,	25000 },
+	{795,	30000 },
+	{696,	35000 },
+	{605,	40000 },
+	{522,	45000 },
+	{448,	50000 },
+	{383,	55000 },
+	{327,	60000 },
+	{278,	65000 },
+	{237,	70000 },
+	{202,	75000 },
+	{172,	80000 },
+	{146,	85000 },
+	{125,	90000 },
+	{107,	95000 },
+	{92,	100000 },
+	{79,	105000 },
+	{68,	110000 },
+	{59,	115000 },
+	{51,	120000 },
+	{44,	125000 }
 };
 
 /*
@@ -418,8 +418,6 @@ static int qcom_vadc_scale_therm(const struct vadc_linear_graph *calib_graph,
 	if (ret)
 		return ret;
 
-	*result_mdec *= 1000;
-
 	return 0;
 }
 
-- 
2.29.2

