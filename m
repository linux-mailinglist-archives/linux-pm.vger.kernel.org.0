Return-Path: <linux-pm+bounces-12896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC195F7C6
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A601F2329C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B019885D;
	Mon, 26 Aug 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZhQAN52"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733D18BC02;
	Mon, 26 Aug 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692556; cv=none; b=SlgOn3PKFLpT4zzB3UiNkmPPeaGOsO+n6XmF2QvFEVgW9vXQHvOhtlWbEp+3tigPW8YSSdYYwGgrIvmWyiVmDgwcIgMKztG126iv0XSbC4boItWCLr6zWnQryyrXpx74jqyQOh3Azc7vDDQU8Pa5v2IkM2wp6Pah7bFjfCF9+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692556; c=relaxed/simple;
	bh=aag4ttsnwtXSFMZta8hZFDauX1VZpiHxIrwcXJXjvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tq4CR7XOc4CY84js8D+oE9hcuJVcmS5GcPt02NnJbdgvvJlaTACNi4QH/BS3HU2lex5kkVnxMD0dtJp9VdFOQ79vMDjfULJRqbtt+7QD5fvNUUSSI8l6JigDmqbukpflXsz3MfuPfzaq3hHYKhZR3hXv65cn/IvlmOnytkxVXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZhQAN52; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7106cf5771bso3662871b3a.2;
        Mon, 26 Aug 2024 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692554; x=1725297354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcql72JPQTQ2OTkoapF5mbW4vnMiQPQvKYGW7HfPhkQ=;
        b=jZhQAN52Qfl+0RvBWsagF+Ws/BcUswb9biaLsRwMemBePZtseSsQne45ASBtFmJjLm
         6R1H028oOB9lbMxLFimyKEDhDBw5zW9sIfKWBEgVq8/KPltRXL5YyCpdr5m2O+7VSzYR
         itR/puTHLFDGRkrR7Th3hy/5Z7ps2XtEfgF50vZsBKmHT8bXpOJWlYtbQzshAPK5tOH/
         SM6SHlST3tq9HJhm39N2vqMDgODfv5o4Jil7Et+kE3GwRBglAqrYr3Yv8qy+SrsDid+E
         1jAaiStaI58bWKA/2i4CGF4vWRlhpiPTpUSb5O/zzASw3Bhrq+qhondsNTmbzXYd6mFs
         BnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692554; x=1725297354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vcql72JPQTQ2OTkoapF5mbW4vnMiQPQvKYGW7HfPhkQ=;
        b=kq2XvgHJzCeDq7t4xJpm4cOE9UcowgI6yFDqhb9oOivffGFzVPNnEk46TlzN9K+4qg
         54e/sIPrhqSPqVmmIIrjcXpdDfyaVYNMUTseDOXlVZa/Foxmfst9jvukhRApNlcVUWJu
         VxCwTgGV8a3bL99GcDrgrRmaHM4noiC/t9Eh4oqDi7GbDqzWOcRcHd5TaLe2ua/unyiZ
         aOEZBHQ0ddbBhLnALLetV+Zhvo4gM7pjfswgCxFIEEeMDVyFPVvaaCLYsZ7ljVZwTId3
         Rv/dTprXSv1kjn6kwzV5cr9IB+/p3VXN1M9guzWhQuYEb5TTA7GN/bz+R9ftjtCHko4A
         nHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxJRfgDy9TioOKjBknOJ9rJCKV1DJyV9eR8o/Htjz6wFBG0VZ1weT+5DETAZJ+qe/3d+uqzvo7omGwM25I@vger.kernel.org, AJvYcCWP0BtUciZ8IHzgZ0jERTiUbIrpcu7YjpmuTn87swKpaotD8Y/N9jFNtDefvINcf9D/N6PRmSfGCKwCvl4g@vger.kernel.org, AJvYcCWq1xdDdsnUQajr0FoNi0X5wBej2WgHNjSPPstbotX6QrYU0XECmOuPtaYUSFuVLQvX4PAe46/ZhEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp7UqhDu2dWwz8KAeU90mS+rzRq7tmAezObudoV0Qw9Sskc4ky
	ZpW7toIXanGczdN0S4dO9Yvc6bvkUupck+wTj+7AA8md1q4efcYl
X-Google-Smtp-Source: AGHT+IHqCiVZD8k41tBXvr0tubaCtVb1j37tqzR+PZ1WdzT88DIUTlpRPwV6ErHFhiO0ftk2Eidn8w==
X-Received: by 2002:a05:6a20:4f89:b0:1cc:bb4e:a905 with SMTP id adf61e73a8af0-1ccbb4ea95amr1234779637.1.1724692553998;
        Mon, 26 Aug 2024 10:15:53 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdca6asm6761815a12.48.2024.08.26.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:15:53 -0700 (PDT)
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
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v8 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Mon, 26 Aug 2024 10:15:37 -0700
Message-ID: <20240826171546.6777-1-robdclark@gmail.com>
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


