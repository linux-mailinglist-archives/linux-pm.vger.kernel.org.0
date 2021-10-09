Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD24279CE
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbhJILyC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:54:02 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40603 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244900AbhJILxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B002158055A;
        Sat,  9 Oct 2021 07:51:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 09 Oct 2021 07:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=VqCaXYMs9oVz4
        wTwqKZPPKhhsXOGl6f0l2zOxe7iOCk=; b=EeZUxiWmaJgEQmBaYdEGuYQn7OQLw
        w2iIhKOiPm5cZqOnzcwHMLYpjg/UamqBZ2utXCoa5pyJFAmsVPcRKkM/PQWL0BXM
        P2/k/QKh435qihn0pG39B7lMM9Ar0htAeyQshj2GRCsF6w58PBHb5w1uYfBIdSCY
        eQz9zZFcIs1Mk74xP07oOEaFx4MUU+0/cjz6madRUO/3X4uQ4DEiMdHlnlzaKKnK
        wZtZLjRwIvZzNpQ/5MK35nqnsThi2SF007Pnc0TsLIbBw8KJ8vgLHTIS6XrpWjw8
        YC93Ar06TyZRHniPwXB3Zoh4aQejZOUg6GLY35KIJyjSkZFNRYcFxFs/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VqCaXYMs9oVz4wTwqKZPPKhhsXOGl6f0l2zOxe7iOCk=; b=K80+mcUm
        k1u00sCjTCaIVbsC4SP/tstP8mJWzDMa8AaD+FwtCEEQqBS0LekJAXx3gCBqi5RW
        nyasRG8QxQjEQysvfKrrW9m+K0ybG/devR0MZqF+tuFuO59H+RtOwCmSN+DCIEZ9
        IlssKF/3ozlVUyT+9QuwAkmAKcIIOC9Wr2cNk0Qjw8QjVdmbhCduZcpA7Jp9r23U
        hlsIuFRpoTBNc6IcV0wljHA2KZe4Wl8n49MxU92dPT14kJOYd9x+aEtTXSQkqdzK
        ESvKeT0O+KhhuqnX/owFegGlkaDVDVTkgWoFlMoxw2LHA+1W3NrO8cjXn+PdGYbg
        E/HZpcjxib4Uug==
X-ME-Sender: <xms:V4JhYflcNbbLFIV43JRsecYNnFP0jR9AnDfQDdbwKPqJDqnX6LyJaA>
    <xme:V4JhYS1ownEDDfrdEsuglUxr6BcHYtrAsApkJ19GVXHTR9XePB4e9VF0zfbrpRClp
    jmYCCrdisQeWmKGjaM>
X-ME-Received: <xmr:V4JhYVohOyD5rxCSoZa_M-1ibORPfp7uoL5_kIk5JczzFunQIcqbTYypcq9pYoUYpPUN4Ns6JMCErhDUcYsNMj4JDSvyaEkrIKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:V4JhYXl7_-hwibGoKZDCwCYToe36S14wgBGuJ6Gxt9JdXZ8qqeF3FA>
    <xmx:V4JhYd0MhrsvbGw1e_0cdSI1MyREJqW5XZPoMBPE3HbiEFujWqA_Gg>
    <xmx:V4JhYWukREobK_qAUAHCo_onbwAAURB6XvXvFA4mrMQzvSRjEanuvw>
    <xmx:V4JhYc1PAlQwILdS4wNtx5ZkAvi-77sineeBUetMJ_sxLg5UcPmdjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:46 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 09/10] ARM: imx_v6_v7_defconfig: Enable backlight class devices
Date:   Sat,  9 Oct 2021 21:50:31 +1000
Message-Id: <20211009115031.18392-13-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BACKLIGHT_CLASS_DEVICE config is required for the already enabled
DRM_SIMPLE_PANEL to work so let's enable BACKLIGHT_CLASS_DEVICE.

This allows the mxsfb probe to complete successfully on the reMarkable
2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 507ab17cfcd8..6b3744e6379b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -300,6 +300,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.31.1

