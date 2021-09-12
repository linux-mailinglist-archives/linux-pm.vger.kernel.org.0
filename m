Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4F407F81
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhILSr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbhILSr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 14:47:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD392C061574;
        Sun, 12 Sep 2021 11:46:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s12so13124275ljg.0;
        Sun, 12 Sep 2021 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2RXcbB3tu0m4WW0OHBxApkMwFU6fLHEdrXt9r4rSKc=;
        b=CgYuDKKtuJGn0+8ts8VKdkmumCXL7q8NSFw115BOkLGhWNvDq56YpfN9LFPiylzIFH
         KdFw6zGb42NBBWS2V+FwMNwG5WiwgCjJI17bJIvl8R0xzcicNRyZOgFL77aHHLZRAl+Z
         OVVqm94poh3lk2Yp3hH9SFTwfawMlRg1795GVNAwkXRcXb+hgEX8P3NaD/0bnxxzWrRp
         nzsSdfVuseeXhCTFEdkiM8h+4zaggCy0kt5TbxN0uo8VQyxlEGFIwhkT+Qnb69tNq9Qh
         +CdIeNfBYva2xaJBMb9MBUQ4t53IemnzpQGL2i3x4/rWvVfpqyuqZSCI/co6nlToqv3p
         tE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2RXcbB3tu0m4WW0OHBxApkMwFU6fLHEdrXt9r4rSKc=;
        b=C8CfK/Pn20rWZdzCtg8FWrbfD2lCH6CMcBMHhkDXrnVhbZ7K/kMR22NqyIMkW3DOsI
         pehrcMYKs6oo8iRZZ20pZaMb1Rkgd8ucwq8tixtmB9x+sWIN9Qpik3810KPlwZIRGF0P
         xS2cNCDej0y5aLEBz9NJZ0WuT33+mvgrqHdO6EC/QnrJJCZPC4cubGE3gyDqE6kuiq3g
         69xGGRXB/5892HIXsmP1ZhqzZIvbSoFl0TVjFZ+5q3rokq+hMDMIRk6KNJXHySDZRP4P
         M3Reycfv1PEODR+R6jSJIexsro2kSXzMpAQ6vWylxXITGzi/y8M8GoEQlOj4Z++d3bIj
         82jA==
X-Gm-Message-State: AOAM53190zzFOPchx+W1l/ede3OgNZs3skuHOPkdwkfxgoSRfCcp/OCk
        G8GWxBhMnNaqyhdGarwvrgw=
X-Google-Smtp-Source: ABdhPJyHw+jtKCOivSBI+NMKRt8D7t8dUHjAg9UXh7vHT2KzI9E5J/jMOi7ETCAnPJ3OfY4VF2Gm4g==
X-Received: by 2002:a05:651c:3dd:: with SMTP id f29mr7301561ljp.69.1631472371136;
        Sun, 12 Sep 2021 11:46:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id q5sm588570lfg.36.2021.09.12.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:46:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 4/4] PM / devfreq: tegra30: Check whether clk_round_rate() returns zero rate
Date:   Sun, 12 Sep 2021 21:44:58 +0300
Message-Id: <20210912184458.17995-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912184458.17995-1-digetx@gmail.com>
References: <20210912184458.17995-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC clock is always-on and can't be zero. Check whether clk_round_rate()
returns zero rate and error out if it does. It can return zero if clock
tree isn't initialized properly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index d83fdc2713ed..65ecf17a36f4 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -891,9 +891,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 
 	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
-	if (rate < 0) {
+	if (rate <= 0) {
 		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
-		return rate;
+		return rate ?: -EINVAL;
 	}
 
 	tegra->max_freq = rate / KHZ;
-- 
2.32.0

