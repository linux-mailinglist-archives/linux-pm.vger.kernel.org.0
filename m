Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6C1FCABE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgFQKXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 06:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQKXK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 06:23:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9AE20739;
        Wed, 17 Jun 2020 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592389390;
        bh=z98OmwGp/U/sP1M/3iSh1+F1PR3c5cPSZzzfTz+XxYo=;
        h=From:To:Subject:Date:From;
        b=tRB1COmIL0c/C0s4l8RfiPlH5dh7aq7vxbY1PCUV+UnLD87XTOBsFlSZSrSD26Rxq
         T7Z71c/jyjtTn1zpekPz6Egfbfqj4Nf4Y587FP8QPl+nPaQV5nSH0Nt4B7T0XveVm7
         miMKYtKwQ8sAcQy3hjTBlOkQ2uVwbFjvY0lRdQ3I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: bq25890: Indent example with tabs
Date:   Wed, 17 Jun 2020 12:23:04 +0200
Message-Id: <20200617102305.14241-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix example indentation to tabs to follow generic Linux coding style.
This avoids copying the space indentation to DTS when re-using the
example.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/power/supply/bq25890.txt         | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index dc9c8f76e06c..51ecc756521f 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -36,17 +36,17 @@ Optional properties:
 Example:
 
 bq25890 {
-        compatible = "ti,bq25890";
-        reg = <0x6a>;
+	compatible = "ti,bq25890";
+	reg = <0x6a>;
 
-        ti,battery-regulation-voltage = <4200000>;
-        ti,charge-current = <1000000>;
-        ti,termination-current = <50000>;
-        ti,precharge-current = <128000>;
-        ti,minimum-sys-voltage = <3600000>;
-        ti,boost-voltage = <5000000>;
-        ti,boost-max-current = <1000000>;
+	ti,battery-regulation-voltage = <4200000>;
+	ti,charge-current = <1000000>;
+	ti,termination-current = <50000>;
+	ti,precharge-current = <128000>;
+	ti,minimum-sys-voltage = <3600000>;
+	ti,boost-voltage = <5000000>;
+	ti,boost-max-current = <1000000>;
 
-        ti,use-ilim-pin;
-        ti,thermal-regulation-threshold = <120>;
+	ti,use-ilim-pin;
+	ti,thermal-regulation-threshold = <120>;
 };
-- 
2.17.1

