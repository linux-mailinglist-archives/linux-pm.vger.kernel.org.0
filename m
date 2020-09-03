Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7109C25C413
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgICPDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgICN6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 09:58:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0ACC0611E2
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:21:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so3702268ljd.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKxx9jGOwv41qjM0dB2DR64F278mvrQpwsZT854Hceo=;
        b=w+ydrhIHhZ7wYAaA63bRQsevdR50iFtEsb8N3t9zizNA4ETwHB10nMe+vAU7P/pGV8
         RLm1BZPCz13ulabvQkJT2zXNnziM7Gbn4CXQQXSUHMyM6WLgX9WBIPJ4RpvARtMVkfYd
         5G3O9e31Xqj731ZKim63bAAdFY3JLMAUnf9wwUmA80BQSOt9TT+t7eVw1uSO71xh4Te8
         hIfLIcejfPKclZLi71jYQ9rBZ6ncsPpCXOlsv80gjMOsEl3fm0wf+M+pp4uhzHX5xm4g
         +Nvjl1x6k5ylV4b4y7YQudDuvRtl9Aoi2b7J0660+t3c0ahgjC6Ll22RzgKYUBkq65uK
         yb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKxx9jGOwv41qjM0dB2DR64F278mvrQpwsZT854Hceo=;
        b=ke+HQSJ256shdBqFsBX4mH4AmiXq9yTPcx/9XO4q3enNABpThKu96KTACI/N4/G4U8
         SsLDF67YzJzSztHPBAHR8c7yflQFkZDEHu2GVXO9lqX0xo29qpBIchdcrZowRDY3D+lK
         nUYFUJl83ni23zx3GFQAwXQeX7B+WawJ3ufzmKyDC6QWNQHe78IPeDpK2VYmMeAUEEMH
         VD5bJ1JR+cP8CRmFOLlL8kMtiWoH7IRRtIeYMUGFFmF2GNX4+7z5tAYBgPYO9QVsFQ+X
         2eWrN7GSeU9QX/ri3P3zjOdJBJB8zA+5433PRhHzjU2RqlpmyFOBUb1guZqtysO8OenF
         XH7A==
X-Gm-Message-State: AOAM533pQ0yFx4VaJBMPceJ8cLbj+ZT05Xl4qhyrhXMSH2D8KnZ9xRT6
        xwUgTxJF5e/n7WRftLa8b17RXA==
X-Google-Smtp-Source: ABdhPJwDYO7VKCBg3p0wQJbtRhpPsjIJzYeR5H8M6AS/TyJXOCUofXXgi4ku6QDgYpgek94sQ53V9w==
X-Received: by 2002:a2e:a165:: with SMTP id u5mr1211994ljl.393.1599139290520;
        Thu, 03 Sep 2020 06:21:30 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id e23sm584220lfj.80.2020.09.03.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:21:29 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 6/9] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Thu,  3 Sep 2020 16:21:06 +0300
Message-Id: <20200903132109.1914011-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use of_device_get_match_data() instead of hand-coding it manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c2da8f068b87..0ac0b81bab7d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -14,6 +14,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -807,8 +808,6 @@ static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 	struct adc5_channel_prop prop, *chan_props;
 	struct device_node *child;
 	unsigned int index = 0;
-	const struct of_device_id *id;
-	const struct adc5_data *data;
 	int ret;
 
 	adc->nchannels = of_get_available_child_count(node);
@@ -827,24 +826,19 @@ static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 
 	chan_props = adc->chan_props;
 	iio_chan = adc->iio_chans;
-	id = of_match_node(adc5_match_table, node);
-	if (id)
-		data = id->data;
-	else
-		data = &adc5_data_pmic;
-	adc->data = data;
+	adc->data = of_device_get_match_data(adc->dev);
 
 	for_each_available_child_of_node(node, child) {
-		ret = adc5_get_dt_channel_data(adc, &prop, child, data);
+		ret = adc5_get_dt_channel_data(adc, &prop, child, adc->data);
 		if (ret) {
 			of_node_put(child);
 			return ret;
 		}
 
 		prop.scale_fn_type =
-			data->adc_chans[prop.channel].scale_fn_type;
+			adc->data->adc_chans[prop.channel].scale_fn_type;
 		*chan_props = prop;
-		adc_chan = &data->adc_chans[prop.channel];
+		adc_chan = &adc->data->adc_chans[prop.channel];
 
 		iio_chan->channel = prop.channel;
 		iio_chan->datasheet_name = prop.datasheet_name;
-- 
2.28.0

