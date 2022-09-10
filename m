Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1C5B4654
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIJMrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIJMrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698357574
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i26so7225855lfp.11
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iVerlQTTcxJMwK/BNvAaXP01NQN8ZnVuUMJYdnIxVhU=;
        b=xxq2Elz2E7FDCRN2HEyRBRas8SZ2ONtz5fP0EATlf+pcHiU5lxV359TzPL33YESAxG
         F2pOk4jgKlxfrVZY/56tu4CJ93wFJ6QOfp2hZnFou5pReM+/OE0rBHd26Qvcqt/Be/IH
         m230C277sH+TLUffHOomnVFgd/2xVzaDgKMeS0sKD88EeaZQIR03aDxp5OH0JvQGlbWe
         1r9kYtdc7e4Mn/1pUh59M8kf+xkdsdzfpqn9k0qZdKmpnwIntdo3dejcVKvfU6zMFl7s
         ezU4NluOOt2IigJTI/XGsylPdiagqR9uTj1QJLE9KERpHrY9CwOdkMLyOAdgQHtY6Vj/
         A6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iVerlQTTcxJMwK/BNvAaXP01NQN8ZnVuUMJYdnIxVhU=;
        b=ZqowVNQ3yrzRldbQ9yd29Qu7ynqA5uFZinxA1Wgxstme/wNMcl4Dcj4IWUxI6OSkZ+
         ZZjtrpvwrCWwQSwm3XXgw1cKlEF9jyK0NUvNkNu1KsV1fMs1txNPJ/9TJ1zgH/tE5McH
         js3OYenZU0D8A6kFSTvYX1w0xjI7u+Lx3O2YzIP+suP+VC30/qjnuyv699LcNhr4ujYa
         wb1zsQ0vTuHzlPeVuzTueAbBA2GqgOk6sl13cKOsnQu7OFCYp/tIrPvYTfHdH3N+wiEk
         GI7upL+hJ9MEtBMlMoauZ1Huo/Ni3S5/yQhzbYkiJQaiFxSdvXQCvscSHiJWm6i9uQfF
         MEPA==
X-Gm-Message-State: ACgBeo2wud774h0dOIXhuU/+jYCfkNvOz+0umaNL/PiLUbsv4K0jJp75
        nS1DVDiyBSjJTK/B7ZNIejINQA==
X-Google-Smtp-Source: AA6agR4xMg+Po6UpG5t3LGegh4TK+Ju54mDhNlHUH9LMgRR/gINyI4YmT8cyrsRIhAUWO0NKZ8Fjmw==
X-Received: by 2002:a05:6512:22c7:b0:497:3512:2c28 with SMTP id g7-20020a05651222c700b0049735122c28mr6557230lfu.357.1662814028483;
        Sat, 10 Sep 2022 05:47:08 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:08 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 07/10] thermal/drivers/tsens: use tsens_calibrate_nvmem for msm8976 calibration
Date:   Sat, 10 Sep 2022 15:46:58 +0300
Message-Id: <20220910124701.4060321-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Call tsens_calibrate_nvmem() for parsing msm8976 calibration data in
addition to parsing the blob manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 11363a318ae8..2a4440a34735 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -213,6 +213,11 @@ static int calibrate_8976(struct tsens_priv *priv)
 	u32 p1[11], p2[11];
 	int mode = 0, tmp = 0;
 	u32 *qfprom_cdata;
+	int ret;
+
+	ret = tsens_calibrate_nvmem(priv, 2);
+	if (!ret)
+		return 0;
 
 	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
-- 
2.35.1

