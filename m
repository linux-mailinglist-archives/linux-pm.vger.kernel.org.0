Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFAA55D90
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFZBfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46916 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfFZBfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so387810ljg.13;
        Tue, 25 Jun 2019 18:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXsLv96t3D/DFNftwnjnuD35+3kXf4vWE9UyrvgtOGg=;
        b=dChPvA+SqxAA1Z6Tp9WqN92ZKuIPyYQxRX437Mgt338KGoHrgEIjQIapPDN9u02vBS
         oJv36SGhjv4dzpfVlVgX2IYlVtT2Kf1UqznKQeRnl4lQ12Nw7rs4skmPvqArAxz/vlzu
         ilOv5CtaQ/7gT3ZpufDEW4eEArXoK7Fha9EQuf8zoVPkiqtKL+NEIXh6nbRHgt24zILT
         lMe3zk88UisrhyUXHSiVUY/HWzgLBQEgzTi+NFgQiCqfXfnsA26oXUC3yWLycq2BkHV4
         R2Nv8boNWf+ldT2woWKLUrBY5M3+mJjXKRoIsUDmXlTwFFuTHH5csaoDJPP47duMZqZ2
         GU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXsLv96t3D/DFNftwnjnuD35+3kXf4vWE9UyrvgtOGg=;
        b=klcpbdKyLbWzlnLfAzLO4tLkwQRUl2JScnKVjQo4R62Yd8HcarzIvx3ppfRvmrPLtS
         gBttHqVCPGdV/WVwjMUVahzjKb3fwvT5M/NDFtlLOFxWMgzzGT7pQ+mmoVubCBSMRPTL
         f2gbKIRlrd7iu5WnhV/tMxPXzc/slJ/w+LQC4R516+8cpm2rV8IQiH1Ub16bCfsEus8o
         uUyIrB2OF3M50+1tJqMWWC/2A5O3es6Ooxib+bpNYqIZB9xZrnlDvDwTVFBMHG2lbnDF
         NSEjKyvuJkHQmhylsdP/T2VrMpfGpZJBMgf7AsmMt4mBG8LYzc7IpY1zFyXlNk3xCn6N
         gbqg==
X-Gm-Message-State: APjAAAXO7HFLhLYiDkvbd3P0Wpo1/KQ6R3f+bPhD0XV7qIlc9rHogjtr
        ye07Nm8n8vnhvCqQkwKixLk=
X-Google-Smtp-Source: APXvYqz4ycpcGN8e89gCt9mh7l8m+0WO7cxqOqZhEqw+B21a91lcC1O3TpfY/narbhUKSHMOKLwp4A==
X-Received: by 2002:a2e:3a05:: with SMTP id h5mr922887lja.114.1561512909584;
        Tue, 25 Jun 2019 18:35:09 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] PM / devfreq: tegra30: Constify structs
Date:   Wed, 26 Jun 2019 04:32:47 +0300
Message-Id: <20190626013252.30470-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify unmodifiable structs for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8630dca99905..d85de0e3dce0 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -106,7 +106,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -171,7 +171,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000, ULONG_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -210,7 +210,7 @@ static inline unsigned long do_percent(unsigned long val, unsigned int pct)
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
 {
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 	unsigned int cpu_freq = cpufreq_get(0);
 	unsigned int i;
 
-- 
2.22.0

