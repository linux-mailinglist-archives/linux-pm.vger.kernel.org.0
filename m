Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7271717C2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 13:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgB0MqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 07:46:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38993 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgB0MqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 07:46:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id n30so1985452lfh.6
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 04:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NROpLkqIKQsmOxVfnI3TCB5D/se19mcdjX7Jsvn77Ws=;
        b=zJlxUbiYhFoF+ODVDIvKjAu386tBZM5zdC9FOjCrrAN13EelHbSprIimZNdA9DUoAV
         HkDCSE3OSDzA5dNryQ2b9btHIUkJRTlRng1zEMwkc+XwCHscftdZISwd1pqrl+BwtHqv
         GlD8ZaB9R1oX1MDCPKIlITtO4YG6dJh7RZZAOXumSZkEOwCp3JhVK/bpllsEEQrzn8k2
         o/gU2N6cqqB7dbSwPiqnkijOTNTasogux6I/C8ZWBKKFy9gM8lmYh4TTcTBQQJ/CxsrM
         XWv6ndjECgFxLLJ/1x/6NU6gCzaV5JEcxLS17mV1i0dmQtSDVdQQ9/QeAcybUpkrhOLN
         /DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NROpLkqIKQsmOxVfnI3TCB5D/se19mcdjX7Jsvn77Ws=;
        b=hl5LLZMDlh3LkoEJBF3wLK6HyaAQ9cVbc4sVPuFmppT75RBloOvjsklZKllzvBL/1s
         SyyuX6nAmPo5GlvlQFtpRciYYh3ayxhfJrOUdBlrF+xXA15vJoXRDAde8GUDHeVOSMV1
         MzzgyQULp8ybfqpwCIDjKmuk8RAdV96o/5JbCOjn43tkCHdF424XgrbrVodRdOdJa+Ef
         b5pHX1fpEMrnKUMEPS+fSeh5SjVAeeYKiuyylhD5eh88DuHOux5f5eveZ2w/MfDv2/iD
         3V2OPyL0f8HyUnFMTzH1gkRnlEaufN3P+eciCokWsXEydk+TmIZj3FMoiXo90nr5Cmdz
         Ulgg==
X-Gm-Message-State: ANhLgQ3BRjHTf7ghvw6T7JJL5jwG580YZBMX7JyYF7U2BIrterxuFs/j
        IC1hhnjY+KFS4pNX1Xa5nQISFil1jIQ=
X-Google-Smtp-Source: ADFU+vu8QOXDccJ4lKeIOMwWimtNYjnsyBTcgqPyMEimE4UADfTmMgToy/05O3pHPo7qI+ThXa9XeA==
X-Received: by 2002:ac2:4a66:: with SMTP id q6mr2085068lfp.16.1582807579162;
        Thu, 27 Feb 2020 04:46:19 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l16sm2669334lfh.74.2020.02.27.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:46:17 -0800 (PST)
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
Subject: [PATCH 2/4] cpuidle: psci: Fixup support for domain idle states being zero
Date:   Thu, 27 Feb 2020 13:45:49 +0100
Message-Id: <20200227124551.31860-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227124551.31860-1-ulf.hansson@linaro.org>
References: <20200227124551.31860-1-ulf.hansson@linaro.org>
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

