Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE21217C
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfEBR6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 13:58:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41808 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBR6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 13:58:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 59086260C68
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v5 0/5] Add support for drm/rockchip to dynamically control the DDR frequency.
Date:   Thu,  2 May 2019 13:58:14 -0400
Message-Id: <20190502175820.25382-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear all,

The rk3399 platform has a DFI controller that can monitor DDR load and a
DMC driver that talks with the TF-A (Trusted Firmware-A) to dynamically
set the DDR frequency with following flow.

             kernel                          Trusted Firmware-A
                                                  (bl31)
        monitor ddr load
                |
                |
        get_target_rate
                |
                |           pass rate to TF-A
        clk_set_rate(ddr) --------------------->run ddr dvs flow
                                                    |
                                                    |
                 <------------------------------end ddr dvs flow
                |
                |
              return

These patches add support for devfreq to dynamically control the DDR
frequency for the gru chromebooks. By default it uses the
'simple_ondemand' governor which can adjust the frequency based on the
DDR load.

Waiting for your feedback.

Best regards,
Gaël

Note: The RFC and the first patchset contained three patches to sync the
DDR frequency change within the vblank. These patches was submitted
separatly in a dedicated RFC[1].

[1]: https://lkml.org/lkml/2019/4/30/1066

Changes in v5:
- [PATCH v4 5/5] Remove use of DRAM setting defines.
		 Remove new DRAM setting header.
- [PATCH v5 6/6] Remove references of unexistant defines in documentation (new
                 patch).

Changes in v4:
- [PATCH v3 1/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.
- [PATCH v3 2/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.
- [PATCH v3 3/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.
- [PATCH v3 4/5] Remove board related DDR settings (moved to 5/5).
- [PATCH v3 5/5] Add board related DDR settings (moved from 5/5).

Changes in v3:
- [PATCH v2 1/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
- [PATCH v2 2/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
- [PATCH v2 3/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
		 Remove comments.
		 Move pmu dt parsing after dt-parsing of timings to fix
		  data->odt_dis_freq value.
- [PATCH v2 5/5] Remove display_subsystem nodes.

Changes in v2:
- [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.
- [PATCH 4/8] Removed from patchset.
- [PATCH 5/8] Removed from patchset.
- [PATCH 6/8] Removed from patchset.
- [PATCH 7/8] Reword the commit message to reflect the removal of
              rk3390-dram-default-timing.dts in v1.
- [PATCH 8/8] Move center-supply attribute of dmc node in file
              rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
	      defined).

Changes in v1:
- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
- [RFC 1/10] s/Generic/General/ (Robin Murphy)
- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring
- [RFC 3/10] Add an explanation for platform SIP calls.
- [RFC 3/10] Change if statement for a switch.
- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
- [RFC 7/10] Removed from the series. I did not found a use case where this matters.
- [RFC 8/10] Move rk3399-dram.h to dt-includes.
- [RFC 8/10] Put sdram default values under the dmc node.
- [RFC 8/10] Removed rk3399-dram-default-timing.dts

Enric Balletbo i Serra (3):
  devfreq: rockchip-dfi: Move GRF definitions to a common place.
  dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
  devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.

Gaël PORTAY (1):
  dt-bindings: devfreq: rk3399_dmc: Remove references of unexistant
    defines

Lin Huang (2):
  arm64: dts: rk3399: Add dfi and dmc nodes.
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru.

 .../bindings/devfreq/rk3399_dmc.txt           | 75 +++++++++----------
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 45 +++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 +++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 19 +++++
 drivers/devfreq/event/rockchip-dfi.c          | 23 ++----
 drivers/devfreq/rk3399_dmc.c                  | 71 +++++++++++++++++-
 include/soc/rockchip/rk3399_grf.h             | 21 ++++++
 include/soc/rockchip/rockchip_sip.h           |  1 +
 9 files changed, 232 insertions(+), 56 deletions(-)
 create mode 100644 include/soc/rockchip/rk3399_grf.h

-- 
2.21.0

