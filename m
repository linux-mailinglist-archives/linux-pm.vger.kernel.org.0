Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE73F439418
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJYKzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:55:44 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55049 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhJYKzn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:55:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1D55F580477;
        Mon, 25 Oct 2021 06:53:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Oct 2021 06:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=E/lvINlfaDwDv0II0+z7GqFpIN
        xVAc1W2JO3GLlW0rs=; b=tN+9t6ZEHIZv+bVrjduN7ovPJzj1aSUmxaRtHd7aLR
        LcSD9oQiesQ2l6PzKAtotOukl6wKlO3jYSCSSdANaAFPxyuh82lEawjvF8Rqkqwj
        bKTdvIPnxRXj70imyA0epfTzXMlAeA7z6ZxkU/AugJl8LeTzJutOs06xbjtNUo6q
        xAn4BwsX1AArzvsYTIUwP+kPfx4SeA7gh1Rlt25yvPNHLALCnWX7Q74w3SIXU2Eo
        W95h4+2ynnhmlQuQs+DwYvVzkmwebJkHnHxaX5O2uSyiYGViA9PFZCbrhJhpVrn/
        UYWAzQ3qe27WSnAPXuaWkJl8XEr1/g4ZPMggtopyr0Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=E/lvIN
        lfaDwDv0II0+z7GqFpINxVAc1W2JO3GLlW0rs=; b=SV4eDD63byAlyVN8/UxyA+
        vmxDbfWnIkfys16pVnx17NEzQ2xHcphKZa0uAkcwT2x4TIXT19iGM0OicRsI6Jgr
        5JCY1CRfdT/8pJ0xb+XTAj1K0Kt4bUjAhsx+Im1HVBzgtpkvXggEviywpwsGMpkR
        0lFil1fFezNAv9uBU9sY9pUaOvth6kcRHl7YUnfKOlzkkBxcnlyga1xjNOGVz9KR
        2OJnQMGXp4k3n5JUGw/C/UxucbanCqwXAxKfEcNZx1jhQJ0XMX5Q5fUp2p5+hI1A
        tqTDWQjRkDvteh9/2sUTJUd7F4X0UpaSOleHAkI/ggrTeEqbbn3DiI2cFPki5ltg
        ==
X-ME-Sender: <xms:oIx2YcBuKEAUVD9nCEmxvXOp-WOvfd6lef5oadmee3CdpQ7uIl3WRw>
    <xme:oIx2YejDrYWetbn8m7CarVGTRh9J24-p7dWFWy8TG7HmHZayEQlYFdCpbtLZehS_k
    6Q6fiplO1DX-oLz0R4>
X-ME-Received: <xmr:oIx2YfkxP8qKJHSipgDx4QdOkjY8vbtI9wM5xb8q8LNjf2xKV5flvcHkKEOIpcq8pCwvfROCAbO5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgtggfgsehtqhertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheetfefgjeeuje
    dtgedvgfeghfeigfehffdvffduveevteejudfhudekudetveejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:oIx2YSxpPSjPnnXapU4XhCHxAzW3Tl2ylAB6fbzxR5cGovnQORfpXw>
    <xmx:oIx2YRQUd6dEDRAyAvERAkW5_3l0ulG75TBHI6W1Ki79f_KXU0UJSw>
    <xmx:oIx2YdYgFKXMiKpbqmWq6HAsTjXAnt3f3LnPVEI0W4H_KBTRHqx54Q>
    <xmx:oYx2YSAs_aXQpOpVILKRjR5NFk5vZvDipS-J3C2D2EZs5UzgP6qPDw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:53:12 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     s.hauer@pengutronix.de, rui.zhang@intel.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amitk@kernel.org, shawnguo@kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        andreas@kemnade.info, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v14 0/8] Add support for the silergy,sy7636a
Date:   Mon, 25 Oct 2021 20:53:01 +1000
Message-Id: <20211025105309.37942-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
 Documentation/hwmon/sy7636a-hwmon.rst         |  24 ++++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 136 ++++++++++++++++++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   3 +=0D
 drivers/hwmon/Kconfig                         |   9 ++=0D
 drivers/hwmon/Makefile                        |   1 +=0D
 drivers/hwmon/sy7636a-hwmon.c                 | 114 +++++++++++++++=0D
 drivers/mfd/Kconfig                           |   2 +-=0D
 drivers/mfd/simple-mfd-i2c.c                  |  11 ++=0D
 drivers/regulator/Kconfig                     |   1 -=0D
 drivers/regulator/sy7636a-regulator.c         |   9 +-=0D
 include/linux/mfd/sy7636a.h                   |  36 +++++=0D
 12 files changed, 420 insertions(+), 5 deletions(-)=0D
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.y=
aml=0D
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst=0D
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c=0D
 create mode 100644 include/linux/mfd/sy7636a.h=0D
=0D
-- =0D
2.31.1=0D
=0D
