Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB802C5C42
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbgKZSzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405005AbgKZSy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:54:59 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BCC061A48;
        Thu, 26 Nov 2020 10:54:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B3B23405ED;
        Thu, 26 Nov 2020 19:46:32 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, daniel.lezcano@linaro.org, nks@flawful.org,
        bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 00/13] Enable CPRh/3/4, CPU Scaling on various QCOM SoCs
Date:   Thu, 26 Nov 2020 19:45:46 +0100
Message-Id: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series is definitely big.
Yup. But it all goes together... here's why:

This series implements full support for CPU scaling on *many* Qualcomm
SoCs and partial support for the others on which the Operating State
Manager is not present.
Since this is a bit tangled, let's go step by step.

First of all, there's the SPM: this is a component that we can find on
very old chips, like MSM8974; there, it has been used to actually do the
power scaling basically "on its own" - sending the cores in a specific
sleep mode to save power.
On the newer ones, including MSM8998, SDM630, 660 and others, it is still
present! Though, this time, it's being used for the cluster caches and it
has a different firmware (and maybe it's also slightly different HW),
implementing the SAWv4.1 set and getting controlled *not by the OS* but
by other controllers in the SoC (like the OSM).

Contrary from MSM8974 and the like, this new version of the SPM just
requires us to set the initial parameters for AVS and *nothing else*, as
its states will be totally managed internally.

Then, hardening here we come!
In all the new SoCs - as new as SM8150 and most probably even newer ones -
there are also new versions of "the same old story".. and here I'm
referring to the Core Power Reduction (CPR) block: since MSM8996 (or
around that time frame), this block has got a sort of major change...
which actually varies the register set and implements "threads".
I won't go far with explaining that in this cover letter (as it's all
explained in the commits) but, in short, here's the catch:
CPR v3, v4 and CPR-Hardened are all based over the same register set
and are extensions of their previous.

A sort of special treatment must be given to CPR-Hardened (CPRh): this is
the one that's present on the newest SoCs, as this is a hardened version
of CPR4 and - in this version - it has got the ability to also get managed
internally, along with the SAWv4.1, by the Operating State Manager (OSM).

And finally, we get to the OSM.
This final piece appeared on MSM8998 for the first time (as far as I know),
and it is (a sort of microcontroller?) doing the "real deal": CPU DVFS
through a lookup table providing "corners" - or "performance states" - to
the OS; pretty straightforward way of offloading a whole lot of tasks that
the kernel would otherwise have to do.

And there we go with the full picture:
- From SDM845 onwards, SAW, CPRh and OSM are getting setup by the
  bootloader/TZ *before* booting the OS, so then all the OS has to do
  is to request a specific performance state to the OSM hardware and
  forget about all the rest, which is anyway protected by the hypervisor
  (so there's no access anyway); BUT:
- In MSM/APQ 8998, SDM/SDA 630/636/660 (and other variants), there is no
  setup of any of these puzzle pieces, and they're also (basically) fully
  accessible, which means that the OS must do it in order to get in the
  same state as the newer ones and to get the entire scaling hardware to
  start rolling.

"Simply", that's it. Now that I've written a kilometer-long "short
explaination" of what's going on, there's a shorter version of it:
- On new SoCs, the bootloader sets up the entire thing
- On old ones, the OS must do what the bootloader didn't do.
- That's what this patch series does. :))

There's also slightly more: since - as already explained - the
CPR-Hardened is an incremental upgrade of CPR v3->v4, it was necessary
for me to also implement support for these two versions, present in
"another whole bunch" of Qualcomm SoCs, including MSM8953, MSM8996 and
others, which is used to do either power reduction or complete voltage
scaling for the CPU clusters on these old ones... and, well, also
in 8998/630/660 along with the Hardened one... and the reason is...
that this piece of HW is also capable of doing the same with the GPU,
even though this is not yet implemented in this set.

I didn't feel like implementing the Multimedia Subsystem (MMSS) part
of the CPR3/4 in this patch series because, eh, it's already long enough,
I'd say.

Perhaps, later... :)

AngeloGioacchino Del Regno (13):
  cpuidle: qcom_spm: Detach state machine from main SPM handling
  soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS
  soc: qcom: spm: Add compatible for MSM8998 SAWv4.1 L2
  cpufreq: blacklist SDM630/636/660 in cpufreq-dt-platdev
  soc: qcom: cpr: Move common functions to new file
  arm64: qcom: qcs404: Change CPR nvmem-names
  dt-bindings: avs: cpr: Convert binding to YAML schema
  soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
  MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
  dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
  dt-bindings: cpufreq: Convert qcom-cpufreq-hw to YAML binding
  cpufreq: qcom-hw: Implement CPRh aware OSM programming
  dt-bindings: cpufreq: qcom-hw: Add bindings for 8998

 .../bindings/cpufreq/cpufreq-qcom-hw.txt      |  173 +-
 .../bindings/cpufreq/qcom,cpufreq-hw.yaml     |  219 ++
 .../bindings/power/avs/qcom,cpr.txt           |  131 +-
 .../bindings/soc/qcom/qcom,cpr.yaml           |  115 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  226 ++
 MAINTAINERS                                   |    8 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |   26 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    3 +
 drivers/cpufreq/qcom-cpufreq-hw.c             |  914 +++++-
 drivers/cpuidle/Kconfig.arm                   |    1 +
 drivers/cpuidle/cpuidle-qcom-spm.c            |  294 +-
 drivers/soc/qcom/Kconfig                      |   26 +
 drivers/soc/qcom/Makefile                     |    4 +-
 drivers/soc/qcom/cpr-common.c                 |  382 +++
 drivers/soc/qcom/cpr-common.h                 |  113 +
 drivers/soc/qcom/cpr.c                        |  441 +--
 drivers/soc/qcom/cpr3.c                       | 2474 +++++++++++++++++
 drivers/soc/qcom/spm.c                        |  226 ++
 include/soc/qcom/spm.h                        |   45 +
 19 files changed, 4824 insertions(+), 997 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
 create mode 100644 drivers/soc/qcom/cpr-common.c
 create mode 100644 drivers/soc/qcom/cpr-common.h
 create mode 100644 drivers/soc/qcom/cpr3.c
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/spm.h

-- 
2.29.2

