Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5651E8D08
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbfJ2Qo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:44:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33914 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390481AbfJ2Qo5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:44:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so15865147ljf.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+efRcFDZJGrl94RZ1Pp04/eQynZO0t/87C0fALcC2Y=;
        b=DcR31P7QEhii748OfmlKLxnlgK2iGESy78LkihiAPNRBd1n02OkEbkB6oINN4qv153
         TZWIg25uFuJM/ImzEcip1z0+uOBlD2R+kFXXfQp/SHkbrUMWd/e2Zl/onpraTJWE9Ls8
         H2Q9VbbXEQZz/wZM7bMZZ8CQwqUSanG0Z8YL+jNcr553bfPAYUvitL4zl1S/7q2X6LJe
         KOSHCLV4B3XmapDudWjAZFt/kvcUofPfUHzDgFCkZu3gUi4zNcJ3wmT9EKsY1DhYkA/N
         dclq1M2EoW6vIFjlfsLh1UBG50Wbt0ZgUhFXluw/poNqBez/Afa9SFciz0phawg+sdlH
         Xmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+efRcFDZJGrl94RZ1Pp04/eQynZO0t/87C0fALcC2Y=;
        b=skIsKqdT8bkPKiCctIqfV0pl/FwTNqUWOkAnduVKK570LVNSSJ7ALmgf92FWg7UH1Y
         gB438gmAnNNVId3QcKu6ILyirp2WiNxGioJ9vF7Ebkqz9pHcmV2CoDQbdvuPfGkzfviO
         APRnK3vdC7gNSXhaReKV1POTZAaPSb3FXyCYwZTlUszFpiik4Y2IbCQmraoovVvI9P4O
         Ea9liceT06zV0mLYbwbxJ/e4YgA/PqOwzwD/tYyJOy/9htkIIvGxvZqWz2Yx1SqdqF9f
         GyihATuRmsV0ANXoLqtqrlv65mmUyc+bY6Gbw+NDDavYjafzelaA4yygJ8n0IOzubG9g
         lZvw==
X-Gm-Message-State: APjAAAXqoLNQXqXig1DtEA8MyTeq8vmrH6U1XODio8XBK46mo0jmZU1Y
        DbJ+SeI6+zeR8OAUexPRuFlsRQ==
X-Google-Smtp-Source: APXvYqzCWSq8jiTn+Qd/Sc5a5w9kGIAL/amfp/ZQemIsHNKP8bf8axa786VJsKcOJkE8woFSWOWH7w==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr3274465lji.171.1572367495410;
        Tue, 29 Oct 2019 09:44:55 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:44:54 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 07/13] cpuidle: psci: Support hierarchical CPU idle states
Date:   Tue, 29 Oct 2019 17:44:32 +0100
Message-Id: <20191029164438.17012-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Added tags.

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

