Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3CA23FF3
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 20:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfETSH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 14:07:28 -0400
Received: from node.akkea.ca ([192.155.83.177]:58466 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbfETSH2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 14:07:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C3B344E204D;
        Mon, 20 May 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558375647; bh=PW2uqU8vRWIxFg8K1JYG93B9yK+DwMBZkhuUAM+C+1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hiD+o5gd/imRDjaGrkvnZwOU4I/RuZMPZ3ZzFa6vI9Nu69XL3uoHGn2vYSk77Pbnd
         u/r1gJofo/hLQRiLTmelMobMjMskQTTye5Ljq7h34HaLLcsWReNsRqJXMFgkDbHG1X
         Jc4TQNhrETLwOi0nb2OB55MWlv5WlO4EgIcEYb+M=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vJqb2EmdVUUu; Mon, 20 May 2019 18:07:27 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 17FED4E204E;
        Mon, 20 May 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558375647; bh=PW2uqU8vRWIxFg8K1JYG93B9yK+DwMBZkhuUAM+C+1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hiD+o5gd/imRDjaGrkvnZwOU4I/RuZMPZ3ZzFa6vI9Nu69XL3uoHGn2vYSk77Pbnd
         u/r1gJofo/hLQRiLTmelMobMjMskQTTye5Ljq7h34HaLLcsWReNsRqJXMFgkDbHG1X
         Jc4TQNhrETLwOi0nb2OB55MWlv5WlO4EgIcEYb+M=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 2/2] dt-bindings: power: supply: Add documentation for the VINDPM properties
Date:   Mon, 20 May 2019 11:07:12 -0700
Message-Id: <20190520180712.32405-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520180712.32405-1-angus@akkea.ca>
References: <20190520180712.32405-1-angus@akkea.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add documentation on how to control VINDPM from the devicetree.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/power/supply/bq25890.txt          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index dc0568933359..fe8b709dd666 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -26,9 +26,15 @@ Optional properties:
 - ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
     input current will be the lower between the resistor setting and the IINLIM
     register setting;
+- ti,use-vinmin-threshold: boolean, if present the FORCE_VINDPM bit will be set
+    and the input voltage limit will be configured based on "ti,vinmin-threshold"
 - ti,thermal-regulation-threshold: integer, temperature above which the charge
     current is lowered, to avoid overheating (in degrees Celsius). If omitted,
     the default setting will be used (120 degrees);
+- ti,vinmin-threshold: integer, lower absolute threshold for VINDPM. If the
+    voltage falls below this threshold the charge current is reduced until the
+    input voltage rises above the input voltage limit. If omitted, the default
+    setting will be used (4.4V);
 
 Example:
 
@@ -46,4 +52,6 @@ bq25890 {
 
         ti,use-ilim-pin;
         ti,thermal-regulation-threshold = <120>;
+        ti,use-vinmin-threshold;
+        ti,vinmin-threshold = <3900000>;
 };
-- 
2.17.1

