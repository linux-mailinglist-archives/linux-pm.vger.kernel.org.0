Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11AAEEEE7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfKDWBM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45403 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388969AbfKDWBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so13411162lfa.12;
        Mon, 04 Nov 2019 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEzUAio8OEZBvo9nZSIV3+A/WsfLupbu1br1SQPd2S0=;
        b=sNRGPYThLEo6m9M+I5V9UFFOPfVuWsHtnKW7NvWNdf1d6mRVhLECezllEPq0z+73/k
         uydbKS4hz84tlGFc9GMOGbgh8RYikQYO4D+XinQHsoXrQkcSXIh6E8ToEli1XTibdsdG
         U3uUKNWXGhrAMKKb5188kU4aB4W9nl0K029R89i/kFxy5NWigTGcqyshYkwo9B1Oy/iq
         W81a4cwhk86LG4n3bktfJV0nGDSZbjFQ/pgvAp/lMP1QKN5toZvRK/8ZqzztBMlN0Gpf
         YSD5TIOooqrhPvTLBZzkYGOBZsqdd1mjtcgcuPGZyxzKGNHlrCXSaXouWvWE8EFlGTBL
         xnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEzUAio8OEZBvo9nZSIV3+A/WsfLupbu1br1SQPd2S0=;
        b=nPD3SCw86wsTPnaxZp2mEcXet7CsHZS34Qe+2GW7B2zcZOv+ye/KucYvoqFAxQvws3
         SKE5tP2SzPlq9lmzoiOkpPat2u+AbU2bCZioUzT0aEHzBV3UeRQ5lDNJAYnGmm9Z7UZv
         8lcMD9WmLKAYINqIUXkjT6/7V6cBo6tzMBtaIqw6iha7m+eNALapeRUZYryAs2nIQgrc
         jFu77IkWEWj+TjpnWDWogwWceVLM12XtCe2wfukJfxvARu3QCOixFA8P/7a4K9eZPQSz
         IP/IBkowpkpim81vOkoDBNPr9zu0pgwO3Csy1fh+VyRdSNFJ1ESycmSxKi8975T6hXaK
         mdrg==
X-Gm-Message-State: APjAAAWdTZ5yOZgLGPea8kEom2hIJpXUGc3NQhSjyme5E8eUfC0iv044
        mdk7Ec/WrgnVn815lmNWVxI=
X-Google-Smtp-Source: APXvYqw8G9Mz+XCHuG/7zu1n4bkCyBbNZkVBePFL2zHn8RRF5tzOgQxKS7KsB0OGvci61Sr/Mhpw1g==
X-Received: by 2002:a19:750:: with SMTP id 77mr17992493lfh.81.1572904868172;
        Mon, 04 Nov 2019 14:01:08 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/19] PM / devfreq: tegra30: Reset boosting on startup
Date:   Tue,  5 Nov 2019 00:56:07 +0300
Message-Id: <20191104215617.25544-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 6960d8ba0577..9cb2d6468175 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -467,6 +467,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0;
 
+	/* reset boosting on governor's restart */
+	dev->boost_freq = 0;
+
 	dev->target_freq = tegra->cur_freq;
 
 	dev->avg_count = tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
-- 
2.23.0

