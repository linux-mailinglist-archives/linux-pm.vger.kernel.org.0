Return-Path: <linux-pm+bounces-5740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938BC89378B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 05:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED8A281A3A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Apr 2024 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F84C6B;
	Mon,  1 Apr 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTSN8gUm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD54409;
	Mon,  1 Apr 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940470; cv=none; b=faRigJgz6MbYPTVlShdkadC2F8fn7Q4EM2+3Em3LFe7mR0JARcRlrbcNDYzWa+P2bJyILcbxneOWwfbBaInRuoW0V6UGKuqJACald7xvg5Rg9H62Kq63nstnoyhKmnhS5i2lxXHJs3OQria7YKd5X3/kMHNXOYfweBnC9791JHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940470; c=relaxed/simple;
	bh=9gvs/+ZG9IaP2sMR0y5sj3WQVST5/3S5+n/sL5FgN+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGPIQ9CPNQC3TLkZyKG8DhtFEEn8nYULPI/CLmrS1v1gFY86eMtQa+z2svqp3AFeRRlrsDr9L3smdC9nX0f5gOKxq5uiSsvNi6kxdICiMXf0h7hfq2cqgyTOxNYMxU7IJj6s9zi/RYeGb+IzAULdWxLQtJIvA3Zgb1ohvnAmkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTSN8gUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FC2C433F1;
	Mon,  1 Apr 2024 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711940470;
	bh=9gvs/+ZG9IaP2sMR0y5sj3WQVST5/3S5+n/sL5FgN+c=;
	h=From:To:Cc:Subject:Date:From;
	b=eTSN8gUmvzghSseuYWG/mDkuI3+N+U8VHy0kk8M8TJi4Hd/nBdzXFh2vQ68M3TqvC
	 kbEzvV0/ZcWcvKNqxTOLXtCCv4yvfoMJHmnSLHUS+AucdMwRyIFrDcH9rAYSbpN2dR
	 E/BHjiWC7m5/zXofC2b8Xu+UcmIBZuSjtgTrPuKR0MWVrkhxjotu9GLff3v5DfkkmG
	 kKVDw34NfTw+Q7+aUgq/UGbCj2tWR/83d6BzrL9RxR7FcuyWD5iAIyKhxihIca9mwe
	 wlPW1eNL5uO9Kvq9/ZJOOzsPKlJLRMW0jsC+pR6fMcx9LWTFlFEEpPQLlbhj3M8Xkg
	 Tg3NsdWU4XZ2g==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	sre@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	pmalani@chromium.org,
	linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	krzk@kernel.org
Subject: [PATCH v2 0/6] provide ID table for avoiding fallback match
Date: Mon,  1 Apr 2024 11:00:46 +0800
Message-ID: <20240401030052.2887845-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inspired by [1].  Turn all MODULE_ALIAS() in ChromeOS EC platform drivers into
proper platform_device_id table and MODULE_DEVICE_TABLE().

The series is basically looking for drivers from:
- `struct mfd_cell` in drivers/mfd/cros_ec_dev.c.
- grep -R MODULE_ALIAS drivers/platform/chrome/.

[1]: https://lore.kernel.org/chrome-platform/20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org/T/#m2cc7d6f770cf0a48fb537bbaed655169c974f067


Changes from v1 (https://patchwork.kernel.org/project/chrome-platform/cover/20240329075630.2069474-1-tzungbi@kernel.org/):
- Split "platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding
  fallback match" into 2 commits.
- Remove patches that have been applied.


Tzung-Bi Shih (6):
  media: platform: cros-ec: provide ID table for avoiding fallback match
  gpio: cros-ec: provide ID table for avoiding fallback match
  power: supply: cros_usbpd: provide ID table for avoiding fallback
    match
  power: supply: cros_pchg: provide ID table for avoiding fallback match
  platform/chrome: cros_kbd_led_backlight: shrink the driver name
  platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding
    fallback match

 drivers/gpio/gpio-cros-ec.c                      |  8 ++++++++
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c |  9 ++++++++-
 drivers/platform/chrome/cros_kbd_led_backlight.c | 11 +++++++++--
 drivers/power/supply/cros_peripheral_charger.c   | 11 +++++++++--
 drivers/power/supply/cros_usbpd-charger.c        | 11 +++++++++--
 5 files changed, 43 insertions(+), 7 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


