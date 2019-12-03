Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34110F403
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLCAmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44278 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLCAmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19so1630377lji.11;
        Mon, 02 Dec 2019 16:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YS3LdxKq5b+UqxDE8Gb+7FH4eIFw8irwS8Dbd5Tpsrs=;
        b=emlsPJmRNGBdEP0DCWBUFtAq+/fSqOcidcQY5LOBKTpTine1WweRJKkNhZ7JLXNwcW
         aATS6UgvXwl2a7QD8OAPMJFFvZbksjOtPzVZfA9RSPsEKOx2OU9g05eTjC00gGIQJGhG
         VCYXkVwaB41Y58vYYp5mNLz67XQCvCge0EhbcYGLD5FjylEMqIzw+ZQ/FvhhWymVT/wh
         U/rr1xKlgi2BAHQ2Nhxx2ovrGSpy2l///42f2z9RY0L0Zz5DDsjer31krm3U3xQXUpIy
         lsyuZml2QdaEHpRhPzFlgy8gd/rBD+UuplsrkB4lg2+M+BJHH/ipTzwLSymSUynPUf4e
         X+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YS3LdxKq5b+UqxDE8Gb+7FH4eIFw8irwS8Dbd5Tpsrs=;
        b=DtwJ3QRzxk4yZ7exeIKzowXAfpmnncFqheAaVe3XMiZNfjb2a+EI36vtOjtaupKUtJ
         3PDbvpv4ySgpXtQgFkGk/bHpkCFTvAcQoaZX4DiuBhULtPY/21tF6TAKN4CaswzcL5eb
         0d1IT6GHpLzIXDXpdBHa1NtgOGjRlO1bnUxs3CEc+CjeX6N0RyOowdfIyfAsDxUBSDU6
         cIok6bpmavcQt50Qp2uH2WYF8lbxx+W6UUMzyf+kWf4xHYeD8m6wuY6I5GMJ2MMBoxt4
         j11256DRIokSrI9/fimRfQXApps0nUuvx9eQR865a405EM+RUeviVxF6aqmJJCofgyPT
         qhVw==
X-Gm-Message-State: APjAAAUvLBywoPSLgVAQCA/qD0kvKIeGL2LCOP2ZYkaWtGON9K5THY1F
        pecTH00OAemZijUXq9MP1UFf7eHb
X-Google-Smtp-Source: APXvYqyQBFgbeWgxsgFsudpDoLp6B5xeUCyg5Ux6CKxPw4eh2/mETwgXCa8JT67u+dnewwAbofeSqw==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr826153ljl.65.1575333731754;
        Mon, 02 Dec 2019 16:42:11 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/19] arm: tegra20: cpuidle: Make abort_flag atomic
Date:   Tue,  3 Dec 2019 03:41:07 +0300
Message-Id: <20191203004116.11771-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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
index f3a898f69a1d..3f4c75dbb4aa 100644
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
2.24.0

