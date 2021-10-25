Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E8439437
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhJYK4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:56:43 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:52589 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhJYK4m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:56:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 126C158052B;
        Mon, 25 Oct 2021 06:54:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Oct 2021 06:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=9BJcSEnAQZ1JM
        Eh8K5qz9X3NSWkhPJwu0Qc49e7vu9I=; b=tSFm2b+nHqdU8/ZTylrrgx+150P4P
        bNF4JUuWWENp4UPFAwG/G+WNHMkg5QMSAuK+pmG/lsTsaJ5PJEqRzT7UZD7TSxpX
        dlmlCv7c9xDKQJBrRs/zRTSlwqcKJu7nA9md2A22LnN0RaBqq5s8yZeogTg6a+6t
        NydYmqPiW21a9uUP/DA+YSj7A+tWB57tqh4ssin+kkGm4crQZRTJ1hSLAsy0n5+b
        Ppu31F8wh7IOqDqhi2GqBZTsnCOZ5d7UIJ0ZQR8irVV1clFZPOQ+2xrcvrZmc/vR
        OfXEpGlhMC6MnaKrd2nnt0grorEt6KpkeX6NtkqqiUXuuwAPzf3KCMW0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=9BJcSEnAQZ1JMEh8K5qz9X3NSWkhPJwu0Qc49e7vu9I=; b=mf5WIpwE
        8PhijkI8VY66A6c4wWyBPnCMCUsoWZ+01BU5Z9E+dImi3gXxCr2mSlI9T712klI2
        2kuQbOIJ8AdgD5WdvPQispcd/eiQm0z0kgVO4IrJwsHlo/xe59oFUJ4ZhJlgxsz0
        Z+px2+3BV/3OBftqdZbvVo/AbdwAD8pIJeQZoDpow7D36M8lkJVLdogR3nf0xvzG
        fyf0Ovnh7oI7UWanj9S7Y1izXOcNAc3MdqcwQ8EpCvWwMkUxscoH9iOyv74wF+lU
        kPg4LGNbkR8oe55GlZmK1aBN7Y4ZSwX5aBl90z5neBG8PjkuyUB5PSPYVWnp20RV
        FFq5dK5w7CWBjQ==
X-ME-Sender: <xms:24x2YQmftRjVmYJOCH7x1wXTck1NDebFHi4AXuEvRjjJcPXP8aiDag>
    <xme:24x2Yf3oeGS2gyq-splCma6uVjchXb0ge18Q6dwYTy_IS6ZVV4d6RVXqnf15bE6tR
    6LhmlSS82f5FFuDDV4>
X-ME-Received: <xmr:24x2YerZao8H_PZdPNpLC11wW6LEcVv8y_hTsEbffQn0NxUC8gUNorBbAKNytUeFu_2yPmLEOHT->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:24x2Yclw4iQnKjDSk5fWGBCHmQo3A0kuPpahlWZqJn0QxZpNhXuGug>
    <xmx:24x2Ye1fTqmM84-A-_J8zbU4_tkPqB-znST2oGoQVijB5gIul-a-TQ>
    <xmx:24x2YTti8PUasQ8210skhMCnEk2o_DXXlY_Fo_CUTFIvEORC_m2TtQ>
    <xmx:3Ix2YXHnNMiS_DyfEyqdazNT3OvLnCfjAbkYNG62AYh39fc1YsuN-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:54:13 -0400 (EDT)
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
Subject: [PATCH v14 6/8] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Mon, 25 Oct 2021 20:53:07 +1000
Message-Id: <20211025105309.37942-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
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
index 5e4128dadd8d..a0b7528d7378 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -228,6 +228,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
@@ -244,6 +245,7 @@ CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
+CONFIG_MFD_SIMPLE_MFD_I2C=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -257,6 +259,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

