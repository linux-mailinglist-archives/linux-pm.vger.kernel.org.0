Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED43E8970
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhHKEgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 00:36:10 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:49562 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhHKEgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 00:36:09 -0400
Date:   Wed, 11 Aug 2021 04:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628656541;
        bh=p6OzoMEtzDt7NEqEXpiYeEgZDvjeL0XKSnirVR7O4Z8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=sqMhd5F3Mdf0KHU8Y27g8pjo+q8APJ8hB4qhMoNuPQgbpLWrv8cibIEl7udYgWXq0
         reLYU7cR7YVXA6n8kt8tyYZOtvIVBVz6os/0jaCEfvVAbwnIpnDP1RKUwkZBk1qK9c
         hykyiOyAyyr7ioSRTVSiHSq9gNfh6ZUrpQFmmt7I=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v3 0/6] interconnect: qcom: Add MSM8996 interconnect driver
Message-ID: <20210811043451.189776-1-y.oudjana@protonmail.com>
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
and causes a slight heat reduction.

The driver currently supports all NoCs on MSM8996 except a0noc, due to some=
 issues with writing
to its registers.

Changes since v2:
 - Dual-license qcom,msm8996.h and move it to the dt bindings patch
 - Remove interconnect paths from CPUs since cpufreq driver doesn't support=
 icc scaling yet.
Changes since v1:
 - Split first patch into 2 patches, one for renaming qcom_icc_set in icc-r=
pmh, and another
   one for the actual commonization.
 - Revert unnecessary move of include line in sdm660.c=20

Yassine Oudjana (6):
  interconnect: qcom: icc-rpmh: Rename qcom_icc_set
  interconnect: qcom: sdm660: Commonize RPM-QoS
  dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
  dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
  interconnect: qcom: Add MSM8996 interconnect provider driver
  arm64: dts: qcom: msm8996: Add interconnect support

 .../{qcom,sdm660.yaml =3D> qcom,rpm-qos.yaml}   |  23 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  80 +++
 drivers/interconnect/qcom/Kconfig             |  14 +-
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/icc-rpm-qos.c       | 237 ++++++++
 drivers/interconnect/qcom/icc-rpm-qos.h       | 133 ++++
 drivers/interconnect/qcom/icc-rpmh.c          |   6 +-
 drivers/interconnect/qcom/icc-rpmh.h          |   2 +-
 drivers/interconnect/qcom/msm8996.c           | 574 ++++++++++++++++++
 drivers/interconnect/qcom/msm8996.h           | 149 +++++
 drivers/interconnect/qcom/sc7180.c            |   2 +-
 drivers/interconnect/qcom/sc7280.c            |   2 +-
 drivers/interconnect/qcom/sdm660.c            | 346 +----------
 drivers/interconnect/qcom/sdm845.c            |   2 +-
 drivers/interconnect/qcom/sdx55.c             |   2 +-
 drivers/interconnect/qcom/sm8150.c            |   2 +-
 drivers/interconnect/qcom/sm8250.c            |   2 +-
 drivers/interconnect/qcom/sm8350.c            |   2 +-
 .../dt-bindings/interconnect/qcom,msm8996.h   | 163 +++++
 19 files changed, 1387 insertions(+), 358 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml =
=3D> qcom,rpm-qos.yaml} (82%)
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.h
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h

--=20
2.32.0


