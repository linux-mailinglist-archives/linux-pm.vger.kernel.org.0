Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7854F563B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiDFFiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1851328AbiDFDDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 23:03:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711DA167F2
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 16:59:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q68so1104696ljb.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/JxrbhWAHjw8ckYVJv9DMMKqM3jkzyjVUcpKG0Ot64=;
        b=gaza2oJTKLFw55AclhDk0/Ajbh8SVxqqcz7RXA5284kNNaZd+zz78VoQQLeNAXTfzf
         apiYrA1In7nO1jdEHkJhlN4hkDydpgPsUtBvi+e1KiV9X7XMmJHJRo71Ym10pEw+jY/2
         WUYWLbbSwKje9rLp4XLw1fzGGgMrJlIDgLFVHTqpXgGR5bIYoZNTR0zU0Xth5GNl55Lt
         qUuCbZemsdwDq5KzgcWoE9IaXJHu1gJCZgusgZrgjT06xpW247WgVMF6GkyoaGim1+Er
         cKe22mNTd7vON6v802JQanFyJ5++0kcOqFo3v3hkexjoU1xFlgQOIh1bxptGhmYjMFpc
         2k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/JxrbhWAHjw8ckYVJv9DMMKqM3jkzyjVUcpKG0Ot64=;
        b=7+1SM8ge47qLFKtvI/d7t6S5fn840l/V0w3t2+749wzcc2o8NTlWUw1f+eCmT3ynJE
         EMcY81JOAn4NeFMSPzFD9SXhLYX1gVFotgKReA5GI/veNxN+D+EWubWkc3WqZy8LRt3y
         aLg81KGo2H6BuQ8JYGZ1T08wwouS7LdQ1lFCBUh+aTYXSD9ivPWKS8NNLovSIBW2LIQv
         pPyMvdrVhSF06+YxNyh1VTkZN51TgEKfoA8ofTCzmrdQcN7YQvrL6HZsMw6Q4pZs8mcC
         CEQG9cl28A6WTD88UtWhMO9OazMt2tsTBtD2Pok8+G+Ohd+tx8zeNJsphIR8n2qciNot
         iHpg==
X-Gm-Message-State: AOAM530BEqo1wm9ON8A7qn45tAZn+HyhC6W3O2pajr7wC2SpSp5JyZAq
        moIPHt7CgQOeeuMhRAq10i6PeQ==
X-Google-Smtp-Source: ABdhPJwWdHLZp9cwRO5mb+bG5RQ8DC3/RcS13t+LRAGrf5jqQ2VvX4VTZcc5deIUZjy5rCpcfCv6QQ==
X-Received: by 2002:a2e:9ec4:0:b0:24b:115c:aedb with SMTP id h4-20020a2e9ec4000000b0024b115caedbmr3561269ljk.235.1649203153677;
        Tue, 05 Apr 2022 16:59:13 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w14-20020a0565120b0e00b0044a9b61d2b3sm1646471lfu.221.2022.04.05.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 16:59:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/4] thermal/drivers/tsens: add compat string for the qcom,msm8960
Date:   Wed,  6 Apr 2022 02:59:08 +0300
Message-Id: <20220405235910.373107-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405235910.373107-1-dmitry.baryshkov@linaro.org>
References: <20220405235910.373107-1-dmitry.baryshkov@linaro.org>
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

On apq8064 (msm8960) platforms the tsens device is created manually by
the gcc driver. Prepare the tsens driver for the qcom,msm8960-tsens
device instantiated from the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 154d3cb19c88..7963ee33bf75 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -979,6 +979,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8939-tsens",
 		.data = &data_8939,
+	}, {
+		.compatible = "qcom,msm8960-tsens",
+		.data = &data_8960,
 	}, {
 		.compatible = "qcom,msm8974-tsens",
 		.data = &data_8974,
-- 
2.35.1

