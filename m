Return-Path: <linux-pm+bounces-33074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1AB353E7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BC67AEE52
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283DD2F39C8;
	Tue, 26 Aug 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0RscgFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495FA927;
	Tue, 26 Aug 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188704; cv=none; b=NlUok2QS1TOSNMDPeiWFtKEOmnzFWg6n0ksRH/0zE425axv2VnoHdPOL9bUrojPv4sjP274KjKUwcCpsHX154L39RO0KPHNgs1MTiv0y5Z94owRjnKk8S3Veee3ma6/8iIg7G5fRaeLl49oAJmikvZTecZzoXjRiUuNpe6hYE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188704; c=relaxed/simple;
	bh=1aCqvyxHXgKW7qO4Zfe4WeVha9L7I6MGsMQVUql9V4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpVthwUxkoivUTtiOAZUvNmfldteaui/PQ9+KIUa/lj9s/6wOjF4mh1KoflLPDR/snd/GMSQhnEz29SHExOx7qqjdJuaY0G6LMNtA5xuHMqusu1kTvGNh2qLQPsylMTpoSU9yAKoY+1QPxthtzS3p+zpDtpXVIh0Vs88jrfhxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0RscgFF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afe775db944so300070766b.1;
        Mon, 25 Aug 2025 23:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756188701; x=1756793501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pLdsbTRNDKb2ip98JxwpNT7eNlirBu5H5bq/fBfXEE=;
        b=l0RscgFFwHPsLOGLGKHTRhWNcCW1l2dUwVwHsUrxxy2Dl3uSz9A+6iPWSJ9HATYab1
         4AynUgLxAFTONP5vxfHO3sOz09hokbqeUxO9tbAzB/uMt4lU9KENlI3hxrOOJ/1+PoPR
         re9D9GDzMC+zdRrbD885S5wAW/AM2es4xQ3Wy5zR+Y25+zNXxbrDh6M5aCtE87iqNXG8
         YtVW5Fh7ocE8Q7R/h0OgnWdwVtR+f+tf6fdz69CNWSnq6UO+u6m0NVyRJcZwzGJRmmIR
         1rWu5Ir1+FD+U6jFFSdvj/pARNuIu5/Otbw1HkxNpAmf7GMoMiDGwz8a6eJEFs+KH313
         nWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188701; x=1756793501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pLdsbTRNDKb2ip98JxwpNT7eNlirBu5H5bq/fBfXEE=;
        b=OBrtCBVsE0aHOp8Zzv9b4LLPN3PvVX9yH1AH6OLYrbaRvNxTDk2au/zw5uhEy0fzgk
         eEAXhlIjiLreJbKNPSL29hYEmFRNqVox+USIpaH+Z28aMMXCosvZeTV4YtbUXXjiu+jv
         rpWM+xWUh6xM9YsN8Rlx5LplNqeS0NR8xhWfoZbEhoOktScxfjGocNmoyBxaaC+vOS9K
         EU1C9LXt33N5NOlfiA45Lm/873Jw6DZjYyNC32kXx7obzynG8w+KV7Vs27omPSgSEcgK
         bfmh1hFzL5+UlEZpTeUFzqqPP8ApH4vcG4LaDTJm/SNBSq3Buiey+hMCRNFH0YMPI+nE
         Xi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPMkw0aJQEovvq4XcBZ6rmswB1mP5jfK1g23xSP3FyBGZHLH9dXo4lMWx8vtRXo7SX9V9St25iObo=@vger.kernel.org, AJvYcCVAeZJGbmYXgbzhY5EZtN+RFJnUMV/U+O7GoVjaWU9trC8nr4Glte3FJ1DpXdXemGU5I07v+lBQYgo=@vger.kernel.org, AJvYcCVR1n2kebpFE5gQCfAF6KHHw0V0r6xZS3TKINPUsSPoxiNAfQDFCfiNhL7ocHmkE0oM2MPk0yAAYDl35bOG@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpDSgFe8kW2uVXK/j12igFY1RKeXMBFYkJm9WEotrBjdszogB
	DkApxS5/e7fs+TQzPV5oHxc6AzIhVQR81mwWx0eK0tNT4oz7ZjF0MXQw
X-Gm-Gg: ASbGncv3q4qNrSh5ZEArRp1NO8LWdShdxcXNCUF5V0EVzgIGv/1hBKsbkXbXcXZMgaY
	YXpvsEPdKtBeoxkJvmTOoxOQ5kZ8pDkfsAufsEtK5qG2xeMBYm3vDc8Sa89cv2tafercPyluf9F
	TGO6UajB+6tDqf9GJqwyHPEggQIOF0QralSeVVIYPAkN9ToJjwZJM6vmEwbshWz6ZfPhjA5krUs
	mBUI+RQMCH65uobYm04bH/I2wf+HyOBdSz1/5qZDlIlcYPZXooRerfzRLR5idjYBjp91l+2iqfD
	S95e+Q6RUqsHQcfuN25pFie99HM2nRoXW1j5o5JXE64WxXhnB90psXoeDO+yvAAFgIGrVkkv2Lo
	z0Jo8fzOQz04DmcYcqtxu/lHd
X-Google-Smtp-Source: AGHT+IHZjVf54HzcE/vYHUtS92B81GGwSmo2eGgcV55Q95KAAOBOMeNSQj3YrHPwYW+ycYRkbhyHlw==
X-Received: by 2002:a17:907:2d0f:b0:afc:d246:8425 with SMTP id a640c23a62f3a-afeafec9176mr37833866b.19.1756188700632;
        Mon, 25 Aug 2025 23:11:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492da4b9sm711067966b.63.2025.08.25.23.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:11:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/4] clk: tegra: add DFLL support for Tegra114
Date: Tue, 26 Aug 2025 09:11:13 +0300
Message-ID: <20250826061117.63643-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DFLL is a dedicated clock source for the Fast CPU. The DFLL is based on
a ring oscillator and translates voltage changes into frequency
compensation changes needed to prevent the CPU from failing and is
essential for correct CPU frequency scaling.

---
Changes in v2:
- dropped 'drivers:' from commit title
- aligned naming to Tegra114

Changes in v3:
- add DFLL support for Tegra 114 was split into dt header addition,
  DFLL reset configuration and CVB tables implementation.
- added cleaner commit message to dt header commit
- added T210_ prefixes to Tegra210 CVB table macros
---

Svyatoslav Ryhel (4):
  dt-bindings: reset: add Tegra114 car header
  clk: tegra: add DFLL DVCO reset control for Tegra114
  clk: tegra: dfll: add CVB tables for Tegra114
  ARM: tegra: Add DFLL clock support for Tegra114

 arch/arm/boot/dts/nvidia/tegra114.dtsi     |  33 +++++
 drivers/clk/tegra/Kconfig                  |   2 +-
 drivers/clk/tegra/clk-tegra114.c           |  30 +++-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 158 +++++++++++++++++----
 drivers/clk/tegra/clk.h                    |   2 -
 include/dt-bindings/reset/tegra114-car.h   |  13 ++
 6 files changed, 204 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/reset/tegra114-car.h

-- 
2.48.1


