Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B857FF4B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3SFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 14:05:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3SFk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 14:05:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 60BAB281CB7
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com
Subject: [RFC 0/4] Add support for drm/rockchip to dynamically control  the DDR frequency within vblank for gru chromebooks.
Date:   Tue, 30 Apr 2019 14:05:20 -0400
Message-Id: <20190430180524.22710-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear all,

The purpose of that RFC is to enable de DMC device for the Rockchip
based GRU Chromebooks, and to add a mean of synchronization between the
Rockchip DRM driver and that DMC devfreq driver.

The DMC device is responsible for updating the DDR frequency according
to the load of the DDR memory. Changing that clock rate within the
display scanout leads to glitches. Thus, the devfreq framework needs a
mean to synchronize the rate change with other devices.

In that case, the DRM driver display has to synchronize a change rate
within the VBLANK.

The first patch adds a locking API to the devfreq framework. The users
of a devfreq device can control the frequency change by locking and
unlocking the devfreq device whenever they want. When a change rate is
requested, and the device is locked, the drivers that hold a lock are
called back, and the change will be applied as soon as the device is
unlocked.

The second patch adds the devfreq support in the Rockchip DRM drivers
and uses the devfreq lock API to defer the change of the DDR frequency
within the next VBLANK. The DRM driver locks the devfreq device and gets
notified when a change is wanted then. Next, it enables the VBLANK
interrupt, releases the lock on interrupt and starts a timer that
relocks the devfreq device at the end of the vertical blanking interval.
Also, the DRM driver disables the devfreq device if more than one CRTC
becomes active.

The third patch merges the Rockchip DDR clock code to the Rockchip DMC
devfreq driver. These drivers both perform SMC calls to the
Trusted-Firmware A to run SiP services that are related to the DDR
memory. This merge puts the code at the same place. It avoids the
contention in the Common Clock Framework that may cause to miss the
deadline during which the rate can be changing without making glitches.

The fourth patch tells display-subsystem to use the DMC devfreq device.

I am waiting for your feedback.

Note: This RFC needs patchset[1]. Its purpose is to addresses the review
that was made in v1[2]. I dropped some patches in v2 to address things
separately (in that RFC).

[1]: https://patchwork.kernel.org/cover/10901577/
[2]: https://lkml.org/lkml/fancy/2018/8/2/7

Best regards,
Gaël PORTAY (3):
  PM / devfreq: add devfreq_lock/unlock() functions
  drm: rockchip: Add DDR devfreq support.
  clk: rockchip: merge clk-ddr in dmc devfreq driver
  arm64: dts: rockchip: Set the display-subsystem devfreq

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi |   4 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     |   2 +-
 drivers/clk/rockchip/Makefile                |   1 -
 drivers/clk/rockchip/clk-ddr.c               | 147 --------------
 drivers/clk/rockchip/clk-rk3399.c            |   2 -
 drivers/clk/rockchip/clk.c                   |   9 -
 drivers/clk/rockchip/clk.h                   |  33 ---
 drivers/devfreq/devfreq.c                    | 200 ++++++++++++++++++-
 drivers/devfreq/rk3399_dmc.c                 |  42 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c  |  51 ++++-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h  |   6 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c   | 177 +++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.h   |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c  |  82 ++++++++
 include/linux/devfreq.h                      |  64 ++++++
 15 files changed, 611 insertions(+), 212 deletions(-)
 delete mode 100644 drivers/clk/rockchip/clk-ddr.c

-- 
2.21.0

