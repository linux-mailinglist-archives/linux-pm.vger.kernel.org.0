Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24E8E8D03
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfJ2Qoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:44:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38650 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390436AbfJ2Qoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:44:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id q28so11055990lfa.5
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ez2utYAtjrFLSHNrrL2RvE6Z5l8CFOmyZBlsi6wZqI8=;
        b=eCGaQk2ChyJ/95Dayhp/eCVH9GYp8vqXLGYdKqn+s6sbEXDtYLqRbzL7MikO9jQwyb
         NSWhHLVWes+HJoe8km3MiXNurD1DIePI4IWhRMUJBpByb2QW+HnOwvhkWFffVUwo1qqE
         74g+X6ot4NazRXExIRE9h6nF5bDA3m6jHXT5deC0kDgH83ltRxgW2Mafp/I7qfrbwGec
         BZci5DBOypZIdRKtHNqIhasuVY2HvSsYaGEQVgReO9iPipAlWPN+I5faeOai7oGtGJa/
         1xlmHTo7sf0GTQml9Crhr1W0TtwNUr4qnjdFhNspGAPBO/3t9kbe6mGFB2FCR9QjWZRe
         /jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ez2utYAtjrFLSHNrrL2RvE6Z5l8CFOmyZBlsi6wZqI8=;
        b=H7Hhw1FhYtLzMxFDZh/xE/3emXwYYyAwwkCeBqH71NCOF3b4IT8bqo5bqxS2424A61
         jZiqqfvJGqvas+rTxESvbs+o+KzVe9FR3FiEvjMeDjZ8GmRLlLBpKc6BSYlvc/UqjP2v
         RIrcn03dKKAojP4Mv0yXWrC2ytuIBdl7rgUGdhhMed+KC2YUKYSI7OKjSBTjQVakWazx
         yGCQ0znOx6ADcXdyR6A/oFp3zeRsQ5PbWX8Eq8+dKOlfY24KkuA+rqKypGRtuGO1Ke+m
         Jzz8N+wFkWuHXnZX5oxJI/rysVEqb/oEobq+Tsawxq7lLAdBabmLIb5W8UwZ3L+ASOzH
         dPQw==
X-Gm-Message-State: APjAAAUVSxWMvqC4eIqwBJAgitxUOA4KNa9nTtBYA6x3OUJmqJyPDqFa
        9UHN810165iuvm0cun+5t7Nm6Q==
X-Google-Smtp-Source: APXvYqwG093vCEUK38BuHysHC02MT9Ew/IBlJLhyuhJziPLSFaU9E7tosCpzLO3LqiexNq1Pnlj3zQ==
X-Received: by 2002:ac2:43b6:: with SMTP id t22mr3275250lfl.126.1572367491899;
        Tue, 29 Oct 2019 09:44:51 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:44:51 -0700 (PDT)
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
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 05/13] cpuidle: dt: Support hierarchical CPU idle states
Date:   Tue, 29 Oct 2019 17:44:30 +0100
Message-Id: <20191029164438.17012-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Added tags.
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

