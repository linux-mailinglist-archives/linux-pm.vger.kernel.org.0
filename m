Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88168565466
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jul 2022 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiGDMIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiGDMIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 08:08:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CB26D7
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 05:08:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so9388774pji.4
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxgLelNuWT5l4LKZo/aKRP7N8N8MOwnW7uf8T3lO5YM=;
        b=M5sqMky7dul93mwO1cpzt2UVIUkgqSJnlBiS4jQzhp3uCqpkv9Uj8sBRIzNWCp/4/r
         /WuapDAVKxR/Ztt/xdo0cWzoAPLRjOuMcOYbjsm+CJus296d/NjdWB6UP+Fq0h3fy1xy
         ZBTFTkZ1f+H3upB9gQXHVAEnI2yUvawtGn582FfX30yWYdBVBOugD+lhDP9+2OnUq+Km
         6V+ZPLUHLDur44Ah00QHHUYeLqfuzelPXsML0KTZdq04Sq9vFIjdTYNogZkyuraPfzUM
         hJnvWsj3c6AE5YReSV5gjYbmWjn/XqAU9xBxHUMTlsj5Hy4CrUyHm+PhsvAuHuR/DSz7
         ldpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxgLelNuWT5l4LKZo/aKRP7N8N8MOwnW7uf8T3lO5YM=;
        b=iwPbQMkmVa8Nbwb5oTCCpTC6p/S7jXZqPi6hzObdtGcg6ozW/5S1VfR+8JDnYW9qIF
         H+1F5dVxPmebo9eWvRLzST6I4rL/NPVowXXw+qbDQK4L/xjBYQY3GxTxFeQ0ohzico0v
         jwuM9Bw5uTlM8LlOQFZLcM23zAntzgv9h81r106TqNIswahzriEmR7Kj/Z8Pp63g+TAs
         LLLOzwjMmLpbFoNcd1HP8CCkBZQhCLbhNt+X9Zd2ejfPuCbCpO+NIhx1/n0SqJRiHpk2
         axv/kM56GoS/wLSAI+FPkVLf92TWorTTruMXyZSoqoZMnSxXwaxm4q2jvTHE2GVzvECg
         nNtA==
X-Gm-Message-State: AJIora8P5lzY8+4wrIHJlqzkRAb54gbWlwmlp4Ik9l9bWqq+jjxJK7WK
        +UlXb0amxNk7qaVO4pUXT8DoJA==
X-Google-Smtp-Source: AGRyM1toKei5gUmcV+0t+PABYig/AwZPmv/yv+3Ilq4Kot+Y4MOsLO3uFqP/qQMxIcknTkRKzRuqQA==
X-Received: by 2002:a17:90b:2285:b0:1ec:aa3f:8dc1 with SMTP id kx5-20020a17090b228500b001ecaa3f8dc1mr36415858pjb.145.1656936505024;
        Mon, 04 Jul 2022 05:08:25 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090302c700b00168e83eda56sm21060261plk.3.2022.07.04.05.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 05/20] cpufreq: sti: Migrate to dev_pm_opp_set_config()
Date:   Mon,  4 Jul 2022 17:37:43 +0530
Message-Id: <0b24496df4a70225c777726ffe2540cf83a3c079.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

