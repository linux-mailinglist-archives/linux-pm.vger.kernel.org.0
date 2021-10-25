Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73341439422
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhJYK4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:56:05 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34999 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232837AbhJYK4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:56:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7884E580477;
        Mon, 25 Oct 2021 06:53:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Oct 2021 06:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=24kmoyDbYZcI3
        nFH0O+DrCAf+oLm5SYIeuUA5wksFuQ=; b=ke3WKIQBySjWDN3KKnVTAzfwLgVNR
        g7w2gxmedjdspecct7dRIKOfaTqWAMXHbMTGUr8mYTW+hiPllvT9Pj6WMsHcs2Hl
        q9Q53+Yml6t83Qum3DAsUsO8qZXuh9H5YSnJnpFwf3/ZcjndIThlVJHaMYR0aIiR
        a4xJiVwqq+RuY/7o2J0yIk4nxKFJioYI/z87i07oFzHlb7RlCDnhAHUhAUNlxinD
        LfbCxvNLyapAboVBKIMnYRitKnH3eQj13Mac4Y2mDEgit/0EsPkDc80xQhAiLy9i
        jWvayC6p3+rxUJrK52Vl6NPWp4mUeGqV72y88B3NOswUwoYvynkprgPxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=24kmoyDbYZcI3nFH0O+DrCAf+oLm5SYIeuUA5wksFuQ=; b=XimBK2qT
        xehIbX/zIfXVa9bzs4aXPHZdDPM4XlFqb5BgMwDdaO8Cm7kgrvIorYagZg6hEp+G
        T7OisqgzwJQglAoIEymZaElqbVtu+y+BOLY0LYmo2t/dc8wLGydn7Ici7QPu3ZYm
        pw4qY7d00B4MEGVbc9KsDGrIkfrIFBDMUfy4XnrDrA4mZdNjIPBlun51jQsUcZNn
        hBLB5q+pCql63X1pFua84uyqr/9UVK8k3Y2GqiiMFz4AAZMjAFesYtXbhKel33kQ
        suLdHSVcGzl78yQu/Rp5SKJKYoocp0wsV6a1miK3xQLKJ14jZPkBLEtz61XFTdj9
        Kg9qmDyqRfoeYQ==
X-ME-Sender: <xms:tox2YUgxcdUbzLZPAYAsOzWSEsxm4O7OuVt-B4aDNjvYYtM4OsKbIw>
    <xme:tox2YdDHzrmc3EvcGIJEpVJ_FkTSmY00gQ0WWTV0BiaT2thHCqG6WXAPXY3vTdLDL
    qzgiwkihXDyVoOKwgs>
X-ME-Received: <xmr:tox2YcFLsG-19qz1mqhRiCFvSUxvjWWHrk3kHJwDxu6SFUDCEpsslNlmI513b7_C5F6EmA1jM2V3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:tox2YVQT72rELcJyc1DJmnRCaFokVZrsiJJ9tL24mGQGBEusIU0DJg>
    <xmx:tox2YRx33Dhkf6MpQNRrFvXGRixEQn3Vpc4L_pCG0a1D--fJDSAZ2A>
    <xmx:tox2YT57mN_ayVlsdjvIJFFdWIhbx0-SI70nmm8uZhaNNPCc_iN5dg>
    <xmx:tox2Yej4FCwGqOSDIyg1NXv-xmCe6yyMp-c0qLUKHORaxh-xMziQcg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:53:32 -0400 (EDT)
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
Subject: [PATCH v14 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Mon, 25 Oct 2021 20:53:03 +1000
Message-Id: <20211025105309.37942-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
device so that it can be enabled via menuconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

