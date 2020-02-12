Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4815B55F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgBLXwu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40954 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgBLXwX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so4428281ljo.7;
        Wed, 12 Feb 2020 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sLX75wuAzd6+MMz3Hu9LnmvekmEH4xItVN4J4n6aik=;
        b=lbM0xqpcsuUE2KPCHz7Ns9UiE49LiAjMu2waKekvSELjm7B7oSgNab/qOKV5IgOHji
         70mD6nk+0GOtN+I5KtGfVEuqmDuDzdtRdZw62MgPzIjTwdko2z+ayI2XrLryUE1I5YV2
         4rDIL3LAxliytyDqGN4+6PFsZtkNYTQ7jdAEtCDMQ97TmoDzDwMLmSfJwoG8j6lGxGB2
         HsSWQmlxxru7PVVy4hbF5G7AbHiACD8avoEVbQGOQK5PmfuDQTL6Wx2eAYrw4mxUZZWZ
         WMc/hpJPiNE1d3m2OVaRwAJ9KeTYrHIooH1C8FNc6XSQnslaxW1f8MSqZZ3QwNre1nPd
         sP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sLX75wuAzd6+MMz3Hu9LnmvekmEH4xItVN4J4n6aik=;
        b=hWO5+mAwZp5aIOH8CIhhaG0FUmYoyPdGjXJHPa7rD2d/jPgUcxrkK0qs5YJfzEVEoS
         oerUp/Se23GSOIARWqkPgZUaoGP58rAElozGJE3CY5ZMOSOAYUogw1BBueYBlycrsRIM
         0gSfo7t00HNWotm19vLT/8H/lKSbKi4xhMc9JNHevytoqyX7OLgGTElMv/uv8U5orDTh
         16rOla5CDbZGllbS3ArdVdCvWxbIMgUCRxNuBzVPX6nNYLO8c9jYoEBJgCq/XTb6YOIw
         Ot56iPMckk/RQ3/Bs+4aMwLt4DxfzKK8CY2rQ6Py3cUDeJl5G/00rB000EsFcgdouk46
         1L8w==
X-Gm-Message-State: APjAAAUa2PEcIy0fPtd0ucYtO5a6Gd2gwLICQYfXAllyH4/MEjk6a6f6
        ilML8ZnlA/USz+pklapINu4=
X-Google-Smtp-Source: APXvYqyyvNchlbrlwSt+ADuQS9jaIbzHQ/OYWfHnBk18q1l60mPKIz222c45FzndN2chq91/OKRsNg==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr8732133ljg.24.1581551540814;
        Wed, 12 Feb 2020 15:52:20 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/17] arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
Date:   Thu, 13 Feb 2020 02:51:28 +0300
Message-Id: <20200212235134.12638-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 2 --
 arch/arm/mach-tegra/cpuidle-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index ccb8b0aa6c46..f8f14c0b79ff 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -194,8 +194,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
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

