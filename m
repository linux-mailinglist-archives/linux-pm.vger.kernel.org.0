Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB575C337
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGUJl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGUJlX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 05:41:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA730D4
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66c729f5618so1563109b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932480; x=1690537280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYBTSL0OfRqOhOs6Z05SkTlqzON3K7UIBYPi9xq4xxc=;
        b=h/+u+zIoZ/y1VnucGLle63jX7c+pQ7Xm0NSJwjLnLSldtrque1+JD9Y6a5Wt6PV+s8
         nSh+rpgcEuhavmiPomFhpb0tgkZ9ria5aWjkvT4t/eGKlkkib3Se8yudwK9gO7HWsWso
         riB1rg8fd7Cn3A4auXB5333l3S1A/Wm/ucpZx74pgINzcnP4STs9BAOF0/Wx9lk5e+d/
         +mOZ6lXDiummONPaFzjVBcA7Ne48ukqaWjjF9HPevN7LRV5KGvNLT9FWwCs5HFGjSxKr
         EPYzojBgnvifHYFzhsMhUsMRDXh5/j/snvR7jwU9b/RRxI6r0U2/XSIGuPL2z9v0xMEB
         OszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932480; x=1690537280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYBTSL0OfRqOhOs6Z05SkTlqzON3K7UIBYPi9xq4xxc=;
        b=SlUoFkIHLTMMeTYaY5eHvXXMd5LGt9o5fdutrQDIRCeHyrjO4o4LbpnCnfZ/mjez+a
         vx4u7vTv6c5rX2MlIK/DjqAeIa2TrGtG1IDPWegR6B0Ww24aB2o10rQY8xr4TRVrX6Ro
         WSi6xCPf1UcY0EHBZ8UlNLnHxWYTccBdL4z3rpKZX46wuap6s/fyfXm6YD3fTaOBioXh
         7BqoHjBLTDkZyVWlHC5d4Kuab33/slq4GQqGrq+weTsMPqGvN06YQrhgyQ+ppxcGczwi
         yWxRMtBtQajRMsX6m9u3RtW9GzA5JmUhm6ngu/xIEEcKpmmHo9Q2FJNP5YHdFEBiwGge
         LIMw==
X-Gm-Message-State: ABy/qLa0tWt0ziOzIhsASSI2TSlIgX4hPwxorQxhFXqIK8zi4OzovuKH
        OqvxKU9zYstHh5kLSeHe6Bu4Cw==
X-Google-Smtp-Source: APBJJlHXUu/oayiAgSCxfpwW4T9SemBsvXOG6+3NOAj1UN9MdpiDtsif4PSKpRSdjDaxkHrn6GIH5g==
X-Received: by 2002:a05:6a00:2351:b0:686:24e1:d12e with SMTP id j17-20020a056a00235100b0068624e1d12emr1697924pfj.30.1689932479645;
        Fri, 21 Jul 2023 02:41:19 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j26-20020a62e91a000000b00682ad247e5fsm2633899pfh.179.2023.07.21.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] OPP: Introduce dev_pm_opp_get_freq_indexed() API
Date:   Fri, 21 Jul 2023 15:10:56 +0530
Message-Id: <93dc0fb7d0c51908ce1a1c35bec846afa7596e65.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

In the case of devices with multiple clocks, drivers need to specify the
frequency index for the OPP framework to get the specific frequency within
the required OPP. So let's introduce the dev_pm_opp_get_freq_indexed() API
accepting the frequency index as an argument.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4f47b341f9..00638d40353f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -197,6 +197,28 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
+ *				   available opp with specified index
+ * @opp: opp for which frequency has to be returned for
+ * @index: index of the frequency within the required opp
+ *
+ * Return: frequency in hertz corresponding to the opp with specified index,
+ * else return 0
+ */
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
+{
+	struct opp_table *opp_table = opp->opp_table;
+
+	if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->rates[index];
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
+
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
  * @opp:	opp for which level value has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2617f2c51f29..a13a1705df57 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -105,6 +105,8 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
+
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
@@ -213,6 +215,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
+{
+	return 0;
+}
+
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.31.1.272.g89b43f80a514

