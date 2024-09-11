Return-Path: <linux-pm+bounces-14005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC523974D72
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E61F21B9B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E419E971;
	Wed, 11 Sep 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh56TQcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444119E966;
	Wed, 11 Sep 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044513; cv=none; b=ifHiBbsg4XCw9/j52sQq4D6wISI5xiNOlHYz8Y+EE/LafA2m3rah6EJGuhFzbNLiEgfsetuUHNRG82RItEqnYUb62+Ldm9kmof/efeBjx2ZjWCjWA5E+azjjDYE+lJF8UnumSC0jeWXtljb71FSDYPWu0PW7JIeGR+A+OpI7EqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044513; c=relaxed/simple;
	bh=WNqRV8kjVJXJZ4YG/va/EvkwzJLLE57eREOK/RGHQQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz//Nf65RBcrMPDkVEovggumw/l6O964Ar31Abl0l32LouxZSeBTSdF+xvWNLMIpKJVHVyFUr51dfZW8hAZfPWj09OUpy/BzA5IT+y2uewu+OzyaRv53ElLYDt36v3sQ7Hsq2n6ZGggnVjbwVG8CwPhP9O9bIo1Re3HsxUQ80Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh56TQcY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20551eeba95so57869555ad.2;
        Wed, 11 Sep 2024 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044512; x=1726649312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skKJu76OJxOTwD1xlwFtFFTVKvyWq0V0wXx6JaBgBBg=;
        b=Dh56TQcYwU1wVV0NvCbdZdZW1yUsthOUd6S9HyAvgPJzM5sSoqW53S8RXwJMFmxTVS
         t4m1JOMpXk1HJlDIvntvVrYRP39gna2NBqYZTFhB3/iMrQt0AlN4oxWyyjENI5OlXS52
         0Ocw+7LuzPrcuQflMy8BVA4R+RUXbVvUFus0A0+vmJTPIYI1x4efJtbgkAfFPCBel5vI
         x4qysVTuhscMy+/ShJDsD6HIe86ux2JscGqHNNVGHEb/NQRLwgF5i78t6dsdzLJ76yju
         JGTussOo9tRUPo2qdvDyzzapd/uQaxl1yUgi0GTelVlKRjVy81lrV9cq3GHwg3qKL6ND
         nTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044512; x=1726649312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skKJu76OJxOTwD1xlwFtFFTVKvyWq0V0wXx6JaBgBBg=;
        b=YZGzObtEOKeuu0f7XWOh2So0B4+bkBqs2Abnv6a03XQwAOEuEZkGGyg9UyMXaD/oS9
         39TcOwG1r+Q0zC0EPW9B9W+R5fZ0gLZml/q16oDGwS+nBzJlrPnSvVkglzF/6Dj3kWRW
         neRANV+UxK8YEZeb9eUaAqmkY2EV/Qg4ZjAZLov1UDBuIzzj8JaKQOyP92vmme6NkvUz
         dAL6juQh6NXQwYaQ7jVrmu/TgvfMx+c6JOeS6JpHuRQRn5g3j5GJv04MTwphsyxoHBiC
         X6rxGiKvAhpn7xEj6gVqmacN/wzw+ZOzkpMgLgSatGcOtJGo2CfAk46xNzj6lQM4jnEZ
         YJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGkjLjqbrR65MzbY4gfDmnjs0XtuJICBpPZN7c19NnezetCkVmZ3xCKY+YYNPYxfEovPJcViEmUeM=@vger.kernel.org, AJvYcCUvx2yiJBDr4CYIXaRjKAtsI+k8oCZlQ1xrlQyQhKjTFah57Ec86MfkCng/tbuVhbEO2E9g4jJLx+nqMJl8rUo=@vger.kernel.org, AJvYcCVVclSvIG4XHfFkDJSSHLD/2T9a8iEXdKd0dkrioWQiBFuO5IvTrYobQoN9OFJT1N/kRBhcX2Nw7LuhtA==@vger.kernel.org, AJvYcCVqvyYMDmsY6dXmyjvBRCAa5o1yJbXI/UHAOmIfXHUylJpZEMOt/ErAJwdr6VqSSyvKLPnEFu1gdijf5qp4@vger.kernel.org, AJvYcCXzYu3g3F9eSAhr7ynVxOVPCSucCcNDmlibVWNC5J4hsjRw07hFekLU2z764uyGs/A+OzGiO1IErhx+@vger.kernel.org
X-Gm-Message-State: AOJu0YybXntvx945cocLarr7pq5lYZe0PdIaa7o+GjDrabhrK8w+bzRG
	pd3LNskiFgIhiRjbC+xXjqTqDPjozMRjCHjr/sH4XNE7o177yn/roP2qG2Hw4Xg=
X-Google-Smtp-Source: AGHT+IF1nFu+Ec2ol7ZDJZAlfGyY2LqUQPYWowStBXV/GRNQbWDVUTiE7+BLbu8tGFNbScsr7voaSA==
X-Received: by 2002:a05:6a21:a4c1:b0:1cf:4422:d18b with SMTP id adf61e73a8af0-1cf5e079ecdmr5131512637.14.1726044511757;
        Wed, 11 Sep 2024 01:48:31 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:31 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 21/22] arm64: dts: apple: t8010: Add cpufreq nodes
Date: Wed, 11 Sep 2024 16:41:11 +0800
Message-ID: <20240911084353.28888-23-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cpufreq nodes for the A10 SoC.

The Apple iPod touch 7 can only go up to 1.64 GHz, so the higher operating
points are in t8010-fast.dtsi.

A10 consists of logical cores that switches between E-mode and P-mode
depending on the current p-state. Each mode have different capacities so
the E-mode frequencies are adjusted to make performance scale linearly
with clock speed.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010-fast.dtsi | 19 +++++++
 arch/arm64/boot/dts/apple/t8010.dtsi      | 60 +++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010-fast.dtsi b/arch/arm64/boot/dts/apple/t8010-fast.dtsi
index 4bdf1c3eccfe..9a263eadc776 100644
--- a/arch/arm64/boot/dts/apple/t8010-fast.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010-fast.dtsi
@@ -6,3 +6,22 @@
  */
 
 #include "t8010.dtsi"
+
+/ {
+	opp: opp-table-0 {
+		opp08 {
+			opp-hz = /bits/ 64 <1944000000>;
+			opp-level = <8>;
+		};
+
+		opp09 {
+			opp-hz = /bits/ 64 <2244000000>;
+			opp-level = <9>;
+		};
+
+		opp10 {
+			opp-hz = /bits/ 64 <2340000000>;
+			opp-level = <10>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index 926a0f501477..e7d7194b412c 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -50,6 +50,8 @@ cpu0: cpu@0 {
 			compatible = "apple,hurricane-zephyr";
 			reg = <0x0 0x0>;
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&opp>;
+			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
 		};
@@ -58,11 +60,63 @@ cpu1: cpu@1 {
 			compatible = "apple,hurricane-zephyr";
 			reg = <0x0 0x1>;
 			cpu-release-addr = <0 0>; /* To be filled by loader */
+			operating-points-v2 = <&opp>;
+			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
 		};
 	};
 
+	opp: opp-table-0 {
+		compatible = "operating-points-v2";
+
+		/*
+		 * The E-core frequencies are adjusted so performance scales
+		 * linearly with reported clock speed.
+		 */
+
+		opp01 {
+			opp-hz = /bits/ 64 <149000000>; /* 396 MHz, E-core */
+			opp-level = <1>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <275000000>; /* 732 MHz, E-core */
+			opp-level = <2>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <410000000>; /* 1092 MHz, E-core */
+			opp-level = <3>;
+		};
+
+		/* The following operating points are handled by the P-cores */
+		opp04 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-level = <4>;
+		};
+
+		opp05 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-level = <5>;
+		};
+
+		opp06 {
+			opp-hz = /bits/ 64 <1356000000>;
+			opp-level = <6>;
+		};
+
+		opp07 {
+			opp-hz = /bits/ 64 <1644000000>;
+			opp-level = <7>;
+		};
+
+		/*
+		 * The iPod Touch 7 supports up to 1.6 GHz, faster operating
+		 * points for other devices are in t8010-fast.dtsi
+		 */
+	};
+
 	memory@800000000 {
 		device_type = "memory";
 		reg = <0x8 0 0 0>; /* To be filled by loader */
@@ -86,6 +140,12 @@ soc {
 		nonposted-mmio;
 		ranges;
 
+		cpufreq: performance-controller@202f20000 {
+			compatible = "apple,t8010-cluster-cpufreq", "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+			reg = <0x2 0x2f20000 0 0x1000>;
+			#performance-domain-cells = <0>;
+		};
+
 		serial0: serial@20a0c0000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x0a0c0000 0x0 0x4000>;
-- 
2.46.0


