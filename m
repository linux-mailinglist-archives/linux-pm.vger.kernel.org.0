Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8592181D8
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 09:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGHHx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgGHHx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 03:53:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4DC08E6DC
        for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2020 00:53:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so17575945pfu.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2020 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y55nygfLWId4LN/DVfidqEEz07PpT+kE/Of591U6tQ4=;
        b=Xg5+rbjB4NptqIoHOkzJD8CBC9CdjUtEiqL6VhBe9weMoDUPG2r3x3/raQHvb+DQfw
         z7VO288nlBCiFbODbJrcXUvNxl2qAwJp4QuldqLdXN6AMj9eMqdOkVyiYG/91TWuIuvC
         j2L0f69XENjZEe26MlLnqG0lemBcCDxqqFoXWxYq6Vcy5lINlm18YvOPVR8Di4PnIh3w
         DJQrNXwsbvEfzAHgFVkBFtkpJ6X2qFDCiaI7z4xK1T6JmywW7ZFzl2rjwFOH6RRVBDhl
         pvQSyELHn9KwzfgDJx0yo6LGJuLYdqg+du4ZiHgZ7nXmznz2YYghQY1oVwn3oMgzzGss
         IkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y55nygfLWId4LN/DVfidqEEz07PpT+kE/Of591U6tQ4=;
        b=V+hKbBqmNIwfC1ImlSPzJG424pxyKCvwBK9wT2729gj74P6JLNZvIXg1D2EJAcqIbT
         BSv2qFcP8tXxd9FyXsm7pq8XXoIpnYKksPhjYgjOVh1YutgVBNopgAkgTCyrzNidRovZ
         q5UqXcW+duazK8j9d/cRsEgSHVFel5NZg1pGVcghwAUvRof6Rtau6wqWSl8phwvtOKI6
         yN95ouCQzjR66TZG5Y4bYX17KcLtTkH7wlUkeiwukzxPqFvxmhTtMUSA4evlTLo/skDR
         NrFGBXFzoGJkguhba4cxwDyhx6LuJrhkk8kDPCnilualP7YQmxIu1NwpNuTv9Hr3VyBo
         uMIA==
X-Gm-Message-State: AOAM532E7FTdCUF0sCvPgShk7qpYfHpwEZZ24e5nCOq0AvE9Hs1/ViBB
        xt0Q2QGAAW9V0uvyGtsPwR57gA==
X-Google-Smtp-Source: ABdhPJwC7Vm1dEppffoA5E0fBMvPfXspEZc6nlyiGFReMPLoTylbUyWvT/PUDl6HviV+8iyvh8H8Gg==
X-Received: by 2002:a62:178e:: with SMTP id 136mr51909249pfx.180.1594194837422;
        Wed, 08 Jul 2020 00:53:57 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id m68sm4672626pje.24.2020.07.08.00.53.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:53:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     stable@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [For-STABLE] thermal/drivers/cpufreq_cooling: Fix wrong frequency converted from power
Date:   Wed,  8 Jul 2020 13:23:43 +0530
Message-Id: <bc3978d0b7472c140e4d87f61138168a2a7b995c.1594194577.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

commit 371a3bc79c11b707d7a1b7a2c938dc3cc042fffb upstream.

The function cpu_power_to_freq is used to find a frequency and set the
cooling device to consume at most the power to be converted. For example,
if the power to be converted is 80mW, and the em table is as follow.
struct em_cap_state table[] = {
	/* KHz     mW */
	{ 1008000, 36, 0 },
	{ 1200000, 49, 0 },
	{ 1296000, 59, 0 },
	{ 1416000, 72, 0 },
	{ 1512000, 86, 0 },
};
The target frequency should be 1416000KHz, not 1512000KHz.

Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200619090825.32747-1-finley.xiao@rock-chips.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Greg,

I am resending this as I got your emails of this failing on 4.14, 4.19
and 5.4. This should be applied to all three of them.

@Finley: I hope I have done it correctly, please do check it as this
required me to rewrite the code to adapt to previous kernels.

 drivers/thermal/cpu_cooling.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 908a8014cf76..1f4387a5ceae 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -280,11 +280,11 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 	int i;
 	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 
-	for (i = 1; i <= cpufreq_cdev->max_level; i++)
-		if (power > freq_table[i].power)
+	for (i = 0; i < cpufreq_cdev->max_level; i++)
+		if (power >= freq_table[i].power)
 			break;
 
-	return freq_table[i - 1].frequency;
+	return freq_table[i].frequency;
 }
 
 /**
-- 
2.25.0.rc1.19.g042ed3e048af

