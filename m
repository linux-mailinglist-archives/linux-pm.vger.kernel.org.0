Return-Path: <linux-pm+bounces-8418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1E8D47C3
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729371C21CAC
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321241822C8;
	Thu, 30 May 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti6CjaFm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D517FAB5;
	Thu, 30 May 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059404; cv=none; b=KSl5/Xq4P3Da2VBk12vUOaDIxDvgwGd4CNzP/CxAc+APgmufc6/h7m6mRhtpodCfFcwWUMz+fgTKVIvm0DyyeeM9Y1cyHoO+ssXACxVe+DXGGsFX495Fc3de/1TVRsMJEiKY/iK20tnBUb55METClPVbYFJw/f8e3yInCH8URNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059404; c=relaxed/simple;
	bh=fjOh0MJjj/plDrKA9K0KZ/bX8+GSDBRzqIWJ4jir1Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbW7X6aQggG+ROHkpI70RWhOlXjaIIxDUHdAFiv4RGCan/RV3LbQlcq8n+lkuKsFxiS1hg0U/dwsNhFnip3uGemqJBz72z77Ek3QOaqqEck5BgdLkuaQ/zZ3Q3o8SQcT7t9TSa84nxPoMMfTJlU64jUXjb9DZM5XX7LN5nX+V+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti6CjaFm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a63036f2daaso54458666b.1;
        Thu, 30 May 2024 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059401; x=1717664201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/bTfxUDpLBsxqobZuUMzQ5F6E7SsMJqv3Sv+i++EIs=;
        b=Ti6CjaFm6P9+5+gad6CC/QW76oeCB8SNhctDdBZLUTQc8qjyMY99ER2N65HWg1AbBl
         4GTNRBqZsmCBvea3jwCiibtXnah7n1QBffUTMerJIt6z8iciw01fxZSVHkyV7lrwjW0c
         PJ7dybdo/wYwjDMTEtyno+PGmr9UBGyoDH2CXpTrPWxNfvO8ACJGS/EMww1ZY+ZCBqBc
         IHdpQRQ1r7azRQ2KS3T0YrXCzRW5gpP63fK1lJ3sLWxNHA/NKx+aG+/6XqkKs5krQ7Cd
         eg7r5RbrPoBqgRmEOrPa8LSsej5AxA1BDXqmME86eAdIAq8ImWkqRN6aTVXboGCVhXLL
         dadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059401; x=1717664201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/bTfxUDpLBsxqobZuUMzQ5F6E7SsMJqv3Sv+i++EIs=;
        b=Tx9E+tMzbakL85sny14vjRyVUjOdRhJn9sxsu98oGoqqTk8zTNFJ04SmTzVf4hhDI4
         /whaVv+Ob0tsxZ7gHJNbT545XquwHHUfwnzrlK1flRaIn1cTPlVVpnmHYzyw7FtcfbRT
         Nb10d5re8sGpFaxKu1wlEIzBr+vQpN9HdYIJxQGI1an+Ptfn9Q/9qY7xC5YG5zy7iGtk
         tzAEzO1cehptPcCoBqS32sLjabviCpO+1esFOnz0PPec7BVD+jBMhi1QyOfmjsNxUbwW
         U+84jGliNFUXKMhMRqfcvKmaYOQPsD5/31q8YA9b6EDxdEt6UllFSWRClmCCuakD8J7I
         lpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcCkk+OErXo8CeOpcteLdu+mSWzQ1WATjlUT4dYQ8T3CXDLeLJxtxxm9XDeSJPSlRmt1KeRcrqOyxSTzF2ADDBPJJ+wA9GkJZ/LzXIdeBgHMjN0qzNYCTVCyvpn1D1XVwXlMSOL2Ub0uu5Rhchl/7yHxiKRXCyYMQ3RVBJBBquVGu9+6vuYEbqZPKQ5JcV54xrdFUPZ0AqjOwWoTohywYbQ+sfWoU=
X-Gm-Message-State: AOJu0Ywghz9qOiahOIbfgOHWJzfFNoKZKPflSZPy5rbxxSr4ACWJoO1s
	3ykbJQXkU4cxAUQjpMXJ0qDrg1QhUMevm2L0QP5GXiVEIHPs1jK7Zttsmw==
X-Google-Smtp-Source: AGHT+IG573BZMS5XVV6j5fgOeiWkxgpjXNFMSLM5231icRj+AWqiNBcvUSNKCU/IRhzaVgsi5S3G1g==
X-Received: by 2002:a17:906:4087:b0:a5a:896e:d0b4 with SMTP id a640c23a62f3a-a65e8e5d2e3mr98732566b.26.1717059400816;
        Thu, 30 May 2024 01:56:40 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:40 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:56:01 +0200
Subject: [PATCH RFC 11/11] ARM: dts: samsung: exynos4212-tab3: Add USB
 connector node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-11-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=1216;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=fjOh0MJjj/plDrKA9K0KZ/bX8+GSDBRzqIWJ4jir1Tw=;
 b=iWckinN8kfDKXZyUp93fjpuNF22RQGJf7qyhBbbG9wnGN5Ei88ykYtNMZdQQU+5qTudvzUHn/
 E8JEI13qHidDkix15SP7eOCW4aOpuH5PjY/ei03qHHTzr6K9AX3aMG+
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add a subnode to the MAX77693 MFD for the MUIC and connect the USB
connector node to the charger to allow for charger type/OTG cable
detection.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index b13c135bd944..2e7f7e8f6c3b 100644
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
 
@@ -160,6 +171,8 @@ charger {
 				maxim,battery-overcurrent-microamp = <3500000>;
 				maxim,fast-charge-current-microamp = <1800000>;
 				maxim,charge-input-threshold-microvolt = <4300000>;
+
+				maxim,usb-connector = <&usb_conn>;
 			};
 		};
 	};

-- 
2.45.1


