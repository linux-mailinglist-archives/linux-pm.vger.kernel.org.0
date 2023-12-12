Return-Path: <linux-pm+bounces-977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687C80EEB3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEF11F211CF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B77318C;
	Tue, 12 Dec 2023 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="md5jkMNp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E6CD
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 06:27:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf69afa99so7349247e87.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 06:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702391256; x=1702996056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oi89GvlAHEHZg03UHqAC2QcBZtFXzQljGaUkYEpdYRQ=;
        b=md5jkMNpMSFt0c3//Hc+vHwemgL/u0RoKjbdEOW9c9g9HkXXfDVf25KBq1h9ZttbHI
         vkDq6Z+nLffOYg3cJj5Kb7hCDiXC1H32oLVT482XNQy93E85ylok1FNSfdrDRQlUff95
         rlKB5XLlIDlpuQ9LnW0Hnu0P75HO0LNid3m3AN+TF2EWuIHZeHu/IyX9ic/00lumnlVf
         VHencOhvLRD5KDGeDhrpsSRQH7zbvRBUsD+9Wdy344RnqhCZpv0ZV4W2PTnelSheSTHw
         irCQVNW+61s7TyEIesbvHcSZQyE6I4m7Pv/Hnz441BTHUhOkjKHMLdiI3o5YQ96uaAed
         OFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391256; x=1702996056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oi89GvlAHEHZg03UHqAC2QcBZtFXzQljGaUkYEpdYRQ=;
        b=UkhG47LjNRfLoi4UmFwF5XSicRZNTmvxL8SQU07Wi1Uhe7S3kFSJxOiFoM/Gn2fvpw
         RkTp/k8V1DDOX9VXBPP/tRpsF8MeV5X9+14BQV0DtZI99XzXQZf1f1nXwgUSry7OSsSJ
         nlssYs4ugXxvklN/Lk4oAGaDnS7KK+77W3lO21gIOYgj2SKmIUZa9ZNbjSVE1we12dUS
         6nyhAYYesCiUpM6LbedV2qhAbk23end3ue8yESLUbLrOPTzH+xzYAvUKmPZLNvf4lssX
         KHXbZrPOb3qT0lYN5ltVhTUy3SqnmbEs2ZIdCb2MgaA+fqc214p/CqzC9wjfIxPTj2V2
         HWTw==
X-Gm-Message-State: AOJu0Yw6niu9wCIdLQV4Di4b5vJXmyqVq8oHHfeEjCtTHq+clgXRz9nF
	kc7QDAOmz+Jx4eEg1RujbTVR7g==
X-Google-Smtp-Source: AGHT+IHyo1axms+ckhodl2KbZ/1My7NcqxxzmO0EEcz3ZK+X3IOJxW78U3l56AhQYBvpEUAbefnwcQ==
X-Received: by 2002:a05:6512:a8c:b0:50b:f84b:9b0f with SMTP id m12-20020a0565120a8c00b0050bf84b9b0fmr4113837lfu.25.1702391256066;
        Tue, 12 Dec 2023 06:27:36 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a004:6e24:43ee:dd81])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm9078291wmb.46.2023.12.12.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:35 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5] Rework system pressure interface to the scheduler
Date: Tue, 12 Dec 2023 15:27:26 +0100
Message-Id: <20231212142730.998913-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the consolidation and cleanup of CPU capacity in [1], this serie
reworks how the scheduler gets the pressures on CPUs. We need to take into
account all pressures applied by cpufreq on the compute capacity of a CPU
for dozens of ms or more and not only cpufreq cooling device or HW
mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
- one from cpufreq and freq_qos
- one from HW high freq mitigiation.

The next step will be to add a dedicated interface for long standing
capping of the CPU capacity (i.e. for seconds or more) like the
scaling_max_freq of cpufreq sysfs. The latter is already taken into
account by this serie but as a temporary pressure which is not always the
best choice when we know that it will happen for seconds or more.

[1] https://lore.kernel.org/lkml/20231211104855.558096-1-vincent.guittot@linaro.org/

Vincent Guittot (4):
  cpufreq: Add a cpufreq pressure feedback for the scheduler
  sched: Take cpufreq feedback into account
  thermal/cpufreq: Remove arch_update_thermal_pressure()
  sched: Rename arch_update_thermal_pressure into
    arch_update_hw_pressure

 arch/arm/include/asm/topology.h               |  6 +--
 arch/arm64/include/asm/topology.h             |  6 +--
 drivers/base/arch_topology.c                  | 26 ++++-----
 drivers/cpufreq/cpufreq.c                     | 48 +++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +-
 drivers/thermal/cpufreq_cooling.c             |  3 --
 include/linux/arch_topology.h                 |  8 +--
 include/linux/cpufreq.h                       | 10 ++++
 include/linux/sched/topology.h                |  8 +--
 .../{thermal_pressure.h => hw_pressure.h}     | 14 ++---
 include/trace/events/sched.h                  |  2 +-
 init/Kconfig                                  | 12 ++---
 kernel/sched/core.c                           |  8 +--
 kernel/sched/fair.c                           | 53 ++++++++++---------
 kernel/sched/pelt.c                           | 18 +++----
 kernel/sched/pelt.h                           | 16 +++---
 kernel/sched/sched.h                          |  4 +-
 17 files changed, 152 insertions(+), 94 deletions(-)
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)

-- 
2.34.1
 

