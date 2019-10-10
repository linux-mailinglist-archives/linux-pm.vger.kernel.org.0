Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121C0D2825
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfJJLkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46252 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732792AbfJJLkS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id d1so5795195ljl.13
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nvXOpVcM/IpothdU1ZKoTmNHFS7WJStir72tye3UWWE=;
        b=EUAy07fBsO1Wz5z3ljchfWd2sfdTxk2utOmWleJB60APniuQ0U3RAzfQdhfU/BWbU3
         /PpxRmMYJ+bhc8H7y4zsGtOLcdqr9mF9vHT+BAF1w2huN0P/nPF6ZTE794efcWFcaxrq
         82N6hkfxHfNP9zDCtgRDb7F7P1918eEHfSkhI8PK4xqSZVgc88lGjJ53etEeAcHIcwMP
         ytQqCscNLLgc+xJioNh+2NOpa9q7QFuCq+3m59fEwdALI0MT6g8ITkIlJ/WS9+aWE+B4
         Z0vwxgptGD1RDuLRlsFVMW4k0nYmjTmLaNA4g29yjtIoKOgj6OhnsLkPjHkVD+6KZGZ4
         qDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nvXOpVcM/IpothdU1ZKoTmNHFS7WJStir72tye3UWWE=;
        b=bOeacgvFu41cAIQpM3SLEwE9UXuQ8lXUlM3aGyBs13bUih5DKh4yAXeHtzou+Dn+Vc
         qqSjEc3nAiZJC7rYeeu76KHlDyEgRzFNV7tQopQ9jlZZxss3XHVLe67+kH4cj+QeZUDD
         1qVk+qb1ZChyFhicc191HqqFQfYp7AJNiMwFarZ0FtAQamCatzFR/Lx/jcUhQHjd58Tr
         vi9LDtrCzmbbVTogXW2oxHDv8i8mGEcv6K05u4ogZk5CWmYDpIbG/j7sEWyLV5m2WiGD
         7w20wvBWtKGJ2RpmKyB8D1o5oAOaagWVyofCj2TfVp9+EWtJKorOG1kTUES4Vua2zura
         g4fg==
X-Gm-Message-State: APjAAAVTDn3VScDyPY/ZTMqih+IjgzEgVZ2WAzfXUw1aCsMAM2juonzb
        GWE/Ea+tg8BaseCiWTERzy3pYQ==
X-Google-Smtp-Source: APXvYqxUdEhaIFvRKswg87UCzDQiM72AeRacZpBqrmORob2xGUbd6DLiJRFX4z5exUT/BNmXNpFbgQ==
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr5832114ljk.65.1570707616291;
        Thu, 10 Oct 2019 04:40:16 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:15 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 07/13] cpuidle: psci: Support hierarchical CPU idle states
Date:   Thu, 10 Oct 2019 13:39:31 +0200
Message-Id: <20191010113937.15962-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently CPU's idle states are represented using the flattened model.
Let's add support for the hierarchical layout, via converting to use
of_get_cpu_state_node().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 1195a1056139..5c30f23a8a7b 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -85,7 +85,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 		return -ENOMEM;
 
 	for (i = 0; i < state_nodes; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.17.1

