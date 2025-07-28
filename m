Return-Path: <linux-pm+bounces-31472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B65B138D7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF401892B68
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA021FF4C;
	Mon, 28 Jul 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="czFtDkeW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04361F4CBC
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698043; cv=none; b=jvOKbYIzkkXSB/M2lqhC4zy/lVTYEz4AoH62ZJQu+4h2NMFWuQZXg0tmbE/nWVt/A3SwppsFm6t9jUnq4O9CR8pjABLQ4AmoyBDTRJqyg6ByMr77UnJrl294brtAju2ryGgH4cSuS/k7+Q9VK7eYuAuNXMJtqzEkZuguDS2v18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698043; c=relaxed/simple;
	bh=pyV7Aetn6gZ7xXS5CT0vvgHUaHHSEVxQJE3ZgGcCT+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQJshh6KzSu9lS0kM7yeK/ug4bCXEWK+0Y56AmE9EQoj+HLCHRMOO6Ru3raIukGTqZfpNkIKN77c54lIwnDQh0galTBupO32qCzRDjWuTBs8s3e7JQ890D0b9ngrSP2y43eXotpaQtTZ8RIDLZLIWRbuZMEjAU0QJQfl+unJ3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=czFtDkeW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso43182705e9.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753698040; x=1754302840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=219O2xVBqIOUMv3jLy61uyg7qpqwuip52JZjqaIWS2o=;
        b=czFtDkeW0kusrKZ0fw9jTdFMD0EZomZEs1AhjCn3bARDO6U1pWYX8wv5aGBCxxwxXY
         Ku/JfUylywWVd6VG7QVu/8+A3EmRLorsS9RRhouH8//1L+VmWmj2EqYTEq+ryjZlaKv/
         1Nl8FSnfC1uNxrItHGD2we7+td/IrGC/geg9hfgeBih8jqOe6ZXogn3ZU+Dj2xJ99nu8
         +8XR8hhVUU581fe6uWjJbal3du2z17ZHGTH2lG+hWrvQKMka24x0j55pESkXbDC2XvOE
         4Z0lFdx00qtKZYmrBn/rKws/OxVLYa4fjvK40EdAmyA5adY7gmhPeFIpRDfOn8CX7Lk0
         Hv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753698040; x=1754302840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=219O2xVBqIOUMv3jLy61uyg7qpqwuip52JZjqaIWS2o=;
        b=E4+/o/buxHGATNIODNNyrPGN7MOSupAR3cTTfC+HauwRJ7eHXiEoiQrEUQuF6DjuaN
         jFVmXB2SR4h3uAWuA/UEYodag3XVmO8SRaYdJWAo6pCqNm5zlRdCGhcBG3HLrhVuvTLB
         msqmfkVOx6mx2+QyNVbP8OefWxb2AH4MuatYORRWC7n6WqouQat+B91JVtsYiBldIxLv
         zL6uqE7HnnnqrVo8IZWInfvw6yY6t2E5iueT9z0JmCDI4QPe26UJ1fQRq0CYhM5I/PhO
         Wl/xsYhpQ1Zd3RjHJwbdsllKdEutZKaBTLFV7gNkTvOe/EBsiOoyXbL5a60iPyoVHN7w
         LqEQ==
X-Gm-Message-State: AOJu0YzZFGSc4PDgtqLr9OEMxiIV1Y6tBgdsQO1DXDAHFV9GugRxpRbf
	5ilRo1X+NS05h8iya2mGDezfLkKCzE7ePUODMQPiA/IbCljHoyj+Nm+XTvi0cZjP9NE=
X-Gm-Gg: ASbGnct6k27oJOfM/7mO3lLQWVZOPY7t145oEe4hdsQr+41D+jWnj0/kRnFI8mtme+E
	TlD7X+hK/5WZeSdSLYIt4GDb7JYcw1wZsWt92podvuYTNveSaVlHVm0YPVQ/vKGMR4CAmyB6mn1
	7YyawxvVzdk18+Yu975Qyq7sutmEME10ZmA4WfGYTILoyxdZtMF+y7tMHpMwNK2wJT+Aof2UUaT
	1RTfYmf2YJJ2lcZC/7NWNpl8UEpMYr0WVM198yW3HBxVqxxIiIMAEDdYh0vm17zQQ5jqwiq+bUz
	9gPuwWEOfxQXHZfanlWfPv4o5cpnIsTZeyxd2So3BHEJOO5mSbGaYlFxXWp9nPM9lFiUYxKDt+2
	8xCNdL3LoYlvkpqohPekbyQ==
X-Google-Smtp-Source: AGHT+IGj5AJyBcYgln1fm6c5zt4uON5qzfUaZeojAc6NG/CRXcwFlI2+uLjZU/QAvrqAIKFbe1ew0w==
X-Received: by 2002:a05:600c:a010:b0:456:1e5a:8880 with SMTP id 5b1f17b1804b1-4587631a095mr75658865e9.13.1753698039894;
        Mon, 28 Jul 2025 03:20:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:53d4:51a:4d68:dac1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378f4sm154610875e9.2.2025.07.28.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 03:20:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing updates for v6.17-rc1
Date: Mon, 28 Jul 2025 12:20:30 +0200
Message-ID: <20250728102030.44816-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of updates for the power sequencing
subsystem for v6.17-rc1. We have one new driver and a small set of
improvements as well as a fix to power sequence unit naming.

Thanks,
Bartosz

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.17-rc1

for you to fetch changes up to 07d59dec6795428983a840de85aa02febaf7e01b:

  power: sequencing: qcom-wcn: fix bluetooth-wifi copypasta for WCN6855 (2025-06-30 09:07:57 +0200)

----------------------------------------------------------------
power sequencing updates for v6.17-rc1

New drivers:
- add a power sequencing driver for the T-HEAD TH1520 GPU

Power sequencing core improvements:
- allow to compile the pwrseq drivers with COMPILE_TEST=y in order to
  improve the build-test coverage
- add named defines for the possible return values of the .match()
  callback and use it in the existing drivers instead of magic values

Fixes:
- Fix the name of the bluetooth-enable unit for WCN6855

----------------------------------------------------------------
Bartosz Golaszewski (5):
      power: sequencing: thead-gpu: add missing header
      power: sequencing: extend build coverage with COMPILE_TEST=y
      power: sequencing: add defines for return values of the match() callback
      power: sequencing: qcom-wcn: use new defines for match() return values
      power: sequencing: thead-gpu: use new defines for match() return values

Konrad Dybcio (1):
      power: sequencing: qcom-wcn: fix bluetooth-wifi copypasta for WCN6855

Michal Wilczynski (1):
      power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver

 MAINTAINERS                                 |   1 +
 drivers/power/sequencing/Kconfig            |  10 +-
 drivers/power/sequencing/Makefile           |   1 +
 drivers/power/sequencing/core.c             |   6 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c  |  10 +-
 drivers/power/sequencing/pwrseq-thead-gpu.c | 249 ++++++++++++++++++++++++++++
 include/linux/pwrseq/provider.h             |   3 +
 7 files changed, 271 insertions(+), 9 deletions(-)
 create mode 100644 drivers/power/sequencing/pwrseq-thead-gpu.c

