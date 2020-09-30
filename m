Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5C727E608
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgI3KCd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgI3KCc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 06:02:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFCDC0613D2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 03:02:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so1374433lfs.13
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btHk6QbobgU8CR1iug8dhO0BVhzD57z+OLRWCB8dwFQ=;
        b=TSZLggRsxbN6SKIkUZq2qln/ul8b/CGjLkgO6uAJVhiGi4p2KTLK7fXyOK4e7Pk/vJ
         lDSZN3KXtYTHhDTDqKx/p6Wn6Y+XFJ7I1450EJlUAb8a44U6FSNPNW/QH3HebhDYQ5qU
         xXsGDArhpq17ZTiQRSVvrhR0tuBrScpiJNnLujZ85qhQy5NENKVw1VBlmRrdZ8EPxyFV
         Dz86dXNeSZgYincme7muOcs8XPzBLS85GHHPWkGuQgXsZUtxRSLPeVOTdYW8o2EDNnL8
         xmjnS+Y5D3n9Opj5aLh3KZXH0U3PfUdOXl4uqYDjnAz4VN7b5vYimFU1aJVy15BxJa/y
         VelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btHk6QbobgU8CR1iug8dhO0BVhzD57z+OLRWCB8dwFQ=;
        b=VwRrQRKY5qwnhtLg7m82p9r5Ziq9+lc9QiG10dM0fmLOn+XWhd80MjzW4YvPmEm13g
         AldeS/4jmvBsVi+nlMMTo11Bn+QP+coGGawlCfZ6N9FORO4GBQY4vBjmlgcPVhe+d8ZQ
         R3E3OCInMRuj4vqLifkelXCBHREzeU52AAm3B6Xgp6cSww+H+J/nINOiBg0+BlhN4LK2
         EWQOPh5k2zecE+0VqZ0nM2ihHSjEGy7tBFZ4ANZZFVghh0imTQWJ/V2kpFwkMJgxP16I
         s1T3nVdaJb760dAJ3d5C8A+RBJrb55rLu+NeOp9ypRCPatmz5LcMqaoKaCpzQWiBE4k4
         /8tA==
X-Gm-Message-State: AOAM533NHu4pZdmPW3jLzavF9+Y8hnpVpJET6H4Gr7rDdK1cJq/Q3o0Y
        uxGf/f9u4sUjKIZf5WigWD46Sw==
X-Google-Smtp-Source: ABdhPJwV5aY2gZnpEPtEgqjl3OUIN4h2+PGRvfYihOvCPF/1dlMTR2ltAR34pdJI8uuE/bNnqTXsEQ==
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr563611lfr.571.1601460150349;
        Wed, 30 Sep 2020 03:02:30 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id w4sm132479lff.231.2020.09.30.03.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:29 -0700 (PDT)
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
Subject: [PATCH v6 05/10] iio: adc: qcom-spmi-adc5: use of_device_get_match_data
Date:   Wed, 30 Sep 2020 13:01:58 +0300
Message-Id: <20200930100203.1988374-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
References: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
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
index c2da8f068b87..ae27ed7a26ff 100644
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

