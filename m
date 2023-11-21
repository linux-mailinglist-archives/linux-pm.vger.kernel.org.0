Return-Path: <linux-pm+bounces-3-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEDD7F2248
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A226B282819
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB21380;
	Tue, 21 Nov 2023 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEd17WkY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70228CA;
	Mon, 20 Nov 2023 16:40:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ce5e76912aso29926485ad.2;
        Mon, 20 Nov 2023 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527203; x=1701132003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWNEMhZS/K0TJv2uoFh3uKzFoySYNwsIpa4bcavYV+M=;
        b=NEd17WkYF+NXhfS2etPmsRD8sEAko3mlUFF1icHnojB9KRYhsi5f8Fwk7SWou6xlim
         ++LilX841XWudSJZTMVr2FICGLjEYvWbz/fM0nGBFFw5vTVMsFLb+XQLcGPrhkLf31H5
         13VRP/WEbFwM2XaGsoSXelHGWfYC8hxLjz4xJV+IZ2kFSyeQBp3WfrpQeNSJTh6J4XpZ
         N/GblDuy+jq8tlqZsWXihjfJH5xF9YMu60CDGYW7esg6KJwDc8I9HK/K+L2sSM3OL57n
         y2T2Z5MnK48vFaqyjui5tACRdA024D+8FSSNmbaBC57I9XZ9FzcDSN/sBtXOKcBF+g3J
         8L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527203; x=1701132003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWNEMhZS/K0TJv2uoFh3uKzFoySYNwsIpa4bcavYV+M=;
        b=Et1qt+l9CSSItPLXjhrxz4ldvSBv8tXGToc/xNOgpuWdnYUixLK6KKrfdxpGZur262
         NATlUo8j4bNC2A9XH5DG9YRdEJvD4f0mwSE88hh9aadW9mhDKXoTVM5oEO3FywIXztZf
         Z+jQ29XNHrKve2tv1t0Wmrw52fFtR2iCINxvuSDY2QpNahkc+WAC/Z/Rc2KXuUmdQCsk
         pXnn2mUS6Hch3J3+sR5hhM+9cbQ4tnksZ/5kKUb/izGn64Kgz/LcHgT5WyJPAW1qJqWv
         fH/DQ5D4nwDF+7k6fHa6apqaAKXtG/hQwUK1/N5uQWHuYeST/eUFGdFgXVOH/8KH03lE
         vwCw==
X-Gm-Message-State: AOJu0YwJt/hhFPtnhMoajxKmLvnDK5h5vx/Q7nbZhjaWFFgVvBwtTQRI
	QeZsvpbJVJXbIwSfa5leaPQ=
X-Google-Smtp-Source: AGHT+IFXhiAAFyErJlqOO1DTQVYb7f74uon84kYLMLdTjeTRCnwI6JR3VAOwwCqryfnQrGSMB9oxFQ==
X-Received: by 2002:a17:902:eccd:b0:1cf:54e1:8c8c with SMTP id a13-20020a170902eccd00b001cf54e18c8cmr9016957plh.63.1700527202832;
        Mon, 20 Nov 2023 16:40:02 -0800 (PST)
Received: from localhost ([47.215.232.245])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b001cc436e9806sm6636258plo.81.2023.11.20.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:40:02 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:AMD KFD),
	Arthur Grillo <arthurgrillo@riseup.net>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Guchun Chen <guchun.chen@amd.com>,
	Jack Xiao <Jack.Xiao@amd.com>,
	Jonathan Kim <jonathan.kim@amd.com>,
	Lang Yu <Lang.Yu@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	Marijn Suijten <marijn.suijten@somainline.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS),
	Philip Yang <Philip.Yang@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v2 0/7] drm/msm/gem: drm_exec conversion
Date: Mon, 20 Nov 2023 16:38:44 -0800
Message-ID: <20231121003935.5868-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Simplify the exec path (removing a legacy optimization) and convert to
drm_exec.  One drm_exec patch to allow passing in the expected # of GEM
objects to avoid re-allocation.

I'd be a bit happier if I could avoid the extra objects table allocation
in drm_exec in the first place, but wasn't really happy with any of the
things I tried to get rid of that.

v2: updates in 6/7 and other nit-addressing

Rob Clark (7):
  drm/msm/gem: Remove "valid" tracking
  drm/msm/gem: Remove submit_unlock_unpin_bo()
  drm/msm/gem: Don't queue job to sched in error cases
  drm/msm/gem: Split out submit_unpin_objects() helper
  drm/msm/gem: Cleanup submit_cleanup_bo()
  drm/exec: Pass in initial # of objects
  drm/msm/gem: Convert to drm_exec

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 drivers/gpu/drm/drm_exec.c                    |  13 +-
 drivers/gpu/drm/msm/Kconfig                   |   1 +
 drivers/gpu/drm/msm/msm_gem.h                 |  13 +-
 drivers/gpu/drm/msm/msm_gem_submit.c          | 199 +++++-------------
 drivers/gpu/drm/msm/msm_ringbuffer.c          |   3 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c        |   2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        |   2 +-
 drivers/gpu/drm/tests/drm_exec_test.c         |  16 +-
 include/drm/drm_exec.h                        |   2 +-
 16 files changed, 92 insertions(+), 187 deletions(-)

-- 
2.42.0


