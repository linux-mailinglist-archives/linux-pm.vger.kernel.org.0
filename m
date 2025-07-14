Return-Path: <linux-pm+bounces-30766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE3B03911
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A529189D9B0
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EEB23D29A;
	Mon, 14 Jul 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx1cpQs4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F26238C0D;
	Mon, 14 Jul 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481069; cv=none; b=CoP5Y7jJXOZsOysgk3zSx4HAjUNxrs3NO3odgDeWorIPDYlzWeYxqSjdRuJbhUXMTrMkPDW2DCk1PuzEFJa8RL3Fgjjy678NjKiqXJc05a1/LzFNHYDCilZd6yG1tRpDSfIJXgDUohzZmjRAQYTBC/HtVnh4TGOIeaXFRZmBp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481069; c=relaxed/simple;
	bh=RRFQPSwJuaiSQ6xFygps3+8PlZqDpZJw+OjDLsZKys0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiL48E97ty0WvOYO34DWqbEjb05h/ymTzgQmd3q3C7UlK8FkK2+2bTZQQGyqa5t6SsaoOSwPiQpp4CGLZMuoaFvEw1yTFgSEJate1W0IYSedADNsCf4aL+7sSBnb/QYx/mLR5OOfqWKSdpr6/FVFnqZvbHGr/RN1IH3cf+nM1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx1cpQs4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so842394666b.2;
        Mon, 14 Jul 2025 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481065; x=1753085865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeYEZUJvoBt0BYac6VBGNOwvufSSWTJUzzIUT+OgjG4=;
        b=mx1cpQs40pXBhHtiEHGFBOywCW6hHBkEJBA9qn4nKkHDT8Yya379Qikp7XGFiUdanf
         llF2aZaxb8VcBj932ctooM20Pg7ANQTdCc/Q6zVJKsPQE2Gvkq1Xd26ji3oFYIYUvvHD
         WV/1gvZZC0MPheOIBvkUDrBRkpPbREuRauo7MKOsRGB2PDtbKle750207qWziWC/gWbC
         K3Hjsc08DWRPSMNcyPnztRlkvQMQIxL7sVP8Gk0NU+6IO9PkvA01aUdsi3DBxBMCdjvF
         7GcjYNANeUs3JkskbnofWwR639wzayLk3peMoztgrItcbHaVgSSyIDHcbKmh8Dtw5AH3
         mM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481065; x=1753085865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeYEZUJvoBt0BYac6VBGNOwvufSSWTJUzzIUT+OgjG4=;
        b=winbd7ShSQtuCSxsydkSWfE4sw36WsZ6lKjw6zXKnO2OHeLyAWOfiOj2NeJZ4vUM5L
         XqkGcFsNaFhsZyRwMoxL2nz27kcRT8sSRN5kscqIUHLn0tOpZc9Xxn/LbMOZmIuEBS9X
         AGlseoRbRZUlMVaRKCWCgMoffwzt5g415BtF9GbnkxtGM5NO8F/rtpJGtg2iQh1jE5W4
         Ajq/QtOuSUsoceTnlHCsdQU6H0EI3+gNI86RCEw1v9mh9hRZbxOWY8NytdH1GrHI9kPc
         ZhhsW6AHmpEVZpSX7K7vGaxiV4KWypwSZRsE/lmaNMaAYR6c76h6j92PuDGPvvsPt4XS
         IhbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBy0RZDKNpc48hjP47MetBNoW3H/Z8kYl0rtK0FgHeoqodtQ801FZj8rOPzY52s0x5zxUlwzNB0XQ=@vger.kernel.org, AJvYcCVDXWxOh6lV9ZEWRNXre1pBJjw3T+MTO36XVs/LDic/EBLRA6O1YUmKY5N8tP11heo97Bb/5rqKj5j3FoL0@vger.kernel.org, AJvYcCVuWeXaK4RrluwjpuGEO34QC1OjyBAv3900YasrW4kvmvEAIyN3GwtyhY4kFPxEaJ463gz97vf8xpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGfP5/0pLFk3FRUfKefATh4gDoHGXZhy2A9W2y8rCV4AU0VJV
	mk++SD04T0TBQ1HG9SDYW8nUBUiFs6tyBCro6+sA+xyHveCYZ5kZQh8+
X-Gm-Gg: ASbGnctnmNtgbjeGNnxYPr2PLsKIlo7MmSNTXjEJX8ZxARYIquEiiOsVaKOnHdR1ae2
	7VHauqD8e6Cx8toynzpV8Y5LY6ufg2noYLGCdleS2VqJ7E6JS6algz9QHosumUwmRl5e4rUrrUx
	rl2sgK4e1oFdeI2QmPAdqUUFyfLc7WX7MiBPyyieZWBw4X/cgR1m00G3svViAOR05D7VNsAJIPu
	SCNtKjsMAj6mj/EPwMjN/CFUvpTHPNhCei/Za8VGwQz72G/t8miOXBrJXMUm82+n/fQaCcroFEv
	+yuNxzKSwYCzBci4BTja6ewfyYMZcQoYVialtJ6wXHkDsnnX5DRGGaXkVowNHOCZ+dHEqFEgaP3
	MDpjbLbFfQXhk/kIbqSKBuXwh
X-Google-Smtp-Source: AGHT+IHfOzspiJ/OkV7AHgpVfrIGNa3hQ0cgiSDc71PJ7Nc9sWphWwHE1DbY1aVGbbX3TN2qnxkV4g==
X-Received: by 2002:a17:907:1b1e:b0:ae3:bb0a:1cc6 with SMTP id a640c23a62f3a-ae6fbdc90e9mr1095726966b.16.1752481065146;
        Mon, 14 Jul 2025 01:17:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e949f2sm787867166b.34.2025.07.14.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:17:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
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
Subject: [PATCH v2 1/3] drivers: cpufreq: add Tegra114 support
Date: Mon, 14 Jul 2025 11:17:11 +0300
Message-ID: <20250714081713.8409-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714081713.8409-1-clamor95@gmail.com>
References: <20250714081713.8409-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tegra114 is fully compatible with existing Tegra124 cpufreq driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/tegra124-cpufreq.c   | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a010da0f6337..015dd393eaba 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -143,6 +143,7 @@ static const struct of_device_id blocklist[] __initconst = {
 
 	{ .compatible = "nvidia,tegra20", },
 	{ .compatible = "nvidia,tegra30", },
+	{ .compatible = "nvidia,tegra114", },
 	{ .compatible = "nvidia,tegra124", },
 	{ .compatible = "nvidia,tegra210", },
 	{ .compatible = "nvidia,tegra234", },
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 514146d98bca..6ff2ccc08e5e 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -189,8 +189,9 @@ static int __init tegra_cpufreq_init(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (!(of_machine_is_compatible("nvidia,tegra124") ||
-		of_machine_is_compatible("nvidia,tegra210")))
+	if (!(of_machine_is_compatible("nvidia,tegra114") ||
+	      of_machine_is_compatible("nvidia,tegra124") ||
+	      of_machine_is_compatible("nvidia,tegra210")))
 		return -ENODEV;
 
 	/*
-- 
2.48.1


