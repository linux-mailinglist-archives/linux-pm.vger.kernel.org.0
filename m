Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0A351CF2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhDASXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237451AbhDASNC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8709F61205;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=a43R6JQDznUNGqfSK68B+tax5VVfBWlTLzjy/Xf6wOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKGJR8RJYpeMKKZHZVMOR2rPSQadIfHCLLjVnF1DsA9h4DdorXuG18pOpTomM71kW
         5bLQ3DzFx86lGoUv4P+74cA4ghLdOt0N9J3nxYixfYDmWca9y7rRLXPuvcVPlUWfu3
         b2Dyk63NyUvknf3TOhyfWHgb2HwVJ2tkkShwnbZo/88V0Ac/AgHwj7U7ISPL6fe2Rw
         zfHZaDxY0XsOg6B7Pi2agJOm3NFPhlf9TDlRHvSGaMcaq2whAQIYk+EUzS1yq3AivG
         mKub+mRPtKt3n/Q0Zc376e+Fbe5YxFhUFpRwd1mLh7zBXP4wgyu/jCJ1VMpZZv9JpT
         +7Hfex5IP/rCA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3c-Id; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Murphy <dmurphy@ti.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 28/32] dt-bindings: power: update battery.yaml reference
Date:   Thu,  1 Apr 2021 14:17:48 +0200
Message-Id: <38d6c11d44570822931395dfe18ccaf7d72ac84e.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changesets: 70c23e62d20c ("dt-bindings: power: supply: Fix remaining battery.txt links")
and: 471dec8023d1 ("dt-bindings: power: Convert battery.txt to battery.yaml")
renamed: Documentation/devicetree/bindings/power/supply/battery.txt
to: Documentation/devicetree/bindings/power/supply/battery.yaml.

Update its cross-reference accordingly.

Fixes: 70c23e62d20c ("dt-bindings: power: supply: Fix remaining battery.txt links")
Fixes: 471dec8023d1 ("dt-bindings: power: Convert battery.txt to battery.yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/power/power_supply_class.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/power_supply_class.rst b/Documentation/power/power_supply_class.rst
index 7b8c42f8b1de..c04fabee0a58 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -233,7 +233,7 @@ Devicetree battery characteristics
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Drivers should call power_supply_get_battery_info() to obtain battery
 characteristics from a devicetree battery node, defined in
-Documentation/devicetree/bindings/power/supply/battery.txt. This is
+Documentation/devicetree/bindings/power/supply/battery.yaml. This is
 implemented in drivers/power/supply/bq27xxx_battery.c.
 
 Properties in struct power_supply_battery_info and their counterparts in the
-- 
2.30.2

