Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25044C151
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhKJMdf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:33:35 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52763 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhKJMdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:33:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 99CD6580869;
        Wed, 10 Nov 2021 07:30:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Nov 2021 07:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=V8tCZDVlOk3rk
        cprQ+2KQBwTR6cMGYHthIRm9/6DahY=; b=ZXw7OatydzINJDPuPGioAtcFRFMCD
        1l6tiHfkkZjk1WQlh01tdyQ4GEEYW101PjLVbHIDjon1HC965eaMhA3ahxACNZW9
        n//qfyl/H/r4/Gd6tScxiylzSSRLYGWXSCu+nThcKGhgGbRqKYo8XvXcVJt5nNap
        RY6HuMPfm9/L1jv0tu+My87bJr1Exri1Ld3xm+YGyjrG35WVq8XJpVXB28KQs/0y
        SqEfjHzpkEboAJr59ej6R6CrpsJ7724gc56nDb5dM9ej/YlhTuzJokcPDfZaBgCy
        JtN3gPmUC7KQQ1D1a9/qEpSpxDeHxOcu23b7ocew3VCOsPHS796MCqmXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=V8tCZDVlOk3rkcprQ+2KQBwTR6cMGYHthIRm9/6DahY=; b=eITkGZlO
        h2kmKaoP8eEFbXEgVZEupvTbXLEPlH2YJP95AgyMwRYZhbKbDKG3TzUsLf1ErAwA
        BMsFTtYUWu8vXsV0Tr9D0U3x4jRyVG5ngrKZIdm6n5EAlmbW9S7vFs4kEpAjQFbi
        ZD7KOpIi9iqkzfx7t8/aPGilSxV54Pon3K5rXu6bO44LvuALMWZCEfXeCSqGQSe6
        UaaHAl2HcXmbuiihI/UP+oLZwy1jr49vJRQjZ8/ZXQVJI86aHWUVHckJBZmsoNWN
        6R76NYsjyTAoUbEEdYVRx8PKHT/KKr0FqDwn8vzG96eaj8ikJVLtsl4eq+C1yZ12
        hVuW+wHBR53wEw==
X-ME-Sender: <xms:a7uLYQ5dR6H8zdmYctWhH79PYByM681O4V_sOlYYtUwgKe-cPuDGPA>
    <xme:a7uLYR5P2_22-Br4CGtCigZ5Luuo2OqC9er2rkXDc5c6N7qvrFgbb6EC4kxX_kaBk
    kXDXg2pF4NaB12rbdY>
X-ME-Received: <xmr:a7uLYff7fQpkHkgEdNl33WU4B_SOlbVWZYUTuL7mpSmbNe9JohUHEx4_uEiWyAePkFOcn4eqtPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:a7uLYVKem2Zc8NNFmOQ5ohDz3du-tzQEDVVcKVAmbSXRGH31mgm77g>
    <xmx:a7uLYULZW8y_Rw-gaLaEYjGjpu7Jigs794JdbOLbpic5CETuwpa1Aw>
    <xmx:a7uLYWxpC45WDQZXl4Y0hC_4-MoE8b77VguB-IW-ukdnv_LAJiRkUA>
    <xmx:a7uLYV5josnLmeLA1y1BrGhU9h0h1QwmFBN9pFAN9mBjfe0ECIVXyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:30:29 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 6/8] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Wed, 10 Nov 2021 22:29:46 +1000
Message-Id: <20211110122948.188683-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1fbb8e45e604..6add186e189e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -223,6 +223,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
@@ -239,6 +240,7 @@ CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
+CONFIG_MFD_SIMPLE_MFD_I2C=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
@@ -251,6 +253,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

