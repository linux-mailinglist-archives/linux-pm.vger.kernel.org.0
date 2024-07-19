Return-Path: <linux-pm+bounces-11250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6A9375BE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD762826EB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334607F487;
	Fri, 19 Jul 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="erHejICu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1C78291
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381785; cv=none; b=mpCIXRksVxVZrNA7kU06G278jCL25Yd/Y79sPt5a0Kr+UBH6d+npOZIQUDUlV3eJSiRXpH2yyQywAcZF2tefDIqJGYbsOpwZNIO7tgBXGKlH3Z+8gzBpFtwSYPZbfPCHEWu4EgYrzRddRCLXOXoGTzqtrdj1f6ncmjNAozN7rhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381785; c=relaxed/simple;
	bh=tdk84TAQOJyGZ8fYKBiIUqc9KGVWzsHWO1h34z466G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goni4qvrvNGmT6uCygl9sTT0+VYRHwmq5RNZlKMI+qBj3q03gIrWosYzSwXYgtCCdxeIhvNSW1np8xC0PDoKkUa4QO7ka3P/sQlJx2UgJvooo4t10SQLmJ5KjeD1HEkrQ+Bwfrm0NBnhFqoP2xCRNZH5TWaaO+QaJvMqpKU6CLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=erHejICu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36799fb93baso541703f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721381782; x=1721986582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdgwK3eQK6TzCDKCXBvtv5JzZ8fbzZuuyV7JfbDIf/M=;
        b=erHejICu9e3IC7cBXI/vph46SIamCBIMZadTaLFIWr7GquL6xgCLlTvohB667TVTQA
         by97iSZ6jrvvochPDK8FWVNSSoWkVQSnQGygk2U1eeNw1LEDJpqCwzalXhN00i8HLYU9
         35Yrf5yckgdulB3wAXFD3jRRh8bd057caEVcA+en7xsW3aZTLhZVlrL5rqJSbe8IALQn
         foGuqAoT05EFuc3lxKICNTwofzNa7Gb2A7DzamXfMyf1jJTrEhDcgxzH97xRoR1+wsQW
         diAhofKD4sYiqRhIffcazj9CVGrJ+JyrNBcT/H70oOEXKvyVUSI8s/rh9MAiK4oumSzF
         DJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381782; x=1721986582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdgwK3eQK6TzCDKCXBvtv5JzZ8fbzZuuyV7JfbDIf/M=;
        b=nRnrZrUMS21bBd735QaBPRR9skJ0PHuu87Tcj+7x4koLtnF04ERPhBgGspmseaYsup
         IEWrvnC980Ah5C0dq/a6xwd/DejNacX7kg4i2n7HdwhIsgvB9/u1mgEPOx5HVdj8IJxr
         CWBmn8/waXZuLf+kkAb1vgsQRIZIHneeK3YFWuOcQ2zl7Bs0QygJgO7AUT1ez4VRNnWd
         n4ZR0znt/bmE81BGiwGwgSm5s8kwmIwycUfmLKXx7F/b5y3njidYZ95B5LdqYFXOhvZ5
         13dbwFR72nMEnNOJ9RNRG3acBdPvhmhHC9KVqXfIVM/6RfWR4+KxSp84ZUziIwxhg25O
         5ylw==
X-Gm-Message-State: AOJu0YxdzM8Mg5DwaTBfr2SuDObl08ZsHSG5h8uHytDOXbeYvO6jazEx
	M9+myP1OYS2n0m8hAjtlo9uPYkbqXP4Y7DzN5JsoPiipidK1lK1SMs7pUR0gGA0=
X-Google-Smtp-Source: AGHT+IERJ5CVIKajqquihn6NE/XmMlyxafe6ckVtPVAUC0vybHV46jG9oDc6VlL6RYybBbU9nX5pbA==
X-Received: by 2002:a5d:56ce:0:b0:367:9877:750e with SMTP id ffacd0b85a97d-36831605880mr4408312f8f.25.1721381781590;
        Fri, 19 Jul 2024 02:36:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2aee:948:fb51:d5a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b7d9sm1102859f8f.42.2024.07.19.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:36:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing fixes for v6.11-rc1
Date: Fri, 19 Jul 2024 11:36:11 +0200
Message-ID: <20240719093611.29244-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of fixes for power sequencing. There's one
fix for an invalid pointer dereference in error path reported by smatch
and two patches that address the noisy config choices you reported earlier
this week.

Bartosz

The following changes since commit e763c9ec71dd462337d0b671ec5014b737c5342e:

  Merge tag 'pwrseq-updates-for-v6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2024-07-15 17:34:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v6.11-rc1

for you to fetch changes up to 1a8c67a8b21e26843d5641c55f48130b3e323ce8:

  arm64: qcom: don't select HAVE_PWRCTL when PCI=n (2024-07-19 09:49:24 +0200)

----------------------------------------------------------------
power sequencing fixes for v6.11-rc1

- fix an invalid pointer dereference in error path in pwrseq core
- reduce the Kconfig noise from PCI pwrctl choices

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: qcom: don't select HAVE_PWRCTL when PCI=n

Bartosz Golaszewski (2):
      power: sequencing: fix an invalid pointer dereference in error path
      Kconfig: reduce the amount of power sequencing noise

 arch/arm64/Kconfig.platforms            |  1 +
 drivers/net/wireless/ath/ath11k/Kconfig |  1 +
 drivers/net/wireless/ath/ath12k/Kconfig |  1 +
 drivers/pci/pwrctl/Kconfig              | 11 +++--------
 drivers/power/sequencing/core.c         |  3 ++-
 5 files changed, 8 insertions(+), 9 deletions(-)

