Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B503316B443
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBXWmr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:42:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgBXWmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so11914164ljc.8;
        Mon, 24 Feb 2020 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rz2ISugkt7qveQ6HpbfJWAvvkJeXQ6y9RjeXhO+Pnyg=;
        b=O3JG2c9xM2ocaKkGzFJG3skCViMAqMJRq3IKFyHt+CR6iNLywRxq6LFVtUud/gj7YQ
         ZtM9Lvavxzp8mbE2vYmDE18bqHoRMa7m4qPv8m0o+LxEUfrp2EFBqTdz1Whn8MPJiSFg
         12hok+UlvPItpfDaogmxy/s+Hw1DB39YDapiHcp+LFyzeG6HoBEtiL5TRA8flYWo7Wlm
         Imyi2xTVtlNoXUqQZBrDmI/xbSP2wFvdXQxYcGNd2AS+e+jVkncjTkllkyHyXSDTesyq
         CnniWdv0T00vdQqXlPj+rQcq1Ii10M+O7AKongCK0kLrZ4S3i0/wNYM3dbPSuXRQ5oom
         7AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rz2ISugkt7qveQ6HpbfJWAvvkJeXQ6y9RjeXhO+Pnyg=;
        b=ckALeDfcU93Xip43tWlaVzZDZ9VB4FJQaJyLEaBg0EZ1wEgqNMPPCCL3TbrnaHU569
         dCsfYav4eqGMKQNN6uIytMJImHy2whBGmFk/5IHzfHVm+Qv/tegdzokXRE5r+J4pX4Ua
         m4PF215iJHXptP7XnM4iZB8tJug941/NBvv/jwtYq2B2EY0RWDdvyiUhwZEfF47Jkxps
         lM9jw5LCqxVspWxepjbaDSgpK6MnTeyHFXVNi9wQxoqY9dMHvko1q/yOUPkusYc+xzWa
         r+eMNgdbe3sFBVfIPT3UGgPwPUY/h2N5IezumbwA9Cj9WWZNvAEOSO4GxM2X0cWEr5kE
         w6XA==
X-Gm-Message-State: APjAAAXyOFNOGCYdJ9OKYJD25VVpwmu0wPQ0FaiU1qs84hzggALQVDdi
        cACk1NQBP6VYp+qRp+gpcQk=
X-Google-Smtp-Source: APXvYqyyxdVNN+cpXo0lxx6Ost1gzNW7pM+3kRKuGG1aWoUBEK2F1NAcsZDmiVxl70vODLXEP3yjKA==
X-Received: by 2002:a05:651c:d4:: with SMTP id 20mr31018523ljr.269.1582584164716;
        Mon, 24 Feb 2020 14:42:44 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 10/17] arm: tegra20: cpuidle: Make abort_flag atomic
Date:   Tue, 25 Feb 2020 01:40:50 +0300
Message-Id: <20200224224057.21877-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace memory accessors with atomic API just to make code consistent
with the abort_barrier. The new variant may be even more correct now since
atomic_read() will prevent compiler from generating wrong things like
carrying abort_flag value in a register instead of re-fetching it from
memory.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 40566da25c6c..8cdffdf7acd7 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -32,7 +32,7 @@
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
-static bool abort_flag;
+static atomic_t abort_flag;
 static atomic_t abort_barrier;
 static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
@@ -171,13 +171,14 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 	bool entered_lp2 = false;
 
 	if (tegra_pending_sgi())
-		WRITE_ONCE(abort_flag, true);
+		atomic_set(&abort_flag, 1);
 
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 
-	if (abort_flag) {
+	if (atomic_read(&abort_flag)) {
 		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-		abort_flag = false;	/* clean flag for next coming */
+		/* clean flag for next coming */
+		atomic_set(&abort_flag, 0);
 		return -EINTR;
 	}
 
-- 
2.24.0

