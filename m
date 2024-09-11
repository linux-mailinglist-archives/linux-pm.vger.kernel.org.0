Return-Path: <linux-pm+bounces-13985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0E974D0C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D09B236DB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0A179965;
	Wed, 11 Sep 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaKE4Ncw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DB176FAC;
	Wed, 11 Sep 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044419; cv=none; b=DgaHj/lIvgQjA6BUkQYFUKtAlsNBPiJhHuU3jIuHhylpaW1OanwIO2exsxbt9eE9Y20p33fclYaFVvpZkQHXluwDXqgwRrClXb1QoCPKxfXSf/TjzgXfZgi2kvtNBIyBuFGhOwP3Y22KpkFEDA10lKkcRFQIDQ6WA0fs5eR5af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044419; c=relaxed/simple;
	bh=ynppOf1zjT5jg8yIuCyBCo3upiHCSvmiR/+jWcV/oII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM/Qh+I91leM/M+ZBErn0wR34cG9KI1metFPGUCuHelEfTHsXiqGXLhd9ccifNtpIIWVtZwkmJ3sDnkzDUqhiwk6y+tk96ugmr4OS+uu6cz9e+/8NY2Ld8zmA02JEzYBdKFDkKyojhozRzIzyVKiB1XMxGziKB6cNfkJzxAupmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaKE4Ncw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71911585911so1147813b3a.3;
        Wed, 11 Sep 2024 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044417; x=1726649217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhM6nn3shddOfQsAbEdajAgYbEDY5o4hk9hxIHLCtR8=;
        b=PaKE4NcwRrrTLZboVrORVBB2+JZNq5TEGDvPTYR8dbrRfP8UFLPSGhLsB59iNJiO2f
         inwBV8y1kUG7kddLTPC7NoKLw/f9VLs0dmqp4tqz6g7FcCImGFUlL+Fh/AW3dUgQYC8W
         SagXwW/kW5NaczEtsouz1lqO3D5+UYFbdeHKhEBT4GH6Sueyujgdw9mQCoJxz9vPZ9P4
         fR7DLDM8idqxFDP7GPPYbTfzZEzF2QBenVWWjvlRjLNOg237rRTO6XvPfE9cBBNQlSbK
         p6NBYknVgL5cGb4l2RYpOdTEEDZvqcD6yRVCYw1itqlyYVtqIoKBw4/03IWq0XEym/F9
         768w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044417; x=1726649217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhM6nn3shddOfQsAbEdajAgYbEDY5o4hk9hxIHLCtR8=;
        b=A2RFvYksJ/2oS9KXWnPVK0EREi1PqP/i2bpF5HU14fWhGP6TmKJmqlWyrsQHBQ0fMt
         FD7/JbM0GeHXI8S05z1DDxtqn9tQRtukf16+5MKWDyvoLmhqyfuh6V6op5Xo3OWr1gOH
         ZnD5thOjIt+yexYmMuecud+fEgDIa+LjwJmv2nU6k8zMV/Vxpf6tlo0VcGqMCBp6bQVQ
         0TC9acntu9p8MCfmC13D4/mZjEd/8YO8247fPhEJYtGpuje9L6hMVIiIiPnZFGsy7hXy
         Qf5MxPxYjyfMM82cWkPk7eS1y4nWaVVsdc9xAGBOs3SaaTaeD8Pxv1yrpCIgtEo5+JLI
         0Cxg==
X-Forwarded-Encrypted: i=1; AJvYcCVFOH/I22eTPqfzVrf5qlg4UJ2mxoDu21dIJ81ZKiqVsppKV+QSMdz6lMiA5gUrRzfPDSgTbEpJTKQF@vger.kernel.org, AJvYcCW9KFh06i3hE8Qjf9mfJaSXoA1Ored//0Z6Kku6o97t6iOIS2iYhhgPaO5mZZslHXoSh8vWiUSdHiuPnVl5ujM=@vger.kernel.org, AJvYcCWRRMPjeevV6OrXoR9ggqcfEEmUhWRjK2azRz7ckWoNBYOb46Uee/0Y5ZNQHdnOHXrfjIAHdcEhKfE=@vger.kernel.org, AJvYcCXmU1om5rdHiNUfhrRADqbfLllujfKbnFW4xp1rOxmsyvh8zINLHAe11yM4Qjb+4ogGWclMCgsyAjt0fw==@vger.kernel.org, AJvYcCXzo1tO61NI2bCmQxGAqahpdYfLxyoeAUhA0mlCKxkdSnANrnAM8wHUn8q63QKY7c1WuAouX0/wAr/z+UpO@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFF/taCYjsElJ5FDku8OrHFwT8ZyjPYJ/jcv/dXYgC87BR4E3
	E7TGi1lX1mFJetSoF0f3debJJoG8lJpP3PIWbFtE1PTyP/e21U2q
X-Google-Smtp-Source: AGHT+IFywTc+fEKIENWI2Af6Pl92YCnGr+JPtEAffWFuyESOnmaN6fcvn//eL2oTrduP+cJqvFFuqA==
X-Received: by 2002:a05:6a00:4fcd:b0:70d:34aa:6d51 with SMTP id d2e1a72fcca58-71916e16cdamr3995606b3a.6.1726044416677;
        Wed, 11 Sep 2024 01:46:56 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:46:56 -0700 (PDT)
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
Subject: [PATCH 01/22] dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
Date: Wed, 11 Sep 2024 16:40:51 +0800
Message-ID: <20240911084353.28888-3-towinchenmi@gmail.com>
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

Add the following CPU cores:

- apple,cyclone: A7 cores
- apple,typhoon: A8 cores
- apple,twister: A9 cores
- apple,hurricane-zephyr: A10 logical cores
- apple,monsoon: A11 performance cores
- apple,mistral: A11 efficiency cores

In the Apple A10, there are physical performance-efficiency cores that
forms logical cores to software depending on the current p-state, and
only one type of core may be active at one time.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f308ff6c3532..3959e022079f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -89,6 +89,12 @@ properties:
       - apple,blizzard
       - apple,icestorm
       - apple,firestorm
+      - apple,mistral
+      - apple,monsoon
+      - apple,hurricane-zephyr
+      - apple,twister
+      - apple,typhoon
+      - apple,cyclone
       - arm,arm710t
       - arm,arm720t
       - arm,arm740t
-- 
2.46.0


