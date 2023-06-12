Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8872B78E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjFLFkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjFLFjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDD10DB
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso4589614e87.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548374; x=1689140374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGbEet3b/rx50jFo75nJLCsb42VjSV2dPYjIjeFOCt8=;
        b=lr/oAEMxboBfDXF2LsVGtrS0ya/WVbVUGIwqExLo0cZ6hMpIkHNGjrbOOgOoHzQqeW
         g4Htv/C83MeDI0kg8jN1qYttDmnll+vCA9MTm5S/ckblAWDsRtscWF9WaBrW7wkCNSik
         SGoLEQc/BLAydNnMpXlHwNux3fIoU8J7/t9jIl74iXrocL+4JfIBhGpJej+Z8g7OXKIW
         ZDRFFWxu2alK5AzrmVyD4wA+sHbZlWdwWhL4SYE1pW7xfloRvvfqnOxHoYd2Oo5O7qga
         iscJCPSsTnSNXCszmC34fCDNjt1g4vDIPAms5cqOeBVLroK7itUK1oJLaSo1TPKPBuEd
         pw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548374; x=1689140374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGbEet3b/rx50jFo75nJLCsb42VjSV2dPYjIjeFOCt8=;
        b=c0TObzb1fgVPt0uK0KYNufgUGNrdPRV6ebB6VkPbvhiXCvdfrx1lBVXXaatIlEDvmc
         w9MUdIeOE39rWtmmZUky7KJQPtgn9nvyIi7weV37l81RoOQKRfECxV/BXOEHxExFN5MW
         73HmZ/gMpv8p0UV8p8sH38iUF2VOO4b/VDaQHt8DYWiEdgnNjFPAmnxutif1vzmxnEOP
         G8aM0WF80N2P8oBiA2ucqZIkZ1Niehzf7emr9Wt09jD6ipynUqN1VNRYusT2ds7Uakp8
         P9Rpbv5z6hZJo8D64QS9ZZw2/P+G5CSJ7JgdnKV93vLAu/6ZXRzOLVa7+zkq4QsnjMdl
         kSXw==
X-Gm-Message-State: AC+VfDwq6xG2P5T5odgNun2om1ig7Qp3L2+FFfKXHqmPXYh/OVUknyrr
        Yyi3wWWFf2PLFCfqf2hIokLQNg==
X-Google-Smtp-Source: ACHHUZ7HPvLQel7zvNvRhYb3yBGVftlTckyxUnBQbpOjBTRAoFg5EDh72iFkfJB9+PMS0MNWmWsZQw==
X-Received: by 2002:a19:770e:0:b0:4eb:e8e:4139 with SMTP id s14-20020a19770e000000b004eb0e8e4139mr2594263lfc.2.1686548373841;
        Sun, 11 Jun 2023 22:39:33 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:33 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 10/18] cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
Date:   Mon, 12 Jun 2023 08:39:14 +0300
Message-Id: <20230612053922.3284394-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
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

The fuses used on msm8960 / apq8064 / ipq806x families of devices do not
have the pvs version. Drop this argument from parsing function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 18d6e6ed1bd0..fc446acfda22 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -52,7 +52,7 @@ struct qcom_cpufreq_drv {
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
 static void get_krait_bin_format_a(struct device *cpu_dev,
-					  int *speed, int *pvs, int *pvs_ver,
+					  int *speed, int *pvs,
 					  u8 *buf)
 {
 	u32 pte_efuse;
@@ -183,7 +183,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 
 	switch (len) {
 	case 4:
-		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
+		get_krait_bin_format_a(cpu_dev, &speed, &pvs,
 				       speedbin);
 		break;
 	case 8:
-- 
2.39.2

