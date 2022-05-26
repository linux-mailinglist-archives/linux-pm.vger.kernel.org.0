Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16136534E73
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiEZLpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbiEZLoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:44:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD3D4122
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cv10so1514241pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnikfB78qN2eYHl4FR7LPxdyycjHoZ9Hgqa39kltcXQ=;
        b=iLa9+C/z31eA64sQJIWGTLNaXb2oUnaLppIs8+xdJ+XS+eVWwbWjVMA1xaMtm/g9zp
         fQK8S0t8bACe27kKS2NezrOJtXk1UeWGGwn9TKiXdBS0+LJRJhibcPm7xOP8qWahqAE9
         wrwX6s2oR2W5dBzZQOMePd7wqgxPgGxbxcC2u/tuK3e11BTC6KPzWM7Bf1KBb+FhBuB7
         XeyVcxMN8gM1gxShGrX9udLdNm6cM8mbfl1U3BpT40Mdaxu0QX0mapb1COoDfpVtox3v
         fVzHqig8Cr/AdA65AdyNFmbPd+6yQyBnL/vqPuOzSmFD+PI2I0dgpW98NtFROFkI168M
         LhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnikfB78qN2eYHl4FR7LPxdyycjHoZ9Hgqa39kltcXQ=;
        b=EJKfi8Vbe9lvmwCoz4FOJ8GgM+LZCdCuZ7qbtOp3xVuEAl8L4X7x0g5XtaMGcXEFB/
         15e49QwZApMlPgr8zN9M5t8umhKelTVQm+3agC3Oqm68GBuj1kW3VZtg5anDsfEuZmpb
         m3bQ4H6B98xkg7NtN4rh3PELjNZWOZacW6ZocUs5nifVQxOl6bq1K1DTXEyOF9GCkYzq
         wm0uvSqUNXt70VzZZhDuhGz1Yrouh6sqTsfXo+OUyY3+jFZmrToRBRd7Av31ZQ97T1SP
         7zbAHZBo8kKztZbCWeDl0t5gP85kv50BauyyngqQWkL9QILAMtjEPGJPjHkaMMabDYUq
         N09A==
X-Gm-Message-State: AOAM532PCoaaZf6QLWQyQUflV4UlZg67HwKa1ztcIZ22CdttOJHsG5l5
        hZ9wTfGtI76BsHIFcnj/8ClMSA==
X-Google-Smtp-Source: ABdhPJxxhjUF1JGPGdIx5+uHDoJrHMIiF47mG2/D6YAqtvdWuR0wXd119OG9/t5XyNMERogQGTBd8Q==
X-Received: by 2002:a17:902:8f86:b0:162:22ff:496b with SMTP id z6-20020a1709028f8600b0016222ff496bmr19413781plo.105.1653565468446;
        Thu, 26 May 2022 04:44:28 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w67-20020a623046000000b00518424f8922sm1294114pfw.77.2022.05.26.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/31] OPP: ti: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:19 +0530
Message-Id: <bc6726196db7116065e7f6dffc6dfb1e50c77700.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/opp/ti-opp-supply.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index bd4771f388ab..a30825dc30cf 100644
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
@@ -405,8 +408,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = PTR_ERR_OR_ZERO(dev_pm_opp_register_set_opp_helper(cpu_dev,
-								 ti_opp_supply_set_opp));
+	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_config(cpu_dev, &config));
 	if (ret)
 		_free_optimized_voltages(dev, &opp_data);
 
-- 
2.31.1.272.g89b43f80a514

