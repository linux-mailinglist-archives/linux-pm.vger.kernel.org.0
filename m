Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4828E183C60
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 23:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgCLWZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 18:25:07 -0400
Received: from mail.manjaro.org ([176.9.38.148]:58864 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgCLWZG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 18:25:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 8D826370254E;
        Thu, 12 Mar 2020 23:25:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GwXIrCV7kU5o; Thu, 12 Mar 2020 23:24:59 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v4 1/3] dt-bindings: Document cellwise vendor-prefix
Date:   Thu, 12 Mar 2020 23:24:46 +0100
Message-Id: <20200312222448.25097-2-t.schramm@manjaro.org>
In-Reply-To: <20200312222448.25097-1-t.schramm@manjaro.org>
References: <20200312222448.25097-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
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

