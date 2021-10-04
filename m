Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19E4204A3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhJDB3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:08 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55119 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhJDB3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 47CC42B01318;
        Sun,  3 Oct 2021 21:27:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 03 Oct 2021 21:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=HdSTkWjTFUo6RFWfKSuzPaUvO9
        DhW7mD54XQttsAuQo=; b=C4uEPvofM0N2qvyNjQdIB6L2vv8y/u8GHPXyVR6mpF
        YXwVIKXof90Me/gtZPHt6BJGeDKjBHFmT8rzj7+UIb1wTLj+/bxMxaADcLC1Z7OK
        G46wOlaZxxgB5RZfQ1/V7iSRAYHKMg7fJ3Z9+/R6uRdC7D+9zq24/x+AglbBft+W
        TmNEznO4pIVk+68tj51Yro0l3JP6KOIR6Hz4KRwg1wS5yU+LVygLt7u2smK4XmCP
        k36icDWHsI/HqP9pzagb88aT7TGflhhYX3GiTIyesCCDtmiNU3AxZFkbsv+VJDxd
        cM2xKaBoR5i4y5LthMaI7023ueWnUEglVSmzj5vaJAGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HdSTkWjTFUo6RFWfK
        SuzPaUvO9DhW7mD54XQttsAuQo=; b=HH1tmBGljnseQVrvMh6EDd1Dj90fH5o+j
        sva+YVHrlUBwln/czzoPe2RGZYCCP/gbdQ+d7IrR16p05ed01UmIJEkwqB7bbllm
        FfF7K1S1cZ2PoR4I9nO6TCbFWJfVALMmraFxmu0kN0zmV41VxqQMTlBM66wtVley
        iAd6Y/zF1EeJuXeTdhImQZlMvg5VhhI4RBrEJhn/Gq748X375Bs19zGTWM0blx84
        +YPyQrkQCV2GxgP3idKrGi7Yrgl8zd/uZqOoNN/nmUwy5W25Rrt69vN7cgmysFQm
        lttz9I7rEdahPjcyx3jSo8QKtrDAMmmhLURHSSPMM+SJzBTJceezg==
X-ME-Sender: <xms:dFhaYf82svvOvIsBDlffp4uB2H2ycS0QxLa8OGwXKSzAHfMHu7SLxg>
    <xme:dFhaYbugVGU7QGJ_QQOkZK_Up-OIpFTSFNQyblWxpFThtNur91nMSbdsYpnnv5sf_
    XervYAe_J8FvDcHqA>
X-ME-Received: <xmr:dFhaYdDJNHs2N8HCPHVBfHmD9rZVVdvGo3VG-SsJESxQEIS5FL0OoivgPvtGj1LP0PIUWEP20LBit865WimHU7WKtgQ-I7BTj_R5gtKqa0Lb__3TfVyXasQwjDyo_YMuGFesTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:dFhaYbc5bpMfDzpUw1TnsNBZB2r5xXASF4Km6J_-76lPOq8l63hhOA>
    <xmx:dFhaYUPBwPC7OJgSxiqIsxv11Pu_HsUdWZVTU_2GSaar8piQw80dlw>
    <xmx:dFhaYdkXX3SO4NcnUpbHs6sQqe5EIzz4ymeQ_hUxNyhxi1d2j50_zg>
    <xmx:dVhaYWvVcVBFhI7gXLpfnCsuyuPX7LfXYe7NlDIIwKKWLiQzpVj7rPjR8IM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:16 -0400 (EDT)
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
Subject: [PATCH v2 0/6] DRAM devfreq support for Allwinner A64/H5
Date:   Sun,  3 Oct 2021 20:27:09 -0500
Message-Id: <20211004012715.38986-1-samuel@sholland.org>
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

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   |  77 ++-
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
 12 files changed, 620 insertions(+), 14 deletions(-)
 create mode 100644 drivers/devfreq/sun8i-a33-mbus.c

-- 
2.32.0

