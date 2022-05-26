Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D101C534E40
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiEZLnw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiEZLnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:43:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358BE3FBD0
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso1539747pjg.0
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5eTD6wz1RXfj8aC8lU6FuYhpZBKLogZOeVce0BXIgM=;
        b=hyg3hFnQcPvN2g1w1Dk7J+XwKPQZFfUbC4t8cmaoD+p2EK9JJlbZowvdc5GDn2InTZ
         U/hmhwfU0LvuiYyE9robqo4jdwQQqInnjxW/Pl1wzI0O8uW2DwgSLzevQlopXFz5fDDQ
         RBQIZ9BWrpxnWvDDB6UO4Hu1VYTzO5OEyoI4iJEmWmlERXPuhRtdi+9kJFFKZ9NM/Dkf
         8ua/vHhARhWTbkCkUyI66x1IC49r09iZw7/dTHhXSC6CKW282fnDITCiULd3xIY0vgsc
         vSiEWao+Zffi8wJQ/olvRqsXhWfsfPpTo3oNS1m8pjS0ILEDsUMoNYBT2Irwy/NprreE
         2ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5eTD6wz1RXfj8aC8lU6FuYhpZBKLogZOeVce0BXIgM=;
        b=F6JcqK3b7PDZiJUtq1L7w1r2IMUPb0+r+QZN/v4Tku+J5zgWEVV88LVUfYHpcbjFzO
         TYZYHnstmiuWXbOOpDGwKlwjbtTcdEkWhZCRUr+ygLuXpOIQKtJo5q3Xor3dhKL6iraU
         z24VICpSv4qAVDpGhwPT+jqDmsv2LdNbKrKI05MAkspXk6wzdIdDVo3oybUCf7yQUouY
         3tPGT0c69LFj1qlVSl7pQS3gnpi01z55vgL4KmYxOGhb0KU5lf6iv6OHuB0Q6vKy11c4
         rvvMv//E1RBDxB1m+YtnTEiDl6Kojuzta4SEN8WEbtgFPMKqvNKLZCwajPQEGSBXahC9
         +afQ==
X-Gm-Message-State: AOAM533gl285EeEbsVUx6xxLKhF1mG/daWmpD4FR6djILk+crBnIVTKQ
        KQROAR+GvWV3qlAGNixjmqVf6g==
X-Google-Smtp-Source: ABdhPJxX52apzdGJ+G31jFpsd6qyzr51sC9eQfAIoKm53t4NTL029WnhH6PlgGdl81lH5onahxYScQ==
X-Received: by 2002:a17:90b:1d87:b0:1dc:a9c0:3d49 with SMTP id pf7-20020a17090b1d8700b001dca9c03d49mr2272677pjb.12.1653565423783;
        Thu, 26 May 2022 04:43:43 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902e48200b001617e18e253sm221482ple.143.2022.05.26.04.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/31] cpufreq: sti: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:05 +0530
Message-Id: <a8de04432a90f35f7a6ee9aec8555f829e7ca9bd.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sti-cpufreq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index fdb0a722d881..f4121a9d27e5 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -159,6 +159,11 @@ static int sti_cpufreq_set_opp_info(void)
 	int ret;
 	char name[MAX_PCODE_NAME_LEN];
 	struct opp_table *opp_table;
+	struct dev_pm_opp_config config = {
+		.supported_hw = version,
+		.supported_hw_count = ARRAY_SIZE(version),
+		.prop_name = name,
+	};
 
 	reg_fields = sti_cpufreq_match();
 	if (!reg_fields) {
@@ -210,21 +215,14 @@ static int sti_cpufreq_set_opp_info(void)
 
 	snprintf(name, MAX_PCODE_NAME_LEN, "pcode%d", pcode);
 
-	opp_table = dev_pm_opp_set_prop_name(dev, name);
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to set prop name\n");
-		return PTR_ERR(opp_table);
-	}
-
 	version[0] = BIT(major);
 	version[1] = BIT(minor);
 	version[2] = BIT(substrate);
 
-	opp_table = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
+	opp_table = dev_pm_opp_set_config(dev, &config);
 	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to set supported hardware\n");
-		ret = PTR_ERR(opp_table);
-		goto err_put_prop_name;
+		dev_err(dev, "Failed to set OPP config\n");
+		return PTR_ERR(opp_table);
 	}
 
 	dev_dbg(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
@@ -233,10 +231,6 @@ static int sti_cpufreq_set_opp_info(void)
 		version[0], version[1], version[2]);
 
 	return 0;
-
-err_put_prop_name:
-	dev_pm_opp_put_prop_name(opp_table);
-	return ret;
 }
 
 static int sti_cpufreq_fetch_syscon_registers(void)
-- 
2.31.1.272.g89b43f80a514

