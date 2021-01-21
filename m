Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7DC2FF461
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbhAUTTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbhAUTRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:17:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3CCC0613ED;
        Thu, 21 Jan 2021 11:16:38 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so2098519pfm.6;
        Thu, 21 Jan 2021 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TJ+/IkMxCE3Me3OscF6ay8YRP3qL8IEtjgxoP99DSE=;
        b=FK7MfMHf4SGJILR+sHK0PKOBbz5BrcJSqMkh5Xn57+xD8yXD4MR4CBRO15g37ChqOs
         UpVFv13HjPHg8N1wO4QJ6ctTUwLuagBBlo51P0y/qCTdWeVcw3yGgmmedPtAjehDdqpJ
         mOl53FsFj2CIKfqyei1p4qcrymafV2VfHBnFMPqq4MsPv05IIwhA8ZRD9VWkZWWCE3Bh
         rlNoNGm3cjRTEbjzdZFZjotdFtak5Y2PMH5hDx+t81QQpOtAXV3jtDuKEVmjiXoNcdAK
         Chv30FnZ6YNP9oOHiSVuM8DxqPFz7K28PfHQCCtnouU5AC9gDJrdjMOd2BVHM4ggkP4E
         U5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TJ+/IkMxCE3Me3OscF6ay8YRP3qL8IEtjgxoP99DSE=;
        b=graIcfA7CXk8nNSvAVT2PrpLB6/tPxRafQ0obCnsJctM8eBdN6WUwU/7n+OkpQkWo3
         yu6dEh9/4nBfN8R38gTgAnSzY4b0CBLCtcn1ev1H8UeUXR0hg9TGAdudJbw4nhmo3KMl
         f5hiXKDFGpTV8QKkZcn1DYPXaz10f03THm/IIxOSAlrU25jhbe9mX6TLbolhhvBkbsaj
         BiIOcJjsOdJaoqhRsq2nLlshR5nvD1r8ZczMJa36lmdEu6Sv0VxLq3NNtom4O+uDqJKf
         OFukLqbY7ZgJb0mLVqMwoX/BZ6j7kq1c3tPxcNfG1KE0tHoFJrswaDiO8hw3/8vZROfQ
         4lRQ==
X-Gm-Message-State: AOAM531xBEVu3VrhHHE42aEPQwBF7RQzukjRDpAVWjNljRnB98ctdKPI
        hTu0WWxdka9oBzopc2QMN3o=
X-Google-Smtp-Source: ABdhPJyByj5OTVv1UZPdho8rMYmkQjVXKqm48U9EmhAalZM5DKwY17h3hKAyeZMyHT1xJcvOjsHYlQ==
X-Received: by 2002:a65:68cb:: with SMTP id k11mr741755pgt.271.1611256598421;
        Thu, 21 Jan 2021 11:16:38 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-41-39-5.retail.telecomitalia.it. [79.41.39.5])
        by smtp.googlemail.com with ESMTPSA id gg6sm11291013pjb.2.2021.01.21.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:16:37 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/8] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Thu, 21 Jan 2021 20:15:54 +0100
Message-Id: <20210121191601.14403-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121191601.14403-1-ansuelsmth@gmail.com>
References: <20210121191601.14403-1-ansuelsmth@gmail.com>
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

