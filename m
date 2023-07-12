Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653D7750496
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGLKeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 06:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGLKeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 06:34:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84E1BE5
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 03:34:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6682909acadso3785959b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158044; x=1691750044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Da5r3Jfw26dVyORzvrEm8qPAG9eUA105lcs0ZwlGe4=;
        b=Sqebp4dmS/oUIv5MECxVCadbzVGHwkk1wQwGZA7C+YTXRxVBatcl0kLjTTkaqeQ0fr
         G8Z6iO/503t/7TyX/OgOpCL7amfwK22v8xzPAy3+w8g9nloGyrpHUDdNIJjOo0jGi9SH
         ZHklI5Iau9vBHmsYzTT30fBxpTk6A7ok8CT7lH/ikmo2OPuWDEEr047cG+9STovQK03R
         12g3JKVStBAtv62pFfkQ90GWQ9NBv3dJfd6PXhJklx54RRzCRsYMHyMdeqmRVyqViA1w
         /fB0tmOek6A1m7hRFT3Loh9fZyUZEvXtJ5v1ejSeGpXj5S9RUFLQnIZwUk8qhPuUQRxn
         i0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158044; x=1691750044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Da5r3Jfw26dVyORzvrEm8qPAG9eUA105lcs0ZwlGe4=;
        b=EQOs/koS+elAvtLLpHv+eQNTGL9N7Kyq4HlA1pkcenReLF/t5AokarlCc+R6X0K4T0
         aGrMZBKIyLsRPfYtKSgkNTXqy/zC0pJ7Mq0P/3rq+zKF3O7ZOTIMTpVWymmOFpGS0PpT
         9VEIfHLHOJBCfYP6ohE51QU2M6NkPgKTQAw1bKgNFRlgMLm1sDVF/ItQEDjW9cKYmGWG
         35/se5NzHWeBYMiCCbOMLkZTXY+PIQOXSXcpToP8nU/uDv+P/N7oe3KW15VvsBZQcgAA
         2vPAs/79DePh+T6QbTBG8XdwNcc/KF+HeyuSmV0seJbjt/rtmRsQW9hiJhOMCakWF2lZ
         2abw==
X-Gm-Message-State: ABy/qLZXAQjYnMpYWIqiwUNrm5jpHdnPO51JDsDCpPf8k10oAHRh5QE5
        Qk3hStzsBVJUr68famEXWxaL
X-Google-Smtp-Source: APBJJlEUCRl2n0TnXX1PTCvO1fYxKgNl2vo0IjZqY6qzfM8o6ozuVvwt8qWGXK5nkbCfkOGGbSIZeg==
X-Received: by 2002:a05:6a20:9144:b0:12e:be7b:a4c with SMTP id x4-20020a056a20914400b0012ebe7b0a4cmr17651487pzc.49.1689158044263;
        Wed, 12 Jul 2023 03:34:04 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:34:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/14] OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
Date:   Wed, 12 Jul 2023 16:02:02 +0530
Message-Id: <20230712103213.101770-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the case of devices with multiple clocks, drivers need to specify the
clock index for the OPP framework to find the OPP corresponding to the
floor/ceil of the supplied frequency. So let's introduce the two new APIs
accepting the clock index as an argument.

These APIs use the exising _find_key_ceil() helper by supplying the clock
index to it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 18 ++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3f46e499d615..a6d0b6b18e0e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -658,6 +658,33 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
+/**
+ * dev_pm_opp_find_freq_ceil_indexed() - Search for a rounded ceil freq for the
+ *					 clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	Start frequency
+ * @index:	Clock index
+ *
+ * Search for the matching ceil *available* OPP for the clock corresponding to
+ * the specified index from a starting freq for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_indexed(struct device *dev,
+					     unsigned long *freq, u32 index)
+{
+	return _find_key_ceil(dev, freq, index, true, _read_freq, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
+
 /**
  * dev_pm_opp_find_freq_floor() - Search for a rounded floor freq
  * @dev:	device for which we do this operation
@@ -683,6 +710,33 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/**
+ * dev_pm_opp_find_freq_floor_indexed() - Search for a rounded floor freq for the
+ *					  clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	Start frequency
+ * @index:	Clock index
+ *
+ * Search for the matching floor *available* OPP for the clock corresponding to
+ * the specified index from a starting freq for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_freq_floor_indexed(struct device *dev,
+					      unsigned long *freq, u32 index)
+{
+	return _find_key_floor(dev, freq, index, true, _read_freq, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
+
 /**
  * dev_pm_opp_find_level_exact() - search for an exact level
  * @dev:		device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb5890792..991f54da79b5 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -124,6 +124,9 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_floor_indexed(struct device *dev,
+					      unsigned long *freq, u32 index);
+
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
@@ -132,6 +135,9 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_indexed(struct device *dev,
+					     unsigned long *freq, u32 index);
+
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					   unsigned int *bw, int index);
 
@@ -271,12 +277,24 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor_indexed(struct device *dev,
+					unsigned long *freq, u32 index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_indexed(struct device *dev,
+					unsigned long *freq, u32 index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					unsigned int *bw, int index)
 {
-- 
2.25.1

