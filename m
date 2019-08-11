Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE58D89441
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfHKVZQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:25:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39606 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfHKVYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so19207715lfn.6;
        Sun, 11 Aug 2019 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DipR4hwlo+C3xieASjVQKlAxunkARzuIH2w7oPgSg0=;
        b=gjsyse6wDQwZA4x+EK9knjC9/CpkfAp9T5JAVNm63P+Hs51Z7jUl8hCAxM4g+5zPHi
         Ay7+ZsRhwLUtIxWTBhWEgGT7f7wXMUd3scx0J7hCBjy5Lj3hVrlXKqBYrMv6JJlljzwm
         wfhoJQPX3Y73TLHed1K6qqV8OmWnUU0ov+UyMOYurtDPHVbmi4xXLU2kWQvfErkL+MdO
         bBD21VRaWwooDP0lW68btSVyLtrFl5btrZZe5RC3Kbg/OsKpO8me6FdewHQBhAxjv6GQ
         MjDGnHLFgmBPAwxUq0LxLmcEJooV0V5wAP9UDL9VFlg3hsiDwTogaCery5s/XUkR5Zkz
         J/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DipR4hwlo+C3xieASjVQKlAxunkARzuIH2w7oPgSg0=;
        b=RNat1D9Zmxuz88PAsAvP5mFsghAFZMk0V3kdiIn/XSBjAPMayhyA+CVPYL4xnGoKn3
         4VrMPLyZCR8tjqMklK+oBU0P3Sq0Nxj0jFwvZ28f3sWtscRy/MgUifNrLgxGbuYNuxir
         z6sx8hlTzMkWv20OPoSXhD+T9K662pHacTZvfhC8sofi4ZKj3GbEszW+lpFeP2EiaTon
         pttNqtP6C0Pf52aJm/pP0bBJr7GMpJ/l5TSBvbzutdZ/9XDoxsIII4p9eyFpVj9ZOQ27
         pLj4nVJP79RcH0+dJBPbnHE+B5InvTdpG3jn18UXwzGbY1nDTafqoJ2qIQdGO49n359H
         JA/Q==
X-Gm-Message-State: APjAAAWT99B2EH5573ilD2OKPLjb1imP/k+YdzMQw9VNBA+L5xA6QgRx
        R6150hTk3XIFeu1CV7xE1rw=
X-Google-Smtp-Source: APXvYqyzYo4TOGkWXwCOZT/8T07hDkQuGj2IQhFTkTVwQKv7xIItsXzSOD+douKo2pEtw/JwgX5pbg==
X-Received: by 2002:a19:4f42:: with SMTP id a2mr17836593lfk.23.1565558686247;
        Sun, 11 Aug 2019 14:24:46 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/19] PM / devfreq: tegra30: Reset boosting on startup
Date:   Mon, 12 Aug 2019 00:23:09 +0300
Message-Id: <20190811212315.12689-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
References: <20190811212315.12689-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index bad9836b1eea..5002dca4c403 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -686,6 +686,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0;
 
+	/* reset boosting on governor's restart */
+	dev->boost_freq = 0;
+
 	dev->avg_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	device_writel(dev, dev->avg_freq * ACTMON_SAMPLING_PERIOD,
 		      ACTMON_DEV_INIT_AVG);
-- 
2.22.0

