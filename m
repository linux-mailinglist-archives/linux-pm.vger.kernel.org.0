Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28D6187A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGGXjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 19:39:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33130 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfGGXjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 19:39:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so14036275ljg.0;
        Sun, 07 Jul 2019 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6IbPJ6wDnrb4fcms6auW9pIcul91gDJiEO4g8AMoqg=;
        b=hUlpixej+aTYqmP0Y8BC6Z42cHgL51W18NKAEXFzvUf67CQrL07FBElT7LnS5okf7n
         OOfbt0geThq4TlSgFC0nMpAT/KWN7pfkxLwqXU0Iq6enS0Gm0lyHmQKG6RhblHxte7Td
         cDid3Lk4NMKcv6fbKP70bVLZbKZR30eNpfxqwcmWhLVq5+dTXsjDDL0crzFHsl2NpD81
         ibOw8ugIEqQsozILPK63hgnl38zbmi2RKNKPGqjsXjh7qm+AhikX6xBaeaq6KPG7I0nQ
         qDu50RsJD4abWhRZpMtOAyTS1VuoDvIqOZOKUOcp0NmcnGBSrIpAjmMcCY6QpHOQ7PxL
         G5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6IbPJ6wDnrb4fcms6auW9pIcul91gDJiEO4g8AMoqg=;
        b=XZTA5JK1v7BGJWRBRQvXY5IKntugDP1bcSEInRj6Jzio2/fgUqIdk0tY1/Z2WGub/y
         GyZ01aoPhwT0OcgdSy14LJUnD1shJF4FvwOY9wsHGvG3XmJ2E/3g3wFw2dlsR1rTNMyI
         XmrZzlohOQXlCQJB7tiYWeDePOBxeJ51LgqiG2+oLGl6RTKkMECDFOBkah7ZPRiNvWwi
         6xhci8syg7LAvKYcl6iZXhsi8GELlkZsjaL3KvsD8zj1H5UZ6IYDR0I+fErlTpsh2hMF
         nXrKYQyuZSp/P0QDVJl89oUCznJKtMyffmd/AvAOkjWKpGjB6PvkMJM7ew3G9h3fO1qd
         GB7Q==
X-Gm-Message-State: APjAAAWZdQGp9Sdeam3NsCxfue/DwbRii+cCUElP4cUpkb4GT1Q+VT+F
        mWZdq/pDnfYZ7QztiCqb2HQ=
X-Google-Smtp-Source: APXvYqwol9QdoQv+SXsrn0ugomHu4YqCbffe9VcqqXA1rd+0VQRNz4LMcLmqDhU4aPnLGZRky4qStw==
X-Received: by 2002:a2e:9209:: with SMTP id k9mr8350395ljg.96.1562542742975;
        Sun, 07 Jul 2019 16:39:02 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y5sm3246520ljj.5.2019.07.07.16.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:39:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states
Date:   Mon,  8 Jul 2019 02:38:09 +0300
Message-Id: <20190707233809.14400-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707233809.14400-1-digetx@gmail.com>
References: <20190707233809.14400-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra's clocksource driver got some rework recently and now the
internal/local CPU timers usage is discouraged on Tegra20/30 SoCs in
a favor of the platform-specific timers that are assigned as per-CPU
clocksources because they do not suffer from the CPU-freq changes and
are always-ON during of CPU-idling. That happened in the commit
f6d50ec5f85c ("clocksource/drivers/tegra: Support per-CPU timers on all
Tegra's"). The Tegra's clocksource driver is the essential arch-driver
that is guaranteed to always present on all Tegra SoCs up to Tegra124.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 464b2376905a..e2aa46231c05 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -143,7 +143,6 @@ static struct cpuidle_driver tegra_idle_driver = {
 			.exit_latency		= 2000,
 			.target_residency	= 2200,
 			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_TIMER_STOP,
 			.name			= "powered-down",
 			.desc			= "CPU core powered-off",
 		},
@@ -152,8 +151,7 @@ static struct cpuidle_driver tegra_idle_driver = {
 			.exit_latency		= 5000,
 			.target_residency	= 10000,
 			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_COUPLED |
-						  CPUIDLE_FLAG_TIMER_STOP,
+			.flags			= CPUIDLE_FLAG_COUPLED,
 			.name			= "powered-down",
 			.desc			= "CPU cluster powered-off",
 		},
-- 
2.22.0

