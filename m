Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92818E163
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 13:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCUMxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 08:53:32 -0400
Received: from mail.manjaro.org ([176.9.38.148]:37122 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCUMxc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Mar 2020 08:53:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id B42AC37E5074;
        Sat, 21 Mar 2020 13:53:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zo-t32rK0CpE; Sat, 21 Mar 2020 13:53:25 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: Document cellwise vendor-prefix
Date:   Sat, 21 Mar 2020 13:52:39 +0100
Message-Id: <20200321125241.3072123-2-t.schramm@manjaro.org>
In-Reply-To: <20200321125241.3072123-1-t.schramm@manjaro.org>
References: <20200321125241.3072123-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..af3d1aed8118 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -177,6 +177,8 @@ patternProperties:
     description: Cadence Design Systems Inc.
   "^cdtech,.*":
     description: CDTech(H.K.) Electronics Limited
+  "^cellwise,.*":
+    description: CellWise Microelectronics Co., Ltd
   "^ceva,.*":
     description: Ceva, Inc.
   "^chipidea,.*":
-- 
2.24.1

