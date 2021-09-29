Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2305941BE54
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhI2Eoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36619 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhI2Eoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:37 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8DE53580B80;
        Wed, 29 Sep 2021 00:42:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 29 Sep 2021 00:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=qs7rOkinBPHpqLW6M5nctLByUA
        e3O8t6z/LIIxVOeT0=; b=BZo0nvQBMEZY2FhpSC+3qwC3o8M8Ih6AFsHZp10rbI
        fdzF+vOInI3kiawzF0xd1lg0gMKKpaGoGItV9XnZAuIIn3tk7jYy66thxHFs7WUZ
        Ka3hgIB++X0U4KQ5YorXU0s77Bb8q+tr0Q3Z9J/kfv354YBDSMrGMFCJCmi5Qb7e
        6jqMzaNtDFtH7j2UPgPVtp9U7/ZxFPld3MKjSR0q0C0YKjBo/mjXwiwHk6fENSGO
        k9EiAThDYODKgYK8gdsh/OU+FzRREh/Z/2vrGe8/rar4qY9WgdU1VmiJmhmwoFro
        saMbm/ZRfSMr6wbE5ErUdZ9kwl3Y0cLT3ffZNAaZuluQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qs7rOkinBPHpqLW6M
        5nctLByUAe3O8t6z/LIIxVOeT0=; b=bXM4T2TL4EziCSFpBz82vTbxmaDuWxk83
        IOlYaghKYUqbeMVa62bPfbNrd1Xzvj4j83mItyrE9RFhhwRsWO1aN78GJ4bO6Y8m
        wFBhcLLz1YGWc3Q+Ds6kN+zAuuUiTPK8SlufLtf8yVvH37nHpfHnhEjVXRq6GKKw
        jhz582ubWfjzAkfsfmcwBKjH57ZNL1GtkebrlZv3mE6nADEQuKmKS5WUAVBYQ+pB
        n9FWQ72t0ssVxt7G7imXHFDPbm0CChlDVGiI0OdDIncMkWJ4LSeTucNjlxXcyl/3
        Z1MibOy02LeaestPqrw/nFFWRuca2zHtUyXJ+ABL4cqptI9Sd4lOQ==
X-ME-Sender: <xms:z-5TYQgFyAXG3ROp4qQnEmSlZK1GM2u86wOpMk7QWjRZtfc1R9Nn8g>
    <xme:z-5TYZBwBQbGQFoPS99gdlR-NK3BdI_y0EgkgxabJMmyZRTDNMUpWkJG8bM_FDr_x
    3EgVylAnnGnSlRLvQ>
X-ME-Received: <xmr:z-5TYYGlkg9zTFoYcSwAe8ZXs353FvM8lB_rW0DBYl3tPcXVWhZqqrQHvBBkSzHoyfLVqVXJlT92pwM4OTZkl_ZXAmgcnb4UKAWnHhHM2RGfmci742X0vI9eU41eQbTtuwHX2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:z-5TYRTK8ReBOmu_ex1QYi6GUCL_FuMHN5Dds77zQIqoegk6G-g1Rw>
    <xmx:z-5TYdzGNEy6R5LVyKw2WtHczO20KXlsZfvF_81mKOFNEk0tDQjC9A>
    <xmx:z-5TYf7v2HiznDzWxqbEHyZsozCzi01EvlMavLFTHVxmAeZ-fBtQxA>
    <xmx:0O5TYdiTGWxcKumawvrH54CQiMFIp0cdTw6LjP6iQxskWjNbZarujw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:42:55 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 00/10] DRAM devfreq support for Allwinner A64/H5
Date:   Tue, 28 Sep 2021 23:42:44 -0500
Message-Id: <20210929044254.38301-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds a new devfreq driver for the MBUS/DRAM controller in
some Allwinner SoCs, and enables it for the A64 and H5.

The first four patches make some improvements to the devfreq core to
support drivers without any OPPs in the DT. They could be merged
independently. (Since this driver controls only a divider, and can only
slow down the DRAM clock, it works with most any base DRAM frequency.)

Then the binding and DTs are updated in patches 5-9. The MBUS nodes
already existed, but were not bound to any driver before; they were only
used for their dma-ranges property.

Finally, the driver is added in patch 10.

I am not 100% sure the best way to handle DRAM register access -- as a
separate reg property, a separate node, or simply enlarging the MBUS
register range. While the DRAM controller is a separate IP block, the
MBUS hardware has the ability to double-buffer certain DRAM controller
registers, and the hardware MDFS process writes to some DRAM controller
registers as well. So they are rather tightly integrated.

Like the patch 10 description says, this driver could support additional
SoCs: at least A33, A83T, and H3. I can send follow-up patches for
these, but I cannot test A33 or A83T.

Samuel Holland (10):
  PM / devfreq: strengthen check for freq_table
  PM / devfreq: Do not require devices to have OPPs
  PM / devfreq: Drop code for descending freq_table
  PM / devfreq: Add a recommended frequency helper
  dt-bindings: clock: sunxi: Export CLK_DRAM for devfreq
  dt-bindings: arm: sunxi: Expand MBUS binding
  dt-bindings: arm: sunxi: Add H5 MBUS compatible
  ARM: dts: sunxi: h3/h5: Update MBUS node
  arm64: dts: allwinner: a64: Update MBUS node
  PM / devfreq: Add a driver for the sun8i/sun50i MBUS

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   |  77 ++-
 arch/arm/boot/dts/sun8i-h3.dtsi               |   4 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  11 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   4 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h         |   2 -
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h           |   2 -
 drivers/devfreq/Kconfig                       |   8 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/devfreq.c                     |  77 ++-
 drivers/devfreq/sun8i-a33-mbus.c              | 482 ++++++++++++++++++
 include/dt-bindings/clock/sun50i-a64-ccu.h    |   2 +-
 include/dt-bindings/clock/sun8i-h3-ccu.h      |   2 +-
 include/linux/devfreq.h                       |   2 +
 14 files changed, 644 insertions(+), 40 deletions(-)
 create mode 100644 drivers/devfreq/sun8i-a33-mbus.c

-- 
2.31.1

