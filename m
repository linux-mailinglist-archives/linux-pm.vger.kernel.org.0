Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5C565458
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jul 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGDMIP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiGDMIO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 08:08:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7A26D5
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 05:08:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4074410pjo.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfE4CypbYijTDGyXwa2amCPLxG9OKV5lx3ftdIcweMc=;
        b=VOQJJ0Xj/keiRsNE95xbWVq38yfDGgT0CJdYARDTyHrjtV95Uc7sIddF49E+uHQB8W
         DKqF1YdxyG2JQ2Y/2iig0KDAG2jVxWnLUhjs98cQbu5TmUNfqmVRwp4IeB3lhaZNphN6
         V9n71n5QAbcZDGZNZT5Aa7pVyqw3H5bbVxINxocWdRcT3RtNX/mKpHVLVzxFZKOdSgIt
         mZZduUrAHuSRleXG5LxEHs+yi+6Iva1IuOZIkcorwseVgaJXkkPHoFmFVy0iZXgFD76j
         3U3Ex1JLKEVxe4LPtOSbwFKBU+99HnItBt/Zrum/Ad7gIPy6HIduiDWG9OcSXGjKYPl6
         zibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfE4CypbYijTDGyXwa2amCPLxG9OKV5lx3ftdIcweMc=;
        b=oGwGfVTq0MLW2AFI3W6R7TnLGGcPPQgHfbnegdDhZPr5Lg2XRQko+RBSsgCDEUzMdb
         6iwdFKnO3ylmR7DEf2YSRgnWgrZMFdsUcTvQ+EKx225ev/hmyUKqO619KpG8Uukgypr4
         7t3JT6X+ubo+yamR9vIab7Zt7YVMNihGlZzSyJ4enf4gPVEAZBHaBUVxVs5cc5IoP2NJ
         sX+jnYZh3InDdZKIUqoMPd1B0Lxy93gayY+gtYAcJvM3ydfQ9rkQ9gQi65mfAw2BPvZ/
         F3CtK+/9NLPgCixGEDcAqnZuGIv+EAyVi/+7FFU1+irFzXbHWD1VmQWSB9cPK6ZOEFyy
         Nq/w==
X-Gm-Message-State: AJIora+vD1JgWGCfexkS6YyLe5glDf19s5MK7ulEziRra5wBy1j0Xb+r
        bncSLJAmDIIbPoQWEadPbwqb4g==
X-Google-Smtp-Source: AGRyM1sEiZGHuKgCdtlWDDXh3Q8VSVWbopUUJNuMEHLrtBilE/TOPNcCiyxk+knqz76QgtmPzTy/qQ==
X-Received: by 2002:a17:902:934c:b0:167:80c6:aedd with SMTP id g12-20020a170902934c00b0016780c6aeddmr36946238plp.97.1656936492939;
        Mon, 04 Jul 2022 05:08:12 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id bc12-20020a170902930c00b0015e8d4eb1d5sm20991256plb.31.2022.07.04.05.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/20] OPP: Track if clock name is configured by platform
Date:   Mon,  4 Jul 2022 17:37:39 +0530
Message-Id: <0a43452bb6b1f499b695b123e9fedf4b1a9bbf64.1656935522.git.viresh.kumar@linaro.org>
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

Track if the clock name is configured by the platform or not. This is a
preparatory change and will be used by later commits. This also makes
the behavior of the clkname API similar to other ones, which allow
repeated calls to the same API for each CPU.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 7 +++++++
 drivers/opp/opp.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b2715950e76d..e166bfe5fc90 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2277,6 +2277,10 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
+	/* Another CPU that shares the OPP table has set the clkname ? */
+	if (opp_table->clk_configured)
+		return opp_table;
+
 	/* clk shouldn't be initialized at this point */
 	if (WARN_ON(opp_table->clk)) {
 		ret = -EBUSY;
@@ -2291,6 +2295,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
+	opp_table->clk_configured = true;
+
 	return opp_table;
 
 err:
@@ -2311,6 +2317,7 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 
 	clk_put(opp_table->clk);
 	opp_table->clk = ERR_PTR(-EINVAL);
+	opp_table->clk_configured = false;
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45e3a55239a1..9e1cfcb0ea98 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -149,6 +149,7 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @clk_configured: Clock name is configured by the platform.
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
@@ -200,6 +201,7 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	bool clk_configured;
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
-- 
2.31.1.272.g89b43f80a514

