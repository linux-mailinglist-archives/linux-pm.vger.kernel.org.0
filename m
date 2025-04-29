Return-Path: <linux-pm+bounces-26360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362BAA031B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A972A3ACC8D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D430296173;
	Tue, 29 Apr 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ChxZZ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD927B4EB;
	Tue, 29 Apr 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907518; cv=none; b=lRKcOE8j+wvnm7A/Xlkek8uo7Di+58Ydhq6XI+87Q0mmHbWziiN5fdQMZzmGv7bTituXg4yrDZgtY0rdMmZ5nk14UF2NpN9Wi3q6wGghalUHRXfCHzYV6bRsi4bL905zLhMxIwHL5EiRsB2PFy7r4Sn8Z0WUUbqb+Bk4BWR1K+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907518; c=relaxed/simple;
	bh=BN3Rx27h7PANEPMmgBLG9zVNV06h/WVAMzPpsR7rHNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov+lO7p3lDdQKxoD/wphdcSSNEqxUCYrVhuJ/k5LTBETHWW0OoeTmAcaHiVar+lHgUcqqmKdC1py4MU9CA/l6YVRU/psUdEP/kCl+5sSRecr22zhB3YE6NnljjyHyoMORoO0NDJH3WZcpv8VP9cLTTKyEsDD+oi12iZBABhNxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1ChxZZ+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so8548981a12.3;
        Mon, 28 Apr 2025 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745907515; x=1746512315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw1I85Tpn1zuDCQW6uOXQxEB4cGHAS6XX88DkqiZcGc=;
        b=Q1ChxZZ+TCwUS8mKeMzCMzyex8EY+rRJJ8IVPzxORgSkqfh6+N9nBXYR4Tz85sojUk
         H7lK5R9D0hHHWGsCH0p/P3wv/CysSQrR8hvmF9hyNYWf63SyoWCoQDc+oYozDpaelgPG
         MkUlAhWLD4U7oQlXyVvbkFcMwNHiy00IppuRtKTEd/mUSM/6LFDZsirmrT8Wqg3A7SYN
         Hb1pXnkQCCB0IeLKJB1HbF+pKtMYj7u/F1R7IDeqkn0qEfqv5RKil6JKZC0rOeFGS81b
         Z5CFjHjz94R9z1PkVbsfc35e2BObNNgL+sgh8PdNmCwWUqEqIij5oAJnTzz+4HBXI2Av
         P0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745907515; x=1746512315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw1I85Tpn1zuDCQW6uOXQxEB4cGHAS6XX88DkqiZcGc=;
        b=YVXbyMjvsy+w3I0ZP3nL/BVPVT6iOIRTIY4d+jI7Me7sGXLXlURCekv2PaQquJ1V5p
         CD83aeZoWSP96QiYzYSO8j0quYM9nwmI98MpN2bMJVm8w42yRwyf+ZmgJosDbFG/RwQ2
         TpAGUKET2L08Ernvd5Qyb6dCOxfF2pXxDcXb9vD9Y0ITOGay9txxXKcpgS5il3CvIshc
         94AzrKnH/tB/hN4V7TlZjSNq6OGdQt7JU0MJWU45aN2/YzWnAGIidGqvbMRi+CTJ1EMj
         XJOHSdOZtaRYhHeDhZ5CR/fgFnzyU/L0S17mknLOSi7ikGZjCUVxP0vsddBK3U5hk1tR
         o4WA==
X-Forwarded-Encrypted: i=1; AJvYcCWTQROXPr/OSMJm0R0EeSmE8f/Pdj0Ui2RpNq1gHYzzNux204PtlV2EssEjE8ZaEAwe6wsO0FD+thXfAVE=@vger.kernel.org, AJvYcCX4fpSFLES+ZOk4gku1ikATkfeMyJ9wTj2BNsjQy/X570ZWHnE9R7sv7D6EoOp+Ikgw7lJZyRy5RYaeOyp3@vger.kernel.org, AJvYcCXPI52o75xgYrwK8K6L3zgy6ohO2zA60MV30Sj90HBYkOYlq5su0BhUJaJqsqIwGH6IVEHWCPpw+d36@vger.kernel.org
X-Gm-Message-State: AOJu0YycbIYwL5EpFCeb3mpXSegNqf9EdAVG32e9OADNGYXDfPWKMJ78
	3Lc30/s7GdPkj1jtQ8zr3V+wv7PvLlod9vgwAE7WAJHKv2nvC1RN
X-Gm-Gg: ASbGnctdqlEqB/VT42va3ulhC9tfvJIASI975OQ/2vNf1FT5uiG9nJ2OJ2R8+U/xkv7
	ddmGMWxI7u1LtYOjfv/DoE3nKRvyOCyNSc8W4yO6xaM6R8E09CP4Wss7cXICBBPQs43s4hnqsUi
	xR035tMThOkF9araHqwn8W+AEGKiD5BeLiUzwZ/VQ6Cdshk5w7xWmjZT9QfFE8fDugpNAQos5Yt
	Uy95Sf1qVNqqneCb0eUHkiOKifUwPynwgek2ng6xgNrs0auR3RQGddH1S9arj9jpie6Z6ugikrZ
	44qxeeUxD/+vZ+Ti9aZ1ZTxEhajjAWO6
X-Google-Smtp-Source: AGHT+IF4fs1Hb1HMyIriUcEGRhTmB0Z8OEj5E8q1zClVTDw5ao60cZQA+Zowh6pUE4g+G/fvwg9JCQ==
X-Received: by 2002:a05:6402:40d3:b0:5f3:4ac5:9e58 with SMTP id 4fb4d7f45d1cf-5f83b2561edmr1612091a12.22.1745907514896;
        Mon, 28 Apr 2025 23:18:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff9c5sm6996570a12.28.2025.04.28.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:18:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: tegra: chagall: Add embedded controller node
Date: Tue, 29 Apr 2025 09:18:02 +0300
Message-ID: <20250429061803.9581-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429061803.9581-1-clamor95@gmail.com>
References: <20250429061803.9581-1-clamor95@gmail.com>
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
index 4012f9c799a8..b7d0ebb766a6 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
@@ -1155,6 +1155,14 @@ lcd_ddc: i2c@7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
+		embedded-controller@10 {
+			compatible = "pegatron,chagall-ec";
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
2.48.1


