Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44A1562DD5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiGAIVU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiGAIVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:21:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEFE70E40
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p14so1777755pfh.6
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxgLelNuWT5l4LKZo/aKRP7N8N8MOwnW7uf8T3lO5YM=;
        b=RIqayPswkbEVZ3ZMVbRpS2q5QXKz8JXz6cJQ0EH2xhUIXtemnD0X2jEy+t2eVl5yw+
         Hv/MQd/ESQj1lVAskkrBZtJ0rVB4O4HlGHVnxXYl2oImWDBc2nfZQ3VQ5yVBW8Nnlgg2
         CQpYfPbVjOwBZn1jLGEYCFpe10LcwFlRAD96bVL4s/HjdnEIPkwM/YwqUFRk/oFtR2SC
         dDiZuIRbpV3mdvTYtRPeG1C2V//NGF+iS0NZhzKFEmhrVJobhNhRYHMgJ5Sp7WjyRsyC
         hRq3+tYiH4bHY6QiL6Pi84K0JliTjskicQ8c83gZg6kkT+OtTVAiqzNVRrPyU8tMic/i
         lVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxgLelNuWT5l4LKZo/aKRP7N8N8MOwnW7uf8T3lO5YM=;
        b=61LoDQBHYQeLFPL25i3bp8H344NM3IlmhDIR+yRZ/3Thr3In7wyJmH6Cl0sOiq1E1y
         XSnePzRIjsdPBBbwLOOKgxighSX0YO8vw5znR+VvfevkorFoxkgjnB/shoCJ1C2QQgPW
         D/V7I0QaHaJ/g2paq8xxWVQDF16KGa0DHB/YBjmgMkqb1ohZ/Ob7j3FFY5cuHtZcvPLu
         ZWidMcAr4iuCNZm3f9tNqhRc86a6kggPDz3uID3xnYbr19wJzD/TavryDjJ5TXUX2Jsa
         MsXi7GK3RQMuMa3I/ZLT9RUd2Q8W4lOGlYuMaa9qnVo4enhenOAB3s7cm8E9y69dUG0T
         oIRA==
X-Gm-Message-State: AJIora8Rqc2ej6TZ8MPWhTIla9GsL2vBmq7RKSgUPFaVPLI6UJdUhvxp
        UoqjHRItoFizcVIpF3udGzC5ow==
X-Google-Smtp-Source: AGRyM1uXq5wOQbUjInZMGnjqZB6uOUcrrsaHSAqLeSNKbmgBCDl3OTWafESheg7frLTic7Ml4STGXw==
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id d16-20020a056a0010d000b004f75af447b6mr20268070pfu.6.1656663661463;
        Fri, 01 Jul 2022 01:21:01 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902714a00b001693bd7427asm14959831plm.170.2022.07.01.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/30] cpufreq: sti: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:01 +0530
Message-Id: <808b80fad5be3ca92c3b873d8943a85e9ceb0215.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sti-cpufreq.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index fdb0a722d881..a67df90848c2 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -156,9 +156,13 @@ static int sti_cpufreq_set_opp_info(void)
 	unsigned int hw_info_offset;
 	unsigned int version[VERSION_ELEMENTS];
 	int pcode, substrate, major, minor;
-	int ret;
+	int opp_token, ret;
 	char name[MAX_PCODE_NAME_LEN];
-	struct opp_table *opp_table;
+	struct dev_pm_opp_config config = {
+		.supported_hw = version,
+		.supported_hw_count = ARRAY_SIZE(version),
+		.prop_name = name,
+	};
 
 	reg_fields = sti_cpufreq_match();
 	if (!reg_fields) {
@@ -210,21 +214,14 @@ static int sti_cpufreq_set_opp_info(void)
 
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
-	if (IS_ERR(opp_table)) {
-		dev_err(dev, "Failed to set supported hardware\n");
-		ret = PTR_ERR(opp_table);
-		goto err_put_prop_name;
+	opp_token = dev_pm_opp_set_config(dev, &config);
+	if (opp_token < 0) {
+		dev_err(dev, "Failed to set OPP config\n");
+		return opp_token;
 	}
 
 	dev_dbg(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
@@ -233,10 +230,6 @@ static int sti_cpufreq_set_opp_info(void)
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

