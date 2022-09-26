Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2E5EA5D8
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiIZMWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiIZMWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 08:22:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C35D0F5
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 04:04:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u18so10211635lfo.8
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SzZdZTQ9yg2AYbF63Q9RIKM+cK8iwb2vn6Xllzfi3yo=;
        b=BZ4NJ8aK1BgwIAhIVdY8A/zCCyu7QbeE9dWRBMGaIkGg+ELHSmCe4byrX8+PBAYnm7
         K5uFMloJ+xJstiZ+k1GYZBhUQPj4v60kjYBBowRJn3q2lmPKcCi8LUdjWrkL83G5MWxu
         AytppXnTlAO+KUO5lfrr6Ap3OLyxWhN0Q+atmwRJodwXTx5akWYQbqBnS6sH3bQmKBrD
         Z+AkpzyAwkIdytl7Xf4JlSJzwrwJMSZoPPprlUyzF3jOqDSUpY4URezpp728CRRV0aF2
         mfwetJKV23rNE2XQCRNRUYz1WXWAdt7IkLTWhVcxKkgvfv/C/tObii+iT3KWfBQnmo2A
         uY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SzZdZTQ9yg2AYbF63Q9RIKM+cK8iwb2vn6Xllzfi3yo=;
        b=mvwUoPAIyXHnua/SJWJCftgNC3AqLDt4qLAhpd2h3yVCIniph35KWNSssCD7p2pYsS
         miIB6yixTnU10+7Yo7t+sTRGHglkdYJvkTWB3rqoDLhiZCkYa7PgOeNz/jgYsTIsqpKz
         Q7lmJiuQiEUUtYU3rBgpOIXrfz1O6IlDjrbUWn8JDnlwJf6c0AFhJVD2gdlgQOB03pLZ
         XW6NzBVmkkyJg8dm3pXlFlaU+gDN3SJfuV4vd8HyZfUKkEZrab7vW9FXIOBPh62YXLbT
         J3sZUoWedEQHRzVF7EqPTN6pH118XPqVUl/RPGjjDp2PaB4R8AAEnyxa5CJbHxOc+0Lp
         8qKw==
X-Gm-Message-State: ACrzQf2ol0PGwCPP4UTxJlO+jMAFoJfvQmXEbcIbLDIN0x26KqM79BCT
        xEKan5muXC8y6d1xHF8JHopHOQ==
X-Google-Smtp-Source: AMsMyM5W3WeYQ1XboE++c1vd8Cjn+/5cGjGtRWycEk85pI6L0lEjCrPisCtUyVfjBs9CX+6uOkYJqg==
X-Received: by 2002:ac2:4e16:0:b0:49a:d15c:c3e1 with SMTP id e22-20020ac24e16000000b0049ad15cc3e1mr9154341lfr.648.1664190171290;
        Mon, 26 Sep 2022 04:02:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 1-20020ac25f01000000b0049f5358062dsm2497955lfq.98.2022.09.26.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:02:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [RESEND PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept PC mode
Date:   Mon, 26 Sep 2022 14:02:49 +0300
Message-Id: <20220926110249.666813-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function psci_pd_try_set_osi_mode() will print an error if enabling
OSI mode fails. To ease debugging PSCI issues print corresponding
message if switching to PC mode fails too.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
This is a replacement for [1], now moving the warning from
psci_set_osi_mode() callers to the function iself.

The patch is resent to include soc@kernel.org

[1] https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/

---
 drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
 drivers/firmware/psci/psci.c          | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 3db4fca1172b..821984947ed9 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
 		return false;
 
 	ret = psci_set_osi_mode(true);
-	if (ret) {
-		pr_warn("failed to enable OSI mode: %d\n", ret);
+	if (ret)
 		return false;
-	}
 
 	return true;
 }
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 9fdcb6bff403..42cae0ba10e2 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -164,6 +164,8 @@ int psci_set_osi_mode(bool enable)
 			PSCI_1_0_SUSPEND_MODE_PC;
 
 	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
+	if (err < 0)
+		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
 	return psci_to_linux_errno(err);
 }
 
-- 
2.35.1

