Return-Path: <linux-pm+bounces-9395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239A90BD8D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A69282527
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6B19923B;
	Mon, 17 Jun 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvzIYQob"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA338187575;
	Mon, 17 Jun 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663368; cv=none; b=q9u3c+C5X2/dKF5eM4lMYK1r9VmOpbWQ/fh0xpcOy4YJHGOm80etMbNi0FoBAnKUfbDfAKIWgzSrZxuyJsreE3g1/dvpOM30Q9uhHt11KjgTbdTai41YPuM3apWGbsqOMiOr8BSHKzRl8YtwdWbp7teNa/AVWjxtvLPs7Rvms3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663368; c=relaxed/simple;
	bh=8IW6PDUT+ZIAVeO7Pm34F83TgSukPXWpOfyDk212pDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFBWgBcLzTInloIgxRP+0bZEnjG0LMX2PoF4mWPrWDwAePL3rJraf20Mslvo9cfY+7vzoqIkYHVqMA1svWLA0E0lOaNY9VLwaZqt5ANkQYdO7fUUEUgk8c4PSnMFuRrQjMwQ2jiPeMExWvh4Jra3takrV8rJjWnWNZyRPFTq5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvzIYQob; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f70fdc9644so43581095ad.0;
        Mon, 17 Jun 2024 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718663366; x=1719268166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XM94SIgqTgrJbrT5e0SKLh/HdcnUyE0iL7Um2J9PNd4=;
        b=gvzIYQobOOF8HXW30oR4IYy3C/y7QCk9Wq2nmgZIxjY+7+0CB+Y8+OCucprjXTte56
         hVWpAJMhfZ3NNbqb/UpuK95q8fUuMYdub3j/reICqQ2rdPGmPWm16FzeFuQqgZZ40beF
         WxqfbtGBGGLhxZDHA6zMfem4B/48P3qw/EGvHYw6mI/zB82/JF9uxYViinMs7ydXbUY8
         nXdnwH6gIQsSdInT4M5XHC8cr08McMT/zT0GfggFmEHRM3lFP2JjCeyZtSlP+RiSbe1+
         gKgWI2zAx0dJhQrHtP8HItPB+Pl6RitVpUZ4JacUSDDHJd+AmlObGod59VRf8QY5dd1G
         RCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718663366; x=1719268166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XM94SIgqTgrJbrT5e0SKLh/HdcnUyE0iL7Um2J9PNd4=;
        b=Doc26rlaRcC9xUrM5feNIrzHbM7TpMFPmZ8uWQfWEgNYLk1h6FizGYsknrDLRs/ro7
         mP4etqi0s3y5LF+Rz/Xv1UC05XIKtBdR5WkSpfTlnS91rS+9HD1yJbezFVhz7fYAuk4U
         Lmo0qGwG5zArLKdSB5jIuZChYIUwUMHfDz6BVhj3owPGicIQ294k0BpfgtJGwB9roHLh
         OtP0kDCvQ5Aw3EoD2155d2GMIDAMamRd+oLe2UaidlVipA0NL3CUuGRwXlUL/sjapQC1
         xNbNaOz3OhqYe1+e1Wbd6K/9o+q+Brzl7JIpf1nXZK2dCIhNTvmvwWdDZdygcuUMb/6/
         ms7A==
X-Forwarded-Encrypted: i=1; AJvYcCXotg3w1N0BZKrcsgrSbO7tdsasJVTyjAYCvlFFtqmxYsvnx0HxA/csq2RCHr/qoCl16G67ojZpmqOI8/aMrfGzVlHEzTer4pPQ9pJawxQ9Lncth9ir1eIz1RFho58wVL6imah+7n0=
X-Gm-Message-State: AOJu0YxxSl4KxvJkSXjhPxywv/ck4HyEZFIv0R/cZEJCSp9BOaIfImER
	rykTg2T58h5I2KzTSi/4N6w+04Nx1SlA2nJgMLnGrGon+p0ln9KK
X-Google-Smtp-Source: AGHT+IEOpgI4p8x4cS6eEpW2PNtg21Ko2+su+tSYSUewhI2L7n5QvQjQZK3b2ttS8wmFTQuHEHMrtQ==
X-Received: by 2002:a17:902:f791:b0:1f6:32ef:3e00 with SMTP id d9443c01a7336-1f98b12905amr15453335ad.0.1718663366090;
        Mon, 17 Jun 2024 15:29:26 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55c80sm84222675ad.21.2024.06.17.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:29:25 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>
Subject: [PATCH v2 0/5] drm/msm/adreno: Introduce/rework device hw catalog
Date: Mon, 17 Jun 2024 15:28:58 -0700
Message-ID: <20240617222916.5980-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Split the single flat gpulist table into per-gen tables that exist in
their own per-gen files, and start moving more info into the device
table.  This at least gets all the big tables of register settings out
of the heart of the a6xx_gpu code.  Probably more could be moved, to
remove at least some of the per-gen if/else ladders, but this seemed
like a reasonably good start.

v2: Drop sentinel table entries

Rob Clark (5):
  drm/msm/adreno: Split up giant device table
  drm/msm/adreno: Split catalog into separate files
  drm/msm/adreno: Move hwcg regs to a6xx hw catalog
  drm/msm/adreno: Move hwcg table into a6xx specific info
  drm/msm/adreno: Move CP_PROTECT settings to hw catalog

 drivers/gpu/drm/msm/Makefile               |    5 +
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   52 +
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |   81 ++
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   50 +
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  148 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 1239 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  880 +-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   11 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  624 +---------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   32 +-
 10 files changed, 1648 insertions(+), 1474 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

-- 
2.45.2


