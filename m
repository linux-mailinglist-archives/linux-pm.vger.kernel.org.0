Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0907F4279A6
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhJILw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:52:56 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35213 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233034AbhJILwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:52:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48388580A0F;
        Sat,  9 Oct 2021 07:50:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Oct 2021 07:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=yw1VucPUQqdpZ
        mHA25svfKcp/yBBqIjEZdlG3rBe/yc=; b=VhYRKkdx7DcdszfNteoa9Xa8hsMlS
        XqxhE3K7qotylN0ggV3loYPlyMsaunVjeb19/XLGFOAPgFNUj00dWcesRQoa0Ypa
        0Pw1Q+qOwgsrl2XsfZs90Ks6Ce3wrOjiuDqgD48c1t9adTyaHd2R/hIfctSttz/v
        xC33lfvil+OzQJ1aTow6y8pJ/XyQeAVTeZ2pmA1atzsg5MRjLb2Cjc4feE4l1Aq2
        gfGSDuE26JjzvorX29i2im0zYyycceSitQ/GnEUUdVTnd0U3rwLLmlTefp4jnu7E
        qwHiQASwokUyc1RP1Eqm87WhFVxGsbnb/UGz8HiUMiGdlcSWMhRb0QXhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=yw1VucPUQqdpZmHA25svfKcp/yBBqIjEZdlG3rBe/yc=; b=nyEOGtz5
        LUAmLPcxf8pP7CRlzUeYRSwonTXpbpk+gXCP1MQMY0lAu02kBBlRKHAn2utI0jmG
        zDWFCgChDNvkG/jH5dQdS71hxo3P0JLqi/Jcf5ggcOAp4OCh9gecaUH+e9kUdPOa
        cg57uG3cJizONmOTREQjKGvfa0R6GrpcheNXbzkYlFC5eV9znqsBmlcH7MpBT8yO
        JwrNIm2zs/s+AwnfFHICYAxqKMLJnURTc62OgZvL5JeJYCTTqrWpIkSzCJm11So+
        qCk4MfZr6dkveZNzyc9bnqBA6ZmRWYg6KMcL8NpQUfoEkjPdqDS1Z2vVIbgT7JRk
        ZIC2fm02m0xHwQ==
X-ME-Sender: <xms:IoJhYbgL5HGmvq5KlzJsMWWqyM772Mzo1FUU1EoPV5Mbu0CmdPLxLg>
    <xme:IoJhYYBpNgaulAK_fGWJIgAbOxNDby1M-B-LM0-olGsEfTiqQINMjLIk7w2K54GHZ
    c4Oy_8jVY0u8MjJU2U>
X-ME-Received: <xmr:IoJhYbFDVMG83DGTHqx1_1-IlR6yhlYHdpMc3y8QSstqXIo05cE2p4hsZSciTiDpjUjjdjLOMjiVGGpzh9XR0Yk0eEJVHaA7PBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:IoJhYYREwS_tu-XTd0WjX5uQ6GzulcE4MeTU-6GsbnqpgaJOw8ytZQ>
    <xmx:IoJhYYyIzNanKJ6O7EuH8o5EtOSx5CC7TPLKCC0500ZD9KElLNXCUA>
    <xmx:IoJhYe6HugHmONKfNRdXRWbQkmiulXFfIPQWTm3VhmgW1CRmglyocA>
    <xmx:IoJhYUCbww-9RxgwqVRtJXjCtjH4BWEkqx95x1GOObMBDZye0t7bqQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:50:53 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 02/10] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Sat,  9 Oct 2021 21:50:21 +1000
Message-Id: <20211009115031.18392-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
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

