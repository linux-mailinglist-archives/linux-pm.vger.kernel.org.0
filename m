Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A872492DEF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jan 2022 19:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbiARSzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jan 2022 13:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347837AbiARSzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jan 2022 13:55:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB27C06161C
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 10:55:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s9so271099oib.11
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZFGTElrC3sfK3btUfb11FHGF7x4FjrcJFy3qIIQKiM=;
        b=hCarYOz34jr83WftfM0iS+dwH1sSDGCkfsBkAB57NfnKesxK4aaH5gD3/gh3issx9+
         Daa5eBqKtQcCCoptygVZMnTNfFjMD8xIZoP7jzlGWUGzWWIUiTFJ3vGwzYp8QHUkHvDX
         qpJY+Q0N4siTxyRUiqYaSBFwPjztC9Dwyzg20xTJeFpuiUGSgcpmoF9mm+KrEFyb2VW5
         GQXv425AFDyHeYwfKpRwAaPL9cGijJqd3aCus/IssOUsVcRu3y4VSnTgwf3/Qoy3a4e5
         rNzA1caD7HISrSKPftdbKKczvNQz2zBzNro1xInu9PrWcsjXFXZdGcNMIqx2ZFbW7Sac
         ENvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZFGTElrC3sfK3btUfb11FHGF7x4FjrcJFy3qIIQKiM=;
        b=r9FpLeBy53pGNxTd2EnEgvTOkdrz5BmQJ3qfFIuOd8b2iicBfl9HQ87iF/GwSkPM50
         pllXZ5wDYVsXIdpKMrq5lNNCkLSQEoUeH2louQaY8o8FKg0+d6ad8ksm69VOqajHa/5a
         Rlz+vWmGbEDEjhb60UzbnHwYGrTqGgRt5e5PbmjCTBPWWsRbDDDBKeGLR7WaVISGh3WM
         Oojk6C2bbI3i1EzLwBynU/tyAik5Rrq/gnGbxwQHOFf74EzD7wdJCra8giHxnNp7RIIL
         QQnIqNWy9KgwakOyRPNJ5kWe3wpzb7/qu4GdkaW/3FIhRH+ki4hXqjDvqemgpYjkBuyR
         dN+Q==
X-Gm-Message-State: AOAM531uXM7zwxsJb3xhLxtcXeQaAiHu+oKxSnCW7m0Bk78c1o4FtG/i
        O2S7PF96FTqMd8iNuU3fTG7jdg==
X-Google-Smtp-Source: ABdhPJwMGts/PsWLqBrYm3HeRRLwq7WaG7CdrrxQZDPqt3E46l7dlRGt5JffecmAxnLrUslTHJ33uw==
X-Received: by 2002:a05:6808:1508:: with SMTP id u8mr9261476oiw.35.1642532135383;
        Tue, 18 Jan 2022 10:55:35 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id n19sm7258855otq.11.2022.01.18.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:55:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: qcom-hw: Use initialized cpumask for thermal pressure update
Date:   Tue, 18 Jan 2022 10:56:11 -0800
Message-Id: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the event that the SoC is under thermal pressure while booting it's
possible for the dcvs notification to happen inbetween the cpufreq
framework calling init and it actually updating the policy's
related_cpus cpumask.

Prior to the introduction of the thermal pressure update helper an empty
cpumask would simply result in the thermal pressure of no cpus being
updated, but the new code will attempt to dereference an invalid per_cpu
variable.

Avoid this problem by using the policy's cpus cpumask instead of the
related_cpus mask, as this is initialized before the interrupt is
registered.

Fixes: 0258cb19c77d ("cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 05f3d7876e44..866fba3ac6fc 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -297,7 +297,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
 	/* Update thermal pressure (the boost frequencies are accepted) */
-	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
+	arch_update_thermal_pressure(policy->cpus, throttled_freq);
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
-- 
2.33.1

