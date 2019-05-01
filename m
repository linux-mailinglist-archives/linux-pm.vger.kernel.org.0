Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1986911061
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEAXlr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39662 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAXlr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:47 -0400
Received: by mail-it1-f195.google.com with SMTP id t200so344825itf.4;
        Wed, 01 May 2019 16:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfIFaN/cDvep9inRd5PqDA7WzNgKemRCq9lkW6WG194=;
        b=P99ZqlgboRhF5XRuOsWm7jgTy8cXOLjBRBMlWO1S2cywGUyFPKzXjMqraXVShzSn/g
         PzXZWH97KzfulgOF5TYJOF9akbfHDpBVbznDW5Axb/6up2Qn+4UnIu6fBfjkF/Q4Pkig
         9E6NnxdF+MPJTe0dvm5LYH/aotHHgIMSLCJudM1ryUqbsYeDhpkL/hH4BZTV9XOEX95d
         cIT2rJFM4RAQd5Z0sD1u7UMJ7e6GtEUm8hO8tzNZUVDimQXU4o14WsKkwNw+KOWXo0/x
         dJ8u4vv1txC+N62qGwm8GaXq3/uaEXlLeL+u2j8vD6V+rqPAqYXJ7LP6pwhCMuDrGmC6
         BzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfIFaN/cDvep9inRd5PqDA7WzNgKemRCq9lkW6WG194=;
        b=cDbiAENkIu0/60xM248auhLCrFDYRbjNP2ukzfYHtkSS8wPqe3nrUhJ6pvbOEyVjlQ
         piXPohxe0slYeba7YjB5WRzurzpGSldZNheEw8rJEyymQnFlC2qsQ/B9TR92050aCHsb
         Ea59v1T6f2kw7RA4RmvUqh91DUbEABmUdIypm74p/covZGpRxXu4OqUpFqCN8nANQzmE
         ykdSZ7orbr7mYPA0V97W8sBaRMaTco6AQiDT9Qdw0I9YwXF86uBeRO0tTogEULDAjSUM
         ItsGjjqdZXqqpxPfvB65ES1Zie1jnEykHmgjNZf4hiEz2d3XnPw0kmUMt9U9cIGnD8/q
         HLkQ==
X-Gm-Message-State: APjAAAXKraSfVECb9pcaHv+Q18qbvPoHBNGI8ohn9v2I/rd19GXgUiU0
        bCah6TTAYT4hMUEcemZcEsWOqKvA
X-Google-Smtp-Source: APXvYqxcYFYw5TbEFuGDeoD1sV5z0Oapxz5H0rtjF1vS5tAEvCBZ7s2wdnRQocopsW7pV4+9+vNm6A==
X-Received: by 2002:a24:694b:: with SMTP id e72mr251605itc.48.1556754106132;
        Wed, 01 May 2019 16:41:46 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/16] PM / devfreq: tegra: Replace readl-writel with relaxed versions
Date:   Thu,  2 May 2019 02:38:01 +0300
Message-Id: <20190501233815.32643-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to insert memory barrier on each readl/writel
invocation, hence use the relaxed versions.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 43cd1233f87b..f7378a42d184 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -191,23 +191,23 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 
 static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
 {
-	return readl(tegra->regs + offset);
+	return readl_relaxed(tegra->regs + offset);
 }
 
 static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
 {
-	writel(val, tegra->regs + offset);
+	writel_relaxed(val, tegra->regs + offset);
 }
 
 static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
 {
-	return readl(dev->regs + offset);
+	return readl_relaxed(dev->regs + offset);
 }
 
 static void device_writel(struct tegra_devfreq_device *dev, u32 val,
 			  u32 offset)
 {
-	writel(val, dev->regs + offset);
+	writel_relaxed(val, dev->regs + offset);
 }
 
 static unsigned long do_percent(unsigned long val, unsigned int pct)
-- 
2.21.0

