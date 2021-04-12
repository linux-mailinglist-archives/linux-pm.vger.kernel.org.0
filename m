Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832A735D3A5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbhDLXDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 19:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbhDLXDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 19:03:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F44C061756;
        Mon, 12 Apr 2021 16:03:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C67DA1F453CF
Received: by jupiter.universe (Postfix, from userid 1000)
        id DE6FD4800C7; Tue, 13 Apr 2021 01:03:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/6] ARM: dts: mmp2-brownstone: Fix max8925 vendor prefix
Date:   Tue, 13 Apr 2021 01:03:15 +0200
Message-Id: <20210412230320.382885-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412230320.382885-1-sebastian.reichel@collabora.com>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix typo in max8925 vendor prefix.

Cc: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;
-- 
2.30.2

