Return-Path: <linux-pm+bounces-8170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750188D04D8
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C56C1F21C9F
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8CF161913;
	Mon, 27 May 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtRw8EjA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6515F309
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819972; cv=none; b=qDxNTtObRS426l/W3XJTn1Cx/trFO0V1Y7Z2UO+asLHGlOSrxL+29RVoH/Bzp9hhvfha3N0eY+hZ5D26URReulfHG8hsA1rRwNzkX4Dm2zTu+qf75cMuKqjfjdzDPi4rSAMNvg87faBef0H9KcEuqu6GzG2aFYbtEprr18qY5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819972; c=relaxed/simple;
	bh=6jcDQSRGQriKta5hxhLanAzBNZ/Jw6OPpaAHgN7aCBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N4QUTP7nktEVfbnKNgUPJXCLNjSHXsIlpQutZU7OF61FCLEBtbG1ZcR7B/2HK5JB0wn1iB1IYD0hBU5Chx3bvX9uaOqTaxHyt650lDDVB1pqpnzSCN2ieGBiinJGTPAyskWIex2pi9dNcSQ70HPa25tdt/H6mB/zBbpKI2mSWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtRw8EjA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e72b8931caso95039851fa.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819969; x=1717424769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4/aOzZ0hsg6Et5+0deJCRjrlcbs+6p+P8Nfmbgr0Wg=;
        b=gtRw8EjAt5T/bRgN18LNqeQyURmvswT2q0HodrTvY2VWqxtHUbIPiBgGCY5XVu3e1b
         HfP1mW5EovML0K4Cah0WGitWs531Xr69eCzCrgUw0p74R11Jb96w1SE7UMQO1Wq6aG3j
         8dDJTEmRxQEwN1kCeOfDolwwWN5NQ13bEBASjNnLkVS5HJsDl3LT/zPg+TZZDLI21EQR
         sNFsMJRaOMndgqPc2WMsMeFvKjluJgakP946ZjJJ8jsMWSwclBju2AZQSUGjcMSC0M2z
         +intT+qaXtMk8H1HO3yf1YASVW+sgEJirAiYAfYdAL4orsYInz5JZIwRH4TOnQVroJHr
         nJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819969; x=1717424769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4/aOzZ0hsg6Et5+0deJCRjrlcbs+6p+P8Nfmbgr0Wg=;
        b=IqDUX2R1W7S/4lJ5HIjlGZzYrtLeqn36SaQFE1RhIPUPPFWmiz1PvLzbwQJGsgWA+w
         PgO2HStlhiUEWtKQtLxJ9m8csOnNrGBHsp5Lwuw59DEkDUsQB3ToM9RsKZ9luAPn+9n7
         EZH781v0KKle1jwcUromFlUfMliC1q7d7jBLrgxe3tWsTTqQ0M+7jHW/RqCwQCErEw5b
         fWUFFSMQpWrHzqm7nz7M0J3vMDyCA6eg2ipJSmV0+YpIY4NgAhZuKkP1pFuOhP2EXkpH
         FAr9src5Bot8JRAVbcOlDIsIsqE8abB/t0gvDxBf0ItzH72T80XZUbTQHOd+CFJjXIQD
         iI8w==
X-Forwarded-Encrypted: i=1; AJvYcCWary2Rn1/0pYpUWF54kHbeU1iCjosKDgp7oP/cIPTOybnHGaZNAG/y8B1lLOF53AbniAswqkBPQCGZw1aYNBS6LOZBj517dsQ=
X-Gm-Message-State: AOJu0YyxmA/gXli8G91m0EnuNDqlBjuP2qBfTQsoDxQE+lDiyou2u+Zk
	B12k4VROAy8QatrcXXcqdobuvGt+opJApgUv/+ow1FkwLv68SvtKG7K57NPFLjY=
X-Google-Smtp-Source: AGHT+IH+Repiz1mD7Jsz8/a6LNVzHuU42Y7XwFI26a4ECpBnmSdsIFpuHAnpFl7oDQPNA9Ib/KtAhg==
X-Received: by 2002:a05:6512:3994:b0:522:2a2c:759e with SMTP id 2adb3069b0e04-5296420479emr6995769e87.6.1716819968484;
        Mon, 27 May 2024 07:26:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:50 +0200
Message-Id: <20240527142557.321610-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates in v2:
	- Rebased and fixed a small issue in genpd, see patch3.
	- Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
	- Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)

The hierarchical PM domain topology and the corresponding domain-idle-states
are currently disabled on a PREEMPT_RT based configuration. The main reason is
because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
genpd and runtime PM can't be use in the atomic idle-path when
selecting/entering an idle-state.

For s2idle/s2ram this is an unnecessary limitation that this series intends to
address. Note that, the support for cpuhotplug is left to future improvements.
More information about this are available in the commit messages.

I have tested this on a Dragonboard 410c.

Kind regards
Ulf Hansson


Ulf Hansson (7):
  pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
  pmdomain: core: Don't hold the genpd-lock when calling
    dev_pm_domain_set()
  pmdomain: core: Use dev_name() instead of kobject_get_path() in
    debugfs
  cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
  cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
  cpuidle: psci: Enable the hierarchical topology for s2ram on
    PREEMPT_RT
  cpuidle: psci: Enable the hierarchical topology for s2idle on
    PREEMPT_RT

 drivers/cpuidle/cpuidle-psci-domain.c | 10 ++--
 drivers/cpuidle/cpuidle-psci.c        | 26 ++++++----
 drivers/pmdomain/core.c               | 75 +++++++++++++++++++--------
 include/linux/pm_domain.h             |  5 +-
 4 files changed, 80 insertions(+), 36 deletions(-)

-- 
2.34.1


