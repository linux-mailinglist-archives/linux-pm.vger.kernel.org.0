Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8556B7434B4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jun 2023 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjF3GFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jun 2023 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3GFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2023 02:05:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EDA2122
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 23:05:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2633fe9b6c0so931153a91.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688105146; x=1690697146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoWE23CXzwwvKS/GqWrSHTla9or+X8quOknw9f7pTDY=;
        b=xDtl7ksuvO5i2QhER94EPHHNNBlxCU8+PaHhx/Jb5jwnmxB6jaas62WI/Am8IxPwZO
         teSR1kdfWeef7fbPP4sRT2DD7M5CXYFt0j8+YxsDE7ozCIZd8GrPhIcotmLbTFlnfJzM
         1Hq0nSfgrAxaM8EeZsBnKmn/W94r25g5MhOGRTkmDEYTesBvcCnXseekWq7AQnnkY91l
         52FStTweEJGrcysgp9Q7+GuXiYyf7Q0JVU//klq9JNDb+L5a/pdoXf77KTdfSmPPUGhi
         tUBqChTEbOYetyN+E/TTa64+uxVn1p0zrgbMUZOHrNbuDRFHZmlgS3OuX4/K3coqfBGh
         0ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688105146; x=1690697146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoWE23CXzwwvKS/GqWrSHTla9or+X8quOknw9f7pTDY=;
        b=PhMossiXPtGjQezjY08K82ltKg5nhSCDuGbkPOms4AzfoCLdK8av2byTXBtwl8uQPC
         11uOW6qFInip6dKeEhIogM0XWUD9W8Jbz6pMmgu6rBagcsD0ZtbYYKPcfqgf/VWDMmvP
         YBEFyRrQsie35W1ySQ+DjKIIhkAog7N9wLeOiLTQrw9OSXKh1OWyb++UrhbPYNgZ6XO1
         D741pUFTOLnv0KQyMNgKV2181rAlsrD3S79jC0ouH1pnmcxnYVLZngao7X8zr3Vrkwu6
         h2VLzoESg2/IDrIpQWr8pgyJ1UL4uRTAAfz4xSwznQxL1NGzy+gve5ZMbfvPxuC9ng8m
         4W+Q==
X-Gm-Message-State: AC+VfDwiQxCjXKYDDuR81DLM/GZtXdUgViA1cPLRLnH9SH3wktP6IP8p
        91MY2R/VVu4GPZiX2XErV1qNvg==
X-Google-Smtp-Source: ACHHUZ7zMT8JD1BZ3GCoxKp65FxEBzvlf+8OksNhXYlgF77Ndx5OwkIR3gU4UkPfq4uV/gnonDKe5g==
X-Received: by 2002:a17:90a:6e02:b0:261:326d:99e8 with SMTP id b2-20020a17090a6e0200b00261326d99e8mr8159709pjk.2.1688105146135;
        Thu, 29 Jun 2023 23:05:46 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a1f8d00b0025bf9e02e1bsm10823351pja.51.2023.06.29.23.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 23:05:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Zhipeng Wang <zhipeng.wang_1@nxp.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Make CONFIG_CPUFREQ_DT_PLATDEV depend on OF
Date:   Fri, 30 Jun 2023 11:35:41 +0530
Message-Id: <4639e8e00a321e2bbbe4dcbb93e57ca6c10bab51.1688105074.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq-dt-platform.c driver requires CONFIG_OF to be selected. Mark
it as a dependency.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306250025.savpMM8L-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rafael,

Please apply this directly for v6.5. Thanks.

 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index dda3a78bfd5c..6693d52ac3fa 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -219,6 +219,7 @@ config CPUFREQ_DT
 
 config CPUFREQ_DT_PLATDEV
 	tristate "Generic DT based cpufreq platdev driver"
+	depends on OF
 	help
 	  This adds a generic DT based cpufreq platdev driver for frequency
 	  management.  This creates a 'cpufreq-dt' platform device, on the
-- 
2.31.1.272.g89b43f80a514

