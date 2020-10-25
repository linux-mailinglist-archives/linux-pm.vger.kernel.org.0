Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677AB29840C
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419335AbgJYWSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419328AbgJYWSa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B91C0613CE;
        Sun, 25 Oct 2020 15:18:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so7712799ljg.4;
        Sun, 25 Oct 2020 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6ur3FMhIFe8KvuxQxBkljzFbdkKufNSmZGLKBtZ/Ro=;
        b=BodnatAiw/VKmtLioaT+neJet4GwmMhSrvQOmSWb1dBrf2P08gTcaOGU1uurLGXRxE
         lGXcv57rEDS7EiB7mldnxCE+2vfBzzp4zayubegNwxxpzyWPLuMAQh2TlmdfgfCR4T8k
         uxhWvqKrubngEgoCndecxTbFXI0MbfNe0MlVkh7BZMCmfRZBtfwyX+qvHirQFB9Tslxq
         GEPI3vYHdH6pFo3ehTUEk82FitfIKVO6BH8XF9oL7tiIKQdAXsb1C4q6+MzwZr1qdMKa
         /kCa2SoiMZCMAe6gUhf4JU2gyP5noYwf1hbeWI0ggx80umHA6r6/0u2Yj66wQ+L8dhNU
         UDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6ur3FMhIFe8KvuxQxBkljzFbdkKufNSmZGLKBtZ/Ro=;
        b=U/JB2uk77JumYUahvq4w/6De/TDVo1kO5Lx36432lEBYJG70pAhXd5aKUkpuy+ZJqX
         IiwhLuvJOLchenBZSskQzlJ+6GsDZyJNfsqZvRI+LMhKAcCDihtkyJNrm4r4JXoDDQ3C
         8pa5m8W1IG65Xz6GdUqGRi6OX5gIVGGNrqk9UksBScW1XYWdH3+7zm1/5ia7OJu3qqXP
         46Wlq2WC4GPW6OjxJIi9OipVs0VT/F1iKeM0Wfp8Goi3jge1nR1Duxs/zLb4svLS+B07
         247/PsKQTE2hZYfM+NDpFKZc7lUkGyWSqPFfy88GxwHiSsnmfIYNQXKIkCyAa47IjJZe
         RJMA==
X-Gm-Message-State: AOAM5311zVe9Z61g2QdgeARNJQ4aLkakJ7XM9ffY98XoMzChRbqBFhQl
        EW2gJUy12HOjET04/v1SLqs=
X-Google-Smtp-Source: ABdhPJyJrFTPUr3OlEv3PM6r3URpRj9d4p8+2HogxPn86GPceWkk33M9WYAtiheFrzdPsx3wQks5Ng==
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr5025831lji.242.1603664308300;
        Sun, 25 Oct 2020 15:18:28 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:27 -0700 (PDT)
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
Subject: [PATCH v6 35/52] memory: tegra: Add missing latency allowness entry for Page Table Cache
Date:   Mon, 26 Oct 2020 01:17:18 +0300
Message-Id: <20201025221735.3062-36-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PTC memory client misses the latency allowness entry and this patch
adds it.

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

