Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D904279B7
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbhJILxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:22 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41907 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244813AbhJILxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E6F48580542;
        Sat,  9 Oct 2021 07:51:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 09 Oct 2021 07:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=VlKu10pGyqFtO
        YC6n8tkW4+yJlH9Ol1fiFnYlC1VoXk=; b=FBAxtdRDWdUC6Wrt3CIS9wfoL4eLP
        jBE2lQGcLR8FW1xhwVn+NehfJItFDEg28apzq9+m8jChVAYLAFRshAksw+Ywq9Ci
        y5qXUQAGgt//lWJFV3+JpEzvNPGfZhVhGJQGxniDMXIlUMjpORPrYpk3QUBKlY4h
        MsAMB0hXOwnKswxt+eyLcFTgi/S3mP+3PFOx88ATLODrkgarJdiELr/h7MJY/O7r
        EjG04OJjJZqAkUAenK8yUmSJeEMeK9jkjXm6FbR26evgw67hhwCTRyCFHEyvdGoK
        DmVwzsZE+5pL1DnsnEYontd/NFehtZPRcncuncnlSFqJNMOslkOIBV+dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VlKu10pGyqFtOYC6n8tkW4+yJlH9Ol1fiFnYlC1VoXk=; b=H8bCdJSZ
        0eSNuWmv/TL78WVfJLGiaREAV1DcMdHel4f9GspdXXAA4ykJ6Ps9s9qEHqcwuxeB
        +cWZ345HamflghfqMw/3tbZvioVHIaKhfildOIwp4JPws6JkNN9uFjMdLhQ/5r5o
        Oa/yfsVSjDXgD3Btxo07vD0vqPh6ddtFNhFpRsIYgmO227+SgkcN5P1EM6CRZJ9l
        fXVZ4qWW8a1J86ijlv7uMAwjGjQY38DU8wxugNPWvOumMpd/w0EPHyXOhoT5CXw7
        dJWMPnhONBn6URSlSsNmaysAPE7+YQStvPcdsHmGrhFdtyoKKLbtBlqV1iF63ReR
        00MHPX+oWxVTsg==
X-ME-Sender: <xms:N4JhYfJDe5ON2K8HDkSwoHRYC5aR-nns4Rt2oaMDYQhom9_0HJu0bA>
    <xme:N4JhYTJ2lVFKASUuLn4A7_UUZOv7e8XuhYZfX83W123cRr4lzyjSC7cYUMg6UhpCs
    KDEB7oSfNfkukcNH74>
X-ME-Received: <xmr:N4JhYXuXTE4TkyJg6TY7Uhx1vmdphhPyA1dCDecym3hf2dcmjk1BLMBkJvOdKZ7_Tb0y56v9-AVWl7uvoQY-orseG3y8VGJLGoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:N4JhYYZt_LpBmHa7VFaeNIwt3CkvtNYe6Vq4S0sp76f3fVzMLsYieQ>
    <xmx:N4JhYWbKrM9kLr48gj-COC_Nln-69SmKhwWESZ8WkoiUKILKUjN0PA>
    <xmx:N4JhYcBtWDUvwgGTa8IbFAXG5BE0mZJwBF9pf7KaB_Jp2Q6ZZmjAKw>
    <xmx:N4JhYbLs9tIClhXGGzxZGTiCaDlAPO1Ga7ePhgENE4yM9qiySKB51w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:14 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 04/10] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Sat,  9 Oct 2021 21:50:25 +1000
Message-Id: <20211009115031.18392-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig             | 1 -
 drivers/regulator/sy7636a-regulator.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

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
index 8360b3947ead..22fddf868e4c 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -70,7 +70,7 @@ static const struct regulator_desc desc = {
 
 static int sy7636a_regulator_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct gpio_desc *gdp;
-- 
2.31.1

