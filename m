Return-Path: <linux-pm+bounces-5606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229DF8914A1
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 08:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A489A1F21CA8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4840877;
	Fri, 29 Mar 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOvqi7Sf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56183B78E;
	Fri, 29 Mar 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699036; cv=none; b=rEGYg64d+9iXF3GJmx4KDWxKitE7eSLyZLThS46Y50rPXwgDqWsKtyx1yPILMnVajmFIbXMzc+peYQZlSWONIvEwkiJhS+jI/hW3tAkiFjg1CwZTIsj2UHj/+nLDKLg3JJF35esOdAiIEitoZZnjFtrs19J3ohrtFn8qnwZHYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699036; c=relaxed/simple;
	bh=VfU7QoMGIzVV4cTnNZd5yeDBjCpnVSdeFYafrvvqPiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMSut6z74mSmp6qApezYAZLsInkheZ+GtEoKlNVaUSf6NExK1inkLY+AcpRPY2raGjJj96JJaeVLpDP4eByQviQ5/WyC7ZaBTdrmRT8VNAH1NaXrQAUmjRZoE3EfF+DgT4c81WDRhMAuvkjC5i8cEOt4qLu9TStYsBO532lmnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOvqi7Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92CDC433F1;
	Fri, 29 Mar 2024 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699035;
	bh=VfU7QoMGIzVV4cTnNZd5yeDBjCpnVSdeFYafrvvqPiM=;
	h=From:To:Cc:Subject:Date:From;
	b=AOvqi7Sfkt5flEJlMlu0M/klCkfS119dFjq3LoNxICxK+KOARjBZryfgw1kBPxygK
	 w6gIDCSwBIHs+u2hUwSkXk6UgHs6sqRvNfRrFxwwtgHV3QugIUj1eXdqFffeDCv/1R
	 CYYJ/XBYs6n0MvDaJOdZDIk0p0A6RN46nC/JIWoPpWBAiQQYP/goCWWV4UggqLfFZH
	 2ecF5JSAyHl2eY4AQVUhDbWbP24LJVFZK1vsOQ2AbmfJ1JDI3FscqBHF3Xiz4tVt0V
	 k8o9muzcjqIB6pL+XE6yfjbSVjANLJDypoELXvDhT6t6JtQi7MYLWpJOR0q8al1V/G
	 9YRqXfiOb3dtA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	groeck@chromium.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	hverkuil-cisco@xs4all.nl,
	mchehab@kernel.org,
	sre@kernel.org,
	alexandre.belloni@bootlin.com
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	pmalani@chromium.org,
	linux-gpio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: [PATCH 00/18] platform/chrome: provide ID table for avoiding fallback match
Date: Fri, 29 Mar 2024 15:56:12 +0800
Message-ID: <20240329075630.2069474-1-tzungbi@kernel.org>
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

Tzung-Bi Shih (18):
  media: platform: cros-ec: provide ID table for avoiding fallback match
  gpio: cros-ec: provide ID table for avoiding fallback match
  rtc: cros-ec: provide ID table for avoiding fallback match
  platform/chrome: cros_ec_sensorhub: provide ID table for avoiding
    fallback match
  power: supply: cros_usbpd: provide ID table for avoiding fallback
    match
  platform/chrome: cros_usbpd_logger: provide ID table for avoiding
    fallback match
  platform/chrome: cros_usbpd_notify: provide ID table for avoiding
    fallback match
  platform/chrome: cros_ec_chardev: provide ID table for avoiding
    fallback match
  platform/chrome: cros_ec_debugfs: provide ID table for avoiding
    fallback match
  platform/chrome: cros_ec_sysfs: provide ID table for avoiding fallback
    match
  power: supply: cros_pchg: provide ID table for avoiding fallback match
  platform/chrome: cros_ec_lightbar: provide ID table for avoiding
    fallback match
  platform/chrome: cros_ec_vbc: provide ID table for avoiding fallback
    match
  platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding
    fallback match
  platform/chrome: wilco_ec: telemetry: provide ID table for avoiding
    fallback match
  platform/chrome: wilco_ec: debugfs: provide ID table for avoiding
    fallback match
  platform/chrome: wilco_ec: event: remove redundant MODULE_ALIAS
  platform/chrome/wilco_ec: core: provide ID table for avoiding fallback
    match

 drivers/gpio/gpio-cros-ec.c                      |  8 ++++++++
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c |  9 ++++++++-
 drivers/platform/chrome/cros_ec_chardev.c        |  9 ++++++++-
 drivers/platform/chrome/cros_ec_debugfs.c        |  9 ++++++++-
 drivers/platform/chrome/cros_ec_lightbar.c       |  9 ++++++++-
 drivers/platform/chrome/cros_ec_sensorhub.c      |  9 ++++++++-
 drivers/platform/chrome/cros_ec_sysfs.c          |  9 ++++++++-
 drivers/platform/chrome/cros_ec_vbc.c            |  9 ++++++++-
 drivers/platform/chrome/cros_kbd_led_backlight.c | 11 +++++++++--
 drivers/platform/chrome/cros_usbpd_logger.c      |  9 ++++++++-
 drivers/platform/chrome/cros_usbpd_notify.c      |  9 ++++++++-
 drivers/platform/chrome/wilco_ec/core.c          |  9 ++++++++-
 drivers/platform/chrome/wilco_ec/debugfs.c       |  9 ++++++++-
 drivers/platform/chrome/wilco_ec/event.c         |  1 -
 drivers/platform/chrome/wilco_ec/telemetry.c     |  9 ++++++++-
 drivers/power/supply/cros_peripheral_charger.c   | 11 +++++++++--
 drivers/power/supply/cros_usbpd-charger.c        | 11 +++++++++--
 drivers/rtc/rtc-cros-ec.c                        |  9 ++++++++-
 18 files changed, 139 insertions(+), 20 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


