Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65B10098D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKRQq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41584 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKRQqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so14794269ljj.8;
        Mon, 18 Nov 2019 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSS5/MmskIAajZTBs7D6Zb0R76xGQBQ4vfEB2g+VhfI=;
        b=dSWGNAIscxuox8i/f4k9fxJCYXLkOYs8c4V9uuFlA9SegDARfNXm30V+fA26F1Vh9q
         qMZeV0Q1U5USzxnGztfqFCZtMakgozLP/mjXIEgy6jYUjpMH6LW6TzqXKOUHh5NhUXmv
         HgnG2O7OmmNmlwXyiBiSoyLCmrKVf1Iz8h+wG2anEr2cxpqitH4NwCVCIjVOheE3arkl
         BcYen5b28/Q268gKYw4B4Ll0Je8tZfsHTi704q3QVT4e1OfSpBtLzqRGGThP1ww50lIb
         e38JewaV4w3qTF4zTNxHYIJAWpes+C2QJH3TJwIuoFdaMkMPhoxJJOqFAaXVIWn7q2j5
         qwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSS5/MmskIAajZTBs7D6Zb0R76xGQBQ4vfEB2g+VhfI=;
        b=h/EQjYk14X96cJk4i5xO7Z4DR0Fn/OMVdwtaRszIGhsFW5N+QAOvEIdayuWmrAbgTt
         pAeJDjV93RnvbptCzf0TnuhcOPx4tyRsMfDzVPiU9OjxXRbo4tKhXi37O+udZ192dYtC
         KY9F4z8JDVegEYMus+rmgQfWlcs5pnbU0+tEyhV+RYw43W/Zu94UbnMFFmNPBip6mR9q
         atXDUTUIbenSIMJZyihOnT/cujRwMiBXUz7ZEM4clG/70hPa9IE++hdrpO4hiT7lsCgV
         tXhfaHLi5slziGOO4S9tW4iMqCHhU29pud/gWldJH1M3l9D7r7zCEbr+ZNmm3QPapKYj
         RAtg==
X-Gm-Message-State: APjAAAWe3cjoXUDGR8l1MkL3GlJVzcccKWaY7eXY9R0U9PL2daqHOmDO
        tJ47a1okXFI744gWVjzYn0U=
X-Google-Smtp-Source: APXvYqxlqLM20mDO2M7+YU85rS6jMfO1OLrV46UKkfkkIY4+zlzsjCzi+zqjYWX3egQxQ401PtG5VQ==
X-Received: by 2002:a2e:3313:: with SMTP id d19mr279650ljc.240.1574095613216;
        Mon, 18 Nov 2019 08:46:53 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs
Date:   Mon, 18 Nov 2019 19:45:08 +0300
Message-Id: <20191118164512.8676-8-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both NVIDIA Tegra20 and Tegra30 SoCs should be blacklisted because CPU
OPPs use supported_hw and thus platdev isn't suitable for these SoCs.
Currently cpufreq-dt driver produces a bit annoying warning splats
during boot because valid OPPs are not found, this will be fixed once
tegra20-cpufreq driver will be update to support cpufreq-dt. The warnings
will also happen on older stable kernels using newer device-trees, thus
this patch should be backported to stable kernels as well.

Cc: <stable@vger.kernel.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 4053aa65c517 ("ARM: tegra: cardhu-a04: Add CPU Operating Performance Points")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f1d170dcf4d3..aba591d57c67 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -121,6 +121,8 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
 
+	{ .compatible = "nvidia,tegra20", },
+	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra124", },
 	{ .compatible = "nvidia,tegra210", },
 
-- 
2.23.0

