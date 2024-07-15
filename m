Return-Path: <linux-pm+bounces-11111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03C931523
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFDBB23D5C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A776318FDCC;
	Mon, 15 Jul 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIXtwzIO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7B18FA2C;
	Mon, 15 Jul 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048132; cv=none; b=APqAk14QXkd6vlGblqZZDKFTcbeH5FZa63YxrBpHJd9uAXtIw7fp1lMbmYpP1qbBQN2Hq3d0n38opiMpWme9dzTTkxgZxnzV/xM/nMi4QYg2tNkd4f7nHpEmuQA7ucsv2PmZVb45tReK/FzeQa2OGhHi4BWsvAo/oy+9XP1U9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048132; c=relaxed/simple;
	bh=JPvmuWMb9Cv6qRz3cEGIn/kWuF1SOLW1hi0UXwnEzKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZ6Z8B3i8nLuU/tkgTIxZiqFfcRWu/EcPyXV1m1STwcSfjKiTYQoo0PbVytUEjNRbuxD18gQ8pB/vqg9I5levc4BFe0Y2dWSTrbvpAXJIcBr6SYI9k2PG9ISfgvukVlgbJ1xPm30fGwUNT/pq0Pwec3rVOv7o6l6oQM6Hz2r21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIXtwzIO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso21675831fa.1;
        Mon, 15 Jul 2024 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048129; x=1721652929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g142l+1Rp8I4V1ReaaLX7dN3MJPiIMAN9KWL++3gC6o=;
        b=hIXtwzIOWrDvYitkLe5qMQs1KWxw9g96vgApmLCL3xxcORS3uby5rHn5jzcyCdytO+
         fVwrXzc7lMOBwJqOIcB3ovPNa+ed3LV0v2pqq6ifamgAit+8tMKLPM4Ggq8lRk3u9xbq
         8TpjW3AMm2kYsL2KvSLw6OurkvVN9AjyxdZ+/4YZi3LJMrHLtub9yfS6Rw8mFIzO08DJ
         18cnACU2Ko0kVUbPv9bG1zYuWAdXfSVHjEnZ63EoDPQTL7A82McB86HloUY1MBu5LCoZ
         3zTainZ7fSkPC42UjY73j/HjTlf4jfAMeYeJIul626roCQ+8R6Y8zt8mZkFSOFcPwmCo
         0QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048129; x=1721652929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g142l+1Rp8I4V1ReaaLX7dN3MJPiIMAN9KWL++3gC6o=;
        b=rWo3BeZRi/W+6885Qo9oyKftjGDe+zKRq47MiEsoYHdY75V7AOfVdnuUdOorVC9Gf+
         nvtq0tfw5EhL/3eB5pD8g/3uy2G9R41WNa1IBmnQ+sCs1KBW7EF4qYXW3nyNuBcYts0z
         sqH+UEDo1ansl4yeIJRxpvdmPumawdmKsGqCr/JLXcSjHlQOHa/fLYK1IxLZacPOJ6jd
         HNqXjV3pjbqlzy/FshxDUVzudJrjWcEuUMXK4aVtPOkLqcstHTrn5/EjtUW0Ki2A9SB8
         4dytpO41CCF7f//u2pki5eMes3r2Ah+2sE4JiEKkL+Txk0aoqD3P1bkBDQZXrnqJ8XDe
         NOSA==
X-Forwarded-Encrypted: i=1; AJvYcCXPhcM5ymzLFxxzw7FheR20KQGMSb4p+1OF74O8VmsXaiaL40caHHQxlFN7nvrWUA/Iy5yGoxMPniP6HWNIZFDl3tZRtPuwPQr/7rkXhNXC61/6dmVLCLQAWpJJHCerSa0i/X/FaEMX3O4ju2aFlEvCpwoKPf4YWqLCgsE10cPlfpnTwVGFzPyXcL2/ycrUgi6a0EZwzTwGlTvASnIC8PAckMUQosc=
X-Gm-Message-State: AOJu0YxchuPRxiasQv+1wt9JwEYGzHiznAa7XadVb2aNRF27rW0FUxlq
	92B3lreW/gbXCIMoijqq725R4+gcaF4IpOXWDwPbDsgjTg/buPBTeizcrYFp
X-Google-Smtp-Source: AGHT+IFx8MQcTRzx3JN+U8ZxghUQcdnvTgYnKydFLvaBZKUXf4eaprXj8MMYOE+oITfaurUMxJRBMQ==
X-Received: by 2002:a05:6512:2247:b0:52c:dec1:4578 with SMTP id 2adb3069b0e04-52eb99d3d82mr11609664e87.60.1721048129043;
        Mon, 15 Jul 2024 05:55:29 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:28 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:11 +0200
Subject: [PATCH v2 9/9] ARM: dts: samsung: exynos4212-tab3: Add USB
 connector node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-9-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=JPvmuWMb9Cv6qRz3cEGIn/kWuF1SOLW1hi0UXwnEzKQ=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwqnFSOEjC8QWSCPslauoOTiO933O3gvdDEc
 e3gOsFdVleJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKgAKCRCzu/ihE6BR
 aFmxEACYfKH/GNZtUBx1ayE51+WDZH8Lsh7YCHzX0J0u0GIF7sy4e52YDmnH48GfzystWyPPaXX
 4tChxghI0ZSVFts1vH67Iqd3zBRaDCJkHERejtV5sMP6QIX5hSlqD8pj4OAFPecpgcJG3dT+pLj
 IK330kJ2pKG36NHMRti2HiX1GtLzdG4YL7EakFGVo79x2s0V1dLXYrUz8BGFpeEDT9sHnYVA/0x
 wKkvzRnSWK+aGj0Hj8AQHaC6z3+0J0sJin+VltFKpxLIIFuQtVZJzz9YXH+bpaHPg2oBBf6ixhE
 jReLMZEDFWSyt+bStQBUW6pp3ZB7vTx89JFQh1l9eIzLwufABxHIWWcKBcK1pBPGaWE5T42vLcr
 tfLeyEG9XJiypKn6b9SPCVsEvulMQ4y/zjhOZhiLht7qe3EtHkEEex0SAOKD1IGsR01bVhnOtfJ
 f4ojHCmJMu58yv0PLcKYW9JzCEW4zVp3rePVQngPLpYhCbM+iskfDyhP3z/d0aiBU05GojgWItf
 j6YyJEC0wpDsLiLDZF48LEMBb6sT3LjQtHXcME4t6fJeox3Nw9KPh6Dh9s40VGQxSzETgSd+i17
 dB8Pf1NRrzuZ0lGjYPXjfPTh8Vo2SMTqsGlijr2xWVcWYxXZN0cKKoIix6fRrngVy79JzpYP1FL
 tULnfR+O6VXKZxw==
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
index 7905e33234f2..f5ee3640a940 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -151,6 +151,17 @@ charger_reg: CHARGER {
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
@@ -160,6 +171,8 @@ charger {
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


