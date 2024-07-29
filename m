Return-Path: <linux-pm+bounces-11579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4693FCBC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5638E1C223CE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1CE18A93C;
	Mon, 29 Jul 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDyC7+pR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85D189F3F;
	Mon, 29 Jul 2024 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275285; cv=none; b=KGLb0DdqGjNovB9GXNBlkTr3cATTbwv/AFZK35vH2ZRIZqB93xTxlcYC8DMnEld4EvUlc5LUgUW1vpijZW7nJB83cton7UmTt5wc+WEEkVbh94dvFubY5zEcJsvxhDARfU867zyvtlSmbv4u401x6xoLVRI5qRXMJHVR04GkOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275285; c=relaxed/simple;
	bh=8B1kt8AWmIpBQPncG9dfhlWKEjLZT84Kr302Znpylas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a482yByoJwBV0HiuJ9Q/ZAqff9iNLh3os15tSylnMjPzix9XJxVzqbnOXbQTdGGIebIr7VgD7cvlrLbl29uMeqkivK0uqfYHKS/5f9lXcLnwkGdWe1g/jHg7QZp23h5RKA9LyxQevz1RPw2bhAKmnE9YtFYLLX63d6/0iN1f258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDyC7+pR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684407b2deso1545473f8f.1;
        Mon, 29 Jul 2024 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275282; x=1722880082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnVUt1AGc9AqCAUSKdpREqmxFC97kSldsuL6yvP0RyA=;
        b=HDyC7+pRwhK9F77CSG+weYlHulS5UiGni59LUML9WFhDBzN44AIiHAsbJW8v/vKleN
         1QvlcLshGwQLjbES78lhuJXRTvoHErquUw0bbMytfLpgG/J/KHL/sEGGcjNsX1RFIbUL
         LfiHtOHQQUq9I1/V9FkeRo4UkaMl51wWyUv2uZrI1YGQI7EcwbK/4kABgHJWXG3Rb/Pw
         /PBtDZ2P7bglu7lSYT5FhVosbDzC+FSJhwRsJl1iprEIxUV1yz2J8Hjr6EXHBT56LZJZ
         GXbtTT16hyS8Dntsfc1yr2FzXchUUHW/vVLNCk5jnjZylqwnW0C8i6FVrnmkQ+wokIKG
         7drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275282; x=1722880082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnVUt1AGc9AqCAUSKdpREqmxFC97kSldsuL6yvP0RyA=;
        b=UX3sx2RTkbB5zl+gt9mNYWTFkZ8btawtuFBHK7LwUhQm4pF8I/hmMuqWE3eA2jLt4R
         W2gCQkmNKeNkVg6MsS3SjwhgjiVS70YCCvsNOTe04yluhgpUnAtg+JjRCrkaakPAFs5W
         Ic31oDW6LuV1kkNhp4m2zctk6VOzIs2senfroDkLioy8aiGUEVHtjOpSYwwMJnkB/hfP
         H891Qh1PlLJ7bs19lMoGBGS653QSofNfbKpWQ+tEq5Ph5LSAkqyUnp2gn2hOOdtwFQ7U
         vTUJgFGB9zxuDoDX03TPK7YfiOVFwoyBs714DWwLUoljyPLlmgn5cmfASZCuhtSiNB1n
         8HEA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ge5pf0hNIqyS0b2dobBxBefnpIckVnmHmXikOj+GGboJwhgx0ZZlwJnwRRYS4QOi5mm0Iz1j30nAUQIkqYMzuy6xrOB0crPmz+4/3jEyBN8/MUFbHR0oHVXXPwukoUAi5XaqW8YwaqcOIpiDmDiDSO43bXBUvB7KvOxl0B/3ANZ7ANnx0nMlH8Ys/pRc0c0rh/IFhJbWLOpXZZWSbOfqL88CgaM=
X-Gm-Message-State: AOJu0YzFZa/AxFoin8aL8LPDWuBshJzlF7IfYh0jitEujxETNtF3y/8W
	9ddjzZGc6D+mYREWrzyQCtlqpEB81HotX1s6/YJJMCf2TjVy8oe+
X-Google-Smtp-Source: AGHT+IHNyFmYhpG/++yMrpkuRc2XYprU40Zz9/3C+49zl/kR3iongSZ4buzWgKt0FzzTDvZcE6BgZg==
X-Received: by 2002:a5d:63c1:0:b0:367:9516:ffb4 with SMTP id ffacd0b85a97d-36b5cee21a2mr5812478f8f.19.1722275282210;
        Mon, 29 Jul 2024 10:48:02 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:48:01 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:42 +0200
Subject: [PATCH v3 08/10] ARM: dts: samsung: exynos4212-tab3: Add battery
 node with charge current value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-8-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=8B1kt8AWmIpBQPncG9dfhlWKEjLZT84Kr302Znpylas=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W/6MLFXnaSOcMkyzmUQa2TpYwPaa03T2gQd
 VHEdtI6YyGJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvwAKCRCzu/ihE6BR
 aEnXD/9LZurHLtb9yxoipoT46Gc0pSlhbAAFltMTws9gW7PF0xBpQHj+RJUwrIxFxsvts0i6MYc
 eWRx5cPuJYjwdftPZm7FPa/J99Pie5Ob2TWGQuiAqDITmKPOgaN4tgCwgsKw4Qg5dbNjqwxDfO8
 tkEj5wbKjpUOYvBXDB33xzXmtyOOWTcpD5mtQSmM9jYwZT/8TbZyurZj/OCA71fNfstNFWaRYuV
 YFe4ae/c+g+51J9CSTaOQO1xCQ/igRcu+k3z3vAK66Z5Y6rGG0z3A9+cWLdo/nI+YnnCDX2ArcR
 kjUFAs/n8+Ku5x54lXivQ6bLvzMxl6AEUczZPoG+2/Lm+yt4Q6GctGxTu+Gk1RitAIxzVrZhLbM
 w3P8lh+rU6QSzLMJmPhaXc2kMyHhJVof2tO05h1DGb4i4VTjVH5EDLF8Pd0tOAu1KTl2S9BND8L
 p4TX4DHpI3VNtCU5fnMsLV4UCIVYkuSN1V5gmefHuURBIrw/cfY2z43r3d+w0vAEif9w9WSGxjJ
 fr8GQU4Rg77Jne4EV74m0OJhxN66zpCZarrG4IeOGUY1aT2UB+vOsGFD5Mm8OfbOUYLfim6h0iO
 Ao0OO7jFPmkZgEYMC3WbButGbhyVVCO49bGb17Rq61sL0uFnECsntOmjqgmnibxrX1thfk6A1MB
 sZclK9Q5N2Vb7yA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This value was verified by comparing register dumps of the MAX77693
charger with on mainline with a downstream kernel under Android; the
value on downstream was set to 1.8 amps when charging with a proper
charger.

Add it to a new battery node and pass it to the MAX77693 charger
so that the fast charge current setting can be used for charging.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Switched to monitored-battery
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index 9bc05961577d..3c905bfedd96 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -159,6 +159,7 @@ charger_reg: CHARGER {
 
 			charger {
 				compatible = "maxim,max77693-charger";
+				monitored-battery = <&battery>;
 
 				maxim,constant-microvolt = <4350000>;
 				maxim,min-system-microvolt = <3600000>;
@@ -300,6 +301,11 @@ submic_bias_reg: voltage-regulator-5 {
 		regulator-max-microvolt = <2800000>;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <1800000>;
+	};
+
 	sound: sound {
 		compatible = "samsung,midas-audio";
 		model = "TAB3";

-- 
2.45.2


