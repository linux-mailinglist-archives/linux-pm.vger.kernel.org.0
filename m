Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0B11B3AF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfLKPoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33537 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388750AbfLKPoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so17120568lfl.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3dFHMSTWmknhjBa3X9neiliLOt0Ua6IMiSdXiMVvsE=;
        b=wcpag0kFqzXeqRry8Pg+EjTlMzNiSVaOfpgd2if+zbTIxT2iOgTP4xyZQYDC8Bs6dB
         Zluu3yKQ0PKtJnDpD55xA3itb23Jn9Sp2je5wAgwp4H+0HY2bMJk7/6Ipq8dh1R89DaB
         n1URhE+ohyGVs+jgVRNadHhoHlebRHdIPN/V7BI6SBWKO2DYO8RdzuvI75pXdvqpvhXz
         7M5kOfABGVvXfaD9+Bldd012eFKU3iv0n9b8VLjttNt5N3LN7Z5pBKEB8eiFVpTjae0r
         FYPzg01HomARnv+j/Tsl7qynJqgHED4aYsx7ALVvAkIb5SElrIMAY6qA4fQ2A2d3w9tt
         tWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3dFHMSTWmknhjBa3X9neiliLOt0Ua6IMiSdXiMVvsE=;
        b=gzEmbSGNulu43XXKxI+ern32XxgRhvcn8cZ1APiYsXk/TsCgHLf9sCp8X/ip8Apy4J
         g76y++J9RyTMz7rIGtVa1WnUdlMUNdr35Z1jeYSBqM5Ph80M92VgtZWyGDkqkgrLZrbk
         XMPEO8JQlLFGwAhSAO+hJsNvo8R4M2dZB1gT53JX6YrraJj2K5mJMD7DCQDjSDSjJP51
         Rh4eVf3LORl3Dz9Rf5/jmgMbB43ckMQrwCsaOyDJqRCGaJDYJ7pDky33UiXtk5AVgIcp
         Ko/Y69LWX4kfYm+nO5P/IBEuWX9ebWYZi9Mdbl7PpUweaYHaRGF/5o68vm4ksO5SEr2A
         LpQA==
X-Gm-Message-State: APjAAAV+aLnR/xhHBGyQtQTNVPwvPpKjDAe5gZK6LBFlOHwtf9e5uDE7
        uPWXt9acrRKP2NiecsDMnIbPRQ==
X-Google-Smtp-Source: APXvYqybL5yW0+Q8vqmaFlpbiu510ZmXk7dCEaf5C5AYnxU+6bSbBrEJxJrKmgsFoRB3rc4iE6TC2g==
X-Received: by 2002:a19:5f58:: with SMTP id a24mr2699587lfj.9.1576079039918;
        Wed, 11 Dec 2019 07:43:59 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:43:58 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 05/14] cpuidle: dt: Support hierarchical CPU idle states
Date:   Wed, 11 Dec 2019 16:43:34 +0100
Message-Id: <20191211154343.29765-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
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
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v4:
	- None.

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

