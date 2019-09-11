Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B645BB059C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfIKWcs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 18:32:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36945 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfIKWcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 18:32:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so10836964plr.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OSYcY8IBbPXHFII/5CsrnXT8+IaVG+jk8Oh4t4Zn6xA=;
        b=o/hNxA2gr0vDUeX9kntmZsI+c644sUOFOjeuCT21i22ln2dgMqCeD+ac/azR80Ssz1
         FeA575pCuqYEFUSjPfrcnwZ2dY+6oq8PyzemYUloMch5Qsw7ZJKxtaEPMaRLZi1yacCh
         dwCK84LSrzklc9yE0pL3xJawW8MODGsnOCLi07pY4uM53SKgRSvuXqnMtwfhgJZk4Jxj
         P0aNX8We7coIMq3hfcxnM7tef1PTGpkgpeOUycGITRBuG/Zq3MsfCHWrriPK+TuIY4u0
         F+L/B7RfsqFnS7zRnnPWV40L4TgtLk7vMsnVXcnsg7uzoXeMmD41j3ZfC3BYib3uB7Mn
         acNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OSYcY8IBbPXHFII/5CsrnXT8+IaVG+jk8Oh4t4Zn6xA=;
        b=UItAMDYO7V0H11XAZ/kkuV+fkbdX+YGOB7BRALxSwH2UittnzGKq9f2t/caXjXcewB
         Me7lEuW5SInvitByGYZ00QRc/phaEmJ7EluJSDF7BwspEvEQYcAxgTerQ9IowttEWmHU
         QNe0xeN6rCrSFqJARMeJUHwtu9+Zdn+Q+/VBJzxsntmZfqBWZiHKtGgWFoUKNkRvVDxM
         K2d9BB1wEyk/JUGySAJKKbTmRO6og67XeKY8ycdN0XiFxAGajC9Cct2fYExcctDUWuiL
         yb18WyMNBp9S5+63wOrPcZQzHrRXMMpMmGpHmNWw81Aga5tQSIDfuh/HQhohXLTT3P93
         prgg==
X-Gm-Message-State: APjAAAV6YQikiX8AWI8GxNsM8MJfwyMe55Zw2UrIE8cWB8mZBw8crSae
        o5+L2lHBr9D0aoWI2FdKTUjTsA==
X-Google-Smtp-Source: APXvYqzvuQibd2D6UfQ//STmLBnUmZhqs5HY1ImusyRyrxLJ/G1YruEWbLPZRbhabAyr6M3Iq1nTrw==
X-Received: by 2002:a17:902:7792:: with SMTP id o18mr37634234pll.73.1568241167291;
        Wed, 11 Sep 2019 15:32:47 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id v5sm22415190pfv.76.2019.09.11.15.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:32:46 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/5] cpufreq: Initialise the governors in core_initcall
Date:   Thu, 12 Sep 2019 04:02:31 +0530
Message-Id: <6ac50a647b8b9ee4af70a33fab10bb5df4a6b5ff.1568240476.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initialise the cpufreq governors earlier to allow for earlier
performance control during the boot process.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

