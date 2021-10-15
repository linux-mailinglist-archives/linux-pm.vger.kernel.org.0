Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6D42F0D9
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhJOM3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:29:00 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58403 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238911AbhJOM2w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7FFBA580EC5;
        Fri, 15 Oct 2021 08:26:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Oct 2021 08:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gfpmKNzWonR92
        QsaGahokwdIzQKNcF6Y0UVq38RYfWE=; b=pix9A8ezfvlwGqip+JGBA3rYX3vUe
        I00+cumWfNe4rZ6Uo7hNRa5wAwGaA+QQnIYOrb9dlqnuUMR10n+n7S+tVxZ9BMaz
        G3CtGaMJPATYNsLCM8Pe0Tobmx39eaIrp8YmG/qhyE5DuUckjTcMFb9D+K043pUC
        qLSOqT2hjW3K/hfVWRcyxJmy2B6rvcMlBE0wKWh/n41cxGo/RbQUd1O8Tjd3638Y
        lDpDA6Gts3DMTAib4r5TCUo2KHXDpyGnmCaU40UzUJxZa+DJUgIHfwiZ6QCRc38M
        y/oemYvgURK3KBVIlJ3lw5gQW0y1ZuM2/BNnIEoLt6ogQMO81cAw8tXVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gfpmKNzWonR92QsaGahokwdIzQKNcF6Y0UVq38RYfWE=; b=esaBt7em
        4FKcav7XloA98WDg3rMFWNAGTOxW9X24KyoJqs0kHQS3526vDCAUGPhraYWF5BtB
        3NV0ge0zCr65R0Xm2K9PyL3oLaBrK9gxrxubaYybqLwMHHq2ZGEnpXIDJinRrrtf
        gjkYX4vhDqNMLQxHCizrWHfz8pNeZNjGNtAd3A6cnwmTMrTEJMFznmyUWXB2NRCA
        LQf7XZkQVgmKoAY4k2O4pCX4b6cyp8nrHduOUpaFGMeDRyc94QmvebmPH0d5n+b5
        YHCbY+9ftm6o/wF201QCOb/RkGVQoGptpmqWwJNReJkIDIcEryTordHKOpr7s2Z3
        2sknaBc+HK1MUg==
X-ME-Sender: <xms:hXNpYXT8XV4RisizfwY9uelTx87t0eTmszrWZ81vzMoF6hySchHPxg>
    <xme:hXNpYYzRujkA--YN1D_6V6mym01Uhp7nLfQI2NXOzYqS22IE1BKQN_zots-3JrcmC
    NmaB5uqp6eip1erxpo>
X-ME-Received: <xmr:hXNpYc1YP_lBc_eGgCtL9zLvyAQHI8ACk3W9SOykAZHvjp8PyKxxyhhZb8V-bd72D59wPFu875F6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:hXNpYXBpoPGRneZudQrqi5PYfL1GS8jGxgCeOlqsvyjrLQWbOA9a1w>
    <xmx:hXNpYQhJi4-Y2AuJisZu0c8Quvy7aLml12KFs1fSnGo3q6xnT5SPiw>
    <xmx:hXNpYbrkMQaUuO6vAwKC3vn-j-25NZerq7wYGuTU_sKJjVJiqvCvww>
    <xmx:hXNpYczzksYIbdCdb70gmP7E4f6-g5fL6Nz2ncdcvjD9NObkDCHneQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:39 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 7/9] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Fri, 15 Oct 2021 22:25:49 +1000
Message-Id: <20211015122551.38951-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator for the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5e4128dadd8d..948494074de4 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -228,10 +228,12 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_SY7636A_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
@@ -247,6 +249,7 @@ CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_MFD_SIMPLE_MFD_I2C=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
@@ -257,6 +260,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

