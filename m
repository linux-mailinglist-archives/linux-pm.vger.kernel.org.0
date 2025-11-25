Return-Path: <linux-pm+bounces-38580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70FBC84E5F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D20C3A3A41
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69F322740;
	Tue, 25 Nov 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InJSXmoC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E3320A34
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072393; cv=none; b=Bu9l0+6cpRJyDQrkkY5rzGFmPjnJBFPQBDXYWoR2LKAh49hZ8MdLfFO/yxaOS9NE36lla3+pxQOC0ppAa7vPiq+yKqxi8yucOe4l15ZnAyHGvFP1gHyCFYVDV7CMZotr+8jQ0QthZppUzPNpwcPnxd9VIJAe3VmUuyN3kBHA9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072393; c=relaxed/simple;
	bh=0XVqOHYcT7n720wnH1cgjwBE24hrHgCE0m9zaQ1pJGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKp73uHOzS7HfKrtjIQC1r7wxoC0+UnPw1tDD2a+l8wmO+Z/L7kGG0bx/g2DyVjKkbHcA+OfIVMtManORNS8VvY4ICEjbHEH+SanIx4SxJ2qrDkxjlRDv7F8ue5LfMzwxAI4ZJCyHJZrRuDvv4znPI8icJG0EjgXbucCV+CuEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InJSXmoC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5943d20f352so5575215e87.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072389; x=1764677189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5WNlBYT2Uj6LLmyZJ3IXERmQU06xOhrcyW5MYrfiFA=;
        b=InJSXmoCeiiQx4ai9bvt8iF885jElanQAoPbfwo+ftnh2+zsww+e9BgzuP2URAzBHx
         d1Fw1gMjmbBhYQhwy+yi8zOa5LtFkE4top+9tI1f+fVv3QFD3iHlUsG/6MCU534fdOgb
         d03nW38y7WmuX+CM6ximquQ/u9e4Fsg6YglH8jaxOna1Dxhm8YTrJuxY25yedKcWuwSL
         5YAL/ZdCGEeU+YO3ED058LHe1DMT2hbDYma4lJBxwY7XslVwkOrfnWseNTn28yoc+DV+
         ajQ65m5bi9ZCxlc6/GmKY1Sw4CWoYUV0V9ZOdUl3If0s60ZwMEPON09OuWThRmXUF5Zx
         9epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072389; x=1764677189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5WNlBYT2Uj6LLmyZJ3IXERmQU06xOhrcyW5MYrfiFA=;
        b=UPpsq7PH60jJuX2dPHdeo8t0Jq47jpm8kbFs21D3Z3kHDZ+tMqjk5yVAEMDbLkN4Ue
         cLGHwBNdQTNugEWD48snppB6gVU5QO1NzWmDLd2qc+QQEYZsYvR3Wuw7DlFjqIhttN0e
         tgO5aXxyNa26rhqny/iU2BTpaBbTSSK610+W3zNkV6fhG+ek0sfcYjOpfXQSbJoxMkhT
         o/D7BLyW+Zv40eFDZbg2Fif0T84hIWRoWNP4Z3o8AV2gOWEi9Y4PSfO0mC5mJPcwQOh+
         sObkTuPt57ZBwKhV+IIuguR6m7Bjp5cJjFRptYmIl+mnQLBDfHSfLmCOMm6RadkQIN+v
         KZpA==
X-Forwarded-Encrypted: i=1; AJvYcCWoalKSEWjjYb2xQ9wgllHsMnrsTeyCxQN1oHV/S9bb7Gp+qxOA4KCF0Q0CIua0OiIvgU4lPSunpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuIgfNNXZDpeuHCq1xJS9aBym4IL+wMvi2xpOLkPcLUcYTmeQ
	4Au7TTQCcGzz+KInNDIcar9+hLrXVFtxrtR9/p9/QKU53CdIETGVt2rK
X-Gm-Gg: ASbGncujhbAJRomLKk/cw9Ng13ORqhJb7LygmQ/qyo2Qy19uLrrA+MqnEPyed6oEiLl
	eCyRXd2EV3WTfjD81tDW8FwU8gbB4/ROVFq7//acEBxBOKCOse8o9PEUX019GB6nKsjao1zWPsy
	RFhYV9YCZ/c1QvncsbFTIGHcqZqFRN9QWUBpAa8r98XxXyCco35jSJZyHIZcI8FAzQviW+tJqoH
	A4kb2ifGvTQpRt9P3e8rKs3s0YBVA+kRYIK/xlnmWY3J+wTsXwzDHF3YF7+d+Yq0tg+ySlWWIyz
	dx4WlA9IgiIpHSnDEVYkMWqOzchcqp7zJqDqCXqiGgHVNudJsdpMLJzrMtQsf9YtE4yis6U6oiZ
	Pq8lHHnk5d8T/nwgW4Us3LYJn9TGvjdVeGjDH0YGUbuWqDuOG28g6JZwFpEVVJCmQiBu/Fzxo8U
	RDeDLCMqQD7A==
X-Google-Smtp-Source: AGHT+IHsvV73iCsg1Nwxo/fBsVh2b9bPW7NvyGDXndOdwYhh1h8BJuTE0RXG2eDeb0/M5MiGhzgcdQ==
X-Received: by 2002:a05:6512:3c98:b0:595:7c47:cd47 with SMTP id 2adb3069b0e04-596a3e983camr5380015e87.2.1764072388565;
        Tue, 25 Nov 2025 04:06:28 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:28 -0800 (PST)
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
Subject: [PATCH v4 08/12] soc: tegra: common: add Tegra114 support to devm_tegra_core_dev_init_opp_table
Date: Tue, 25 Nov 2025 14:05:55 +0200
Message-ID: <20251125120559.158860-9-clamor95@gmail.com>
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

Determine the Tegra114 hardware version using the SoC Speedo ID bit macro,
mirroring the approach already used for Tegra30 and Tegra124.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/soc/tegra/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 6292a1c72071..2264dd38893a 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -143,7 +143,8 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 		hw_version = BIT(tegra_sku_info.soc_process_id);
 		config.supported_hw = &hw_version;
 		config.supported_hw_count = 1;
-	} else if (of_machine_is_compatible("nvidia,tegra30")) {
+	} else if (of_machine_is_compatible("nvidia,tegra30") ||
+		   of_machine_is_compatible("nvidia,tegra114")) {
 		hw_version = BIT(tegra_sku_info.soc_speedo_id);
 		config.supported_hw = &hw_version;
 		config.supported_hw_count = 1;
@@ -156,7 +157,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	}
 
 	/*
-	 * Tegra114+ doesn't support OPP yet, return early for non tegra20/30
+	 * Tegra124+ doesn't support OPP yet, return early for pre-Tegra124
 	 * case.
 	 */
 	if (!config.supported_hw)
-- 
2.51.0


