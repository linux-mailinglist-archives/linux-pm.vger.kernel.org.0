Return-Path: <linux-pm+bounces-31058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D3B0A1FC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50571AA3993
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83EA2D9495;
	Fri, 18 Jul 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWyRi8ud"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54A2D94B3
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838506; cv=none; b=A+WUAkCo+7ghnpdoAp8wsAa8zHJ0w6opowFJtd5WvPzeSZgxCbmr9K5+3m2b06UXL/aWuHYQ+a+XorffK7opx6Qp0ho0F6SoG9c4T2WpWiSlHOueSpw6A68i5Hue14h0sVZ1HUXQtqyd3Pz0r+Mc3n2IhbWcscGiPAOZc7LP2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838506; c=relaxed/simple;
	bh=jQSOqRGmJhKihBmtIppchJQd79WhRv644pHuQe0irRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI6RuFi85e8brpKaySKdqv8M6+aYs9FiGD6LUFwt7Z5dCHDFqwHIln1wHSwnqe+OEAex2p6glQ8BEAj6TWOeM3xWZ8oTLwG0u16tkhu6aBvafWDfBkluI4y9OZqDWz88KNCSWLzlNAz2l0HA4sco3VTVPUBS7UU7x6TO57u+2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWyRi8ud; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55516abe02cso2031923e87.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752838503; x=1753443303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nEPBqEpSBX6wiXaEWzWfHLx60QtO1oMIXeti88dk8Y=;
        b=PWyRi8udcmGyqwBy5X5iNPCV+bkGcTbez3ksra6f8tuteD06Ye2k+TDZps5rhSbabP
         a1owIRk0TvmaxWlQjev+c9pA2RcnPQoA+QW1O9vSxI7dQx3DmNfPSvThoNep+LDDFO6G
         Z60Ru4XBFouhrA/QO1bu9tDH1xkVky327UZpWPPlN/kSRV/sfKmUm/d8xq1Kvqo9e/9g
         3FaapBYhUOkvzoaXsJhPl6EJicH7H5TZJYNzRT0EFRcryBxe8pkMbSfseQA146lFH8ZB
         Mcr5MlRxCVXaV6XRWlU70JFR6lU7Ik14d3SE7By1zLW4F4pp4v3yZxa5AkSp2JIewLM5
         3Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752838503; x=1753443303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nEPBqEpSBX6wiXaEWzWfHLx60QtO1oMIXeti88dk8Y=;
        b=bNY1CIWcpzJ4L1/221a/bsRtbnNxAYXMV4+W2Dn5vKXp1zbyzIQ3E0JWlXw73ZPTqE
         so6DMnCLnEgT546UEo+YLjNi2isGCP6mATwGiAGpgrdg1P3ndfXE2c8UT7jOxwxKyBnx
         3E5RYXeItpfa7H0NVMSd6T3bMh95E9iR5QF3ixgjh8bZNJOXG6OuwJzNIWaqfGtHg/SQ
         UpKiWO8uPWpR4vRGQGIhNAmQei7IAab5I7LM2HxBj8saDKN8QJpWJ+ae5mf33JdYHgqf
         GYDPRpytKE9FtxKEpqNkNLxas1yWIO7g46JtfHVxfu0AuEnuGFBo4eM9Vz3OCT+EGjpN
         f6jA==
X-Forwarded-Encrypted: i=1; AJvYcCX44nmRmjq3m6RcSBIcHk6pcJEFtWM51iMWHi/U1gVMoD1j6MiePRajzDXYMxnM4BfJWoOdFuZfUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVa5YRAtt6mvZBL/F4Qj235IZTy7fY+Y+l9GKcCtVyuYt4It1a
	3+1pOMnKwuoJ9Dh8QGYpHng7NPsRUVTAvn06AS2pA/NALhK5jXJ24/o73tB5QfoL5pA=
X-Gm-Gg: ASbGncudgdZZd9jr78UwJK7geVGZXSZB6Wt5t1rebGXyY+5SC8ra8EVvBcQ3J5YV0Hk
	WcNV1tBE6OVQxpEeMbLDh0GBoXxmu5dvuqhhnmznZon9NqeiQnNnJAjkuSHnIfatjAXiccQ6BA0
	n4VizrG7cLImwVpP4fhKixrqTWo9WSfAxnhBx4iOY7gtyquAKfB3kGpJyhdsMOzhVpc7kdeHrjY
	Yy2aEOo86JyRX/YoOdydtnfHs+8NQFjNZHPSThCrz7fMXcwN7OpNIds1MB3W0fua8KpcJfA7DGK
	9ohorehlTUvmj8Gi2q6e78XMGNXOymug74JjgYXo+NLq4OWYBzFcWYLymMmZNZdKbCwZ2AuAMS0
	f/3380zaQLsQi74mcTLwTqppmucyHLxUwEvHCK+LlCLqj9Y4JpeudLbRUPaHASkxSVpU5UzhN
X-Google-Smtp-Source: AGHT+IG4/1xEJsLz+qOzcVFluQ/WLouAG1pqXqN4pbEVpAjZiEuAyzyQxw+ookED+NDC66AWax4jCQ==
X-Received: by 2002:a05:6512:3411:b0:553:2912:cfdc with SMTP id 2adb3069b0e04-55a28ca499fmr2104268e87.9.1752838502793;
        Fri, 18 Jul 2025 04:35:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9cfb1sm226928e87.45.2025.07.18.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:35:02 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci fixes for v6.16-rc7
Date: Fri, 18 Jul 2025 13:35:01 +0200
Message-ID: <20250718113501.80851-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of fixes for pmdomain and cpuidle-psci intended for
v6.16-rc7. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16-rc2

for you to fetch changes up to 621a88dbfe9006c318a0cafbd12e677ccfe006e7:

  cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y (2025-07-14 13:09:04 +0200)

----------------------------------------------------------------
pmdomain core:
 - Respect CPU latency QoS limit in the genpd governor for CPUs

cpuidle-psci:
 - Fix cpuhotplug support for PREEMPT_RT

----------------------------------------------------------------
Daniel Lezcano (1):
      cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y

Maulik Shah (1):
      pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov

 drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
 drivers/pmdomain/governor.c    | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 13 deletions(-)

