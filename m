Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850A11987FD
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgC3XUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:20:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46998 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgC3XUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:20:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so12330979ljg.13;
        Mon, 30 Mar 2020 16:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWJ17QgfjQfYiVMNjS2RpFaBaWnfXYsQ7FwOrGsFKas=;
        b=EQqyEmao78riDA6NReH2DsSK7cavfmOdi1B49u8sq6YJVWVdAF0ti65/n3Ro/AO6q9
         aEOeJHVyR4u1JEPVahsssJbZPFuDUmX8J0FwF3FLZxd0B69c5BF/QmhxiGssVUIHssd1
         qVfSG0pbwWQ/bWG5f5YkNLJuxYrA4ZywlH09s7eHrudjcZUaotsKt5Asce51mSK5GH/u
         qdUJhqv8cWPzO8i//mVej3l/WW2qiY6x45D3fB2+zT3dWtLxzClu/6S8G0EiA/PY38oW
         CQ7msb/t7VED1S4AMxs3EBXyvc22658JPC5CYMoXo3dqluZymECNEEzAB4jVblXXgnlS
         GXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWJ17QgfjQfYiVMNjS2RpFaBaWnfXYsQ7FwOrGsFKas=;
        b=trqStLzJ4gnWibUUV0N+dC8p1EjyI7XOiuc1OgAQF4/QS7LHCC7JMTK3tRPuq07Hdb
         6GL5rXE6uc/gNVEbMpM/3znyw4WjR/djxuwfb/tgj6q9WVuRT/RPlnRGW3mQKDbge2/H
         a6qNEB28uR55vqGdlMecC5XSGW6S6QweBg0ZHCpOIPzlAPXqt8wDnuVKsIcLcpUJDHGE
         BS9+x60PdwDCJWQrSyhM0/wd9QevAZMvPyaX+n1T4KQpBm2HtU94BA8qdF7rDatkeyLk
         vK+ZqvQ/z5PiMkwatHEJho5n7C57X0cSQWUsM8UKyhcOr6yf0etGawuuycnlTkrpoVtW
         gymA==
X-Gm-Message-State: AGi0PubUm9aYm9va3m+HSjZ5la+qQLlLP8eW7UgN2b7WvqaQIRav/9gs
        u1GBWMxPrDXNoKENuaPKjUA=
X-Google-Smtp-Source: APiQypKc1S6eO3KhpVEEF2gpYXrf5kNQ9F72l1NV6q4EuPc+dFdAPBfecepxyHyWrWW2xk5fLNSN5g==
X-Received: by 2002:a2e:8290:: with SMTP id y16mr8412523ljg.186.1585610410601;
        Mon, 30 Mar 2020 16:20:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm8773187lfk.30.2020.03.30.16.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:10 -0700 (PDT)
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
Subject: [PATCH v1 4/5] PM / devfreq: tegra30: Use clk_round_rate_unboundly()
Date:   Tue, 31 Mar 2020 02:16:16 +0300
Message-Id: <20200330231617.17079-5-digetx@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 28b2c7ca416e..34f6291e880c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -834,7 +834,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	reset_control_deassert(tegra->reset);
 
-	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+	rate = clk_round_rate_unboundly(tegra->emc_clock, ULONG_MAX);
 	if (rate < 0) {
 		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
 		return rate;
@@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
-		rate = clk_round_rate(tegra->emc_clock, rate);
+		rate = clk_round_rate_unboundly(tegra->emc_clock, rate);
 
 		if (rate < 0) {
 			dev_err(&pdev->dev,
-- 
2.25.1

