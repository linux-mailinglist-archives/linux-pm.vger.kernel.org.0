Return-Path: <linux-pm+bounces-35909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15EBCCC19
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B8C421AE6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422E2F39A5;
	Fri, 10 Oct 2025 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Du9tIdLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A642EFDB4
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095440; cv=none; b=rwO4wHfPcdir0oCYLYDAxDKo1Sa7AO4L1UVA+uYz8C2sYB1l9dHbcWBKjKEO7w0JIiTk+z2lsnj8xXM8E0fJkjkmPRFBEMhuFBG1C5ilWgJP0OkEt7F8jrFQcG4oj7RFYsSqvr5wpBaD6osDdGYdv3PcI/vMEEmryROksgX9mCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095440; c=relaxed/simple;
	bh=JpYLHBppDURESW3oGd0+8XBXaU0yfTl1Z8DessSgdAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvsVUG34oJ84si4+CYr3hfxS/o8R+fHYXx2tmEjCI56VDiYFJC3fKBEAuEqcAySPG8JzzcMoX8nRyiNynZcatRLPvvrRgC5RoXTM//vWQI8ZXQwKzW7Gtn00dNBJ1zy9KsETi/aniynB2365G+f9GKilLvXICruoh/jIIRySlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Du9tIdLH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3da3b34950so319893766b.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095435; x=1760700235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlEbSwGOzNwkU6KFYMavrAYJ9rwkM5KnTfqRG4W7Yk0=;
        b=Du9tIdLHG5n4hWQXmqD0J6mBBfrCWf/jb6B1w6jPHyGyHRSzvgc/z8feaARj6l5HxQ
         omxK+ZpiYmBqoJJI0Bg0svNuDlP6jGDVTZLyODbX1Al6udzzX2QgfJII4qoqreE3m+nv
         F6Q55cRHMADNPFKFYjtz4yUwC8rWC0KawqnDBY8m4aloVevW3E0ZbTUJcqQof1O+FHTP
         sTo7d644fpYr04nG0eHGVjrRTTLHGKk45ZHCLtIvqmIwvZv0JdOh5/evT+3WQYI5HWbp
         M0Wd1tvrzlUTPiIdC7aluYE6CgknPtPX1jNsmi39O6Tt4yvIZ5KcuiNE7G+BukJQdk2x
         fcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095435; x=1760700235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlEbSwGOzNwkU6KFYMavrAYJ9rwkM5KnTfqRG4W7Yk0=;
        b=uG+PYRlnOya0Pa94QYHlXXTVrtQRPrEeknD8bbwBSI1ngy8px8mlLd7VSxgbPrXtxJ
         HpWNp8/cFbG8QtljB4bfpAMKlZMxiq6GX/vL8RRh2UoI7xJ7yISg1gzpCTRQATbd3oKu
         fHdlEK88LVvsVA5++822KzRCl+MlcHKBCZWql4r3yuKxuIXIqSNQYx5kODFgYJ9uqxA9
         y19oTbM/FV8mUzULm+8tc1k2nX+dOVtx8ysqEgE66UX0MqwzlhkOOHZXMJEkzFYqnWKb
         o3OyUEGyxg8qfbVRYWmhA7r07eYkwskhzmxNZSL7btR7zabST3Sf6oinwNlG9cUbDOW1
         gb3w==
X-Forwarded-Encrypted: i=1; AJvYcCXQVLkKEWMwaza84HQvteNt2BiZN5uQejrtU5a1AVgSkTtnF6EacUBdpiphMJg8iQbDJl7UEDT/VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Z+fMUiyrCfwupMNZGzX5TVQq7+VhqeTlgvcYxWG/oziaI244
	SUl9xrhr/zzWLWuIF2ypZoHNLad+50PYk65M9ueOB7Y7VuQ2YG1R/lQH/jd/BjfkJdM=
X-Gm-Gg: ASbGncscz+/YF/fPNjaud8KVztH1FBsRe6WrF+k99PavM83RR2S+gpHyV7y4KrYWnU5
	7YGvQPLm4J81r3tk38HR79SLT329HtMcwbT0MCb/y313aBuocpQ+IbFYTGMjpnkjxxM05vpVKb/
	VY1/+Gx73J9ehnDfr00KrAc6OTr+FByn1qoyU6tm5hU0sH3i+zad7dflz/7B1Rg7cUHLAoPF+2J
	fDPVkgU5Pq+uoCD4BwAWaKuutqgtesN0gXeANmBmCmX+CPCDpQVltIrK8fP7xTU4xN0WXQa3b4H
	LL+xcs2Fx53ZRtyoPlgc88wlRNWjQhZdGefFP4zpdfDTLKcjEH3rmDqmVHCGu6F2c6sQWNliC6F
	ypiew8YDPFnaoY9yi0UZKvOylqbFHyJaMaylgM8Xq8yWUhfQ4ASTxHnsQsfPbhjVzoiEZoB4tpG
	OKqJC2G23WxT9IIXE/Y9jQwltZZFpoSQ==
X-Google-Smtp-Source: AGHT+IFtOKOdgJ4dWifHMxzpmdJ6iqSE5R85wkeuGb0qbSbozu5nIiJKB5e4xe1EX1wTlhX9Ev6i4w==
X-Received: by 2002:a17:907:3f1c:b0:b47:2be3:bc75 with SMTP id a640c23a62f3a-b50ac5d1dd9mr1201041566b.60.1760095434892;
        Fri, 10 Oct 2025 04:23:54 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:54 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:22:03 +0200
Subject: [PATCH RFC 5/6] arm64: dts: qcom: pm7250b: Define battery
 temperature ADC channels
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bat-temp-adc-v1-5-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=1351;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=JpYLHBppDURESW3oGd0+8XBXaU0yfTl1Z8DessSgdAI=;
 b=qaGcfuqMeIg0Gum2+/UPS5v4Y9LiQtlhFI2337haSWnu56uZivPuiS4BHaj9sRq1e3k7jqyHN
 I7QA72rmAs+AefjACqzZcd5Wft8+6p0hD4VGXSrzyDehfZ0EKOjSYQp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the definition for these ADC channels to the PM7250B definition.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 0761e6b5fd8d..c96089520548 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -156,6 +156,22 @@ channel@1e {
 				label = "chg_mid";
 			};
 
+			channel@2a {
+				reg = <ADC5_BAT_THERM_30K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_30k";
+			};
+
+			channel@4a {
+				reg = <ADC5_BAT_THERM_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_100k";
+			};
+
 			channel@4b {
 				reg = <ADC5_BAT_ID_100K_PU>;
 				qcom,hw-settle-time = <200>;
@@ -164,6 +180,14 @@ channel@4b {
 				label = "bat_id";
 			};
 
+			channel@6a {
+				reg = <ADC5_BAT_THERM_400K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_400k";
+			};
+
 			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;

-- 
2.51.0


