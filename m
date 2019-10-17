Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EFDDAC30
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502348AbfJQM15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:27:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502333AbfJQM14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 08:27:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id c3so1075166plo.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F14E7+MnIlpQiExL8cWFs9niwCwKQjYO3IRinn+L/UE=;
        b=SW53kbOHuCdPg1DuOx63gq8I1iayGlxonA/1rDDbCiItozWianEK9QISjChUx+Xq7Q
         GNYKWlPIzJcJ+AqJ0dGEwruPuFWCXQlSD5LKyvrMFAT4QUreATzVtl5KT0Tn5lfXwqOO
         vLizgueqTBOf3dfRa28LH03rBDpHE/MWvmeVTSivYW67EMCfmo82FA+xFzijO9BhEUEM
         CP51IPGhliOBPBQJI6CNSUMoG4bS6jYpo53QOvQQRtg7NsJs4xsLhkFX5fH/04mJU9tm
         IEOveG5+RCVMGYpnOIfyvnAmD1ktwtEW8TOdKho+eZLTGahRrwtZBjTlKUimtOEEv31t
         c9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F14E7+MnIlpQiExL8cWFs9niwCwKQjYO3IRinn+L/UE=;
        b=Oo87ugQ9yBCyIKGjCVVs8ffyiB6tDXjL6Qvux4KOTPKI8PzdHdo+HnF3hKlEGbmGzi
         xhnqGqNq0DSucFF6u8Cj6uQ//5yYeQN5LZWGkQiSqOvKzX0Sk7fWroQPiQR4Nn1WHPod
         txo2wEmvB7f+3KLJt4JFfzLQREZqzcOnxSuPQk69/mOXwqTzA/ipNfTbDF6xWLIosyhQ
         lc2uu7oNBBtZOfVfc8WnRkhBDe4M9Zw37NRCk0708sOJLibrOG+Rznf20PUWvsjsAEbe
         5t/Hrhv1npSQKHKoi4Gdvv/qQPmYRFwg4BxjqMYmYEjYoBXTH4g6/2+0zJBCSi6pkpa+
         KjsQ==
X-Gm-Message-State: APjAAAUB3yxWy9sSwI65Xd+oK5/uTxaRZsKaLncu99z+3OQgoiaJb5tc
        2Hae6CkksAA6yLSvHsSO700Qdw==
X-Google-Smtp-Source: APXvYqxPkJnxEr/SitV6b1LTVPecxRv9RdR/8xgTjWWMcFC4xoO2obdw5qvD+7daSHAfkLTb8+Wwqw==
X-Received: by 2002:a17:902:9a93:: with SMTP id w19mr3590819plp.316.1571315275379;
        Thu, 17 Oct 2019 05:27:55 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id x72sm3907375pfc.89.2019.10.17.05.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:27:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 3/6] cpufreq: Initialise the governors in core_initcall
Date:   Thu, 17 Oct 2019 17:57:35 +0530
Message-Id: <f1d7214951e4b2caa394c722b4d8aaca9cc2c4c4.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initialise the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
 drivers/cpufreq/cpufreq_performance.c  | 2 +-
 drivers/cpufreq/cpufreq_powersave.c    | 2 +-
 drivers/cpufreq/cpufreq_userspace.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index b66e81c06a57..737ff3b9c2c0 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_CONSERVATIVE;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index dced033875bf..82a4d37ddecb 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return CPU_FREQ_GOV_ONDEMAND;
 }
 
-fs_initcall(cpufreq_gov_dbs_init);
+core_initcall(cpufreq_gov_dbs_init);
 #else
 module_init(cpufreq_gov_dbs_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index aaa04dfcacd9..def9afe0f5b8 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
 MODULE_LICENSE("GPL");
 
-fs_initcall(cpufreq_gov_performance_init);
+core_initcall(cpufreq_gov_performance_init);
 module_exit(cpufreq_gov_performance_exit);
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index c143dc237d87..1ae66019eb83 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_powersave;
 }
 
-fs_initcall(cpufreq_gov_powersave_init);
+core_initcall(cpufreq_gov_powersave_init);
 #else
 module_init(cpufreq_gov_powersave_init);
 #endif
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index cbd81c58cb8f..b43e7cd502c5 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 	return &cpufreq_gov_userspace;
 }
 
-fs_initcall(cpufreq_gov_userspace_init);
+core_initcall(cpufreq_gov_userspace_init);
 #else
 module_init(cpufreq_gov_userspace_init);
 #endif
-- 
2.17.1

