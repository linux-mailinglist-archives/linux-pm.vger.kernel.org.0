Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998D62F9715
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbhARBDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbhARA5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E32C061794;
        Sun, 17 Jan 2021 16:55:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v67so21647376lfa.0;
        Sun, 17 Jan 2021 16:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyHjrNQl/VVrQYVoDFRcSB8NEQfl0N78N+dBhjN9Zys=;
        b=psNQNKmUoSfKuU+xSOgLca9Qq1fOHDpSogTRlMAdEzHSCYtMqCY7Ix6sBrZp25T3nX
         Dv6Ij+JIUWFT3VT8YH0wwz6Kzf5D3336nOxrSt6jLTFH9Oc5XCKfB+lpjAIk+GI35272
         GuB51X14qvv1Zzjd0ZvmGKlyKYEucxnfEvuHD8oQ3Hsr3CMJYGqY9+tfe99QikHpO2Nk
         rdb5ZIVU1X0FyIf/2Bs0YNSfAzz2PyBlxy9n5ncmbk8BtENuhRVks1fyxw93xCIA06zO
         NQmQhnHHbH7k8UwCCwqnQqiZOm2pijSAsehsRTQ6xXBZy8t4rNU7eajHsFY8HTWCokcu
         0bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyHjrNQl/VVrQYVoDFRcSB8NEQfl0N78N+dBhjN9Zys=;
        b=bVVD7i42hMHyienreAsGpkaxDIJsnwAe1M6WyMcGHTpLS5SowhlCsJnIScJthGc3X2
         H2muwkbfg4taraQiq8hxMO2rzyBp9eX9iBgbm2jjo7uK6YCHERQiNA81bbz8GwDJxaEC
         tYZFmZvFpY4/wz10Ixlcip93CP5g9wdrGCW7MP4WUwRxjd65XAY060Zv7Zv9vyrU/KvW
         lotNDDSZlDgr6mrFzvkW4JUZ2kOQOkUXMFGJ7kZYC+JNLDRm8/GHJ3uNwU1U5ExrWu93
         C1yZIq97qBdvU4U3y25GUOZ57aCHl3ra+IWpYjQ4SyVVKPRBcB2yPTBnXOePQTnYcPqt
         r+Iw==
X-Gm-Message-State: AOAM533LGoVmiJsUA8i1bAohofTscw5ysug6IK3GhNexe76I8nLpzEvK
        xn9XhS3nbYbb3+G64ieJYRU=
X-Google-Smtp-Source: ABdhPJxpt1/bY2Bpgu/+DdlT0QMvUKw1/40EKNh5JrhRE+VL03Op2xfEkTbvFrbVfBuPFYtUSjFmkw==
X-Received: by 2002:ac2:5e2a:: with SMTP id o10mr10371041lfg.481.1610931345348;
        Sun, 17 Jan 2021 16:55:45 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 11/12] opp: Handle missing OPP table in dev_pm_opp_xlate_performance_state()
Date:   Mon, 18 Jan 2021 03:55:23 +0300
Message-Id: <20210118005524.27787-12-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

NVIDIA Tegra SoCs have a power domains topology such that child domains
only clamp a power rail, while parent domain controls shared performance
state of the multiple child domains. In this case child's domain doesn't
need to have OPP table. Hence we want to allow children power domains to
pass performance state to the parent domain if child's domain doesn't have
OPP table.

The dev_pm_opp_xlate_performance_state() gets src_table=NULL if a child
power domain doesn't have OPP table and in this case we should pass the
performance state to the parent domain.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7726c4c40b53..ca8c6acc29f4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2419,7 +2419,7 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	 * and so none of them have the "required-opps" property set. Return the
 	 * pstate of the src_table as it is in such cases.
 	 */
-	if (!src_table->required_opp_count)
+	if (!src_table || !src_table->required_opp_count)
 		return pstate;
 
 	for (i = 0; i < src_table->required_opp_count; i++) {
-- 
2.29.2

