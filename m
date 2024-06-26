Return-Path: <linux-pm+bounces-10077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97E919955
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 22:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A11C22F9D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4711946CF;
	Wed, 26 Jun 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgwhsgRO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8E183083;
	Wed, 26 Jun 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434443; cv=none; b=pQ36b+qLhtBTBANJV3HeiVZMAQjG8YRvtmgSjf1N2D0oEA57F6wbGtopmcwfSvYaku8/syVbqqzhioMRG9Smoo56BdOj+0s1VqmeHN5HhM3W+wv5SVI2PrBtq5EQV5+69FQZxh28aRilRyU2jgzPQ4gWeYrzlEVGsYgEO0QghHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434443; c=relaxed/simple;
	bh=22Ko6EUlCppzoVb0x55QzmkAFqFzXxmLUukogzwq/2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDcpyBo3d9Nle6KhuOtGrOKaCEA8UzqgPapM8nBx9pVESyAIvJ//1TQ9suHTqQ9TXFXyUAFH7EpjBvw6LmG59ZlW6Zoki5aZqZUJ1RrRcQm0drrO1NhYIpV1VbgTpnsK838Yr/JGXlSsBExupcQYF3XS006VnCUcv1yyGtOrnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgwhsgRO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so5346301a12.1;
        Wed, 26 Jun 2024 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434440; x=1720039240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbOHayuQJNiEIov1gYrLNhraOo1uckdkGZa6Izlq/48=;
        b=JgwhsgROI2wgcn4map5FuwsX7SMvhLPl6MmINKo+JiQ/DpAhCUYpKZ8aNzVCnDe3zT
         79DBr1zEt8KxTYfxSH+jdSQprmiV5FdhsO3TQ8sQGh8w3uu2Up2HEZXX3+iDAlDbYiZr
         RvXaoIFGMqRBXQLgNwS695Jt/nwoJ2mwaq3OT9hm3v95QGfkhii4/Pv5xUh/Ls1AvFqh
         TXWROEIWb/I7FB22NMg8/5PNwAz+FoDffPXZDX0gOZ9DQ2aLM2uT/OV1hglrU1S3zBj6
         Hz9jGbEyme9dtjyEOcCjNGniUlyH9PFOoM/MnD6Gyvrh5bATAO1Od/V7n+t2WmEdbKhh
         0Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434440; x=1720039240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbOHayuQJNiEIov1gYrLNhraOo1uckdkGZa6Izlq/48=;
        b=nJJvpuSPIWEqpeBR729o14Q3MjJ2vP1KEo2Rl0EYdvg8v5I9KFQ25re+Ch8XryiuPz
         e5VddCWhAlLK81BeqtTG1+Hk/L0Pn9UOE/501vVHIMW6xRJQPDwOhule1t4icA8Mp0U3
         rlzWREqy4OdA6a6ocVfiuj8LGxn3x1Y12MgmDiKwucQCl0Wrj6pbMrzpaB81hIBKl3M9
         MG332IvkEa//4fQn7rK/LcZ4+X2YVAax9TP9E3vyBp9+qXbM22qOOXFZm+KsZUElLjTT
         Hjz40Kd93YVxJ/J7vnbx3WIT7fz7OiI+HTPcYAhI1NSv3DmurG00Oq6U6t4cjHNgK5vQ
         /nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzjkCh+Ax+be+h3HRXZ9aT6oPQO2L7sLCLHBBEX2cLI2IV7dWL17jhesMAZ6FJ4Nr0AoKplOvi9yC9Qiy+9VnY5t6MgEIXLv3tuPCmoNPGycq5wQO8aA0GTIO5T6LLwMkdGD4LGEs=
X-Gm-Message-State: AOJu0YxKC+9OltK/8jDHATh1v7qBfVo+nQr61ZC9diVUD26PyzPGxYY6
	xoRm/5I79arnvWRK7F04FH0V+p2qHMj2XMrAzmyyT7SJshzS1TH9o9fEog==
X-Google-Smtp-Source: AGHT+IF3IekAjZVaykmQWQEV/CWbBuXRqd14xzAhjMZ8QLFh0Na24yFedXvOlLwgPR38grbkYKuKzQ==
X-Received: by 2002:a05:6a20:6387:b0:1bd:1e0f:efa3 with SMTP id adf61e73a8af0-1bd1e0ff0dbmr5381451637.4.1719434439963;
        Wed, 26 Jun 2024 13:40:39 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb323636sm103241125ad.102.2024.06.26.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:40:39 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v5 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 26 Jun 2024 13:40:25 -0700
Message-ID: <20240626204033.255813-1-robdclark@gmail.com>
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

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++
 drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++
 drivers/gpu/drm/msm/msm_iommu.c         | 25 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
 drivers/iommu/io-pgtable-arm.c          | 34 ++++++++++++++++++-------
 include/linux/io-pgtable.h              | 16 ++++++++++++
 7 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.45.2


