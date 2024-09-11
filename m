Return-Path: <linux-pm+bounces-13986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CAC974D10
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754291C25C57
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D517E005;
	Wed, 11 Sep 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEpznqDn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5F17DFE7;
	Wed, 11 Sep 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044423; cv=none; b=cFE619hCutS/+1ZC0uwIMNDcJif0LiDM0+CLCVcqFhJAyxVJJ1FmCWbiJ8eBs8WC0unLvjwI8KOmd/0JUPuDD+m/b+f7xbCjYvLgYTacVgwBJbdHaPt+ZcLV4EReN5UsKLvHKijm1PP5mEu8+PMc9EYbqxCXssuI+HV8G2zurTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044423; c=relaxed/simple;
	bh=wjv7S2defJHb4w2LIijyyI7ICLEtDGHr6+Y7Ed98jvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5aQYIK8VO29X/4UsqZHleds7d7p5YFOGHpr3c7tvHjPo9fh/U1QfZ7KlQBWUZcUjtH1NQPo9N1l8S9IGMQZKWiXDjpxXRKvB+IRrYi5TYcMhIgbyPIgfoib86TcQtkKcaATYdTCXIvRkSfN2yq+1ZxfTM/rITwVYDawFk5ITik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEpznqDn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso4549520a12.1;
        Wed, 11 Sep 2024 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044421; x=1726649221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drlfe7ijxNosG2VKP6kf49hdRW10I7zx+SACXHP4QNc=;
        b=cEpznqDnnOTJXNEZgiIdGodd/TE5DQWXZFNbfhC0IpKUQoEJ6U5YuMWQwPrAInzAWL
         Aruo0yp3rFNtSUJEjnI37OTOrNF/J1X73lggC4JKJFfa8MzLIMtf8U+Om33YuUsFzcbS
         l0oWytDlxVZ4BnMR/xY57fPHddn2Ei3QG4ACn+paOoGZybLZgp4U6mkODDW2iYk+4CLH
         oMBGCQzlQtJqgqQKbzBWkV2QjO+V7eOggxMG/fqwhAoC/GykTmsROfXmQRx6f4n6QLSq
         nBSoLXQXoE6uADQrlvsEOXnCm7Jk38TKW9laFWwAsfzDXgx9IOR0lvckVcU8hklpGbN0
         3xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044421; x=1726649221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drlfe7ijxNosG2VKP6kf49hdRW10I7zx+SACXHP4QNc=;
        b=V0Kszl+QQpvmI4tRUDf85EmOciNGETI8k9fJHqw7uDTfuANdO0INyVu3HL9AFvLZMg
         5tCKswj4eUt34mAUyL2wBjYc8wSW88w9moG91yTmbx2xSXGVMbhBl0OzGJR1Tj/39gjh
         AqI/wRzwPe5/VBsC+8IoUNwISejdxeEEETugHrzFq8gFLe9d0lXLnhw9hx27LcMlLqV5
         LvSWQUiW+DXA1vFYQJj52OPJwjMy4juz965HUQmPYTkwVKEYf9z+SrpZQOf7qYs5Z33z
         Hoqra25Pka9o/GDWlLlcsu4dkFURzv7Y2ovyHce7V291mqzVerxB0j0kw6yesDrkgfux
         aRvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxK1yRay8PvVzd8tatbRGHKhDFGGvnrdYgtufZDGr0fhdWHkvxWDLDLrlufLy+7zfGH7jKu0KeoFGV@vger.kernel.org, AJvYcCVjZKiQo4FhmK6plkO1XMGo4G/dqjhlK4ltakTeiqPPDJKjuxKwt4tvoEMLDIQhjp4BlO0j4B3zWCk5d7oMsM8=@vger.kernel.org, AJvYcCWRB2HB7WiIJjukOxWzC61XwNyY3NFgkI8Jks/VBzgy+fsXLurNReFh9dre/SiUn13aiRZ6sT9Ar4tAgYiJ@vger.kernel.org, AJvYcCX8hbDom4NLfAJFQSrgN1ZOIFYy+6xHubttNlaVAWUo8Vc+nhzos0Kv4/bEjXFAi9J6xjqiLbJOEoK2zw==@vger.kernel.org, AJvYcCXLCQFZc8Mb/m4zn6lHzA4/GA8M+hliuA2ngt7GJ6L0K+Q9nLtCXQBJTcF7qFpa7jOAKqpHq+auIxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqmKfBhWOTfRt+LmODpB4GfdMdJpEhb493OeQjCxkx3vNqfyZ
	gNVx03d0EPTsDyfIY5RKxmLew0hOPWYZ+DG9tkQpLiYDFZm7zGw0t8LaUqndeAY=
X-Google-Smtp-Source: AGHT+IEdAb8iPla587CMNYLHmoCGdjQJEE1KnhntFK9s8SAt+VoAwMchj1XQxQ5sg7+JKpi3Zu0qJw==
X-Received: by 2002:a05:6a21:2d8a:b0:1cf:5c1d:83dd with SMTP id adf61e73a8af0-1cf5e03238fmr5427708637.2.1726044421370;
        Wed, 11 Sep 2024 01:47:01 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:01 -0700 (PDT)
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
Subject: [PATCH 02/22] dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
Date: Wed, 11 Sep 2024 16:40:52 +0800
Message-ID: <20240911084353.28888-4-towinchenmi@gmail.com>
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


