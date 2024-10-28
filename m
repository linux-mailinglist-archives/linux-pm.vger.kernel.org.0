Return-Path: <linux-pm+bounces-16628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FD9B3CD3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 22:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A912807AC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECA1E0E09;
	Mon, 28 Oct 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/rIA4x2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF8188904;
	Mon, 28 Oct 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151324; cv=none; b=P2aiYCNp/4bNjbYVfzlZ1OFd+uLUSCOSRl6qwCJSF5paFR8ePjpdJe8ouEYuIR93WPhNoPIeveI79DqYUZj3uNY/HRgFne5x7UPL1U1e197b63OzcVT/p7l5YooVfLOqaIqKsel6iKqWmVednoq4CZ+ISCxTjXy3x2E8YFRrx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151324; c=relaxed/simple;
	bh=86+cVO9x+rqe0mkARdlhmy599lZTkD1tVtwmH1rilNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVMMOcFtNYkQU9u5JslF5MmkOpn19+KMJMc5DlMQdNow8jf4XEmWSTDmPE+3CZQee2BJNcadzWZ8JVX16Tbl3MeZU9CmYHdIfbq4YNfCNvrW004ES8dgbDa5+9CQnzbcbS1C+0Q3IyHBYRQ411U89+qtIKixX+5szkShhJQCF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/rIA4x2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c805a0753so46285065ad.0;
        Mon, 28 Oct 2024 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151322; x=1730756122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/WuSIt+DjzGI2XfAN06ei9IlKFvKYq+fLWWtLmBqEs=;
        b=f/rIA4x20Z2QwYGXSnOcPrzfErMk1/bPmLkQZ2K0UL8JBK+/uwp2YtHEaYUn7AOIlD
         SyFb7vyS3x0liBlTSLXu882k97AHxCWdCpUr7yLEJ6LsMcjHUt9VEzqwFa9O0vtJDn5X
         6eUeFVL18jMhL/ILvsv2Xu2AJ2oJA04e/dsToO1kZ+zFTYPtL8nQejfT7jiOvAmIeIrG
         3GCcjzquyS1xUCMZqL/Sh/9z9zoG57EpT672RWj2dyKI6R74I77EjS5MHnpNpa7N+m/C
         P7m65DnisqNb02dnvGhuzJKKOLxAN+jOzvJp8G/5xcKuwlzVsZvSQY9uGdmWIgIXso5l
         ZYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151322; x=1730756122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/WuSIt+DjzGI2XfAN06ei9IlKFvKYq+fLWWtLmBqEs=;
        b=sbO72fXIBuXJhF1t/C83D/7fPplzHZHMk0HOrUZXSJNwjn7afoZqMkpIO9IRMcuJe7
         OEg/nKfaOoX3sAfzYp6Dv8Y8ux+gaAewWxg72SkRjLr8a5fgCdQ35HdaSTtJRKLSZQmy
         t6/b4pLbDJkhRdKOv+fcsYhRVg3A8xKfX4NZZpa8D1lYgBMjpEGM63hq8Ej2WBEMY8au
         bKqWpfHi1rhEqKzk4O0kBiDbZS614GBeJapvpAGS2evPj18vqBtW+R9d9olXvmsWTx86
         c7nyX9zPadXjDVpk0AOX30f5RbcaeUJIkGHFhb7e1IBH4m4xslYp3aXVORSPuelYrEWz
         vm1A==
X-Forwarded-Encrypted: i=1; AJvYcCVukw7wajvWpEVygT5SeAbWOw+lTiCVlt+TtSxxwpjnageAjwt+cKWKT2pwCQPwrrNTA3B/4W+MgzQ=@vger.kernel.org, AJvYcCWqfceZiRwPkJAiPGPHePv9boA6Jv0UysHY0nmLPTKX5Posja/jP9Is+1wvTovORScyQ+L759lvgun8pZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7M2rV9SLQYBn9OHbPsgROiIOZ83Kkeo0qbzOspKC/PfRV+t6H
	8fLyJ1JX7MLOFhh3F7jiDg4tvwiLoeQpqPWWmWDicZnnaulw8btQ
X-Google-Smtp-Source: AGHT+IHpXaUaQZbGQlSlLzr86C3aCU0KQKQ4WqN1NM7MJCznKl4kJ0inRJj992VpciPWjE7vWWI19Q==
X-Received: by 2002:a17:903:2445:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-210c6c0610amr146342205ad.30.1730151321914;
        Mon, 28 Oct 2024 14:35:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d3dcsm55171655ad.88.2024.10.28.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:35:21 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v10 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Mon, 28 Oct 2024 14:31:36 -0700
Message-ID: <20241028213146.238941-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.0
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

v2:  Fix an armv7/32b build error in the last patch
v3:  Incorperate Will Deacon's suggestion to make the interface
     callback based.
v4:  Actually wire up the callback
v5:  Drop the callback approach
v6:  Make walk-data struct pgtable specific and rename
     io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
v8:  Pass pte pointer to callback so it can modify the actual pte
v9:  Fix selftests_running case
v10: Call visit cb for all nodes traversed, leave the decision about
     whether to care about non-leaf nodes to the callback

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
 drivers/iommu/io-pgtable-arm.c          | 156 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 166 insertions(+), 57 deletions(-)

-- 
2.47.0


