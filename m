Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB362A6A5E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgKDQuL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbgKDQuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:10 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC40C0613D3;
        Wed,  4 Nov 2020 08:50:08 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p15so23745561ljj.8;
        Wed, 04 Nov 2020 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOGvVUHcibmPsiJFYWy41eUdIfTQfcWXxsgewF1xVKg=;
        b=hl9PYTeGaxu2o8M5LrEu6BtKQP8m6rA7XTM+RoY50/kPsRxa8J9MTXuP+rCTLD4pPI
         pcl/iTlEfddLxoJvSDTQMPheJb67tlB86IDV1YHFTv0Wm3/tj1K0nE/nVwYVhPdPaJYO
         NnCYXIPOOTIAbOp4kEH0pOeZMlF5DTw/3I3HK9+Lh2E52CEKYMxjgguS2YbdTN9m6wv1
         NPtSS5cdQ9nHITAZMxMqyhbWonBhdZgkc7Bv4mSlbYvQ/7kJwrY7rUXzCOAfmrk6TzBU
         LghymARrfDpLRWy51/4HibOiUXHV5K2mzHPJyddJU7D/shVzQT3S+jUOgkFUtnIGEflH
         pR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOGvVUHcibmPsiJFYWy41eUdIfTQfcWXxsgewF1xVKg=;
        b=fCvKUaomN7IPSBzd5/2eDKo9407TC/12AJu+LVidHEtc9Bxyn4lZue2NG3MTt5l+fS
         zlOTOZQZ7FnvopR3l3didOrA8thMQsvt8up6tXZmUAUIb4uEozmIZ6g4HZn0m0YU6wpM
         GsRsmXGy7m0Jh6M2XeSoO2g8CvZ4WAk+z12uYsn03+1OUed2WOeWx252rtvgYEucTJEF
         9Wu8KiyrIoOcObg2cXxuh/fiARIwjMuxJ1M0YWVYFrkolyfadbIBg5ScKzDGPc5cYOYR
         Q9Us09kNnDsouHZ4OrYpLdeQatmHqRx6dnUVDCPE+pToVUxWXV3Kxi02bXEDz3NMZFcV
         jU4g==
X-Gm-Message-State: AOAM531kLYEChu722H2Z1yK8gq/jnUR6/lCPXN2qA61s2+kcd8iZGcLH
        gHf0pOfqlKiHJx6mW9wgzAc=
X-Google-Smtp-Source: ABdhPJxze63P/PqGfFrXgCrXBjeFwj8H2RVN0iP7KJpDm/DqMJe1meNS4slHrFYeL5pTc5ZW0q+wPw==
X-Received: by 2002:a2e:5d4:: with SMTP id 203mr577835ljf.137.1604508607389;
        Wed, 04 Nov 2020 08:50:07 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 31/47] memory: tegra: Add missing latency allowness entry for Page Table Cache
Date:   Wed,  4 Nov 2020 19:49:07 +0300
Message-Id: <20201104164923.21238-32-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing PTC memory client latency allowness entry to the Tegra MC
drivers.

This prevents erroneous clearing of MC_INTSTATUS 0x0 register during
of the LA programming in tegra_mc_setup_latency_allowance() due to the
missing entry. Note that this patch doesn't fix any known problems.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra114.c | 6 ++++++
 drivers/memory/tegra/tegra124.c | 6 ++++++
 drivers/memory/tegra/tegra30.c  | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 48ef01c3ff90..ed376ba2d2fe 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -15,6 +15,12 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.la = {
+			.reg = 0x34c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0,
+		},
 	}, {
 		.id = 0x01,
 		.name = "display0a",
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 0cede24479bf..e2389573d3c0 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -15,6 +15,12 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.la = {
+			.reg = 0x34c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0,
+		},
 	}, {
 		.id = 0x01,
 		.name = "display0a",
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index fcdd812eed80..b1990b4133d8 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -36,6 +36,12 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 		.id = 0x00,
 		.name = "ptcr",
 		.swgroup = TEGRA_SWGROUP_PTC,
+		.la = {
+			.reg = 0x34c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0,
+		},
 	}, {
 		.id = 0x01,
 		.name = "display0a",
-- 
2.27.0

