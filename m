Return-Path: <linux-pm+bounces-38573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B949C84DFF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 125534E825D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188231B119;
	Tue, 25 Nov 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1czExDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4960318152
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072383; cv=none; b=tIMON3X8kB5k0FNw3zR/yIhOT0rwU2fGmJ6YY4eL+s/0FFmHO3qdJJ3Un+wUi6qLuSqpPIvghGdcxYbyQvgYAKRfnRXH2k6gZ1JUy+zAKO6BYN+35SoP/kSR7CWHaElZxAaYIP/yNeRBq2kh4BTjzQE8nNsEqCTeeXroGslEjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072383; c=relaxed/simple;
	bh=oSxMov1SESrAgpKKZcLn4WtxFn0hZta8BIUSnqu+iNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN6asxbJtNiJVWyqevbTvaZ3kxbu3b9LYIq9U/WUUW3trWBs3YurXcCr6IuEV21tInTTxA+fIDNE36RNYqxFHAUFRhYVaoZ7UquYqSwg6BHL9FyNDULsCkqJxVJPKcjSjEk4S+BDr/UPeoZKdhnukqEklOgv6EnqISEGolb7WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1czExDw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59445ee9738so4107599e87.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072379; x=1764677179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQgVO7SUdIDltP6h5MVysIssYHMNX5v/mXvkkoKdSwQ=;
        b=k1czExDwJZmYSaGUoDNF3wafP+LkiTmWpEq3eJgODWVtvNp97tx3MXr8Dw5vf6OFSl
         bHyItokgSY/CTT4BbDg/x6WQJD2cZRKZWdCWHtpNLdIkQVYNFCoSbiw08KVPOkXOwthW
         xMBtUwy9U0m27G8BDMqRKnz/Dp4HLQR9iiGMDOeW5mRkUNoqoZlRH+ss8SFEPMtUlX01
         nkfe7MivbEsRLI8qUDPeMP+zCB8ORUVtmo9aHOZYoj+U1Z1LJER2HSOonSCzChJvR17u
         wI2RD7lIOB9XB5QJciVWKRyxxM2stn6KGi68VTBIvJ6qYUt8tqgSjUreKp1qYxpOM1hP
         yfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072379; x=1764677179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MQgVO7SUdIDltP6h5MVysIssYHMNX5v/mXvkkoKdSwQ=;
        b=mci6VHniBP0LdA6+ffSzMHPLeUMun1s2K/TgF+a7ZWSGGgC/k61m/a6EQGSADWFUCs
         GYba+rPBQnjXKIUWIqSjVdt+aUWJMRQLWhGCvJ9GIa/Wkvi3zPCAIUe2q9dRCBqHt3KZ
         o7Jikfa/O7uSkAxhpnauhDceVSKJ/OJsQBLxkzyOmzUTTnW7Cd4CSc+OOOSiilcYJJGb
         /A8G3T2pO0jrrA9dXFOe2ldUdmFM6lvljbON5Vc6XaFKznTZ/MhQqRIXCM1D1546JGtK
         ngKZGHTN2NLYCwDixz7XhMOul3qK7McpVTwsXGdM1vWIzCV1kIxa6VhE8TEJwVQOVIw1
         3yyw==
X-Forwarded-Encrypted: i=1; AJvYcCXV6XeGt+miheytvBvlBaWKy96PxTJ06qmNGbKp+5GK2bnfALScHtgalTbW3XpjopVYebZXl0is9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIFrP2Q8PJDMUN90e7gRKsXiflTVDNM5KsJ9lPcg8UKQbPyJz
	uzVJ7hidUlmzBTyF8SursSM9Ri7S2RknmRJJhSzA2AewErGd4CBbW6Dr
X-Gm-Gg: ASbGncu3b9K2pogp0ZxPUZWWbp5OXjw+vARNsf6klk+ULgcLRvuVh6skVvUbc22DMTc
	er+iZw5FIRv5Xy0nZZiWYEXywTgeHIqKOC6lN387GDFY5PB35TgY+z9sqv88pqxUg822pwlrH4N
	KEKfaaMtqZsXOi14RTGG7QUd27hhP8yusmwaLUxnY3KanS2yhYZ/TWsqLrV7KS60gqmFifS8AzW
	Aeg1MTdKzyqT1C4zMZNV/aZedxfHOhoqw0h8dzI6+1N4YotR/kCcl9PjN1/taoK5DsBqyfL0Q7y
	OR6DUvi/1jejbIGuaQe2uRIOoY/MgJjBRkQPvMFui57FVfNK/ig7buvR++iLYfSKF9xQHCG0T9F
	gvhcckCK3imBdhXblQLOY6rNrldepGgDHD5S/G5HfRqls21huEYrp+5JRz66gZTy58X8fuqs7Ui
	g=
X-Google-Smtp-Source: AGHT+IGtM1PyFoR4RY0zhjHY2chTLDIVD6KPz0Yfdd6DO6DZabktBNfX2NguAOJht6zWvGQbtOixQg==
X-Received: by 2002:a05:6512:234a:b0:594:48e6:26b8 with SMTP id 2adb3069b0e04-596a3edd5e8mr4793046e87.39.1764072378784;
        Tue, 25 Nov 2025 04:06:18 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 01/12] devfreq: tegra30-devfreq: add support for Tegra114
Date: Tue, 25 Nov 2025 14:05:48 +0200
Message-ID: <20251125120559.158860-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125120559.158860-1-clamor95@gmail.com>
References: <20251125120559.158860-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lets add Tegra114 support to activity monitor device as a preparation to
upcoming EMC controller support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8ea5b482bfb3..fa83480a923f 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -963,16 +963,22 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * The activity counter is incremented every 256 memory transactions. However,
+ * the number of clock cycles required for each transaction varies across
+ * different SoC generations. For instance, a single transaction takes 2 EMC
+ * clocks on Tegra30, 1 EMC clock on Tegra114, and 4 EMC clocks on Tegra124.
+ */
 static const struct tegra_devfreq_soc_data tegra124_soc = {
 	.configs = tegra124_device_configs,
-
-	/*
-	 * Activity counter is incremented every 256 memory transactions,
-	 * and each transaction takes 4 EMC clocks.
-	 */
 	.count_weight = 4 * 256,
 };
 
+static const struct tegra_devfreq_soc_data tegra114_soc = {
+	.configs = tegra124_device_configs,
+	.count_weight = 256,
+};
+
 static const struct tegra_devfreq_soc_data tegra30_soc = {
 	.configs = tegra30_device_configs,
 	.count_weight = 2 * 256,
@@ -980,6 +986,7 @@ static const struct tegra_devfreq_soc_data tegra30_soc = {
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
 	{ .compatible = "nvidia,tegra30-actmon",  .data = &tegra30_soc, },
+	{ .compatible = "nvidia,tegra114-actmon", .data = &tegra114_soc, },
 	{ .compatible = "nvidia,tegra124-actmon", .data = &tegra124_soc, },
 	{ },
 };
-- 
2.51.0


