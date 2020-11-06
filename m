Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78CD2A8FE7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKFHF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFHFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:05:25 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F5C0613D2
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 23:05:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p4so251942plr.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 23:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsT44B8TOti3vqDBsPwYpvUpQYIln1nI64StpRu+PIY=;
        b=HCi2LBTkx3q9cFQ31LcoZa9qzduR7Ac4seDkJ2c5MmJURGaxGFDI0oPLEZ/s8JDq5G
         /YF0e7tcr7QMwRDVOOBYsK1EzYoPLJflHiJSV8s8s1WWBz5l8NL5CfLQ8YofnxC8LANE
         FGjPHxse7Vtg/yymkrq0UEzqqbIBrAVjIeIhOUjIdysrypGwrNSkUemIpO7NuxJi1RKh
         nlyiuoY5AVcJPT78mO9gV1jtljiE4i7fNZT6lpSu5ucdgKdnWUjAWJNX+wne1CidvnPT
         50zsQuRiiCQ4KNmqe4HUgraFHUmgNxif9ZRzdF4VFubxr2a2s4p3KinEnytaWsoaEoqH
         DdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsT44B8TOti3vqDBsPwYpvUpQYIln1nI64StpRu+PIY=;
        b=ob+0bI1OSh5gquKlycJgcUIzDS5xQguATh/SaVrBSTHsXE808bYQk+56KSsV+z8vEW
         80NAUMolUh+Smd8vvoelV2JWr+pVO5TUQa+2sfpk3cXwlgoCHtg78zYXHH7KFlEnRjC3
         wvLVssCFFHD42feICQrxStb2rVWPxjzcppGI0SF3i6ZfPk/+t/R+gO/RIbM+ZG3W3Ytb
         qS2JY/aPzN6WK/+KM2Fl0T67q4IgHHkxXx+PS0QmQe3FO0UD8zv2rkwFreuTK9QvgdaL
         r4K9X8hmV+6Emg++81RpezTc69mK9G+QFrZDtd+aOyaj72IWPwsycbaVk7KLd5ga/0gd
         h4kg==
X-Gm-Message-State: AOAM532vmKqXuA2V1B/6YyUJuoBYY8i3vt07Ip6x/vhZaaI6jSN+IJCZ
        uVJnvecZ177wY7H+Y3aiEqlZzA==
X-Google-Smtp-Source: ABdhPJzTw4Z9ly/m7vj29VejC+Lv8wxuy+qjENFj9LgRVcYmKAG9oZQjcLDLep5pV84Ym59o1+4Q1g==
X-Received: by 2002:a17:902:bcc6:b029:d4:db82:4439 with SMTP id o6-20020a170902bcc6b02900d4db824439mr565906pls.63.1604646324964;
        Thu, 05 Nov 2020 23:05:24 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 192sm803859pfz.200.2020.11.05.23.05.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:05:24 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] cpufreq: dt: dev_pm_opp_put_regulators() accepts NULL argument
Date:   Fri,  6 Nov 2020 12:33:22 +0530
Message-Id: <1277c2aa85ccc4fca1792b8311ea6af0c99ffc82.1604646059.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1604646059.git.viresh.kumar@linaro.org>
References: <cover.1604646059.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
there is no need for us to carry the extra checks. Drop them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 66b3db5efb53..5c049428a6f5 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -291,8 +291,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 out:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-	if (priv->opp_table)
-		dev_pm_opp_put_regulators(priv->opp_table);
+	dev_pm_opp_put_regulators(priv->opp_table);
 	free_cpumask_var(priv->cpus);
 	return ret;
 }
@@ -305,8 +304,7 @@ static void dt_cpufreq_release(void)
 		dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
 		if (priv->have_static_opps)
 			dev_pm_opp_of_cpumask_remove_table(priv->cpus);
-		if (priv->opp_table)
-			dev_pm_opp_put_regulators(priv->opp_table);
+		dev_pm_opp_put_regulators(priv->opp_table);
 		free_cpumask_var(priv->cpus);
 		list_del(&priv->node);
 	}
-- 
2.25.0.rc1.19.g042ed3e048af

