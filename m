Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE543942F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhJYK41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:56:27 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37855 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232960AbhJYK4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:56:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id D693F58045A;
        Mon, 25 Oct 2021 06:54:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 06:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=qE6SMYoRQzVad
        KkaxPJOujbvaC++jF3gyfOey8v1upo=; b=Hoev4zvS9ET4XlsAfsLElP3S1h8/A
        pnK2HRnC0V7y60HoURLkek+NIkyjiCgyqLQPvrnCYevEzDn5bag2IiGsGtaCBFIO
        FUVDBWt1bvVTgSXOPSo37mFJ/MxbIGnbdSwkeAnjlb83R1QAj2H0nCAa4l+Nc4xF
        7rQ92ugfNkePmnDi5eK5MisMhTaCh2c/0FTV5kGY96x+g+N7I8j2s8zkni8wX4EH
        Goq5+PezE2j24hoBXTT10DA1hULEA4BaNBxGj/DDq+H0RZrgqAk64+WycyvAVyAh
        kS2dPbwRgZdCHCvHqP1VAnABz6M1GGuMgXZtj3lDRTude8YtyUxoQ7xvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=qE6SMYoRQzVadKkaxPJOujbvaC++jF3gyfOey8v1upo=; b=kYznf7/6
        TY/wCgYmnnRYUE417/4eqa6irsHlBEka7VUGHAaoU2fcpkeotmx25dQi84qQw+/6
        JPKKtJVt1v5x1REhN4+19o3tG+cV2AX4iu/OMtqpseXilCQJuKlJtmcBj5rWkFiX
        ByIPXJ43nExftd/437UarJfNZmHoyuhv/7sM2RoNp/0rM/mnTGVYusIy5zpwJPgY
        7yQrbU/b4hQ2tcRa06rX0Gv+sNa9vpExzyeUHfol3iyhLrKPDiDZxac8+WL8TWby
        QyyX/zc8BaklQxyjoowV64eGF9t4yt9o9p5O5+K8Sla1uKD+m+IUL75SbYtceBKZ
        bB2WfQbIoR5SiA==
X-ME-Sender: <xms:yox2YSbb6dXJ_sK15xWZ8M3a-LdwVfbEj5vDOOeqDzDulElhxnf8Cg>
    <xme:yox2YVaPdHJbZWCAxT8NnIklw_tplqatdI3J8PdAF20HkXBX3WdLsU611cNE5sQrc
    ckolfGjEugyNd13q5E>
X-ME-Received: <xmr:yox2Yc-jECMVtxTdLlFI6ypzvIOwoOwfdi396yiClUbvOOe1OnWCeFE5FZRtxmx3c_0BhSrdyyUr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:yox2YUol-aro3dap04uXBMEYivfuwdYQGg6TBnW5hqCb5ciqwT5pLw>
    <xmx:yox2YdogEWyJmqYUZrczVU31hxaZM5KTZ-81WzWFE7IaSTsW1k5r6Q>
    <xmx:yox2YSR1rTw6i97DLHU3bV41vibnfHH-Djusa3bGhn4rI1HoqkKp_w>
    <xmx:yox2YTaUKfTp5YZE9wm2-WMZSVEbPiUjMAszKvyN--oh-xsik8MF-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:53:54 -0400 (EDT)
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
Subject: [PATCH v14 4/8] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Mon, 25 Oct 2021 20:53:05 +1000
Message-Id: <20211025105309.37942-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig             | 1 -
 drivers/regulator/sy7636a-regulator.c | 9 ++++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4fd13b06231f..21077cb14625 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1199,7 +1199,6 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
-	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 8360b3947ead..29fc27c2cda0 100644
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
@@ -70,7 +73,7 @@ static const struct regulator_desc desc = {
 
 static int sy7636a_regulator_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct gpio_desc *gdp;
-- 
2.31.1

