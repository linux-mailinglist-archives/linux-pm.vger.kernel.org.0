Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968B01971A3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgC3BJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42907 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgC3BJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so16239391ljp.9;
        Sun, 29 Mar 2020 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mKtQtW5d+QZO5sS4d1TUhWoxitfV+iMW6pt/UheZUU=;
        b=IpN+1WW8ChpXXkajbJachp67OlaAqUuv/Zf20DrTCZHaySBU2fAlUgIwqIHczpK8qX
         +alZPRKVhBmDxBRSkDeVJx1pyCL9DS4AlnNYeaM8ZSBbg2v1/H+yBAki8/3+bomrgcsp
         PuutNcuikmjNfan5jYP/KkZ7bmSMMDpawtswfi+4UeR/pjKVkLjHeGukwhGRjF8QokQM
         aBe6Ybf5NyRAur7XkkxgzZ6Sb2r+FfGMJMRHBH0/8lxERqbKev9S6NdEU+Ks2QJnvL6d
         /Z4BmRD72wxGmVPDnVj8xQq1ekMLRO7NL4ESIm6Ts/wpmgHRIN5tvVNUY/53nX7bMvNp
         IdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mKtQtW5d+QZO5sS4d1TUhWoxitfV+iMW6pt/UheZUU=;
        b=IzzYR+4GN+Fe4ylgXP/9E7+w87VI5EFuN6/n6pj69cmDpyR9eifyFJusdtAGyNN6ll
         LhaAxVZdUdZPByBMXV+mWIvzdjcX8k+6i8jU7OY0OwVdVCHWD1ZdJ5JnXi0ivLhWtaBX
         Jy5JyfUAKUTD9GQPEMPT4QE0DSvGErbG+9v4o943tAvPkE6h5gVikBIoXvtdDt7EpTNq
         OJ+CGp2jPsP3xJvodJF015o+vf/eBAdbk83EslMK0N1O/vyVSv/fRCFn+JWT7qGgJz1c
         VqkRW26v3+lujU3/01S/Z7BrJtzxYJtlzAGjonTSowxvu6DUS3KCxuDHDNa5GU19jZZE
         3VsQ==
X-Gm-Message-State: AGi0PuYzQxJpx9G08Z/A4M46kHwxl672+zhd8Q67O808SxjJtXPWL8dm
        /EXUvxQ2ED4FmSCIgSgdyUg=
X-Google-Smtp-Source: APiQypKABPDN7b8JWZ/OsG7aVs2aEJwYWKVYjc05Q4ZDGuMcNnfRbs7SVkk1TaRzip93+KQTiztvGQ==
X-Received: by 2002:a2e:a495:: with SMTP id h21mr5723315lji.123.1585530590977;
        Sun, 29 Mar 2020 18:09:50 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 16/22] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 30 Mar 2020 04:08:58 +0300
Message-Id: <20200330010904.27643-17-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after turning it into interconnect
provider because interconnect users, like display controller driver, will
fail to probe using newer device-trees that have interconnect properties.
Thus make EMC driver to probe even if timings are missing in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 900a291803ca..69698665d431 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -988,6 +988,11 @@ static struct device_node *emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	ram_code = tegra_read_ram_code();
 
 	for_each_child_of_node(dev->of_node, np) {
@@ -1057,6 +1062,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -1263,12 +1271,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct tegra_emc *emc;
 	int err;
 
-	if (of_get_child_count(pdev->dev.of_node) == 0) {
-		dev_info(&pdev->dev,
-			 "device-tree node doesn't have memory timings\n");
-		return -ENODEV;
-	}
-
 	np = of_parse_phandle(pdev->dev.of_node, "nvidia,memory-controller", 0);
 	if (!np) {
 		dev_err(&pdev->dev, "could not get memory controller node\n");
@@ -1280,10 +1282,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (!mc)
 		return -ENOENT;
 
-	np = emc_find_node_by_ram_code(&pdev->dev);
-	if (!np)
-		return -EINVAL;
-
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
 	if (!emc) {
 		of_node_put(np);
@@ -1297,10 +1295,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	emc->clk_nb.notifier_call = emc_clk_change_notify;
 	emc->dev = &pdev->dev;
 
-	err = emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
+	np = emc_find_node_by_ram_code(&pdev->dev);
+	if (np) {
+		err = emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
 
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
-- 
2.25.1

