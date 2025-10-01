Return-Path: <linux-pm+bounces-35613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C3BAFA84
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 10:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BE23B4ABC
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3A246795;
	Wed,  1 Oct 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMthSMXB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E931494CC
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307668; cv=none; b=JStOTnEfDN7CxrbBOXH1YA9H7ZIVHWc9DexNqsYRYllckRmuwkGJrVv60AsFpQrg3nyrgrjicVnx9s9SlrTuOhEsw1Kxnyi+03OFnwCmBWr6vKf1oF6W5abBUZ8vSnX81PqzEhY9u9j/OQgb6sBBMfPFIOoEW4iGXHXbGgqYO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307668; c=relaxed/simple;
	bh=mujG6ZEBYNJUQj4X4QkV7ug1oGAH6DomMaXr2GB5xUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rbJWt5TMf2VMQm11ngva7fVzlqdQYjKZ442NgCk/+FhKO/MOgMFvDzP8toNxXU9lqFK7wGYeaWUh3aOAFkW6hGaNJwRhANdrlUGRZIPQ8/UkAaRGqvGE9/Mby2TJ5dy9RyL7903Fqh+0gMiKgvHpNit27rUaDaRPdZWqAXcCzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMthSMXB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782023ca359so4556687b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759307667; x=1759912467; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+kh1tuJGbRI1gly7hpyaiYfbAOz2ThedwHiT2rufjM=;
        b=SMthSMXBfJqtpQclOswnzhJ2Op92RBod2nw/olgMmQtcCMebneVrcdE9tBjfpXOZBc
         WkrpBxwHW+bsefMZk4yT/o0uYJldb0mLSLlt8NwceprOcwY+pNze6yIcD+PkQ/Ec9EsP
         DTqwKawBl5AacJF1CSfH1zasTIycQ27WlxKuOHp0lHRSwIrvlHsBUoGkQ9/fk1FH/fm7
         AwyoEJoz4hqq/V4Dc7I81qZnjMFga0E/nmcFZtbpa9uREyVxppbTzhQIw8CESM307aOY
         HQaigMThxBjNCRRMdQOTjyGPsvIrLyfG9X2CjmgCAIjHQ2lw4hT37FiYBWWZG55bDPE+
         McIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307667; x=1759912467;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+kh1tuJGbRI1gly7hpyaiYfbAOz2ThedwHiT2rufjM=;
        b=rDlxaspr9vdKiiRnldvPkbWqrIBLmBLIZ2xeXfB13IkWwcEBCboQAO3SgfD0QPvf0a
         Sx2La42vMdu/tBMGng3NHZMwU8Lvs3UNRz3ZDuVSg9nJdbU6Y2dRjF6M7lKBfTt0/pu+
         bJJuUNBTqM/ZgxrKCqryZMVHdfYokJc15dRLvQccmoMic7957U8iqqJ7Tp8KrdYgiU2C
         8pInQwDzftsCVVj8Mf928fJzgGyU+GfB8SGlemfIM3QbDIpJkAh6qpxDvryC6Mx70MHO
         5kyj8q3/ePfVMDTdsi1UA0Aily2GM8qkhOlu1VWdRyk/gRZsooO/qM8glJoaUJddeZas
         gU+g==
X-Gm-Message-State: AOJu0YyW66aeey2OJyMlAkeYJ2edQTRPl6dYsXWXrP2UxtacjhkwgoO5
	b0+o/+lXmdlYqBB3zrnI3f9jrPa40QCJAS79wUUrjAVtxuYZOCgLCVWKpSxpi9Nt2f8=
X-Gm-Gg: ASbGncush64VlMzRyosemUcArJplcA15hoSH53qosKYpEjdUIVe0uYQ7V6PaP8Kz+8D
	7QpsTeP1Qz2TNNtQAWr7Q/R9aCeFlxc2wmV4me9DGrcRdeFczUGLbvxI8bUC5nHZCrzeTuFG+qr
	VZuMEsGO9pdLj2faOz7pkovKJcAcmDKLsC/pGKd08xYHGSXI00oxES9w8bGzBervbPPQWuF2nwl
	C76LcAOPd34nTmEVVO21vTZFCYJbn7yJgIzZAY+5sVl70QyMqlUb1OFzWbkkxHIjJTISG/3sTkc
	DuQtGir+Yhc98v9HCu0qZhkVNZ/r1kYRGbdyBl28HgPXBDUUP+i8HznIHPUGphCxOCi7NnIxnNv
	sLjBsBnDQXv9uOnsPFYe8oFdLb0RV3ODpcGEKe569eNyKp6lD
X-Google-Smtp-Source: AGHT+IHIU4ZOfELjW3sW/2Hlrzw6TdqTbX2sqWkl1rY6IM2ggUqn4yXRyM0ZXVkNbHMRL79MR0oMxQ==
X-Received: by 2002:a05:6a21:9202:b0:2d3:8d14:7fc5 with SMTP id adf61e73a8af0-321da9e22c7mr3688618637.18.1759307666677;
        Wed, 01 Oct 2025 01:34:26 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55bdefesm15507699a12.49.2025.10.01.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:34:26 -0700 (PDT)
Date: Wed, 1 Oct 2025 14:04:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.18-rc
Message-ID: <20251001083423.5jndpemysufxjx7f@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 3e681899cc6e6c77eca55dd8c7cc57b27868e8a2:

  cpufreq: mediatek: avoid redundant conditions (2025-09-04 10:20:44 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.18-rc

for you to fetch changes up to ba6018929165fc914c665f071f8e8cdbac844a49:

  cpufreq: tegra186: Initialize all cores to max frequencies (2025-09-29 14:55:50 +0530)

----------------------------------------------------------------
CPUFreq fixes for 6.18

- Update frequency for all tegra CPUs (Aaron Kling).

- Fix device leak in mediatek driver (Johan Hovold).

- Rust cpufreq helper cleanup (Thorsten Blum).

----------------------------------------------------------------
Aaron Kling (2):
      cpufreq: tegra186: Set target frequency for all cpus in policy
      cpufreq: tegra186: Initialize all cores to max frequencies

Johan Hovold (1):
      cpufreq: mediatek: fix device leak on probe failure

Thorsten Blum (1):
      rust: cpufreq: streamline find_supply_names

 drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
 drivers/cpufreq/rcpufreq_dt.rs     | 10 +++-------
 drivers/cpufreq/tegra186-cpufreq.c | 35 +++++++++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 18 deletions(-)

-- 
viresh

