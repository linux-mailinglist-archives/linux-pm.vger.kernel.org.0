Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45F41F07E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354959AbhJAPId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 11:08:33 -0400
Received: from mail-m17638.qiye.163.com ([59.111.176.38]:46900 "EHLO
        mail-m17638.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354933AbhJAPIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 11:08:32 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Oct 2021 11:08:32 EDT
Received: from localhost.localdomain (unknown [112.48.80.210])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id BEA7A1C0085;
        Fri,  1 Oct 2021 23:00:37 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Lin Huang <hl@rock-chips.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] dt-bindings: devfreq: rk3399_dmc: fix clocks in example
Date:   Fri,  1 Oct 2021 23:00:24 +0800
Message-Id: <20211001150024.18672-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlNQh5WQ0xJHk9NTR1JSR
        pLVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Eyo*Tj4KFTgpOEhPNi9K
        PgEaCxdVSlVKTUhISktLT0hDT0hLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SVVPQ1VDS1VJSktZV1kIAVlBSUpOSTcG
X-HM-Tid: 0a7c3c5f1a49d993kuwsbea7a1c0085
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clocks in the example use 'SCLK_DDRCLK', which does not exist in
the rk3399-cru.h, correct it to 'SCLK_DDRC'.

Ref: commit 7fbdfcd68783 ("clk: rockchip: add SCLK_DDRC id for rk3399 ddrc")
Fixes: c1ceb8f7c167 ("Documentation: bindings: add dt documentation for rk3399 dmc")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 3fbeb3733c48..58fc8a6cebc7 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -174,7 +174,7 @@ Example:
 		compatible = "rockchip,rk3399-dmc";
 		devfreq-events = <&dfi>;
 		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_DDRCLK>;
+		clocks = <&cru SCLK_DDRC>;
 		clock-names = "dmc_clk";
 		operating-points-v2 = <&dmc_opp_table>;
 		center-supply = <&ppvar_centerlogic>;
-- 
2.17.1

