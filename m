Return-Path: <linux-pm+bounces-34630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F056FB57241
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9470B17DDB7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6692EB5BA;
	Mon, 15 Sep 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9o3Awbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254E2EA159
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923347; cv=none; b=Q3LdK2FVCL+/JfGXnCHc4a5Cmbbx4jNZrX6gNu6lDUINCSJBC47dcAnyIch3XTAZyAH6Ya1R2X3Zs6OPkeqrGqppvgY4aztjtgwHuqEeSQQPGSMd5mvd7IOziFtFW8OjtpVDbr+96cdJdMrEsQs9Tc3DnxK6/dAnNuqNDthvYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923347; c=relaxed/simple;
	bh=zND4GhxFU/tz0sYLfWaRU8glzS+okJHK24B1i0p/cZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGqrYghAQAMuYOyF8Tr22FH21hQIqyLrNiFI4Fzg1l5RkR5szjc+snQWkEtwjdrqi1HPqXhljRpy+g1QUN+EMZPc1gfex2o7j8n9c/2Ej0toX7TMrU1swlOVUZG8kpmsTvKTLN7kZqa1w9slIPW65qgIs0JhGQcxy89YJfglSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9o3Awbg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so4443550e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923343; x=1758528143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+y0n2iQaoQRxXuIEAJP6wVzz5TSA3TjXyGRiIjZrCw=;
        b=K9o3AwbgmZiQ/wdnFKUyEc2dCx6D5gVDTz+yZRekRc8pJdKcSydcnbf7psHj1pdExI
         ofMDtNmiLOP7w5RTwWU6LvrqtDlzIuee2jH7VEtVnx67GMh1gTQ5fZsfFHRNT5Oh/Kwu
         HMgy7QX2Edbvgq29gf1Elrop4XC9Y6+yMjd6E/8MdqlSVXS5PLPUupDqE2t2/AJiy98Q
         O3RP1xk3wP0CDTEdYpkcemPWEjF57hYoLVFH1TkJsFATOaTM/NSGHqiJmcUJrZK1fjaw
         EPZkICu3B3UYEQ6zlwWHRnpNtxOSMQCkyvnFp42A/5FgaA83NVqRogyN//XnhvlMa0Ck
         bupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923343; x=1758528143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+y0n2iQaoQRxXuIEAJP6wVzz5TSA3TjXyGRiIjZrCw=;
        b=Fh5rSvsx7ZY1q1A8NvPcAWAAJkgZ/Dpg1I5XJ2MDObrnlAPQP3FA4ag7PBa3TUUH03
         ALp7EsKoGsf35hbw67Gn1QfG0X6EjdPhe1kF+x7Z43xBX3UP4cZKwTU/yCj4Jc59guV2
         +LVyOuXnPYO+jPz4iprdW33JVhAIfnw0ZRDQwDUjVDYMRiI+3TfRvxwCvQitTVH7CwXb
         EuCLdO5NHLeRFoM04nJHUi5Ajtz1BrXpxqArP5O816jUULIgw3nXMF7YAh6c7SBnXsQl
         3I04cRWHFFCDAh+roOzDhPw2mJABpwiazAi5hHTRK7SQ5KBo49x4/ifM3V9Bszi5IN/w
         EliA==
X-Forwarded-Encrypted: i=1; AJvYcCXuwGLF4sRJVQarKi4RYvgr9Wc5lE3+nTvPNgOy6/iPO58Nb2t3/7KyiBs/gYlg4PALG72JDPzD3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9VaeE4RWWtD2c56WCt5GxVs+QtCOzKj0SyIww6dnLAtAUsdD
	79r+/kjedd8Bb8Z1I+iXQJLx6xHTeEwEDDE3NhbpAnX5xe2gQ7IJSsT9
X-Gm-Gg: ASbGncvTFW6Pf4GriW5qQ8bU1oWsUYJ1GKRcVRwztlvL6hdr0lt+sv5yzrzDoJNzc2u
	+ozMfOVqvnpP8z6K6GcQa5ZtEohrktd86PT68mHCxYDP9X1UpxDjAdUYEREYeGm1Q9CIsrhiLyn
	2MM1H9ehoksnPR6IXgQ5d6kG2QrwnqmByU8CSoLyodbMQmfojgtQ9I8x/r+pP8zzMvueSVhaTb9
	8VV+WRZz3jWT3/q+XO1VLXMUr8NIlqocLeuW/QrfgTUA8JcBhEoJdZvGQ82TlXPBdrlHLf2Tk9t
	g1vPK7Zve6gLcC2GOvstPAF3hfY01Wys40BbHWwV0fkACM4ReQnI5+PTkXPz6asHg/19yaJmqcz
	RdAaxLuXxzP09gyA16kuwU9u9
X-Google-Smtp-Source: AGHT+IE6lsTSCi1HbUYjhR6DRaTx/WD5l7j/ig8VpXqBNn3d/LYOB9q6iXpX88ot17AUCeJYiqAUPw==
X-Received: by 2002:a05:6512:79a:b0:55f:536f:e89b with SMTP id 2adb3069b0e04-5704fd772d9mr2486614e87.53.1757923342570;
        Mon, 15 Sep 2025 01:02:22 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:22 -0700 (PDT)
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
Subject: [PATCH v3 01/11] devfreq: tegra30-devfreq: add support for Tegra114
Date: Mon, 15 Sep 2025 11:01:47 +0300
Message-ID: <20250915080157.28195-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
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
 drivers/devfreq/tegra30-devfreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8ea5b482bfb3..d976077d4757 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -980,6 +980,7 @@ static const struct tegra_devfreq_soc_data tegra30_soc = {
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
 	{ .compatible = "nvidia,tegra30-actmon",  .data = &tegra30_soc, },
+	{ .compatible = "nvidia,tegra114-actmon", .data = &tegra124_soc, },
 	{ .compatible = "nvidia,tegra124-actmon", .data = &tegra124_soc, },
 	{ },
 };
-- 
2.48.1


