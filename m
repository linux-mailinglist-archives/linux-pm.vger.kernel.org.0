Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9811A44C147
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhKJMdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:33:21 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40043 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhKJMdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:33:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2B1DA580869;
        Wed, 10 Nov 2021 07:30:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Nov 2021 07:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gYLYvrAxI3X/3
        c3mgOA/Ii05B95qk6fjjUUXWCEYze4=; b=pmP0n9tCtUd5+fmxb+wk4r2GCSahZ
        SQrrpwHfb3VmoZQ57cQB4s44KDOsWucev0maz7se0/iOJjVIipx33W42cAHKEo9B
        lnwT/Uh3Wfu4jsAh0Nre617VfL6nxvn4aF7kFwTLQKsot1JgbQm5zIiJGxI1PDdg
        e5/3gLCUWM9JzxLXrTAXDzBZsDGD8QS6/dBBHnl469V9K+55338CQCT2lHp6QQTc
        FhRyI14avHlAl8sS+U8mLxsN2ejvpA4QxAHeCy3umaR1lvejIVGhvj68Zjg1gJPY
        UPZnvhOVF1nUPmPQfzyfm9q21JHBpzhccNHf+Odpiodm0ZN3PPQ2JWsIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gYLYvrAxI3X/3c3mgOA/Ii05B95qk6fjjUUXWCEYze4=; b=eE6XjD0U
        Qmp6Jb9lg7cVtUSy649F7ycszzEbHpm1OviMPZQT59tAcpfTWabixqNdvxinI+sN
        h6W5DEXM2Mri11pEd/kWRgWz00/qjwCGHQqqmPfBgRfOCdNfqJuQSw4am1E1uRzx
        Inc/eeinJa08g0ixjbPgyLoeMvaLhQVE07PlhWoYVDnliWIZGYHVz3Pp2ppXJzeN
        v2fDpYApGlpSKSb3f8f3+dlrAXXH8FbvBcrpOfLoaVmTETArFdKXdnf/t0m5h4ir
        ILgfnZjj2oih24rQ+4HAfvYy0/XBrIoufAlEbISjaZdOVAlFiw3/6mg5Wmy+wrB7
        JMamQRskMxCaPA==
X-ME-Sender: <xms:X7uLYTos8YQZHnv4i9ORFjaqXVtg1Hhv2Lk_2163X0IEDeWeS7U4Sw>
    <xme:X7uLYdoM2qEYmbhi4HPgXv9DU2_xfFNbHNxNKhmCOkKmggsAj31WP-wwBbGwT0tTx
    GH3-EAgercTSAjJGwc>
X-ME-Received: <xmr:X7uLYQOtu62PkUIkrI9J52FqFZAKaOLBgOYvRrNwT21mB_b0XT8_CcnhkpxKa_0nfXm2L9qtRds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:X7uLYW7IAPRnLcvVbn52WORMfIEz3j3V1sfXwXqmhnZa9q3rodFm1Q>
    <xmx:X7uLYS7vE_6-XYSIcXX_MrzSlURSIkzQAEXin_-Z5yOJs9ALYQpt9A>
    <xmx:X7uLYejGrvrjhD4XHWFdQRHUj8BcNvXhetCzOXBaVvPaIU2Aqw3Jtw>
    <xmx:X7uLYepk153_MYzI8iY7WfhnwPS2xqZ8qzuVXXxDiyDcshy5DDxKnw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:30:17 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 4/8] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Wed, 10 Nov 2021 22:29:44 +1000
Message-Id: <20211110122948.188683-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig             | 1 -
 drivers/regulator/sy7636a-regulator.c | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6be9b1c8a615..3e515a3fae73 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1199,7 +1199,6 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
-	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 22fddf868e4c..29fc27c2cda0 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -7,11 +7,14 @@
 // Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
 //          Alistair Francis <alistair@alistair23.me>
 
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/mfd/sy7636a.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/regmap.h>
-#include <linux/gpio/consumer.h>
-#include <linux/mfd/sy7636a.h>
 
 struct sy7636a_data {
 	struct regmap *regmap;
-- 
2.31.1

