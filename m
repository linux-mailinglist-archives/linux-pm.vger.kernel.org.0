Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22D3DB836
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhG3MG4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 08:06:56 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:50296 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhG3MG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 08:06:56 -0400
Date:   Fri, 30 Jul 2021 12:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627646777;
        bh=DnTVkMNQyN7PF/kN3hZUf5ZArPpdOn2CWrXvEvbbJ0o=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Ek+XMqgmxpioWv9+WLQRr9W6kHOgU7YBsYgkdtTsDz79ZmMXaQNWaY8h6zwMJglBH
         V1fmvNDdjONJOr+EN0tCbYm7+QZxNtQ75qKee1vRS4ks0t+4H2qxd8tTEDrKdD3orw
         Z9Zvl1ThmdNm52jQLWYvCrCZgSfy10pLEYJCrTpE=
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 0/5] interconnect: qcom: Add MSM8996 interconnect driver
Message-ID: <6JHqObH1HYWVEuXCDMTC0NMw0Uz7kXUT0mxvgR23I@cp4-web-030.plabs.ch>
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

Yassine Oudjana (5):
  interconnect: qcom: sdm660: Commonize RPM-QoS
  dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
  interconnect: qcom: Add MSM8996 interconnect provider driver
  dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
  arm64: dts: qcom: msm8996: Add interconnect support

 .../{qcom,sdm660.yaml =3D> qcom,rpm-qos.yaml}   |  23 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  84 +++
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
 19 files changed, 1391 insertions(+), 358 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml =
=3D> qcom,rpm-qos.yaml} (82%)
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.h
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h

--=20
2.32.0


