Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3550956B026
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiGHBo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiGHBo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 21:44:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6412D38
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 18:44:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n10so3303914wrc.4
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tA1T69NTAu2GrtW3MQqMLxs934MrKxAEy6GEq/EFFiY=;
        b=rL6nHlsKVSr8t/NeupTRp5VCJb2s6NGVgLM6ymWbs4RYw5bRx2N55bdlSTgs0Bn/yI
         +AcogrlsCRRpi6nBab/KaAKa+zMu07Tal9YN46za2g0V8gk4b2p5aQGM5dWgUoURoJ/k
         gtHfASQ2+KecMgRMCw3xqnCdcJxjn6+mCbON91+alKA2xW+kbYNRC+hJm4HlIVV0ku4S
         BpjCxwZRcEsexID53XZvyaLDTF80s1h3PXOIf7QEoL3s1QEm++Aeg+bk3MbWNlPtqlzo
         H8wUiB/xq6YyskEw5Mp61w7SpY4qGhkWurus2SX/ETajJY0XLZv6D4jm4Chf9Zutn/D/
         ZEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tA1T69NTAu2GrtW3MQqMLxs934MrKxAEy6GEq/EFFiY=;
        b=qewD6doawP7ydWzcykf7ozIjMEHHpywsKWhoivgc9v3xLaQIAE2ejHM7EiHNN4jCWu
         RAP+uFMgxYnu5zM489nYicGo/mxTccWr1HlMSkn5De56PjNMDa950tb1AybE/DZE5Z0S
         iF/RsG1QdJJeFp00jzpxgbU+7avXm9zKiK0KgDcBKbLlcTER8xWO+oqOd7+tsFSbUOoB
         U6gY5PtbNcLnrgkgFCmc3P5yH9HKYOyDQa9aRxuGr1SQJ0QVg3VE0S7nncWvtwz1iqTs
         xI+rQzKW9To602YzyB+hXdELpPDji7/N2o8zOZqPjmTrkw+dQnuVKbeUi+IcGiKb7A4g
         80Bg==
X-Gm-Message-State: AJIora8nwWiig+NxM9PfqcVAMTGwbd9O2n0a+nSXG8mVpj5IHpOu7pa6
        kzKhWO3K3Heiy2/E7uFbzEa9Vg==
X-Google-Smtp-Source: AGRyM1sb0xTEO1GlKvD6kKmv1jDxMZTw1qjGgB6EkBag2vAnOG3nALiC408OE+fGUNqXvfPaxKwasg==
X-Received: by 2002:a5d:4e04:0:b0:21d:6ec3:38a2 with SMTP id p4-20020a5d4e04000000b0021d6ec338a2mr753962wrt.362.1657244666788;
        Thu, 07 Jul 2022 18:44:26 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0021d4aca9d1esm22732846wru.99.2022.07.07.18.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 18:44:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, stephan@gerhold.net
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 4/4] cpufreq: blocklist Qualcomm msm8939 in cpufreq-dt-platdev
Date:   Fri,  8 Jul 2022 02:44:19 +0100
Message-Id: <20220708014419.2009018-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708014419.2009018-1-bryan.odonoghue@linaro.org>
References: <20220708014419.2009018-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

msm8939 will use qcom-cpufreq-nvmem. Block it on the generic cpufreq-dt
list.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2c96de3f2d83c..26c97ab778974 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -137,6 +137,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra210", },
 
 	{ .compatible = "qcom,apq8096", },
+	{ .compatible = "qcom,msm8939", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sa8155p" },
-- 
2.36.1

