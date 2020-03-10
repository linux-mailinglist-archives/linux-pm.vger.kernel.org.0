Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE4C17F530
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJKkc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:40:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45924 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJKkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:40:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id e18so13490963ljn.12
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOmLbFg4f7m0VWnyO1xDaH/AZNMu+kPMNjgBVvsbMM4=;
        b=XmPV7pmfeVwv3eR7FYLArkOxNj27Kv2v7Sx7iRQrmZdzWxfxlm1/2+6ROU4I24Rih4
         sfMG2dff10ReM0skBVyIR8ywsuBgmcvdt12e2ZCTI4Qo81wWI1tCCP6jUdZkGjLPQ50P
         C2QGEB9K3G/dqaRMfDNWxuHMFPrymb3R5agvF0Agm+VQuOdUfUNHoEj/9ksEQ9gUlLxo
         gzqwva0Zs4/SDsB2Rmj4itCDw/94E8QchLWRxf8WuPigcg2aybGDW82RNXqaWGSTHjDk
         n8qThSPy6zFIN95KirHptSJJ8TZgWB1sm61UPdbxfwz5KxBBZLhuMi4nL8GQ5ebHturv
         M2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOmLbFg4f7m0VWnyO1xDaH/AZNMu+kPMNjgBVvsbMM4=;
        b=QkMrrAjoncvV+Ox4Dj9AUMrTCSrbLaGCpc09/mL9pSPSRFieQQfxLhikWePJnD8Umm
         JNnKynkKbBFRH2e0J+dJQFVSfeGIFwt/maFv9VzSUZciVs4ymP+cnRjs8X1JZMj7fQoW
         MI1ftt76klu7IwdkgPD+yIx2xaBrqLL9CNiBur4nXHXzV0drKNnEmefvnbnc4ee0dHiB
         AFbqb3vCbOCK82FvYhVbYiukeFJoUzMNHHT1ZPUwwMheY2tqVF2yKpjn3/5brMdJbj+5
         8qDWmMe6uV5zboEEbQLUhi8sxbX8gTOsOIUTHI5Z7akJdyDVR7SEUdbwWS11u4dsadFs
         +lrA==
X-Gm-Message-State: ANhLgQ1q7xcg5PQ1aSDY1iUbaINUOfxrBwXd0PWtl0Hm9m8Myulz+8n9
        xAujmGej+lPcTWQESskFnmuCqw==
X-Google-Smtp-Source: ADFU+vt0BFBJbAznVQSE1PNl5MnrDZymFS2judAVRaRDmr4mbgXWDTWu7QcpSCh+5klHcSq6m8dkfw==
X-Received: by 2002:a2e:8654:: with SMTP id i20mr12334652ljj.248.1583836829816;
        Tue, 10 Mar 2020 03:40:29 -0700 (PDT)
Received: from uffe-XPS13.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j6sm3414632lfb.13.2020.03.10.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 03:40:28 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH v3 1/2] PM / Domains: Allow no domain-idle-states DT property in genpd when parsing
Date:   Tue, 10 Mar 2020 11:40:23 +0100
Message-Id: <20200310104023.4018-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0002-cpuidle-psci-Split-psci_dt_cpu_init_idle.patch>
References: <0002-cpuidle-psci-Split-psci_dt_cpu_init_idle.patch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 2c361684803e ("PM / Domains: Don't treat zero found compatible idle
states as an error"), moved of_genpd_parse_idle_states() towards allowing
none compatible idle state to be found for the device node, rather than
returning an error code.

However, it didn't consider that the "domain-idle-states" DT property may
be missing as it's optional, which makes of_count_phandle_with_args() to
return -ENOENT. Let's fix this to make the behaviour consistent.

Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Fixes: 2c361684803e ("PM / Domains: Don't treat zero found compatible idle states as an error")
Cc: <stable@vger.kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Resending with reviewed-tags added.

---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 959d6d5eb000..0a01df608849 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2653,7 +2653,7 @@ static int genpd_iterate_idle_states(struct device_node *dn,
 
 	ret = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
 	if (ret <= 0)
-		return ret;
+		return ret == -ENOENT ? 0 : ret;
 
 	/* Loop over the phandles until all the requested entry is found */
 	of_for_each_phandle(&it, ret, dn, "domain-idle-states", NULL, 0) {
-- 
2.20.1

