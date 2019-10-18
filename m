Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE4DC05A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633002AbfJRIwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 04:52:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43574 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394802AbfJRIwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 04:52:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so3442267pfo.10
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Pg58XqMrgMUueF1t0WSUT94hNH4L7QyXjN2jFD44ecQ=;
        b=mbBsczHQ7geTZHLUH4glHa/GX3d3C6ZLa1u5dvWDZVaHWaS2JW7g3tU6SDyLxy6o1u
         Ds+uGnMxFI1XvqwwerVewsBsOJm0LG3yhE5/CfT0nTve6T4lYLg/BgbpeWs9FCp3bkP/
         2Ibs1iUqmJT+tkwK3dSKnVoWyVL0cPq9GW2PyGPwzyZQKgs07xKmYmo06UC3UTN9b1TI
         6DN0X7GFdOLHiURDDIY1mq6bMBwOnZi5VaudeF59RJejJJtl3JcMLLSqmVEKZh12MXZO
         O9krPHLIXRIT3dWmX/RwRshSQBwsyDEVqof8bpki2b5GXrFYAUiuAvb6PPcfNflVbqGI
         UBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Pg58XqMrgMUueF1t0WSUT94hNH4L7QyXjN2jFD44ecQ=;
        b=mUReFG5kgg0mhwyhyv0jBDTuN/jRnbPSsHdoWaiaqVxJKq9/c+ghhR+3o4FlT+Rx0w
         9rdM3OLrmLC/XNmDIVls54UyHYevOmOEEt8p01SBvO7FlzxtIYxDl9wqiG7CG050Hh4h
         4+2vaGKHdyFfDqUymHeb995zlDXE6BvduzbHWd/VtFodjFWDNZzmyw6lyRM9wFSIf78w
         kzIaE9arpDm7/vHD6iH0d33cIsd7nSLJ/BX/x2JfPXXkPfwE8eEGhG8+ikxG3d6fd1cb
         FqwkQ5spMHFmq7URVLjQTGsCPqRZuhhqfVd6AApMcQCxdlNuz56tR0XXxB2cYib4BK/O
         2MWQ==
X-Gm-Message-State: APjAAAWzJTKUUigsTE873ZSPOLADUcoM7lXyalJASVJRHvJEcsaRjcPQ
        AYl+3yvbmy2Pi9acLDMIYkiF1w==
X-Google-Smtp-Source: APXvYqx8Mpcrks1BZxeEuPxaAnWhLPj55ZV7f4Bw1XHAjGHH8rk1ne6dxHoD9m6lONZAOPVwKvp1Fg==
X-Received: by 2002:a62:4ed6:: with SMTP id c205mr5321495pfb.208.1571388755817;
        Fri, 18 Oct 2019 01:52:35 -0700 (PDT)
Received: from localhost ([49.248.178.134])
        by smtp.gmail.com with ESMTPSA id s1sm4662870pgi.52.2019.10.18.01.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:52:35 -0700 (PDT)
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
Subject: [PATCH v4 6/6] cpufreq: qcom-hw: Move driver initialisation earlier
Date:   Fri, 18 Oct 2019 14:22:03 +0530
Message-Id: <3d367762ba72fa1cbd6391dc55d94b3284f6c00c.1571387352.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow qcom-hw driver to initialise right after the cpufreq and thermal
subsystems are initialised in core_initcall so we get earlier access to
thermal mitigation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Taniya Das <tdas@codeaurora.org>
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

