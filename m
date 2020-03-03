Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9191F17841A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgCCUgW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:36:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38240 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgCCUgW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:36:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id x22so2896829lff.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NROpLkqIKQsmOxVfnI3TCB5D/se19mcdjX7Jsvn77Ws=;
        b=z4JKkqN1r6xRG/KIVxn8rmsB5O65VLA31nuxkGSm+tnCsAynoEP9joIT0dW5u+frjr
         JOlrQLtXbkN8siv27mSjBLOMMLUXSCLVlzDVAhvV8sGDQp/BHBd92V79Sh+/wZ5MRY8+
         PoSDLHf23NLIt7YzoSkdsbz/WPP1+DRFdvsaU4/KD2Af/0+Pb54gQUARhQmJpGvYIK9n
         n+eBd8csqq57uOxodmQ5EKSE/Kh3WENqdrUou1a8C2F8Pqd0Zs4b3YORqcuRhHKXVNa0
         vaq3aMWT/6JGXo92PgRuKP+rMc9mhcJBgnaMT2OZ+b3mZywsnprdDXo3sqAXZj5zM++Y
         9Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NROpLkqIKQsmOxVfnI3TCB5D/se19mcdjX7Jsvn77Ws=;
        b=LR1ll35PCYg29CWc8gRRZQZ++J4NZfynoAs1JMnrv0bcO7Kgn7KEMzV0Ak4aAPAhn6
         oxvnNP2LAk6AOwekbJbEoV8Y1e6Q/CeNk/1t5r2muxxnqiwkUAC9aGGqvqII0LHCpBrh
         hhmqE1VBM+y4H0OM+DKr19d0GSgZyq4D86sa4I67KeTkc+sYCSt2pWChiiFyfSsmzH2S
         EaIgruoNFB10NnDPNiy0Gu2CvQIQeo7fMgNv9z//NWGzW0mwYFhMzLNiAcKGKdDLhr5v
         WlBRN2JAC6QaH+zLR3zJM2sqpMSVwcQsZxYh6K3OU/hq7azmArw+AIhsjvHesoiPc0u6
         WinA==
X-Gm-Message-State: ANhLgQ19/0vBMKWjaxeIivRlsA/YjbqA7piG/qahgdnDziJCRwragi2C
        OIZPiOl1jOpQzJ1e34EK+snA1Q==
X-Google-Smtp-Source: ADFU+vvzLeYQbIe0vTeTmA7QTfjZa5SPu8+43nq3kqPmgzCEuIsW2a14EHXf+icCB4h+M6eJ1zgXPg==
X-Received: by 2002:ac2:5a05:: with SMTP id q5mr3792740lfn.143.1583267780603;
        Tue, 03 Mar 2020 12:36:20 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t195sm1339532lff.0.2020.03.03.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:36:19 -0800 (PST)
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
Subject: [PATCH v2 2/4] cpuidle: psci: Fixup support for domain idle states being zero
Date:   Tue,  3 Mar 2020 21:35:57 +0100
Message-Id: <20200303203559.23995-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303203559.23995-1-ulf.hansson@linaro.org>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current code intends to allow a PSCI PM domain to have none domain idle
states defined in DT. However, a few minor things needs to be fixed to make
this correctly supported, so let's do that.

Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 423f03bbeb74..c34b12c4069a 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -49,6 +49,9 @@ static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
 	int i, ret;
 	u32 psci_state, *psci_state_buf;
 
+	if (!states)
+		return 0;
+
 	for (i = 0; i < state_count; i++) {
 		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
 					&psci_state);
@@ -96,6 +99,9 @@ static void psci_pd_free_states(struct genpd_power_state *states,
 {
 	int i;
 
+	if (!states)
+		return;
+
 	for (i = 0; i < state_count; i++)
 		kfree(states[i].data);
 	kfree(states);
-- 
2.20.1

