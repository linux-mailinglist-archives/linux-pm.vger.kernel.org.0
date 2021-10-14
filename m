Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485D42D4E4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhJNIc4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:32:56 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:47438 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJNIcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:32:55 -0400
Date:   Thu, 14 Oct 2021 08:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200246;
        bh=dYBtx/f72FXDYETSYLf5EAjO7iUAZoohiB+Y/H5mUU0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=I8a9Rl4QsX2UuPOvVMYlUxxXgztYNgff7Vaf223KD4KAhJcfPaqG/tZS9CBWXGBZ6
         hUrTCrUApoOEEtsMxuvFdPhHb1nZYwRTWnQqxj4SEzeiV78Ia67O8Y3bfMXavEEmnG
         wVFvSlB4BNVt8CDZ42a8x9etqiBLIF/+EZYCUUMI=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 0/8] Add support for MSM8996 Pro
Message-ID: <20211014083016.137441-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8996 Pro (also known as MSM8996SG) is a newer revision of MSM8996
with different CPU/CBF/GPU frequencies and CPR parameters. Its CBF clock al=
so
has a different divisor.

This series handles the difference in the CBF clock and adds a new DTSI for
MSM8996 Pro with CPU and GPU OPPs. It also removes reading msm-id from SMEM
in qcom-cpufreq-nvmem as it becomes no longer necessary. Separating MSM8996
and MSM8996 Pro will help with implementing CBF scaling and CPR; since they
have different CPR parameters and CPU:CBF OPP mapping which is difficult to
implement in the same cluster OPP tables.

Dependencies:
- clk: qcom: msm8996-cpu: Add CBF support
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.dyb=
cio@somainline.org/
- arm64: dts: qcom: msm8996: Add support for the CBF clock
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-2-konrad.dyb=
cio@somainline.org/

Yassine Oudjana (8):
  dt-bindings: clk: qcom: msm8996-apcc: Add CBF
  dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
  clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
  cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo speedbin
  dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
  dt-bindings: opp: qcom-cpufreq-nvmem: Remove SMEM
  arm64: dts: qcom: msm8996: Add MSM8996 Pro support
  arm64: dts: qcom: msm8996-xiaomi-scorpio: Include msm8996pro.dtsi

 .../bindings/clock/qcom,msm8996-apcc.yaml     |  11 +-
 .../bindings/opp/qcom-cpufreq-nvmem.yaml      | 557 ++++++++++++
 .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ------------------
 MAINTAINERS                                   |   2 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   3 -
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   1 +
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  82 +-
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      | 281 +++++++
 drivers/clk/qcom/clk-cpu-8996.c               |  61 +-
 drivers/cpufreq/Kconfig.arm                   |   1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  75 +-
 12 files changed, 935 insertions(+), 937 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-cpufreq-nvme=
m.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufre=
q.txt
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi

--=20
2.33.0


