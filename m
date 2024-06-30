Return-Path: <linux-pm+bounces-10253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58391D272
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542951F21232
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B257155CA5;
	Sun, 30 Jun 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iJkhsSqr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A752154426;
	Sun, 30 Jun 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761875; cv=none; b=gUKWODp53BMd/pbNm8a5r/9M8trEsnkBw2wLK02v+u/9FjUC8DCYncwDUjIhke+mnvAJ9VV+irztVPj5dNR9ocUZALiY5TAsQPPDeCxo6VgRacK1kMhaUQXZ52BnUPhg4MUstqAfGM1vg65Ibo3dJhM8+Iey4CG/ftsQ5BtzRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761875; c=relaxed/simple;
	bh=VGgTqYEtkLlfGU1mP6wdMoWPqx6+ivlPB6F7NoSQjmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ikfscb31M67XjFye3mFtCizBKnjtsXToLMVsEKRBHnGRVxmaFvXWXAdh4wJiRoxxcY4rQTWX1SXx9lJULEv3QQCfsX29C9OFcN0dDCsrGqWDfEudkXSWQr4bRptaGJidqJ16iQnLq/0BpTrj/ihqRtyaLHhlIzl8Wvwvj0/EMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iJkhsSqr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761837; x=1720366637; i=wahrenst@gmx.net;
	bh=zA9YlRZEzaOCiDAUQ+MTNt0D6Y/5h+AikyQcZnvDVyk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iJkhsSqrGIn7W1qq4lwfqq+Nng5ErmxnweyIJs+oTAejs3uaJJDot695pkSeMjKO
	 KwW4rD8OklsdJDtUe1VkqfHbYufcew+uWMsGkwwqFONEKueUW+EAqsgzccLri6Nj0
	 Q+5ZMTs+UOuZSg1/i52E62FiCaKwU3nRI/XX7i/DyedzCNG4hF3YgGXKK+aj5Iv+3
	 LTWnAO3BinkU85gmcLOPYwgSU+/yS32Cb1CSUrPGqbt9BcGpfqBQoYO+zpti2TrJO
	 119DE3R5ERPlZsRfexCBlZh3obd6GAXnwQqwdmn8xK7nzu2Hehavnnu+ViU0M/cmp
	 WAkV6ZV+hWhNnmp/aA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1sH5td3j1F-013lvq; Sun, 30
 Jun 2024 17:37:17 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 00/11] ARM: bcm2835: Implement initial S2Idle for Raspberry Pi
Date: Sun, 30 Jun 2024 17:36:41 +0200
Message-Id: <20240630153652.318882-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Fi98xX7qIA+CaoFmv9hWLBSKpWxyuRQs35WEXEoT2wbzxbg51n
 EtDuvHww+9XsAJDnMOqsmQJbj44weEEuI8uu508Qo3y5XIcNJ1g94X9S27n+UqBUDgvW74r
 nsEkaTnSvU2TUrJY7xLejkA79gutrXCK0JUpmUwqwsak4ITqVsuzWsn+KujmkwGRPGjImtl
 cdYg4hq9PiHHDczpkv5kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vb8zIloFvmw=;fAnhE6UScJij9u5eJiTV3r0B88v
 veevuVw3++FcPOYr7wRDBvceSSLJUz/bKwkV1RLZZEq0rGehYqLna7WsLHiybA1ntdzhu07h2
 L912qUYzM5vav6F8+b3CuG6TuRyZ1D8HbEH3BIvyb8UiUurb1D8gSZeeSaCXsmK0m0clAX1Zm
 IP+jl37kXEywMqv1wcWv0kJfUcwKurZAJMWtcygxVX4aFSseVN4nDgNYdOVHkgZL8lab961YL
 lkIuCwaWEpDetC45GWraboRaXUC6OEyo37AwVY008keKm37r5j+IoGeeHehE+WC4DsiBOJOf8
 DtuASJq7VtS4JBuIwEgfmLam5PCme2yG/ZLbsMOzKlUHZCGPfBbxDxxhYZUJBJF7XHsDq46Oq
 IqCWxwYG8QpCg3xz1WOoxRSvna4sw0BesQVsPA0goQ0ULE6UK4DZTpnLwtbJeIs4vMP4uXjpE
 9c/EmiFvpYPLCSLYla9NsNOchZahIcPwbT/boNBMNXsbRPDu4ut9F8Y0ke47stDKdoaUP8ytg
 8ZvQg6dO5qLJCLRMRRfKTvsDqYEDqEbmXz8gsvK6GPkd0JbhD/d5zo4jaAdkKdBTYro6ruWke
 lE9Hq9zxxI5Vnhdf0nKJ5A/P56aDHlQ10tJ7/AQKrXBsgM7T6nZPihQTEYKYa2H0RSOqiEkH+
 AGiVaDYpxFD0EiN9gRQChKkWrBrlB9OE4lBG0idzgAvMrJclfK1zj3CkXfgZiMjAVrceT7hQs
 RhhKAuM3InsH6XveTLYqzumZxzhEqZsq1uMT6aQqpB6o75GI9BgNO6kRLrU7V88/0I7v+2yN+
 INPyXn2trcOSxyr3t9dvwP9zo6HhAuAsvAD8DuD3PL70A=

This series implement the initial Suspend-To-Idle support for
the Raspberry Pi, which was a long time on my TODO list [1]. The
changes allow to suspend and resume the Raspberry Pi via debug UART.
The focus is on the BCM2835 SoC, because it's less complex than its
successors and have enough documentation.

The series is a loose collection of fixes and improvements.
So cherry-picking should be fine.

Test steps:
- configure debug console (pl011 or mini UART) as wakeup source
- send system to idle state

  echo freeze > /sys/power/state

- wakeup system by console traffic

The implementation isn't perfect and contains workarounds like
patch 4 and 9. So there is still room for improvements, but
at least the system won't freeze forever as before [2].

Here are some figures for the Raspberry Pi 1 (without any
devices connected except of a debug UART):

running but CPU idle =3D 1.67 W
suspend to idle      =3D 1.33 W

The series has been tested on the following platforms:
Raspberry Pi 1 B
Raspberry Pi 3 A+
Raspberry Pi 3 B+

Known issues:
- currently it's not possible to power down the USB domain [3]
- there seems to be an issue with the DWC2 suspend handling [4]

[1] - https://github.com/lategoodbye/rpi-zero/issues/9
[2] - https://bugzilla.redhat.com/show_bug.cgi?id=3D2283978
[3] - https://github.com/raspberrypi/firmware/issues/1894
[4] - https://lore.kernel.org/linux-usb/3fd0c2fb-4752-45b3-94eb-42352703e1=
fd@gmx.net/T/

Stefan Wahren (11):
  firmware: raspberrypi: Improve timeout warning
  mailbox: bcm2835: Fix timeout during suspend mode
  pmdomain: raspberrypi-power: Adjust packet definition
  pmdomain: raspberrypi-power: Avoid powering down USB
  irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
  drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
  drm/vc4: hdmi: Disable connector status polling during suspend
  usb: dwc2: debugfs: Print parameter no_clock_gating
  usb: dwc2: Skip clock gating on Broadcom SoCs
  serial: 8250_bcm2835aux: add PM suspend/resume support
  ARM: bcm2835_defconfig: Enable SUSPEND

 arch/arm/configs/bcm2835_defconfig        |  2 --
 drivers/firmware/raspberrypi.c            |  3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c            | 18 +++++++++++++++++-
 drivers/irqchip/irq-bcm2835.c             |  4 +++-
 drivers/mailbox/bcm2835-mailbox.c         |  3 ++-
 drivers/pmdomain/bcm/raspberrypi-power.c  | 17 ++++++++++++-----
 drivers/tty/serial/8250/8250_bcm2835aux.c | 23 +++++++++++++++++++++++
 drivers/usb/dwc2/debugfs.c                |  1 +
 drivers/usb/dwc2/params.c                 |  1 +
 9 files changed, 61 insertions(+), 11 deletions(-)

=2D-
2.34.1


