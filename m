Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1617841C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgCCUg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:36:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35735 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgCCUgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:36:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id a12so5085946ljj.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6OxZjqO84dNl99kuVPctKqSI5SbottYVoqCuAlbKlY=;
        b=xL/TeD7xGicYVnZjuz5GIxiYOxPH4BTrkcynvaLMauv1NyLuQtHbfACxUi7y3w5VfQ
         qBbXxi4obb7qT3QVorg9XjxXG+W3XJDgFKvEyveWOQocNLnkXALY3aR32yqG94pKZUcl
         jvMUa1LO/S2GhGsGYyNUD7RNYW0GsGmvPnh8kgxFn3DJtqGTbL/8DIO7DmaU6bUOjp1F
         fTQqat4KxMdVagRi9hGOUlLG1rfyN7y91LriVd0D7hbvBNI8ld0LNRkEVNm4gCaDCH4a
         zqhfX0P+cUgzYVj/+MXpoRIcT9EC9DS1X9VkqHvJsWqk/Rh/DkmZ5Twp6fCLT3AIL8jA
         iJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6OxZjqO84dNl99kuVPctKqSI5SbottYVoqCuAlbKlY=;
        b=F6ak0wCJNVb8WucoYyMjdE9W5/VpdDUG8ceQeI0Ibx2xvUEwmetehW/b/ugDiMwVNS
         UX613nHNYWVaba8uz4zvCFMqKA8fNmdRPfBHLyPPmVesZ0eN9OH4KlVBm6fA3nkwd9Aj
         njrmH02AXJtwrunXypEdy/SMNFhLP1m5no0+72b6IfvG1/tVPBQ/i+E7nM+lF4sp1m+w
         G/JoxtcDm+QAxxKT9NG470237ZaLMsMCbVER18p1BLW2F/ZA85MobDSlzIi7KJ2Icpvv
         0VrxZGEQRmoAKM/txepQZct2ypP64xo/QBlQS+v8eK6IPwfO9Tj3dYTN3FRIQ0TbKmmW
         zIpA==
X-Gm-Message-State: ANhLgQ1GRSvBcE/DTNfSXrOYM4lfSKhKHmaTDIyb6EIE0QqdvNIONPUk
        qydBkZ+xPsZfgVFf9TMxHjhtLw==
X-Google-Smtp-Source: ADFU+vu6WzpHn5qg+aeDQWydbv05vDibX4pkN4lVrelM0STP1h+Lc44f+lGs0T4jy2FAanBW1AKICA==
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr1138741lja.16.1583267782135;
        Tue, 03 Mar 2020 12:36:22 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t195sm1339532lff.0.2020.03.03.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:36:21 -0800 (PST)
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
Subject: [PATCH v2 3/4] cpuidle: psci: Split psci_dt_cpu_init_idle()
Date:   Tue,  3 Mar 2020 21:35:58 +0100
Message-Id: <20200303203559.23995-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303203559.23995-1-ulf.hansson@linaro.org>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Adopted suggestions from Stephen to use IS_ERR_OR_NULL and
	PTR_ERR_OR_ZERO, which further clarified the code.

---
 drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..bae9140a65a5 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -160,6 +160,29 @@ int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
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
+	if (IS_ERR_OR_NULL(data->dev))
+		return PTR_ERR_OR_ZERO(data->dev);
+
+	/*
+	 * Using the deepest state for the CPU to trigger a potential selection
+	 * of a shared state for the domain, assumes the domain states are all
+	 * deeper states.
+	 */
+	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+	psci_cpuidle_use_cpuhp = true;
+
+	return 0;
+}
+
 static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 					struct device_node *cpu_node,
 					unsigned int state_count, int cpu)
@@ -193,25 +216,10 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
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

