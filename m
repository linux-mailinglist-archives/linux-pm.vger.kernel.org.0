Return-Path: <linux-pm+bounces-8087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221C8CD976
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E233DB21ADA
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066937143;
	Thu, 23 May 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex5zyySz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF642628D;
	Thu, 23 May 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486752; cv=none; b=TQdQLtNtGPo41vyHd6GDaF/4YE7Jh6Ny6kh1/Okh9lnRTuEonfBkZCVQDCQeTnXi7UpJOwuulKduP01RcrV0CfOk3Oh9EWeoCTpMjRSbeIPKAz0OfoEoDAcMT2uksVwTsZsg2faT3jNJYpPma2F9g6gzPtzZYmfRPstYZRd7JHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486752; c=relaxed/simple;
	bh=sJKyceLK2hp3R2DtYdyiGb4AR1HaM8zgJkN3aJUGyEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=diABjeGLe/KL4sHVWnoWEP9M3FyeVPLFjFgNnVoWfjnKA1mRs2dLVW4fYj1VgEdTeqsVJXeZ9SP+if16l8c5/AK9jbESCbVT/MDU9Mi5KLu8KBSr/6s4Drts62v3zlB7GTIR1+eklZM2OLGwOQjcWm+XKkiSf+exZ8wiRgcuUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex5zyySz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bf5ba9b1ceso63218a91.0;
        Thu, 23 May 2024 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486750; x=1717091550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6bfu+bhhkfLjZgMfcumMPy+A+KJDQ31ZI+nlFrepqo=;
        b=Ex5zyySzfOmkVC1CDlb/mbSUCaLiLpdkgYsNz22xUTp/b/ZZfAGGKlORP3j6ZYN/6u
         PNUOgs0HgWiL95i/ov8fRzIiCagu5YVzRyzyZO/DbfUf9KqxEYtIa//s8vsDfjtc+zcE
         LIIpcWdrxqZkyX2tkvVAmLAy/chlRXXpntJVicKszXH1doUQZGC664QTyeczU+B3p0+r
         V2D35sxLvfQZG3+i6jBmJxdiOUVqs0uBd+IDCS2CY7U+Jvzaha7+egUGPRopstq9bMnG
         phG26aSnntjO27H2FFZoy2yG/0cZpZq/004rSwuJEMAsGH7bO67+TPyLfrdaArbsWr/y
         LJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486750; x=1717091550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6bfu+bhhkfLjZgMfcumMPy+A+KJDQ31ZI+nlFrepqo=;
        b=X/67ALb4CUcXSWkEgtMyuu29QOWsBxcz3N+cxo2F/dL5rwDrt+7hLx1e0YpS3eGXyP
         t0JkfyT6s6uFfnrvKUlQeg5986WxbgjNgW9k49OZ2WnYe1h2a63wLr3+wVNLHhxYeVi+
         cVr/rRpNe5qi9xAJgbAS4wz+F/m5h/6bs1Pg9Gp4pJv0u6YR5Os5mo4rDtFMmDVGRdqg
         mV9PumBuO7n7pq0BGqcSqv8LZBHmHSrBiUHLh5r30gCnPIQD4eQBuRF7R9lU70Z2Qrya
         BPv7k3OjEz0wu4bOdudXODUuTiaNmL9HNSlfEgvT2VtFycoraariReDYDh+l54zR5U8T
         kvnA==
X-Forwarded-Encrypted: i=1; AJvYcCXKc/VJt5GwafH1m5AwnAaVywjE9aisJQih3tbXran9YdsOMI2qnWuAGt9Zy0mysVb86KezTxtf/B4p12qpDb9FeaFFWzWoluAdgGjsp/PwVieHDu4mVCiejBaw7IagaZHlIlDLPs4=
X-Gm-Message-State: AOJu0YxA9a84oFaMBycIMrYrdJmEDomqpaFBDEvT5wYdTOfaSZGAdKw1
	cPwBeSFWc4q+hOZjzG+gHbU8V9OzjGCFIE2PLRrAy3ORQ18vRDPVuwtXYw==
X-Google-Smtp-Source: AGHT+IHvfjzUer2CoBJAM367aQfyuIiKPe9JX5y3lgO0SB5+ywdrrZbwTN4dupnWt0YKqTjVHdV00w==
X-Received: by 2002:a17:90a:1788:b0:2ae:6e16:da91 with SMTP id 98e67ed59e1d1-2bd9f461d5fmr5924366a91.29.1716486749999;
        Thu, 23 May 2024 10:52:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdda058d7asm1825463a91.55.2024.05.23.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:52:29 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v4 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Thu, 23 May 2024 10:52:20 -0700
Message-ID: <20240523175227.117984-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.1
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

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++
 drivers/gpu/drm/msm/msm_gpu.c           | 22 +++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++
 drivers/gpu/drm/msm/msm_iommu.c         | 18 +++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  5 ++-
 drivers/iommu/io-pgtable-arm.c          | 51 ++++++++++++++++++++-----
 include/linux/io-pgtable.h              |  4 ++
 7 files changed, 108 insertions(+), 10 deletions(-)

-- 
2.45.1


