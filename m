Return-Path: <linux-pm+bounces-37176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A27C24AB5
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B394E1FFB
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88633A01A;
	Fri, 31 Oct 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXxcp+QI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC61E9919
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908477; cv=none; b=N99G8+vOd4rVqFeTtr4QPQYj7EFJgHVhA89ON8ta4cGS1pfsacdIyZEKNyiap8GALuoBrwrcxiqaUiUh5At+OyhdYkp50gBiOMv6MtlMGemxozCgVyz4EaEZ1rk8VRRH1hq2dGOFX5hvQhNVwq64y7TOj+QeAGrXmkUc4291FMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908477; c=relaxed/simple;
	bh=Id79NlrVdiY7C3LNpK6PG+FaIrEAYaIenAK8fKOPAWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIQrRQjNSd9/BbkqxZt6P8qOU9zRr9cghN43OuqJKsWgkRstw1GLZvTRwenYrsYJU90BDyTrtIvENUFvauyqq0aMvNdY79kybk4CTbFQHMI+aI4muApk29kck+fpHPPd3oZmOvL/o2Thic3Y5p2yWQVh+lQRGpPs/mYLkCs7b8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXxcp+QI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso4721803e87.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761908473; x=1762513273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MelVgbYmu2c9trVYIc+BMDKKDqiiaRVkA5YIS13CkK8=;
        b=yXxcp+QI1Wdc9d8xiY6USzCM451Z9Tf4N53w7WnwecQPwAt7xWOhC4lOYAFe15t/WU
         /6mxQcY0XMIdTXi6eyvQscnRe+lBRtbMegqzKsjytuTkVVa3wSH1uR3UtH/kK8Nq6lBR
         xciS0o7n79ureTqA4e8T9QjP8sMJVaXBFVa6Ht7x3sGR+KKoBCvb+sZRsjMJFUEbFZfU
         7ojlyfGcbJTakCvnUj9YumhYX/lRdbKbXFqofeuS/JIZJmUxKru9+vsX5GMWyM8PpUUG
         7vjOMaTRiEohL2kM7s/neDmP6x9wOchhN4E/Uq9hXMAWKM1xRb/limmmMezeU+mQZreV
         tpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908473; x=1762513273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MelVgbYmu2c9trVYIc+BMDKKDqiiaRVkA5YIS13CkK8=;
        b=NZNmSeDNx6cr2mlya9MaLL8j1YmxdMiUGVTOzzkgI5BBAD8zSXSQyJPow56JXz89f9
         lEvOCcxK9mnIn37fn3yXSXISyMFHwE4mT+tjEvMfOQU8mWSq2xrLwbP5QAcpf2QVNtgO
         vepyrwO8OlZL/ZAJ9CIRLpFpGKDk0HtRQbkznj2iSL8dBAuA5+xbBuzLbX7keRVmfowF
         Ey7stzMLIEzx18wCDOQmN88Prds4Zry7Mkwl/Q4+mFPgulTU8pJttLSb6Z/xtsV6Oyok
         a5cGFK6D9kLl3jEVqxrMl+gx4feHrDKYmnezmPalSPd/hhKtPeWNImWbJol50//CQCQD
         eSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUsCa/j72j9UGd8HPaDoQCTMuY67TUVVfBYr8RE4F+y45XJbidYvHSjNjw9IUVQj+aayrZW+OVTsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOWLwePEjJWY9fSZaEvmfntO/fIqxV48VsO69ofJcTZmk7/Gb
	unjXLBufe0vBN5SYGTowilSbH0euHSKS2CLHwcLDXPM/wL25kOaeL2I98xCpO2XgBTA=
X-Gm-Gg: ASbGncublpLrQ8MTC7Lexoc4YSfFlKu2njcIzR8D2cFoKVIqs/pFaNbOjoroJ2lzeQP
	buOBfCuaiQPV5k7ohp21mwiBkKJCVFtEN8mAnaLa+drRT04TEDaoLhVdhYLRsazwwbjYHCpIe8J
	Ifypwy8bksAZH04ZXJgYm3gMqEOMSLSZ9XMf/KSf1EMOhv8T9D/kpMe6nbssxRNcDA/Lx8QY90d
	KMWN+kHj0SIkwexJXec8AyrbQkMNAjPfwqDrcKrUNiJdukf9RLcQo1btpUH0qRG2DWU6ZBK+c/e
	aVPStYQ2WreXjo/BPaxVF6kTBZGwXRe3ojxHE6Uj8SnSFNwg2Eh/mYZTDRLxMdO8OMt+Z9RgL+N
	mp8Inc8Ni0wrHY0L+N1kLvwRdYerVKP2TIQlG/CtaaatFEUmSf4g9twNpSFv4vnuOcGPsXEkEYe
	QpHFzF+mP7ji4Ls2Z7LjvcYFMLzVpcDhVD6+GZKxEYhWs91TI26g==
X-Google-Smtp-Source: AGHT+IHsT/nk3uXbNF1LOs+Zv/A3vY5tGk3m+upNiz408h90WHKfJVouc2BIcKO7ZcdEjqacd3XBlw==
X-Received: by 2002:ac2:4e11:0:b0:594:1a8a:3858 with SMTP id 2adb3069b0e04-5941a8a3a2dmr1796839e87.4.1761908472127;
        Fri, 31 Oct 2025 04:01:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bbaa9sm432721e87.77.2025.10.31.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:01:11 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 0/2] pmdomain: Improve idle state selection for CPUs
Date: Fri, 31 Oct 2025 12:00:56 +0100
Message-ID: <20251031110106.62394-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms using the genpd governor for CPUs are relying on it to find the most
optimal idle state for a group of CPUs. Although, observations tells us that
there are some significant improvement that can be made around this.

These improvement are based upon allowing us to take pending IPIs into account
for the group of CPUs that the genpd governor is in control of. If there is
pending IPI for any of these CPUs, we should not request an idle state that
affects the group, but rather pick a shallower state that affects only the CPU.

More details are available in the commit messages for each patch.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  smp: Introduce a helper function to check for pending IPIs
  pmdomain: Extend the genpd governor for CPUs to account for IPIs

 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 include/linux/smp.h         |  5 +++++
 kernel/smp.c                | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.43.0


