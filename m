Return-Path: <linux-pm+bounces-19902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908819FF97B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 13:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A80A3A30EA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1BF195B33;
	Thu,  2 Jan 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLCmqL3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507654431
	for <linux-pm@vger.kernel.org>; Thu,  2 Jan 2025 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735822079; cv=none; b=rKVBoGuTHUZth9rEkFJMAl9LeXwi/zmdBvklxGPpN6Vrwb9UA2TaM8kAvwfkqNvJyx1ASAMXWVIpSLN7eo0yTKOCtWwxc4fACBHEltnJTdOXl34+NWogoeH6Rmc4o7X2UAQ0CddCZBL4+ZcDINzk4VBdydhgWHZysD+A8KFfqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735822079; c=relaxed/simple;
	bh=GrAq73/L407yMj1vo2ni3/vYnlr8zbcdLF5JsHwBMbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVU5KP8T6xB5lO7j9yruazvyZjj7dwYc6iUEMGJAugEEkxO6gMgdiZAZidr721EXJ8Hui4Ie2pygg8lrjl7d0u0JBbwJdGmo0Hy3lJdo2Zz3jJwjnvpEi6Bk1Hx5lADI3BOu+oi8kT5d6bUp3SbMI8dmXOBVjOPTfS8ZgoLnSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLCmqL3p; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53f757134cdso12456013e87.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2025 04:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735822075; x=1736426875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87IKF3c9HbECtsPTMeRuQc+tjYDzspetfXzHHwU8By8=;
        b=tLCmqL3pNY+erBVzj6IAlrznR2wLYfXiyLaqhAv2eoiYjMhFqAOofhirSdUq6BSMgr
         z0NPqgg20A6qmIAgyy/Q8HK7YXD9jvLXQl1a3cIjksXAU4eVnY0Rnb+mDRJj6q/vDtxu
         KsiymcInGl+IZzcKnZP1VCanHlSJertM3Z3/LtDnwWhpBgiX4t1fngOJZidyN/OR2S+7
         4yFN7VhAHs5iY97Pz5FG4CtXrE1DXi7TzqUG2n2DdUAidGVSyrRPY+0spKdE05Bkq97S
         r9wtvWHt9BcEgJFYtGzR4T+5lewQQthsoxNBGmbaTWMyf+asDWDWt/3qBi3+l29cFrVs
         jsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735822075; x=1736426875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87IKF3c9HbECtsPTMeRuQc+tjYDzspetfXzHHwU8By8=;
        b=lGYdOEvLidFe4ZraeyH0S0ghY6d5y93zBZSIpGpRFQLKh/UkZAFt1k0ILbs4Ub0Fec
         xuNZFYyDxBVf1DKYRDuPS5AhQWvJC7+rZyKe76YgArni+z9gKYpubE5ngv7myVhjPWWm
         1c+3IS37B3LRwcq6S/CrxdyzVILUU4AAlzbihIRT4OYgrmtT1vg3/5Xb4b5VOpfk/yuN
         if374R4/3Zm23fvv6m4MuXLorwdpUxt0p5a9arOuSrmYsJSJM0wRqnY9dToHK1phWg74
         dx24X0hwp1ziqt0zy49mqt8tHFrlkZhhiCs6m74PlMkiDkAz9DSzLcW8rslKezpPHmk2
         SaPw==
X-Forwarded-Encrypted: i=1; AJvYcCX88rZe2J/Rl+m2JNEB7IKrnLs19LR9cO37tBdYi1OX3/0TdcuIp7JX+2hdX2Ph3MIeHSK8gqgZsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpQPCzxvyUFEdA0Safm6JyEqjvMv6L01/FORWD7ZQPy+gdypn
	oxRhtSbwak0vUTw55jEEKjqoDYl9XsPtpySVZx5nHup1I4TXhJZ7eC8ftM+ivpE=
X-Gm-Gg: ASbGncu7uuIFdITaiUEn8eMVwUsMWfnb1r8kVzViQxAgcNqUOjBuC5aQ0CUkSBo/ZyT
	BMiaSfEC1rsG4ThHmqbic5mAL69LnAadjBKH7z6lsfPt5v0TXvycO+I/Hf7OTtb/Sqs4Fa5UNW5
	p11OZVG6HHmq+1PUgheOTYt9WnNhAiwTr8V1h8H8v5L4DSKvyj+5uI+kdg8PWRx5Cmm6sKsUqZC
	ZAA/N/a0C+uWx7I3y2PKLHbVziJKeqm0NrtsdnExjL3YOU5pRI03dyuAhNx7KJDNMYllRE40aqC
	rP44/v5JpZR8lT4vOEb8aWc8IJ5+LVk=
X-Google-Smtp-Source: AGHT+IHSR/Xqw+zKVilPbS18SxVhML7NXuysuSNJyvDEen1lNQEfTHRrM46D8RL3KMyIttSdLTLqLA==
X-Received: by 2002:a05:6512:e8c:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-5422953fedcmr15859594e87.31.1735822075431;
        Thu, 02 Jan 2025 04:47:55 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238217f9sm3817314e87.211.2025.01.02.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 04:47:54 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.13-rc6
Date: Thu,  2 Jan 2025 13:47:53 +0100
Message-ID: <20250102124753.50440-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes intended for v6.13-rc6. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc2

for you to fetch changes up to f64f610ec6ab59dd0391b03842cea3a4cd8ee34f:

  pmdomain: core: add dummy release function to genpd device (2024-12-19 15:47:02 +0100)

----------------------------------------------------------------
pmdomain core:
 - Silence warning by adding a dummy release function

pmdomain providers:
 - imx: Fix an OF node reference leak in imx_gpcv2_probe()

----------------------------------------------------------------
Joe Hattori (1):
      pmdomain: imx: gpcv2: fix an OF node reference leak in imx_gpcv2_probe()

Lucas Stach (1):
      pmdomain: core: add dummy release function to genpd device

 drivers/pmdomain/core.c      | 6 ++++++
 drivers/pmdomain/imx/gpcv2.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

