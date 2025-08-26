Return-Path: <linux-pm+bounces-33076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08072B353EE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C369E16331D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420322F60B4;
	Tue, 26 Aug 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVeJnyBl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650792F532C;
	Tue, 26 Aug 2025 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188707; cv=none; b=HdRgMwPvdTUfkuP1/3be8WfXpKd8zTb5N1vDqMNHG8mgyOgiwXQB5VMbFEbnCWYL1i1iS6zDPdhuLKnE5VLF7S2rSIdTXxAmFivDTSZ87nD8IfEYxJQ5wu6cy5BCF6wlY0jbhQr2YSBbcuK4Sc/mJ6wGvu/qmh9xjOdCh+dDQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188707; c=relaxed/simple;
	bh=21RYNlmCHuRuunlGqGsBYkriVict2NzlHetlsy9T50o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtTHC192hl70D39S1npYe2/9alKAj4hLVpf4TuUJWv/2JvswIpJmx/6hawoJ7i+BzSFsnrit4v2Wqw/8gWY65ITYHD6XmeBd0ZadV5KUc/89axNAPZGIelVqyPy424YklBr5fD+8rifFMrZB+G3u8OcqFPV9q1BmQ3gHCKEv2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVeJnyBl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a2befdso768320666b.2;
        Mon, 25 Aug 2025 23:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756188704; x=1756793504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+knekcqGNz6gs15/qnRU+9wCksd2jEv93UOmoTNkaE=;
        b=nVeJnyBlY6CY8TMqi0SX/zZmaZxUIqFiy+pMUbhxEvay4XpGWIFnxB8HJP6IO/ee15
         DmW/IwZ3dakDbaOQ3LlE7D7j2tIANGpCT+rjEtH9O/6j3lw04EjSdyQbkjwYnsVzYW9u
         IRox8CCymOlS9yQfAE1SRviT9hL4sPUDge70obohXub9z8V7JchdfioeeQe4iUCZnHGy
         4dCfW69hKk0ciB9k2i2840Csd3wAWGIdUCAh4/sH3Uj2vB+H9cz1pZYUNrzRTTIZuk2I
         sA7EJ6if2RVPNVtOeaXoVRH26o3Kabg+WyNrtzgaI6aT27f0dyzXtopnBY4WyYj1PWAo
         59jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188704; x=1756793504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+knekcqGNz6gs15/qnRU+9wCksd2jEv93UOmoTNkaE=;
        b=F/3jTxWWJqB/AebZqZgQPGUn4T5GihulGbZa+XoRIBD1QuOYvTPebioMKahH3c717/
         7dK8QjvYn8NdnL255r3Acm+Ek/lnxE7RESCHzXAGyOP20ZAOKNh7H/1RpwR5sR/Pfo4K
         n/DKrgOVjVTQIB6T9Wk1aq/kF1oEA7orczCtyLaiNo1PL8IJtjRBnmynOVjMZZgdCCL1
         cLvK03yD4+XdEH9lcgy/QI3R/2hSs15faaL7hKXvrtGXlk8g6dFQp/p1W7GHE7IjccnU
         s4lEJPyK49yW2TEj1dpIZkGAn1N+f0qVrMeRTr4YWPqNIStaXVwoUTFT0zPqogV7kCt1
         7tlw==
X-Forwarded-Encrypted: i=1; AJvYcCUWfP6aQNybbAk2H/GVjrLyHi6XxCG7sOk9ASrHgxvxVHSvsULoajtbwDX+FPZyD6UH+FO+SVvd2Ms=@vger.kernel.org, AJvYcCWUXmUGKL0KNHw0cYn31yLyYcO9A78dWfuXfbnaMblayNuXcI3mc3miI3k2En5Ly7JRwzjWVy6IKk8=@vger.kernel.org, AJvYcCWdarGbSlph1JoD74QI4RGBq5Hgi1hTRxFABjSo2fC81SIyPx/7JrS/sdO8cjdBCAlI0tqIOHCAFP+DX9Oz@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgOPbQS1jTx+KQbxa1qwJt2Xq1K5zwY5lO193PNdzD7rllWo7
	1fH0xXJfgYjj1JQSnykajeLXMboEgXLiunI/xnvCygNtogHPPDBdBFuf
X-Gm-Gg: ASbGncsfKWmu7nB+THEq7Us+3tIwZz2jEqN+9xZ2SIZp8Fmtz/Xj6ffNtdVLBv5GbUt
	T4/N8bDZFmL5SyurxQz6CE18eQVA/xOiPJ2YynMdMfB6JHm7ZVwqNrlHOl/7AzFBzGx0UXpM97I
	tGlSS1iClIhVLT8HQPOZ3RuUpqHKKBaN7uAy8XxfWAlQTMEiJSdbYhRTHP0HHtXq8fk4tVBBZ7o
	3TS2ZZo5wQlf/zF/yjASz8C2iORRQfXBPxMJMqMO7lI/9smF2/VRyR7nBCudnPiBq4IWKDrpCiQ
	NOVCv9iMLJfdlZhPV9nHSiY9kM2YoAxHCw4hbkmNKd7NQhkCDHpN9M6ge16Va3AfSvESmFAhJA6
	rsgiwxVr1m8q29A==
X-Google-Smtp-Source: AGHT+IHjkdFCQnQAYQeGOqDyx9KKQHEq6m0hADLxusTCyX0totMmpj8Xv4mOWpPIiIo9PLNgYHNBAg==
X-Received: by 2002:a17:907:d10:b0:afe:dd9:de24 with SMTP id a640c23a62f3a-afe2979fd28mr1183255566b.60.1756188703469;
        Mon, 25 Aug 2025 23:11:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492da4b9sm711067966b.63.2025.08.25.23.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:11:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 2/4] clk: tegra: add DFLL DVCO reset control for Tegra114
Date: Tue, 26 Aug 2025 09:11:15 +0300
Message-ID: <20250826061117.63643-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250826061117.63643-1-clamor95@gmail.com>
References: <20250826061117.63643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DVCO present in the DFLL IP block has a separate reset line, exposed
via the CAR IP block.  This reset line is asserted upon SoC reset. Unless
something (such as the DFLL driver) deasserts this line, the DVCO will not
oscillate, although reads and writes to the DFLL IP block will complete.

Based on a3c83ff2 ("clk: tegra: Add DFLL DVCO reset control for Tegra124")

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/clk-tegra114.c | 30 ++++++++++++++++++++++++++----
 drivers/clk/tegra/clk.h          |  2 --
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 186b0b81c1ec..3eaa97c7d79e 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/clk/tegra.h>
 #include <dt-bindings/clock/tegra114-car.h>
+#include <dt-bindings/reset/tegra114-car.h>
 
 #include "clk.h"
 #include "clk-id.h"
@@ -1274,7 +1275,7 @@ EXPORT_SYMBOL(tegra114_clock_tune_cpu_trimmers_init);
  *
  * Assert the reset line of the DFLL's DVCO.  No return value.
  */
-void tegra114_clock_assert_dfll_dvco_reset(void)
+static void tegra114_clock_assert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1283,7 +1284,6 @@ void tegra114_clock_assert_dfll_dvco_reset(void)
 	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
 	tegra114_car_barrier();
 }
-EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
 
 /**
  * tegra114_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO reset
@@ -1291,7 +1291,7 @@ EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
  * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
  * operate.  No return value.
  */
-void tegra114_clock_deassert_dfll_dvco_reset(void)
+static void tegra114_clock_deassert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1300,7 +1300,26 @@ void tegra114_clock_deassert_dfll_dvco_reset(void)
 	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
 	tegra114_car_barrier();
 }
-EXPORT_SYMBOL(tegra114_clock_deassert_dfll_dvco_reset);
+
+static int tegra114_reset_assert(unsigned long id)
+{
+	if (id == TEGRA114_RST_DFLL_DVCO)
+		tegra114_clock_assert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int tegra114_reset_deassert(unsigned long id)
+{
+	if (id == TEGRA114_RST_DFLL_DVCO)
+		tegra114_clock_deassert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
 
 static void __init tegra114_clock_init(struct device_node *np)
 {
@@ -1346,6 +1365,9 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
 					&pll_x_params);
 
+	tegra_init_special_resets(1, tegra114_reset_assert,
+				  tegra114_reset_deassert);
+
 	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 5d80d8b79b8e..58e860b18e5e 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -898,8 +898,6 @@ static inline bool tegra124_clk_emc_driver_available(struct clk_hw *emc_hw)
 void tegra114_clock_tune_cpu_trimmers_high(void);
 void tegra114_clock_tune_cpu_trimmers_low(void);
 void tegra114_clock_tune_cpu_trimmers_init(void);
-void tegra114_clock_assert_dfll_dvco_reset(void);
-void tegra114_clock_deassert_dfll_dvco_reset(void);
 
 typedef void (*tegra_clk_apply_init_table_func)(void);
 extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
-- 
2.48.1


