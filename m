Return-Path: <linux-pm+bounces-7281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E967D8B5ADC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63312865FE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC979950;
	Mon, 29 Apr 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5Itbw1P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9A763FC
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399556; cv=none; b=HW0qV98YLULuCIjuJ9faTW+9Ye0/wwxpnALPnFGCq4naAKeKOLE6GYOq5kBB8EJyo0JsQbaNOCehq7Z9jQLJN9KqrTojxn7JglpsuZsiod+25Cb0sybbgtF6J35137rkBNV9iuWkMp7vGnnd09vq2kYrQZOtQfaf25bj+WosjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399556; c=relaxed/simple;
	bh=Uf9ddhEBMCM/OlaEb7CTzNoTY6fpHPR3X42S1b/KeT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKETqlJHIiO5fAuN4TB5kJMpBz2jDeTQX2gUcGLsMTA3snukAEBFo2+ZBO5EoQ931hVIlbExmx9EcmVeU2O+kwvdivYSI9nEGirFLaIMEfr1VDBCNBTlg3RLGIDzO5qRoOS4/ihEuLoFfYeb33ClNBEsueUNDAquFx85YTXTm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5Itbw1P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso34012291fa.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399551; x=1715004351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXJMGZU5gWJajF1DAzW8nc/IcTR1txmF3L1/3ROYhek=;
        b=D5Itbw1P1NBmUpFO10twp0nncx6lGHp36H83ra6rvujpSaPPDKnRhxdAts5LwIMMYr
         SuPBDb97ici9jxQfwgrrqBCXtMpCH+sQQjr6ghCO/NTTlpHB3vtFo8c98Iu13oid4iH8
         94N/17OLYNSLQCYPUGDZO4EkmdQXb9ZNrDgprLQhLzbacgkAIxURc8iLSqmvIdp+OHCZ
         Rh3PD+E3XG6wevU51XUQZ+lLoPDS447axOw81uHXSZt4zH8Kh8N67OuCk31FxyR/Ue9+
         H60kN2QdrYyXij+N8pm6VDf9JkPtQD9CunuV1m2P0Ij9RQf4GA6ES9O3Zi85+vEaWg0h
         aNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399551; x=1715004351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXJMGZU5gWJajF1DAzW8nc/IcTR1txmF3L1/3ROYhek=;
        b=ffsW6dI/sOQRz/ZtnAsHdcrqnQnxsn6EHY2eDGpxAwxuCOPXkYmp3Zn7flVT16R1aO
         t34CWyKfZPIdI6m4aU3OVyvmWzQ2musmqyHEAKjTjfJGK8OfIvA8qVnBJMvknHr+ste4
         DDILfpsZXJdJNG5CykRY89BkkJ0nrwd6e0vKSLW/gFE5r+nu9TlBgr35Q0bQb4nRPMsV
         Rkgq1Ncw4GnmPryDsutZtKEA7KR952syLnjDmj0c1iP1FoNZNJ0WKFKP4/oTKOhyOGM6
         8+YbyR+RyPNwoNkS9OKClIgvqdKbGHRaYRb8E/jlc2hBCRuQ/1D12sNjXdIlCYtmdE00
         AJIA==
X-Forwarded-Encrypted: i=1; AJvYcCXmjS5xCp9t/2oAA3yGaJ1wYGWEEhP46SpPH+11VzsOR6U4JKymR4WgcarQ519nR46VBJx7IZ2gtLcjjIY9bTJuAf285jiLDGU=
X-Gm-Message-State: AOJu0Yxt+EOc7MuKuAhySw/CDMQYfsyVrVBzIPubHGdSSyCeIz/QZTAW
	/sdJutu9PgC43KYmZoo2nxVLNeuUXNJW7FNvXeBpJsBYFpeaTt/+Ud4QPCG7SlA=
X-Google-Smtp-Source: AGHT+IFUjAW34oQS8Y+fnyeVdUbDkDis1iigpkrMI5QToMUOQcc8rZfl2WurAe5k4jfFMqtb5cerlQ==
X-Received: by 2002:a05:651c:2107:b0:2df:dea1:5378 with SMTP id a7-20020a05651c210700b002dfdea15378mr6030267ljq.16.1714399551361;
        Mon, 29 Apr 2024 07:05:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:50 -0700 (PDT)
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
Subject: [PATCH 0/6] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:25 +0200
Message-Id: <20240429140531.210576-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


Ulf Hansson (6):
  pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
  pmdomain: core: Don't hold the genpd-lock when calling
    dev_pm_domain_set()
  cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
  cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
  cpuidle: psci: Enable the hierarchical topology for s2ram on
    PREEMPT_RT
  cpuidle: psci: Enable the hierarchical topology for s2idle on
    PREEMPT_RT

 drivers/cpuidle/cpuidle-psci-domain.c | 10 ++++--
 drivers/cpuidle/cpuidle-psci.c        | 26 +++++++++-----
 drivers/pmdomain/core.c               | 52 +++++++++++++++++++++++++--
 include/linux/pm_domain.h             |  5 ++-
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.34.1


