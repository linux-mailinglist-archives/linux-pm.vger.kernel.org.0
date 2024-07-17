Return-Path: <linux-pm+bounces-11209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB6934097
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A27B21D5B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975B181D1F;
	Wed, 17 Jul 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtuBVVPt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93B181CEF;
	Wed, 17 Jul 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234203; cv=none; b=bL+dV7bU2Mvv00WraJws2qA7bWlYGRcApAa7YiC1UgE6Gc3OsHlB6LagXrdMJZbzVGnszV4tHAKysxArZR40fa7FtOhQ6hgQvfJkPPxz23oWURXIndgU9y32JprbkTBiJOmeZ/hr/F1b3wqj8PJdYkOYUA38xCGm+62V7J/wuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234203; c=relaxed/simple;
	bh=pevFJEVWM2LxwHZaGOh4hSpXKwvZeu6orjWuJWggIok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiaHWNBlOuOFcjGlNynKQZ9qwdW21EY6aRwVt5KQ7ym5fpRQ5v2Q19waVZFcReMltZkx0m1JWftp2M9L/CZZsv8k1kN7vRuAqu+3X4NAkEHRNI/oH7efeHPF2viTVxK8yOMMwHNdUFSzJoAXVRPWL97J4oiewAtK/NLbyLcqMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtuBVVPt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so3410725ad.2;
        Wed, 17 Jul 2024 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234201; x=1721839001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TKuZ+LLWKFD2SRhsXU6njcd+7Nl5m44Gcrf0C6YsTI=;
        b=LtuBVVPt87ufgASL5xEb9CUsXdTezZTn7XM+BZcabQdt1LD0LKLVwqb/NmWKsqOA5V
         fP26P2Ca6qtnsANbaATyU03zMiTGkXYujVqEbIFxVDMlltY9x8Q/uoD5m/bZgm+roe9c
         kw1xnONr+vr+O1y+Sk29fc8nW614bYCOVa8GEpqBT0MlM+99SZmgPiqVhScIsUx3GKB9
         2BS8vhhD2SGa1K87Ls28Rm3nL58SmdwADWf8rRDanFknvO0CzL51adMlnqBQ8EapcIr7
         ut6UrlP77uc/gmFF+hjQ+77L0NNXs6hgLcKmGYlWMktCxihcJ2UtaJTF6bOPvbDkVzeu
         uC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234201; x=1721839001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TKuZ+LLWKFD2SRhsXU6njcd+7Nl5m44Gcrf0C6YsTI=;
        b=eVgzMjHBNCWUkcFwVVmTCAUN3gZdd22BIQb3WM9f8PTRMnScZ3CrjbbxX5uVbz2LIP
         e34tcuO8B00KdncqlyTzV6UyEH7Pe6O89Q+WcdndoZoVFuXUN+VFlsX2HlM4hAy+4FcK
         T/KqlUrud8cS3W6S5cRVHLFfsqwepPlljhqEnlWt+0gFr/86Sg8jBI9NciSpy6IwSwj5
         7RFrxBpf0h++3oAAE4iwIPS4TC/gK/tbai5aPn8EnEwGz6B8vTOWUAVioIgnRtFUc7yd
         V6C/8Q7fwcu/npxi8CqLHTv4FVrHLnH4Re8GIHXFvArjEA2ebfYKyowleouwXD7zjnYm
         xWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3sMMfKi2heqI+MAlY15MhfyCbEVzu8ZfRIqtf4n7BMPHhRdNQvu/jossSapgCO9DdIKHZcKiFfF9H0VwAeap4fsx5MEoA9Hs+vQNmDvgwCPEt7NjCyDqQRQbCN0xJKbwVLnrZtxg=
X-Gm-Message-State: AOJu0Ywloo59z+KLHhdJCqu61gwLzWa8l0y1caofB5SW+bPt+TjQtCxt
	LEuxEeuWID+6U2H+WvREVNJDZETW7HER9Ma78oyaNnyZ92DKehKX
X-Google-Smtp-Source: AGHT+IHEmLpSAb65L1ZZEAG7DejWL9QRUnhbkb1WfvjNwqFc5ST7wh4b/x5LadbiinMc04M/Mvyhlw==
X-Received: by 2002:a17:902:eccc:b0:1fb:6ea1:5e with SMTP id d9443c01a7336-1fc4e562501mr19451975ad.44.1721234201188;
        Wed, 17 Jul 2024 09:36:41 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27178sm77113815ad.134.2024.07.17.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:36:40 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v6 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 17 Jul 2024 09:36:20 -0700
Message-ID: <20240717163627.43423-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

This series extends io-pgtable-arm with a method to retrieve the page
table entries traversed in the process of address translation, and then
beefs up drm/msm gpu devcore dump to include this (and additional info)
in the devcore dump.

This is a respin of https://patchwork.freedesktop.org/series/94968/
(minus a patch that was already merged)

v2: Fix an armv7/32b build error in the last patch
v3: Incorperate Will Deacon's suggestion to make the interface
    callback based.
v4: Actually wire up the callback
v5: Drop the callback approach
v6: Make walk-data struct pgtable specific and rename
    io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++++
 drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++
 drivers/gpu/drm/msm/msm_iommu.c         | 22 +++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
 drivers/iommu/io-pgtable-arm.c          | 36 ++++++++++++++++++-------
 include/linux/io-pgtable.h              | 17 ++++++++++++
 7 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.45.2


