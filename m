Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C13DEBE5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfJUMPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 08:15:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41264 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfJUMPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 08:15:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so6528681plr.8
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cukx8ujHc8MZYDdytnpBWfM0F4aiiT0HrshMHuyoYiA=;
        b=EW5sDR0BhvXc5p2C2yYb6Ly5+xBcSNYaYAMkfBRcHMvST6fBuTLsWUipr6L1RkaRHR
         EyQ/H1mFn/ZhFeoaHosy+oDTjscGr13sRayWyNPEf5vnw4QJRA35GkR84gG6DyvZc416
         VTWlu1owMddSIyvuBExTYfiRkBmm8T0iC4NPVX9FXIOxND35hCBjW51j8vY+xqn4Ztmx
         Vfl39SaOokAvpylKjusmOdhXZOyMu+1qRqwkgdcNrcewQot7pzpdBskEGhj6Ri86OLDh
         lrDsx8HLSHqVT07Ud81PSb2H10wWUkVZ/day47X+8dGQjogXPa1x617kWPv/z6Pw8KCl
         DKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cukx8ujHc8MZYDdytnpBWfM0F4aiiT0HrshMHuyoYiA=;
        b=TaCOCpQyVllRYQRFzn85Gtq4AScdZd5y+u0Lqdkq2NLWvfVi7hYrMRx5JyPRtwp293
         b+IMeNh51CsG9yH3GyDO6XyWKghrqaXRLydrTrivuPLqlJ/9ZApy9rgQ9lvzLr+xSIu7
         gZr6VqOAmyaEzTHfCwqMsCi5+cKwzCGgyxL4MhCH5lnZ+eFZ+KIWpyIMFmMTKEggRF2Y
         mDSeyuBiDObF34TzVbcxpLQHIAgLog8vanlkpr3RwAfb+RapmLrQIfmwlU+gNHZUzryV
         ziJoDLt4xsv3zc5TGtEJxeGsRc+WI5XbeUHxeTTdKMkkthImU+/LJG6ATF0ursyjvnjF
         Y/LA==
X-Gm-Message-State: APjAAAUTBylwhYy6Zqvxtm5sNUqDpQOcUpHz/7okhpxewhJ1asgE5XXV
        G4KlgmeGp7xn7C9SHsnwLcYQ6w==
X-Google-Smtp-Source: APXvYqxxOzJafjce4b4GYvuqt+JhynnibQqUNBuGu1L6adXLHdWZzFTJzN1XM6qXNR42+xvxeXPBuw==
X-Received: by 2002:a17:902:fe8c:: with SMTP id x12mr14860552plm.55.1571660142988;
        Mon, 21 Oct 2019 05:15:42 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id e9sm12976482pgs.86.2019.10.21.05.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:15:42 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v5 6/6] cpufreq: qcom-hw: Move driver initialization earlier
Date:   Mon, 21 Oct 2019 17:45:15 +0530
Message-Id: <eacce8d08388b0bdfc908d2701fe7c2b78d90441.1571656015.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow qcom-hw driver to initialize right after the cpufreq and thermal
subsystems are initialised in core_initcall so we get earlier access to
thermal mitigation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Taniya Das <tdas@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a9ae2f84a4efc..fc92a8842e252 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -334,7 +334,7 @@ static int __init qcom_cpufreq_hw_init(void)
 {
 	return platform_driver_register(&qcom_cpufreq_hw_driver);
 }
-device_initcall(qcom_cpufreq_hw_init);
+postcore_initcall(qcom_cpufreq_hw_init);
 
 static void __exit qcom_cpufreq_hw_exit(void)
 {
-- 
2.17.1

