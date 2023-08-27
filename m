Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F04789B2F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 05:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjH0D2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Aug 2023 23:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjH0D2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2023 23:28:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F9DCCE
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500913779f5so3377304e87.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693106886; x=1693711686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDcX6nc3xf4NnNrUKfcUNu5SXO4YsMvuQIo9lBU68H8=;
        b=HR8yZWX1d5bxSySO0g4a67Ipugd3uqpw7d1qrV0rbEt5V0WLp2iS7E+4MRhRclbzYv
         BfIzctwAb3FsfMgfFxsr+h8k0MxPwdhgr1vBRk4+2OE+NvxIZw6/BPG69ucG3ckp+vRD
         YAMqzAUwA0z6ptUOfVoT4LTpi2vHJiUIkJ3ivVdyxrQs+Sn+z9RWLfopbAHonlHxwlWm
         maNv1zx+il5iCar80F422rCkXfn+D1NaY7wiQ7O/SI1Z0G72KwpJC6wFFg9jdKY8CVD3
         dwMxD7Ky+pQWFjkNyaV7Xf6wyd+ZGbdrAUNTOMjIpC8MfAJg56uSTAE+RA5pLT5lqY53
         oa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106886; x=1693711686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDcX6nc3xf4NnNrUKfcUNu5SXO4YsMvuQIo9lBU68H8=;
        b=JV1Gd6vAfCr4qH11V/NVo1LC5I+LrGlOsdt7xzjFvpVOHgxJeq5u83jnpX07Z5ypOM
         mAnkHl10N9r8+oXO5wcKKjqbmGHXE3ScUcEkz14OhNlbT8z7cRGmIcTiW8BCF/4HBzlI
         cac4gCOOLvyX4xZyeb3lQ8Idf6tEtBQLFDaEoJlX0tsSIcDy5lsAMBneiilVRKc88vTa
         z4sPAaFA8ie4bebTkwkrRf+x/pDxwj50wgVUC6CWGhezbhmJS9FGOJIgPFBIqodIH8Zl
         nuonwlAQNeXahxKb5TLLTAiSFmpw723wq7O0BMgeWuF1mFeMcI3m1f8ivinWk9ydCpHw
         L46w==
X-Gm-Message-State: AOJu0YwXubM/xE6Mnh99p1dsu8+/yQ6bNSZT7dYkw+MDsC74QjtnKr/e
        MohdJP54tgPu/BEEtF60x/Hg7w==
X-Google-Smtp-Source: AGHT+IGux7+fe7WeUPSp78YK1YySxewfhDKbFzq71mjdHBbSG7uE6yCErWRI/u5u/sIYn8TIhYa6wA==
X-Received: by 2002:a19:9158:0:b0:500:a2d3:3e65 with SMTP id y24-20020a199158000000b00500a2d33e65mr5142697lfj.23.1693106886272;
        Sat, 26 Aug 2023 20:28:06 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm955709lfk.220.2023.08.26.20.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 20:28:05 -0700 (PDT)
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
Subject: [PATCH v4 2/6] cpufreq: qcom-nvmem: create L2 cache device
Date:   Sun, 27 Aug 2023 06:27:59 +0300
Message-Id: <20230827032803.934819-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
References: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 84d7033e5efe..f4c196ba4432 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -377,6 +378,7 @@ static int __init qcom_cpufreq_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 	const struct of_device_id *match;
+	unsigned int cpu;
 	int ret;
 
 	if (!np)
@@ -387,6 +389,25 @@ static int __init qcom_cpufreq_init(void)
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

