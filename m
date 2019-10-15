Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55080D7CA8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfJORBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35583 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfJORBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so21041543lji.2;
        Tue, 15 Oct 2019 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0El1r5sR/3XS90TExiIvdI2lmehipmygt0wHnvPAxUQ=;
        b=F52AQVkzmm6cIIRIypc9mBwhZ7fvyTDY7hcqPeur1+oEE3ovBfJU1MvsVBIWxL22Ee
         Qh2JXMr5LuNmYxVkcYFi7OpDcve1+wOQwswv1hY+akPnalpDaUUmm6Ym7qlHQXN7Teot
         SA2fem0EyOAFSHJ9991h6xHNubcbb+KUT55JgqsoeP9+hTSnU8dI9KsiC6Z3G0akg5Fi
         dNXRqA23sbJ4K79BX68XQlCJPSbcTKqQ/lmfULmG5J7Eqnhs0hWveC+vTp6nN9IwKsbb
         ugMhT3KBW9jnvPBNGWlat46n2YDnQcDC6kYNBKc1r1RPREWw6KOm9BMSGmmKGzMdzngK
         HVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0El1r5sR/3XS90TExiIvdI2lmehipmygt0wHnvPAxUQ=;
        b=Q+j2cleNcHjPlMzqnjyDfXLQGRl3ReEKJxleNDvef5GD2WkjMGPEh5vlLvJ/IyOjV4
         S8XeMesX/689zhZ5ty3NJzrLRzvcGyVjuaf12REIka8rUnoUDW7ViVBC97kDaOmBlPf1
         17ubFZ/h3BN6M8cELYg+FCngbp4Bv7ZejWCxOdPymp77FA3/fdFcLXzivme+OdbaIHNE
         Tcq/FEw3KP1NE+LQwNZqpsoTmLRp+6QG4Ob+BvB21WaHPp2iAB4pa+N5cgh7WMMIJFcp
         vCombeJADKhsm+NBVXLe6JXdqkBn4nHHT0XS0OyCw53W0govl+ClJggfKHHMqXg3wUTl
         RHlA==
X-Gm-Message-State: APjAAAU1v5Bve6WP8zo3N17UcsMEXf8Lf7cu/empy3w8CerDFa4s3WGU
        fiu6IvlxquwPKPd9EP/BdiU=
X-Google-Smtp-Source: APXvYqz53Re3jOt2H62WWYr1iivI8KBu3qJtHSQkcLZcdLSKLbTaDCkqbRpPCXJSPKcloiZf5brhfQ==
X-Received: by 2002:a05:651c:113b:: with SMTP id e27mr22344296ljo.125.1571158911288;
        Tue, 15 Oct 2019 10:01:51 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/18] arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
Date:   Tue, 15 Oct 2019 20:00:09 +0300
Message-Id: <20191015170015.1135-13-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no good justification for smp_rmb() after returning from LP2
because there are no memory operations that require SMP synchronization.
Thus remove the confusing barrier.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 2 --
 arch/arm/mach-tegra/cpuidle-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index fe80f1988120..af2cd339db43 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -193,8 +193,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
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
2.23.0

