Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713EA55DA3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfFZBfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42823 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfFZBfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so402222lje.9;
        Tue, 25 Jun 2019 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHcA7DAn0vBlxU0r5wyvgS3+aE/PnlBNnqu4CBrs4zA=;
        b=RMh7VrO3Kb7bQZ6kh7oBcL397794Z/6zkMtmI2SjXX8lA5opCe4EyZhD3Up9+OguWc
         bfY7oLyopyRJOKS0oQmzDjo4ay6IfbcdCU9zngTO3EelSpUTor9GpG0GeQ/OqTCTCsOe
         eDlh+RJrvtpDGGxXmXT35r8BChzIQEkdTPI0ZikPykFzTNV0jLBeLw2qsl1PoLtFUB7w
         oukqtLkVFdSucZdRhBIcTzq56WauLqlGV6u1U9DbTnMq/yZg8+0Bg9dnc4BROA0FZ17B
         xzF+wxKl4FmI3ui2nqQ9g706J2iuUyqlgvJZOHMh5DqzHo5e9B5aV3YFnF2kTB80j7VB
         lsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHcA7DAn0vBlxU0r5wyvgS3+aE/PnlBNnqu4CBrs4zA=;
        b=GdnAuOdFpWfQ7oEhZCynZCvvO2h3qtl/Q2eY/N49pD5UXN7q9cxi6Wf4pZ2nFjf26S
         2pKwrq/rQeDsbIZQvI3kzlzbJ21/o3IhDWc2eZmdH3SNriscCzs0arkpT1NsBhQ92j1k
         CQA3v1ddeMij0/Ci5ZbfKYM7lUsJmunDxqBOae+L0LM04vkNdS8J4Ww0L5UJYaus+6ip
         5x2NiZ1HlIllSv3mvz++x/b9/S7d19HXThunWCcZloUid8ikSkE58dK/X1Q95HnGh0WH
         ankJpaJ1Ualzr5mcPDhyobpixC2KWGr02Bpv4n3yFGmfifw9fl4kVgPe7lZJfuMnFZvm
         DpCA==
X-Gm-Message-State: APjAAAU+HAvJfnjrw3Lv2G9QLRk0Be2efsbT7nhwbcrIOaOCZMFAk8NS
        kTE/nqBYwI8gWz3nrZgqlJY=
X-Google-Smtp-Source: APXvYqxbvr44HSxwBwgJXXdwqOJJW2psb8uCApxVdKSNKo3u64j9dYhUoArriWOhmNa3KxJwMaP7rA==
X-Received: by 2002:a2e:730d:: with SMTP id o13mr838821ljc.81.1561512911446;
        Tue, 25 Jun 2019 18:35:11 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Wed, 26 Jun 2019 04:32:49 +0300
Message-Id: <20190626013252.30470-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 1dcc2d2fa9e0..c03135000af7 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -172,7 +172,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000, ULONG_MAX / KHZ },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.22.0

