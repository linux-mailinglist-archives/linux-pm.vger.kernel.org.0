Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761BE6C13B9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 14:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCTNml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjCTNma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 09:42:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B4F941
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 06:42:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so46846460edb.11
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679319747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQtrWDCM+22cQpzRRbVDJZjtR/eFtKTL53q6CUnjVrA=;
        b=m6WWdvyhtAOPk/0OuJjnEg21hoMIbAVidJpiNn+dmHa6hrOTmwvVTWgmYoobYKk7bk
         YuXgKLPbT+avt/j0eZvscu00k3J1cPtSfbLKJ7kbnyCcGSGgVOh+yECsfSnJKybt4up8
         kV/48kbVKfW8V7xGb9E0sW5ce44PrIUJVXiejhK4aTy/HZ/Bv8Vc+76SgxAEuYTqV5bq
         a8hciAQRZBC58PAUCewbgn8YnhSZwW1ZSq6P5VeUjicnDDbRkUs4NMKhXIxfqJUtXPL7
         oSiNulSiYQll2eiuOheOcK904JTbsGuREE5VJTu16BWfiggbU5HS5zw9cQFyz41bo+me
         pPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQtrWDCM+22cQpzRRbVDJZjtR/eFtKTL53q6CUnjVrA=;
        b=o/TEeEwscgLeHmN1OfYNaUW9xj83nt9VYSSOSSjP701ycezRerSERBaE9R507wGMWa
         GWiBju5JdZ8SAIkjaMxx2YJtV498weti+jl2KW040psH8jc5BnCGm8juQYtK5HDIdcOs
         XDSiAXw2I8sI9/moCR4cv+G74WxwSpKrB024eEOWIztws4uXNTAdUeCRaiP8PEcB5SMJ
         mJmbURcM95uvZak3aHj53ly0912Uw3STT1lc+t0McOFOrJngtaLWFc+JEF8Odi+PURn6
         rWlICb97dEPXfhsuvVoXjQ1B6O0xCkpQ9+tDOX4FhuCka4g6UydAKrW+bjkZ/BcrQVFT
         r7hg==
X-Gm-Message-State: AO0yUKX3evNPCdxCDWM5eCy3ZwQyoHKU1tkQdapvBC2R5UE5u9IBFLGq
        arj6TUC1OIg1OJSQjQseRYEuOI+5hcE/YB7xIV0=
X-Google-Smtp-Source: AK7set8STWg1Rns3/0smj0Q44nbZB3/IvQ/ygDqex3RKHPaT6fygb8UA/9acK6hL7QexFWuXYa/MTQ==
X-Received: by 2002:aa7:db83:0:b0:4fd:7f6f:3179 with SMTP id u3-20020aa7db83000000b004fd7f6f3179mr11830162edt.3.1679319747250;
        Mon, 20 Mar 2023 06:42:27 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm2368602ejj.141.2023.03.20.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:42:26 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH v2 2/5] soc: qcom: rpmhpd: Do proper power off when state synced
Date:   Mon, 20 Mar 2023 15:42:14 +0200
Message-Id: <20230320134217.1685781-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320134217.1685781-1-abel.vesa@linaro.org>
References: <20230320134217.1685781-1-abel.vesa@linaro.org>
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

Instead of aggregating different corner values on sync state callback,
call the genpd API for queuing up the power off. This will also mark the
domain as powered off in the debugfs genpd summary. Also, until sync
state has been reached, return busy on power off request, in order to
allow genpd core to know that the actual domain hasn't been powered of
from the "disable unused" late initcall.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f20e2a49a669..abd999c74783 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -649,8 +649,12 @@ static int rpmhpd_power_off(struct generic_pm_domain *domain)
 	mutex_lock(&rpmhpd_lock);
 
 	ret = rpmhpd_aggregate_corner(pd, 0);
-	if (!ret)
-		pd->enabled = false;
+	if (!ret) {
+		if (!pd->state_synced)
+			ret = -EBUSY;
+		else
+			pd->enabled = false;
+	}
 
 	mutex_unlock(&rpmhpd_lock);
 
@@ -810,10 +814,8 @@ static void rpmhpd_sync_state(struct device *dev)
 {
 	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
 	struct rpmhpd **rpmhpds = desc->rpmhpds;
-	unsigned int corner;
 	struct rpmhpd *pd;
 	unsigned int i;
-	int ret;
 
 	mutex_lock(&rpmhpd_lock);
 	for (i = 0; i < desc->num_pds; i++) {
@@ -822,14 +824,7 @@ static void rpmhpd_sync_state(struct device *dev)
 			continue;
 
 		pd->state_synced = true;
-		if (pd->enabled)
-			corner = max(pd->corner, pd->enable_corner);
-		else
-			corner = 0;
-
-		ret = rpmhpd_aggregate_corner(pd, corner);
-		if (ret)
-			dev_err(dev, "failed to sync %s\n", pd->res_name);
+		genpd_queue_power_off_work(&pd->pd);
 	}
 	mutex_unlock(&rpmhpd_lock);
 }
-- 
2.34.1

