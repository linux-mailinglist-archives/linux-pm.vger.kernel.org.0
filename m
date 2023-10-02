Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637F77B5ACB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 21:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjJBS7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 14:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbjJBS7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:59:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D3E4
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 11:59:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso38692e87.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273183; x=1696877983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUMMYHvgPHC3FfvjsnckoOJeoQiZG6ia/eSTyXFZQWY=;
        b=Y8ogdLqW/97k37B08ZvQy2ynd7nwL8wxzTBKwIHlkwyCy4/j5SyHA1qyBgroePjUZg
         bJn/4THiCoijQBLbrnwwlmQ2kmkiEAm2gZKW2P4XJ+cml1MToHVDA6p5seNOx+riogcB
         8c6in0X9GOxbqu4QLmxfnGU99ARqX7f0KIbFttBS2twp6zdPHjnFkT+f2e0oDBGOhI7Z
         u4L7z98Frx99XKH7irS3PljGySz7ODuEBRZ1RGVMdW6ng+qXhx/J4NlfaPyFFORNo51Y
         wQpSP0X+l+/gsYcjgXHaXE9y7/z8opMkvYyth1QSZnTs3cnHPXp8E9Y3q2TlYLnYW9EA
         rWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273183; x=1696877983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUMMYHvgPHC3FfvjsnckoOJeoQiZG6ia/eSTyXFZQWY=;
        b=wW4dp1xAiqOwxfanwE8j75HtaOGvx9JAskIwUuL/xEhrcS8oIi/778uPm8ynM81POv
         HiZv56Dn7hvawqzdhwAilYa5ONpY8SSU3bVnKfJEkpFo4LckhrBe9ieEsNBruIB2c+Kv
         GxBHC/0iHNtGxutse+V6eC75brfSlbfdbAMp80k8S8XO7j0EQYMlpcM768pbE1+SL+ww
         cRsMAQxakKlnye3MRVVFddHXHeTMua08hVvQaxX0Dxvc9NerqG4Wzq3Y1VYYh5Mh6N0l
         z8mGMmCIqmxlGq7WzHz+zjOOKAAiuoP3kozI94bK+9nlwNJV1WYFwSc3VK6mXxd0EhAH
         L7GA==
X-Gm-Message-State: AOJu0YyMQa6S0Pv6hu+G6WhGjEowm5flQhRYnVV++orUYRCqAU7/mqjE
        3o8/SOeFT6ZPRRP7viobG13InA==
X-Google-Smtp-Source: AGHT+IEgxFY+35KvD5H3tSxWVYVRmZNUF09HNGbEzDO2oFLSFdd5IOhZLmpK+kmZLitoT04UbgVrRg==
X-Received: by 2002:a19:f814:0:b0:503:343a:829f with SMTP id a20-20020a19f814000000b00503343a829fmr9526676lff.23.1696273182683;
        Mon, 02 Oct 2023 11:59:42 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00502d7365e8fsm2443981lfc.137.2023.10.02.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:59:42 -0700 (PDT)
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
Subject: [PATCH v5 2/6] cpufreq: qcom-nvmem: create L2 cache device
Date:   Mon,  2 Oct 2023 21:59:36 +0300
Message-Id: <20231002185940.1271800-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
index 84d7033e5efe..919f2ee9cafe 100644
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
+		struct platform_device *pdev;
+		struct device_node *cache;
+
+		cache = of_find_next_cache_node(dev->of_node);
+		if (!cache)
+			continue;
+
+		if (of_device_is_compatible(cache, "qcom,krait-l2-cache")) {
+			pdev = of_platform_device_create(cache, NULL, NULL);
+			/* ignore, this error is not fatal */
+			if (!pdev)
+				pr_err("%s: %pe, failed to create L2 cache node\n", __func__, pdev);
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

