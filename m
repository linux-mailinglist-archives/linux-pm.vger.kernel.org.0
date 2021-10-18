Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401E74317B5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJRLsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJRLsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:06 -0400
Date:   Mon, 18 Oct 2021 11:45:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B3DAjTHDTBu7hiPwMNzbV00pTOtOOC1Nt6L2T526ok=;
        b=hLeJIJDaKEg5NvHPI/YeW9szWlhUbOIcg8d47YmIEAxHHYW+PvAvbhTf2H3hB2p+J5+tuZ
        eY0Xez4VTj5JSdu59PEVmaUqp0IPgHQpbIKAd+Vs+VHgDK1DyaqHn8eTR91wMFI0rZoGk3
        hQU+Jsjh4E241L6SY4O+j5LKgM211Mc8nfU9fbqH9D+Qe3KwOb+W1n3e+B5EAkKvbH5uu6
        UY4RFPCFDtTow/ED8y2W0kBoJYf0E1hddUmGJVrGMoobdR82qTinijQzSpiPOkvE5FsVv7
        iPODLGiSzEbs9V+1w3Uy82GUJmfyVpxfOETbIIpzz8hWF92u7+yPfnXr831ydA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B3DAjTHDTBu7hiPwMNzbV00pTOtOOC1Nt6L2T526ok=;
        b=dgg2CcHWYGKnkR7UeR/RLawdDXkEml4E17zOJtnhXyiIOBHDvaXEo+yX+OAD3hJrI0HKsy
        yOVfIGs1b/IBgWCg==
From:   "thermal-bot for Johan Jonker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: remove redundant
 comments from rockchip-thermal.yaml
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210930110517.14323-2-jbx6244@gmail.com>
References: <20210930110517.14323-2-jbx6244@gmail.com>
MIME-Version: 1.0
Message-ID: <163455755359.25758.1616229689764744384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5f553ac2325456f484806df5aa695392364d39f5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5f553ac2325456f484806df5aa695392364d39f5
Author:        Johan Jonker <jbx6244@gmail.com>
AuthorDate:    Thu, 30 Sep 2021 13:05:15 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 00:14:55 +02:00

dt-bindings: thermal: remove redundant comments from rockchip-thermal.yaml

Remove redundent comments from rockchip-thermal.yaml
Sort compatibles in alphabetical order.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210930110517.14323-2-jbx6244@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 3c07470..f6c1be2 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -12,14 +12,14 @@ maintainers:
 properties:
   compatible:
     enum:
-      - rockchip,px30-tsadc # PX30 SoCs
-      - rockchip,rv1108-tsadc # RV1108 SoCs
-      - rockchip,rk3228-tsadc # RK3228 SoCs
-      - rockchip,rk3288-tsadc # RK3288 SoCs
-      - rockchip,rk3328-tsadc # RK3328 SoCs
-      - rockchip,rk3368-tsadc # RK3368 SoCs
-      - rockchip,rk3399-tsadc # RK3399 SoCs
-      - rockchip,rk3568-tsadc # RK3568 SoCs
+      - rockchip,px30-tsadc
+      - rockchip,rk3228-tsadc
+      - rockchip,rk3288-tsadc
+      - rockchip,rk3328-tsadc
+      - rockchip,rk3368-tsadc
+      - rockchip,rk3399-tsadc
+      - rockchip,rk3568-tsadc
+      - rockchip,rv1108-tsadc
 
   reg:
     maxItems: 1
