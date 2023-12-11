Return-Path: <linux-pm+bounces-884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C980C717
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 11:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AE21F213AC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC4825774;
	Mon, 11 Dec 2023 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xw+vhX/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD2CF
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 02:49:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3362216835eso498522f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 02:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291740; x=1702896540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWzSZuy+BJY5KdPH9uh7PFjswwXJ15GYr8pE1c5Ls/4=;
        b=Xw+vhX/WDi7xrNZ7c/Eb6T9UGFYZpWL94JlQt7vHEfVeYiqJoDVDVcLarBHbeppUwN
         FxS9EA0pah0nyjTyGu/mVIaobQDK02hd/Zhh8g9EG8puViLfolgYQVrwamf1rV3B8FgY
         O3CS3PKdE+SdzFYa/vyOzrZ+KJRjs/uR3wEMzlvq05koICOvlE3OIty1StmpvRptPm3W
         7smppVUFdxgqG6r+o/s7jLKzdhjw3Od5WYtZjR5lWfEkwucYu6pJHg6lmXw17bSryvNP
         j8YklTnWT6Q8EgoxwLRMbBKMrCRKp3PYib+zrfZ5rW0cRTWo+FRLu5TKHELgG8vn4STd
         HVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291740; x=1702896540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWzSZuy+BJY5KdPH9uh7PFjswwXJ15GYr8pE1c5Ls/4=;
        b=rXJt00O6oX4MheiN/JI7Pu9GAtw0z5QIjZHcwq94rbBhAoUnmfjxl0/J54eLbycufI
         cI7FI5NLcRpnGqHaJKGtM4+qwuQYBBwIANVTdF9ZimNp6zmMtZq4/Hp12nicX64NzXc4
         GztC48oFDAqbx/KGDJl9kRQfCIL5ZznCeHAZl20tJJH5vkyDelTIz40RfLS4nmyP/BEE
         7g7Sz9c+Z3rCA2HHG+dMqsRtmApVKBe2pKOy61tnkWka/HgtTnQldFiNOScoPUS0rwYH
         OIw4pQSuywuov9Q+BBuvHFKp2iZ1kl21+NGvYuSxOYsvJNlH7mR6ZUd5bZcvjcyRw4ch
         5fkg==
X-Gm-Message-State: AOJu0YzONkL368rVfzPADRP8cYYjALG4Otgj1qAR4oU/uSWCfCxniM8j
	a5nbg9d1saoBk6aVsUJb1htRNg==
X-Google-Smtp-Source: AGHT+IEKJ8ZipmsRoGBJMPEX7p5Y8cHuPNamCdUScoQEcaAztSZfnYFJI6KbkQ8H4e5b59Wkt0BG5Q==
X-Received: by 2002:a05:6000:bc6:b0:336:ab9:9659 with SMTP id dm6-20020a0560000bc600b003360ab99659mr2961273wrb.92.1702291740351;
        Mon, 11 Dec 2023 02:49:00 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:48:59 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	viresh.kumar@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	lukasz.luba@arm.com,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: conor.dooley@microchip.com,
	suagrfillet@gmail.com,
	ajones@ventanamicro.com,
	lftan@kernel.org,
	beata.michalska@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 0/7] consolidate and cleanup CPU capacity
Date: Mon, 11 Dec 2023 11:48:48 +0100
Message-Id: <20231211104855.558096-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the 1st part of consolidating how the max compute capacity is
used in the scheduler and how we calculate the frequency for a level of
utilization.

Fix some unconsistancy when computing frequency for an utilization. There
can be a mismatch between energy model and schedutil.

Next step will be to make a difference between the original
max compute capacity of a CPU and what is currently available when
there is a capping applying forever (i.e. seconds or more).

Changes since v6:
- Rebase on tip/sched/core and fix a conflict
- Add tags

Changes since v5:
- Remove useless return in freq_inv_set_max_ratio()
- Add tags

Changes since v4:
- Capitalize the verb in subject
- Remove usless parentheses in cppc_get_dmi_max_khz()
- Use freq_ref pattern everywhere
- Fix MHz / kHz units conversion for cppc_cpufreq
- Move default definition of arch_scale_freq_ref() in
  include/linux/sched/topology.h beside arch_scale_cpu_capacity
  which faces similar default declaration behavior. This location covers
  all cases with arch and CONFIG_* which was not the case with previous
  attempts.

Changes since v3:
- Split patch 5 cpufreq/cppc
- Fix topology_init_cpu_capacity_cppc() 
- Fix init if AMU ratio
- Added some tags

Changes since v2:
- Remove the 1st patch which has been queued in tip
- Rework how to initialize the reference frequency for cppc_cpufreq and
  change topology_init_cpu_capacity_cppc() to also set capacity_ref_freq
- Add a RFC to convert AMU to use arch_scale_freq_ref and move the config
  of the AMU ratio to be done when intializing cpu capacity and
  capacity_ref_freq
- Added some tags

Changes since v1:
- Fix typos
- Added changes in cpufreq to use arch_scale_freq_ref() when calling
  arch_set_freq_scale (patch 3).
- arch_scale_freq_ref() is always defined and returns 0 (as proposed
  by Ionela) when not defined by the arch. This simplifies the code with
  the addition of patch 3.
- Simplify Energy Model which always uses arch_scale_freq_ref(). The
  latter returns 0 when not defined by arch instead of last item of the 
  perf domain. This is not a problem because the function is only defined
  for compilation purpose in this case and we don't care about the
  returned value. (patch 5)
- Added changes in cppc cpufreq to set capacity_ref_freq (patch 6)
- Added reviewed tag for patch 1 which got a minor change but not for
  others as I did some changes which could make previous reviewed tag
  no more relevant.

Vincent Guittot (7):
  topology: Add a new arch_scale_freq_reference
  cpufreq: Use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: Use a fixed reference frequency
  energy_model: Use a fixed reference frequency
  cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
  cpufreq/cppc: Set the frequency used for computing the capacity
  arm64/amu: Use capacity_ref_freq to set AMU ratio

 arch/arm/include/asm/topology.h   |   1 +
 arch/arm64/include/asm/topology.h |   1 +
 arch/arm64/kernel/topology.c      |  26 +++---
 arch/riscv/include/asm/topology.h |   1 +
 drivers/acpi/cppc_acpi.c          | 104 ++++++++++++++++++++++
 drivers/base/arch_topology.c      |  56 ++++++++----
 drivers/cpufreq/cppc_cpufreq.c    | 139 ++++--------------------------
 drivers/cpufreq/cpufreq.c         |   4 +-
 include/acpi/cppc_acpi.h          |   2 +
 include/linux/arch_topology.h     |   8 ++
 include/linux/cpufreq.h           |   1 +
 include/linux/energy_model.h      |   6 +-
 include/linux/sched/topology.h    |   8 ++
 kernel/sched/cpufreq_schedutil.c  |  26 +++++-
 14 files changed, 224 insertions(+), 159 deletions(-)

-- 
2.34.1


