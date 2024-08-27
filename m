Return-Path: <linux-pm+bounces-12996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360999616B7
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 20:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A251C23251
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259071D4142;
	Tue, 27 Aug 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfOjMmCY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74781D2F59;
	Tue, 27 Aug 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782644; cv=none; b=q7um/In3eulRbKrKFsoXJwhF6oj5jiKdB227Tv1bmmQmjUf993awqU3RhiH3+ZSSdvvPaBQINGIKw1iQjaB79ZxUpAW1RAPQzrVp/Q2BZe0vYhqd6jEwKpXlaLNh2VQILti7PQ69TzEMagTacxdhXf27oZAnhPyU1hAyrCCn2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782644; c=relaxed/simple;
	bh=W0MHtkjrqMehqszFX9YeJsQcicvaA0cF0zodtjl7Pjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOs19fMTyhyxSi/MIUedh8AvIbnJWwTGRybxt48B0CrHQu/ULBS2JE+FBeJqY2BK36P7tPGDx1bF4DaLgb7tQdo0e3KhVY25F80pWmtPNw9JPAqIlrY46ya6sx2cEKL+f7QOge6oNqDJErAwzJbDZ4ZoMNJQMBzKe2aUkFbGoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfOjMmCY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c9a67eaeso4275202a91.2;
        Tue, 27 Aug 2024 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782642; x=1725387442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qqm4VTqFnRP1C9/26fHK+dHKryok08NkyH9r7+ILNc=;
        b=cfOjMmCY4cxNQXJGRWVsxsWOYpIRNT8VEs9Y2I1PbmLbrrdSJ8YVxgrZ3wtPtjYd+r
         5c5cdYwuTSQ8S+sPmj9x1cxqRsKZXPAcQ+0GavCwBBSEu/oc0AC9WfYteoh41LHiea/5
         88yS1vmtCGEiGDevoYegnT7qQ19KHU1cyMUFvvVbaW0b7rwscEVBMuuCLO1T7xFKxPre
         gmZ+R3/22kYvee4TCNuGlfx2CctRbB3G1MjMvSc0g3rOM/cdufK+lUAwYyGMavd6YDWA
         +eo7H7VEgtd1yJhiPf7X1uwyT58etVAs1ZOpE594Qy1ivpRHAmQWdJS11LrXt0xNfECm
         UwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782642; x=1725387442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Qqm4VTqFnRP1C9/26fHK+dHKryok08NkyH9r7+ILNc=;
        b=a47RL+1kDEJwg7A+jBH1iev8XGmIP2SC2BQcgMlqiNmwZNQZN6S0Z1jTSsWFPmNj8a
         OR7TekNxQakg9047N9xTtJDe9LVQWrcolvxZmZZjve7owrZJXq8CbnsbV4lFU732Enqj
         aOhGtU1plEj1Ep+5rUI53fKHTMOXMNXzI0OILTaFVKfHdxZD94TQAibrrFLe5l42DAR0
         SE9lxpK49ZFIAz+grIDXgfNE4J5lf8qBBF+dh3EythLZ1BtuiVvzMsqk2uhXDGTW4kmb
         BPMaD4Q8x04/fxbScUAU26tF7MQGwIQEmsUMxkyGeENa+JFE1nDcU6IYfXN3dd6bTE8N
         YPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+4C1b4XjR/sN3MNMVEZZTJ2D32BZh0TTPt8CKR+T1oWJqCGKvwbymAnj/1zmpOTI9upFCvKb7BWczyP64@vger.kernel.org, AJvYcCWH36MzwkQTddmMKp3wztC9/1E7VMqrCBAezzd6fSpEwlbSf4bjPcnQniLkOtHDcqfMNysTqM2UOd0=@vger.kernel.org, AJvYcCXBSbrrUd0xyY31dCw+oXE6TWPfJF4akmcn2ucbRVApui2nFDR/9p6yhV8I4kFE+xWywlia7fOylY4kJmGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YynNXkUcjESvILUdZXask3rZ+OSJBsv04M/e/mnwxXWUSi7fWHa
	jTfZdeXdXTBicA4TvDKDR7MUdIyHjt+hz4ZIztBuEkIAJVzXO5wh
X-Google-Smtp-Source: AGHT+IH0n0TFg5/hRPO6Qh7jcBNG5pKNGVUs+INu5ONwGclHNTvAiowUqwIyW92ev15iZ2fiZpT+nw==
X-Received: by 2002:a17:90b:88d:b0:2c3:2557:3de8 with SMTP id 98e67ed59e1d1-2d646d24df4mr13634871a91.33.1724782641772;
        Tue, 27 Aug 2024 11:17:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a6123fsm12436271a91.33.2024.08.27.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:17:20 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v9 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue, 27 Aug 2024 11:17:08 -0700
Message-ID: <20240827181717.187245-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
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
v7: Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
v8: Pass pte pointer to callback so it can modify the actual pte
v9: Fix selftests_running case

Rob Clark (4):
  iommu/io-pgtable-arm: Make pgtable walker more generic
  iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
 drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
 drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
 drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
 drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
 drivers/iommu/io-pgtable-arm.c          | 149 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 160 insertions(+), 56 deletions(-)

-- 
2.46.0


