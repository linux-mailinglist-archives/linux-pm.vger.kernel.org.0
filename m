Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6D44C138
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhKJMcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:32:45 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:32959 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhKJMcp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:32:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F1A30580867;
        Wed, 10 Nov 2021 07:29:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 07:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=MzRlBB10aPvQx4wbfg+Ijo0y66
        MeQc5NRSkoGcYFw4w=; b=z1XHAqHJB65dVGaDzZnlhBR5UlsTMx5s5Ze2zb2bTI
        PUQp7L3tjFoX9/f+RbPIGScp9PNx6akxSiO4sLhHHeIjYjVxrv4FqvjqKUU/Zu3c
        SRiNOrrE8r5G9PlNSKsos1wMYAKqMbcFjTs/kMj/vRlGdyQQteR68Q6Q3xVz+K1Q
        2+3SpeJhzQbJTQcusMTTdf+Oc/7217rCwzqD5NehroWBLZ3h/+/A40DuOfDwUUXM
        co98iI0SFUZX9WdvOT+q64pGDLSXmIYKrL/Iae2U7SP6tVlyAy+crN7Gv9H3laVp
        kDPYjSXuabt0vZ8IUyw0RPGske8NeJbzqjUvLg5dKnuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MzRlBB
        10aPvQx4wbfg+Ijo0y66MeQc5NRSkoGcYFw4w=; b=j81hPTcVvNVccuRp+Y62yP
        Z/qrBdRSEP9w4vjyRdoU3dQaECAiBYAQprOwFFjLHlLRDE90Pr7pikRnpvB6vguE
        9yIeL+It2GBOriqmASQ787P4Jlqu4qrxMmtkzYpXTS3L2TWU50NScLilOqZr6JH4
        FFyQ9C22j40kJ9DuJqemecWIhYAnGZvSWH4GfXZWcrGPEcpGRPjMY3I++n/J/2Fo
        E+R2ZDsnLmwsnjDYNmNm/TOAkerozSzaYMFkOs9dUwqi27MY5pJgMgFMa7idlCAx
        0nCD3Jkufg3Nr7azKk4HA8yJyBvGQn3GyzVQciJ+PjSKAj0ufsULhQNQTc3rlbCg
        ==
X-ME-Sender: <xms:RLuLYa_wHlioKdeeGMdDCzwAscHL1T8iPP4-SFIwe1V5qPgK1Iyz3g>
    <xme:RLuLYavQszxoBnQi--JMwMpUxwmHzieBMP5-GrxWGGpxEUoOKVp31C2sdePtTSrIs
    BvEeerNbI87uHWPV5g>
X-ME-Received: <xmr:RLuLYQDTDQXS26vPEtO1oRuHbsYyIR1RjvM6q9-MpEcnqyG9lF1bJb2s_1hbMU7Imk7B3_1DTBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:RLuLYSdDWFtDHINRHRx9W0-l8H2jrvNn6iZTaES3-VWXY9MGNCgxMg>
    <xmx:RLuLYfNlISeEKKf-E-KmpAciajRxC_mN5uO39ry-ONsgABBZ5OK95Q>
    <xmx:RLuLYclWu-EXmd-ltApEvdYSoa5YGnL0rSjE_gdqu4a_0CS6ORd5UA>
    <xmx:RLuLYcfOzrwgnZJxoxTQePWxCjlCKL3WHD9Pxbj5HWD0VF8dVjynDg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:29:50 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 0/8] Add support for the silergy,sy7636a
Date:   Wed, 10 Nov 2021 22:29:40 +1000
Message-Id: <20211110122948.188683-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v15:=0D
 - Address comments on the patches=0D
v14:=0D
 - Merge the thermal driver and hwmon=0D
v13:=0D
 - Address comments on thermal driver=0D
 - Rebase on master (without other patches)=0D
v12:=0D
 - Rebase=0D
v11:=0D
 - Address comments on hwmon=0D
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message=0D
v10:=0D
 - Use dev_get_regmap() instead of dev_get_drvdata()=0D
v9:=0D
 - Convert to use the simple-mfd-i2c instead=0D
=0D
Alistair Francis (8):=0D
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml=0D
  mfd: simple-mfd-i2c: Add a Kconfig name=0D
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a=0D
  regulator: sy7636a: Remove requirement on sy7636a mfd=0D
  hwmon: sy7636a: Add temperature driver for sy7636a=0D
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a=0D
  ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a=0D
  ARM: dts: imx7d: remarkable2: Enable lcdif=0D
=0D
 .../bindings/mfd/silergy,sy7636a.yaml         |  79 ++++++++++=0D
 Documentation/hwmon/index.rst                 |   1 +=0D
 Documentation/hwmon/sy7636a-hwmon.rst         |  24 ++++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 136 ++++++++++++++++++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   3 +=0D
 drivers/hwmon/Kconfig                         |   9 ++=0D
 drivers/hwmon/Makefile                        |   1 +=0D
 drivers/hwmon/sy7636a-hwmon.c                 | 108 ++++++++++++++=0D
 drivers/mfd/Kconfig                           |   2 +-=0D
 drivers/mfd/simple-mfd-i2c.c                  |  11 ++=0D
 drivers/regulator/Kconfig                     |   1 -=0D
 drivers/regulator/sy7636a-regulator.c         |   7 +-=0D
 include/linux/mfd/sy7636a.h                   |  36 +++++=0D
 13 files changed, 414 insertions(+), 4 deletions(-)=0D
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.y=
aml=0D
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst=0D
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c=0D
 create mode 100644 include/linux/mfd/sy7636a.h=0D
=0D
-- =0D
2.31.1=0D
=0D
