Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B964204A6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhJDB3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Oct 2021 21:29:30 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:53345 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhJDB3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Oct 2021 21:29:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5631E2B01318;
        Sun,  3 Oct 2021 21:27:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Oct 2021 21:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=HdSTkWjTFUo6RFWfKSuzPaUvO9
        DhW7mD54XQttsAuQo=; b=EihmDYib3vvy0NlGOt2bP+b4O5o6ETorkH+AHsK9KU
        qtdzDzRog9aM5MPhiA9Im+aOOag4Ccop0NXGDvVxQEeRk7Yej7jDOLTRqioLhJnN
        HmBU1DF15jvbGzbRaxJAIK6c+e48IFiB7FpX+Z6oVztWv4Du6W4iy68s1+HG4ihF
        gjEdHaMRVLwl9a6CHHL6Hm+LTVLmiw330xuunuXLE/p0VhOaXv+1BgMEqFXUmz+V
        BrhaXwg0empa/KBTos0BP/pRu6b02H4AjtK2B5u4cFRyUpb68+aY25RvppGNjRqe
        jEgUS0DUY/pVhKFhW7LJJ+zPYeJnfw+BwJGCI+vZFwjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HdSTkWjTFUo6RFWfK
        SuzPaUvO9DhW7mD54XQttsAuQo=; b=ZYuil6dNYYFK5fiUDNdmXlZZwMdiOcZh5
        pC6mhFAnbRJMMhYYPkhKQSyq2RUAJphAshZ0QpIxYp5ABtKE0K8ti1gTYhCu1fW9
        +OSenETXwZgjuPWRHo2Z9yTtkInFT+IQcTTPS522yBqurXndvuseHVb9p8n1ece8
        HWCeARejUw+E+2rx3qggN/WVK4pTUJrlzsDfYsKP/hxos87FDhOx5eITGz+mMxVQ
        V6GUGz4kCfMgVNmYGjBV7lSKDOQZmkan4cW98r+5WFPtG/9SIutmRpZ+Ng3ITq6d
        UzLM777Hc8wf2kG3zXVMqzBf38DVbmUgNFYqJHZtS8XNgVXUpaN3g==
X-ME-Sender: <xms:jFhaYYphPU6q1eCYfGQfTMfnp3cWWivYEW4D7WCuReqTcaxZN3r6Pw>
    <xme:jFhaYeqf8lSyZaw_JQxG1FrFKdtrlBkpgkkz7uiPi_kIR3SPy-dM0aUQLReuhL8J_
    iX7xbx0fBVBEKQi7g>
X-ME-Received: <xmr:jFhaYdOqEnbDoDzd5fzg58mRgHlG7c20H-8Igqy_a2deQSLS7tl75oRh1MYUoDcd8lnHOFfWBw4wc6h2ruKNjzNUgrVrRMVrzSzCX_-3-yFwg-tylfoyNz8MkFAe6ddi1oD_Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:jFhaYf6508RgTH2HnXhsJp_hGRpjbtUnW6axs0T2N840WXpY69jTiw>
    <xmx:jFhaYX4prP2rPIln-tqCgnaJBQIhP48tnx04gN2GTZbg9HTu0h0JHg>
    <xmx:jFhaYfh6o7S5gggjRzdMCURpnC9DOs-mYYg8g8Egw-T5UpUWKDcacQ>
    <xmx:jFhaYeKOnGGNY5azfLaVwM7JA2rDJLcSHfdaIc--O6TdEaOEUCtrAL_HbV0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:27:40 -0400 (EDT)
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
Date:   Sun,  3 Oct 2021 20:27:33 -0500
Message-Id: <20211004012739.39053-1-samuel@sholland.org>
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

