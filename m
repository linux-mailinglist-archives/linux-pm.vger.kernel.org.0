Return-Path: <linux-pm+bounces-13988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F78974D1A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E553A1C23A6F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B2184524;
	Wed, 11 Sep 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9gjxPte"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D91714DC;
	Wed, 11 Sep 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044432; cv=none; b=CuSXSatI6V9O/mxn7E+2MVDYMNm6s4c8myhFhN7hitn8adw10cCqXk0zvwGpKP6Pg3q3iGBv2AEP5PYUkn00YCXC859tgJeVu+HBZruPa1szg8Yt60sL3OR99VOt5cSo4glq50aC4irHADROcdH1oTZEEtMEyXEnyyIa93+9ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044432; c=relaxed/simple;
	bh=F+fvD8tj9Q89DXXtcIua1ke1r+dlwF7u6BI3SFUU4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY6h2dwteuOzmWY2+/sOVIU/Uu61adrMD0U9qF+zYzFA3YDccJ4jap4HZS0lm+53mksNbuPjstoGGdX7TG8JE8vgUhtw7kiLq/AN1UOJzrWCiRUxEMFtFIxWjfM3wwREynuF1YPYsiDex6re5CqF40E32DefPUPTfIPUQDDCa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9gjxPte; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71798a15ce5so492091b3a.0;
        Wed, 11 Sep 2024 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044431; x=1726649231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g//YBvaXm4NDbD/O/tpcG0z+ryfJ+nqPnLFYEOt6ung=;
        b=D9gjxPte45nlYHqAQQyFVZIfX2nDFSnbO2o21T2AcJcJ/LLZzWkmPxZzw58eON3+/q
         hdFtO29AUA/JdNOFUHrvTbD5nU++jsspCAXejrH9Ay/pOU5PVa4dJPNyhE6xj8YL2dty
         sze69uZDNIefrrwugkOAiZM5rHxBp9LUNRkSzegr4VRr4G9Bv7zG99s5xBfrkp71ddWD
         CllRiRoMbeKJj8DGP6357Rg3MWO+JqeZoibIvt54hmF1rfqJBhS8rM2CHU7F3ZqT1mo6
         Ro2iEwoeEhhJCgSr0OU4D/vusATbbKDuq2410AE80e3Mq7jKbgJUmrSaBd+4KBDgXkXx
         vCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044431; x=1726649231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g//YBvaXm4NDbD/O/tpcG0z+ryfJ+nqPnLFYEOt6ung=;
        b=fOEhFN7GEXiqu7ibebLZUn8+BH+PpTQdvFPDgNZBhIqCirCniUPXw4mE00AzaQ3x4K
         Er/ql3TSmqQeHO677e0wxMZtQxdtV3NkCj08u8ZGtCl5OzenUIt9Lb/RE+N7JdbpC/YM
         umn2bWBwOs2NzociOz080ZVbsQj3Q3cmdJTwrdAF/Vu6usoCdx/3yfRtO+uxh+OcWL7D
         c02rOhI6/t1idbMVuizHJzt0QqbUUMzcFBOXdbdLng3OA+U7+yPSXIbUC/yRkjRI5hIm
         CdrGEvbjvNeaJohe8vWXObLR4Q4Nc5V6pz6iHz01UgIv36qToG7ZJR4GOqR/DHhfbI3E
         jc1A==
X-Forwarded-Encrypted: i=1; AJvYcCVD2noZIks14BMLkfbHyWYnWwL+7QK9LgyW0Uw3SXCfvBGD9+aolT2Wt6qP4mi4zMw4OLIpQkbB1NZ5@vger.kernel.org, AJvYcCW5NiDP/KYyoSIHi3T1gJZCkRGfpbypplRE7P4UFzUIdHgLN2NqxqbfKwQ7yrTw2E+sRppFjsyLEp8AZENV@vger.kernel.org, AJvYcCWg71s+PBVplR4O8TN7BXv5s/wkRTJwyHQCTPVVRMkaw/f7eSXwJQw62HyY2xx6n36Iug4/ToNT4Ft/ZQXGysc=@vger.kernel.org, AJvYcCXnb4WA+ZtEperyZiI6oxJTTq5lA3xUWG9xtqRuKAytwYj15xXy2UCoWoXPAJioCHCOX+jIZ9hDG5OsQQ==@vger.kernel.org, AJvYcCXtdDej1bXzLygT/ZOhX9246wcMn0mQc197+lpe9AJjxR3q8Zg2t3kZ845004t+wC2m6VcxHI0qopU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YYCG5uAwnIDaALHQiZs3sN4VGkdJ/g086Ut0wwBH6S3CeOYX
	whkQS5qa4vx/dcho0n6RoggXss80iGxI5Gic0w6ziEYJ787+hVTF
X-Google-Smtp-Source: AGHT+IH8/nRyylYUAFxI6agtFOCCglAgDxiqi0BoCGB0dcL7Mo+8ZsRc1G6ANoc5BEGZLhb8Gx5qxA==
X-Received: by 2002:a05:6a21:3a85:b0:1c0:f114:100c with SMTP id adf61e73a8af0-1cf5e4ae0f6mr5116868637.17.1726044430786;
        Wed, 11 Sep 2024 01:47:10 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:10 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 04/22] dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
Date: Wed, 11 Sep 2024 16:40:54 +0800
Message-ID: <20240911084353.28888-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block found on Apple's A7-A11 SoCs are compatible with the
existing driver so add their per-SoC compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 9c07935919ea..63737d858944 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -18,6 +18,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pinctrl
+          - apple,t7000-pinctrl
+          - apple,s8000-pinctrl
+          - apple,t8010-pinctrl
+          - apple,t8015-pinctrl
           - apple,t8103-pinctrl
           - apple,t8112-pinctrl
           - apple,t6000-pinctrl
-- 
2.46.0


