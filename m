Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE901545ECA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jun 2022 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiFJIYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jun 2022 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347631AbiFJIYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2022 04:24:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2283ED87F
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 15so23260525pfy.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3J6lXA8/rnBftbG6MsbGJ9PP4BJZM2h2Yta2UTOvcDU=;
        b=jjcUUEhFvaPSb7bFG49Tbd3Z1VjBlGsuPIlk7NFMhLPoJ8gVI5ZQX8X8bjgIrMhGg7
         6svc82XE3Yw+JEyCn8f2tT2WXDtPvjsPh98puFpBr43czhAiWrUEoluUdl3Dh9FS4iH0
         UTCtzX6UJ1YucSJfGzK8hlJ1zDfJn5ppylIlBCAGBaVlTAbo4cqfb92/pMIb6pLX0D41
         1zXjlLF4gtjEXhU1ppXTRbbe+H9DCREaaFnOgO33lx4fXQhf4oaW3UgAitma87YmDxQd
         tCqxnA+OxPobKHC+WqX/BihdUXdjlu/rn5z/uiOqC14jV158mDr+kMDQ2UiGd08k1lDd
         Wmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3J6lXA8/rnBftbG6MsbGJ9PP4BJZM2h2Yta2UTOvcDU=;
        b=1b7VCBw80/3nnvudDNwWtadCtaLyOybTf+bCnJiV2nSeE8EhSb5E1kNry4Kq4q8W1m
         FmgPh8ghrIWf/A8+eOrTCgjLoFxFD26PsSBE6e69OUGj8psU0G/KZpKWBV7+Kbyjhvzd
         6shga3+2MbU8q+voQcDQ5s6OMIxc7UZ3ZY14yx+z7L86w2QTYzhDqaL+DNJI7xhSYtvC
         4TAwapdBGf+moNyeGZaMsnmt7EyK9OaGcNFtJEZZHdBKu76P2MUeMjin8qwgEHtnB/5Y
         L+fXE3R3kP2DUbSClbnCoLO6tvqEpUVsd9H/Mz9iVuKCcLH3hhIZoANjyyfN1L+nPWD6
         0vGQ==
X-Gm-Message-State: AOAM532N23CiCcMTDF2WP+V7hc3uYIwrYGOwABRqC8+5d2CUBYllem0i
        KA8AFvudfHvXnkqgPXp+1aGhszBo3TdgLQ==
X-Google-Smtp-Source: ABdhPJyqTJhOl3tzkF5q8ujg2j82pUcC7YV029PQ0wp9uQlAIZfwG8pfeHWKlanKyHz6+Cyzrx7joA==
X-Received: by 2002:a63:4c:0:b0:3fa:b4d8:26cf with SMTP id 73-20020a63004c000000b003fab4d826cfmr37551776pga.463.1654849272507;
        Fri, 10 Jun 2022 01:21:12 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a5e4300b001e2f892b352sm1080739pji.45.2022.06.10.01.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
Date:   Fri, 10 Jun 2022 13:50:47 +0530
Message-Id: <2e335a6c263704a8d465bd02896fc5fff0533fdc.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
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

Reuse _opp_compare_key() in _opp_add_static_v2() instead of just
comparing frequency while finding suspend frequency. Also add a comment
over _opp_compare_key() explaining its return values.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ++++++
 drivers/opp/of.c   | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fe447f41c99e..9f284dc0d9d7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1618,6 +1618,12 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	return true;
 }
 
+/*
+ * Returns
+ * 0: opp1 == opp2
+ * 1: opp1 > opp2
+ * -1: opp1 < opp2
+ */
 int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
 {
 	if (opp1->rate != opp2->rate)
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index bec9644a7260..843923ab9d66 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -929,8 +929,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (opp_table->suspend_opp) {
-			/* Pick the OPP with higher rate as suspend OPP */
-			if (new_opp->rate > opp_table->suspend_opp->rate) {
+			/* Pick the OPP with higher rate/bw/level as suspend OPP */
+			if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
 				opp_table->suspend_opp->suspend = false;
 				new_opp->suspend = true;
 				opp_table->suspend_opp = new_opp;
-- 
2.31.1.272.g89b43f80a514

