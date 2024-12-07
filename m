Return-Path: <linux-pm+bounces-18738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4B9E8096
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 17:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C08C188432D
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20494149DE8;
	Sat,  7 Dec 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4uPveSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AE1DFE1;
	Sat,  7 Dec 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588238; cv=none; b=jUYcnLPHJlKU9pg0KT0noKJrHqw4Ra/PJMebiTCgYvzwsStXcnK4UkblQ7g+U9G99umPMxz24WaOSjZ752L0So1fmpIxTdpq+SDOb/IXNH0GrqHpN8qHdMclQ04FVY3pGHVg0Sd4GB+f2Qlt2jXTl2ulIOsac7kySMentHR5Ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588238; c=relaxed/simple;
	bh=jnmC/9SGTHlP2v0Inubz8Hb/ROZA8v1ie5BTlI9X1I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6fwY0T9N3FqHea+E8PFNYTWjv70Lw4FYkahMPjTRPGWo38U/AjtxqQ+RPrOX1DZ8Q2VgG/VmMHcggki4fslGEUTWgH5xPb9bvM3Syo1hBZVP9YaZN1/RGcJRHZrZNQq0ANs5vRkK88LQPvqqW7FYG4kliJpm6VbLEshYpH95DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4uPveSM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd377ff3c5so543757a12.0;
        Sat, 07 Dec 2024 08:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733588235; x=1734193035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQVo/h69eP7W7+1c9cYInjm18ZQ/NruUHHKzUMPfb2g=;
        b=G4uPveSM5y52Mxd7lVj5RVXTHsr5A/ojmcXQQQoe3ccck+UB5DddN78QbpQBvDmxUD
         whaqrEfAqiViRflv7504j8s2kc9cB5Who64f4WYhQuML8yYiuOTCgefLazv13kWw+0RA
         1Vzf4n6pBx2cCS1HpSjtuLTGLFNZG6euSTKqW4OFrElRhsegAM8BQYKmo6uBTuJO4iLO
         f+iWvfDVnPiPgruh76bdfTCKmzPTbT4QKSGdR4K8oiPYVNxsUQ9lnwWqqa6u99mx5XwY
         lcnjjg8kgWF3GINt75xV8G3mvnGWsd9NYwYZBLw9nnfmCwegaFlxT4sJqLP2ItmiKotu
         mvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588235; x=1734193035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQVo/h69eP7W7+1c9cYInjm18ZQ/NruUHHKzUMPfb2g=;
        b=lKUwolwMpGEAES+FlD9SwHnE3OkIFdgxBQMHShVo+INLaSH7KCk2tv+qRmZHRiWtYM
         V+WKIuKW+dptEauInDlIoVx0iTo3HhOuSUWHMISWbtcQsPopq1MeNrICxpQQKsoOIgIz
         2l/PRJQ0kFlCyA5FhKEwa5Qr1iUdVL5Rt10fVBy5Yxn4LI6k8tsE+CDapOMowU63O0Ly
         Dg2+d/ZK593wPGpHdW3Uz87XrmSSAav0pEpCKlLVMKa6E2d+ChJhqGmxVz9YoJGfZzfS
         Kqr1PSEXREHPkNkuzVF3VKzB/0tCrxlnIwe1v+sRv5zxDaJbfC7C3L3iEl+yrTCOp9vd
         OF5g==
X-Forwarded-Encrypted: i=1; AJvYcCUwX7Bq92xdEFGzDUUUKll9UeNTfcMV4LiAUtiFbFQkI35VfaMoKoGG+B/RJpYcsDNb2ChO2IBoP7U=@vger.kernel.org, AJvYcCWb2axFKcStqY+vn+Zs6JaHe2Dd875pZVZth6emLKFyqlH7pbkWf7xyUy4+G3PYeAsdXz+vly4DDaF77X10@vger.kernel.org, AJvYcCXVHKrzjUpQpVT/N82GQNtglEDvacZ8C6jV9Enjo2jUcdRwAMEWyM6ls+tB3b7crvRHFfdINHqMeKZ9Nhfs@vger.kernel.org, AJvYcCXqVTT4+4mesVcfpzpFPKdwbv1BZcDIpTaXBwhEuQMLC0xhN9bTVZ3FbBE2MDU5IN2Wzj79VH4hlzy1KY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/9qCaTH8dijBAtDGbZKFnRYgItXbrUENppENpQV+RgTCHMaQ
	MyNYZgjLMAEv/W4uDS1Zts/pogKVgxUWwdG5Ov+9/FB5/SA3KbDw
X-Gm-Gg: ASbGncuH2mcZuesyRiSuf8njxm8utHhyt3uI9iGQoZQDfTW9UB6vbdlzQ1GJZVitZ4S
	D4KhSiyutAk615c0GNuFbFKu0S3m349zAPeTE2Rh/q0fSrKvHOvYq3pouCtxt9SGoEQJTvReeG/
	r76KbvrNSErK3LMH0BTGqCdcef9Apq779cA3impH3TFiscRuIphmokLJCPPrymza8qx+slacklm
	0AtZfSccYB6RyYYpO+PTF3fe6Ip77kfIHMWCxKVAUwYIEFE18P19enP1g+rhyiNKGKchwKdkI4C
	eriKqm00
X-Google-Smtp-Source: AGHT+IEmvFnBaDTFAw3iJraQEGMF/iUDVX5tXZvZVfuIO2OYpZL0lZpXEUIfhOJmviPs0qS6KOnT/w==
X-Received: by 2002:a17:90b:2015:b0:2ef:6ef4:817d with SMTP id 98e67ed59e1d1-2ef6ef486ebmr9437262a91.6.1733588235412;
        Sat, 07 Dec 2024 08:17:15 -0800 (PST)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8610ee98sm1426630a91.5.2024.12.07.08.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 08:17:14 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Connor Abbott <cwabbott0@gmail.com>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Jun Nie <jun.nie@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	linux-kernel@vger.kernel.org (open list),
	linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
	linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
	Marijn Suijten <marijn.suijten@somainline.org>,
	Paloma Arellano <quic_parellan@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Stephen Boyd <swboyd@chromium.org>
Subject: [RFC 00/24] drm/msm: sparse / "VM_BIND" support
Date: Sat,  7 Dec 2024 08:15:00 -0800
Message-ID: <20241207161651.410556-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Conversion to DRM GPU VA Manager[1], and adding support for Vulkan Sparse
Memory[2] in the form of:
1. A new VM_BIND submitqueue type for executing VM MSM_SUBMIT_BO_OP_MAP/
   MAP_NULL/UNMAP commands
2. Extending the SUBMIT` ioctl to allow submitting batches of one or more
   MAP/MAP_NULL/UNMAP commands to a VM_BIND submitqueue

The UABI takes a slightly different approach from what other drivers have
done, and what would make sense if starting from a clean sheet, ie separate
VM_BIND and EXEC ioctls.  But since we have to maintain support for the
existing SUBMIT ioctl, and because the fence, syncobj, and BO pinning is
largely the same between legacy "BO-table" style SUBMIT ioctls, and new-
style VM updates submitted to a VM_BIND submitqueue, I chose to go the
route of extending the existing `SUBMIT` ioctl rather than adding a new
ioctl.

I also did not implement support for synchronous VM_BIND commands.  Since
userspace could just immediately wait for the `SUBMIT` to complete, I don't
think we need this extra complexity in the kernel.

The corresponding mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/32533

### Notes/TODOs/Open Questions:
1. The first handful of patches are from Bibek Kumar Patro's series, 
   "iommu/arm-smmu: introduction of ACTLR implementation for Qualcomm SoCs[3],
   which introduces PRR (Partially-Resident-Region) support, needed to
   implement MAP_NULL (for Vulkan Sparse Residency[4]
2. Why do VM_BIND commands need fence fd support, instead of just syncobjs?
   Mainly for the benefit of virtgpu drm native context guest<->host fence
   passing[5], where the host VMM is operating in terms of fence fd's
   (syncobs are just a convenience wrapper above a dma_fence, and don't
   exist below the guest kernel).
3. Currently shrinker support is disabled (hence this being in Draft/RFC
   state).  To properly support the shrinker, we need to pre-allocate
   various objects and pages needed for the pagetables themselves, to
   move memory allocations out of the fence signaling path.  This short-
   cut was taken to unblock userspace implementation of sparse buffer/
   image support.
4. Could/should we do all the vm/vma updates synchronously and defer _only_
   the io-pgtable updates to the VM_BIND scheduler queue?  This would
   simplify the previous point, in that we'd only have to pre-allocate
   pages for the io-pgtable updates.
5. Currently we lose support for BO dumping for devcoredump.  Ideally we'd
   plumb `MSM_SUBMIT_BO_DUMP` flag in a `MAP` commands thru to the resulting
   drm_gpuva's.  To do this, I think we need to extend drm_gpuva with a
   flags field.. the flags can be driver defined, but drm_gpuvm needs to
   know not to merge drm_gpuva's with different flags.

This series can be found in MR form, if you prefer:
https://gitlab.freedesktop.org/drm/msm/-/merge_requests/144

[1] https://www.kernel.org/doc/html/next/gpu/drm-mm.html#drm-gpuvm
[2] https://docs.vulkan.org/spec/latest/chapters/sparsemem.html
[3] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=909700
[4] https://docs.vulkan.org/spec/latest/chapters/sparsemem.html#sparsememory-partially-resident-buffers
[5] https://patchew.org/linux/20231007194747.788934-1-dmitry.osipenko@collabora.com/

Rob Clark (24):
  HACK: drm/msm: Disable shrinker
  drm/gpuvm: Don't require obj lock in destructor path
  drm/gpuvm: Remove bogus lock assert
  drm/msm: Rename msm_file_private -> msm_context
  drm/msm: Improve msm_context comments
  drm/msm: Rename msm_gem_address_space -> msm_gem_vm
  drm/msm: Remove vram carveout support
  drm/msm: Collapse vma allocation and initialization
  drm/msm: Collapse vma close and delete
  drm/msm: drm_gpuvm conversion
  drm/msm: Use drm_gpuvm types more
  drm/msm: Split submit_pin_objects()
  drm/msm: Lazily create context VM
  drm/msm: Add opt-in for VM_BIND
  drm/msm: Mark VM as unusable on faults
  drm/msm: Extend SUBMIT ioctl for VM_BIND
  drm/msm: Add VM_BIND submitqueue
  drm/msm: Add _NO_SHARE flag
  drm/msm: Split out helper to get iommu prot flags
  drm/msm: Add mmu support for non-zero offset
  drm/msm: Add PRR support
  drm/msm: Rename msm_gem_vma_purge() -> _unmap()
  drm/msm: Wire up gpuvm ops
  drm/msm: Bump UAPI version

 drivers/gpu/drm/drm_gpuvm.c                   |  10 +-
 drivers/gpu/drm/msm/Kconfig                   |   1 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |  19 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c      |   5 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         |   4 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |   4 +-
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c     |   4 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  24 +-
 drivers/gpu/drm/msm/adreno/a5xx_power.c       |   2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c     |  10 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |  32 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  51 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |  10 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  78 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  22 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c   |  18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h   |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |  14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h     |   4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c     |   6 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c      |  28 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c    |  12 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      |  19 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |  12 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  14 +-
 drivers/gpu/drm/msm/msm_drv.c                 | 175 ++----
 drivers/gpu/drm/msm/msm_drv.h                 |  31 +-
 drivers/gpu/drm/msm/msm_fb.c                  |  18 +-
 drivers/gpu/drm/msm/msm_fbdev.c               |   2 +-
 drivers/gpu/drm/msm/msm_gem.c                 | 403 ++++++-------
 drivers/gpu/drm/msm/msm_gem.h                 | 193 +++++--
 drivers/gpu/drm/msm/msm_gem_prime.c           |  15 +
 drivers/gpu/drm/msm/msm_gem_submit.c          | 223 +++++--
 drivers/gpu/drm/msm/msm_gem_vma.c             | 543 +++++++++++++++---
 drivers/gpu/drm/msm/msm_gpu.c                 |  66 ++-
 drivers/gpu/drm/msm/msm_gpu.h                 | 132 +++--
 drivers/gpu/drm/msm/msm_iommu.c               |  84 ++-
 drivers/gpu/drm/msm/msm_kms.c                 |  14 +-
 drivers/gpu/drm/msm/msm_kms.h                 |   2 +-
 drivers/gpu/drm/msm/msm_mmu.h                 |   2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c          |   4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c         |  86 ++-
 include/uapi/drm/msm_drm.h                    |  98 +++-
 48 files changed, 1637 insertions(+), 903 deletions(-)

-- 
2.47.1


