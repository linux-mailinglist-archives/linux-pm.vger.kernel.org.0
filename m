Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B98430D91
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbhJRBhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Oct 2021 21:37:07 -0400
Received: from mx.socionext.com ([202.248.49.38]:31220 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243034AbhJRBhG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Oct 2021 21:37:06 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:34:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 235722058B40;
        Mon, 18 Oct 2021 10:34:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:34:55 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 69B57B62B7;
        Mon, 18 Oct 2021 10:34:54 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: thermal: uniphier: Add binding for NX1 SoC
Date:   Mon, 18 Oct 2021 10:34:50 +0900
Message-Id: <1634520891-16801-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634520891-16801-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634520891-16801-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update thermal binding document for UniPhier NX1 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/thermal/socionext,uniphier-thermal.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
index 553c9dcdaeeb..c5b25ce44956 100644
--- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -20,6 +20,7 @@ properties:
       - socionext,uniphier-pxs2-thermal
       - socionext,uniphier-ld20-thermal
       - socionext,uniphier-pxs3-thermal
+      - socionext,uniphier-nx1-thermal
 
   interrupts:
     maxItems: 1
-- 
2.7.4

