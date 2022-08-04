Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65259589772
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 07:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiHDFr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 01:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiHDFrN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 01:47:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927E606B5
        for <linux-pm@vger.kernel.org>; Wed,  3 Aug 2022 22:47:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id iw1so18396178plb.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aeM1+URF6K22PChBXxuUTBq3ki6hGotwl2mOvNpT7uo=;
        b=XYE6lG1nVAsFoknyPfH93n27W+v8EsVFCNwYv8Bris8KOHhoifD31YhysdYaONc/oh
         tDf8L2Dm8B2jTpDGhBF+ppBueSKe7XT7vTcFfB6vmg76SvQrDJ5Tu4HatfuX8XhuTpJx
         PVhbknJbUUW9/ZZoaoOZhK9Cwym2+40+qmJZ3TivSBPvT3EB+3J8CyNRQUofYOhXj1Vh
         AWCG49tmLTLtOIVmQmJMn4+ZHLFXlWCtnbn62t/B5n+BpY2eQ+6kl87KiIOGpwl3O5J5
         Is2kDvPSe4Pe20dfxErwmPiGe+JzT6uIYvvmFHJ4b7WHA4diVl4OYSExXFLMXcvakRmU
         Qnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aeM1+URF6K22PChBXxuUTBq3ki6hGotwl2mOvNpT7uo=;
        b=MaE+CNZX3YA2UgA9CR2Oo6Aii0lv5nzBfKhokRcEUm0mHVuRFcOXG5/J9HCvt5xLHz
         4/eMB2hYrfOXfu9ZNL1JHv0f96NnsQ1pAi3gFFLVIwl7Nsk/rIIKlCfmE4gvyAfe00/H
         FPH6dQHkgWAh5dL9BB6TMojMYJMz2bW9uye98nD8iOSXvTbH0bqrFPscJ/TOkjC/uP7C
         3PQWZ31FubRhaeJEVvcdpxeMvnaoi+Del/ZOK5IdoRG62ISHmSSoJT+VMltubSvjcb/B
         KOSYv2unhmcZChHOHPGrwp81XgQPAbAqUiddLKC7ikjP9TvbtP5WJxTygPWXOMPkEnEv
         aOrw==
X-Gm-Message-State: ACgBeo2OJPxsbm/RxfTprP/PAAzKPqE1YnYMLT+qFUm4MZC89ddT3FS4
        +LkJYt4p9u/0Uh8TboSf57reP0watttyYQ==
X-Google-Smtp-Source: AA6agR5s8VBh5e7rB5YF0kTtEjuQ25Uoxkc6uXEOuyIA4DILe2m54E0oTf/r4dlZ+Qaa8GmTvb3grA==
X-Received: by 2002:a17:903:2291:b0:16e:cf55:5c72 with SMTP id b17-20020a170903229100b0016ecf555c72mr361690plh.121.1659592026831;
        Wed, 03 Aug 2022 22:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:ddbf:1bd6:4443:9e5b:2aa2])
        by smtp.gmail.com with ESMTPSA id q25-20020aa78439000000b0052dcd14e3desm5375636pfn.183.2022.08.03.22.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:47:06 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v3 4/4] thermal: qcom: tsens: Add reinit quirk support for tsens v2 controllers
Date:   Thu,  4 Aug 2022 11:16:38 +0530
Message-Id: <20220804054638.3197294-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some Qualcomm tsens v2 controllers like those present on
sm8150 SoC might require re-initialization via trustzone
[via scm call(s)] when it enters a 'bad state' causing
sensor temperatures/interrupts status to be in an
'invalid' state.

Add hooks for the same in the qcom tsens driver.

Devices requiring the same can pass the relevant
compatible string in dt and the driver hook can
be used accordingly.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 12 ++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index f521e4479cc5..431f17f99d34 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -104,6 +104,18 @@ struct tsens_plat_data data_tsens_v2 = {
 	.fields	= tsens_v2_regfields,
 };
 
+/*
+ * For some tsens v2 controllers, its suggested to monitor the
+ * controller health periodically and in case an issue is detected
+ * to reinit tsens controller via trustzone.
+ */
+struct tsens_plat_data data_tsens_v2_reinit = {
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.needs_reinit_wa = true,
+	.fields	= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index c2d085fb5447..928b6a44fda8 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1145,6 +1145,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,sm8150-tsens",
+		.data = &data_tsens_v2_reinit,
 	}, {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 900d2a74d25e..03cc3a790972 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -607,6 +607,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 extern struct tsens_plat_data data_tsens_v1, data_8976;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_tsens_v2_reinit, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.35.3

