Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08842799D
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhJILwn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:52:43 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:42513 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhJILwm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:52:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AEFD3580A0F;
        Sat,  9 Oct 2021 07:50:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Oct 2021 07:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=DkQo3Y76p/829Ck2u4MWorQHm6
        enIPYpBvnzwrSnMYo=; b=nxz+YpzV0nx4lm8+onS79tFmR174TX3oWYuPn9iHiC
        ow3TQPddi2EngpJSLm8N5jylJVGZEvRjfiUtN0R4rTXLB/yfqPlHkUiyE0HWXtjU
        dQ4haf7La7E0uxRcPkgzjnXjXKDTpMM+4w6jODKtqlqAFjrjryMYfBjTbjUcMzr3
        4KkIMKdUPTNS/ttDLwZXk8b9tjgyOpZpSahiGfVzYjCIMIy0sx7fswB6mGbMWixJ
        x8hXcoK7MI52HV9c3dgcIh6SN4wSyCd7VbL1aCcD10ecvtABTCi/sxQM4UCBspaf
        4SAQIg8ookq2ILVLBtz8b0QscqALN/p9RILnqEkvSvEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DkQo3Y76p/829Ck2u
        4MWorQHm6enIPYpBvnzwrSnMYo=; b=L5mugscpkS9Nt9h7R4M2XTgpwJfJY/ikE
        dLnTey6Y25lpZU/UQA88/Mwn5VbL57zKHczO5l9+rRgJiC5B54pcx4odVAVWTSAV
        deRKnejvs2nqNP+qxLwK3dmE+3UsLTsoXlLLisXVaXNiaWPIknTdaKlGsh9vZrjx
        IpHU1O8Z3TDviX246TdSbPXotSfMyUHp+niU7tf9DrqSDllw38rYa6Jmy/F+9Xil
        jF0vVHmxwmyRiSPd4nFunVt4GR7O8NI1XPNiDNeSvJsPidI1nj0dEbgrsT233Wts
        A12aVGZQX+mBIt4lNEerGmXhSurTnNsqcudX7v7OJcnSz1vWUwuPw==
X-ME-Sender: <xms:FYJhYeArCdf1ZnD7EKrsqfgHV6ncx3Mfei24Ue_ceqUl2zjIVIHiHQ>
    <xme:FYJhYYgKycbzARkCvIk6HOSvSAfy3b13J2fY7wlttySsa7WsDvHu4Ra-55AqxEuw6
    Nd05d5PxMO6RISzu4s>
X-ME-Received: <xmr:FYJhYRkE0N9QnbrOPXDLK8mqVBUsIUGe5XX9Ezy_4Uzz48l2oDL_nQ2e5Dkto0lNK6BkNRSqzfYJFnIzbZDbVKz0HvCpfUf_O04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:FYJhYcygL-kaEBXd1ZLiNaq6RdHKmdroazuMlqqEPtZiLuGHugMleQ>
    <xmx:FYJhYTSDEnQoibc0T0Ljujxc0ej4WjYWvjqNKMvPUXiJQeotMUQ04g>
    <xmx:FYJhYXYxmZoa5aO4wRugsWI4LZ9QB1m1gqvJQJ3M2gsQr3CrN9VhXw>
    <xmx:FYJhYUjnmGh2oaHRJC0fufi3YUphKA0zUhMIlxz_i0O66LvhYbI8UQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:50:38 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 00/10] Add support for the silergy,sy7636a
Date:   Sat,  9 Oct 2021 21:50:19 +1000
Message-Id: <20211009115031.18392-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v12:
 - Rebase
v11:
 - Address comments on hwmon
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (10):
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
  mfd: simple-mfd-i2c: Add a Kconfig name
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
  regulator: sy7636a: Remove requirement on sy7636a mfd
  thermal: sy7636a: Add thermal driver for sy7636a
  hwmon: sy7636a: Add temperature driver for sy7636a
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
  ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
  ARM: imx_v6_v7_defconfig: Enable backlight class devices
  ARM: dts: imx7d: remarkable2: Enable lcdif

 .../bindings/mfd/silergy,sy7636a.yaml         |  79 ++++++++++++
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 115 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   5 +
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sy7636a-hwmon.c                 |  77 ++++++++++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/simple-mfd-i2c.c                  |  12 ++
 drivers/regulator/Kconfig                     |   1 -
 drivers/regulator/sy7636a-regulator.c         |   2 +-
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sy7636a_thermal.c             |  94 ++++++++++++++
 include/linux/mfd/sy7636a.h                   |  41 +++++++
 14 files changed, 443 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c
 create mode 100644 drivers/thermal/sy7636a_thermal.c
 create mode 100644 include/linux/mfd/sy7636a.h

-- 
2.31.1

