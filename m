Return-Path: <linux-pm+bounces-27533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2EAC16EB
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 00:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C85E172F05
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DA281539;
	Thu, 22 May 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fueoYtN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E327FD6C
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953528; cv=none; b=V+S4nN8qm7M2tAOxaxv06LplXEPqZnDKqhhoGtrtS5EZh6o1okV6x7VY1E/61wtecOwKCd/CBuclPxu7kWL+afHNeAinsODdtwL1Hgik9Dh8PawW2BHst7n/B56lhIbRRh4VfIVgM+WQK30JMdM35FJ1OypFCfG9UlHbH6OxRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953528; c=relaxed/simple;
	bh=a3PRYd3Cjo/rv/itdwXNTrt3wKQ+asO4RWYKiV1N2rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FF7nIaoJeRXYm9aUDf43X/62tVbncZQjUZdAoF45NAxr09Tvo2MpUBixFhj6qusyLyHD66oKxXMthc6qbBt9x7HJwJ/Qp23/gReIGVt7s2MHOYxnuTFj0LBcUFtMaaYGlw9EL7cjm04wxNpk+oBesmr+xHQ3uxoAk4yTwWRP6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fueoYtN9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-551eb17123cso8196643e87.1
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747953525; x=1748558325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=162PHkNGgQO3PjVXfDykPBsa+evqNxguX1rebBysG+k=;
        b=fueoYtN99VdT8GS7lnPa/Y0Rff8e47AURXcWXbGA+sMzcHNjjnpgdUUdYbsgLgpYpv
         w1i543W6bAvN4nMKtZ+UAisGNAWd1Ztx4Aap5yCHVy6Saa/LC34W+KzfP+DDKjX4y96O
         wT19r/qc7sfr3gxqJhj6axitATH9uUPpdb2EyCmPCStIz9OD2XIkEDwYbb/pmTgZo11c
         5YQdEnqejgcSrn7WHpeQQcpytGy1vUdSB43nEnNY7tBpEoVfQuONEbWDJVLzOplpjpz0
         vIwUnDzmLa/2lMfSd6oytD/kmRE8I9UGwHMeYLDiKmDCJYuY38szAThfm7Ix9Cj+qmgk
         uRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747953525; x=1748558325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=162PHkNGgQO3PjVXfDykPBsa+evqNxguX1rebBysG+k=;
        b=S09MgvRBBPJkkMps3Pq8pohaP7hVSNMLjODWX2M9Bo17bbAq7su+VORK3gbQAXpGqB
         nIhOKWJBHYUt6/tpv2QGnO5su049oNdmJe7Pd6Y2IT6dLThGHsNFVMkoAFOd9bYi8HIs
         BFcD3nhzANcaJ0hyBH7E8ZEWrNmBTE2SBF32R18EQwKEhNeoDbCCrUT6lwiQOBBFWdh3
         a2P0JyJeNcbMNLc9oD7tqYMGOUQRnvmoYrmpNc7RNWpT2j9oaw49/oijSY7STXq4okDB
         6WdKEMoxSBywv9Y8BZFLGjwhbPFu8O//v1k3uDIvwOmFLmZGshK+0muTgLdnmMxQZ7Na
         PaRA==
X-Forwarded-Encrypted: i=1; AJvYcCWUZQZn6odUOOAAOSi7OiVIIG82nVFeC/Y5gT83g4fGUYJQBGa+HAVFklIs9INWtBMOwVX+1fTA1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRAHHn8YBu5DBgFnIddcZ6akWBi3fM6gj5tr82zYTJtH7PEMF
	x1OAgUrQ5Y+VTV1UK73VFLOBJHa1bONVKjPNKLHQT1qcShrU80YaLeui3AnwhzKN060=
X-Gm-Gg: ASbGncsd7ECv+YmSLQvyRPt12PNSkaf6c75c0w+wkyOBzO6RW+kcwzZ739Shvz2XkW8
	pa7lViZ7mbZjzS0ny/hXhLruEubcW7D96+J2zGrabGDGzdtwl/ZXJSvUCiwSL5QpUPdAC89g7UC
	m/3Q3KgLWoyTi4QCrbcyLAPg3BeWg03UyJOzMJW6zyrb4ShhTs7xQ+Md9r/M3jf2XktkltCVk8S
	Od/ryMaZNqF8f4DvBm2XXKg6QibsQjDzkl2q3ImRaDqNvaZ2mlZkZMYOIhDuQdeE7TkICYyTTV5
	XwCZXsPhTkjCW16bFKN3U4+aHWtBOPSYewdw4cqvZ/fU2IGE4ziFIcRJ4aJofUTdDEeNEfeOtGd
	TtkN1SUNAIlIeWHJ9ZJfMz43lHw==
X-Google-Smtp-Source: AGHT+IHpKvG7QTF5JMFQRfjxHS1e4Hh60oqpoUmBhfN3NuDv06qvqDXaNXWN+vdIaPYvt1ahDgUnfA==
X-Received: by 2002:a05:6512:22d4:b0:550:f012:966 with SMTP id 2adb3069b0e04-550f0120ce6mr5060108e87.39.1747953524641;
        Thu, 22 May 2025 15:38:44 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328084c8c78sm33932571fa.36.2025.05.22.15.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:38:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.15-rc8
Date: Fri, 23 May 2025 00:38:43 +0200
Message-ID: <20250522223843.171621-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes intended for v6.15-rc8. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9c32cda43eb78f78c73aee4aa344b777714e259b:

  Linux 6.15-rc3 (2025-04-20 13:43:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.15-rc3

for you to fetch changes up to 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe:

  pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id() (2025-05-08 13:29:30 +0200)

----------------------------------------------------------------
pmdomain core:
 - Fix error checking in genpd_dev_pm_attach_by_id()

pmdomain providers:
 - renesas: Remove obsolete nullify checks for rcar domains

----------------------------------------------------------------
Dan Carpenter (1):
      pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()

Geert Uytterhoeven (1):
      pmdomain: renesas: rcar: Remove obsolete nullify checks

 drivers/pmdomain/core.c                   | 2 +-
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 5 -----
 drivers/pmdomain/renesas/rcar-sysc.c      | 5 -----
 3 files changed, 1 insertion(+), 11 deletions(-)

