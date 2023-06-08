Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB2727900
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFHHnh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjFHHnf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 03:43:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A21FDC
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 00:43:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53063897412so145214a12.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210211; x=1688802211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4piU7CzrDaa5QhnkhaTZdsRHzU3ysUgPO829UQGygfo=;
        b=LT4ic7gaDbhkeHP3vX7WhgwtCEbsjg/KgOAzGBbIp/TbIP5tG5ifa6Y1LgVXNb26xh
         zcubk20bG4RqvyjxgRT5FJjmXrVt9djTA3DgNtEOVysrpqGb6PvZPUDSxzS70ooyv6Tt
         aM3SefFgUCN6llPb6KxShBIiymE7yFpQXXdhftkwzVHmuXP58lqcf3VAb2B8Qk32GuhC
         nXSMIG0DOxHfL+mYxmdc7zD5qkbhnkMcfgk694m+/LYZ+Hx9g8NeSUSrF+4JnnZ9SY0y
         ZIQ6lq7CqpZIrGvbcwcqgyv1eDTUfK/vMA05SXmiEUrc+vmCqMuFbX+Kgf7MaNJNp9Es
         KuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210211; x=1688802211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4piU7CzrDaa5QhnkhaTZdsRHzU3ysUgPO829UQGygfo=;
        b=Ma1mPGoUr0x5gjBr1GRc37CCmPqHq9+UU6dKj2BdPPICGFsMBRa8B3Z8Jj0tuqBqrQ
         2t976c3h80zvNHn3B+8iI3xCGYWO3/TH6P4s2oQqe+Bu+WbduGspYnMOziUZUrTCwcWk
         5YNxmMDVdROmv3MWbVVSYjct0fE+2ReBWIc4aQ2U6YgxRBU9Bz4jGX3CAJzrebNPOZyJ
         Chp0ormPhyh98bzGRt+kaURTaa2+lF105xDbUEm3z6kBZP0uMpc8lr2Qy37r5YBu/q3+
         2/kkfGrlr4NGxDSh0M/fHuP/F9tPo6/T5vyZOwCkU3bxcXXQBjEq5TPk85F+13WaawuD
         4qnQ==
X-Gm-Message-State: AC+VfDwu6rv2fa2TKSQlUd+zu15FvLcyVM75P/pPf/f2l07TffNrm5Bv
        e+lsU8QU+cxMP7Jo4g6VNk+qXg==
X-Google-Smtp-Source: ACHHUZ73PvKpO0zgkXxdWyxP24ZxHdPzn0+olB6J7us+JXjLJBN40EBPIoKjtYfkhpC7O9chE74vIw==
X-Received: by 2002:a17:90a:4d:b0:255:b07a:3d55 with SMTP id 13-20020a17090a004d00b00255b07a3d55mr7554658pjb.28.1686210211234;
        Thu, 08 Jun 2023 00:43:31 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b001b1920d000bsm745971plk.234.2023.06.08.00.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 00:43:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: Protect `lazy_opp_tables` list with `opp_table_lock`
Date:   Thu,  8 Jun 2023 13:13:23 +0530
Message-Id: <c0bac65236cf77fa8ac17c2645449544b73a0104.1686210112.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <167eb2bd947d9c04b0f6f1a5495ce4a99eeab598.1686210112.git.viresh.kumar@linaro.org>
References: <167eb2bd947d9c04b0f6f1a5495ce4a99eeab598.1686210112.git.viresh.kumar@linaro.org>
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

The `opp_table_lock` lock is already used to protect the list elsewhere,
use it while adding or removing entries from it.

Reported-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Stephan: Can you please give this a try ?

 drivers/opp/of.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c740a907ef76..ac2179d5da4c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -21,7 +21,7 @@
 
 #include "opp.h"
 
-/* OPP tables with uninitialized required OPPs */
+/* OPP tables with uninitialized required OPPs, protected by opp_table_lock */
 static LIST_HEAD(lazy_opp_tables);
 
 /*
@@ -148,7 +148,10 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 
 	opp_table->required_opp_count = 0;
 	opp_table->required_opp_tables = NULL;
+
+	mutex_lock(&opp_table_lock);
 	list_del(&opp_table->lazy);
+	mutex_unlock(&opp_table_lock);
 }
 
 /*
@@ -197,8 +200,15 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	}
 
 	/* Let's do the linking later on */
-	if (lazy)
+	if (lazy) {
+		/*
+		 * The OPP table is not held while allocating the table, take it
+		 * now to avoid corruption to the lazy_opp_tables list.
+		 */
+		mutex_lock(&opp_table_lock);
 		list_add(&opp_table->lazy, &lazy_opp_tables);
+		mutex_unlock(&opp_table_lock);
+	}
 	else
 		_update_set_required_opps(opp_table);
 
-- 
2.31.1.272.g89b43f80a514

