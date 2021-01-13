Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704252F44B3
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 07:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbhAMGyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 01:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbhAMGyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 01:54:02 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59841C061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 22:53:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q20so642993pfu.8
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7tnhSr/TgWVw/GPv3kc5UsoWGWtqZNElqDlp8y6EGT0=;
        b=uNXha/oB+9R/2OP/sVAbuMv72bhyOwU5pGmElrqqNkn/gYhwdTC4Pji0m0RQDSac64
         9a25gAf0ESz7IdZdlxmVwMS5cnLppbhoC5aZa+t2GdaquRCJ9DXxkAKtTD0jOVJTIt7b
         4+9gSkY1CPwJesKEMelvKiHU6vZTc4nt9xgFQVCe8aI9gOEb0SSOnEzSSvFxe34XoMVs
         /A+Dzck3SNZNIi7SyzxxNba9IVVDMnnSweNHGdmqmxpEd1PLxf5ZiaRUK8MgxpRu1Sw7
         uZ9Dg4fcTNpU5NMLsZmYjJ+koOfn6dckSDccSFBTBSt+NY94Z1zskYfrxL8kH9hnBmUK
         magg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7tnhSr/TgWVw/GPv3kc5UsoWGWtqZNElqDlp8y6EGT0=;
        b=lBcfa+AU1B8ZZU6zmfSHullw0d8+p00cAvbEMHxS64xEG2I4+LA8C0wbdJflDMR9gE
         A0IkrRAokaF5/pUdPvsK86V81dJXY6wlMmQ9PnLxgZVVbd4LUE/sPAIzOvP2j8rS3m2l
         +Ysl1NOkZMKhno4PFxQc7356ToMYdhegC1YkCswoOtJ3bnTyL0Kqk2Ws0KYHzsOBBTsa
         3hVqKqq+YJ+M18GwF+vriBG6gUsj4MNQ4uMIyK0YX47GDCAaz66hHuCFv6R/Z57brjHK
         nEQoiZqnnh3RzOT7jiAGDgVuvYhNUX9eK2Jc0KgyQNRGPpl1WQvKyaSNGX5SzXI/4dM5
         C2Qg==
X-Gm-Message-State: AOAM532rc0AQ1MyGJrmhcYkWm91SMWx9TQd5/YazLXJXZQ/E5vwaJPwq
        vTFbYMaasKGBInb/WgOHoEsJTQ==
X-Google-Smtp-Source: ABdhPJzytLgbSbUEwpCYlqfbnPKHFilahzfk6Ge9TtH1yvtXBfdXiZ7sMFpMP/cyyVBwlukxYgud5A==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id g134-20020a62528c0000b029019e4a39d9eamr807735pfb.20.1610520801918;
        Tue, 12 Jan 2021 22:53:21 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b6sm1217532pfd.43.2021.01.12.22.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:53:21 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpufreq: qcom-hw: enable boost support
Date:   Wed, 13 Jan 2021 14:52:41 +0800
Message-Id: <20210113065241.23829-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At least on sdm850, the 2956800 khz is detected as a boost frequency in
function qcom_cpufreq_hw_read_lut().  Let's enable boost support by
calling cpufreq_enable_boost_support(), so that we can get the boost
frequency by switching it on via 'boost' sysfs entry like below.

 $ echo 1 > /sys/devices/system/cpu/cpufreq/boost

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 315ee987d2d3..6eb88463a24e 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -351,6 +351,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
+	if (policy_has_boost_freq(policy)) {
+		ret = cpufreq_enable_boost_support();
+		if (ret)
+			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
+	}
+
 	return 0;
 error:
 	devm_iounmap(dev, base);
-- 
2.17.1

