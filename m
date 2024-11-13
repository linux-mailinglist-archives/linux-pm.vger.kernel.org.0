Return-Path: <linux-pm+bounces-17500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71489C77B8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AC11F2544A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253D16087B;
	Wed, 13 Nov 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lK7cZPYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624C146588
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512921; cv=none; b=ehnUuVLW+6pxdHEbu8H26Zxq2gjvQ4v5gbtGdK7QWzT6efvz9DfmdjvQ7rZij8VvCoUUHaR5KtMDzzhzaaTDWbjcW8M69g/E5RSYBNjqcI0qWJWu0YTlEoYRk0d53bqta+8FiUO3fx3NBom1aeZ88HLy3mVtD3fJbjp4S//hzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512921; c=relaxed/simple;
	bh=q5ar/iDTvRrWUmUGLZmHHecZgDsI6qhIEaT2LGKwJWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iFZQCNKl63XFRm0bZHuxRMNgU2KIzTPSg688Kj0qVWh2DABQwYW3upv6EnEo9Ih5jTVZr9XS9ja14v4wvJOKyaubbCgvnMcxBCmFhb4fXai9YEddXM0+JbODb43+0MiQBmBbppS5up6krxbgM/KXhi2UZxC5zIDHP9WgFVMYV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lK7cZPYj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43159c9f617so57033805e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731512917; x=1732117717; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUw1QAWMH+tzja5s7eVHANVh4+/fXkKybRoiIH2f4Kk=;
        b=lK7cZPYjHKDvBcnY6yAbhSoQP1zYAyVR2eRczenLzotiDOY5+6A/LlTWZP/BSoq+iF
         9sdqeOP1t6ikJrodtMHzAgjst2S3q1fmN/LmV5n4PrwmLMQggtV7UfI+YhxZZ26ZuUk5
         LlkyH3V2e+2uWPUUmpA1a/O2YTKANe9IKsrCqy7eM+hfutmAWjtghBBaVxhFFV/eGrEz
         jpEYu5whFiI81E4hWEBlgeL5dKcaud9LZj5m9qcKi5YNEr+jss2itmgqge97lu6uREow
         PyJb8V80QeC0U1BsIJ6ZW077EGL4fmwwFcvv7aCr+s2Vhc+GW3i7JMt8arq/D1ZVghkv
         TPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512917; x=1732117717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUw1QAWMH+tzja5s7eVHANVh4+/fXkKybRoiIH2f4Kk=;
        b=CPHxpzaPXfddutgvfm90Gl1s+4qHyNmOQVbzYwpK899Mm0u5AZvqzjwRhZugVEOjPD
         VlBvv4qDx5FAmVzpMrs3zQcMrMpDs76kOdVhapFYiBrw1aKYNs4cB1A3/FRpGg8eMsNP
         jeDuYCf/0XOhSXMqtwqZIl++OTqHuqpD1enM4IDX2rpO7Z4NPqQJKy3Vu3R0OVxy5ViP
         6vtGk3aT4D1AxqDswUQunARg6Wn0zKIwvfyaEnW7+Y3fCfRjpWbbrwPxAumAr713gOyc
         xyzDjqqZF1e8UuzM0053Tx5uWSM9yuSBWW6ZnE5UZn+ajDbofokwZ6dyogmzD7LUcXmy
         u3bw==
X-Forwarded-Encrypted: i=1; AJvYcCUEUdxN1ghazrBWHDDBt9It7FhwDfcIBojLjo9Qy/qAB6faPawyw3wRCMv/l8WTUWrVYe4CHBZIVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jZcbWO6+wC3cn9Ab33gHDibl59fEXLKMGiDxpBfN2BPKKHAh
	ITPTZIXM46719U7CoAI++xZb0l7wg/AoXxuj5Vam5TomrJbD0w7aIGZNzPLFW+s=
X-Google-Smtp-Source: AGHT+IH0+AWN4BjMUB0SBHWOf+erLPiGOfP4Vhtzv6UNHG9sRcGrOAMATKFvSgWIXqDkAA6diXrhkg==
X-Received: by 2002:a05:600c:3b09:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-432b7518365mr174183885e9.24.1731512916955;
        Wed, 13 Nov 2024 07:48:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f772asm28445345e9.18.2024.11.13.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:48:36 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/8] drm/msm: adreno: add support for DDR bandwidth
 scaling via GMU
Date: Wed, 13 Nov 2024 16:48:26 +0100
Message-Id: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErKNGcC/x3MOQqAMBBA0avI1A4kUVFsBQ9gKxYuE51CExI3E
 O9usHzF/w94ckweyugBRyd7NluAjCMYl36bCXkKBiVUKqVMcDeWR/RrcWcCZ3vgcOFpdkKdkVB
 KU96nOYTcOtJ8/+sWmrqC7n0/p3iwQG8AAAA=
X-Change-ID: 20241113-topic-sm8x50-gpu-bw-vote-f5e022fe7a47
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=q5ar/iDTvRrWUmUGLZmHHecZgDsI6qhIEaT2LGKwJWY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnNMpQHfZA+OfH5dhI3Gcmtq6DXWsnzInwZjcWDscU
 ZhNgKiOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzTKUAAKCRB33NvayMhJ0SoqD/
 0Wl7nGwBx5diixbfRAKseyZLMQI98FN2EGblsvC/puVSEMBW18WDGREytVJd3yTHuJtPmFzmHyiLJf
 dLI0WQF51+NXC0ajolKmjb3KxPVgQtUHbj8G8wwdy87tzH6ZB2z2pPzQslSrfxu8mOPvZCYrp3rlRG
 JinePEUnhGB2j/k4cdSD3MS/ORJooFkaI3XgkpstUMFpkNcIt8WoJTjD+6r7JJocf8SWLVO2v2bExL
 pjAwc+ZQmPElvskwFp4bAD1vMzNGY32d1g4Pq0T+bWcF5rgLQ2MpiId3mgX/3/omDj6K9pNPgfqoxa
 ErNrYM0fHk7mxqLgKwCIZBHT8BJ+vETGWg6WR4JTuSyNtjQ9mC8KD8J4ND7xZHYV67ThTQQwZdUoPE
 jWsnFcw8soPKl9ODMl++OVEav9gJRd7PI5uw6K46CkhgtqHKI3Q0OrDQGVzAI8IgBvvG1dbWPEVhpk
 CCO5Hwo+8J7QGYqQDQ3I5hkeCOFxkwrKdrnGEKWS1xzH+V4tpoK6PdW8O6pgdXrjSzLQjVWZT+sTFP
 yW5atSi3PTIf1x//rC7Tfg9W6Jxm16yQ/RypoGo7uHDYdoRfMuBqOXJ1+tmF9+qCE7OpG+r5p683AA
 w52u68BWH5eDkEAYU+dDzq+srKhru5N6Pb3VmK2qWL9eo8G0NjbEKKZ6TQMA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GMU Management Unit (GMU) can also vote for DDR Bandwidth
along the Frequency and Power Domain level, but by default we leave the
OPP core scale the interconnect ddr path.

While scaling the interconnect path was sufficient, newer GPUs
like the A750 requires specific vote parameters and bandwidth to
achieve full functionnality.

In order to get the vote values to be used by the GPU Management
Unit (GMU), we need to parse all the possible OPP Bandwidths and
create a vote value to be send to the appropriate Bus Control
Modules (BCMs) declared in the GPU info struct.
The added dev_pm_opp_get_bandwidth() is used in this case.

The vote array will then be used to dynamically generate the GMU
bw_table sent during the GMU power-up.

Those entries will then be used by passing the appropriate
bandwidth level when voting for a GPU frequency.

This will make sure all resources are equally voted for a
same OPP, whatever decision is done by the GMU, it will
ensure all resources votes are synchronized.

Tested on SM8650 and SM8550 platforms.

Any feedback is welcome.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (8):
      opp: core: implement dev_pm_opp_get_bandwidth
      drm/msm: adreno: add GMU_BW_VOTE quirk
      drm/msm: adreno: add plumbing to generate bandwidth vote table for GMU
      drm/msm: adreno: dynamically generate GMU bw table
      drm/msm: adreno: find bandwidth index of OPP and set it along freq index
      drm/msm: adreno: enable GMU bandwidth for A740 and A750
      arm64: qcom: dts: sm8550: add interconnect and opp-peak-kBps for GPU
      arm64: qcom: dts: sm8650: add interconnect and opp-peak-kBps for GPU

 arch/arm64/boot/dts/qcom/sm8550.dtsi      |  11 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi      |  14 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  26 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 180 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h     |  14 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c     |  54 ++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   1 +
 drivers/opp/core.c                        |  25 +++++
 include/linux/pm_opp.h                    |   7 ++
 10 files changed, 314 insertions(+), 19 deletions(-)
---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20241113-topic-sm8x50-gpu-bw-vote-f5e022fe7a47

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


