Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84FA641AE6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 06:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLDF7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 00:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLDF7Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 00:59:16 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E2192B1
        for <linux-pm@vger.kernel.org>; Sat,  3 Dec 2022 21:59:16 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id n1so9966783ljg.3
        for <linux-pm@vger.kernel.org>; Sat, 03 Dec 2022 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR3/XKv5q+q3k6NfYOB/5GogcXcC1ZXxiI+xqdp2Znk=;
        b=AUfobIipxAp4rsG6ezFi/b6PuBsjqBtVYy0wuuxD65ohmavhjbuAlheRV/cho8zf4+
         Szy+1l67s3R6HiYWdZZO24A0a2NNL7toj7u5pUZzbzhYUno4/8N2KDUavjETqWfZTGso
         mIyiLMGKoGbvVHlY79rqPoE1f6Se9KmVaYs+fy5cEqbY2JVKUh7RPDpiL2eppuuIB5j4
         Ozl3WZqHUJZtB7XhAjWIpKkkIfvz9Ep9bQyKyn66N6VT5WWu29ixpxZ3qKBCqtNi3YFT
         zWusbzSmN7ncu5AtbmGJQWnmwLgrlYceZWQQvTBeZNEKALg+5gAkTdZ8GivcvY9XEbb6
         qZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR3/XKv5q+q3k6NfYOB/5GogcXcC1ZXxiI+xqdp2Znk=;
        b=gaSY7gO36DAmFNBRpUUQ5YTQdSwXFvjfJg5NvyzS5Y2gK7U0UcLZFqokal4GcCAyaH
         kjBjc3uZ+Kbn5AezgPECXd4VxTo+koR3wRyoUhSPX4RTIQTTO3CpqLhH73M7nmuD8ThB
         TptjDxnX4elfIPq257QZQabgxf/uqxqjnQQ4+t1l4w2E6ovBgP5vr5m6n0SWDWybCpq9
         X5ZbKmlCp1xX9iCRXw7p+ndMTK4104Lm7UBikLTIpEPVhcKVb6PKFhyU+R9Dk3vZ+V46
         EP3f0z+7Gf2BwNg6cQFa4vL+ZMQv+JHqRwQqQCUxwInk0kOSoiXHW3kZ5gfADAJ6S2bO
         4FrA==
X-Gm-Message-State: ANoB5plqBuoEnBOMu9zgFhx38CEaZC5PMCW1zkgQZWQ1HD+RJGsIDqtO
        qqEfHkqC4MIOZ2GHeCXD2VN4zQ==
X-Google-Smtp-Source: AA0mqf5Vcrz0vPyYknzC6K989JBkzs6IsPC6lQyq9mygDbnzdcsqhIxojA/smEGaoryxL5N5aMxpAw==
X-Received: by 2002:a05:651c:205d:b0:26f:b445:8c8a with SMTP id t29-20020a05651c205d00b0026fb4458c8amr19698738ljo.156.1670133554283;
        Sat, 03 Dec 2022 21:59:14 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b004917a30c82bsm1650028lfo.153.2022.12.03.21.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 21:59:13 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/15] thermal/drivers/tsens: Drop unnecessary hw_ids
Date:   Sun,  4 Dec 2022 07:58:58 +0200
Message-Id: <20221204055909.1351895-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
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

The tsens driver defaults to using hw_id equal to the index of the
sensor. Thus it is superfluous to declare such hw_id arrays. Drop such
arrays from mdm9607 and msm8976 data.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 1 -
 drivers/thermal/qcom/tsens-v1.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 327f37202c69..94bb185c5aae 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -632,7 +632,6 @@ static const struct tsens_ops ops_9607 = {
 struct tsens_plat_data data_9607 = {
 	.num_sensors	= 5,
 	.ops		= &ops_9607,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 573e261ccca7..622d43d35076 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -384,7 +384,6 @@ static const struct tsens_ops ops_8976 = {
 struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
-	.hw_ids		= (unsigned int[]){0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
-- 
2.35.1

