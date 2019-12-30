Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313D812D0FB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfL3OoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37931 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfL3OoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so11531866ljh.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8v5xuPr2EJ9DSJyEgwYWHNaPW3NhmJIKXs9ahA/QI14=;
        b=gaWhEs8bCTWDjEkiGpFUqwqn0GmNDQFWOkn0x0TuUvrI5mbmBk//3DIZtLQXKs5geY
         qZOvtle3WhKIeLFP4Jf/SaYuFwlcYSLHPyMWs99zDm1lmL1hR/5wxeqoI69Ti0korIh5
         PmfFnwSLudQzFF1yugoRk7BpHN/tfDHzC9mmEwDiapNhF41HUTHdedRqODqM7S96A6uG
         bt7yFtA39kFLXZA+CCjihGvjyrxenBf/EJsQG9XvkaoZqTB4ZRdiGl0cms+egMgnp6W9
         3zvKcfSuVKP3GLgFldKd0Ef/fh2TRxoLjaDsk8sD4a993+4iZ9mAKuW783awGHt96mi7
         Mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8v5xuPr2EJ9DSJyEgwYWHNaPW3NhmJIKXs9ahA/QI14=;
        b=qe6iH6Wuqyj0nR87QCQa8LDk91eLuNPcIRNCax4ESFhPSk03/YgHBykG09Xjjrytbo
         mJ1d74tvUR9KRRbt23/2A5YfjGR0dQ3TaaF8ZTlhSVvQTS7PjmNf/dghj0oJl8vQMmlo
         ZuCqsSxJr+aTqKhu7rq0wPgq+7hnRmUspkTRH6kSGcMVAnPEzK9IALT3BfCvee3HgldL
         WjjoNqE1yViuJ8nVsQItUrruHuW3Cier2+hGqc1x0/r1tI4R0YtRDZ8Zce8bW5umrqG+
         YcJUrhDgGTLLCPL49p+f+zsCG6CojKV49nA/4mK4YSyUWJA6kdH9mEs8BnhRQRxE+JYp
         RGZg==
X-Gm-Message-State: APjAAAWcJeGaM/xrrEHiuoT02C/T4cjtOaHx0roDczkXV+PqitgHtRry
        5bvwFKbsmvgyBsYAkx8PYesdSg==
X-Google-Smtp-Source: APXvYqy2psF+SHAkdnmFnQHEnt8nfdz54W8h3uR+uQcrYtNUivkQ5xNld+aRPQg4nCP0yfXDA3vZcA==
X-Received: by 2002:a2e:b1c3:: with SMTP id e3mr38270940lja.137.1577717060097;
        Mon, 30 Dec 2019 06:44:20 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:19 -0800 (PST)
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
Subject: [PATCH v5 07/15] cpuidle: psci: Support hierarchical CPU idle states
Date:   Mon, 30 Dec 2019 15:43:54 +0100
Message-Id: <20191230144402.30195-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
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

Changes in v5:
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

