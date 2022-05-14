Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F22C527284
	for <lists+linux-pm@lfdr.de>; Sat, 14 May 2022 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiENPUx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 May 2022 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiENPUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 May 2022 11:20:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA362F3A4
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 08:20:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a23so5356952ljd.9
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jN8Cl5mMVbr+UVzRRSRn5vcrJAUsBCcLDo+azLgnVmQ=;
        b=ZGnFOk9hnpw6WfZAAwaIom/4T/t0E3RIw3N5rrztcNKF1+cnTHgUXQ5eAksdWhd8F8
         LL0Hp6hlh1rBhZ8SpqPVGfvIw1MIfkwUwzEuLT4zYmqW6XfwWdjbxmugBH1rWe5FqKDc
         /qih7U8rfz8MXQKbPbRmdkUNl+VZR0fZnSe8Q4oWjwleOFkxqjHQ/eJrOdyGQDvcczNR
         uGhzOiBs06Bu55Kp2793VRtPn+Ke5pCYovkRcYRg8YBg0l1vBMPZuK4oTnnzOcVgfDBl
         fNQiOTkxaUGgmBGs3YjN5kH6dZHJKibKoPXPqoxNpBYmiG4gQRpsZF3hN6DD9NrCN8f0
         YkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jN8Cl5mMVbr+UVzRRSRn5vcrJAUsBCcLDo+azLgnVmQ=;
        b=VbnYetYeSPRmfZnZDgnNTW+Az0XfVkFevyFSvJrEP3G1h7cCaNxIFWyoi8Zo4OnBFP
         0tppVRyB77+6SwYMnCK6eNiySE4nYxExDa28xNCqwVMZIO/Lz5F9f1IckqMz/9i6yob9
         490YgYrtB0RQEOzupiDHlTS1/kJF55GnUNZuNYJ38XyT/AdIdA+wfGuJPY+OVXdMUXih
         aZRmRMm9Zp12VXS1sFZRhbhGn7wimxmcGQXxiyUKgHm6R/7CrcXwEYR8D40VFw3R9T3L
         ZPMiXsYYNf+5Ied06yn3MxjE4GvWhGsm+8BvwNoGhuDplwccQzw0GEAEYt/dG1Kxcnmj
         P+2g==
X-Gm-Message-State: AOAM530HG7g0wiQcXWkFF1HuWBDErqc/mKqSz185XwSJGjwysM8/xWbF
        /hRQ5X9hrBEJ31VWtKKjdevgoQ==
X-Google-Smtp-Source: ABdhPJyo0RugdTImkXnKS+tdrl2IGYQ36+s5tAYiGXLQWyQLsPLFwsaWHeGOeGJoSr0CzPerDZPL/g==
X-Received: by 2002:a2e:84c7:0:b0:24b:6842:1923 with SMTP id q7-20020a2e84c7000000b0024b68421923mr6306348ljh.166.1652541648677;
        Sat, 14 May 2022 08:20:48 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id j18-20020ac24552000000b0047255d211d4sm734170lfm.259.2022.05.14.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 08:20:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Anup Patel <anup@brainfault.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpuidle: riscv-sbi: Fix code to allow a genpd governor to be used
Date:   Sat, 14 May 2022 17:20:44 +0200
Message-Id: <20220514152044.758802-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The intent is to use a genpd governor when there are some states that needs
to be managed. Although, the current code ends up to never assign a
governor, let's fix this.

Fixes: 6abf32f1d9c50 ("cpuidle: Add RISC-V SBI CPU idle driver")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index b459eda2cd37..478970fa3b0c 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -413,7 +413,7 @@ static int sbi_pd_init(struct device_node *np)
 	struct generic_pm_domain *pd;
 	struct sbi_pd_provider *pd_provider;
 	struct dev_power_governor *pd_gov;
-	int ret = -ENOMEM, state_count = 0;
+	int ret = -ENOMEM;
 
 	pd = dt_idle_pd_alloc(np, sbi_dt_parse_state_node);
 	if (!pd)
@@ -432,7 +432,7 @@ static int sbi_pd_init(struct device_node *np)
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
 
 	/* Use governor for CPU PM domains if it has some states to manage. */
-	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
+	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
 	ret = pm_genpd_init(pd, pd_gov, false);
 	if (ret)
-- 
2.25.1

