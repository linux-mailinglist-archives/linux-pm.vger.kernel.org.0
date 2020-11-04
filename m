Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C752A64F7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 14:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgKDNVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 08:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgKDNVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 08:21:43 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40AAC061A4A;
        Wed,  4 Nov 2020 05:21:42 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so27116526lfq.2;
        Wed, 04 Nov 2020 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dJEn2vpD69Y57Q7MWBkxBmWLGesZqBQ4JbwthL3OFU=;
        b=eUqWxOxGe6yzmP3hZAm/EYsVFmmG3wUFYj2lr9Frww5hno5omFxAp4fj2ETrPDkFfz
         RzfbdMrZiJ0yD1SSbSkpkJ3aquY9UkLex8Wnjrt4f5MWsgMjraH8GjD8eBf68qjrF1o6
         bbZMkEcZGfPh/dXx/DxklM+xbzgfj0d9PTNjUbCyJOSVC6+f6f1TtWbIaIZfSLVxrXeU
         tQwdTOUVjvGZTIz0IxxRnP62DBA7H1lrGBwayji4EDJDZvZ3itVVpKvYN7CIPKR3LFj4
         /4eXIrq1EGpHKzTOuSpQ2ZpPZqe0X/XqO5O3GIbYnhRaB6I3WwYlWelrLZyFb1pZq3Zc
         XOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dJEn2vpD69Y57Q7MWBkxBmWLGesZqBQ4JbwthL3OFU=;
        b=nlAgt78GH0/6skY+cEltbB1LmUJl+P+iE1RuljP57Z2dQUeY4Cvai7ezYSNDboCi+P
         k1FkjTZtebnKKj1Z6T4tmxmeZlssupgarWQH0R4N4P9Xz5u+heYnIDYqImJetmX8Oztq
         duDTpqO7sa7lsSvHa47nAsl1LByEVTGvU45N/tuTFZY+oUWKNX5QUymJHLU89ZzB6Ywj
         mOpNm9MO+yMKlD6GGYeqKv9EXO8KZ+Lgpzb2a0pcv56NiVsHU4chdqP0aFrw7nQ15kgy
         fuRBbyTxl84dweTUKOX437vPojYNETLp8fabIU5ge2MeJqgHKInMV6/ofVEN73Stml20
         5r4g==
X-Gm-Message-State: AOAM531MuC4bsM5o3Ybk5CE5QrAv3EkK4Q8aFrYDSzDEYr9t54aH5zKB
        QFhJFgpfkphBm5DoaL5UN+U=
X-Google-Smtp-Source: ABdhPJxP9N/4DWCr5MV0Dh7G5j4JYZDoRQ2qpZbqtET4FjJqEKaSfpXaxRf488sWyTpMYaSkt5b5WA==
X-Received: by 2002:a19:2391:: with SMTP id j139mr7798731lfj.339.1604496101285;
        Wed, 04 Nov 2020 05:21:41 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id a19sm512975ljb.97.2020.11.04.05.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 05:21:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1] cpuidle: tegra: Annotate tegra_pm_set_cpu_in_lp2() with RCU_NONIDLE
Date:   Wed,  4 Nov 2020 16:21:26 +0300
Message-Id: <20201104132126.15943-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Annotate tegra_pm_set[clear]_cpu_in_lp2() with RCU_NONIDLE in order to
fix lockdep warning about suspicious RCU usage of a spinlock during late
idling phase.

 WARNING: suspicious RCU usage
 ...
 include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
 ...
  (dump_stack) from (lock_acquire)
  (lock_acquire) from (_raw_spin_lock)
  (_raw_spin_lock) from (tegra_pm_set_cpu_in_lp2)
  (tegra_pm_set_cpu_in_lp2) from (tegra_cpuidle_enter)
  (tegra_cpuidle_enter) from (cpuidle_enter_state)
  (cpuidle_enter_state) from (cpuidle_enter_state_coupled)
  (cpuidle_enter_state_coupled) from (cpuidle_enter)
  (cpuidle_enter) from (do_idle)
 ...

Tested-by: Peter Geis <pgwipeout@gmail.com>
Reported-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index e8956706a291..191966dc8d02 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -189,7 +189,7 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	}
 
 	local_fiq_disable();
-	tegra_pm_set_cpu_in_lp2();
+	RCU_NONIDLE(tegra_pm_set_cpu_in_lp2());
 	cpu_pm_enter();
 
 	switch (index) {
@@ -207,7 +207,7 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	}
 
 	cpu_pm_exit();
-	tegra_pm_clear_cpu_in_lp2();
+	RCU_NONIDLE(tegra_pm_clear_cpu_in_lp2());
 	local_fiq_enable();
 
 	return err ?: index;
-- 
2.27.0

