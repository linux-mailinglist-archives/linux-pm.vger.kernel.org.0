Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0342F0C2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhJOM2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:25 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60505 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238838AbhJOM2W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6892E580EC5;
        Fri, 15 Oct 2021 08:26:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Oct 2021 08:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=yw1VucPUQqdpZ
        mHA25svfKcp/yBBqIjEZdlG3rBe/yc=; b=J+nVeIVh811zcJCO+1GXtUtwIeMyJ
        h84HRfb2BoZYwcGJn7nE0dXV2+IQe+QwI2OYEOIUlKHTDujKgs6/uE9Je4zPL7n9
        gp1Fi8SbRV8SiKepsTg+NaevzZncxRYQ2dKwdZmqFuxh0YWjOktzoSKT6qURyVDe
        OVDVBYuQEEfJ29aSnHODVJTUgSd+9+xsShQvTWrxDEnCi69JCpP7MwKRLOD2DeN2
        ayEeFWMP5rHbCySGFU/xp5jzAiORHlh0ejxLfUGPugWFvP5ggVtod0QWi3ksU2EC
        z2KgG7PyNdnpyPkMsbaz1J7bHFsoa1NiFg2YvLOQFV2dvC0DrtBkdLbFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=yw1VucPUQqdpZmHA25svfKcp/yBBqIjEZdlG3rBe/yc=; b=ltgHftLN
        HZx0I9avF4+O5DGuf2s5T+9ED4Lz1+2KsdO5p0mLykbCW6sEj6lZE2ZXw8sPxQGE
        EKRg2H88STbvSCREcQPi4730DzS3clAX6+/aezKsXjUB6EIGLfvES1ohgocwSGtD
        rumIle3bDDrd/bhAV78bxq2OpYkcs/P3q9A5BLITZDyQJ/ykqQYOQG4gCPPsdEbV
        Hk2gEYnzohaiW0LqNaqUafdaWY/GffLf5Ul0La7LBaVe7hMVY8LEI3zsqId7VNel
        UbLta3XCMc7FcTosFx7SuBgB0PdQL4gdPG+58z7Hu2I2Vn3xyZLQiF7V1uUie7ho
        tEn3YZKbCg11mQ==
X-ME-Sender: <xms:Z3NpYVpIF-fO1YFaq7pBoTvMMbm1QuE6agnGtcsAU5BZ-hMdoyAQdQ>
    <xme:Z3NpYXrG2FbJb0_0yKR5xxbWFRSX2he5FAq_jEDzwU08Jkq1ueD_vg8QDUdNyLhpl
    -Vw5onrZi6cTdYB6Xo>
X-ME-Received: <xmr:Z3NpYSN2dnjYm2bqE6O4FIFF-r8lYR1ordNEH6jZF5J9r1oR1X1vdfaAGDdDFA8rwr_TS7ebSW4W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:Z3NpYQ4ruz_c0xFTSWDgJcrDeUsXbe8KIxAh_6W-q-yu6Q8-oM8qYQ>
    <xmx:Z3NpYU6ti1z_-rLgGuyIrVKB645XrczgkpS9ZN8Ex4XSBxY3Ujafqg>
    <xmx:Z3NpYYh6-82B-7q8JD7ryhVNGjds8ugyXWg7D74Nuku44zd0WAAXEw>
    <xmx:Z3NpYfrfLxf8X0rMWG5MgGPFeCG3rMIu26wUQI8XSHpuzBb3Km7DEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:09 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 2/9] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Fri, 15 Oct 2021 22:25:44 +1000
Message-Id: <20211015122551.38951-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
device so that it can be enabled via menuconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ca0edab91aeb..e465ddd9ee77 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1192,7 +1192,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple Multi-Functional Device support (I2C)"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.31.1

