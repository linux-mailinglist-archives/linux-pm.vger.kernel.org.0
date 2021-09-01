Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121AF3FD63E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbhIAJNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbhIAJNK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 05:13:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7BC061575
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 02:12:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so1547977pff.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9awTdNZXeyUkH/oFOCLr7e4LdyXBILhh3s1aaJszUyk=;
        b=ihEuaUERWeKow9ehEulv8jzIYo4APivhosmQp5knPz8bLu9qf2kiJ526U48rO2uRnL
         p2gR9SCalooNAenTmIRj30SJOyHBuPevEvt2DN+UFuSBw6SLeP7SRC1deAzXrIFHEoFN
         XqzPr7bevLHVks7G+mZXpn71JI+0nbgN8MKVAJ2NKpyRnNoLOQWzEhIlQ2HmOVXgmGdh
         zMranfIMmYNrrKN60W3XQuBEd0HVgzTBXqnhpVpJ0CZq8YX6YjY+TF7imRJADHn9/lvm
         sJB0d5CW9cwyNYBI8M7w4vDbjdl/mxv3hhgTE0u1CRw5HvpoYnRQKCV5mlR5y6B8Pt8i
         q8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9awTdNZXeyUkH/oFOCLr7e4LdyXBILhh3s1aaJszUyk=;
        b=lTDHKmbppQYMDv0YAL7qDmWhQ3gynhYKOzI8eLLdCkvtvryZCouxs/rjiBvzOmEC+o
         avFSvHpJFx5PyJALmZJzrqDgcSQhfRylGKRM2WDyGIx1fSdT9NJghE5ryIT4Z5jmSEmz
         tkfI7XNmjzUT2YDnaygCbS0HqntTr3z5IP4NbE1D261CLQpsO5zanrt5CORBqZRx4jZy
         5qkNAuPt//+ot3WWkGdvFLCK73BrqzgOHlZKMKF2TmVbXNDSIHBjQLXiONyigjiRWSfS
         vCrXIrE9tKytUXnQq2mc2sGia93rOKohraXmkpcjV9SdftuZ6LrtXV4R+GDRBsmxiJjl
         /UKQ==
X-Gm-Message-State: AOAM532SpaXNDqXPviJ/YmNch69nan8hye+KRYIiVFxBzYmMyg4qzfI/
        ++HpQqC10pdAdxdSIA3n5VTEcw==
X-Google-Smtp-Source: ABdhPJzXC3xDk2lbyoJmViBzLMbFm4JFysm5CrC+l/MMJFZq9mvpJS/kohLSc3tRGDIhCjVdJqNccw==
X-Received: by 2002:a63:444c:: with SMTP id t12mr31095067pgk.212.1630487533654;
        Wed, 01 Sep 2021 02:12:13 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id k190sm12341642pgc.11.2021.09.01.02.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 02:12:13 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: sh: Remove sh_cpufreq_cpu_ready()
Date:   Wed,  1 Sep 2021 14:41:56 +0530
Message-Id: <2c81cd66e09dccb9189221d39f0871d9fc7192d3.1630487322.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1630487322.git.viresh.kumar@linaro.org>
References: <cover.1630487322.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ->ready() callback is going away and since we don't do any important
stuff in sh_cpufreq_cpu_ready(), remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sh-cpufreq.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 1a251e635ebd..b8704232c27b 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -145,16 +145,6 @@ static int sh_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void sh_cpufreq_cpu_ready(struct cpufreq_policy *policy)
-{
-	struct device *dev = get_cpu_device(policy->cpu);
-
-	dev_info(dev, "CPU Frequencies - Minimum %u.%03u MHz, "
-	       "Maximum %u.%03u MHz.\n",
-	       policy->min / 1000, policy->min % 1000,
-	       policy->max / 1000, policy->max % 1000);
-}
-
 static struct cpufreq_driver sh_cpufreq_driver = {
 	.name		= "sh",
 	.flags		= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
@@ -163,7 +153,6 @@ static struct cpufreq_driver sh_cpufreq_driver = {
 	.verify		= sh_cpufreq_verify,
 	.init		= sh_cpufreq_cpu_init,
 	.exit		= sh_cpufreq_cpu_exit,
-	.ready		= sh_cpufreq_cpu_ready,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
2.31.1.272.g89b43f80a514

