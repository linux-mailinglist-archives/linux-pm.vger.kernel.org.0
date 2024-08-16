Return-Path: <linux-pm+bounces-12329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2A9543F6
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB901F24718
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E21474A4;
	Fri, 16 Aug 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO/W3jlr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96E145FEE;
	Fri, 16 Aug 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796374; cv=none; b=iRZRt/FIYWNxY3mqqbossZvhtCgW6kflKGlJEPFulU2EKLZCVzzDDp3QFGCmfo/Rq0K5W7HiI+wDlcWl4qI0iaaGJno1DarPfuL6DDYxEJPVITim6SR/RXAQktMvZtjc6Fbj2FYuI/k59FzQh7v9lx1TO5z5niDPkN2hie4wNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796374; c=relaxed/simple;
	bh=tVXqBcPeo+G6mj6298MiM54OrNViarOkoHHogiR/EXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljQ5Q8bbu72gusVJ49Q3EsigBX0yteYrTKShX/ERSMXnYvwyFBaYacaQBLh54vmy2A++b6CvK0F5DOhqjcAvJyaN592iRq8qihamesV3yM3G/cvh8udSS+ZZpk9rY7X3fMIpcN7HE99LxKckVEuo41aGTy0gyLQ6v0Y1dVIjXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO/W3jlr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280c55e488so8835305e9.0;
        Fri, 16 Aug 2024 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796371; x=1724401171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoRhb00V3b2YHQgd98mtv4KUJ8LC4IwuReaO+Jmg960=;
        b=HO/W3jlrsZYqvkYrtwgGAxroB8ep1d+0EehVaE0ejyBqpqYsOzYZpQ7H7VUa1Cs4ks
         TKqKOrrEwQxxac596yg6TDWu7kGU0AbUEvIya2IWAGqNs/VCTh0fePoG8tn/oId7x8px
         1HZpcibdJfpRDwG/nRpfNapIs6AHp2uouzwMCjKBAnYXcZaQnrU1++qUSrigjFciFBLH
         A13pR5YULrbnExlAJiASx3Pt6jNXCPPFizONM0UtMREPggdbk+5priZHB3X61RPmtdX2
         i/PGgdCIYaR1ftWEZDyzoZe/idxAK14VoncroHtrq5aKyyNpNu82WNTfZue64x3k0Ixo
         e0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796371; x=1724401171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoRhb00V3b2YHQgd98mtv4KUJ8LC4IwuReaO+Jmg960=;
        b=gYge/5fjjNMYDKwFWaTT0fJQoJ96rHQSZ8xQoN1TpRFFWzURg7gC2JiYSbcKEO2q4T
         CW6TlWL5RN6nBE92ZFUf8iWXd+SdUKS3XuxfDkayGxPvNSCye3fuPy2Vk2jaO0npI25K
         X6GhcwI33LK5tgQkE14pvrrzXOO9T0n5bTQ/um+IYZmwTPkqJfYOdt7qC9c+1y5BF/TG
         KzID9p/nK4B9CQnL6y7j6owY769bon5hE6F0LntjVGTphmVeWCfr9otA5eLf+3r1J3q5
         dTkXBUlcBxJ7CAsGup9TIc3AN+GWQQszI1OyARq31ErExlEjOh/c+5hQz3KLmd1M66ZB
         qqTw==
X-Forwarded-Encrypted: i=1; AJvYcCVmYpnzBBMmioFHSU8XstZiwL/rGhmDqW7H4FeptrP5QKhO9SeUKDNo9LAi/iMtUFvP5o2L6BwyIHq+WbuNNeU7RJnLQ1rVuSnc0r+nyyeTUpv6DM3NHKNeGVAIyTw2+a3JmX6r9NCr80vu/Bh9r423z18YDUJoj5HXZESRMA5msRFm6vfeF8btv91k5V690sdy77evIkjRrB7dNk6e0rN4SE1wuc8=
X-Gm-Message-State: AOJu0Yw1YUqbMlXh9UOveE6v+lSSOBSeI6sgqsbkMPeSB0O/cvMPXQMw
	1EOSWrxjIDQeYIaWpxG33y+4ob60+E3Q/wHOZVaYz7m1blbV6UIx
X-Google-Smtp-Source: AGHT+IF1E656TFpK2w4q5TDlMbLKFRWBD1HiXg+Mtkab768Qqq3+epDpvZYs/3x5inQx5XaV1Rl6FA==
X-Received: by 2002:a05:600c:1d0e:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429eda1f0ebmr12227085e9.11.1723796371414;
        Fri, 16 Aug 2024 01:19:31 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:31 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:15 +0200
Subject: [PATCH v4 09/10] ARM: dts: samsung: exynos4212-tab3: Add USB
 connector node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-9-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=tVXqBcPeo+G6mj6298MiM54OrNViarOkoHHogiR/EXo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt/QhHtj7N5Zin99gbo1sxWukqNmO5BWXe+w
 GvTxBPZAJSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfwAKCRCzu/ihE6BR
 aDsbD/9qil+0jJMgb3pMowZYLtMLmZgqtHPWkr6hQ2Kay5TvaKFioVXLcyKTUksySXmaOYQddep
 1iytEBc3dw16bB8xdkfLSM8b4n7ejE2/lnpBEfCghyQoUtlKHwdhiynmeYugiToudvZV9gtMJAx
 Ev7iFOYcxkZV4coYrUocOCGNi/TfZVGOUAEJy8fQpvjol9kDi6RfjSQyg/KcZd/JL0/qNcxL9y0
 wq1Msrcjp+wfGBIztP2EnZNnNVAjjEkUrwywouRkA4KAqSDXoEJ2Y5SxKnc6BwVR6hTGOufkRWE
 TaBeWEHvhCqY98MOJ3sjbCDl2sbkBEhxxp98BaLD54Z+rF26R20zuBizwmaJGF6BjvT8cBDk7gY
 1b1SfGSPJq8Tp5rbkaLC+oLKAfLqF9XYxSt4Dz5hCoOfaPbfhfiCOw6FyngQvBo0m/sayEBTv2X
 iW7yn36PzJ46x46H4rvk6dQtW/ZtzTCFGq1TIseruNUSuGocsjVj+QnPLe1ESezu68IRhPnwBLX
 A2GUEovvuyNcyU0Sq6S8ZWbxMt9xdOW5SOwxa7u5etYVn4+R3aN/q8PMlqFDJLx31w9xQpjEWh3
 uhemeeA1c4K4YJkXjw6NXUc0cV89x+/WO7ALqQfViGDr0zSvttD0eZ+wQuU1MpSOAVcxJjoIFXF
 He1o9VwzZ0Z5LWw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add a subnode to the MAX77693 MFD for the MUIC and connect the USB
connector node to the charger to allow for charger type/OTG cable
detection.

Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index 3c905bfedd96..7309b4e1cc3d 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -157,6 +157,17 @@ charger_reg: CHARGER {
 				};
 			};
 
+			muic {
+				compatible = "maxim,max77693-muic";
+
+				usb_conn: connector {
+					compatible = "samsung,usb-connector-11pin",
+						     "usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+				};
+			};
+
 			charger {
 				compatible = "maxim,max77693-charger";
 				monitored-battery = <&battery>;
@@ -166,6 +177,8 @@ charger {
 				maxim,thermal-regulation-celsius = <100>;
 				maxim,battery-overcurrent-microamp = <3500000>;
 				maxim,charge-input-threshold-microvolt = <4300000>;
+
+				maxim,usb-connector = <&usb_conn>;
 			};
 		};
 	};

-- 
2.46.0


