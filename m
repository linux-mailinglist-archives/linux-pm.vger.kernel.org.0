Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA127BDEB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfGaKA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:00:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbfGaKA6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:00:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so31724522pgj.7
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vuwg/qLthBT40Ca2xrbvcRHyZdgOFkkkM28IonKKxd4=;
        b=BGrk88fawYJnzHlTqSp6jAcbVl4MvCckvfC8RgMr9Iq0piEiaZ2vyikaRxDhM9fLSn
         xlRwXhOZymwnuqLXEXZCVXGakJTqcBwfe9pSQxJQs9tFf3b/btbIEU6bWd7a22pHa1FX
         XnbKJaf5d6QeBvS6a2hJi6b7eYrlKLuT+vR5nw85UjKNJF5NAg2AvIgaN0qfUq9KW+H1
         D+86lngDkbCc9sND22axjQyz0lGSDKqA/KvdbbGuRQLdSkH2iJCYhFVAMrLM5vvqeIaY
         1uy4NRxiurckC0uiTQF7DYa0lIdvjQPzWAUMdCLG6DdM+/QmJSMk4+8tPDCW8GLhIrqw
         JCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vuwg/qLthBT40Ca2xrbvcRHyZdgOFkkkM28IonKKxd4=;
        b=pNKGKu2hcGuDDX/YWo04sgAmLbIuOGllHxrtUkK53bcek9kNO10EW/YWRd73H1SebW
         9rckvkX/8hA0H0Cmh7GEApaIe+8xWrx/QdQvPC5L+STq9yeotqXZ0pqtHZgbugxLk37R
         7iNeiBblks75HN5yglzWHDXnY1UxD2SmTrrCgGfb9PA6zyK1oKhh2oguTOyszcZni+ot
         VTtVyD4twt2Dm+uYwdnFxaOQNdPTLpgNHPt1pjDV2mse73m6fuMsYfDnk0sqnpMEqA8J
         o51QoRrKp1drzDIjhHYnoM9MAUmaUgQtItuVtTbumS9go5a325PwnK90buGXDBFCY03P
         5bhQ==
X-Gm-Message-State: APjAAAUhnOtvbMdjZyGii+7IgeaynAaNOrD/tk9kzb2rHieQeqCn9yxv
        laNh7fboUatiI6sZeBBBm3Nm0A==
X-Google-Smtp-Source: APXvYqydg9TR+BiV/Pz9CW9e98/wdHVGKxLK9oxylari74O6XN92CBconFgW3aaqYn1XtdjKzu52bg==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr59564051pgi.70.1564567258256;
        Wed, 31 Jul 2019 03:00:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] power: supply: sc27xx: Fix the the accuracy issue of coulomb calculation
Date:   Wed, 31 Jul 2019 18:00:25 +0800
Message-Id: <0e86ed1f992d2eb99fd4abb9e0c51ca2c4ccd4eb.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

The Spreadtrum fuel gauge will multiply by 2 for counting the coulomb
counter to improve the accuracy, which means the value saved in fuel
gauge is: coulomb counter * 2 * 1000ma_adc. Thus fix the conversion
formular to improve the accuracy of calculating the battery capacity.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index ca7b73e..ab3afa1 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -326,8 +326,6 @@ static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcnt)
 {
 	int ret;
 
-	clbcnt *= SC27XX_FGU_SAMPLE_HZ;
-
 	ret = regmap_update_bits(data->regmap,
 				 data->base + SC27XX_FGU_CLBCNT_SETL,
 				 SC27XX_FGU_CLBCNT_MASK, clbcnt);
@@ -362,7 +360,6 @@ static int sc27xx_fgu_get_clbcnt(struct sc27xx_fgu_data *data, int *clb_cnt)
 
 	*clb_cnt = ccl & SC27XX_FGU_CLBCNT_MASK;
 	*clb_cnt |= (cch & SC27XX_FGU_CLBCNT_MASK) << SC27XX_FGU_CLBCNT_SHIFT;
-	*clb_cnt /= SC27XX_FGU_SAMPLE_HZ;
 
 	return 0;
 }
@@ -380,10 +377,10 @@ static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *cap)
 
 	/*
 	 * Convert coulomb counter to delta capacity (mAh), and set multiplier
-	 * as 100 to improve the precision.
+	 * as 10 to improve the precision.
 	 */
-	temp = DIV_ROUND_CLOSEST(delta_clbcnt, 360);
-	temp = sc27xx_fgu_adc_to_current(data, temp);
+	temp = DIV_ROUND_CLOSEST(delta_clbcnt * 10, 36 * SC27XX_FGU_SAMPLE_HZ);
+	temp = sc27xx_fgu_adc_to_current(data, temp / 1000);
 
 	/*
 	 * Convert to capacity percent of the battery total capacity,
@@ -790,7 +787,7 @@ static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity)
 	 * Convert current capacity (mAh) to coulomb counter according to the
 	 * formula: 1 mAh =3.6 coulomb.
 	 */
-	return DIV_ROUND_CLOSEST(cur_cap * 36 * data->cur_1000ma_adc, 10);
+	return DIV_ROUND_CLOSEST(cur_cap * 36 * data->cur_1000ma_adc * SC27XX_FGU_SAMPLE_HZ, 10);
 }
 
 static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
-- 
1.7.9.5

