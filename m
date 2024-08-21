Return-Path: <linux-pm+bounces-12663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41A95A6E1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C70D1C22729
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FA17B439;
	Wed, 21 Aug 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="P+K4Xlre"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D421779BC;
	Wed, 21 Aug 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276499; cv=none; b=JwjPrsGnRjRPSROQNwL5bECqTFWpb4mJw/oWda7fQdWmo6ytdgS4s9AtfUvoTMM7AoGQ6JcOGegPrns5LCRNdPJK5dCDUr3b7Jxp3x3YlPJmeqpqg3nL/Ox4rTPLyb/H8wit67sEHMYrV1hbu4OmhL9Z2cZk4Q6c3RixAI57bx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276499; c=relaxed/simple;
	bh=sCb+Pxmy4xDpHR3cs0toZaUGNP47RDFntrKyYlIfFMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FLSnLrp2WILQ0+zBlPWSusHiPJrffMY31B7rSyIBP1uPVm6jMW+7PDwpvw88/GjBaytzpHks1b9ekk9aS9IjY1JnVOSo8nZhJMnVFL40xZTvULaxIw8YK7G/UvNP4Qx9dqQBNeMjjGldaqAErukSUgX+xLTJcfLDSrwad06O9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=P+K4Xlre; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724276463; x=1724881263; i=wahrenst@gmx.net;
	bh=5N3RH8iPiqYqhY0BGlP98QSqLIwGal1ASskCaWkhhn0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P+K4XlremlDBMfj0znT28BU3Qk/n2y/K8TUDfZrhST95kvzxN7iNj8lw24jed6B7
	 ZNJTP2yHJNUZjOtGlcnbSUUvajdJYOMDP4fe4iIBIJxxZNs4R7Pc0FpVdibKiT+nP
	 ohw/HtJxXlXNMYBx62uczaFJrf4ZjRJBPiA0qxwmwl8rvhpwxNeHL7Mubjazhd7RZ
	 8Rf7ajAsU7OHz+1UMyzhesjWXxdg8ayY3xn8+Vf/zJaSeIcsmAS6h+lFF9H2ARrfg
	 JYoJuj3LE7WKmEaeLzJ3QMoh6V3O7T+xc38+Iy/KSaswuhr2E2YK5O3kDa21z9z4/
	 Wt1rtwUExEUhPps++A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1sDZXG2ovN-00fzvf; Wed, 21
 Aug 2024 23:41:03 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Russell King <linux@armlinux.org.uk>,
	Doug Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 0/9] ARM: bcm2835: Implement initial S2Idle for Raspberry Pi
Date: Wed, 21 Aug 2024 23:40:43 +0200
Message-Id: <20240821214052.6800-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aCzKQUb3XFyxBbC5ls0ydeGzWXL1jSVErWB5ynWFjsaMAtLrJLg
 gWT9J/fZSA8+fMj5Fk++EZdE5iuyCF0tycySzQYq80Yonv+krIch9+JzofZKNExVRsfOMuN
 SxvMHr2tQVxMK9AuL3LFmWH8QWkNMYDvs1MEI6IyZ9jCExgAMEY/Ylx5V4HHzSMhJU9Shln
 RzW9K95SNrkxoWiofMDvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4i3lW4xDfNk=;2vfUEntvDEFs0axQpyzrSRVeWZp
 LjF4UAHwcoJgoIAaIHt9FyIcHVBzISjt5XVD5vwCJvHPmHLHHJBg10kX6ngFbU1spllPXOOH6
 XTW+4e09ULG0ZwLR35Eck/iuxTPZo0pmXImlBoOcxoaltowGwny7FqpQDhEnuyqWw/r/vGIn6
 VtuKUyqxpmWBx2gWnICNkJcjwxv9Voo1K8hoS0kEVhxDLc7vVoigZyrG1SdZRVgkGvvuUrxHW
 KuGJgR2PUJyyALfd0NoMRGa+xMtgqqziA/sUsaCIniUUCvbvZNGj1wsu7HqGc9hmcO1CEJZQy
 q607g2/z3PvvzdVIkqWeCBPsA+ElelTXRPbEGm9E8TrIBlLYCxdRwTAPzFKaMNA0h13PsYEPu
 Ec8ZE3CO+hM21rqxztCIrIixwB6YeY/BIGy4aeQn3tjqBwvtt2xZkhKpi3Ke0i2qB79KSNxjq
 X6gTqZv9ZVfb1kj5ih6p2Rst+ksw1L5eL4uNwWLxJMiV072YqY7w4vk4Cm86Up2tbjzuMqOJ0
 bQW63pu1q9FLFzbGDlLUn9uUQwByxr4HindIoXO3hUC2roYA5QfpiPKFQeFtA/Qmx7PHWfGJU
 D3sVfBBNYZZoomgnZaQbOQ3OgVMfJZlFYVGqi7QT91vWg/25KWZjtB7vQxSsiWOoMPBDW1M1D
 n0K67XnJcXkBHOSRHXwtZlTfPQ/GzJV4CJO+0p53h5kNV/L8LlCcClrrbolmdq1ZL3CHiPFha
 PWvD/y8RwzYAFACMHViuZ78UwtQe9zMjlerrTJjGzvntAf+KWxDMxMu/kSRGRmSsu8ia5RWwn
 cODd1MJnJYpuHx22EF5PMkHg==

This series implement the initial S2Idle support for
the Raspberry Pi, which was a long time on my TODO list [1]. The
changes allow to suspend and resume the Raspberry Pi via debug UART.
The focus is on the BCM2835 SoC, because it's less complex than its
successors and have enough documentation.

The series can be roughly separated in 3 parts:
 1. base patches (1, 9) which allows S2Idle support for BCM2835
 2. drm vc4 patches (2 - 6)  which implement S2Idle support
 3. dwc2 patches (7, 8) which handle BCM2835 specific issues

Cherry-picking of patches should be fine.

Test steps:
- configure debug console (pl011 or mini UART) as wakeup source
- send system to idle state

  echo freeze > /sys/power/state

- wakeup system by console traffic

The DWC2 part based on an idea of Doug Anderson and its implementation
should be mostly finished now, but still RFC. The USB domain is now powere=
d
down and the USB devices are still usable after resume. There is still roo=
m
for improvements, but at least the system won't freeze forever as before.

Here are some figures for the Raspberry Pi 1 (without any
devices connected except of a debug UART):

running but CPU idle =3D 1.67 W
S2Idle               =3D 1.33 W

In comparison with HDMI & USB keyboard connected (but neither active
nor wakeup source):

running but CPU idle =3D 1.82 W
S2Idle               =3D 1.33 W

The series has been successfully tested on the following platforms:
Raspberry Pi 1 B
Raspberry Pi 3 B+

Changes in V3:
- added Reviewed-by & Acked-by from Florian & Ma=C3=ADra
- dropped applied pmdomain & bcm2835aux patches
- address comments by Ma=C3=ADra (patch 3 & 5)
- replace old USB recovery patch with canary approach [3], which should
  work with other platforms

Changes in V2:
- rebased against todays mainline
- added Reviewed-by from Florian
- added Acked-by from Minas
- dropped "irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND"
  because it has been applied by Thomas Gleixner
- dropped "pmdomain: raspberrypi-power: Avoid powering down USB"
  because this workaround has been replaced by patch 14
- use drm_err_once instead of DRM_ERROR and return connector_status_unknow=
n
  in patch 6
- add new patch in order to clean-up all DRM_ERROR
- add new patch to improve raspberrypi-power logging
- add new patch to simplify V3D clock retrieval
- add new patch 5 to avoid power down of wakeup devices
- add new patch 12 to avoid confusion about ACPI ID of BCM283x USB
- add new patch 8 & 10 which address the problem that HDMI
  is not functional after s2idle
- add more links and fix typo in patch 13
- add new WIP patch 14 which recover DWC2 register after power down
- take care of UART clock in patch 15 as commented by Florian
- use SYSTEM_SLEEP_PM_OPS in patch 15

[1] - https://github.com/lategoodbye/rpi-zero/issues/9
[2] - https://bugzilla.redhat.com/show_bug.cgi?id=3D2283978
[3] - https://lore.kernel.org/linux-usb/CAD=3DFV=3DW7sdi1+SHfhY6RrjK32r8iA=
Ge4w+O_u5Sp982vgBU6EQ@mail.gmail.com/

Stefan Wahren (9):
  mailbox: bcm2835: Fix timeout during suspend mode
  drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
  drm/vc4: Get the rid of DRM_ERROR()
  drm/vc4: hdmi: add PM suspend/resume support
  drm/vc4: v3d: simplify clock retrieval
  drm/vc4: v3d: add PM suspend/resume support
  usb: dwc2: Refactor backup/restore of registers
  usb: dwc2: Implement recovery after PM domain off
  ARM: bcm2835_defconfig: Enable SUSPEND

 arch/arm/configs/bcm2835_defconfig |   2 -
 drivers/gpu/drm/vc4/vc4_bo.c       |  14 ++--
 drivers/gpu/drm/vc4/vc4_dpi.c      |  14 ++--
 drivers/gpu/drm/vc4/vc4_dsi.c      |  32 +++++----
 drivers/gpu/drm/vc4/vc4_gem.c      |  11 ++--
 drivers/gpu/drm/vc4/vc4_hdmi.c     |  70 ++++++++++++++------
 drivers/gpu/drm/vc4/vc4_hvs.c      |   4 +-
 drivers/gpu/drm/vc4/vc4_irq.c      |   2 +-
 drivers/gpu/drm/vc4/vc4_v3d.c      |  26 +++-----
 drivers/gpu/drm/vc4/vc4_validate.c |   8 +--
 drivers/gpu/drm/vc4/vc4_vec.c      |  10 +--
 drivers/mailbox/bcm2835-mailbox.c  |   3 +-
 drivers/usb/dwc2/core.c            |   1 +
 drivers/usb/dwc2/core.h            |  14 ++++
 drivers/usb/dwc2/gadget.c          | 101 +++++++++++++++--------------
 drivers/usb/dwc2/hcd.c             |  99 ++++++++++++++--------------
 drivers/usb/dwc2/platform.c        |  38 +++++++++++
 17 files changed, 265 insertions(+), 184 deletions(-)

=2D-
2.34.1


