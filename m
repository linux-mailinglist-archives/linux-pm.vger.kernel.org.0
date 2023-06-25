Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03873D3DA
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjFYU0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjFYU0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B4E51
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:25:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so206742e87.1
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724757; x=1690316757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCh4arQEoAGVlLqffis8gz6DC+6MED45nir984gUIUQ=;
        b=WakZUF3MLv8+NpQwPBr/AHoQ7rZ11PJbJr4+Zzc2q7/7GkrqTin6p0JQO25kNFp0CM
         +rRRDfYrjsIw1UNOUKDb9ZQYLBE6XsoJidNf7vCk/yYTVCAaaYh1UMbXCZKf07Jhzokl
         h9A9jEXM11Fuj2QsMNwYHSOAh4xJbghfXNJpw6Ifkc+489O04qIGJJNuomM0nxU5Pxfb
         i3e0/MCFyHY4dn1rSL+ziBjuqlnKB1oYO/jRib7ASARhbCSyeq9vklJCLjx5Zao/Wx4f
         Fm8a3rAhg538w4GIzAcrELOP0EcIJzAUwo22HQGM+5bnsr3WQpydP9ZfbA2V+y+y6xzk
         Q52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724757; x=1690316757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCh4arQEoAGVlLqffis8gz6DC+6MED45nir984gUIUQ=;
        b=HE+u690qUuPwzUDLf4qdjTXcLmg71raZrE1Co7IqX9LRzMQcIzDKTQ55IIE6U5k5fp
         ZIgwZR8QWjXlglBcr0c7kf2jSYUt5HAFAIoCqjwVO+Ow2/YzRjxz941u8IJ60AxWGL4g
         CIeXcynEATdJk3mktfr6BHyj/B5P9CZQ+XEVJTzqLQbIpZ72Iz4a/lo4Ea/Dvw3nHxjx
         3CA+wXJeX6NtL0FMrYfEzjBoGF2o296UNjzb8qncsUKGaZya7tkkxrl4cxvefzSO9UV2
         uNa48Tm8Cr/Y5AgU04+Bfn2muneVzOxUYCViZdUD+QwB6f+1kEhEk+QRhPtecdADiyGu
         R6Zw==
X-Gm-Message-State: AC+VfDxkvRM6VV1q66Y5s83/6cx/JvfaEvlUgVA6JDCzTGNUmDWwS+MW
        wNrDtBDMpqIpvsoOY/hafSAb/g==
X-Google-Smtp-Source: ACHHUZ6G6XU4mvLao5i4E1ouG7XhuQjN+gl1gHdo3px2ekTH+qGyuUm65rYpN3AZrzFAruEnd8EaNg==
X-Received: by 2002:a19:5619:0:b0:4f8:6d53:a68f with SMTP id k25-20020a195619000000b004f86d53a68fmr11261203lfb.64.1687724757592;
        Sun, 25 Jun 2023 13:25:57 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:25:56 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 09/26] cpufreq: qcom-nvmem: create L2 cache device
Date:   Sun, 25 Jun 2023 23:25:30 +0300
Message-Id: <20230625202547.174647-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
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

Scaling the frequencies on some of Qualcomm Krait platforms (e.g.
APQ8064) also requires scaling of the L2 cache frequency. As the
l2-cache device node is places under /cpus/ path, it is not created by
default by the OF code. Create corresponding device here.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a88b6fe5db50..ab78ef1531d0 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -380,6 +380,7 @@ static int __init qcom_cpufreq_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 	const struct of_device_id *match;
+	unsigned int cpu;
 	int ret;
 
 	if (!np)
@@ -390,6 +391,25 @@ static int __init qcom_cpufreq_init(void)
 	if (!match)
 		return -ENODEV;
 
+	for_each_possible_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+		struct device_node *cache;
+		struct platform_device *pdev;
+
+		cache = of_find_next_cache_node(dev->of_node);
+		if (!cache)
+			continue;
+
+		if (of_device_is_compatible(cache, "qcom,krait-l2-cache")) {
+			pdev = of_platform_device_create(cache, NULL, NULL);
+			if (IS_ERR(pdev))
+				pr_err("%s: %pe, failed to create L2 cache node\n", __func__, pdev);
+			/* the error is not fatal */
+		}
+
+		of_node_put(cache);
+	}
+
 	ret = platform_driver_register(&qcom_cpufreq_driver);
 	if (unlikely(ret < 0))
 		return ret;
-- 
2.39.2

