Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731BB3FD63C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbhIAJNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243434AbhIAJNH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 05:13:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204DC061575
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 02:12:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 2so1527344pfo.8
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWah+IetMQ7aNpxLyaztsF0WudYoMWYnrUia/FiXZFE=;
        b=aazJOhw6HmE6zAcrZkuwG0M7/uRCKODFPzfpvRHRaD6cLUQwpOsG1cDMogCOJZysEb
         Q4F2+2YU/y3IVyGuj9Bcx66RAX+frBRLcM9vPPd4HFo+COp6uOq4fZCZXtHSSMqMeSzE
         bGJpPBzsntnWAZcje8IrxGaXJYDH1LLwYVEU2fNh3Xisv1pezDu3TOCxa7Nhlo1VdR39
         WERAywUyhhAP02r07m8yqwp5VinT2c5wCAerCFHgkDo4p9v6GlS39o3fuXdA72QBeivf
         hfzQWQSJ2UkxwnJ4OHS2J1HvjLMHe1OsIrm4VlI3Zx6kUfFdU/i1ZGq96Phb1JJ8Qmo7
         UMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWah+IetMQ7aNpxLyaztsF0WudYoMWYnrUia/FiXZFE=;
        b=lM6+Nw07Dn14v3dAAoBgsYiTI7vxcx1+IfKjMF6k6itUuvwx9lcXnghyjycmpw80O9
         R+Fq33pp/D0tIb+tpIsqD2b8OGeDgIOHOAMAhWbXUYO9DhDCzw9zCT2QqYqPAmsoCHNd
         ydd6BtE2In72oN46AhM9D/Ob1WRzJ7aLJ0v6/4DHhVN1fI1TmHRd128sUQYwfFXfynRV
         TdFJb4EW8zQDo1BGZXfVU5AuzSM7zS2YrxMwoeOMWIBHDFz1U1dgXv7XKNlymj0F3ftG
         jje1rBv9QK3LziauuiTZ2H6h43E7M4mE07+YwtbpXbLcXptsqORi9ZmDtxAsK2vgrMUm
         gjTg==
X-Gm-Message-State: AOAM530hUITtn4otVdAUxta4I8VgAOp1p3SIeEIklpPPXlAuYpnd3bSr
        Jmty4IKU3/4xv1QpS5dEiWv+Cw==
X-Google-Smtp-Source: ABdhPJxx6arFHFXDgUFd17DleCNzFJq2OuN3u1BoBfcAtbs/82aMpkj/d3w5nFAGcQdzTMYAS+DH8w==
X-Received: by 2002:a63:8f4a:: with SMTP id r10mr31328737pgn.337.1630487530535;
        Wed, 01 Sep 2021 02:12:10 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id g141sm1062034pfb.128.2021.09.01.02.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 02:12:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: acpi: Remove acpi_cpufreq_cpu_ready()
Date:   Wed,  1 Sep 2021 14:41:55 +0530
Message-Id: <f8f67df9cc5ebc37b0417b2320471f117598b10d.1630487322.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1630487322.git.viresh.kumar@linaro.org>
References: <cover.1630487322.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ready() callback was implemented earlier for acpi-cpufreq driver as
we wanted to use policy->cpuinfo.max_freq for which the policy was
required to be verified.

That is no longer the case and we can do the pr_warn() right from
->init() callback now. Remove acpi_cpufreq_cpu_ready().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b49612895c78..28467d83c745 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -889,6 +889,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible = !acpi_pstate_strict &&
 		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);
 
+	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
+		pr_warn(FW_WARN "P-state 0 is not max freq\n");
+
 	return result;
 
 err_unreg:
@@ -918,16 +921,6 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void acpi_cpufreq_cpu_ready(struct cpufreq_policy *policy)
-{
-	struct acpi_processor_performance *perf = per_cpu_ptr(acpi_perf_data,
-							      policy->cpu);
-	unsigned int freq = policy->freq_table[0].frequency;
-
-	if (perf->states[0].core_frequency * 1000 != freq)
-		pr_warn(FW_WARN "P-state 0 is not max freq\n");
-}
-
 static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
@@ -955,7 +948,6 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
 	.bios_limit	= acpi_processor_get_bios_limit,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
-	.ready		= acpi_cpufreq_cpu_ready,
 	.resume		= acpi_cpufreq_resume,
 	.name		= "acpi-cpufreq",
 	.attr		= acpi_cpufreq_attr,
-- 
2.31.1.272.g89b43f80a514

