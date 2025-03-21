Return-Path: <linux-pm+bounces-24368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5BA6B830
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 10:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9127A5816
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDDB1F3B8F;
	Fri, 21 Mar 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heuTFNsx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E618DB0A;
	Fri, 21 Mar 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550980; cv=none; b=Yjj/xgvsd9Fv5JVLvwINtpI7jrwDl0jNGw76aZf/LKmTzm2WKuwoCtSk+LFdrKDtwRfifjGR4FjkU4yiOtVTT5a/FGWN4FERrrLhNZM0IO2ojbIQiUIZrjn05n/dukoywLFKIiQanCEVlapUz6hS5NVGct5ADUbgajWbp1kS3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550980; c=relaxed/simple;
	bh=PFXW3BPWI4tg3WH9tCeZ9sRfoQYxKrwfsg4KfEOyEXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cg2BfCZpCbp5ne0ketHT9U2PzfVUB2u41T/nQqNktPr3oKYQ6Q1jTFxEetvwOVZFSdDnIKh9RJljnAJDTx2ryxRcF3CFHgUbnvZ2L/Jf65F/xtwi+dOVEY6DSyVEf4yQWmvR7sy9iHiLyLlPGDC0t3tbIR+BiTpCaMXAvft3Djw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heuTFNsx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2963dc379so295179266b.2;
        Fri, 21 Mar 2025 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742550977; x=1743155777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcYtJ0zLlagbm1t7aK6kYpcjfzHf0i3DEXlLXLLnBO8=;
        b=heuTFNsxo5ciZ6ZlKhMHCQMcb1d+fNxrluNtkfXIkP+sZ+mBpP/HNg7db0XdfMQFEV
         IPAX69i6vJX4hRumstcoNove/HrMd6Ywphi6uq+zgMSOusOgEdRGl9m5iCSfWAlg66FL
         xAuU2HTRQByIjPjV5Lqazsda/YjQeQUXH7in0OkfM9WElwJrG4GzW7deWIBni17BmDdZ
         u8rFA6LMioRR9AX4w1TOasnO6XpQRfKgdz6jEjqwGsXQkiTzvTVJHrN+D3LtPB2mStxb
         Pc7YAw8PJCS2Xv3BMAe2BCvC+RuyVHBxsQBkDwiXq3dcZT5qB50G+5+PoamNHo3xgaYw
         gwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550977; x=1743155777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcYtJ0zLlagbm1t7aK6kYpcjfzHf0i3DEXlLXLLnBO8=;
        b=h/GLAuph5bCiHDPJEzwA+DTNV3qHCYrUt1T1quiWtNG5NwOonHNkS7W011bWBo8Iuk
         ypL8qE8UJbbM91jTstWFGK2q7iXgUOUXUE8myZIU8PZIiZHQYEw0+hUWJml+CjlA6cQZ
         zgLYF3Z9rav+MmxmzYXBFpedhFE1CQgn6AJ5v987K0faCmYSiHij+ps4BJ1MlxHwMb5f
         c/B7aq6/VAICBXnHiG9/3wgkD41gn9tKQojLBSbhvpkHpME6j2B7IMSvEQVlN/dWw/FE
         O0h4fofBTGYgc7Iijt1DI5565B7gY4CkWtW1Seazq1trDPxHampUk9R3wz4PxI1u/4m5
         KGew==
X-Forwarded-Encrypted: i=1; AJvYcCVF5xoF0dcHmhzEy1oQUW3IAy52f4fTMTMTF6yEHAsbZO2oLNJ6OKP5aJHSt3GcFWruPrjdgOW0DVdXkzKB@vger.kernel.org, AJvYcCVv7PHbHhPP6T+/QU3QcSsd9SGeEseEJI5ESGwiTtP/Oo+OQbQUoZvHfk9kJ07ZjtlDeReiG+FxWTg=@vger.kernel.org, AJvYcCX8nyV/KrGbYTWmO50Jcuk85VPN/piG8GOFxSfBZvIkOBX6FvFHIiCSJOKMz3xCw/V7GqHBvtNrCdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRzNHKwiyT9HuOAMjJ0hdEvN9Yl3K6AeW9IQKIclizOvKhDGS
	55FcKt2GlA543TgEh9CSh6xvRbhRCeq+ZTVy0w/kJJb944cRLYUL
X-Gm-Gg: ASbGncvfnPYHVFA97DBzGVLBefCt95JGi2ec0MMgt19p6jIcCKOvdFci2TFvVDiO6a0
	XWZdQTU1QPa9vVvIDn2xN2IOrvmwccHn0RPT9HPM/b6pAWohsW2dbw9cPrh2tWW9O2m8BtVPAfn
	n/lOPX/kwWlErXfrqU+VDILYJHc/lfSVsC79MgwZrw0rB3bQrghTV/BsBW6bA94ySJfOKS4BH9t
	7aRzsQT3uHY9I/a3Ihq3vd1llork1tQbC10j7Mm95QZE2iVsRw7nTa8jzLKScxujucAqDtZ38Ag
	cRFWWYXy8Pvj8QZQUhV9HgpGO3mJtXcv56FD
X-Google-Smtp-Source: AGHT+IHMeAJeclLeqxwAvo3/Nf8bd8OMefhwPdUDTnMhBHE9rBetuxBamtyOftj0s7csc7f77yi0jw==
X-Received: by 2002:a17:907:a088:b0:abf:6aa4:924c with SMTP id a640c23a62f3a-ac3f24757b1mr204187966b.17.1742550977072;
        Fri, 21 Mar 2025 02:56:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef869f19sm122300866b.33.2025.03.21.02.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:56:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
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
Subject: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
Date: Fri, 21 Mar 2025 11:55:54 +0200
Message-ID: <20250321095556.91425-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321095556.91425-1-clamor95@gmail.com>
References: <20250321095556.91425-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tegra 4 is fully compatible with existing Tegra K1 cpufreq driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/tegra124-cpufreq.c   | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18942bfe9c95..7d15a1224d37 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -140,6 +140,7 @@ static const struct of_device_id blocklist[] __initconst = {
 
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
2.43.0


