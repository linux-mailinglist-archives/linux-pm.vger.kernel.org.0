Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2130842F0CD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhJOM2f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:35 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37015 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238852AbhJOM2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88DBF580EC5;
        Fri, 15 Oct 2021 08:26:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Oct 2021 08:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=VlKu10pGyqFtO
        YC6n8tkW4+yJlH9Ol1fiFnYlC1VoXk=; b=DH/yr1AgNO5iEXDyTbqI1RU30MYHU
        A0lhHMFFKK3erTNafah1MkGmx3xp2U+OWrUtqzI6733GmwR20hE17yWAPnLhrG7y
        W32yuZkWXXc3tqgAWVAL0oXwTEHRsyjrdQcCYXZuR72cxM+iXA3BDcWh1Gmop0Ho
        qsvTuw2rWJ+uvO4HGKKQw/hvy7t24d4k8k36/Vvn3sjZENPXo6Ejr8Ecnvaeu7nA
        I4WRiMe+rNeeKmg4yodiCEXQ7Ck00bIDDwtznJ9WmHA880D0yzLQECrIxiioiV9E
        9d34hGQvTPXmhWPZs11HBqVkBU0cZqaFIKhlW8ii5LEs0lbXzbUZCqueQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VlKu10pGyqFtOYC6n8tkW4+yJlH9Ol1fiFnYlC1VoXk=; b=ZDIYYqzq
        PXJQOJtaTLRnCCMJtSTjD98HkITAoQ9ke0wHvTWS1ZuPsLmHn+OHCzO43xJFUStA
        OFuwY7pbKJb+h2xW+1e0dLrjg1iYI99vGP/2qlAWxVUCXesYwj9Tvxa4V0mquP3I
        0yFruL6J49FZNBEIPkC+NG6azUIVYSnEUP7gBf70aNHKyjH9IUG7Zj0SQlRYjku/
        yXhoLl6Z9cVddgnP7BAw3NjPtISeMN/C4MxdzBFsGM6jdIpVt+X8J5qgx16ahjZF
        ZdAVBRhqiT8altCiCnXOyzVXqyVE36/UGY7GRWs6MEXYk5ek8BRsjtPLjwyR7Y6O
        79vaa/Odhrqxvw==
X-ME-Sender: <xms:c3NpYQf295vx458pkg_Nm60lySvEMIrIwwuHtZjtkNpYklfgyOsP4Q>
    <xme:c3NpYSMnCFhIRhCiiJF5Oeb-BHHdQUYaYtzSTEy4ODC7McPllSSzV3ZZrUdmjyLJK
    RiIQos7_IKXxhihhXY>
X-ME-Received: <xmr:c3NpYRh0RjQ2-aEX_pjkQ0grkDd6Z3KmYSyYuZz5evfXuiP3zV8VnVLyTUgSfnNvb8dzebphyFDC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:c3NpYV9qUKkvCxDMQLKln-2ies6iPr5RqqRd1DV_oFiyS6aWNgneGg>
    <xmx:c3NpYctopgQfLRnq9k6McRVvrbtyZf8tXGLVGQT0ZmXAj7iQ5hcY9Q>
    <xmx:c3NpYcGcC6N96LKFUlG9wHH3Tp3HREGGtQHts3k0trWubztDueGD7w>
    <xmx:c3NpYQMRCk3j8XYIYmX44BQJids9yG989g7LCpwD8PJYMYehB7AgJw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:21 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 4/9] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Fri, 15 Oct 2021 22:25:46 +1000
Message-Id: <20211015122551.38951-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
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

