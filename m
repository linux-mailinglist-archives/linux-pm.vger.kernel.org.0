Return-Path: <linux-pm+bounces-13747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74F96E972
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F861C20E1D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 05:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425AA5C603;
	Fri,  6 Sep 2024 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9zBctn1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E71EB3D
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601661; cv=none; b=mtOqajDX9wr8HGexpOU71KJUxPh+bWMnVmRb3EGnDXkfBJ4bYVvOAQfaYUDmrzwjImzJO64JLqXYlvgBNaQCUJtg+W5ZekLX2VajwZJAnoD9bpCf4wJ5dNE/i8SHjyc+uZclBeTMCo1VQEAofXGNiGjE8bUKjO6C8XdMQNiPXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601661; c=relaxed/simple;
	bh=4YEHGrkkHHVVJMZovlHa8XQ6tnbbhoygwFe6blo3Fmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cxIxnQb/jlPZD5qWxpMScQwSecRiZksan4aYHYSAMzTcKp5j9wYLiYWDCUV3bIhSp6w2MOoa/8FbfCY0tpUtx4Gqj4Jfc/NK40ddaLP3+71sp1Xh3MKNT7oACT0qY4ftrHR+H47G197jMwBV+lgInUjPASSygMW6tK0DuQ4zXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9zBctn1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso1231252a12.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725601659; x=1726206459; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUSgO8HPe1JPzO4rusD3SmaqP376Z2RCt2XiIz9KQT4=;
        b=W9zBctn1CKdDIfdt7V6E+SkYFBR7s68dNBTlRq6ov9m2ZtmvCsjksLcvpc5vTRF8uQ
         DsrZ4OR9TIYsMNv5XVzJUGLzozZGvGiPH/6dOIQcWBPGgol9AaV4KvyLzfI+kfDvoKc/
         YtjwSwTY19XXByjJslAz2JUBiKpADj6LVns+S7lImElZwQ5wyBQP6f6YI6c+QeMxsBma
         Qpz07NdBWoXptFhb7Bm5NHqr/kz9BPCDVpUNwUakQKbG8htCT+GCwgERqP4yR/N15zdP
         eTyk/lhxsb3VVfAPk49rjWJgN7qxeTQQ/0WtBsWBhuErpPw1nBMe+Z0d9RDG9RkEDoRu
         FVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725601659; x=1726206459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUSgO8HPe1JPzO4rusD3SmaqP376Z2RCt2XiIz9KQT4=;
        b=BdpExxoJ9K+ZeCrPHWmQ/NGcQW+U7GFjuU1XSeL6HNlw7vLP7Voy1td104oWKRdIQX
         V9G96nkHnL8xgML4AJJluAeNxngUdaR0+kpmO38+cWooy0IWKUVvtHO6wFZo9CorkedT
         k2Mam01tEFnotO/jYxphvcW+CBzOxINGLpg67YYskif6t53qeZb7JNeeUHx4DKgPkGZC
         PUVgbunVpF5ZTWcg+6+3l9ktUY+rLN3NYpVLC/ZkcYPx8RVGk6iTq5jk9bOh76kGOVfw
         Yb/3cAj/6fYzGKL3/JM6H4Ps/nKqNj3PG1G5IeLupuKou8G5y5troxfPe3bgveY2mIBA
         PY0A==
X-Gm-Message-State: AOJu0YyUgd+00jYnbsd7UDNZE3Yw5f9KgnmJfoOmyNVCYAc0GEAT43CN
	QQjC+/7AbIJwm2tAbJJjwNnUdQvVYg8vRo+KpSAvjFHb8Thjh+ELQ8h7a3X8bho=
X-Google-Smtp-Source: AGHT+IGElLuW0pejxxSzjHGQKIiadKeePodVWs28Mu6N3Gk1unA001+PaaxJKfTxaqlYpOGSdZ5qPQ==
X-Received: by 2002:a17:90a:ce81:b0:2c9:1012:b323 with SMTP id 98e67ed59e1d1-2dad50cbcf7mr2059551a91.27.1725601658761;
        Thu, 05 Sep 2024 22:47:38 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc02761asm598725a91.14.2024.09.05.22.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:47:38 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:17:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.12
Message-ID: <20240906054735.cbsjpwvpelgukppq@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.12

for you to fetch changes up to 6b612d1bac67b0f483fde7779a45f6310274d4eb:

  cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family (2024-09-04 20:43:59 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.12

- Several OF related cleanups in cpufreq drivers (Rob Herring).

- Enable COMPILE_TEST for ARM drivers (Rob Herrring).

- Introduce quirks for syscon failures and use socinfo to get revision
  for TI cpufreq driver (Dhruva Gole and Nishanth Menon).

- Minor cleanups in amd-pstate driver (Anastasia Belova and Dhananjay
  Ugwekar).

- Minor cleanups for loongson, cpufreq-dt and powernv cpufreq drivers
  (Danila Tikhonov, Huacai Chen, and Liu Jing).

----------------------------------------------------------------
Anastasia Belova (1):
      cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value

Danila Tikhonov (1):
      cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist

Dhananjay Ugwekar (1):
      cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()

Dhruva Gole (1):
      cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family

Huacai Chen (1):
      cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()

Liu Jing (1):
      cpufreq: Fix the cacography in powernv-cpufreq.c

Nishanth Menon (1):
      cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Rob Herring (Arm) (8):
      cpufreq: Use of_property_present()
      cpufreq: spear: Use of_property_for_each_u32() instead of open coding
      cpufreq: qcom: Add explicit io.h include for readl/writel_relaxed
      cpufreq: omap: Drop asm includes
      cpufreq: armada-8k: Avoid excessive stack usage
      cpufreq: Enable COMPILE_TEST on Arm drivers
      cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers
      cpufreq: Fix warning on unused of_device_id tables for !CONFIG_OF

 drivers/cpufreq/Kconfig                |  2 --
 drivers/cpufreq/Kconfig.arm            | 50 ++++++++++++++++++++++++++++++--------------------
 drivers/cpufreq/amd-pstate.c           | 19 ++++++++++++++++---
 drivers/cpufreq/apple-soc-cpufreq.c    |  2 +-
 drivers/cpufreq/armada-8k-cpufreq.c    |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/cpufreq-dt.c           | 11 +++--------
 drivers/cpufreq/loongson3_cpufreq.c    |  2 +-
 drivers/cpufreq/mediatek-cpufreq.c     |  2 +-
 drivers/cpufreq/omap-cpufreq.c         |  3 ---
 drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
 drivers/cpufreq/powernv-cpufreq.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c   |  2 +-
 drivers/cpufreq/spear-cpufreq.c        | 18 +++++++-----------
 drivers/cpufreq/sti-cpufreq.c          |  2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  2 +-
 drivers/cpufreq/ti-cpufreq.c           | 31 ++++++++++++++++++++++++++++---
 18 files changed, 95 insertions(+), 59 deletions(-)

-- 
viresh

