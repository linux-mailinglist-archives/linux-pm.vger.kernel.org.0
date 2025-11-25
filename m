Return-Path: <linux-pm+bounces-38574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A21C84E0F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5378334EF29
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60D31B81C;
	Tue, 25 Nov 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqrVM0nU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42D31A818
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072384; cv=none; b=jI1lljjyxdB9ajdefn4ZJbKA6iMCTjC61ZZWyNLycxBUb8b1VMCZ4gId1uy+ZNBXGM9qYdGqzA1Km221Knybm9N4JCT1tS/FSZbCv8wzVij5NlpyLc2XovIPw4Asg6ChsmyehH95WuxiKKKIBbeDQDwVmoDNMS1cR2TOKN5Hm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072384; c=relaxed/simple;
	bh=VJS7tKi4W2dCRDnFqQGBe73LZKmaMcajj+4bVj7gZPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4Lw3PH1xdIXLblMSo+fqEp1yzJkCbiDsUsZ3spbEAx766l5wklR3ReyXEUtpkmu3bDYX6HQl+zClRfB+LogcWaBtNRRrNCMlqnMDE+RGKWpJsWsq2OxlywtQtaXwQbun6gjExp+raVZJSGk3xVD2ApaVKoj+ikIA4UGwQ2Yat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqrVM0nU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5958187fa55so4166113e87.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072380; x=1764677180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW/vKp7i5enJJG2aIk5G1BDDlAi5srul9SKR0E7oEGI=;
        b=RqrVM0nU7z3YDn+TCWkGIGIom8LqdYPoKnXH7f6erTb5gohkF+rBvm5Blus2itCW5z
         NVDAzSxU+pzLDmZsRiqC4nDdXT0qmY79W39/XDpKM2EgyacSbCb6sE53FT768kNmAunN
         E4DjJFhmLGGW3e01nKTVpw+RewbvjTTxtPiqMa51UsYms0f5QSbFBA1uAIlYhj+ZQbz8
         Ovnwzr9vTh9z5OP+E2c+qEaxEONKAKePfE9m/8T4dalEGBAvInU0HIqiCqBFN439nGA0
         irQo9dxLGHyvjsA+zI2ZfYJl4Dt3cVAQNAP/1xqF9Kb+NfoXn9t7siIt4gG9IUVnZ4My
         unCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072380; x=1764677180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hW/vKp7i5enJJG2aIk5G1BDDlAi5srul9SKR0E7oEGI=;
        b=i1L3FMtCKgwr1dQfVG7Xpi9pbWgSKW/zWlrD2l4cB5L8EWVWuO0IGgL0tZvJTsZVpC
         GsjEFs2rnFOca6yEvdE4QWvDQW4EmR4tKXMLV2frKRGvbGYWHtfynQXUzUlnGHQaEoxw
         vgADEHw7wMmZ37qnePZ40xl2JGB5ApBVFL/m6qRw5l+M6BrA1vNvlOp/KgdShtvAmEz+
         josIRvVEU3rBsU94FB3V7cXKfQYLwBMLGp8sxVeJGZuCJGyVwBkx8Cfb1S9el57V7bZN
         BHhbOPB7GBFp+ZMk51HTBEx+XNnt/DOqcYOZ19HiRcYOHD60ywxyPDoJfN//AIVNA0jI
         EF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmdQwDTtPF531FvonhVVJWOHJGxoOyTNQ2bjNFDcVSVODKDEixUq2WEES3F9+izUzS4DcoFHomxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2cLLBt5AsgYnhR4GfkvwoBCUHaJ0cXi9lr9u7hHPXbTfWlJp
	16WqYMSrsQO0MIpQh9LpYUp2QX+1Q6GwQRCUDhjBsxOPT5MYsJd/ebEE
X-Gm-Gg: ASbGncurfIc8IfNhREfPMZuUla5TgHAWhwb5mVAhopuQk7BQHo2G2JEjemMj5ZvVQ2d
	HSJhLFQO/qa2IslThLqh+2Lji64t1xj7c7YIknwrTjU2MSPRG8HM/JdfA3m0krA/NhWSQeHlJ2q
	CAZ6R+Ywm3KLOyG2xd0EWnHzlEus+6tkBdzyI9MaTJvneE4WWRAfhOIifVFIzFfy8H6CzQ28fIe
	F8FU+phdodqBHMi8/lJkEdKwxDsTEJ4+USLrMB/7jWXc5IUtqoCK1dJ3KT0jsV5Te+pWKCouA6t
	OJjFinOaxadufU1S+9DeELNZ1DC2Uo+DRkxbqYLkwp8jowTwxYcDqFZ+e3nU+g6+ugKLnCJmwW1
	doEkyOOiTRhTNicBqTgDQufQLPPqM9i+XN/8/ncI9M2YjIvu2c812oPr68/hJHc55wDtx4/1dwU
	0=
X-Google-Smtp-Source: AGHT+IFhjLrOrFiZOapYoRF+cu0r4FsySebLxdfYS1eENEYxZ3es+l0zFrltALiMuKz3JAOnaS+NTw==
X-Received: by 2002:a05:6512:2244:b0:595:8258:ccc7 with SMTP id 2adb3069b0e04-596b4e4b8camr1176446e87.1.1764072380177;
        Tue, 25 Nov 2025 04:06:20 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:19 -0800 (PST)
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
Subject: [PATCH v4 02/12] ARM: tegra: Add ACTMON node to Tegra114 device tree
Date: Tue, 25 Nov 2025 14:05:49 +0200
Message-ID: <20251125120559.158860-3-clamor95@gmail.com>
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

Add support for ACTMON on Tegra114. This is used to monitor activity from
different components. Based on the collected statistics, the rate at which
the external memory needs to be clocked can be derived.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 02d2c40dd79a..ef0618e9eec1 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -312,6 +312,18 @@ ahb: ahb@6000c000 {
 		reg = <0x6000c000 0x150>;
 	};
 
+	actmon: actmon@6000c800 {
+		compatible = "nvidia,tegra114-actmon";
+		reg = <0x6000c800 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_ACTMON>,
+			 <&tegra_car TEGRA114_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car TEGRA114_CLK_ACTMON>;
+		reset-names = "actmon";
+		#cooling-cells = <2>;
+	};
+
 	gpio: gpio@6000d000 {
 		compatible = "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
-- 
2.51.0


