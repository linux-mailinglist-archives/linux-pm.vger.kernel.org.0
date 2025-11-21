Return-Path: <linux-pm+bounces-38343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E232C7862D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71D4135C0F4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF443446B8;
	Fri, 21 Nov 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWk0fN6l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02921343D7F
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719421; cv=none; b=MCq8plKKcz5jn8exQaFDX3Sw/L4a1uIkHzVHsIlgn8NRLOM5+nF2AQ/EJnnOwTujgRIeDJi8m7ZXZahA3otfnDpmP4Rl7DuxwCnwy6bYgrj96+H3Da6d7J50z2DMm/tARtq32cDIRjolnp+893k2Yx0So5fkZZ2SZhOMxRqwJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719421; c=relaxed/simple;
	bh=mOf4kBVog9sA1hICLFGwYBqDysi3qNhBd09FOVPhlVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUf/VT0nw7YacgBQPb6xr+BA6dm1mqtcVbO5d9+ID2dcwHpUgukeWn+lM2rQeNQdy6Iz4c8B3AM99rSaaCUfIdCyoscJbT9PYjhr9y1XdnYQ6xUSMHu0sHIbdKbM9hEN/DV4uniPDDyJsA5dQtM3aLaouGXN/39m6v3+9LkDyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWk0fN6l; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37ba781a6c3so15373601fa.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719417; x=1764324217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8xt/SmdW69gjZ5oyd1iu8QrwZFmfySQlNBtr/fytkE=;
        b=mWk0fN6lpAeq0ahhgS25G3naOPmTzHqhjLwYJxobeupwi4F9ywINCugrPoPa1/PKqB
         e2Rirc0iwqKCNyNS8jqwa4QgVhxlV3xcNdMaTQF1mqhqImMJOfn8HfTjQ/9YLJr+tLoy
         MO6CxEnHW30AkGW+9ylqnCYIiR17mo+umNtTSVNxl0H9pMTBwQJNhG8yg058bxaH8sVx
         k6LNU8cZKG9AMpHel6Ntb5b/PRDpJ13faQTUN4a6rbHeNOriwPq+kvf6MHPrPeFv073T
         zpcv5PZpbW4/nGSBQwhGhvkn7gJJdbi0KFBGUsGrRTpWDZMsVz8Sjtw6tU8hL8SmO75O
         2SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719417; x=1764324217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8xt/SmdW69gjZ5oyd1iu8QrwZFmfySQlNBtr/fytkE=;
        b=NKguenr0Fc3PXdVAToX82Ul4nocBMMxs2PsAWbx1YsriyJLNdDkxm3CPCmlB8lTmGK
         P89u+HOe3uiBwTchXkGYbJ4puE4ikICIhJqtNImSB84jQL8kcE9apJYxAcyToZ2GYRhJ
         y6oAeJdUrx3g9eEpRXyCUjyn+w+v3Fphc4b6OWJ9Hy4X3fQaYwEp4c7Gze/Ff5bDwg0w
         r5Di2QV3XeV2RzKtf/zQFKOFBkA6NTdLFGT3M0MaFgSZOoKEdCn1Kwt4jZClSJ+643Lf
         BPlseytF+PzlTXkEOFT9mkgNU0NOO7vNf1lFyLDZQBNsBuk2RpxV71LKEBLHqbrFAQhM
         UH7A==
X-Forwarded-Encrypted: i=1; AJvYcCWwDiR7FPDkKYaVL6DRvZABRkBaO8i/cWLaOC4sa4F7wQwGgRiz8di6NParuWDrNupxT/3arYdZ0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NTjuq8DDHOCHXp6Jo8/gqOovma/xVN3lkGvii3MSwes0MswN
	h3Smno0mYmA8jbWHetygB0pGwULqcy4Vd9kXj9QRXLfizF3VoExCtDeURnEraG2mkFU=
X-Gm-Gg: ASbGncseLR7pSdGunLYjmLckqoye6cyv+svqU1XQNM8dEZ9PTLGZqitOFogUky6MZBJ
	9ySp5GdEWFBvxB7Mfik035vsYfnjAsh74GIDwvrg26wo1GeIEejH7zDw9g4OYoHS+S43syTji3W
	+h+eQtedVclySSgng41Jr+xTT76DrhEdcxdehOa5bsCZnp53gzHoU86Klk5SdNphVJMY59aK7sm
	o460QWufnXfuP2qQCK9S4//pv293/89NNvIhm5ZSsv3LlbXLx2mls9Woahwjxl1gxsSqrFWIxrc
	ETAQv4EkqsikvVhUFm/Pt6CCNsNCaJsUMfFUKqrmAAMYLWmF4HHu7oQVlOgyUoeY3BTHUCHnAgE
	g77ZJ+yTCL1a09NkGH7mGOn1KuRKjpO3kzZxsX5MvyF/T4J7vfT720Pf/P7whcaqlRcK4j4byNG
	aa+y4mOFZw5TTS+bPsLBzPhe46sLsYxUZ+FiBaASng4/bZiQZhCjAoJo/BC8Wa
X-Google-Smtp-Source: AGHT+IF18rU/BlLdKKiApoQrVGDqv9MGBmJtQ+0fBil0AZdNAqhxlfsgsrWjuuKJ0Iw0oHCthn2orA==
X-Received: by 2002:a2e:83c7:0:b0:378:e437:9085 with SMTP id 38308e7fff4ca-37cd9284a9fmr4146841fa.37.1763719416973;
        Fri, 21 Nov 2025 02:03:36 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:36 -0800 (PST)
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
Subject: [PATCH v3 0/6] PM: QoS: Introduce a CPU system wakeup QoS limit for s2idle
Date: Fri, 21 Nov 2025 11:03:06 +0100
Message-ID: <20251121100315.316300-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/power/Kconfig                     |   4 +
 kernel/power/qos.c                       | 106 +++++++++++++++++++++++
 kernel/sched/idle.c                      |  12 +--
 12 files changed, 196 insertions(+), 19 deletions(-)

-- 
2.43.0


