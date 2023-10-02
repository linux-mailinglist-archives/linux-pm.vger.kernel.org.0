Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC82E7B5AC0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjJBS7u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjJBS7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:59:48 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55185EB
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 11:59:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50444e756deso53773e87.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273183; x=1696877983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+56KXdnxE65EkSdZoHmKszExF8hRCz4jAuhqSaYx84=;
        b=RHtJpeqpvfvlEYHBRlj6P931QKBBieNT+gIGCfhsSrk7Qx3Fnbqi84lTKZ9gB08rIx
         G92ni8UhydGa3ds+lHd9dUOIycLQL6Kk+t2SAbZ1qXlqGM6/y95CxxbNEQCCqsqoQ9eQ
         OmmgeJLBDVwh6KKvY6dY3aYNOZxxcIaxB8Y5cCU6ueG47hZp+fdipJN1Gj78zvmery4Q
         V90txEuWk2DCDhBu7kAOUSZRPUY0kvjALZHg9UPwfelTdYS5zMt0mkymrn/Wb5SEm24U
         JWTTtmftGdM+bL+oIo7/QihwVQDABxuI9McCDy/IGazX0KN2z0HOeVGTEv/RiDfFCpKH
         S3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273183; x=1696877983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+56KXdnxE65EkSdZoHmKszExF8hRCz4jAuhqSaYx84=;
        b=F4lH/jmelHA/XVs3tmortxM/EBOqJe7kc9+LELRtQ7eht2qa337aXqC8kZ1Df5It7t
         Z07vF/QGxl2sB8xfPhf5SAcT/prVbrdGyyb789Hvk8axXskvOilMDLkKVBxK3YTXo6UL
         74S95E1152DaNIq5F4UUyeAgf6v7fI+8WHeGWgKH05OCc4mWbiQ/5QqAn1As7zBuNwUB
         sDBuA06RcSi1R3gn+ZarIOcK0jXQTufJwC+zuFO2MPY+w0F1RmY4McTT0Lmm1d4OQYq5
         ZaJ0CQ6ZhY/TkC38kpbeiWE9ug4uxFE4fT+hDfHZ0/yEbWvaI/VkWFu9CIpZA+D8+JJL
         DHbQ==
X-Gm-Message-State: AOJu0Yy3k8vvwT/m5WWSa9VzEj+TNDzaC9FehD5T9Y6KUzWGuKWsP6Pi
        yx7D2IFFLavIgy2J8zCpyb4thg==
X-Google-Smtp-Source: AGHT+IGsvZCvt/wf7r/3mXfcPjQ5EYeujepsUhoo6d+dKmFSmHIRZsTUCxc9T6L/QX6onz8XGVW1lw==
X-Received: by 2002:a05:6512:5cf:b0:500:92f1:c341 with SMTP id o15-20020a05651205cf00b0050092f1c341mr9311900lfo.54.1696273183479;
        Mon, 02 Oct 2023 11:59:43 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00502d7365e8fsm2443981lfc.137.2023.10.02.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:59:43 -0700 (PDT)
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
Subject: [PATCH v5 3/6] cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu
Date:   Mon,  2 Oct 2023 21:59:37 +0300
Message-Id: <20231002185940.1271800-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
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

the qcom-cpufreq-nvmem driver attempts to support both Qualcomm Kryo
(newer 64-bit ARMv8 cores) and Krait (older 32-bit ARMv7 cores). It
makes no sense to use 'operating-points-v2-kryo-cpu' compatibility node
for the Krait cores. Add support for 'operating-points-v2-krait-cpu'
compatibility string.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 919f2ee9cafe..9db060bed742 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -238,7 +238,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu") ||
+	      of_device_is_compatible(np, "operating-points-v2-krait-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
-- 
2.39.2

