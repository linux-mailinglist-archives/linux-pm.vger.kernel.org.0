Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E94279C6
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbhJILxk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:40 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40177 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244824AbhJILxi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 26A09580542;
        Sat,  9 Oct 2021 07:51:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 09 Oct 2021 07:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SfTCPrBXtXpiG
        gTbdqeWVHIPqy46+Y5IyiDSgZKSQDY=; b=1rQCWKJEot/fFQgxw8gLyO0NTmfsB
        vgCatKYCV5LKay5Jt9tIouF0BspSZ7gBH67QdQFE/yptY/aibyPML8tq511KpYBA
        GAOkgh/cBGs8MmluBHrRjoj45c6AZHT/+WCfjNeyX2ZPC8w+NykYcoow7f0mXRnU
        ROX3ZXZ+w3dR5VPG+j2UuOzOQdjBhFwoBc/+jRK6Bh+nGwVvuA++hHYq+yePxubO
        NriVOPnHDzCinZkIgbGSq7Ydr4vYnLTiwefe1h+UejjycUfvurzV8CVvlLyJfXMv
        CABGNKLCOdQ8nhGeBmg2oLt0kvgyOoFBJLOukca+ZcfPihhbgVYEQlo4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=SfTCPrBXtXpiGgTbdqeWVHIPqy46+Y5IyiDSgZKSQDY=; b=Ncp64Xvw
        yB9DxDHQSvT3CdHMCRT2BjlYaYGOgmZyZZapB7Jb+2qiakNoKDF51dXI1IZizswZ
        KFvdq0sp0P/dLsyf92L5o25rWYn4Z+14ahv3Tftnp53XBKR6qCfu1hM3ewNoExvm
        S9nUB/AOREIVrV5Dlx6PWFXD78KaqEOyJJHrWVAdQKj7b6dBxp+kydi3EEO99hnX
        g141xRJPu900J65Itor/x7cuUlQnATeL1I9bhidIUOHgGWemo2g6unfNRjzLfp6X
        DLFRZzk3KheqkExoMKuyrX2hnS9dZLEOcdU4vGD58tvzkfYailz+o8PovjXObRt9
        JVcZtBv6R1Zh/w==
X-ME-Sender: <xms:TYJhYR96C16uCFEXLjcbGufWTs5M0xMVqzzhh6251r5JxSgGikYPJQ>
    <xme:TYJhYVv1JBlfc8P2szYa4M90UBF6xhJOsFjnsD8-jPe3-3ke5f5zcRMCsMuzwy-fd
    qWrLjbR0Y4-gWMv_YE>
X-ME-Received: <xmr:TYJhYfCRcPqWaz99of9hQytBk8FAfUWul-uyJKB7TCieD3TMUzaYH02gi9pi4sj6R6gYUnFQd0HHdwwiAZUqO0Myx4uZtysT94s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:TYJhYVcvL7NNeoTNEU5wQDtopvGb-MrPcGrAd-5ivCyWvhBBifTBmQ>
    <xmx:TYJhYWMWFwJpcrkXsLmwFLhqUA683OF_daqb-361h893mKM6Q5Qxiw>
    <xmx:TYJhYXkWHKAl6UGHYtgradU-hkOjZSXDUmXnqBnmTBam1i6im8TrDg>
    <xmx:TYJhYTss32j3BVsj_AKCj5PNLo0RkFKd5j1oBFt2OoGXZ8sTwRFbAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:36 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 07/10] ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
Date:   Sat,  9 Oct 2021 21:50:29 +1000
Message-Id: <20211009115031.18392-11-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
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
index b87adf823e44..507ab17cfcd8 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -233,6 +233,7 @@ CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_SY7636A_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=m
@@ -248,6 +249,7 @@ CONFIG_MFD_RN5T618=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_MFD_SIMPLE_MFD_I2C=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
@@ -258,6 +260,7 @@ CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_RN5T618=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=y
-- 
2.31.1

