Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6610ADA6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfK0K3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33828 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfK0K3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so16480579ljc.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCpbFgjGEgfPklFZJxNcT3sX+taTfAQr4roju7E3lrg=;
        b=F6S0qqMGVu24iWB5xlEUSenjorh1CqR7WhxPvplxFREi9q67F98DX7cpAJ0g1E3MEG
         x2OgkDcfshrPloOeK6km8it8DJciTEPHEKCPWYCEJgDI7fd8OhHudj7Wu4ZThoWMAjk0
         +BSufJfudRGkRs8vxAs1hjbf7XsUFeSbpJgvCwtyxAqe7ZboPbj8K6QqqZk4aNFAlxqD
         EFrKZ7dQwLv6pcbRk/6RXsBH9zT557UEKXxHVX4LXIY7NnK/eZmRJb9qIPgKCwiG8uko
         Oov56PJE88Y/KVECS1Wbg9wwXvvSPUJYZFt8UZ7ui5CX2WJsFUq0pdp0NFWzt5/TUmOW
         ZaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCpbFgjGEgfPklFZJxNcT3sX+taTfAQr4roju7E3lrg=;
        b=SzQbLS6nKMxOx95drPWbPhU+Gj5lgzFbOGTIQKKPBepcWpm6NauKqVjHp6MQbcehtr
         RQHD2km2Ptm2lxbY1h7MG9mANjpjd7eOtuHmrq+TlASf8suO88fTwFhVGHqFNNTd0hdI
         LMeI1odMz0CJwARdvLLw31xP7pMMho/tZg6s8+otUxzjZytQ9fPf2zWP/WH1F4wtPkEK
         2fdxtTZKuGm3EJkui1suB5LB8QunP71TS8EPbTXxrhG5XrrlN3pcXX3q7g83I1wMnaXZ
         G+Z3vDrjs4dv+31izCJBxN+DyKG6zhM9DnWHeB7BMX8CoK3ACOaT2F/PY4JVc2Zxj3AY
         nPvg==
X-Gm-Message-State: APjAAAWZqg77HBEsG2zIm0yGjdgwH0FDfbgcbw6hDQmb3/NaoxYocVzh
        rr4buNMXQNZiirfGH/bTFmj9jw==
X-Google-Smtp-Source: APXvYqzTXEyPT0SJHyyvevP9BWE50w3KY6/GovtjKu17I96JMN6sVEEIl4LfjTP/gkozAdXLVnmHfw==
X-Received: by 2002:a2e:9083:: with SMTP id l3mr31130772ljg.127.1574850568391;
        Wed, 27 Nov 2019 02:29:28 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:27 -0800 (PST)
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
Subject: [PATCH v3 07/13] cpuidle: psci: Support hierarchical CPU idle states
Date:   Wed, 27 Nov 2019 11:29:08 +0100
Message-Id: <20191127102914.18729-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
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

Changes in v3:
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

