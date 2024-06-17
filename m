Return-Path: <linux-pm+bounces-9397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1890BF3B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F2A283FD5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F051991B0;
	Mon, 17 Jun 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqINfWZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37C188CCB;
	Mon, 17 Jun 2024 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664697; cv=none; b=IVl6C1h/KgWE8rt//jIxL5mlkMfnkvbNKBNqtL8GdgFf4C2MaQbj11Keaa6nyn6Zt/VhMvfCYu1t0WXeZz9YTWxgi4+g67JhRyKuNSNsp38TuTOUrguZkoY652apxykgzVO/oB1OUhD5zQFyCqSslJgVzDTtlfkCNjbYrAHcw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664697; c=relaxed/simple;
	bh=v5A1wrN/OwUoHnnUivPzvwP2coj7PgHLiOu1eHptmis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mc+mFs4yVjPrNeHTtiGGqXlHTaqDEuCwnwIDP5bGgTDB3EhhcXIQQ6tZFTI0vy5Hyc4c4TOsv+nf9BKjYb4rtTWGKGfZeor2hl53UDtinvZQSuG3SYn43/jroOwYCGmhr4DtVbx50nYdT1sNrPKu2oiYhFV97cUUeu/qauqzsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqINfWZA; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9a5be6668so2531613eaf.1;
        Mon, 17 Jun 2024 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718664695; x=1719269495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOCRwnrSRpia5cthXeBvh3mxj7l6TXY79siPnfMre0E=;
        b=fqINfWZA/zofsi1yAX+iHPwGYodHT10HWMRc9vz8BSQR8OJzFzmKdHpoFF4FvyuFwI
         pVFxKD1VfypAjg/sWvemhMEhPGodiboLSU3gd8WnZp2yJSC/78P7IdH4Yva1NYratAAf
         gRzzCuXwiFMhWq4AaddDPxQdPP6LrxLr24j4YfY3pvFI2SiN8X11ohyJX6+Bhk2kbUB2
         RY3kgH8R9+045tEKfwwkoYrglnKq1zAUJoC9Byby3l+7SSDC3AArAP8z1s52ybuzV8pX
         SL2oalqRygw/JR9h5HqcaYd08xP/iYHjNaV1SRGPbZi0EcbR4QvCVzPll8MAPpSOLJNR
         WfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664695; x=1719269495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOCRwnrSRpia5cthXeBvh3mxj7l6TXY79siPnfMre0E=;
        b=YgEZnskIUuk0UAl6LYLvkK8HeMHBFplRDhtblJpRkaQAu9H81E4nCIkQgJIHYWAuLc
         lEMDNhGnP2nwFDbHOo633IffDA/IfehzzajLjPY/yrsSUKl+/PbmkgmgRGFcFzG6+d1r
         HYFRPRdq8TSOsHti/VJiKkMTMvUXOw0E5ZlTlH06tnPelfJSmsVIopWHUBX0md4GSCoI
         iIqM2GVcppi9reX5Z9jJpO9IZNnA9mvNB86JYK/wKI3UBtneMYfcaWRFPKWbkRnKVSgD
         Tp+ggeHlKiFX2D30LE3RyPYJbQQFzy7o6wgQWXe+er3WQVhocwU5zvJyuQXYvHQaxn42
         SRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVucyNX2OJayEQucaBLV7a8j2loGlI1AdlTgowiDo/VPIN5Uo4CM1uxzLzomHImi3mJCvy8es/OSrT210n05lS1l9fSS0QpIIS2DPriSqI1RFevANwDwNVRt5veZm6RfYXyulI5xHQ=
X-Gm-Message-State: AOJu0YwJL3FRDruy+IuodKsZjk+RyTyTE0bO8cf+Xii6HvBAXJeFPIzF
	X+QDasNIx+g/OEFYrdaR3jRDTjmq0PfbNlRK/AQomsFTlMpvkTSi
X-Google-Smtp-Source: AGHT+IHGLkycX4xJ5JW5WejSq2hWxZskYG8gSZhmXCHER51ANX/Wv0SwwOVWWPB9tOOjB/01BlbIBQ==
X-Received: by 2002:a05:6358:9146:b0:19f:3d80:5896 with SMTP id e5c5f4694b2df-19fb4f5bbf0mr1369553655d.23.1718664695063;
        Mon, 17 Jun 2024 15:51:35 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16a58dsm7096536a12.29.2024.06.17.15.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:51:34 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v3 0/5] drm/msm/adreno: Introduce/rework device hw catalog
Date: Mon, 17 Jun 2024 15:51:10 -0700
Message-ID: <20240617225127.23476-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Split the single flat gpulist table into per-gen tables that exist in
their own per-gen files, and start moving more info into the device
table.  This at least gets all the big tables of register settings out
of the heart of the a6xx_gpu code.  Probably more could be moved, to
remove at least some of the per-gen if/else ladders, but this seemed
like a reasonably good start.

v2: Drop sentinel table entries
v3: Fix typo

Rob Clark (5):
  drm/msm/adreno: Split up giant device table
  drm/msm/adreno: Split catalog into separate files
  drm/msm/adreno: Move hwcg regs to a6xx hw catalog
  drm/msm/adreno: Move hwcg table into a6xx specific info
  drm/msm/adreno: Move CP_PROTECT settings to hw catalog

 drivers/gpu/drm/msm/Makefile               |    5 +
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   52 +
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |   81 ++
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   50 +
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  148 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 1239 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  880 +-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   11 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  624 +---------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   32 +-
 10 files changed, 1648 insertions(+), 1474 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

-- 
2.45.2


