Return-Path: <linux-pm+bounces-12265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959C952C83
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D586B28E68
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEEF1B29A8;
	Thu, 15 Aug 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZk6uaNv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E41714C4;
	Thu, 15 Aug 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716102; cv=none; b=QbZNmjCDWeXzK+P6tmiofFpwxrPUG6X1EvQB4qJegcRR9X8lWMvHB5Ox7kTBJhf+BRqdPrQhX5SRJ3Wvh/o+FamFrHRIab4NIuPWL0pgaYEF5Trz10VY7CpomjL84RCGH/fUF+m0BSdr46Pk30w/h1rFa1mgYwoyJROs6YVgmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716102; c=relaxed/simple;
	bh=jaVmqOGCtFtg45oRYzh/DMwqAz3SGNoNTw6eqA/Lmg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=swmRo6pQn1/NVYbiP7S7x2JoH5zNtq5y0Sr2ySXJmv2T9VZm3bUu3/WnwNgs9lRhZ5UP3SLSAKbs/lU4Gh9VegvAFt1BzfVhiyQS9UI7tNKLW/L+YCdtX0EKlHg6Pans0jhDluS7rPYx3pFoT8WotCtmBsyuMEmcmZzYTfqaws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZk6uaNv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so10771081fa.3;
        Thu, 15 Aug 2024 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723716099; x=1724320899; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3QVgwooRVjSJ3KrvUJIGaJTMZOroFJ24cMZXtlDtZg=;
        b=OZk6uaNvQ8RtFEhXvNmTdQyQmv3+rRobHlArrSLCXLG0mhQsg4J7GlvU+ioawlVaHZ
         JM5pvBcgOm8mpBemtey2ZYWjGkkegOMy9Z7NUyWlrreLURCFLgUzI+eqcmO80nv9Z+ss
         HxPZDl12tbXziKhGimpkPbK0dx2TPc4tnHWNGd2z4vtllnngnZdVMY0LxsERgfocx8Z8
         gf5+HOZc9NbKrL7ZhAGDO7nIilkPM/657IhE9rVnqx8z5SiiP6gJGUAZO38dIAhQzy8E
         Ws8abYYR5vAyif6PxwZ2TKUG1JANA5r/8qOyxG16ktj2VeyFJKUHwnjDg7413AIXo8Tq
         gKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716099; x=1724320899;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3QVgwooRVjSJ3KrvUJIGaJTMZOroFJ24cMZXtlDtZg=;
        b=En03b+8a4datuVGszd36LYIK/TS6cd0ma3JABZjz4SvlsND/0md9xTY5kq83+lDAzq
         pm2zPFfk7qSzFskhGAgCQIx1wVgI8McRa5zDMA4JGYuvvokwN+r/ys6vzMfbbY1KUB+o
         AmKGcMRdh17ydaIVk7WvhYnBpVd4xp6mT/xAtKjto36jOSsWn9kNSPGgjsjuPik5iSB4
         OdJrMY1c184XUI2lnT+XDrVKFlQaQO++GbMmFCEmrCWb8odcXwUkJGLpYj4gPVJC+Zje
         TcH/MN7EiCkuZW1j1qZ3RNRGVVv169RUPvnuqGFndc0LCQv736W+81uMBqsWdQTpAzi1
         SQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGWD2Li8CiJsx8Ebe+cfK6XPovXdbT8p25SuQmpCejVecuaSvvE8nUobMOtQlonZjmBQQ0woqZWmr1h4JT5a9buo0kQYkQeFxLJ6L+5gtFkGTHEXWqZAva7asLRqz8jP9C8QbbhBVyUg==
X-Gm-Message-State: AOJu0YwizzZgf0ZFBVBFYm8bhTE4HEdZwIQUSnjXIpTzJaSxf0Fu+EI5
	GWA7D0p73q6pz63Aqcnhfz9SGS7CG6PLIh8WrJ2wpMas4jZ7IIFXDRXjTg==
X-Google-Smtp-Source: AGHT+IEAL3Yiz1f2/CnKrjPJq9cVxYnHIxycXqbGqzyYKUEyXDHG4CTcqKqKENK47XmCEP40d+PBrw==
X-Received: by 2002:a05:651c:544:b0:2ef:2dbe:7455 with SMTP id 38308e7fff4ca-2f3aa1d8094mr49205251fa.1.1723716098627;
        Thu, 15 Aug 2024 03:01:38 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfd7fsm76958166b.77.2024.08.15.03.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:01:38 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:01:36 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: supply: sc27xx-fg: add low voltage alarm
 IRQ
Message-ID: <Zr3SAHlq5A78QvrW@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The SC27XX fuel gauge supports a low voltage alarm IRQ, which is used
for more accurate battery capacity measurements with lower voltages.

This was unfortunately never documented in bindings, do so now.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Initial Linux driver submission adding this feature:
https://lore.kernel.org/lkml/ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org/

The only in-tree user (sc2731.dtsi) has had interrupts specified since its
initial fuel-gauge submission:
https://lore.kernel.org/lkml/4f66af3b47ba241380f8092e08879aca6d7c35b3.1548052878.git.baolin.wang@linaro.org/

 .../devicetree/bindings/power/supply/sc27xx-fg.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
index de43e45a43b7..9108a2841caf 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
@@ -27,6 +27,9 @@ properties:
   battery-detect-gpios:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   io-channels:
     items:
       - description: Battery Temperature ADC
@@ -53,6 +56,7 @@ required:
   - compatible
   - reg
   - battery-detect-gpios
+  - interrupts
   - io-channels
   - io-channel-names
   - nvmem-cells
@@ -88,6 +92,8 @@ examples:
         compatible = "sprd,sc2731-fgu";
         reg = <0xa00>;
         battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+        interrupt-parent = <&sc2731_pmic>;
+        interrupts = <4>;
         io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
         io-channel-names = "bat-temp", "charge-vol";
         nvmem-cells = <&fgu_calib>;
-- 
2.34.1


