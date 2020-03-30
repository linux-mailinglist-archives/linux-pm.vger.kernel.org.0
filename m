Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C554F198807
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgC3XU3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:20:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44732 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgC3XUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:20:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so15709213lfj.11;
        Mon, 30 Mar 2020 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQq+QxtzNjE/EJiMAC6ATxubC+X+EZVUzsWLxM6NceQ=;
        b=NrxMUjkwmImgyUTl5qRgdSMu08UoO9c982K4nBQEknn83NqOxeWk4PScIBdyL9DN2x
         rXwNIFqdLxuLXDMJZ9Ifw8Qv63zZdo/zLFsCzLVlzm7fDwZaKGkkjiEiQyziXuwBwSTz
         b/hiSA9nO7dB19ubxjg9UkEBVQ6zR9OwKXUfJNDun35SJ7GpexWHgIAgKkjVInYgaKLy
         NvI6DM2TJMb1taxA0/SYgnioOlGP8IbgM9j4kEEjUKuWpgkMs2pV5JmAI/aqWJWQHmHw
         crNWCuLD53uTbyCNw6J8P11xaH2fS6aKOj/h4yjLpZC72j2la0vnwbvj0E1d8wcpMo6Q
         7kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQq+QxtzNjE/EJiMAC6ATxubC+X+EZVUzsWLxM6NceQ=;
        b=eqAXdUi/s+KVUQcxBr8YcgwaIeUzp3fngxbdDjaZhQbTxJHjt9DLcfp2bHTGLROJBz
         ucKN7mPbKjF1yaQKQaoSm3sn2yIn3rZ0Qdz+xN0GA+a0gNPXbYQfhcdEHYc85aA0JTav
         Ipi2wzgEAQHifz0+lBzvOA01ygS8K9UzKc9br0LnMKhZlIp4oVRtyIU3t+flN8mgeGCD
         cDVzMrV5UZNGXAvbnibIp09SU/F1U1BXpXyl/IEgGUuMjzv7TA2mZTjUu1hyzRwH5CJE
         z/5SvKMzOaAMdcfMWrV6sKwwlmDh0Z59cMt9uCjLZ3GQAMA4TiKj8oXNNROukC/l3diX
         xT6g==
X-Gm-Message-State: AGi0Puazima4Swv8tRAacflxkdVlzHNC39GrPCwTmtLwpB8XLzaY0tW6
        sGo5BDAUYZKBInMarCdZFTI=
X-Google-Smtp-Source: APiQypL0Mzbqohu2BKii5CfejZZEmHzmTR6LuLXcqmuU4DiwUBOmIbUVMfpowI815cwo9lQb/XgB1A==
X-Received: by 2002:a05:6512:3127:: with SMTP id p7mr9306654lfd.108.1585610409582;
        Mon, 30 Mar 2020 16:20:09 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm8773187lfk.30.2020.03.30.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] PM / devfreq: tegra20: Use clk_round_rate_unboundly()
Date:   Tue, 31 Mar 2020 02:16:15 +0300
Message-Id: <20200330231617.17079-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330231617.17079-1-digetx@gmail.com>
References: <20200330231617.17079-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clk_round_rate() doesn't work for us properly if clock rate is bounded
by a min/max rate that is requested by some other clk-user because we're
building devfreq's OPP table based on the rounding.

In particular this becomes a problem if display driver is probed earlier
than devfreq, and thus, display adds a memory bandwidth request using
interconnect API, which results in a minimum clock-rate being set for
the memory clk. In a result, the lowest devfreq OPP rate is getting
limited to the minimum rate imposed by the display driver.

Let's use new clk_round_rate_unboundly() that resolves the problem by
rounding clock rate without taking into account min/max limits imposed by
active clk users.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index ff82bac9ee4e..1bb10ef11dfe 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -149,10 +149,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	tegra->regs = mc->regs;
 
-	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+	max_rate = clk_round_rate_unboundly(tegra->emc_clock, ULONG_MAX);
 
 	for (rate = 0; rate <= max_rate; rate++) {
-		rate = clk_round_rate(tegra->emc_clock, rate);
+		rate = clk_round_rate_unboundly(tegra->emc_clock, rate);
 
 		err = dev_pm_opp_add(&pdev->dev, rate, 0);
 		if (err) {
-- 
2.25.1

