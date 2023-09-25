Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4E7AD8CC
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjIYNSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIYNSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 09:18:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599EA2
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:17:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50305abe5f0so9987683e87.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647877; x=1696252677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=167tdHqooI6VpzhOKyy9DJn5EBlj5nE8zbkLsDZ7woM=;
        b=WBP4+Kknvb5kO7n8iUdyddmGhNYDy76agy14hEc9Lzsiq56UTzfZxCY+r8ln6rlItd
         scyX0Zdfo0L4pkQ4HFFpFBHhmu+jio7i3aHE7kdfcWu5WaubjK2T/KTDZzN2rjROsCr7
         xyyt2iuivX2VXXvE6MuqGm9TSHvoq+4pSUAzbHXtrw/ivXtVMVaX7AQY4ErlsBjSiigc
         iP0UdG0nQxN49PjugAJe5kl2AdxA5pR/VDanP6bLT6Y6Rt527DDW49AAfPNZYbXFlDsM
         169VaJzgHwt/qqncQgmcxn5L9En0/SBleLQovZZ/66eTsm9yqKNyrz/PqTrSZV/iYEEQ
         W0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647877; x=1696252677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=167tdHqooI6VpzhOKyy9DJn5EBlj5nE8zbkLsDZ7woM=;
        b=aKuT46PqVcAX5eIequoXGZvLq5fW0Q5KXZx71f24pOdWBllGNQuGylidRs2MGJ7HOn
         4ObgaQ4kqg9RHxLRyne2mBW4i8GioF1lim3KugZyQHYBr1BVqJJduP3JPDub0rPq0sBf
         Z9Yd17HV6IosBXp5vh3tsqT9fzThLQGNtBr3HTV6r7XIjr9sT88QVdAGIHY+3zyzhRhI
         chko0ywZ0sNDJzi8Vq/NeHGxv2JJ0j+GqrdazchCHR3wtQ4UVGel3RqLLb7PtC5RO38g
         q1DJ6jqJSu4vRvc2veokEt3fuRB1bnQNQGM+tryACxrR2FvxfdoCyNpeebMhik9IzTer
         3+Mw==
X-Gm-Message-State: AOJu0YxrWETmlBZTQL3XjRMQ7elPake7CR6ELE0yUGJizUUKgwMhcesS
        0crHuhTWbhAVVsKnWrn5JT1rRxWQRntQcXtMYn8=
X-Google-Smtp-Source: AGHT+IGW4oEnJvWuWsg6MhO9Pq9fqGlgU2jo7ZRrJDKiypMdNYI0ToxsC3DaNm/vfTBYyFn4mfZ5Bw==
X-Received: by 2002:a05:6512:328b:b0:4fb:8bab:48b6 with SMTP id p11-20020a056512328b00b004fb8bab48b6mr4881662lfe.52.1695647876928;
        Mon, 25 Sep 2023 06:17:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:17:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] PM: domains: Implement the ->set_performance_state() callback for genpd
Date:   Mon, 25 Sep 2023 15:17:08 +0200
Message-Id: <20230925131715.138411-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
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

To enable generic support for performance scaling for PM domains, let's
implement the ->set_performance_state() callback for genpd.

Beyond this change, users of the corresponding genpd specific API,
dev_pm_genpd_set_performance_state() are encouraged to switch to the common
dev_pm_domain_set_performance_state() API.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c74edf80417f..da1777e39eaa 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -420,6 +420,25 @@ static void genpd_restore_performance_state(struct device *dev,
 		genpd_set_performance_state(dev, state);
 }
 
+static int genpd_dev_pm_set_performance_state(struct device *dev,
+					      unsigned int state)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	int ret = 0;
+
+	genpd_lock(genpd);
+	if (pm_runtime_suspended(dev)) {
+		dev_gpd_data(dev)->rpm_pstate = state;
+	} else {
+		ret = genpd_set_performance_state(dev, state);
+		if (!ret)
+			dev_gpd_data(dev)->rpm_pstate = 0;
+	}
+	genpd_unlock(genpd);
+
+	return ret;
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -438,7 +457,6 @@ static void genpd_restore_performance_state(struct device *dev,
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd;
-	int ret = 0;
 
 	genpd = dev_to_genpd_safe(dev);
 	if (!genpd)
@@ -448,17 +466,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 		     !dev->power.subsys_data->domain_data))
 		return -EINVAL;
 
-	genpd_lock(genpd);
-	if (pm_runtime_suspended(dev)) {
-		dev_gpd_data(dev)->rpm_pstate = state;
-	} else {
-		ret = genpd_set_performance_state(dev, state);
-		if (!ret)
-			dev_gpd_data(dev)->rpm_pstate = 0;
-	}
-	genpd_unlock(genpd);
-
-	return ret;
+	return genpd_dev_pm_set_performance_state(dev, state);
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
@@ -2080,6 +2088,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.restore_noirq = genpd_restore_noirq;
 	genpd->domain.ops.complete = genpd_complete;
 	genpd->domain.start = genpd_dev_pm_start;
+	genpd->domain.set_performance_state = genpd_dev_pm_set_performance_state;
 
 	if (genpd->flags & GENPD_FLAG_PM_CLK) {
 		genpd->dev_ops.stop = pm_clk_suspend;
-- 
2.34.1

