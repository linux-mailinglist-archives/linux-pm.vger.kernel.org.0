Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302D7C5203
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjJKL1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 07:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJKL1c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 07:27:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E92D93
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 04:27:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5033918c09eso8517819e87.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697023648; x=1697628448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zWK+bD8Aid1fpusuW1MHz1xIacL85O9/h4oyYVsZ/0=;
        b=Ej8D5yfkmy8v6C8HTqPcdvZP6KPW2sG9mFYuuLI04Az5JtVjtW3ZJFCiiOfvPt6DCT
         fY86pJktZ1gyYRs7skZCyvJBZT5zTQZes7jVwGAezewb/YcRYLSlop7+SwMCY0dZpT6B
         7JvZSxv7Nxt2YtxLTynNLvfGfJ56mt3JRHIOzrCx2cTJ8O8TvaZwuC4EQucG3rHAtOkE
         RlTuMxMQXONDQn8l7xIIBN0MSkCY5Fn3IqRTKS36g9PdjyCIAC8HdJEkbSm4IfQnnC8K
         fKgKPDNzeEmKqP1CT1ZGrQTpUYnqP5t5Nz1XdfzhhdrFwThwTsPQAiGpyMXjpNF0SnZE
         LdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023648; x=1697628448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zWK+bD8Aid1fpusuW1MHz1xIacL85O9/h4oyYVsZ/0=;
        b=X6UVB1FoHWyVHRLQBUKL9uETsR6SnJh2KTBBqzPmKX9eGZ26y2HNdCDS9JEaI3vmlx
         tkjczesEdJr75FDqPfWK1c41rgOsDNJa764J5y/W2MT8kRypwSSE8Q86l0EU61UZS/83
         pjYzPVbPBxeYcpnCFPA4I8pThbv6l9ZJu3gareISqya6PUYYjl4MSKZLSnEzwdZtyt7c
         joVdQLjOSox5Qhh3IB+c3X+YKxT0VoP9MZkPSfQz3ulb873Hi7vDV3MbGz2FdNSjKn5G
         7h7Slilt0irnUZBicyFA/7lBjRRu9mODI+7pC+hyqkNx5dhGn96QByZOAhoZRg5ZrRB5
         8LIA==
X-Gm-Message-State: AOJu0YyQ9K+l7lL8kEMyzWRXHiWYFcshMB0vlaD1K3R/0jmqNgF5T9Di
        +6nRYaeny0/xlVZMhiQFn2hphw==
X-Google-Smtp-Source: AGHT+IGvenwk2MJkOq3Kj8WNWwdd/u1jV8TzOJNidj7MkUHF50J7iU+JoTJQf+ppFys3K+MXURN1ow==
X-Received: by 2002:a05:6512:6c7:b0:503:95d:f2bd with SMTP id u7-20020a05651206c700b00503095df2bdmr20944407lff.34.1697023648266;
        Wed, 11 Oct 2023 04:27:28 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a29-20020a056512021d00b005008c11ca6dsm2228154lfo.184.2023.10.11.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:27:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] of: export of_find_next_cache_node() for modules
Date:   Wed, 11 Oct 2023 14:27:26 +0300
Message-Id: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The qcom-cpufreq-nvmem module uses of_find_next_cache_node() function,
so export it to be available to the modules.

Fixes: 7683a63c08ff ("cpufreq: qcom-nvmem: create L2 cache device")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patch fixes the discrepancy caused by the patch for the
qcom-cpufreq-nvmem. I'd like to ask for this patch to be also merged via
the cpufreq tree.

---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8d93cb6ea9cd..c4cf558e60d9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1905,6 +1905,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_find_next_cache_node);
 
 /**
  * of_find_last_cache_level - Find the level at which the last cache is
-- 
2.39.2

