Return-Path: <linux-pm+bounces-4500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC70286AA35
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 09:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549E4B210D7
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7432C6B8;
	Wed, 28 Feb 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0DeH1PA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8D2D05F;
	Wed, 28 Feb 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109605; cv=none; b=I3uW8BlyYrz9mbGDGsYqS3cLL7KDHm2jBudxcAT4H2iUUR8XaaQeUc69k2zTepB1HZEvTNz7LcJxX1XtuHxc+5DJNKAfxRRZvXlgdbmwj9AotolK2ocA45iE+RQiTwzF1xswygrE/J0zzocFF2IHDNkOZm84Fuh5UKkIT8bQ6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109605; c=relaxed/simple;
	bh=vW7VeVlY7tptgeonPLOL03jzUONpq69mL/EUyCyeWjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hqfz83zqteeut36flSb+LLrVWrA7C0WridAygbrp8VXA58g7eLY1vVX0YwnMNNrjbfMc761wTFDdxghALtyq/q4tbiCQlluiwhXvae2YalkvllIduUeguN/1gddZwcdVz6Y65jw7y4pvU2KX3/9x3TSq/9s7j6cvaSrGtfdUvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0DeH1PA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso10425115e9.1;
        Wed, 28 Feb 2024 00:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709109602; x=1709714402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKDsuau3knRC0gjwTo0VByuQYlnp6dLUHuurWCoEmlY=;
        b=f0DeH1PAlU7xATaVrt8W8RATErgcM4jBP8vdiixpRHdjU1mDNsyY7Liwd6w/pvACGX
         s3bS223e0hE02DneUkSoX2dtmAguEo6v/ACnfPRLB8vNU23REyGhrIui/lVCC+j4ETam
         JPDgtKEQKUybjZH1TOHWM5BLexK2MXB+Z49k9eevSp92PJtonTPGoby/S8dH9UXBS61O
         4pT7Y0YVouiyu9RKIZUI4tCQbOPTCFjKWb0ns5Wu/dubLB8U6Zsfgys5ET/1Y19uTk1x
         borcTEc+fdphGhe/d6e3dwqlnvU7Bhb58/5DrMzHXYjH4XAbd90wfMXvqyjBbkCaXmHm
         4kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109602; x=1709714402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKDsuau3knRC0gjwTo0VByuQYlnp6dLUHuurWCoEmlY=;
        b=rNMJn2CaJ2IwaLiFEfWIYPBgAXsOXpdf2yEeN7WnxQBju//6o3MAJhsDYoG5D5okUi
         ClX0oU9X+z6wOpUWpvH5MoybWjSTwl0/TSRM9JtZiTXOkhfyzujT5YadxxU/Drje9he9
         c5gtGDz4GaOff7N/q3WlwzlD/fHaJiLPRzcK3lxvreBxM5Oyklhi+zvGC1SnWfYW5CwV
         inYvgavH9VWv7jBgBNO5Qp3lHuoXm0wj20rbu5iFgFeeMLGeM7bDdjc7WVsofjLWViRi
         fNoKPLeIQFNHuRZmP+4HurSk59E8GHm056H0k9yPJhsF/viKhQhqxQMHeFqqQmDBuwiL
         B+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvL7ih6TE9qKQikCt8/PPN7M6Le2woHwKNNe15rh00Z2fIT/DIp7Ue9eYP2l9POq61Pqf9rHOaC9ftOYq7BHpA4IXC2DOgRL7t+A==
X-Gm-Message-State: AOJu0YyXh1DXUnnYf1BiLRQRGF1wLbSMhYYSQ4zpG3qtrDwJOgdpO5/5
	FrAoRh5CsGJIToQDn3HZKsiH3sFB3CY38wgGL+wYOK6oVwUzoxYWuRcCFhx97nDmgw==
X-Google-Smtp-Source: AGHT+IG+sAxIQd/6LsK9ihij1zDol+ZfekXomdQ+Ko+4myAW8E/3ulkmihi48ngFmg5V+wYxitZACA==
X-Received: by 2002:a05:600c:310d:b0:412:b633:af51 with SMTP id g13-20020a05600c310d00b00412b633af51mr370257wmo.37.1709109601757;
        Wed, 28 Feb 2024 00:40:01 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id x4-20020a05600c21c400b00412afd8425esm1343653wmj.24.2024.02.28.00.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:40:01 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: devicetree@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	pali@kernel.org,
	sre@kernel.org,
	spinal.by@gmail.com,
	maemo-leste@lists.dyne.org,
	linux-omap@vger.kernel.org,
	"Sicelo A . Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] ARM: dts: n900: set charge current limit to 950mA
Date: Wed, 28 Feb 2024 10:38:47 +0200
Message-ID: <20240228083846.2401108-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arthur Demchenkov <spinal.by@gmail.com>

The vendor kernel used 950mA as the default. The same value works fine on
the mainline Linux kernel, and has been tested extensively under Maemo
Leste [1] and postmarketOS, who have been using it for a number of years.

[1] https://github.com/maemo-leste/n9xx-linux/commit/fbc4ce7a84e59215914a8981afe918002b191493

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index d33485341251..07c5b963af78 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -754,7 +754,7 @@ bq24150a: bq24150a@6b {
 		ti,current-limit = <100>;
 		ti,weak-battery-voltage = <3400>;
 		ti,battery-regulation-voltage = <4200>;
-		ti,charge-current = <650>;
+		ti,charge-current = <950>;
 		ti,termination-current = <100>;
 		ti,resistor-sense = <68>;
 
-- 
2.43.0


