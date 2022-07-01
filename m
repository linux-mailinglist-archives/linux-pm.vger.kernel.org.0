Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A86562DE0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiGAIWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiGAIWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:22:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A471BFA
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k14so1717973plh.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAc+kN1ySAvqp/Eud8dE8Wbnfg0J+jhcZxT1spa0gTc=;
        b=HUaPH/BI6kU1br9WqbHqHqSqVN9ff10jniY8/NQouz1HB8c6uAVq/qJg/Mka0+sM/7
         P2YRz4dSTvbvEJKl+GweFNhRyJPH7OJmozxlXWZ4447PLurjA6ER97g45KIwT3A7gBws
         jBo4qeHYyS88784WGlNCEXfGzPvSjEXYSsYBKIwoYHqG4LnA3nhUl2sHFxljWFtqWwkJ
         2OBCbkZ9gnsQK1p96B8sOLetG0Vc40VTJK2kquhIrU/JjbsBx14jb2vxpmyBH/K6kw6g
         W4Hl+0u/Z3a3zt/G5J6L78nFvOkZNHq9NbmqtbJ3/DFGXheyKrTS+KeFP/MBmez4aMQt
         aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAc+kN1ySAvqp/Eud8dE8Wbnfg0J+jhcZxT1spa0gTc=;
        b=IUeUXppmxwIKzJ+9AprqrMA5R50iF6MdC3fjwtb2azFrGHgzElu2mUTJJ4j1TmMc9B
         vxhXOrFiS6hzU9zr0sXttWlMEu5/1yzMOty6khuBphYz4AuLapC6Xa9EBmrbpjj2cJJ2
         FXRIG51VCaoxQwZ/nIBW2wuGTxJo3OjHrc8eH/WeXl0ktPnWAq87slyLItdGqD3LqHFa
         nq/zexUsXWiYUO3eN3YNe1TmiHI7WFNGhdTW08kLgHT5Q2MMkqRGLm4rJOUzcMlgddiv
         8Tqg1gaZ94Bc95mT5h7xsauJkdpbyXjNhMd7Xd7/HwaKYeaionOAaY01A6EkHRg03gxm
         ADLQ==
X-Gm-Message-State: AJIora9jENEpYMHWVtoXaydKaTqAcxLkO9xdhSvnAomfIFDKLvWYcUOH
        SmMVSDAlUFKui/m+ipUgV7hfog==
X-Google-Smtp-Source: AGRyM1v1kqhqtK/oHYzbUIbUj2OqYg5rnC/os5FGevGXj5S7g/n8eBMUivPzzlqKWYPfnaz/Mz9mMQ==
X-Received: by 2002:a17:903:41d2:b0:16a:2cca:4869 with SMTP id u18-20020a17090341d200b0016a2cca4869mr19791613ple.13.1656663700704;
        Fri, 01 Jul 2022 01:21:40 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709028c8200b0016a3248376esm14700448plo.181.2022.07.01.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 20/30] OPP: ti: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:15 +0530
Message-Id: <2fc93a6fc1b07d0dec80e47376bf1dd53b6ad0ee.1656660185.git.viresh.kumar@linaro.org>
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
 drivers/opp/ti-opp-supply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index bd4771f388ab..26e929377ebd 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -382,6 +382,9 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct ti_opp_supply_of_data *of_data;
 	int ret = 0;
+	struct dev_pm_opp_config config = {
+		.set_opp = ti_opp_supply_set_opp,
+	};
 
 	match = of_match_device(ti_opp_supply_of_match, dev);
 	if (!match) {
@@ -405,9 +408,8 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = PTR_ERR_OR_ZERO(dev_pm_opp_register_set_opp_helper(cpu_dev,
-								 ti_opp_supply_set_opp));
-	if (ret)
+	ret = dev_pm_opp_set_config(cpu_dev, &config);
+	if (ret < 0)
 		_free_optimized_voltages(dev, &opp_data);
 
 	return ret;
-- 
2.31.1.272.g89b43f80a514

