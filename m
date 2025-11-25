Return-Path: <linux-pm+bounces-38562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC4C84B98
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2663A1D6E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8899313527;
	Tue, 25 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKEB0Gpu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B12EAB83
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070017; cv=none; b=XMvQYNnftTNgjeKZlUCaW6GAJ+ULVSYc7xDGhMgDwfHfaMp/YbrtGHp4xzOReLf3/bcNEDtuA8QLQNNuTeTA1oU5lygEOS7yfXJmLqusEqGCMCQYc/xW79IioSp7lDfFNbi+TaApF4vLlwkz6+5JoIX3eOOeU6vdw2MPJjjF27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070017; c=relaxed/simple;
	bh=xW+uwgn5nLCEhc5+K4ee+B5yy/7mQJcQCJVTcHLn2uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwQsQaa+CHv0FE12ULecpBNrKTnAJaVyUH40GcP7pAHfcqgUxr9/r3Ri3YGFVBBpENTi5Zfla0/fby2Rm2KwfnvjZrUNHKYRcFNO7+BNjfNa+OtF8sckwlBNo+vemDlpAohq+zxL7FsCWEIldQbdY5RvOf2JDXnXdG2YhmwLhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oKEB0Gpu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b495ce059so43231571fa.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070014; x=1764674814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+3PVOrRrjbJKjJdSa2Pd3IMznI6Bu8bu6yfjK+kYuw=;
        b=oKEB0GpuextMDit84fIrHijbBVqqGD58H+P7qQDp/3ub9ezm3ACJumX+11NE/cdZ71
         ku0nU3iELZBeYSiQ2V1Cx5Z9ExYzHp94TKLm5Xl4JJ9ic2zwYUjzNyx3VmGLydRq+nYs
         AYIR7teqoB6hnUlriZDhLu2EPEIK2WqtIcYgRusGFnlc84LDQBo4T8SGVzuvuc1R+dUx
         GQ2VheyP03/MLsRAmeeqMS+uHvrjftE6c/JHKqRRpYoAjGzYD9r9RE3rYqDf/Y+u1rUK
         a6pHFvyY54ckQ8NzL1ukeaBRNpDjOeSj3Wc0kOeaOtWE9GF0ppPwacRprlaAnDvYXsO0
         0BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070014; x=1764674814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+3PVOrRrjbJKjJdSa2Pd3IMznI6Bu8bu6yfjK+kYuw=;
        b=LaCsDoxXZE9r3ouHIhCsL3tVACzrIsu7WaG0gxrtASyNox8nhubfJkrYtXWByrFmjZ
         rtLLx0yuy3/U7jtwk7qmo8sN6TOzl0PSiaiQzY4bNkE3VX6ODOeg8nlCaR9ZjKYBcyDk
         NxEAEOLI1ipGnakFy0pGmwO2Gw5q/joCQuATzw9dUwG5U2cYq93hVR1vaGKoiaZ4QVKY
         rpE7+D+Xo8jd959KcPQqAyxfi44jqt9WVyhFLMvQiKDYrflfOfPcWf/xDttfbNVXUsj4
         TDOuitaJO6MoSxAKc1kV+SB30br69lp9LsLDIZmGhlNWDwZrfTaqKNdu7r3WH/DlqaDD
         zTKA==
X-Forwarded-Encrypted: i=1; AJvYcCUi1TykV7zGfDRGmLf3gbvcS/r9PgYlM7Tt4CNOA0bEXuBTu4+6RRygYMawkgyjtJX0iGva6kg2HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxeY03dqLukAV02vW2PJXyq55XfJDl6CVnO7QxlMeOOhFOkZuh
	NXIXJULieFNbkZOAz3Q6zdCTNwzxm/ny+3MihnI9PIOWuOtge/38UZcXDgNM5K8SAuM=
X-Gm-Gg: ASbGncs70BqVWKVhu1kFKj7a7hR3nVPUfyd6ZVhDTTTIcybF1ckZQJ/bx9dNF46s7pd
	CS1U6ctyQVQLSEF1IMwjQqSu9U5E/ZJFSGDdYfpunoImAm4X+MMneTZ0ZphBRNurXd4zy9TCHXB
	opt1U1Ds0o89eWJplyJUSNMZqFe3vEPkgVN2DKFdogerbjremue2rvecu1Edmw39ZIYYxCayS2+
	cqhmVOxNRFBnkDa+Ev1B7/emzaFzXJJjQ1gVzfnCfiziA+JuBPEH1KJTRrFViEdBzsQ28R6v+re
	ym4woKwfCR1hAH5Kyo3PMqdSXGsLRj31+K3U1AIJl0e7DpBfAhyBuA98XkPI28duwJ0g0IyE1ZC
	wJTOl+pjISm0WA6y9YahRAu89pSuJJzc7jZeQFj4mv6hdXmB/iSqwl5I2h/3wuRqNRBTsIF09t/
	3ovxZ+Cq+8qagKr967Jh8u/TwhFDzoF51csN3suOeUce9pVxQ7ePoAL5RDkKKr
X-Google-Smtp-Source: AGHT+IHBId0lWUF9ihM7WgWJwxGdWCRxFu0nQ8B9jrvfOAAVAh1Moxh1xxnB0gF11THRTX6yOlue/A==
X-Received: by 2002:a05:6512:234b:b0:595:7a6c:7dd3 with SMTP id 2adb3069b0e04-596b505991amr896212e87.5.1764070013901;
        Tue, 25 Nov 2025 03:26:53 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:26:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] PM: QoS: Introduce a CPU system wakeup QoS limit for s2idle
Date: Tue, 25 Nov 2025 12:26:41 +0100
Message-ID: <20251125112650.329269-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
	- Add Kconfig help text. (Dhruva)
	- Fixed grammar in documentation patch (Dhruva)
	- Added reviewed/tested-by tags from Dhruva/Kevin. I leave Rafael to add
	his tags when applying.

Changes in v3:
	- Take new the new QoS limit into account for cpuidle too (Rafael).
	- Add a new Kconfig for the new QoS interface (Rafael)
	- Improved the documentation (Dhruva) 
	- Clarified commit messages and added acks.

Changes in v2:
	- Limit the new QoS to CPUs  and make some corresponding renaming of the
	functions along with name of the device node for user space.
	- Make sure we deal with the failure/error path correctly when there are
	no state available for s2idle.
	- Add documentation.

Some platforms supports multiple low power states for CPUs that can be used
when entering system-wide suspend and s2idle in particular. Currently we are
always selecting the deepest possible state for the CPUs, which can break the
system wakeup latency constraint that may be required for a use case.

Therefore, this series suggests to introduce a new interface for user space,
allowing us to specify the CPU system wakeup QoS limit. The QoS limit is then
taken into account when selecting a suitable low power state for s2idle/cpuidle.

Kind regards
Ulf Hansson

Ulf Hansson (6):
  PM: QoS: Introduce a CPU system wakeup QoS limit
  pmdomain: Respect the CPU system wakeup QoS limit for s2idle
  pmdomain: Respect the CPU system wakeup QoS limit for cpuidle
  sched: idle: Respect the CPU system wakeup QoS limit for s2idle
  cpuidle: Respect the CPU system wakeup QoS limit for cpuidle
  Documentation: power/cpuidle: Document the CPU system wakeup latency
    QoS

 Documentation/admin-guide/pm/cpuidle.rst |   9 ++
 Documentation/power/pm_qos_interface.rst |   9 +-
 drivers/cpuidle/cpuidle.c                |  12 +--
 drivers/cpuidle/governor.c               |   4 +
 drivers/pmdomain/core.c                  |  10 ++-
 drivers/pmdomain/governor.c              |  33 ++++++-
 include/linux/cpuidle.h                  |   6 +-
 include/linux/pm_domain.h                |   1 +
 include/linux/pm_qos.h                   |   9 ++
 kernel/power/Kconfig                     |  11 +++
 kernel/power/qos.c                       | 106 +++++++++++++++++++++++
 kernel/sched/idle.c                      |  12 +--
 12 files changed, 203 insertions(+), 19 deletions(-)

-- 
2.43.0


