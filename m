Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852EB288D23
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbgJIPpX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbgJIPpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 11:45:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D9C0613D5
        for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2020 08:45:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a5so10038767ljj.11
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2020 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rs/lmUbls2+lr33cOkF5wTnejEIFAqou3Xfg7WIvltg=;
        b=yivuL4J53m688pGDgg3WPhODsMl4KQrCp23+POmiBRLuXeQtDcUSlZ92XvU590BQT7
         P+frwWWKTNat2ORIVRl6EzSIO4yV1kKedUzc/WQtJNNc4VjUJgdCqt0Z+lsflrAmoeaz
         5GQ2j6Qrwh5npSETINzGpD3DBNUQZW3kodv/HgzECl5kCbkMlABTX6WdXIC1PQMYnu9A
         nEQcM45a98V0oH+iJl3XsdbesVmFeawRCJA4SKbfMyFsI6o6UsuzOc5TArbbVoWASB+j
         l1+iaFVmY2OS0FJ+zk7JqybA/GxV6e1O/oBh1zsbJsT2HFWYfuf5tRW15dV0RKlMpsoR
         tnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rs/lmUbls2+lr33cOkF5wTnejEIFAqou3Xfg7WIvltg=;
        b=lXz3AaCQzCiKHjtyspyZFRZrFSF3HaQWO4ShEr/JVu0gfFy/L7pQX5u4S+C/aSiJ7j
         +36aP71mkyaSVN/Epm/l25lqyoeX/h0n43nfRfLdJXaD0du7lCzj8Xwze5W1Ic5NcrDw
         0eQ4Jt3BsqzuPqXrO0+u6ekD4uQSEV/ZXEPhE9StDWXZasbJAb/URUuYzJbKu0fVpjf/
         a7TPvEjkbiSqFMc11gDsc+1fqFAL9bFX1p4C4W554lhSlKZv7T+xPURYDDkiVtcoYpX3
         uVuPvBXqrxx80JFlkvUUJHwAPCQ8yHWdYA+4URSodJNk0+RbunBT38rz0ABs8UrVkozK
         WTSA==
X-Gm-Message-State: AOAM531KwaqdlzaBj7Z+r7XxSuyEisraOhuyryigQpllB4Em+VgxufAy
        wfbbEePscpDbn/OhPqzqfV63fA==
X-Google-Smtp-Source: ABdhPJz+94jCawC9y58GCaJphN4vUGBvFUR/I+I+DN1AfSLD6zRoUPSbXJ5qDQIiKn3/vjYMpY1zrg==
X-Received: by 2002:a2e:3806:: with SMTP id f6mr5315337lja.93.1602258319918;
        Fri, 09 Oct 2020 08:45:19 -0700 (PDT)
Received: from eriador.lan ([188.162.65.231])
        by smtp.gmail.com with ESMTPSA id r4sm1505597lfc.162.2020.10.09.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:45:19 -0700 (PDT)
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
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 06/11] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Fri,  9 Oct 2020 18:44:54 +0300
Message-Id: <20201009154459.106189-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
References: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use of_device_get_match_data() instead of hand-coding it manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index b10a0fcf09dc..87438d1e5c0b 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -15,6 +15,7 @@
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
@@ -827,24 +826,21 @@ static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 
 	chan_props = adc->chan_props;
 	iio_chan = adc->iio_chans;
-	id = of_match_node(adc5_match_table, node);
-	if (id)
-		data = id->data;
-	else
-		data = &adc5_data_pmic;
-	adc->data = data;
+	adc->data = of_device_get_match_data(adc->dev);
+	if (!adc->data)
+		adc->data = &adc5_data_pmic;
 
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

