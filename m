Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C475455347
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbhKRDVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:21:43 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42007 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235654AbhKRDVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8EA8558089F;
        Wed, 17 Nov 2021 22:18:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 Nov 2021 22:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=8t+BKJ/wTuG/sd5P+Si4jIM2be
        U8XseaZWGylrCi2gk=; b=iMTNRNrT1YQKdV1G/Lb7jrpue6qZv3LK1rahicqqE/
        WnoFGHxxhFUevG3lr+eKDquxr/SasNj9bwpNOLm3Tv0iyiAyR8E0mHqVAJAJ1p3k
        rzOqTujgYMwxwHAsvgBG8alw/SLTB0gc76qYn9KHKYbSWbOQAReFH8R4Jm7Y1P/C
        McT6g+46iKUt6cjrhf4YfPXR14YHg6PXKxn8Zrv8iACrhQMEvDLC6RQAGx0GvpoS
        S5haLi0E9UQ2sy9rpVM86E4GXSe0T9RA6y+H+rszGSIchQIm/4xN7cC0muv1K0+7
        8I+Kj0lPfa/iZUAP8ZH32vRVawug9cSoQO83E/M+IVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8t+BKJ/wTuG/sd5P+
        Si4jIM2beU8XseaZWGylrCi2gk=; b=A3rOpNTnFjhG4YabCtF36zymC9H+KiSw/
        3ndIC4NL+rJ0Euxpp5c5qVcKtbfbo2f3Pt9UDVyAvwKyTmmmH+ZdwsddIIwqZ1P8
        gKvAfx0D8zMOQ0JAjzCzHypGBspcdWGFwzMELjVQwXWQh3qsGQl+sfktiNSNg0mX
        R8K+YPj/6eJm1/5wGahOUsMY3nx6SMnyh7inedhdUyXRwqH6mOhCq51BXASzjyrn
        7WkRYOfO7UOErJa8wP+Vl1h60BMEbEQ2zAr7Uuy9w4FI3iUt18hPNwLnnKUa9Q1G
        xzrrD0jsB47bwUZHhCUZc8iTHlnmbYdE3fX7+XRqToZiCYAh84jsQ==
X-ME-Sender: <xms:EsaVYXqzsPwNiQ4UgtWPTRyKJer55Ea_-as5A_S12Kk-T7CiBNsRvQ>
    <xme:EsaVYRoj6uA0PHzaymYrtABSTKMsU9kFpaGJeqURav5gjiYS8ep2OwHnFI7SO7UuW
    V6BwldEAAiVEc86ZQ>
X-ME-Received: <xmr:EsaVYUOmkv4BOwrMwLWZRJnHVr8OUxUjowUzBKSpDpGC2E_V9JfxKAwLLaNaSIBsC-dcXDVJrbH_MD-DTqYK4rRSjFu-pIo-21ehMJsIAqJEviA5wjdZsQRsjz0m3yfoZS5-Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EsaVYa5oeMrZ1Ohb8a_Kq3zstkwB49pVp02-ceg985jiTFv1cMjEpA>
    <xmx:EsaVYW6q_ANBJAU02OwbLiEUrKJqNrd7GjilXyxrHtU-LCG2ZJeXaQ>
    <xmx:EsaVYSgBAraR_zJyu_DpvrNvJcEhEMN2Opj5wZLTC0y_Gu-52SdNzA>
    <xmx:E8aVYeitOv_WVhGv9wdVnFFHuwuVle_Sw0_BzvsVmzExsCL6IHxmjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:42 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/6] DRAM devfreq support for Allwinner A64/H5
Date:   Wed, 17 Nov 2021 21:18:35 -0600
Message-Id: <20211118031841.42315-1-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds a new devfreq driver for the MBUS/DRAM controller in
some Allwinner SoCs, and enables it for the A64 and H5.

The binding and DTs are updated in patches 1-5. The MBUS nodes already
existed, but were not bound to any driver before; they were only used
for their dma-ranges property. Finally, the driver is added in patch 6.

I am not quite sure the best way to handle DRAM register range in the
DT binding -- as a separate reg property, a separate node, or simply
enlarging the MBUS register range. While the DRAM controller is a
separate IP block, the MBUS hardware has the ability to double-buffer
certain DRAM controller registers, and the hardware MDFS process writes
to some DRAM controller registers as well. So they are rather tightly
integrated.

Like the driver commit description says, this driver could support
additional SoCs: at least A33, A83T, and H3. I can send follow-up
patches adding compatibles for these, but I cannot test A33 or A83T.

Changes from v2:
  - Remove unnecessary quotes from binding
  - Fix issues with overall minItems/maxItems limits
  - Added tags

Changes from v1:
  - Patch 1 was merged
  - Drop patches 2-4 (support for devfreq drivers without OPPs)
  - Convert the driver to use dynamic OPPs

Samuel Holland (6):
  dt-bindings: clock: sunxi: Export CLK_DRAM for devfreq
  dt-bindings: arm: sunxi: Expand MBUS binding
  dt-bindings: arm: sunxi: Add H5 MBUS compatible
  ARM: dts: sunxi: h3/h5: Update MBUS node
  arm64: dts: allwinner: a64: Update MBUS node
  PM / devfreq: Add a driver for the sun8i/sun50i MBUS

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   |  91 +++-
 arch/arm/boot/dts/sun8i-h3.dtsi               |   4 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  11 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   4 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h         |   2 -
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h           |   2 -
 drivers/devfreq/Kconfig                       |   8 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/sun8i-a33-mbus.c              | 511 ++++++++++++++++++
 include/dt-bindings/clock/sun50i-a64-ccu.h    |   2 +-
 include/dt-bindings/clock/sun8i-h3-ccu.h      |   2 +-
 12 files changed, 634 insertions(+), 14 deletions(-)
 create mode 100644 drivers/devfreq/sun8i-a33-mbus.c

-- 
2.32.0

