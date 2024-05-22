Return-Path: <linux-pm+bounces-8058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA78CC83C
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108D71C212D7
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD7146013;
	Wed, 22 May 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjk1LAZj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3F80045;
	Wed, 22 May 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414628; cv=none; b=OKOI3zQxjsheTMYQ/k/7CWmwmaAiQ2ebwxvTv0ZZR6fePpEA1Iqr6w40k40ldXEYHO/nn4yRFmvtySi/bhkymAlmu/dZg9l6DRvFxobqeTac2XWy+1VF6A0D5qurkSY5uhS+gjZRwQq7fgono0gQWSbfGuxsyWfgPmaNqJ3bfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414628; c=relaxed/simple;
	bh=L//sNRivVqdwa73OnOET5hl3cywNzWVR2sKrxJQ9x1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tryyKkHVGqZIsTDTv1jWjt8VSRTbExmnObAyoLdo2SKVkYM/mLXqMvaNwiPLBjiLTjSkGrFgrnB0EhHJsWaPNKXqpaOpGGbtGSBlAuCT8rTEItVT/o8aSnddsq/Eq8QnOSznkSzt+DvFb0s8kSgkJX3tlVeKR8TFD+JXlo2lb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjk1LAZj; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b2cc8c4b8aso3799275eaf.1;
        Wed, 22 May 2024 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716414625; x=1717019425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBAoZG0al1m+JA3ktgdRMgrP5Z9mDaaNRS9hpWp/qPE=;
        b=Sjk1LAZjtZs+b40oEpf7JiLOvy5Urg2UkTNObNysI8K7UUfiQZsDXON9b762IJ0sWJ
         kkAOt0cKgWLo/lwBEZbQr9xlAWlGxCREwweOecVrF7BBzH4iPVipxzlGhYW6gH3gBkZk
         LxTFzWy4ERDgH2VDqjLziskc7u2lWnUdj8E/IIbZHbCvOakns5F8ttFeJMauiBRiwv2D
         iLnK9YlnG8L5364Jc6V2DGhB8Yb4OFW4VK584jAFUP49fd7j8Lr5N5qQc/TZ5Oy3UDgj
         qAqE6tcVxsT/3elFFc1dGEogjswTqET37ovKKwSv/RW29pQ5CsgXJBRO7NwXdlgh3rOs
         hCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716414625; x=1717019425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBAoZG0al1m+JA3ktgdRMgrP5Z9mDaaNRS9hpWp/qPE=;
        b=LatPJjkny4duWvFfsLZLIqQVBNcA+2KR/L8zNCB1skpQnWoZYgencpf0ZJewSmSHv+
         lFjHdTth1OpohkSNCoHkcsvLWz84PBva6zUb5mx8U3+jxN2OXQSxutMGUGEsWCuIGTJv
         jOUfr2eI4KFlfO4kz1Dyd9NLDnnG+9iEkJACltaJH4wqzUZIvs1Hnp/jyvs8WqkK1+YK
         Uz1t29rKNYJeiZeKUdeyHqyyYzuoqlJHx7GT37NgqpEo6HVTS8KYe9pye5OGKuQOJg08
         DQWWSZHwHTqBf861YYL9RTQKrVndpN7yStzQR0yy6SHrOeXiv6MAqHo27FtHCfW0YPlN
         DSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtkssaxYVDs28rBJZ95+XIdAAtVqx0fttzKSAvS7gWhGrqP59/v75q5hnYBNAnhIhaE0ATySZpZBr/1h9oPSWFwhPT0RKG15/OMSng7ufVrFtChv8fo9sM+TPsVGdzcPPAb1huzXVFMNaB/HVTTXz5R5hPXbbWWHSDTEA3TG3kTFIgAu3d
X-Gm-Message-State: AOJu0YzpeQqVQJK1zU4Kgq5FgsfysyQJYVQ15ltl6zbT3dip5peWAQnZ
	RQQOShGewHGkO6YpNiaQWqJGnossI3UHxrK7eKQP+1XYIWb0g05fKvr8qg==
X-Google-Smtp-Source: AGHT+IEJ5Jxw6Dx7ysWEw9SOQIKtcpP6HWnvE1UIWEcK7zpJ4dBNansEqpDAUp5l6zKniQsabf2Azw==
X-Received: by 2002:a05:6359:704b:b0:18d:9e5f:aaec with SMTP id e5c5f4694b2df-1979213ec36mr296068055d.31.1716414624804;
        Wed, 22 May 2024 14:50:24 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f677a20c6bsm13037190b3a.129.2024.05.22.14.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:50:23 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v3 0/2] io-pgtable-arm + drm/msm: Extend iova fault debugging
Date: Wed, 22 May 2024 14:50:03 -0700
Message-ID: <20240522215014.26007-1-robdclark@gmail.com>
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

Rob Clark (2):
  iommu/io-pgtable-arm: Add way to debug pgtable walk
  drm/msm: Extend gpu devcore dumps with pgtbl info

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++
 drivers/gpu/drm/msm/msm_gpu.c           | 22 +++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++
 drivers/gpu/drm/msm/msm_iommu.c         | 18 +++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  5 ++-
 drivers/iommu/io-pgtable-arm.c          | 50 ++++++++++++++++++++-----
 include/linux/io-pgtable.h              |  4 ++
 7 files changed, 107 insertions(+), 10 deletions(-)

-- 
2.45.1


