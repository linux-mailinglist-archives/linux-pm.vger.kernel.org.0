Return-Path: <linux-pm+bounces-24434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920AA6CE3B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 08:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0607F170DB6
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101120408E;
	Sun, 23 Mar 2025 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJddlgKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE39202F90;
	Sun, 23 Mar 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714099; cv=none; b=OVBg39+LnaTFEG6NeeUcrY12cpTIXZ/QAc7pQX+k7uTld9z7wPYF7WRE3DeVyEvBFBvUi9ZTlD8U0ERD9gsCXlWsM4zlGTUhc1j8afbv8wfshwU+j4zdeNJHEyRWkXDyYF9LQTKE1W05W+pgrOgjSfqAEzn73dhVkGXp5mWWkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714099; c=relaxed/simple;
	bh=K954LDETOESsqcW9N5tUsbdpbqeKHsx9OEWL6PY90WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY1xuaKZ8kMklPLzNa99KzWeuXO1vpRiNoR+RvFzWaQNSnMqfdH+fZcFWtjOtmYhuiaxKMynzrdN9IaEjlXxxJmtDDgGVBYnIJntL43+RyUK6Gw3HAQsfzwZm5pSJLAgLg04l6RWcCgMaykPQySWuTcGAMu5rUEo5SGm1NIaSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJddlgKl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso4998063a12.1;
        Sun, 23 Mar 2025 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742714096; x=1743318896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6o/yy0mJ6gEoAPM9wSzc0GuosBaD/tZXos6jZFch6o=;
        b=DJddlgKlCwxJ1X+msvBYGMVXbPGfnfMDUXHQvqEiaqCeVy4vKhRMwzRgbBhdMZ+ut2
         LCJZYOTaZzdhzK1fel/xieq4XsmybDYu9EJ1VxjDozFxff30sJjUAa9d6EK9opR07VMf
         bsApo0xbxkZq9FdihJcmf/5n1GBUtYJXnWifYgKKgsqYZ8852QCbzdio86img+1c986Q
         h5w/Zjrzc35WW4dbMEh+1lWgCHV1/l0ScggeraHojsiZ61Ypgcj6WJU+cPwIcP9qaCkS
         eNURwC6TmqIrZyCwKeaKtVJiohc/pJN117Lk7c9XIe7Ahb4lQ/BHuncVEekP28gIXNx0
         U/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742714096; x=1743318896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6o/yy0mJ6gEoAPM9wSzc0GuosBaD/tZXos6jZFch6o=;
        b=Q4cfib5a+U60sM1WJpGzyJEhfdrztgYaMfAlxvATbQQ0oZ2jIXRX/w5sU58AZTkpwA
         AjAht3N0+RaD4zv4WK7zBSmOtwDhvfbU7qlEOnGMGfLjAdbQTHtoU2R0YKpytrXH565b
         VInyz758k1HBC6vKqdn/azCNLuPLu1Xc3V6n+iRLyCkpM3QD2bE8Y1BNQMxHBAd09qB5
         puVwy5Hk0HrY1XmgLPLtlJSLq8Z+XChWoik68lHEwlt8BfVQ0QdeskCv9OOLnssmDKTM
         Fbr4TDX051gnkKXxeaK7TiSefTY/D8XrtVueS7wRqs23k1stRpjeftPb5oi1geBiVjl7
         FYGg==
X-Forwarded-Encrypted: i=1; AJvYcCWLbnEafuIJpzi2dwQeoHudU8vheI6VXCop1exwlJ8yL2Fs2o/UFA9kohymDzaFNd7zDUsls0xxqk8Ie9M=@vger.kernel.org, AJvYcCWTdQKfGOUQYsinmNetWtE9Nax2Z9faUEvBCjvvrZdVCt0Kd4k4mdsCEFaiucGjxDqYPdLp0+dBciw=@vger.kernel.org, AJvYcCXBiogLjTJZm84Kd624SAa+MyovYBZCODQv6a0PZdjgvklvX7GP9d3j4EvNIBf4gt63zv1QfcNoEQTttnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIG7DVn1AsXj4lMJtYqA+A3sHFLhx6gKV8H8andQHe8/oPrnVs
	bg8c9FjGXg4zTLkOWPO4CkU0R1TBHRYcBhydMBjcFcxkMS5NPb40
X-Gm-Gg: ASbGncsQPH/wgZxORbNCNw8/hEVMa0MyuocbbRdhIQmcgdlvB+WyYqEcbILJGISBNYy
	/d3xcIGpTIxH4wi4vI/5U2bzMoX2PgERCfzBau6NJXc2v6nRqfloZD/+PTyEc72UMD86+Bs8OR1
	bS57naO/U32Z0IrukxWtpUYzAaSnQhXQY5H7Zvg8yx3gRgpAnLB3xINr08mZ92sjrm2y7vv59b3
	1RvT/9dls5eWRl65k1uvLGsu30rB1SJ6jxJEANm/RdRJn9z5A/xYBZhYJEByliCFh6RBdndsEbg
	jRJzjhYOx2mm0KzqsSfUQ6OOwMTpsqT0NzIO
X-Google-Smtp-Source: AGHT+IFSwpraoqw/BQA/iEzngeutOVj9G954A9pOuqXbEzu4aPxLZEfsQu9PRth0KOUMeytXUYbUiw==
X-Received: by 2002:a17:907:bb4b:b0:ac4:3cd:2cb2 with SMTP id a640c23a62f3a-ac403cd2eb7mr567966266b.1.1742714095690;
        Sun, 23 Mar 2025 00:14:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfaecfbsm4218283a12.41.2025.03.23.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:14:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 4/4] ARM: tegra: chagall: Add embedded controller node
Date: Sun, 23 Mar 2025 09:14:24 +0200
Message-ID: <20250323071424.48779-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323071424.48779-1-clamor95@gmail.com>
References: <20250323071424.48779-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add embedded controller node to Pegatron Chagall device-tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../boot/dts/nvidia/tegra30-pegatron-chagall.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
index 4012f9c799a8..fc9eeec54692 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
@@ -1155,6 +1155,14 @@ lcd_ddc: i2c@7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
+		embedded-controller@10 {
+			compatible = "pegatron,chagall-ec", "cypress,cg7153am";
+			reg = <0x10>;
+
+			monitored-battery = <&battery>;
+			power-supplies = <&mains>;
+		};
+
 		/* Wolfson Microelectronics WM8903 audio codec */
 		wm8903: audio-codec@1a {
 			compatible = "wlf,wm8903";
@@ -2596,6 +2604,14 @@ backlight: backlight {
 		default-brightness-level = <15>;
 	};
 
+	battery: battery-cell {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion-polymer";
+		charge-full-design-microamp-hours = <3050000>;
+		energy-full-design-microwatt-hours = <23000000>;
+		operating-range-celsius = <0 45>;
+	};
+
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
-- 
2.43.0


