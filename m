Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6AD2821
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfJJLkP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41934 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732671AbfJJLkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so5831958ljg.8
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPQQL2LvieO3hRSdVOoT+soulZMhG9ActuEg4qQLyaA=;
        b=T0nFsd0F5yhLoTBaFcw7y7TSJ7swFLFrCm0iZ9fxXkpwH6LgoqyNcmtnY+mHnZ7wqA
         tzclaFDIjVJeRj4TRzdNHxas/7Vc8CSCkhEVswvN1U/GYZXItT1Dooz0x75Gut6BZJwe
         4S12SRko6dhQUiVAR7mIGBsqkpltXwc+NMvmdHK8upCiNxXR8JCoLhsHRJqg1TNG15Iv
         a8dMDov2BYDB7gaiCVsBOvN3bHHR40LV7UsV9TRjpeuPT4Ri5Tw3COGyo494xPZWl7xQ
         Q9jZ1l0HBJVKHFxRnUwvZuXn9e9UCxKzqe6oBIidHY+cpmTeJzdcMO6Goptv3Oz/YpEU
         VJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPQQL2LvieO3hRSdVOoT+soulZMhG9ActuEg4qQLyaA=;
        b=PPciaWL3rBDhMv7K0tl+jZnsKN++uyZPJ/IOxN3zUrmDCldbqZyHptmuRKynKATahj
         6xCxo8YL/gCzOPWmsG7SKEAtECKX2umCne9jBhxXIelKY/TIg6UKrzGlNb3H/CN2H5LX
         MTc4Z3mk7AN04dTXWeWsrFcKqLuhhjuPUACYkYlChrcszgeNw0OyOAXUXn37AnlnrZy5
         nWOgNClrlXKtRKUG1BCZmS+83II5PwpbMmgPNG5tyZ8r1m9nLUbzE+R26aNGPEHlYuJQ
         uFte76Ge7XLjU0HjQHYqHc8Q6BPIOY+EL/6cQrrIOlo407pRCV28LwW5h2JGtM3p1ZcH
         n2Kw==
X-Gm-Message-State: APjAAAUVcwLwhCny94/eN8DmH8f9XDHnACvjRJkI0qHMBTxhxuSlnWYj
        c9zQ8kuHnsWownL+tDvx81H+Dw==
X-Google-Smtp-Source: APXvYqwd9hZQk2PNNSWawnj+vwKKoXgMm6PDK8dcNZdYDc7Bp/XO4FPg5jdpJ5ioW9H9llCi9Uk6EQ==
X-Received: by 2002:a2e:6f0f:: with SMTP id k15mr6301625ljc.12.1570707613211;
        Thu, 10 Oct 2019 04:40:13 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:12 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 05/13] cpuidle: dt: Support hierarchical CPU idle states
Date:   Thu, 10 Oct 2019 13:39:29 +0200
Message-Id: <20191010113937.15962-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented using the flattened model.
Let's add support for the hierarchical layout, via converting to use
of_get_cpu_state_node().

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index d06d21a9525d..252f2a9686a6 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -111,8 +111,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
 	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
 	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
 		cpu_node = of_cpu_device_node_get(cpu);
-		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-						   idx);
+		curr_state_node = of_get_cpu_state_node(cpu_node, idx);
 		if (state_node != curr_state_node)
 			valid = false;
 
@@ -170,7 +169,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
 
 	for (i = 0; ; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.17.1

