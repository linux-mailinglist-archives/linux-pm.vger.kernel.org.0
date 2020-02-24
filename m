Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CA516B45E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBXWnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46813 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgBXWms (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id u2so5355700lfk.13;
        Mon, 24 Feb 2020 14:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRfDY6o3JLtgU0E8AhwXsc4tadD+Z274NBI7QDEmKc0=;
        b=l0bwjGD5lP1/kKdENiUvJpnEe46PGmODo54ldG8Nn/hn5AqZ0QZsaFHVGdFuw0W3ga
         dYKPi0HoCKLSZp8D37kDa+TeuSAWjMhrLSiQ8nhJ7NEIzdE/2PIcKou04mnPE18MYrTk
         iVUNcWGLpVcRaatDmYiWRW3oK8DPn/AYbH52fPAQtmShrgCfXoxlsUWXgGTbSybtG65y
         fnFkmOAsTv6uQ/mB317SKgrFKSqvnt7d3zwJv47YyU2eTp4u79coppYiagOZmoS9JJyp
         8Yv6lB+Yo30rKD8UrZrjsGZqlwFN+QJoyyKSrIHjovh3GNnzW86SMRHvSKeYomOtEtCT
         KLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRfDY6o3JLtgU0E8AhwXsc4tadD+Z274NBI7QDEmKc0=;
        b=fK7PGnK4hernRuVGq57/wgv/N+y12kLRqcuoUw6T7Q9XyF2grLwXvESHfMY/MSKbLo
         hAAUv2oY3ZD1hjXTSRqRpCL9GtwJB5lJ3dDyImPJWhnn6xVRhvmvYxn2kk52F4bPj5Ds
         VO8cS407SB4i7lF5drl7/sdrbmtm5KHuoze7Kuj8dzDIHGUvv7ukjNYi4JfsSb9tPiLi
         MX04GdHeJ9a79499wHQ1ClWQBd3iBBr0KRuc3ky6MYy4/olMwhiegnInZ6QdwXATOYx5
         r1D64HpAlv2GUdXiFxejiLSTpVU4SekJRayNROY72yhnbwcfzag3k2FjKJyd0vj426r+
         YlrQ==
X-Gm-Message-State: APjAAAW+ZymS4FCmYXHI3G66x1anwd7bAFLgRo0w2YUl7v1CULeRGu4W
        Utg4nqB2vzEMC3TLPfGYQPA=
X-Google-Smtp-Source: APXvYqyiEo42FEGINsJwrlFM47li49pvziubmyXDSxiDbXkU50bgs4t6+l4qei0sFjfyNOhLuJoPrA==
X-Received: by 2002:ac2:53b3:: with SMTP id j19mr15273156lfh.127.1582584165819;
        Mon, 24 Feb 2020 14:42:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:45 -0800 (PST)
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
Subject: [PATCH v11 11/17] arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
Date:   Tue, 25 Feb 2020 01:40:51 +0300
Message-Id: <20200224224057.21877-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no good justification for smp_rmb() after returning from LP2
because there are no memory operations that require SMP synchronization.
Thus remove the confusing barrier.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 2 --
 arch/arm/mach-tegra/cpuidle-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 8cdffdf7acd7..6db380515a6a 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -197,8 +197,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 	local_fiq_enable();
 
-	smp_rmb();
-
 	return entered_lp2 ? index : 0;
 }
 #endif
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index a4f0add46a27..80ae64bcdf50 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -113,8 +113,6 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 
 	local_fiq_enable();
 
-	smp_rmb();
-
 	return (entered_lp2) ? index : 0;
 }
 #endif
-- 
2.24.0

