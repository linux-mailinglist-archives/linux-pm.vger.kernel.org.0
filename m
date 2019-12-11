Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1411B3B5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfLKPoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41822 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbfLKPoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so17037513lfp.8
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1AOYaDETC7AoWHNfeWM9scObxF5giaIQjN7hMSflMOY=;
        b=uR/XWlqUnPKu+Zx9llz6VPEhdC+0Ouhey5oNG2GzZgGnm31i1Vd1IIbsFKhFtCta8t
         9QSjI6I4BJPwsTRfIjNun5q1ClONIbt7jwT8+y0zmljSeqHba49V34wAZ4dewSrp755R
         K1a9Physk4djE0T7CDFSLP94QpLDX132rohpm5+lH0pAsZzi6k207O4lN7c8SNyOHoKk
         L/5ANPqTI5XNEEO/ZlsMiUMuUCs40jZPYIkOFWJdE4g+E6k5o1IcqGDLbddYcYgsDHx9
         IrFpiLyPn3DPyZmqjcXgmerkJRvkuPoXJKPzdYB9F/FX9tDe7qvl6p+jXhIOTm9g0BHH
         dWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1AOYaDETC7AoWHNfeWM9scObxF5giaIQjN7hMSflMOY=;
        b=I+PQbokcA0nluydqZcWXFlHfZqj9FgM0gWKRHv/kLtpOClCb+M7q8Xo1p5UYtr+buT
         KW3XlraKKuI5IxI4M5UlK1rtzkh5p1Ls+9BCvrerz4oAs937RzYb4CfqptPfL5zslVYZ
         +In+tr8oqeI1cA08+XGATSuFSba6zyRjRh7LNuJLkCioGN599x6lKxxfuDJyEPiqWX5w
         6bXvvKYNCQzHkw2p40krbYzt6L0OWGtrj2I7BgpcjvyZYIeTtzbkv6VuP7DtQciNfgC7
         wQ8DPvSe3cuX+IZuF7lTZ+63yczFai2ueMYeY6FlKNzOGeDOx8YINa9qa6BV4+afVarC
         L8rA==
X-Gm-Message-State: APjAAAUniQSbpW4/JTtNPXhvqfQ6MwJ8WXHuWHqiSPAQ2p5sbkWpYf/L
        hBYwsIsqoZU4IqX4FyDmSqN7fA==
X-Google-Smtp-Source: APXvYqw+4mzcRtBlHxe36UISiT+M6wE3tUk1CvI9Gl+QZpzzGHQxkKwO2cVnLAiFq4qHqteUcVj3fQ==
X-Received: by 2002:a19:a408:: with SMTP id q8mr2560939lfc.174.1576079043410;
        Wed, 11 Dec 2019 07:44:03 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:02 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 07/14] cpuidle: psci: Support hierarchical CPU idle states
Date:   Wed, 11 Dec 2019 16:43:36 +0100
Message-Id: <20191211154343.29765-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently CPU's idle states are represented using the flattened model.
Let's add support for the hierarchical layout, via converting to use
of_get_cpu_state_node().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v4:
	- None.

---
 drivers/cpuidle/cpuidle-psci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 761359be50f2..830995b8a56f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -86,8 +86,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 		return -ENOMEM;
 
 	for (i = 1; i < state_count; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      i - 1);
+		state_node = of_get_cpu_state_node(cpu_node, i - 1);
 		if (!state_node)
 			break;
 
-- 
2.17.1

