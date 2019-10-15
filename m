Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778DBD7CBF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbfJORBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42139 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388503AbfJORBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so15062344lfg.9;
        Tue, 15 Oct 2019 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Omi0XtqN8Kc5VZbYU+UoqGDpANl8X11C5I6N+y6qX+s=;
        b=Mo4SxdTQu5aZ5xPEC6HrNLXPT2lhQgbDswpxq6q51db6RbKUyCiGOY0GfU0NKCskMy
         CF5aDRuUqQ+LKizZv0yLHdtvUZ4+edLb6+WBN76r2oecSd1rxRnuDD7GVhjwhEZeu2Gn
         PHVMpbsM5ntAEAoy7ZNa9c67PV9g2vsS+u7jIBlUqlSUdO5cVJENE3HOX1MfUly8SQiG
         tG8Ksz4GNX5Wm4dKgIRj2I0d/beDsUAuEea2qSDQrmFKvd4RwsQFhPzSkYCM+ZDMpu7n
         vBfgc1jqVwRkPJPpZMq9AXU1FXzCennoYtltVP25jDcu9Mv8flDPy493sz2QQ1kEWK/Z
         5s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Omi0XtqN8Kc5VZbYU+UoqGDpANl8X11C5I6N+y6qX+s=;
        b=jOG6i5AynHRToSS3FJcdzfjAwJY4HkQIQAqbNmk4IvlSTvaGZNqpuXFJnvzZuVhV7i
         qFMBuDe11fIuaYwXVZ2F6H0hFpEWZ/Wkoc5AmG5ixv1tKwtZZSeC0D/4NLJSbmCDrmM4
         i3B9LMd5VMCPwW4PSTHAA2ie2gvDvRp0VMNb2kQ0lhay0zCqgWS1vxi2I3c1i/O47Iq/
         Z/TdDOSRby+2bTAgBc+Pb/ySAtuIUhHS6PXtSCM0KSnDJ0p6dNs9Fu/e5rgOPsN4oBjV
         RHoKJVLmgCFEz3nkEtulbcnZ0DI2wjSucALhtSNY12vYLQCkz8YLXfiFpqEqlT+Q6SvJ
         KuiQ==
X-Gm-Message-State: APjAAAV/BH33gX15EF70L4U9O1cgJ14wviP0SJ+FN5jZ5pVy+bcwW2n+
        KlP8bBu+U4aAND643MT4Mpk=
X-Google-Smtp-Source: APXvYqzwopfSYJZIWLREJUlXfvyJhS8zttW57hQ82Sj+eXZJE2pnYU5hBddOMCd7TKM/lOIvK2JGTg==
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr19924709lfq.72.1571158910329;
        Tue, 15 Oct 2019 10:01:50 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/18] arm: tegra20: cpuidle: Make abort_flag atomic
Date:   Tue, 15 Oct 2019 20:00:08 +0300
Message-Id: <20191015170015.1135-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index bc5873e92af5..fe80f1988120 100644
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
@@ -167,13 +167,14 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
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
2.23.0

