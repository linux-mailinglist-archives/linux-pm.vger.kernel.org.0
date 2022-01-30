Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71484A39A4
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 22:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356376AbiA3VCZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 16:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356380AbiA3VCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 16:02:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A03C06173B
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n8so8851542wmk.3
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cWPqnuW+Zg66Vr4iSn8qLu3H5+h06l8a0hGtLAknWg=;
        b=cZHZhTccn2hbg7ktHjSg0CRhqTvQxcDiHYXdlm01ktRZK8oCI1whTseKVOZOoR4Ihh
         dV1GSFlK5GzLq5dS7UlrCW9X/hpdVjSYzQi9mvSrwJQ+82KfpcY5z2X12VSEBc8vcDD9
         mhXmdAg39mrkV6G/b3Sy1eosrkLL8iduggMPakIdbFvSuvU39x+wauek4P7KYKkcxizk
         SyyFFnInW5uXarWujd+Fg+eR99Vv0CyDYDgmHKjyC1kU0qPFkFn8d0OtJtHnpTiwuU6u
         solUKUvj2FipgkX3A1MfRxHbjuDPo0v3GgbL5N3MociQ75/lRCyhwc6Zwb334j5OmogE
         Yp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cWPqnuW+Zg66Vr4iSn8qLu3H5+h06l8a0hGtLAknWg=;
        b=lvdx6rgVHc9kIvzwoPL7NwgQPJRn1nOvcdLgQSzWgcX6zNqducRbF6zT3qmTAv5t0S
         oFlfifOMlC2Y7ft0uVyD+qVnQvCFGWCrhgKzwppioyOHZT6cNckGZxnpQy1oercF1+hU
         SA0IBZH2Z2Td7f4fPwgipS70XfNsN2Uu2RkrFi4L/MbSWZ7ZtUkhb7Xnrbjkv/7KEv05
         x1mXIScOn1HNlXWN+HM6PfVt6sYIuLxpwXOrFVVjSJorCZx6jbYU77y4Sy2yQzaf002N
         GIBWdQvkcBxc9x/BLYHOmwW09kTWhY7C1e6ZDACasrvX6W5jDpxxB1oNtP+AMB1BpMN4
         z89w==
X-Gm-Message-State: AOAM531Bn0PUGUE49bLVn9PeY+0bWKhTJZG5vwxSHSMHG7Hk4fX3GKZw
        +ujUxYw9KRJtwpTQLt3MD0jJ3A==
X-Google-Smtp-Source: ABdhPJzwUtuKgb1uWNz9UUnzE+Fi7SoOUIyGplaM3rWp/eKpXB/QwTP2IUG3LBsNy98m1QCKnIS43w==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr24622958wmm.102.1643576542485;
        Sun, 30 Jan 2022 13:02:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 6/7] powercap/dtpm/dtpm_cpu: Add exit function
Date:   Sun, 30 Jan 2022 22:02:08 +0100
Message-Id: <20220130210210.549877-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that we can destroy the hierarchy, the code must remove what it
had put in place at the creation. In our case, the cpu hotplug
callbacks.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 71f45d2f5a60..bca2f912d349 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -299,8 +299,15 @@ static int dtpm_cpu_init(void)
 	return 0;
 }
 
+static void dtpm_cpu_exit(void)
+{
+	cpuhp_remove_state_nocalls(CPUHP_AP_ONLINE_DYN);
+	cpuhp_remove_state_nocalls(CPUHP_AP_DTPM_CPU_DEAD);
+}
+
 struct dtpm_subsys_ops dtpm_cpu_ops = {
 	.name = KBUILD_MODNAME,
 	.init = dtpm_cpu_init,
+	.exit = dtpm_cpu_exit,
 	.setup = dtpm_cpu_setup,
 };
-- 
2.25.1

