Return-Path: <linux-pm+bounces-14294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A09979550
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F769282995
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59B54757;
	Sun, 15 Sep 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMp9blUO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7C4DA00;
	Sun, 15 Sep 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387700; cv=none; b=V9ezC58GG01sr3lw6Qw0kJ3+DHJUcdNtSGMg8v0GkJFlneMp4sGKhhFCEq4K/7sN+yhjhPoGgbUDFTvw+XVZ1IQlbflRfSslruYGITmAosHMVPWWkR53kk4p+XW7wa0/w2O/u59Q/FRRdTSJQypv+aUMISh+GM5B2M0Om/GHu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387700; c=relaxed/simple;
	bh=wjv7S2defJHb4w2LIijyyI7ICLEtDGHr6+Y7Ed98jvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDf80XEEp0M51aA7tgwCwp0gAi2mTUKoi6lRTFFQ9Ai/LZLayJQjDGIdA5QTnb1F9Wyc9freHLALSdYu52Ya0LuIBcror7S6jHdaipO4HHm6z15B6MuDi2FpcBeeyTPgGzPrqvAfcSbsgD4f8W//8Cjf4YoGPeANx2acA0nd0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMp9blUO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2055a3f80a4so23247305ad.2;
        Sun, 15 Sep 2024 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387698; x=1726992498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drlfe7ijxNosG2VKP6kf49hdRW10I7zx+SACXHP4QNc=;
        b=JMp9blUOoI0TsJuOYTyh3ksueXt9EpqiBLU319q2aAs9RHm4m5FdG5P+yhAAoAvfhI
         tMFXuTUzVQC+EJ97M/g2khy/ZqDkWetwaPnBR+302F4lkQRINQ+H/+BxWUAhRiZJAqQD
         vPvfP8IVTNWqAFpbkZPqnwZ5hECMxgaxsgsiyKFmKN+2IU7EeaEgsAXYXqmXA3kQUwmz
         TSmhbOT/viABbi5rmlJM0qqPo1VejLaJ9W6MybvVFEWIXzpitfj+dYZEulrycGrOIFu2
         1Jl+3zCFZVEorUThiAM8jvNOAr6go6YyXRjPv7/pjF2VSvboW31h1FKtyMqKTWjx4SUK
         3t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387698; x=1726992498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drlfe7ijxNosG2VKP6kf49hdRW10I7zx+SACXHP4QNc=;
        b=gnE+QCkgwJUWQDfHvJu5cv3oqQxouvO0JX/EO78rXhSJIHDH01qizuwGgJlVHfzohq
         2dmTjr9mWB31jO6bKB+2DKQy2ssBZd6CH5yIbB1gmlHYSMsrRJ6WEjUY2yT6IbFOvbOM
         feldkeGHoPJG+4BAYY0R11H/7t9lKPsZd+VeYInu6fpbgMCIwZ0xcVIVId63es/yje3/
         As9xWYAbVHlNvMUc5mZc2+nFn5i86Xh1fyFFTLRDZ1noIrkFE795XVKAkYpI3mIlUp+S
         d1bfn4nmTniL9c748jAb6/XSVUgqieRi8DqmwkWVpMfbZVhpTnM/O/LLQa0o9jrYslG6
         qPig==
X-Forwarded-Encrypted: i=1; AJvYcCUrrenOATHPk0nB9KTXxPFgphmS4CO+qyTEG0iVuyosxTwnBenBSRm75B6FDLjw+a7G2Qe3A+i3dDSHsnZb@vger.kernel.org, AJvYcCVR4+0+X0PWIEy5eZkIuEgZv8X/+HWg/lSumgsaXd5t61KNffVrButvPEMwUIeq7Cl/0OYNrAVlMkgPpw==@vger.kernel.org, AJvYcCWWZn2JBjHpSUqvgkY3G5DOYD7J4AdhLDW6LTNahqTtuN+yNVtd5J0rMh9LQaAt/UKjFFJGejmJhqRC@vger.kernel.org, AJvYcCWnZajKkuVL7Ctma7E7XzCdya2QNkTTuWwb2YVucpFWeGGsJXkoJT7BJhlyOPvm4XkMKtT8zL4F8cwRy0GbqTE=@vger.kernel.org, AJvYcCXgW/2Y1qhNAvCciKxN5POG+WtSwyi04lxKJbhug7GVUShIByu0Jjf9rAv5TqIdkTVGUK4hNAX81U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hdh5qZ9Wyk9WCIp/2mvl/tDD/ReyA0l3SPdKIqxplpbOr9Mq
	8+O6wH6qCiFCfhbRFluFKVpPOTj8V0WTOaq1U5GpagVYARuVtBPH
X-Google-Smtp-Source: AGHT+IHUBFOtzxTUHVVyM142oBd/8DpUUq5pjhWEwNRQ+YUW91vW2eNnMp5bhUx9eypT0N323Wt8bA==
X-Received: by 2002:a17:902:e5c9:b0:206:b8b7:84c with SMTP id d9443c01a7336-2076e4247edmr168126145ad.47.1726387698169;
        Sun, 15 Sep 2024 01:08:18 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:17 -0700 (PDT)
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
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v3 02/20] dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
Date: Sun, 15 Sep 2024 15:58:47 +0800
Message-ID: <20240915080733.3565-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks on A7-A11 SoCs are compatible with the existing driver so
add their per-SoC compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 21872e15916c..310832fa8c28 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -16,6 +16,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-wdt
+          - apple,t7000-wdt
+          - apple,s8000-wdt
+          - apple,t8010-wdt
+          - apple,t8015-wdt
           - apple,t8103-wdt
           - apple,t8112-wdt
           - apple,t6000-wdt
-- 
2.46.0


