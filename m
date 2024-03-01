Return-Path: <linux-pm+bounces-4589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6A86DEAF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 10:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201D8287D08
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4D6A8CE;
	Fri,  1 Mar 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esHeHjXV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F836A8B9
	for <linux-pm@vger.kernel.org>; Fri,  1 Mar 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286989; cv=none; b=kDc0No7uHemYjPy+0H+N7wR7QIlo8Iul+OvaSsEc1+wrBv3JINmsjNIfa/2Y3Q1VK7YKhfNSYTCnzv0zp7JdoTadyOcDIsCHgSAGTdaSjFMi/4V1FK91UT5DWlmbOOGmYw64MJWSxYhs5dm1VdFuSCYWkxN4eEGxObiXrz+Y9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286989; c=relaxed/simple;
	bh=18S77KXqW9B4dMKuNYPGTI7+MDToDmytBAg7uEmV2FU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+BBlZd9TFAkE8c5LwCUZCQMlW1oOH3n0tVPSJ96MXq+/O69yvSqDGTWrn/YYTWQ20eYTp6aw1j2H2ita778Zk3QwbSggoiNRXChkQraaI28YGp/rwQHnWH4VZr/ADx992SokW1MNGvLS84KQoW4m+6lE4WdLhfnVef5MpRaqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=esHeHjXV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d28051376eso22635051fa.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Mar 2024 01:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709286985; x=1709891785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VkH3dZexrgeoLVbHTxNag0IKuqLj3ZDSeXVaWdmYMB4=;
        b=esHeHjXVLkxuYULK8vcdvXvxv2F7/hzg5RBmX1JLSxBVcAmA2Cl1OPbmI4CHuHPtyr
         lPAA7z6ovWbw9ny8umQidO3VKizxq5pL9GfcJDPZr2NcATOThAEI0V1GZ1N+9sToom65
         SdFR0bKoVVnNKxxBS/k0csn7MNnrn0eRkJsEUApNAL/bivCxpM0bn6lSeCZWUt8SsZG4
         142ST2RwUzbh0HKcmKJA7pEiKfEJaUXwJWDPmmMei0bwoVxf/CsXvzgEn39x4tZA5tuJ
         jeyLXgIX+RNlftDkQe+PzLR+8qkWLQSydMcpibOnrtv9fENuFxsMgV3z566tCTePPavL
         rk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709286985; x=1709891785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkH3dZexrgeoLVbHTxNag0IKuqLj3ZDSeXVaWdmYMB4=;
        b=upsvBlLWpcWfhAZ6dCdfHiDKIjWC2ZL5H3oXzBNzxUcbfQb/jsuu3qmjwcPInhclxL
         DAsZpOwcGHY+OiFyA9/R6odyWnrsL9H1Juj4DuNg+dUbHMKahhwYAX7RYuGG3r5XuYXg
         lX8xRuxH445A/UJQpcc+0FgrPmoUFI9pMZgoA0AzW+feG/v2IazScbJqcy+r5zHX0CpX
         O9vUPz4iplNVwSeOEkdJQX2PDFaJOv9xoeafQEAh2zrEb9juOqOPczzc6hRKeH5SqaD3
         2m43ajXAW/V9UFCJOzPUVgqxl4qoSOes5IeS6ggibRfDlUO9SzfEAFrFsJTwr1tRqi14
         mnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ur+X3xz4YjFwk0yiVMVAQGBiGW0AcUq7buruR1ULB3dlW3ikcwUM4Lq4Dn5ijVUuY28ovQFHjbZcNqXaagHg2MKI0eYUSic=
X-Gm-Message-State: AOJu0YxMUtwwbjEeoxpA0G5giFdMw3xKEBciY8vkff1POtDHQqJMMew8
	Pg61gd+8kWhnrdZt97M8LUgA/aAvAyMERZ7dFgyXuGFx0hrrGJy7TRY8xVmOwdA=
X-Google-Smtp-Source: AGHT+IF5nLUsEK/GcU+i4clsC9SpRItPO0y27bMdAQSTFmJjQXi6Pjl+T6nj+mStxcIQL7zVO61Bzw==
X-Received: by 2002:a2e:808d:0:b0:2d2:a8b3:a20e with SMTP id i13-20020a2e808d000000b002d2a8b3a20emr765752ljg.53.1709286985354;
        Fri, 01 Mar 2024 01:56:25 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id b22-20020a2e9896000000b002d2607e6d29sm530333ljj.70.2024.03.01.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:56:24 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.8-rc7
Date: Fri,  1 Mar 2024 10:56:23 +0100
Message-Id: <20240301095623.3659989-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes intended for v6.8-rc7. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8-rc4

for you to fetch changes up to 2a93c6cbd5a703d44c414a3c3945a87ce11430ba:

  pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation (2024-02-28 16:31:45 +0100)

----------------------------------------------------------------
Providers:
 - qcom: Fix enabled_corner aggregation for rpmhpd
 - arm: Fix NULL dereference on scmi_perf_domain removal

----------------------------------------------------------------
Bjorn Andersson (1):
      pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Cristian Marussi (1):
      pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal

 drivers/pmdomain/arm/scmi_perf_domain.c | 3 +++
 drivers/pmdomain/qcom/rpmhpd.c          | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

