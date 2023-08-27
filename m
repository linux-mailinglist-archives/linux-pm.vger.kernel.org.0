Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D867789B2B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 05:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjH0D2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Aug 2023 23:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjH0D2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2023 23:28:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9345D1BF
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5007f3d3235so3326642e87.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Aug 2023 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693106887; x=1693711687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGQGpgfeYNye1dt0r4z4EthF4Df+KGXsl1wiSoevU0U=;
        b=vlT9NoLRHvUa1GVtRYVRfHgKsp3Ww+lrBKkvGEfx4kTJIoyB8u5WtMv3eCSt6gNaWZ
         NMFaNGgqvGoTICRKywbNaXZjJ2ZMDjfp9h/SY/eNwV8+nLiftfSayVx0zb3fLZ9Ol8tx
         /9hKqYGbIzeia1WPJfpQewzp59JRsLvBEOBQaifFtzqQz4DLzOmnXJtTXoTwUByPk78X
         YuZZN1NZ0oK737vuZgklmA7Huau8Vylhr9nM87P4R73K5RwcdEKwlF1NAMmjSx5L68DM
         xk0w7kDHEZG976vyoy6Bbzq4eu2lwzkFzyFRUEMHj9PBzzTPQgCB5Xl/BsbqjjIv+CKz
         9hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106887; x=1693711687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGQGpgfeYNye1dt0r4z4EthF4Df+KGXsl1wiSoevU0U=;
        b=c5v/fleqf5DNDbjsyGxVM4SHJGRM6ShAbac5MjIYQSrAzzJ0aSCfuWySMArXffR5PV
         P2ESOAl/fCSU3lqsMuxKCAQLXIIb99jNYtLxWcLxJo7ygbAy+k8v9S4JQYsYarLyup0P
         Sea+tjHUXPVNbSpvVfIULt4D9iDR8UDFN4hFl8o5Jr66iK9wmNFlCs2XlwfwhmkYZ2jP
         GZpah6jZqm+sbO8jla85aHNUmomI9bmHHqjsAPHesjleW031Kx8PFaC6DSkiLPkLAeJE
         imee0E2rTVe2plucd36pRyzoTadCdcPxNc4Whj/keB+HXzBUEAGySBhcxW5cLxLpzSZ7
         /5nw==
X-Gm-Message-State: AOJu0YwUNzL83NnnDzwSM3GXE+Oud/Hdx/nYRdQpCvqg6DuCByLo0elc
        BbaM7DH9tjmnbd1RGK9eHK8Ihg==
X-Google-Smtp-Source: AGHT+IFk+n/6PVtDoQJf+8ueLyFuYvOcTUbUYRtGdl2csVNXctHp302ZQqhPDY8Vq5EilsYbGtTdgg==
X-Received: by 2002:a05:6512:33c1:b0:4ff:a23b:de27 with SMTP id d1-20020a05651233c100b004ffa23bde27mr2883484lfg.50.1693106887697;
        Sat, 26 Aug 2023 20:28:07 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm955709lfk.220.2023.08.26.20.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 20:28:07 -0700 (PDT)
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
Subject: [PATCH v4 4/6] cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
Date:   Sun, 27 Aug 2023 06:28:01 +0300
Message-Id: <20230827032803.934819-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
References: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fuses used on msm8960 / apq8064 / ipq806x families of devices do not
have the pvs version. Drop this argument from parsing function.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 04329ef61150..81c080b854fe 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -50,7 +50,7 @@ struct qcom_cpufreq_drv {
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
 static void get_krait_bin_format_a(struct device *cpu_dev,
-					  int *speed, int *pvs, int *pvs_ver,
+					  int *speed, int *pvs,
 					  u8 *buf)
 {
 	u32 pte_efuse;
@@ -181,8 +181,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 
 	switch (len) {
 	case 4:
-		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
-				       speedbin);
+		get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 		break;
 	case 8:
 		get_krait_bin_format_b(cpu_dev, &speed, &pvs, &pvs_ver,
-- 
2.39.2

