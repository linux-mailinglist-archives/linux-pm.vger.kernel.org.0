Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEED3FEBF0
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhIBKRl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbhIBKRk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 06:17:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0ECC061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 03:16:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l18so2516511lji.12
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZIDc5dNGmZMEuNI+q0RXZg7TDaDyQay2EJwpX2HagA=;
        b=tJEyqv27c0M36cBiuxle+CZcejlnP42BqHYMsy3HH6riiEJsG+YpXDhRCks2ozu/0a
         YuXG3Fxzldz55lhNT71K7+qRshz8IyqqVyz2HmYf9jTDKw0jCy3PgRM96IBxbT8uJCDb
         FQVEoXVjv2YkFdPzs8JyfoTvs9cqJ3lQ7T21yNoEulElXLMqg5O1cNT1JvuikDEN+XGW
         hmX8t8qOEAbSrLsXUqtGNgo0+zISQLbbiCO2S5f/X3qavwykZZwIrxOhKUcfqe0n/Ljl
         YUMPiD+oIuf656o4snFxWRQSvao9oyutvr3Jb/HwWKASY4i/vU8L9O3bhDBhVe6+oxeF
         IdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZIDc5dNGmZMEuNI+q0RXZg7TDaDyQay2EJwpX2HagA=;
        b=iQNF5WekH225134b1b6dNnHHVhd113e/eGJoubzgmt0TG1ZclC4aT0Heqim6A0k4b5
         dhmIYGJuyjw0xygp+G2aRuj6VSvboTZgGNbAIoW9VvJ6bgs15ykvVOAhPJpknM5ZUpsZ
         NX0UHML3XMgrsMEqMC8CxSCsmxfmfuZhYVwdkvsYYb4wQYeCZOJ9AHPrm/bRvGzMxfsk
         BGE2Adgm25eoISJhN70QRmXmoIrSYBruO1lUmi2p8kdoMCFzCW2SvCxIKktPkFzVgsXM
         iG9RgOMoF/ceQLo/vuk8KIrg/RcCtlsyqTHxhxfrA/eg7cr/FzdytCEoBoHrUczlkBHd
         OKkQ==
X-Gm-Message-State: AOAM5304BZyY2L/MT5Pqg+RQPs/5C+9jSgnKDLmo4u/6pPZJlep6R5HZ
        4V5oO40/nKhTw6O7PqbvGqjbwQ==
X-Google-Smtp-Source: ABdhPJzNXuvX9XDTeaJ02yQt2BdTC2X0ZlUZgbJYnh+m6n9auTpgMAN6FyCEd7d8q4RZ8DQBiAQ5Aw==
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr1803113ljm.95.1630577800779;
        Thu, 02 Sep 2021 03:16:40 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id s4sm155897lfd.53.2021.09.02.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:16:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] PM: domains: Restructure some code in __genpd_dev_pm_attach()
Date:   Thu,  2 Sep 2021 12:16:33 +0200
Message-Id: <20210902101634.827187-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902101634.827187-1-ulf.hansson@linaro.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To slightly improve readability of the code, but also to prepare for a
subsequent change on top, let's move the code that calls
of_get_required_opp_performance_state() into a new separate function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 278e040f607f..800adf831cae 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2640,6 +2640,17 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int genpd_get_default_performance_state(struct device *dev,
+					       unsigned int index)
+{
+	int pstate = of_get_required_opp_performance_state(dev->of_node, index);
+
+	if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
+		return 0;
+
+	return pstate;
+}
+
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
@@ -2690,8 +2701,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	}
 
 	/* Set the default performance state */
-	pstate = of_get_required_opp_performance_state(dev->of_node, index);
-	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
+	pstate = genpd_get_default_performance_state(dev, index);
+	if (pstate < 0) {
 		ret = pstate;
 		goto err;
 	} else if (pstate > 0) {
-- 
2.25.1

