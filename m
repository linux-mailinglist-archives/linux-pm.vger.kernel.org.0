Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB01717C3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 13:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgB0MqY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 07:46:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46731 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgB0MqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 07:46:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id v6so1955497lfo.13
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPYRIg41YwW5y7gzBIFCCQYc7BuElmJfratXvS9/RTU=;
        b=GRMBtDnuFIHhKQLNR5bYnf0YeAvzu8Lkr45VhsfqrQDfegayFVkGEDHxmkTQbBM127
         d0GGkdb82XKNRJ+F0B/Y7uK2QtkhbkfZmBzDRNEW6o1VKKoUgSaYFLuKaD6kIzusy/rg
         VlObzJ6OLnbrt7IhkbLN+nAxe8wDM2LT2gZCSH+4Pib6NlW6ItxKWAWYb2xtBk5FDUQT
         KJMjc+wYUwfzW8jO13sOV78g6kTWdJn2sAcNBULDQIhQ5JwOsvghkPFsog4VDoMa2+3T
         6TmnBYL2K1XcXcMwVwiBUOdbZUS2b4DvOfXDcQ1w17MtSe8UwPRJgNyllErCUf8gBaZw
         iXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPYRIg41YwW5y7gzBIFCCQYc7BuElmJfratXvS9/RTU=;
        b=fCBmk93Lu4ZqRsuzArzO6CamtOWAFWcNi3RLZ4+a3EH+jMSS9dSxPIsjs8/MEDTlJX
         ruhptzbqyPDVIIbZM/fZRDXt7lQ4SiPAHBgWYee+GfdDk8A5yR4uRU3Rm4ziqH7ge+9/
         CkygarTmmRvfTzfuc1BVrAqTYWMNK8bI7fohq/tHEXEi1gA3ncW69gbyjro0dq3uyeC8
         PvNDjUQY75xb7SQZjZ0LOdFPozOJ3u1PPxLFA61BTbNTbtza2wX60xuQP9tA6dlHBLBK
         QySRBDJkf5XrBKE+VeDS4Lqi9KDENVTYfK4fnMPBOZlXoKI1/7GkUM3Bl+4EYE1HwWkE
         VphA==
X-Gm-Message-State: ANhLgQ1+c7wO8E+qK4IieGP9K/bwPEVBk3Gx3GMzivg2pMCdZpazNAUR
        SQ0f/Q90TDNWCfy9cppCNfbpRo9ONpw=
X-Google-Smtp-Source: ADFU+vvy3xadzFJgMR579KvBJp97cg/u1LNr5iTXRd789EXBWJ1RL/VY1A+sJYMUch7iOHDB2kfK+w==
X-Received: by 2002:a19:6445:: with SMTP id b5mr2044742lfj.187.1582807582480;
        Thu, 27 Feb 2020 04:46:22 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l16sm2669334lfh.74.2020.02.27.04.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:46:20 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] cpuidle: psci: Split psci_dt_cpu_init_idle()
Date:   Thu, 27 Feb 2020 13:45:50 +0100
Message-Id: <20200227124551.31860-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227124551.31860-1-ulf.hansson@linaro.org>
References: <20200227124551.31860-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To make the code a bit more readable, but also to prepare some code to be
re-used, let's move the OSI specific initialization out of the
psci_dt_cpu_init_idle() and into a separate function.

Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 49 +++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..7b459f987c50 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -160,6 +160,32 @@ int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
+					    struct psci_cpuidle_data *data,
+					    unsigned int state_count, int cpu)
+{
+	/* Currently limit the hierarchical topology to be used in OSI mode. */
+	if (!psci_has_osi_support())
+		return 0;
+
+	data->dev = psci_dt_attach_cpu(cpu);
+	if (IS_ERR(data->dev))
+		return PTR_ERR(data->dev);
+
+	/*
+	 * Using the deepest state for the CPU to trigger a potential selection
+	 * of a shared state for the domain, assumes the domain states are all
+	 * deeper states.
+	 */
+	if (data->dev) {
+		drv->states[state_count - 1].enter =
+			psci_enter_domain_idle_state;
+		psci_cpuidle_use_cpuhp = true;
+	}
+
+	return 0;
+}
+
 static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 					struct device_node *cpu_node,
 					unsigned int state_count, int cpu)
@@ -193,25 +219,10 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
-	/* Currently limit the hierarchical topology to be used in OSI mode. */
-	if (psci_has_osi_support()) {
-		data->dev = psci_dt_attach_cpu(cpu);
-		if (IS_ERR(data->dev)) {
-			ret = PTR_ERR(data->dev);
-			goto free_mem;
-		}
-
-		/*
-		 * Using the deepest state for the CPU to trigger a potential
-		 * selection of a shared state for the domain, assumes the
-		 * domain states are all deeper states.
-		 */
-		if (data->dev) {
-			drv->states[state_count - 1].enter =
-				psci_enter_domain_idle_state;
-			psci_cpuidle_use_cpuhp = true;
-		}
-	}
+	/* Initialize optional data, used for the hierarchical topology. */
+	ret = psci_dt_cpu_init_topology(drv, data, state_count, cpu);
+	if (ret < 0)
+		goto free_mem;
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
 	data->psci_states = psci_states;
-- 
2.20.1

