Return-Path: <linux-pm+bounces-12328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CD59543F4
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676701F21667
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE014600D;
	Fri, 16 Aug 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PELvuj0I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169A145A16;
	Fri, 16 Aug 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796373; cv=none; b=EhxKrMqpN9sckDgKPp15Hp9t7O6ntv4K4z1KlZCjXlSO4cVY+m1LqSn3EAwbnWEVF3jTEB1m7yt83d3tQ/O9E1jC2aPHCgbYfoTYXH82YjpKUGYmLA5tWTpd3samA4JhypGMeqz2P/cAXqI3aKTOs6XjdLP2sc/JFJfOIohr+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796373; c=relaxed/simple;
	bh=A37c37izrYWJf0Fe0JOtEKWVSivq+OwwBBfAr+DI200=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjiHRdrNzbXNoEoLyk46XZ4Q4NfSa7Y0gwXEGvWGUoSUMd4ekyk5IglAGia11Y2t8bEg0kY4keCjEoIP8sKcQKGBBvhH3UOAXMR0EuEYYSakfDi/MvpkjA+MHMxJDiELmKr+iGGycAHidRsnAhgkReYssST6rMMz5mqGV0GA42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PELvuj0I; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd530a4eso2809901e87.0;
        Fri, 16 Aug 2024 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796370; x=1724401170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXg+lB1Y9hiiUwuYsdnzVumsOx9EvCzW9KQFQaaXx58=;
        b=PELvuj0IiUfahDfX18x14JM6czM8gIo+wTzUpm8o8idk2gkzxR2Mzl9FIndnxNM5rs
         4F1f6D/yBOGEURfDzlRed/bEyhWGQTwcGWGHOD3sB6JUXSF4yOSEY+2mE9CnxYTcj4bN
         tKJiGQNxZGqvt5WXVnw8kbB10camfuiN/cKKM9sLRKBS5bjTjGiCYYywrRXOW0plRrMp
         fK/7pQUlB4ynvdaJ/jT08JkiCM5sX5SuwTODkGoxCnL1qa9304CqJpbsG+IRaWNmyFEJ
         yge/RN+7Fkg7exBg0mJic8BZd9lcE7jyPi1VvPzvcyN7kFsIQn6oX7lRnm/JnyFLbOEX
         KzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796370; x=1724401170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXg+lB1Y9hiiUwuYsdnzVumsOx9EvCzW9KQFQaaXx58=;
        b=lqlZ4dMFx9O+T0W4NzRVqv8dB0ITvvRKuVi20YXA8bSOn858rBerSI36wtH+pyjC76
         e3oPYxfj58kDHuF9w3Mlzv+zBGVvfByJeJIc7XNUmIygUuu3IbegQNLNNWL4Tt2fSCLu
         05QRqU0Dff2Y7MFc5ViHaN/rc2SYwAMDMYdnPEFyt3seqgb7ITMM/E0g65bNxGsJOKnX
         9QjUPqqcH28sfPJ50C715UC5vnYWXWwIylf6f9BMmgTHzVGlOjfdyb3d+13MqvdJlvcG
         WruQ0SYKiFHSQp35KGsHcV2cecwcmEfL21RFtoUyUj/tPnYGOBFhzasKtfN6D/AA6D5u
         N+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUwWrX+2baykxUM93b4AGpcpYL82LHKRoGKBOE/L7N3L0kMJTd50nNc6/oZcx0tmZh2lKIC8lGZM7kWkOK7qTUx/yV6cNj4bVKC1dW1ytR39lLqHMa6qhzU8/g2CR9xK7wvw4cCBV4l1nscgJmk7e9bt+8oQmWZGSdAlLnwgkzg4aZiOOeN2EgE3Ly9Wl9SrZJa/+o/x6mQq+rZ8VmuwTqjuUxY4RU=
X-Gm-Message-State: AOJu0Yz0fDrWInShW3L7KR5okWbYfGEaU/K9zgPUwXa/V7ZIH4aHhAnD
	ZoMYvETIYLT05GOtXiV5DIF8runXsIU3vRM1Wi2QsrFnr4FlnJ7U
X-Google-Smtp-Source: AGHT+IEif3KkPF+pYJhrYQnOK2rzYGUNQn3Fv77PzHZu5B3nVFW9cXf2Uj6+vGaelWOExKB06fZyTg==
X-Received: by 2002:a05:6512:31d6:b0:52e:fd53:a251 with SMTP id 2adb3069b0e04-5331c6f599dmr1250098e87.59.1723796369539;
        Fri, 16 Aug 2024 01:19:29 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:29 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:14 +0200
Subject: [PATCH v4 08/10] ARM: dts: samsung: exynos4212-tab3: Add battery
 node with charge current value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-8-050a0a9bfea0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=A37c37izrYWJf0Fe0JOtEKWVSivq+OwwBBfAr+DI200=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt/X4j09SNcjo4JpyDsxm/BTFk7K+YQVfhD7
 dCdD5cZu6qJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfwAKCRCzu/ihE6BR
 aO13D/9PAHdTYJSu7OeR0eeBISaX0R0zccU3OMZaRAxxL+BZlYNWaxfnTZJNp6M7/Jr0cxK7jw4
 qBHqTGjHHfCe3zdIEeiEwXfqMx0HuUbKwl8wxXKtTtkwt8xjERSU6ubzhKojPzKyR/ZBVVB/Eaq
 cqI0WjhvEtZLbDicYnOyWF2zD8NXPJ2lc4LCDwtTV50WgSXjXjzUNUsqs7y5ve1xKD+kB3DahDE
 VtwlAK83fpShEvWLowtNDJ+flomZvBkAfrPTzdxwcj34P6upPgo605wd+/HXnwLkF091cVcF9Mj
 mqVNzySXKKnX9Ic/9cyP6yvspoBvTkwiQ6cjcC7bu7zkyJqRlluTUlpMLVb9fS57YFZaLinT+LZ
 rl1lzAilD7A/8FJKRsgmZqIKxXGt3vF8bntE2vd6N9AqhOIqPz7D3buRX3peWJ2QcL54f28MlD1
 6j734AMwstNQKp1vmuOYzyRr7eGJcYw0JLLKW2bDC7ljZh+uzsY9lNc5ACBqYvbSIfBZznw9ikk
 1TJ6v5VQdlBrRNEZdlRdE430NQgJGI5N97cL1v8uOwaPsJAV6lIxyw5IMGPz1nVgX5MJTtyW1nM
 c3HzeoS1IFFKQtUgqow66VoW8envcrJgf5sk1Uqy4z255g8JoWj8cauV6E3Hkz6GCrg1dIpA5D4
 iODH1YT05P9otpw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This value was verified by comparing register dumps of the MAX77693
charger with on mainline with a downstream kernel under Android; the
value on downstream was set to 1.8 amps when charging with a proper
charger.

Add it to a new battery node and pass it to the MAX77693 charger
so that the fast charge current setting can be used for charging.

Tested-by: Henrik Grimler <henrik@grimler.se>
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
2.46.0


