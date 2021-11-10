Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E6B44C140
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKJMc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:32:58 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57515 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231737AbhKJMc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:32:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 66A8C580861;
        Wed, 10 Nov 2021 07:30:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 07:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mo4lDbGJIutF/
        EfV6ESK2Jau5DqaSfJJnyr+9T7QDB0=; b=ku0trG0+QwKBIi/X5vSbfI0chJffN
        XwkPf+wUILzcxhY8PNy6oQjTnqKmicNSACu4BQpF5jPXHuiQTFPaJzOy+8zDkGWT
        +VxOKPlEuyIfNPGTBGSoQoSVcKkZ92I9V6LF3gRwnFCBG2LslAaOtQEHNg8eGKnl
        Sm9pVA0zdFcELIrwFx/OA1HdUR4cdb0KhkGIDwWrh+VbyWmeKJZlVo3urxOALCs8
        Jb3GRmI/VidKTnPsVTbSmlNBQfz2CsFI+DfmbENyTz8bh5wcsU68FefxtaG4Uyfb
        XdvBvCYy+G3GbcDSbyB/FWiwZrza6mmI9ubxsiXkTRhglQRG5mhPVaNtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mo4lDbGJIutF/EfV6ESK2Jau5DqaSfJJnyr+9T7QDB0=; b=nyRb0eSF
        tZlmbcifmpVzSNB4kP07GVnCJgufp6QGhWYScyH08ZexkO2x3Gmne87JLxS769ah
        FEDoRCRbbUPDOei6PBsmjt4WL7vKaCaE3y2sKSgw+tpTAPXWX9LS+6y8Yu4Y8Tej
        J6yj6sNvuYjmPk3tC4wWnFxta5r+t/YSeJkS+OrdezTPRGg+kj96CnCFIbgcbWqY
        M5p9CDzz9YQxaEP8BgvpEBAeEGFwIL1Pc/ZhBJtgPw9wHayvonITrxjrLXEGPn/0
        U0w8pb44pu3ti3XWr9RhhVwrJhaSwPV0NKlTRLBBZhY/1g9/g3VgjjR5LHDVOotu
        3MKlfZygAV/jvg==
X-ME-Sender: <xms:UruLYckXsehKlhIggvOQbYoesZekbXmG1_yfU6BSEOZaCVIGmroWyQ>
    <xme:UruLYb3SB7I-eIszFsr7yTPbJ7oWpmpfcJVA97QyxH8PaayU42sJlWBrCNArUIf6n
    5P1Ro98EJqiyvN6zaM>
X-ME-Received: <xmr:UruLYargRvjyZ3gjeII0Ch-hL71O-7eFNXjV80DQSCkgrHJ6sqCqWAuZufR8tlbW9fj_5yDjB3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:UruLYYnQoTHdtmrQVMD7ff0_LKy7JIt2AW1duVbTy9wj9RZPDYg9qg>
    <xmx:UruLYa2k0MsTV4tuskv7wUH3lQ0nilDHVTWDpxnX_MziaqfNNv2Qeg>
    <xmx:UruLYfsnLJJ6jBrwSPlCg2u5kEW5IOafBy8CtZx_4TClsTDIz77dgw>
    <xmx:UruLYTE2SE343DOu9iEHQyvmSSlgU5qFPxScb1yxA4Dcc06wJw_g8w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:30:04 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Wed, 10 Nov 2021 22:29:42 +1000
Message-Id: <20211110122948.188683-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
device so that it can be enabled via menuconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3fb480818599..97976ea83fdf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1194,7 +1194,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple Multi-Functional Device support (I2C)"
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
-- 
2.31.1

