Return-Path: <linux-pm+bounces-12581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC811958CFC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991CC285A5C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB21BD023;
	Tue, 20 Aug 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd8RsQLR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44818C92C;
	Tue, 20 Aug 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174227; cv=none; b=O5wMHPWnUdyfp67HPI+qR7i0btrGaDByLQnpoWGcSjF/neEVwrfaDUDF+K9WKBsIN+IVsNzOmDVUshtBg97xjakTtyUBuCZFA7JXogcb9Gh9AWLWngxDKLlExoN/s/J1wu1YQf7YyfLqmNHmrk2kTjBgUIL5KPWYfnEQVX6x5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174227; c=relaxed/simple;
	bh=K0bgmvxUNrz5vihGLhxf3Ou13m+eII+OugE43qEVdV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sua/LDxRsW+7jBMG5CnJmv+xn1oXRMDUv+JPoItKHx4TPbAAKNgnhVEx5Fz2cqGtj/kLdvE3+Kohy301H6rbJkg4cfsWogYtv+gBMiLlsdSkqnrmJabynUxdWle4eMmUTkGT3klljKYtBnK7GWDqatxc1wFBXdFcFSdoD6O66so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd8RsQLR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd830e0711so384727a12.0;
        Tue, 20 Aug 2024 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724174225; x=1724779025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dx99I4gVjE0nKHxOcEFDps9UKSShAk0pVoAeBRskDVw=;
        b=Gd8RsQLR1zy8qOnxsEwHtnuxYI2h7E3E+976iQHcUsCFFLpgGZvGlaYmOf5zjNXctB
         1eKEwDLhM0Mkoy4T0+Wc2cQkcEFfNz9Q6l1MH3kyryQ9febO6/j1OTVmbn2cx0/4m8Kd
         TfgSFcqCPdfxsaIKSCGB7BG2WrhKC7fDPVCJvmx0jLatiC5yvR+mfx4djDGQEgXIqHSQ
         7o/pILkJmf0PRMyE75WFj61eyvamsTKoihMIZUYGgKHBSkAwPQGOgVPp562qo5tg54QJ
         0+g3VCmPbTbUIukew9mXhnFCF4gVUJFYHcVc8A4RSDIYCm+7TzqZoHtQe9WngEWis1Vb
         uSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174225; x=1724779025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dx99I4gVjE0nKHxOcEFDps9UKSShAk0pVoAeBRskDVw=;
        b=bzDiQxZ6WGeRhOHLz9wD26uoxjvvI+RNP3LEeLJgqNKJ97Axslg0kw12XjKiu8YWLe
         Ty4UTooa4MYYnXXk2RUPmdlXd63vZ3/19SvaCKOscnn8AQel26Ei+isPd+g3eCnZe/MI
         WIJIytDO9RBm1384w3lZ0L2kmjd3WZuQt6xczc+hY5pL0dweA+Z23GLYeLqeR0+9+Vzi
         lmI3TrY07dVJSUNbEn/oWNSj8MBQbCRhnQvKvacj2W86Wqn5aEnzjm4ZBzfwUANDucQ8
         wyKYUq1xUa18n8MwaunXAvgCjbWKmjY7PqCg2qZvcIso/Bl/y407VV5PtRVH/onxZEAJ
         iSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4rvCCdaAVfmmR2bql+uhKRBsBH9hcN0w4lsL0i7Kr5tEJfgPSjQs3XLdEgIFseNLTXOtH3ZDNsHhrIV8=@vger.kernel.org, AJvYcCWGRKFkhkxK5Ggz7tirBodD8/MzJzubg7WOD+ymewdKER3Dg6BAx7PYOx1K2lnqTudcI5xZbN2KyPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmGEm4/1s5zqZhJfoIyEHYtFRqU/gyClTr5VEZsy2Th9Y22Ky
	s3q0QdityIHYgAV2VVH73X5PKGKZr+8J33w6odf5vrYAbFm/9B62
X-Google-Smtp-Source: AGHT+IFqPaVzJwjKdCz+zT/UW2wJpDdZc+xGRDH+xt/ijn6H6ZIBqZtSC9ajtEejlFBlcXFWdHaCwg==
X-Received: by 2002:a17:90a:ce08:b0:2ab:8324:1b47 with SMTP id 98e67ed59e1d1-2d47327c70bmr5465287a91.15.1724174224643;
        Tue, 20 Aug 2024 10:17:04 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:bd02:d0ce:e791:dc08:a375])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3171e01sm9721042a91.30.2024.08.20.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:17:04 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v7 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue, 20 Aug 2024 10:16:43 -0700
Message-ID: <20240820171652.145673-1-robdclark@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c          | 147 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 158 insertions(+), 56 deletions(-)

-- 
2.46.0


