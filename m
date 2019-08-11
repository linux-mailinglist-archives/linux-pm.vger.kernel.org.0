Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3628945C
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfHKVZt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35751 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfHKVYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so72932640lfa.2;
        Sun, 11 Aug 2019 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5tURnCPvlR1FgVTUPFvio04s8CzBn2V+f8QGTCwOFA=;
        b=VYGkYGWSyIqV3/bTw9edC/ZAEXMemhmm7+oIA4bTuiwZ5TpSwXb1uj4gAbqdkmGAJ/
         zTmk4QjPrLARFZzIivPK5ykVD2TwD9GOlgbGxwpgMUJsfJdrRnvTuVpmHzCgI+qGNJA+
         b/QOVd9gjb0BIuXOzJpSbm91Yl5Hw/df5Vt0O63dtVWQ6BXC2y2w3WOZHgoXDaTOBZ1N
         zATzakfMHMb+bKucVFg3hmSkPpyg/IOTr77h/0uFKTa7k68i/zFtxRfi1/JPXI+R44tE
         AxsLxER77eUmuy8SNTmcBOBzh7i4R/fjME/kb65AUUMteAIg7HhDPEwwZ/qrpbrMDhmg
         NaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5tURnCPvlR1FgVTUPFvio04s8CzBn2V+f8QGTCwOFA=;
        b=dOQ/yRt85wws++9ZWbtg5V2sAQeg0qQhTp4t8ZM/KwM2bcSuGNZygtwaKrkBuXujBG
         Kz4Ad+lshZl3qoHb8jat/trIZNm/SbDKcLDc5BQAugBnTl4IZOH0IJMnCc9cqcRRPWqP
         XJVoY0J+SEuZFB0yakWbw4we5iv/nSfvCeRe9hHpY9XovItZNSmSxSypmPsQ2MGsN2tT
         LKV+/4/NcNREtPdjolrDHpRXPvk6/cj0UVLX3t3nLMXcEadHqGsjq3OILvD6LaXX4KeH
         pixlBYltL25T6MtPMz3BuPjlcg5izzYqdqeDLtLASDMtxqy/gQNNaEIKz8nPn1SiR2Lx
         /Fnw==
X-Gm-Message-State: APjAAAXlKyDYJ/jRXxHC24HU8uDNmWWoFC4JPb2GsQ+qyJZQqwNbb9Lq
        3y5327ve9zI6Ci5gXjTNlSIyeZWa
X-Google-Smtp-Source: APXvYqzWsbha/k+n8Lk/bwRxmFe2Qn/10AKfanB58Juj0zMzr1JTJBamAVUy1w7zA/JAMhV9jY5gmg==
X-Received: by 2002:ac2:5097:: with SMTP id f23mr18381795lfm.130.1565558679611;
        Sun, 11 Aug 2019 14:24:39 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/19] PM / devfreq: tegra30: Tune up boosting thresholds
Date:   Mon, 12 Aug 2019 00:23:02 +0300
Message-Id: <20190811212315.12689-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that average-sustain coefficient / multiplier is gone, it won't hurt
to re-tune the boosting thresholds to get a bit harder boosting for MCALL
clients, resulting in a more reactive governing in a case of multimedia
applications usage like 3d / video.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 2331052fd8bd..4525c051f85c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -111,8 +111,8 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.irq_mask = 1 << 26,
 		.boost_up_coeff = 200,
 		.boost_down_coeff = 50,
-		.boost_up_threshold = 60,
-		.boost_down_threshold = 40,
+		.boost_up_threshold = 50,
+		.boost_down_threshold = 25,
 	},
 	{
 		/* MCCPU: memory accesses from the CPUs */
-- 
2.22.0

