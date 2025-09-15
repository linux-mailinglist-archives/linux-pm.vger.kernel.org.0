Return-Path: <linux-pm+bounces-34629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B8B5723E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CD03AEEB1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8602EAD05;
	Mon, 15 Sep 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv/toyx9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28172EA49D
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923347; cv=none; b=phP9t2HhMYK7Ej0o4N8PhQvv4EGemCzriaT9BrIFpHopVZ+kRuDcPxPTfuuS7D36zL68i/mpMt0UuZEvoS4dwEpzGk/L9/E2xlU8xUa1Atnrg6ZfZ6d0xjYgO2aMRP6HToaXH7uMhluiEPjJlblo0dAtIWay7NkMOP5/VTDdDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923347; c=relaxed/simple;
	bh=y84VDV0rZer94jeWEUGutZ+DiGlWK+mnb2KewZUqkys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSSFi2YBjQRB7mqsmn+oS5njNDUSsw09rdO1OtwcSn4t1/sl1rIwUwzqGKitFqttjrUyGCv8sEhoTgsbO8fmyIrqjTaDnF4q8PqeqWlCYplcDU/+njQ6noUSvo9WmMO0fFfReQe9xcK6Agv60Upd0hj0S613LfU0BiLnd3gjJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv/toyx9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so4443577e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923344; x=1758528144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFtIJBuALfkec7VGR4PeH5fwH/AzmTzDZVD8lAug6hM=;
        b=Wv/toyx9Ty3pulYm0UcY4Q/22F4JSMxYIgAJgtualy/TduDl02If2eBvuqedo1soNX
         3r6JqdGUftebh7ifqZMCbnlclJ17cHGe8auMfd+SxsSUflkOzCUmO7WEyZdwfhJCY4V0
         0BY3MSYlqtP31LbKNUrpvGQZPhoWm+zHkyF0apmA0n9QytU3xh5uDQLlzu4blI2muobw
         YoCiSoIwFj/0kVVS/gij0aVwIJrz+rNg6TgME+6y8cbPzkv4JHpu6wnTE7Is2TdUYCSz
         xE8lCCvcQLvzMyIFFAMWt+mfn6+12PQtZ+mVTvFbqJ8Uy9BBUv7/wbkEEk4dgb9B+ty9
         awtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923344; x=1758528144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFtIJBuALfkec7VGR4PeH5fwH/AzmTzDZVD8lAug6hM=;
        b=nH6j7w2lMKG0v90vrY1Ex+E9W1jhMhHvqYciiThBvlKYAsvGCe2VwTE6+Yfa+/bihs
         hVdHhDfioMjiI+1WJUB7PjqF6mEOZZWJqzH81tGz3iG4oa8hZ3TdnjkbdMG8pAG1DnhZ
         K5FZ3dUB/eJZx/Kmns1z4t/nHYi7i2A2ToP6jrljAb9S9TCc12k5sqspyrCtUTxzbK5F
         wcJ5JWPyrfnFyBHbdMRNd+oPka97IWHudU7UHAvv8yXKF6LE7RIoIt4yh6r1vl6hm8AQ
         8p1gQVvyp47oaxe01cuJ9B2eCGCcbnGRnmx1RUhks9LWBijtJuP1jYPMETFwgEp/NRQd
         v0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXIko5C3ARgv99jvJV3oBflhAluvihIGfbsMPWhwgS/7x59v74cAKzWYVL+2eStaMqzUsCP2Qp4Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNnAWH43u2Sm6P4TE4emlyqUdrc7y8nlbvFZ6BHV0ONOHeTJM
	8ylEmGqQZDUlYUpDcGjI4269MFti/e6NFMacoLcudUH9dHsJRxB4rMWk
X-Gm-Gg: ASbGncsKkO+wuKjx34AsWx5LL1fg1+ZXS17cludG6H4LvH73Gbo7EnBCpRkJsdRg7MQ
	mhtyaBJGZ8nkXC2ynj92TWqA600xxaX0XGZUfDbExX+AYfOkWOUoc0k4UvfHgBJlvF2eELd6uOv
	xsb7/ot/w04EZQBM2m5uyJwsCYm3gb2/G60BRLYkFyTxaCbV3TDWMw8Dunb48d8KE0z8Hb0iMRB
	P7m4G9+iSOszRshtrV9b6mFqrwGyljsAJg7EiQMsnV0WJk1tivaY3cpYI0ImNjclASS6lJVp9YH
	/lQ0aF3/AeIdHiUAWYkI2DLxx1TbHJu5kGfcXRc/CaKF/diBOTLYJMDUA19AcmFq7Ptl2GwJ/uP
	IBtJ8WvefFqTYeVE+jMCK0aKX
X-Google-Smtp-Source: AGHT+IFe/jx4tFil9RjxwhD7bREzvIlC8fQ/134z0bvttum74XEn5yTMqRq0eo1UbfObzzjuNO/n+Q==
X-Received: by 2002:ac2:4f01:0:b0:56c:4159:4e39 with SMTP id 2adb3069b0e04-57049f1b51fmr3830912e87.16.1757923343830;
        Mon, 15 Sep 2025 01:02:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:23 -0700 (PDT)
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
Subject: [PATCH v3 02/11] ARM: tegra: Add ACTMON node to Tegra114 device tree
Date: Mon, 15 Sep 2025 11:01:48 +0300
Message-ID: <20250915080157.28195-3-clamor95@gmail.com>
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

Add support for ACTMON on Tegra114. This is used to monitor activity from
different components. Based on the collected statistics, the rate at which
the external memory needs to be clocked can be derived.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 5e695431ad2e..08f81a3d11de 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -248,6 +248,18 @@ ahb: ahb@6000c000 {
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
2.48.1


