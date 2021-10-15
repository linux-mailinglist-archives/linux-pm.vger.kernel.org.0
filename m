Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8242F0BA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhJOM2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:14 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57003 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhJOM2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13FD3580EC5;
        Fri, 15 Oct 2021 08:26:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Oct 2021 08:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=44klJtXqtdBjTuu73pipJjRiQc
        AkB1BkOOwa02Xkj8w=; b=RJegcv7Z1vQDDRPesYzZeefBu8dPNn00MFFJoVZ+qh
        iuWlfAAH4an91F3JleG5KSGTb7k66LTMmrIVlKyJVNyH3/4hbEmUZSa1mEa1lQqq
        gAGdBhRGKtKoek0qA/2uN1b09dlVfVX5rWi64PbojGRThIQHU4zDKNZQD9JSVBsY
        DN04cz9ZtXPnAaCTLwR2meqjLSs6kCINqrQ7vX9c+MkN6rQ307/tY1NitF48qJvU
        nU9RECsspNkKI+yVS7vlixYLyHEJzyPVvLrT1wh6ik2RYVYImuIwIyR9O+Cxq76S
        UA8rlsrxlOKYTF5nYbQAvimmBV/XVP6Fa+CRfYtYzZvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=44klJtXqtdBjTuu73
        pipJjRiQcAkB1BkOOwa02Xkj8w=; b=d2B0lOirCBqpayfy0gP2oxTt2mk3YHhm4
        uXKAfOc1kfj95nOv889u17hFaUMwiu6lfoymoWiQRfkjm2nvSfwpcF4ta4qaZ/ll
        bwyiGFwhqkLYncdbrlFb0UJH4seHlXJEkVku05Ej1j0vhXExFCd42/atypYY9EDD
        2TktEe7P7wXkX+wi/NzBW9WVutN3iIk6sa+pGrSQ50XcAmvofaHJZCKv8f8GDOCa
        rvNem/FIYefvZHGOhX+3DtZqxJo9ibyyRBXFcJmSGOs3HI01JRCYgjgXGd0IiazH
        8LLUtmY8988KpRiGgPehsJUMipa6HOq0uBHtPcXJtiy57rtAMN7Sw==
X-ME-Sender: <xms:WnNpYXKHG65Rbd2ug-U3SNBIjgvGa-v8t2LvA1bjwYztJ9WvM1-8vw>
    <xme:WnNpYbIzd96aKYDAi6qeasCTh9OsncR4P4davOrPS9YzVFYHWgmHoosgPs4bdXKTg
    Ou5EsiCpydS4eJqmEQ>
X-ME-Received: <xmr:WnNpYftGq8y6vaHsK-sXHL2dVnlcV9FSLVWUSTDUKb2pNZElZlnzLG2jq-hZYE1BjqQoZzuEgSrq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:WnNpYQYn-mQWGuHgriOwETa3pmDaJN1tSnF1u2JJRvdaDf1j9rhyhQ>
    <xmx:WnNpYebFXSex02e6PKxnB6ejYZZi-uTZCr7UBntyzjjWY_tUFphWRA>
    <xmx:WnNpYUCDqGcCAhWFi0RaXHjVovhAu3dXc8O-VTg8o7kCG_kHSW0_RQ>
    <xmx:W3NpYTI6GZ12ufXa_EOmljh8ffJHUlPG6JRxu_tmpruXoQgsVnOObQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:25:57 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 0/9] Add support for the silergy,sy7636a
Date:   Fri, 15 Oct 2021 22:25:42 +1000
Message-Id: <20211015122551.38951-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v13:
 - Address comments on thermal driver
 - Rebase on master (without other patches)
v12:
 - Rebase
v11:
 - Address comments on hwmon
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (9):
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
  mfd: simple-mfd-i2c: Add a Kconfig name
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
  regulator: sy7636a: Remove requirement on sy7636a mfd
  thermal: sy7636a: Add thermal driver for sy7636a
  hwmon: sy7636a: Add temperature driver for sy7636a
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
  ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
  ARM: dts: imx7d: remarkable2: Enable lcdif

 .../bindings/mfd/silergy,sy7636a.yaml         |  79 ++++++++++
 Documentation/hwmon/sy7636a-hwmon.rst         |  24 ++++
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 136 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   4 +
 drivers/hwmon/Kconfig                         |   9 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sy7636a-hwmon.c                 |  75 ++++++++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/simple-mfd-i2c.c                  |  12 ++
 drivers/regulator/Kconfig                     |   1 -
 drivers/regulator/sy7636a-regulator.c         |   2 +-
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sy7636a_thermal.c             |  94 ++++++++++++
 include/linux/mfd/sy7636a.h                   |  41 ++++++
 15 files changed, 484 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c
 create mode 100644 drivers/thermal/sy7636a_thermal.c
 create mode 100644 include/linux/mfd/sy7636a.h

-- 
2.31.1

