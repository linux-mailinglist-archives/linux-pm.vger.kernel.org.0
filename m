Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB11B6646
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgDWVlZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 17:41:25 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:57973 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgDWVlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 17:41:24 -0400
X-IronPort-AV: E=Sophos;i="5.73,309,1583161200"; 
   d="scan'208";a="45553084"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Apr 2020 06:41:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AEC84400C420;
        Fri, 24 Apr 2020 06:41:19 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 04/10] dt-bindings: reset: rcar-rst: Document r8a7742 reset module
Date:   Thu, 23 Apr 2020 22:40:44 +0100
Message-Id: <1587678050-23468-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document bindings for the RZ/G1H (R8A7742) reset module.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/reset/renesas,rst.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.yaml b/Documentation/devicetree/bindings/reset/renesas,rst.yaml
index b5de1d1..4c2b429 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.yaml
@@ -23,6 +23,7 @@ description: |
 properties:
   compatible:
     enum:
+      - renesas,r8a7742-rst       # RZ/G1H
       - renesas,r8a7743-rst       # RZ/G1M
       - renesas,r8a7744-rst       # RZ/G1N
       - renesas,r8a7745-rst       # RZ/G1E
-- 
2.7.4

