Return-Path: <linux-pm+bounces-30115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7664AF8DE7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D511C80772
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEA2ED157;
	Fri,  4 Jul 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iTDSd4iP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C279289819
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620115; cv=none; b=crZAxt7WRBwOHR6URWj6jwcg8HqicoAcpkhG5HLR/KIGf/T7Awyf8uYIq2T0TR4Y1b75R493IYjMX0N15Kb7D8zbNipOaLKjb8Xe8A1d0fMwZlRSBM6NYVfsrpe71r4fwPcOJY4j9HRG5NpKmDkVRml4r+vwcpifMWeiKedyXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620115; c=relaxed/simple;
	bh=nD+4P1Bz3uz3iVUljIyC5j66TnIismntlTPPL4CrSxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YTTw8UV+jkDVnJV3JV2PQ/kxIFpWcAY4IlijjIeykAxz0O6NLW330DxHNmv31a8P3qcDYE3cN/3eMdBt2hdExB+040Bl+vYOMWFFram0LIlSZM3jGYc8GA21KXVYP0mSUofwMKEE2IZEdR4Ze1gbWO8AyDdHiAjg7TrogsYdnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iTDSd4iP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso12755665e9.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751620109; x=1752224909; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jrF37oGgCnykTmpySTEV/xGCAvsTJIol9lj96a0tbc=;
        b=iTDSd4iP0ecTUrFwMzso37nd6pUJ7mX0OpEmbqEQIyP23xqX+nI898IjXtFnTpel8n
         5i8G/4KC8WbH5+L8FjiNwq3rthnkdumD7oTv25zU/p9rSahtDFYWSpsgy7Zhe64WhLnf
         /c1DPdsrFO9FGTyv25KvjRvDHl6XHEkiSd3wy7foajsJw1xY54RytgPE+EW4rBTyKFwY
         Oj985pTRpyUAN4FlbmvzT7ttkNKE1PBy6OoL0RGvrLKBT9bjUimK60ZdhlkMc8xx4YXs
         tLLyTLNOnYDUozMjrUkuNMIYQ41ZNxIBLkD2iWr3u/kd5axOWDJrdofPEaNSUECu5pRr
         Y+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751620109; x=1752224909;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jrF37oGgCnykTmpySTEV/xGCAvsTJIol9lj96a0tbc=;
        b=Qyi0ntk8ScGQ2l4l0/N2uJA+reahf2Pp+V1ajVCvlNHRJZ5RXSbm9kF7FHIMHiq9eP
         OeYvhSdU0pLb/NCLaa8FI/46L6DOxiEQzP81Is3V+G+Il9q6v6KBa5gaOOEjUvoD2rLf
         /WCHapuapAjdbTna3wJggAtnzlmbMCTJucNGFv2iv3qP1P2b5SUuHI7AZsO2KbU+kIRW
         1NZPJwm6ULMxRCx2XKYqtzuCyIHDQZ2/Iy3jv4zQ2c4Mi4wE9zlmxNrVGYTjuY+Mqamc
         2uZMkOXy08rc6f1ZWZepa/Dx/UthN8uHnAm8nury2wCJTUrI7skWMuBhde1mc1mdVqIY
         DH9Q==
X-Gm-Message-State: AOJu0YyubhcIi0paPpMG7+FPylCTLk+RpUjRTV1XzcM37uc2IhjTZ0oI
	itKzDJVouhjxYYhA61y8Ra/2VyIlG8eMFsLB0Ox8uvHUrBbum/8LPBnuABnvnLHy44I=
X-Gm-Gg: ASbGnct3jsFrfkosm/kUZLa4GphB9V+By14sK2nWfoxfvH5Gv4RmpvQ5x3eMzMBhi1/
	WuWKABbRvlzYcm/WSiODvriHg8u5aMOU47Z31yWGHhPpnnORoT4jk6tKWSlRCSRCKLP2iaEeqoa
	BI/+c3O1GzsTzEHjX3U56ik/yX7BfENNoSH5DyCTMIwExo6lKurHfhdfLvP9dbUH/WKHueTISo6
	h2cCbR3jaL1FkRxt7BLCXL490QuW5ffUBiTUIjpLgkXN24UAuSo7B15zhKg/mKr36LXo4xiK83t
	ZFbWVIOXII1k6CudbRldmmYuT/X1e9Oz8JRq0v1TXI+vV1VZvH3v24R1wlxeagSCmQ==
X-Google-Smtp-Source: AGHT+IESyVVs6vjvZzD+5wM7FVIZkOxve3ELsSsRYqjQF8xqgzIy5laJwxD6Fmxp6vokEcj1TurgrQ==
X-Received: by 2002:a5d:5846:0:b0:3a4:e231:8632 with SMTP id ffacd0b85a97d-3b495b94922mr1942693f8f.12.1751620108789;
        Fri, 04 Jul 2025 02:08:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:51a7:9db7:1d49:a8ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c919sm1957296f8f.92.2025.07.04.02.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 02:08:28 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 04 Jul 2025 11:08:24 +0200
Subject: [PATCH] pmdomain: ti: Select PM_GENERIC_DOMAINS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAeaZ2gC/x3MTQqAIBBA4avIrBNMFKWrRAvRqWbhDwoRiHdPW
 n6L9zo0rIQNNtah4kONcppYFwb+dulCTmEapJBaGKF4wNJKDDk6Slx6bZVROnhnYSal4knvv9u
 PMT5GgIe7XgAAAA==
To: vigneshr@ti.com, nm@ti.com, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vishalm@ti.com, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Select PM_GENERIC_DOMAINS instead of depending on it to ensure
it is always enabled when TI_SCI_PM_DOMAINS is selected. This
simplifies the configuration process and prevents build errors
if PM_GENERIC_DOMAINS is not explicitly enabled.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pmdomain/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
index 67c608bf7ed0..35a4c73da17a 100644
--- a/drivers/pmdomain/ti/Kconfig
+++ b/drivers/pmdomain/ti/Kconfig
@@ -10,7 +10,7 @@ if SOC_TI
 config TI_SCI_PM_DOMAINS
 	tristate "TI SCI PM Domains Driver"
 	depends on TI_SCI_PROTOCOL
-	depends on PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS
 	help
 	  Generic power domain implementation for TI device implementing
 	  the TI SCI protocol.

---
base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
change-id: 20250704-depspmdomain-2c584745dca8

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


