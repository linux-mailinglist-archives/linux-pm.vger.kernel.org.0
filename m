Return-Path: <linux-pm+bounces-11580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09793FCC1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B6F28373F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155518C336;
	Mon, 29 Jul 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd+jF2iV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40D18A957;
	Mon, 29 Jul 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275287; cv=none; b=U5VDj/mlD5ahCZ0WiSRCCRCln9qKIhFVJcy/vp8Vl70B5JCac2zzYJkEJNAiXZn9rRLr/BztLW5Am6TIdn226EH0FanoI0UWqgxDkaRLwT886Xfd0pKu5i6hoK9MWUH55sIq3XbpEXxCaI1ns8SWkaTy+K3+xy87bpnDxWzIcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275287; c=relaxed/simple;
	bh=9RZit0ywU+LgXYJREclxZIzCm96R2ILsMrecyNIUIjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FofP0dMeQcAsRM5CBEBpGVPe/MC1zXyuNlj6epK7g/iWvE6H2FykLBwh+lPOAHXWKkkwPYxM8AlxhKysuFHqNq3AHQbFvmrfZeITlFCiwuYQn9PIOP8WZfCEIgx320tmESeCxPSNox4uzTguhjkEwHyDNq54w5jRihSFILgAbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd+jF2iV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca782dso17234275e9.2;
        Mon, 29 Jul 2024 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275284; x=1722880084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyvnu66sWcNIBHuBSqyZilcpj0nKWP7q5mWgQAuw53s=;
        b=Gd+jF2iVX/n9ofNcnSKgPMBiK+97jRQkKWdfG6ejqKhFKav754P4MEq7oyGpH3KqnY
         A8s2CrINMTstlL7mCVRlmzYUI9iFD7g48m2T5qHOJ3fPe6yxsw4lXS2wNjoLKVAdvNGS
         AzLMVfQAYOn1+ivSu1HcarnAQYEII3/uBlUxpDlw9vAjRYq/e1B2EQcQdHYg3ymMp35a
         qgzf7anqhpYgFkm4x1Tie+5H56Kh1xe5cZDrbmqmTMW38qOaKANM36BFSTh7lQNfUNc8
         1oflD7RQI5o9SyG3zLvK3+1mtXWjLf/2iVOi8GTxuah9jGxUaTfikBjoqM/5WcIMO2VE
         exKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275284; x=1722880084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyvnu66sWcNIBHuBSqyZilcpj0nKWP7q5mWgQAuw53s=;
        b=J6oveobSIkxtgaPC+XITWmIpoeq8KRLjxEQrPYGyqiS6Y9NMkqFe5O44PXy8GHq9+Y
         oFgGeRkEnlNecqdQrCMpgjQgK8+9QbUdElEVgxdyfsIzDPHSiJRuPYm4uVRG026T+15H
         UeSsiNDS9NP8RAViTxSZpd6YGIyXMdILgFSyE4ck0dt9BKQBIYgWERGfp4QYqgRIuYx7
         DvhQdwD6ObfrDhli4Bg9/1CDL4/fqEu3xaIq13RxlT8OGnX1+s0q7MJAzY9vbZsVclyu
         6Od2CGl6tyNFIG1g2iPXe1UrVJvmlDgDwN5ocXZGCeQIX5TwSMkSjebCx1lewo9mtdND
         oYeg==
X-Forwarded-Encrypted: i=1; AJvYcCW5QyWfHTXmR/ZgQX4CX7O5j3mzeWMexVnpVHnzFruuvsTsZlPOJBSI+/StYeyYTEUZGvaXZ+m2UdWi0fMVJrYFD1ylOAx8f3lMf8Ebz6HcEzZp48QmQpDnIKu2JOpqaHnGgwPjvigmfZsq4ciad5luo1gdAc7aQGpC1VA2KUyWsOWs7gCNy1aeXGk0A6oX+ZhTSOlbjb0K7YAo7oLtwQr4dYVih5U=
X-Gm-Message-State: AOJu0YxD+9zsjHBHSTpH1XMYz2D49EljdZ6JTawyDPLGDvrbpAcSlhOv
	UUA8XX+AdnWpoKE8ALx7j7atyu8444ViSANGGRA8F+C5qqcTYHQU
X-Google-Smtp-Source: AGHT+IHbq94wdyrtZpENkrilKax9bwCk8OWQRo40k6RV87e26CshVbjqr2TeVfo1dARJco7mmmoLBA==
X-Received: by 2002:a05:600c:3505:b0:426:67ad:38e3 with SMTP id 5b1f17b1804b1-42811d73aa0mr59536925e9.3.1722275284340;
        Mon, 29 Jul 2024 10:48:04 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:48:04 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:43 +0200
Subject: [PATCH v3 09/10] ARM: dts: samsung: exynos4212-tab3: Add USB
 connector node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-9-02315a6869d4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=9RZit0ywU+LgXYJREclxZIzCm96R2ILsMrecyNIUIjE=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W/Y8o9dDElXSehvfvPuAOvEJ/fVGJd/Jg6J
 qJYSkTgi4uJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvwAKCRCzu/ihE6BR
 aMNKD/9OUVhvTG5ybHdGPNei8p3wQhAke2A2b73j7omwzlfJ4cmssrk/yY9s804hpeMxjMhm5Ys
 sn9xyjJXM8O2c82OOuF29jUmGwX+re7aitSlJos7L4bbY4SgpMYilWdUolC0HRyac4Qe06IaS6M
 3SX0jjzJ3K//yVtuUBY+8r8RVVHfkstiORdBp+P8f/fhQmSrtPgNHB3/SNu5CbFE3VdRQI8V/Jx
 kUjhkZ0jvF/FCw8r1PcRsFKpE4JQjqhVefvdJ3CiyYtG/d3c24admjms7ggDSqlOZM+q8kYgdcH
 7d52yCGY9a31vSFAwkz+pzvtnzFpTtPJWtPmQ7GxtkDkwYHsOInzKT0DjCV1HHCgE5RYgjTEb0C
 bfdKYO2B0f1XBMF5NFQCln3hdM9AP6UQ4EW5PzMtAimlC9RjbqtdG4EMbDAcU9PBqxV3HuucL98
 GinIN1j+5GH25f8d/gs5AJfiQhKPFvTc8xys6kUCMAeOoY858q0O2bW0dOet6FppiHZlUwkiVag
 Gl49IjgrwAuS7WSkB5/beYv9+YdzSmvsjoq71kx7WBI7WPF9vFw8Dz/ObN0mVbSIjqc4H1pU7SF
 l8sc7ZKq2xtSdusaT6siBjuB4z0K2HsDYaBWol/g/muvbJpiyFLc+DI1fWZfXEcx1DhQmlYjiIp
 +nB5RPkipsyhW7Q==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add a subnode to the MAX77693 MFD for the MUIC and connect the USB
connector node to the charger to allow for charger type/OTG cable
detection.

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
2.45.2


