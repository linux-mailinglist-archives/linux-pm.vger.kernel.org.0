Return-Path: <linux-pm+bounces-18924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9A9EB712
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8C52831B6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE32153DC;
	Tue, 10 Dec 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYini5tk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD61A76AC;
	Tue, 10 Dec 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849506; cv=none; b=BjilVpQYJ9GWz2XPuMrGq2ObS7Rf9jwcn4ay07gFKxPijQmRGBgD7+Q9uo8UtM3ta2oVC2VAPw2mvZRtsxatMSqbIb4jfsMpSU9mG9CakwXO9/i1BgVkfaX758lfIk2oRczwClli6NmCfiDXJswf7+rE5bRKN1q0t7MJxDl8tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849506; c=relaxed/simple;
	bh=Mxw/pGwRlstlF+sMsnwXXRjVPqmnOa+upzVXrXLGTd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ng53blHNkMe5wX5GUgknG3nmm+E19UOBAPwU6CcjKBGikfsFVPZeBjpzQSDjjC9s3C+g2t+N9WThgbACzsLHOLmT0+MNS4Er1hH3/QUw1G5OoAEpwrdycUvKlFgV810ikEt/geVn8vRSqNqu5057ryNcfqrku47ZgyvVn+5uKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYini5tk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21636268e43so35163455ad.2;
        Tue, 10 Dec 2024 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849505; x=1734454305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuzEEwZKQf9j9mqhaN0lST/eQY9CbMt5tK8I46FKdZM=;
        b=XYini5tkdpS1NzH6m0i0TTJ6MkThJ1d+n9qrQNzp7/1DvLw24m1iFxqeiWhVymJi5B
         3oQY5WNEcP+zPdNX+bRqqBkHtIDpj9OBt7LZ67tlWZpowCdC9QqpTdNvfUX4r5NxN/A6
         BRCDKOXYiFeT/HJC8XUGe+VtjWKHWn27NVL8aM6nHbudtJAlsTOHRIQLbJDRkA9Ioomg
         +NGEimPDf2BRvJFHcYM5eRfV0RKZuhsYkbhZln0ikmZuO4MJY2xM+Ym20pteNtZauaPg
         xvWkVwdt9465CAS1cwVZHKkAFhJ84WPFwp1ixeBHbccdggLOFCMILuX6V94gzKe44N1w
         xMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849505; x=1734454305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuzEEwZKQf9j9mqhaN0lST/eQY9CbMt5tK8I46FKdZM=;
        b=bpvRMZMjtSxQqUJeMyuMZlaq0/2irSdVVNp9EOltpvO/IXPRyG+hTjUT3zVe7o2SR3
         yCgPKv8TDcbNi3iQ4ptAVYnjeEPK9j5SO2urCOjFTzzjHW2DMwdmbpoAyBx9IvuC5L6b
         oIu84la+o2yg8UXAcOOqxAdyqeybeQKN8aaIsKfO42CTqpgCjWNy+eZg2jmpNBYu7MBl
         0fnqzbkU9dT7bl9PzlI26d5WXoPReWrzKZ/HnugAfVR/EHv2KPTBIFelg5lD1Q/RMl3S
         PZy5HqSuPs6e1nd5ihY3D8BtyVVQ7sgR5LvsHu2vkDRssiiS7um0q9zHS3yfEFmJPra4
         wNSg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Gq+as6KUo51q0HvTxz3Ky7hhtmQiB40LGwHm3MyG0Is+k9f7hSgRoANh37E4kXqX4Yn/B9M7czg=@vger.kernel.org, AJvYcCWIsc6PWJ9iQp4GXeeHctnxOboE16XnyinQJ6Z4Lkx3W8xWh9YSdvGIVDTzbfsbhzxgmhi2goeDKST0bNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qRa/JeTtCN1I0jGCgNLcQcie0eC9HbFMeDGov8uerGuDo8OL
	MXzZgbp6vlUJKv5DBv0GqTrw4i8f/Nh1MIk4JY2lh9xVg+K+8/c8
X-Gm-Gg: ASbGncv0b06jAnfgvW5ssBG6LodDDy2C20u4xJoZ6f0rv0yGe9YxXOGDwK4o76IlWsG
	VS/FRzSdz83o4i91nySSOBGOAcd9Q+BIcJA/cxunthRbEgwb1ekJ+ATfGX5oPqe80DmkIVZBibe
	9ZWraGCBco4rsm0IDcp0uZAamPsBGKwvIWXEw/DvnKWIBPmYNsOUXtraBxOi2Y4Xz1tocxecJ61
	UodmxDRimbgGXS8UsDH0/1iem7ATi88Mcjp1fnsHgjSyX6SzWvQzkLYod+/L4+YMPGKJ4G6EKkK
	D85s1BzOx7MzdI0c7XITqVJlgAth
X-Google-Smtp-Source: AGHT+IHq5GJLA69hWJIqMBI3xX9I2B1vs+oiOQMLHk1Gt8OrfhdtpCShimUSU+G1kzy0p/Cgwakamg==
X-Received: by 2002:a17:902:e750:b0:216:3c36:69a7 with SMTP id d9443c01a7336-2166a0987ddmr69103725ad.45.1733849504588;
        Tue, 10 Dec 2024 08:51:44 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216363a3176sm51054905ad.246.2024.12.10.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:51:44 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v11 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Tue, 10 Dec 2024 08:51:18 -0800
Message-ID: <20241210165127.600817-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
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
v11: Adjust logic in 3/4 [smostafa@]

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
 drivers/iommu/io-pgtable-arm.c          | 157 +++++++++++++++---------
 include/linux/io-pgtable.h              |  15 +++
 7 files changed, 167 insertions(+), 57 deletions(-)

-- 
2.47.1


