Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB24362CC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhJUN0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:26:46 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:51418 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhJUN0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:26:45 -0400
Date:   Thu, 21 Oct 2021 13:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634822661;
        bh=BKCG0x4LpVNEYm6WhlTKKknm6ccE1gKaMUfpd0i03Bs=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nMFz2HcQRDNWrARSVs31GK0uV5HRLJYR9omVvUDlX0/HzidbJDi5/wq4pVN6dyrM4
         /RwAsMguHhhHR+slVCb0hRQha0AmT9Ad1sYnBTWFd3Nidk9/j8cD2e05+HgUNMYrGe
         XVW4xMAsS2cFJBaK5Cvvco3+9J18OC1xGco4q/HI=
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v5 0/5] interconnect: qcom: Add MSM8996 interconnect driver
Message-ID: <20211021132329.234942-1-y.oudjana@protonmail.com>
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

This series adds a driver for interconnects on MSM8996. This fixes some rar=
e display underflows
and provides a slight heat reduction.

Resending because some addresses in CC got mixed up.

Changes since v4:
 - Rebase on Dmitry's icc-rpm patches[1].
 - Combine SDM660 bindings into the RPM interconnect schema.
 - Clean up qcom_icc_node structs by removing unused properties, moving lin=
ks to external
   arrays and using the same arrays for multiple nodes where possible.
 - Add support for Aggregate 0 NoC (a0noc).
Changes since v3:
 - Expand DEFINE_QNODE macros in msm8996.c.
 - Commonize probe function.
 - Don't rename qcom_icc_set in icc-rpmh since it's no longer needed.
 - Code style fixes.
Changes since v2:
 - Dual-license qcom,msm8996.h and move it to the dt bindings patch
 - Remove interconnect paths from CPUs since cpufreq driver doesn't support=
 icc scaling yet.
Changes since v1:
 - Split first patch into 2 patches, one for renaming qcom_icc_set in icc-r=
pmh, and another
   one for the actual commonization.
 - Revert unnecessary move of include line in sdm660.c

[1] https://lore.kernel.org/linux-arm-msm/20210903232421.1384199-1-dmitry.b=
aryshkov@linaro.org/

Yassine Oudjana (5):
  dt-bindings: interconnect: Combine SDM660 bindings into RPM schema
  interconnect: icc-rpm: Add support for bus power domain
  dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
  interconnect: qcom: Add MSM8996 interconnect provider driver
  arm64: dts: qcom: msm8996: Add interconnect support

 .../bindings/interconnect/qcom,rpm.yaml       |  143 +-
 .../bindings/interconnect/qcom,sdm660.yaml    |  185 --
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   93 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/icc-rpm.c           |    7 +
 drivers/interconnect/qcom/icc-rpm.h           |    1 +
 drivers/interconnect/qcom/msm8996.c           | 2113 +++++++++++++++++
 drivers/interconnect/qcom/msm8996.h           |  149 ++
 .../dt-bindings/interconnect/qcom,msm8996.h   |  163 ++
 10 files changed, 2673 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm=
660.yaml
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h

--=20
2.33.1


