Return-Path: <linux-pm+bounces-9486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EF90D9A1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9420B1F22758
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B27F482;
	Tue, 18 Jun 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8amBQ+o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC641C89;
	Tue, 18 Jun 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728988; cv=none; b=ikFekrz/7u1+9wqUQ5QHob8856p5C1R8nswE2nPAc7y7iqYqJ9fz0jQH0FS/gTAHKjzJhAb9FcPqAmKxzsWJ4uS5dw5uepkSGR7ApRlBVok8Esstyu3Ot2EskWn2tQbEWwq+dCsbJzd8be6fRf+ctTpBFSQPCxYUh343TeA1nwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728988; c=relaxed/simple;
	bh=2KSiTL/3+Ms+mEx0KqDAhGC/hZWe9pewoXNHF83uG9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeHBKsSaHO0VMZSkBahiRLAy0LJJEl/DQh5UXJxQPo5Z1eG0gnOgVvCNHYn2A4o/rbXPiowEnS0f4XozGLFzU/XP8iuzJRV8EXaVcTnA60xGI7Ea4eE4YGXkRQniYMPPJX+NHorl90VnQ0OSy3cau0Qw/QdhQ2D4uFhID++hzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8amBQ+o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70435f4c330so4695016b3a.1;
        Tue, 18 Jun 2024 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728986; x=1719333786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvXhSojD9nxkcyZeCeKyHAlvRSq1UhDBytHKg5xTnCM=;
        b=f8amBQ+o97tIhxLA5KF1+lwNCwXPvhckAAzNdyjL6MiIS6Zdm1yIhob6SHJe00/PJP
         W/2n2gNf7iAJ9b+4zuOWseGDvcw0XiDB5H62weIQfIsXgvY0FFTFzFoyottIs67MBD/A
         fpm0VbWMcPi/yygWEwasfrZarznhM+b3QAxK4BMisHtt2NZYmzxjDvDA+oE96o1I/r2z
         2gcPQrvKeshlp+ngDOmQmFS/6n5zDufnKMC2dBZg507O7vtXVgJkMGmpD6eZvlvoFZKj
         W26Yviz3NZk7PbqCUyreZPOT9dlRlhUB0+Vz6XuPY5k/HAadwf1e8ehJALqpe34GvgNe
         3vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728986; x=1719333786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvXhSojD9nxkcyZeCeKyHAlvRSq1UhDBytHKg5xTnCM=;
        b=jqqWnlr5sEsMLQkNPdCh1CUIv6FPvMU+8jXODcNuDw5aXUUtPoZFMskkCfRl+DYBHz
         MFWBxx2B5GNA3Xlj1S2w1Ol2c/fvtMa31F/HVHXUJ5WCmvpdrQ2kO2axP1jZnTO0hK8Y
         XMCkQEx3M8Difj68TWrY2hhfImrnWceLTliWrcmRmy9jnIjzprBbq3jhDNvW7uQAmhdO
         pwErU6VK1JBUIokfk4i8jTyruw+eU5OGwcPDiNYYV2XzxsFsWwi09f34JM0MktUAGFw6
         DJETFA9uuLO4u7MwLznRhkK8FULUljt2mHanOrV5KwmX7cSdVgeYbWzleK4Zm8rgoFNG
         cr+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmB/ASqVIKqu8q5MuORLVYuqSRXB73BkOIR67VURZbEGzCYbUrBEpPvu0STu/HppwNh1M7sRhdW3ylcj/aD1z7mARyR3rqf+AsKnl1sKTf25WRq037TCUBU2k+jwaOVjCdGeAPQLY=
X-Gm-Message-State: AOJu0YwKVT1txqYPM+WFUdwwg9UO92Qo6pQgDersIgbnw2zoGma4Vz6G
	6rZHd5gIOPG/lHRwzNM0P0PNpphk5+7FXUDi34Prxpp0JpHxTHwU
X-Google-Smtp-Source: AGHT+IFbMiwhc/wRKW0CBE3zZpglm8jK3Q2B1o7O/xsHqHyLxf+YslV9ODcnMWNxYAhfhPJtzS+xpg==
X-Received: by 2002:a05:6a20:3c92:b0:1bc:af91:55a2 with SMTP id adf61e73a8af0-1bcbb5b5e8cmr72098637.36.1718728986112;
        Tue, 18 Jun 2024 09:43:06 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9a0f736a0sm9417625ad.119.2024.06.18.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:43:05 -0700 (PDT)
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
Subject: [PATCH v4 0/5] drm/msm/adreno: Introduce/rework device hw catalog
Date: Tue, 18 Jun 2024 09:42:46 -0700
Message-ID: <20240618164303.66615-1-robdclark@gmail.com>
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
v4: More const, fix missing a702 protect regs

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
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 1240 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  880 +-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   11 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  624 +---------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   32 +-
 10 files changed, 1649 insertions(+), 1474 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

-- 
2.45.2


