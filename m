Return-Path: <linux-pm+bounces-8479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E748D63D6
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1565728472F
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8416F85C;
	Fri, 31 May 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZFy7Tz5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F315B128;
	Fri, 31 May 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163668; cv=none; b=VG93O9w9mJAAncQna9kIdsrlUP8oI18QAyc5AdsQhF4J1WHEPWup51J1uDye5S6iM2zUk2cVwNpLNjyfkatxvIqo5nw63XF8VHvAKXOwXI5CpebMMd4AL5kSiQv277031yPwJx2BRhp68swy3be3jO0bKgwgHz36LJDewnA4uzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163668; c=relaxed/simple;
	bh=8/nXvdeJFH+6EJxYj0XhzUaatHr625g/RAOJfW1vZDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzfYPAhS/2UBTlzyOfGuv0Hq6RQZiwf2fLHtuHrFTYl5NPvIGk7PkMRNsA0cIW92FUTd8W90IuZIdgcNFCUB0R/RSWwcFHU+2/MvFHuS86n5xkec0wX2/J7mKeM1+ZEOm2KWmBYe2PO5LOZEDu2JnLDseE58FhEKqFmdu/WHbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZFy7Tz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC80C116B1;
	Fri, 31 May 2024 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717163667;
	bh=8/nXvdeJFH+6EJxYj0XhzUaatHr625g/RAOJfW1vZDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZFy7Tz51qEdUcedXygDp5F3FeuVLVFf5Y+qyTnGzBAZbcNNb802MtgCqXok1LXN1
	 sFjON9Z/TTvacLeQRVgAPLKD/sHNZCQjFk7CGAIK+jO4CTA7cQd4ncezejTVqrIXa3
	 9fUMKm3FSzOZIefvH/QT9HvyezispTVtXdMwezQQY2GvZ/n4FaxWPXCk9XKTBTpWxd
	 +N8koYv2j1z46FvWk0aZBPv2qs8u84ykr414CPvPzf4DJgE2uCqlJku1JI9BnTqQOo
	 48hXXyza99Hn0P0vXlQUuPY3yxp5fEo6ImxtNXOihhVYVO/3GF0jYaDh02dqX/T4nO
	 oXvVRpG5+DDVQ==
Date: Fri, 31 May 2024 14:54:23 +0100
From: Lee Jones <lee@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between LEDs, Power and RGB due for the
 v6.11 merge window
Message-ID: <20240531135423.GM1005600@google.com>
References: <20240531114124.45346-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531114124.45346-1-hdegoede@redhat.com>

Enjoy!

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git ib-leds-platform-power-v6.11

for you to fetch changes up to 9af12f57f1f9785f231d31a7365ad244c656b7ff:

  power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED (2024-05-31 12:57:43 +0100)

----------------------------------------------------------------
Immutable branch between LEDs, Power and RGB due for the v6.11 merge window

----------------------------------------------------------------
Hans de Goede (3):
      leds: rgb: leds-ktd202x: Initialize mutex earlier
      leds: core: Add led_mc_set_brightness() function
      leds: trigger: Add led_mc_trigger_event() function

Kate Hsuan (3):
      leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
      leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
      power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED

 drivers/leds/led-class-multicolor.c      |  1 +
 drivers/leds/led-core.c                  | 31 +++++++++++++
 drivers/leds/led-triggers.c              | 20 ++++++++
 drivers/leds/rgb/Kconfig                 |  1 -
 drivers/leds/rgb/leds-ktd202x.c          | 80 ++++++++++++++++++--------------
 drivers/power/supply/power_supply_leds.c | 23 +++++++++
 include/linux/leds.h                     | 26 +++++++++++
 include/linux/power_supply.h             |  2 +
 8 files changed, 149 insertions(+), 35 deletions(-)

-- 
Lee Jones [李琼斯]

