Return-Path: <linux-pm+bounces-10289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68D991E52C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6071BB25D3E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 16:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85416DC30;
	Mon,  1 Jul 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAIotl5R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD516631C;
	Mon,  1 Jul 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850841; cv=none; b=IYzHCKEvoxrnBKxTeHyUUoZt+mo+dPj8hzWAlrpgtdOyFW+v8Q61ce+EWGkV3s0q5+JGvmGm8d8cVRcwjTmCrHQ0B1mTg2dD4cdKufsm2hf2bRGFXOfTQ0WlSnKHQKN9Jjt8hCAhnWBbYAf+K6vxylA0lLjRonV9yDivIcSuBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850841; c=relaxed/simple;
	bh=IW8RGWfl2BlHpimDXAA7bRLiZRlSAdHOFyJ5cLC8y/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4C6nluzKJ8DoEOEKgIdpMS7Jl6ZdGPr4X5JGOJzbaih3Z/WOOGwaitO/vwLw9wPCncMsByc1h5+3l6alQ/u/8dr7+qf2FIkKCBT56aDRrGn5LyErn99P0IV/ig86otlvhn+tfhe1X8kU95p/s5Q3K+akGjY1Ai7eBd1RQ+5JhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAIotl5R; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b97a071c92so1524930eaf.1;
        Mon, 01 Jul 2024 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850839; x=1720455639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1jhsbzsQSOicdV37XZ9var/nTBpCYxPxtGqd7ndFu8=;
        b=KAIotl5R7epRM9+HR6snTCVFJKjuragodVg+WXICWpVmZ8viARwyZxFzxyS3YG1aFq
         eU3iOtoWGcHEJWkcI0HbcFkgikjVjTJwBRcSdcVsvWVUiWuuFEznB6c8MwvO+2G1+SW+
         DeFEmMq5gUHPso7QDYjZZCFYV4Gqp1onMWNKEtvWuLqVSMTveJkakIHv+R0HZ8UDidQW
         0stTD3WaLtCvOEeSvMxIAWPpnYGBE235YVoUR5M0yL3+wXZ0XpOzIpr/cpYNl5OBmlIV
         xfJwedetOPV6w+MISEBYRTnUuEz+sEyUZHxzhsv4bgwQN2VKcMs3rg2Z3J4J+9um/9F1
         JQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850839; x=1720455639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1jhsbzsQSOicdV37XZ9var/nTBpCYxPxtGqd7ndFu8=;
        b=iorBjTKC3ODXSAPE185YKoohBMLA6yrOKX7igElWF8JMG9rJnMSLuI3MBv+GI5I+1r
         YdAJNlRQPhyt/xXYEQ7e5B30plk7zlvkFMQLRfoZvb8qxsrj2/A8x1YBUDzW1VC8oMwn
         AekO5c7ZWICW+/yENw9KSX0/pSIrdKAFBVThbJ2k5FLBHZmNsv97o2SYIoW5jqx6C66p
         1wmEdDl0gI0p0sb8DsL09jBKBPw+dRwHZurWoAGECKxvpQeEZpS77U1A3SLDbjuQKTLB
         5vq0Vi+ASdi1yZ0I9SZyWAE/SazX7xVXWMg2fhaAONVw1Z1TWpkFiSzoz+rDfl2cFRlG
         do6w==
X-Forwarded-Encrypted: i=1; AJvYcCUWEqMwajae2tuDTPoRNibKEleYuje6UIY5OzcdgRp2eOsqKI0ujHIoxrRQwrQEWGoyXZJD3cTCxit2yLwNl1+vaDpwKWdTbjj5fVns5kP+W2bIJkfhzwqdMHIYvmrrI2ql10OMTmuosXBOyEhNM7RS0F1xK6gQAHRv/rTY3THooewIjg==
X-Gm-Message-State: AOJu0Yw+/GLVcjLqbxx5hwawExRUed0TArnrmvldq3FvrZeFKvuQBZQD
	mVvSVV93vEw2aP1i0tQZzQThuaPwOfaKSzB5sd44hiEkd9T4m9fy
X-Google-Smtp-Source: AGHT+IE7cvLNIICXLZ+ApTE7+JEq/r4+y8wOtGf3rrz7GsGFtHfKDk9f6EPS0mmgXO+f7YcF9Yy4cw==
X-Received: by 2002:a05:6358:6f93:b0:1a6:72f2:4d03 with SMTP id e5c5f4694b2df-1a6acd61133mr706254455d.9.1719850839491;
        Mon, 01 Jul 2024 09:20:39 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm4452022a12.31.2024.07.01.09.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:20:38 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 0/3] iommu/arm-smmu: Prettyify context fault messages
Date: Mon,  1 Jul 2024 09:20:09 -0700
Message-ID: <20240701162025.375134-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

v3: Split out the reg bitfield renaming, rework
    print_context_fault_info() helper

Rob Clark (3):
  iommu/arm-smmu: Add CB prefix to register bitfields
  iommu/arm-smmu-qcom-debug: Do not print for handled faults
  iommu/arm-smmu: Pretty-print context fault related regs

 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  2 +-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 66 ++++++-----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 74 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h         | 71 +++++++++++-------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  4 +-
 5 files changed, 127 insertions(+), 90 deletions(-)

-- 
2.45.2


