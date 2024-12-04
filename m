Return-Path: <linux-pm+bounces-18570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BF9E46AD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246FCB44A6E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32321202C2A;
	Wed,  4 Dec 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcjmpqrF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2051F6691;
	Wed,  4 Dec 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343015; cv=none; b=hedDK8z0lOojMoUrOzcoPEXpXxgg3e9SUVSlT1qLic247iZhKexKoAYIDZnZ3SYGU/DFAiXVesHXcmoJtPTnHr8NZx+UvTP2xs2kx7IM9icLxxZEYorVeqFg0oI2ska3qMsCJKIfVX2FJQMToxJhMeGOebktgwvxOq/rif7NhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343015; c=relaxed/simple;
	bh=RPQPYzIUrIV7KUtwuEchVeJdACROjNk9ItK/nS5eUAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxKhuVd0fK+5FUCkSrVvDcA7QD9yB8ihGvRYb570pvGZic2902fP1TMUIGM+ASZEcTj2QhGJ9OgVdLlchj6dgwdhZ1WzfBazbifEta366SLlGDupWd1xGnAMLKHYJw9NHHOZUIMaWjIRBQ7No6QV2LV8TFFGWn8qfm+R95R+1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcjmpqrF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0bf6ac35aso138780a12.1;
        Wed, 04 Dec 2024 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343011; x=1733947811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvEYgr/6tTPCr/J7KKhyXeJ8K6wnSFjt2RRmJPjvqmw=;
        b=DcjmpqrFgfEI404mWsTxUM1AbcI9+RxLbRx2lrutnTI9ocrFjDxmwgDaGMYvlGxUFj
         Mq5XF309TSv787UvgusTlCaqyaVqzg2gsbFsDXatzCGG1Fol09SjSnpD+PNTOUKFFlSW
         fb01AArMHqM1Wzc4Zhfm1vamJukw8gheajUARQSKKIt/gL/N4VU9H3dpYt+8cCaKoapy
         ML860WnJ+LpKC5vBHqMJXkI+BJCfw4Oa6PLCB0V9a/wum4Uva8r4SyBIam9i7zF9SONC
         HyVzKPfPqwWIaZfSZUmT8gPYbJG+x3ThjsfbINoSq/gYvl5SWyDvWzqJKPjCvus/9H3j
         7khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343011; x=1733947811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvEYgr/6tTPCr/J7KKhyXeJ8K6wnSFjt2RRmJPjvqmw=;
        b=FOiUOkpLqNGjPQ0hXDUYKQHQy2PvPKAbzuxmdCF7JKktjYG0sZ6R6DSxVod7tfWQKH
         MsStbT6zlrkzaQoPd74zwgI5n5wSlVE+Ar9X8qlu3ZqYhvyNzRyVoto6kLdBOqVuchTm
         BfH53kQnpW97RIpOjmBKs/0yy6OuURX1jdDsaUu6loZdh6HLdQIrp19xHR7LBOIVZogh
         YCP371K+oW6v5m2VGiOtl2ghKvu+RHzIEFfv/OkPlhokYj2o5veVR0FcSJun5RSWnOrv
         n5G87/6OIXAs2K5AQgrbEGDQz/Uxjn+ynO21x9tPhGLZyvs3/BsYwl0umWMo8YpJQMuM
         /82A==
X-Forwarded-Encrypted: i=1; AJvYcCU9AmFHosOXCbQGUYHR5svwKqGkTkHZzrq9605N5mzpY2XnFoVIRWGLfn1zaQQjh55JubOR+wAs10yCTQ==@vger.kernel.org, AJvYcCXb1lfS9JFthiMRPKRFTGnN53KC3ECeEHU2DCqpj2fpDujtuLQo7I6ke2btqcK3L1EcsFeB2bCrZRWvnUVE@vger.kernel.org, AJvYcCXggeDm6ukm24qaE+FBhS5MF5O6paOujGlhpRhvhM0/ZSnQ0yDMK4NpXz0bfO+tiFQ8bFfFKotbQ2fVKPY=@vger.kernel.org, AJvYcCXsOnRfYumqehe1GguC27MgWjMLZsDCqVJIRyAVTOhre1QghBX9TZqP9LhwIT05lWO6X+ThQCLkBNm0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/febtmUfFsoZW1y23rt7oRzwujBcoUGObyzUmFLSm3/AFYdip
	AMz/CIukENgUgeN3PoX3+rafKrU4nyYvsn71yKsYkEqYN5je6qbiretbnA==
X-Gm-Gg: ASbGncvnz5XFmRXO4RTDE5WchmZTvp2hODbjZBQSt3JVEKstrFf6CQ8dlxx8pQm0Kok
	5KERuZ3ZML7ZdhV7OzTAmoqv9P4Te5RoQbjuSzgnEG1XCxvk8JaVdIh0xCCoy1pqSkwYGw8QvdV
	S3GkReUIYJh7BWu34cr1A9Ps07sTuvhAX5ReHsHa8+Az4R9CM7htAWaeS5j1CvvDZw7bbm3cHhz
	VcgZMMiXKwEBE6VrAJ6w+rOlG/KUe/HZzC94+dUAE/lkNfT
X-Google-Smtp-Source: AGHT+IEzr7ntDpPcQS/5uHc9iPibkZ0jlntra62Tz5y3XbWzANT8GEqg00Aa+rtdPGIWpW6yd87VAg==
X-Received: by 2002:a05:6402:4301:b0:5d0:ce1d:44ef with SMTP id 4fb4d7f45d1cf-5d10cb564c1mr11264596a12.13.1733343011214;
        Wed, 04 Dec 2024 12:10:11 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b7ce5584sm6266526a12.54.2024.12.04.12.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:10:10 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 04 Dec 2024 23:09:52 +0300
Subject: [PATCH v10 2/8] dt-bindings: power: supply: max17042: add max77705
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-starqltechn_integration_upstream-v10-2-7de85e48e562@gmail.com>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733343003; l=797;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=RPQPYzIUrIV7KUtwuEchVeJdACROjNk9ItK/nS5eUAg=;
 b=BzSHFDbt7Ayfe9wdSGOHsd8aYVzWhRvmUFcvQYnbo0RRXTFjhxXESfEHqEmyWQxuqjSY0Kd0R
 b1C/GDcBx3fCI7SJ9S20o4RkAUTekhksMzBQsOTv/uScOUP8KaNuyfr
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v10:
- keep alphabetical order
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 085e2504d0dc..14242de7fc08 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -19,6 +19,7 @@ properties:
       - maxim,max17047
       - maxim,max17050
       - maxim,max17055
+      - maxim,max77705-battery
       - maxim,max77849-battery
 
   reg:

-- 
2.39.5


