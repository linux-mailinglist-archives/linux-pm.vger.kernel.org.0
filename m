Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD42810312F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 02:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfKTBfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 20:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKTBfa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Nov 2019 20:35:30 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047FE222B0;
        Wed, 20 Nov 2019 01:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574213729;
        bh=5CL38VfE+2Sp++BonQRuB8quhy3LjMWlhCoAYkC1/u4=;
        h=From:To:Cc:Subject:Date:From;
        b=sAhwF36AHMyye4vlmBjDxgnI0ipSTckmUdRGF/jUnN8TyffNzcvGP85t4zxMZ+/sB
         DBaKSyYrVtTG3NoF0Zuibs43DOceCtx891fW+lODPVz40Pf5q+ZEUcpZUal5NUDjIr
         P4skZQejawI5z/pEw7pyephBD/5GDn1sSzAvYKUE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] dt-bindings: power: Rename back power_domain.txt bindings to fix references
Date:   Wed, 20 Nov 2019 02:35:19 +0100
Message-Id: <1574213719-20766-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With split of power domain controller bindings to power-domain.yaml,
the consumer part was renamed to power-domain.txt breaking the
references.  Undo the renaming.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Undo the renaming.
---
 .../devicetree/bindings/power/{power-domain.txt => power_domain.txt}   | 0
 MAINTAINERS                                                            | 3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/power/{power-domain.txt => power_domain.txt} (100%)

diff --git a/Documentation/devicetree/bindings/power/power-domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/power-domain.txt
rename to Documentation/devicetree/bindings/power/power_domain.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 7126d3e079a4..f3513c9bce0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6953,7 +6953,8 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
-F:	Documentation/devicetree/bindings/power/power-domain*
+F:	Documentation/devicetree/bindings/power/power_domain.txt
+F:	Documentation/devicetree/bindings/power/power-domain.yaml
 
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
-- 
2.7.4

