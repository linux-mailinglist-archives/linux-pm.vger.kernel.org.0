Return-Path: <linux-pm+bounces-14238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94229978E05
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489A51F25241
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D23192B7A;
	Sat, 14 Sep 2024 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqxSHtIM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0747192B63;
	Sat, 14 Sep 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291615; cv=none; b=OGHxk8unUQJsQmSTZfreskCCMAeqIz5pVPpoMOwITeu35QDdpDBceF1Z+D6vn9tToH/Q8CFOqFKk4860fMIxpvpfUt8uIRLpZKwcE5BWr8bCvdAkwe1foa9I6Obw5ERt420rmTrJ1OrtZ5HFx0zasfAGc2UI31k/TFEdY61Fkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291615; c=relaxed/simple;
	bh=IlwfpKeYG1A6lmRpl2J8Js+0dUrkM33rNMIVVPeLcso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBcUY/5w7sO44ZjcpBsHXI+Prl7lJGWLmTsOQBQ8qicKuZ5VlAmDSBB2BNo7kdZJDU2YfsIpE3pgy4E/BY1GRjfuHhn41OIHccHbO+pU7KFz/4AgEJl/AZnG0rj2tVtk/aYw/jKsw2uwXzxmkrVfKQfYwV5hoTYpJWxxgIdBE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqxSHtIM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso1246518a12.1;
        Fri, 13 Sep 2024 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291613; x=1726896413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy0C2tn+S+ad9UGMaUozuLH5nIPIOY9VH2lYfYG3DPM=;
        b=cqxSHtIMhW3IZ0I25qq7R1PMrSYWmTnVo0QCXF8KJ5FKBLHoSReJQldWHt9OertdIE
         D2IBeh/8ILTYMVbO8+GtaKrzbJhXn9xt3GJNjMziJNM8OIoHiHWwefxdFBV+ExXoUJNn
         SFelCNyQERnotstjdU6pYA6bXHPno3qgwsrbEMWWNhJ5qG9YfqFdjNBw65JfMxNrGuJJ
         UPnRWxBJJzTI7ZJbgsqteFyFwBtrR8R3bQqtGkCTk46xh9Tv/TqGxXkk7qUBwwdq3Bti
         4S64DZ39NHlK3EXxHYa987H2n3oV69kyVil1u8DOrFxwaOrH7UjZJWoHhitAhGKwlkho
         EgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291613; x=1726896413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy0C2tn+S+ad9UGMaUozuLH5nIPIOY9VH2lYfYG3DPM=;
        b=kCBNFu/w/uEziYq4IknJwP62nbwAsWakN0aL+B9T1PWa1WXHoX0HInrQKj/fsL900e
         RLHYXn5NueiS4sMVEiL0sknjzqkPyfcAOJmtwygXGalGGa7wJSpehcDpNO/U02PwUpud
         kzOuCr/b0iPIRlW6yIg7VULV3Vie9OBwTjwq7C+sROSxdwA36Vr37YsjoK6sXkyeJAdR
         dDVdt7V+x0brhhiSKSgWT1ucIK9IeDujjUFikdbxJ7enE9JwqjPusNvAgsNOKpOj6+D9
         Ewiz2iS2GNy9FnfUDQ3m2/FlLgPpzxrCESVtzQbE1+kvkXd8M0lwBx8doqdhaT8B2Z7t
         LbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJafuLksu6Ctf6f9z724q+faK5PB1D8jiQ8XKA4ICp36wml5+I2VVdKvWY+vYyCjIwI+iYNyHKZwhMiw==@vger.kernel.org, AJvYcCVjGUcXhT2V3up8xfZWTNyy8EXwN50VcXc0cRxqXdNt7t8CGRQb2eY8rr1urr/RyxmCcWHFeRAfeesElzSVJXY=@vger.kernel.org, AJvYcCW5RmPd75dbWWqNq6bNRgWQ+KnJQIQvNlI1tRe+l6avrqGcA6h3Nn5jkUyx3/h8NOKBcoLfcj2E5/D/nBWJ@vger.kernel.org, AJvYcCWP2AC4HeaWvNY0S+jLy89QxVPIgp36gUVxex675safx3GdW8mM6I4ELfjZTLK7ekTfGzPsLA3HM5I=@vger.kernel.org, AJvYcCXcwNndotA88rzbmoBg+skaEz4I8FgAU0bPGY0ngp52eklShzbEUbInjLTPB8zwS/pbJ/jKp5ygYMqf@vger.kernel.org
X-Gm-Message-State: AOJu0YzESYxVdTK9kcgvpPKJNFxCbUlr5IvJW8NDjKf9e/VkiL1Txw2T
	KI3B/KkOsLEuj2atX9ANoUiM05oKaWusIi7/klK62f4cUI9dEkye
X-Google-Smtp-Source: AGHT+IFAx3i0hnBuicVE8YdLzp74NzUBOGZMK0WvmVsGZX4ALFKO/gW3JhnXQICFiSDi3OGKhSwvZQ==
X-Received: by 2002:a05:6a20:7b26:b0:1d1:17c6:7a38 with SMTP id adf61e73a8af0-1d117c67a9emr4578281637.9.1726291613169;
        Fri, 13 Sep 2024 22:26:53 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:26:52 -0700 (PDT)
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
Subject: [PATCH v2 22/22] arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE
Date: Sat, 14 Sep 2024 13:17:31 +0800
Message-ID: <20240914052413.68177-26-towinchenmi@gmail.com>
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

Apple's A7-A11 SoC is now supported, so the original help text is no longer
accurate.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/Kconfig.platforms | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42..370a9d2b6919 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -37,8 +37,8 @@ config ARCH_APPLE
 	bool "Apple Silicon SoC family"
 	select APPLE_AIC
 	help
-	  This enables support for Apple's in-house ARM SoC family, starting
-	  with the Apple M1.
+	  This enables support for Apple's in-house ARM SoC family, such
+	  as the Apple M1.
 
 menuconfig ARCH_BCM
 	bool "Broadcom SoC Support"
-- 
2.46.0


