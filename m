Return-Path: <linux-pm+bounces-14219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B7978D92
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17F9B26045
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE035914C;
	Sat, 14 Sep 2024 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpob2ei+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDB433D5;
	Sat, 14 Sep 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291521; cv=none; b=gIsDEJAdIY6Cvd8d/UL0KnG5GzAKRdf7wq/+5yxgydzCOVipwRMiLwBVK7zpenEtzwiBV5r+3b5JPCGqXXtbJLPFPURv8zj0r398mGqu84/Hy8DRd8b5mqfKL7+1Ofld07GPxwUlnvN8wtvjCtp0cPRo/VN+QDy5RloL6Gc+MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291521; c=relaxed/simple;
	bh=/TZwa1P5GOi0weNisvEEpeoua8fx09BY++vgJdF9ecA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+yNPVbMGrp2R/SplYX1Tgp2Ma0szjpaKy1/dP6fs5tupG0GAFz5Y9WH5wpJwqpg3UqeH4khLJ17WHuJiMeYKIt8rYhGoz1EYClUnqiwTG4xLn9Yrb6kknViCAZ27e+1vdOtCgIGb7ch30XF5cEtV0X9Hv6jXFggqEI1yYiRF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpob2ei+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2219819a12.2;
        Fri, 13 Sep 2024 22:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291519; x=1726896319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeDHamkVCqUamIh6SnSmGPyPT7GfV2/5V36/vymSx7s=;
        b=Lpob2ei+AZ7Adp2VRRoVZpLdSQk6tpotouGIQOfJV/3AlDzeOnRlPZuxxDokppPcmY
         vCJ85fF76dgKUqpeuCUzjVHmE7xAh7FAoIPOUbPbAMIx3X21SZQZSNf3PMvCJx7aKSbD
         j02ggYkhPXyJNYg0xlotRroZwxWV663gwVnkzXz/F1h3gbTJhxvn7PgXNKEfOmEV04Eg
         k32V937HJMXzElEWbElERbHZZwvhw7qB9dvUUxIEAsNpuuDlLP6nGi6U2i0Btyl42e2M
         dWnJ9+ZpcQrmqlnYnzPfAgNERG3DLDVBgEcBXVmLPsBhAes2AXqEEu1y8g7OOfUNlMMJ
         TjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291519; x=1726896319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeDHamkVCqUamIh6SnSmGPyPT7GfV2/5V36/vymSx7s=;
        b=J/8RMmRYfQaX4tmH+hER7+U1ljabevA0zbMY+yZSvr6n2YLVtoi2D8KUXj+hkWJCOA
         ixJfttCWpytAPY78oyP8VzskVZ+ds/y9cps58CSPRj11Wk6sSwACuwLySAz14RhiuT2q
         +ENyxrF61OzIC1vQhglm5xKDFmPaVnmSOjK+yhuh9F0Hd2od5oQKkVN8mp2FevzVLq+/
         TKwYysGFC+KKezWTBQjQ4wZnF8jFwz6o8Sco/vVJQ/RtiYIHGEuRHe7643js2mog6bt/
         mGvZVvsAzO0zVdNt2A/Oy10ahZIvw0gUoDip90orUWBVmA+ylTwk2seq9RZn2WHAi+b/
         BfBA==
X-Forwarded-Encrypted: i=1; AJvYcCU7NWMlx7y39fGlTAWElNbk5H97QXz9BDhDoDjUVhMMujX4G5SIa+bLqjh4GVGshGHN3FXJBkE38iRp4sCXj8U=@vger.kernel.org, AJvYcCUDXhl8hBQYU4mbHjbl0TPeVkRkQvOrSGKLzr4R8bpJ26ViO/c0bs7UADwi/wvn0VQHPmsVq2qgEwqara1H@vger.kernel.org, AJvYcCUUuumtm7QzDCf9E4VxcjWwTdYFpQCZfL4EQJDoO2/QrYVcNz8dqM4wrjV314I5GDhMehE1mIGsTPE=@vger.kernel.org, AJvYcCWz4AP9isvbhPN3twPZb1x2vU75hwgQSYDrp8Wjus6PU6ylCu+JxuDAHPuGbBcrMSiNHbt7ARYvTnVt@vger.kernel.org, AJvYcCX0Y5wTcw7SRLgYDuxiwOId8qIrUqvUTSK1QalTXVVIsZpTrsuxxkDaj0Uj9UN+BqSGQIPN4ueh0xNcCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WzYY4vXAce0EmMMW2oaGdGmS95S3tzjlZkLPbfwCxuUfa+M3
	4hkPPckIpEXR1KPTDHyoN3GETEPfZVg+ZyXpZXieoN/4jGfdvHKN
X-Google-Smtp-Source: AGHT+IEeFol8fr11Klxd7ngVl07qcK9mskrnyYRncSe3V7C2OUexW3oojx4o4eqOFCi1cDiEQtFcLg==
X-Received: by 2002:a05:6a21:3982:b0:1cf:2931:727f with SMTP id adf61e73a8af0-1cf75f005demr14139271637.18.1726291519342;
        Fri, 13 Sep 2024 22:25:19 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:19 -0700 (PDT)
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
Subject: [PATCH v2 03/22] dt-bindings: cpufreq: apple,cluster-cpufreq: Add A10 compatible
Date: Sat, 14 Sep 2024 13:17:11 +0800
Message-ID: <20240914052413.68177-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914052413.68177-1-towinchenmi@gmail.com>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block found on the Apple A10 SoC is compatible with the
existing driver so just add its per-SoC compatible.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
index 76cb9726660e..e0d1a9813696 100644
--- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
@@ -24,7 +24,9 @@ properties:
               - apple,t8112-cluster-cpufreq
           - const: apple,cluster-cpufreq
       - items:
-          - const: apple,t6000-cluster-cpufreq
+          - enum:
+              - apple,t8010-cluster-cpufreq
+              - apple,t6000-cluster-cpufreq
           - const: apple,t8103-cluster-cpufreq
           - const: apple,cluster-cpufreq
 
-- 
2.46.0


