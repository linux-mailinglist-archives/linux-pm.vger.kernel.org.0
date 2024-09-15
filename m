Return-Path: <linux-pm+bounces-14312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ADB9795B0
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F007288C1C
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B803A155352;
	Sun, 15 Sep 2024 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEW1Lvat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B11509A5;
	Sun, 15 Sep 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387787; cv=none; b=B85Cwc1BiRyY+ql9WEE3NLkmB4dHIZpGvlIwmygvWpI0aipFy4/ltrscfTAztGfoBMH6Axait/Ku7jK5r23mB5/ihfQLXXDrMrT2PBjGA5hQs6INiDBnYGHK2K1+bjiX8AfZ0CvEg5O+7Je2Rkpeq21ppP73qxjSG02IqgTEmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387787; c=relaxed/simple;
	bh=IlwfpKeYG1A6lmRpl2J8Js+0dUrkM33rNMIVVPeLcso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcbpANDJoIV9IK1Yeqd00X8U9AJZ3odsDQMPtK6XOaDV0Nm4VaXC0sm0dvmzyKnVv46BhE4fZaHBacXGE11PADZka3zYuQC9uKKWSWn199PdVeGVqnLmXdauSH1zQbj2IcPGGiyQavdEaQ+S0t3gkLfTA0GY33pY+TVE9dUgiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEW1Lvat; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20551eeba95so19922325ad.2;
        Sun, 15 Sep 2024 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387785; x=1726992585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy0C2tn+S+ad9UGMaUozuLH5nIPIOY9VH2lYfYG3DPM=;
        b=nEW1Lvat+KJEFwfdf3+/asoKqIBIPXFUiP3YQjoQDFMRgPVxTrNGI/h3RM8md/wnEh
         A5KbI4bTpeqM8e5OFTd0pLsR7k02SxX6cYWrLYyU+SJxmAvdIBneM48ykMPs0SVgpeRY
         xTU83ZF73PhuJ8f4/PHvCpMjv+4RfjwOJS5xbQWhqh1jyf4VS3VJDDqrNKSWUTB4vltk
         LrXv8KEwdNmEArBI30x/zqgV8a8sdt1QwhlXMocgJOGFb6ID7u9kcyIvWKG4YLcxixi5
         aiuzJeAtpfSDEGrOT3OkrmfOdxnufk0t9LraIgQ9onwN/PaNraG6yDtIfupHUp5UUtV6
         lH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387785; x=1726992585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy0C2tn+S+ad9UGMaUozuLH5nIPIOY9VH2lYfYG3DPM=;
        b=dG8XohxPlvavMDzZ4mwMat0K1/mkUJdu9UTtzTVSYfX/8H2lMuMrCVKrRmepZBCOa1
         vOvKU14qsU1doKkHspD1Y4Nn4y8Dsj8s3yarpG/XIHN5fqGdKS3ua74rLu3P0gBxgLn8
         ycfzPpQBShxD6+NjSxKffjbrQun0+lBW+vlS6JRO2NwIGQfyoqMdSvHOGEMH60vXaMyT
         /9T1cgvU9OqTLjExHHH06qr1ui3WJaLsXv0K6GnxQP2NKdW9sTzDWWZ4sr8PULjyx28I
         jdADn+VjKt7m1wea/7h2h/rRc6Pt4B80cUuS8sQe8Lvda0M4b70aLIn9qZuBc+BZ4bIM
         tVug==
X-Forwarded-Encrypted: i=1; AJvYcCUprWa1Jm4uLXBhXpuUOUbeBhCNdhtTaXWmatOuH5jzoc2WoGVfmuXzli5bHD8ibsDBRIHINaEd+jXdSg==@vger.kernel.org, AJvYcCVfKS8gfk8IDIvBqkCC9Bm4eLer48f4dSCOFGTn6v3vNm/w1BPM8u18YfZo7/33WJrpu29atieEl2Q=@vger.kernel.org, AJvYcCVksF2l6dNf9YpCWljcrEaU28rliISAL3s9XLWCN27R8UTSpCXgQCZyhXWeW1jM5zV7R9tZh4cRZ5bP8zG8fJ4=@vger.kernel.org, AJvYcCVq94PcLdNxBXNcxs/aQIN+FHlEHzhWdUvD8lQ1TkpsRqlI59iCuvmACz69ra8u0jv1r5hVNVCqVLaaCoPM@vger.kernel.org, AJvYcCW/HXOLs0YU0kRcvYdJ+GT4FcoNugvt2lChIu1aQFaLi8F8P6LnnVzgea+FrfsnpUIsPL5u3CZwF/8D@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9iKfh1ffoo+3TatUbD7sbgjEant2oXaxW79ct290zPwLMJqp
	94ax1ttwfjCb+a28uUTBrwZESEZF29gGmGr/TgFhLC6o+vAAn8Rh
X-Google-Smtp-Source: AGHT+IEhRWXW9tetbRUykWlZtl50TVcdbuFF9ykKbMI555PV2RLTxvSDad+vXmu1916oXJ3kbB/w4A==
X-Received: by 2002:a17:902:e88a:b0:206:ba7c:9f2e with SMTP id d9443c01a7336-207822414b5mr118708455ad.25.1726387785317;
        Sun, 15 Sep 2024 01:09:45 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:09:44 -0700 (PDT)
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
Subject: [PATCH v3 20/20] arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE
Date: Sun, 15 Sep 2024 15:59:05 +0800
Message-ID: <20240915080733.3565-21-towinchenmi@gmail.com>
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


