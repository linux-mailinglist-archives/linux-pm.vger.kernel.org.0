Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC315D2F4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBNHig (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:38:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38998 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBNHig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:38:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so9597986ljg.6;
        Thu, 13 Feb 2020 23:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Djfxd7T9f5ZodEKIVjFqVc2zZPSJb5RQb8qonrTpbo=;
        b=Hzpwoq/ijWME8YIwREREHOo4YSTJEa/OrHcbPVDhYe5+LeGnD/IeRCzc7vROJWysVZ
         PzTmsW+fxaBzqood2MZ0OykxUfaQ4Z+2QfD0CbYuIx/LJEX1+bnnAEC52EVIkWpjLV7B
         VYXNqZzffdOWpWfGJ4nNotDtGgs2E29cphOmNoYICIrAsMfS/JcvJCNs3vSYdfZ+dJsg
         /NM1QeYLQZlbwoiZCzYrwzyMGG/DqjZXPcK7iguL/j+T3uNW2jT5NIY+jlhwsDNOSRSA
         vzCz11M0PmzM49x0LT74qiKjutmbNk2Z7N+9wkqoWzamRZ+8Li6Ih7O46s1hZZCG9Tq7
         Y/5Q==
X-Gm-Message-State: APjAAAWjBaDt5O9/1ntDPg3JB2e/VRZvz7sfIoGE1DmxBy1PLpZMHJYP
        +UEKW3bnYZturXU+KV9fTxU=
X-Google-Smtp-Source: APXvYqwzpuvnElcY+1tNlsV/FKQax662nWtI9vZmzBQ3O37F5lX75Yfi3KlOwor9Nh+y1Wq60Sm/Ag==
X-Received: by 2002:a2e:2407:: with SMTP id k7mr1108684ljk.275.1581665914535;
        Thu, 13 Feb 2020 23:38:34 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h7sm2534735lfj.29.2020.02.13.23.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:38:34 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:38:23 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/5] power: supply: add battery parameters
Message-ID: <a851b8c54662e6fdabfb9e1c9990de59649c1fdb.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add parsing of new device-tree battery bindings.

     - tricklecharge-current-microamp
     - precharge-upper-limit-microvolt
     - re-charge-voltage-microvolt
     - over-voltage-threshold-microvolt

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/power/supply/power_supply_core.c | 8 ++++++++
 include/linux/power_supply.h             | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 5c36c430ce8b..3a2d700adb3b 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -617,10 +617,18 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->voltage_min_design_uv);
 	of_property_read_u32(battery_np, "voltage-max-design-microvolt",
 			     &info->voltage_max_design_uv);
+	of_property_read_u32(battery_np, "tricklecharge-current-microamp",
+			     &info->tricklecharge_current_ua);
 	of_property_read_u32(battery_np, "precharge-current-microamp",
 			     &info->precharge_current_ua);
+	of_property_read_u32(battery_np, "precharge-upper-limit-microvolt",
+			     &info->precharge_voltage_max_uv);
 	of_property_read_u32(battery_np, "charge-term-current-microamp",
 			     &info->charge_term_current_ua);
+	of_property_read_u32(battery_np, "re-charge-voltage-microvolt",
+			     &info->charge_restart_voltage_uv);
+	of_property_read_u32(battery_np, "over-voltage-threshold-microvolt",
+			     &info->overvoltage_limit_uv);
 	of_property_read_u32(battery_np, "constant-charge-current-max-microamp",
 			     &info->constant_charge_current_max_ua);
 	of_property_read_u32(battery_np, "constant-charge-voltage-max-microvolt",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f737e7d..44c727f30669 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -341,8 +341,12 @@ struct power_supply_battery_info {
 	int charge_full_design_uah;	    /* microAmp-hours */
 	int voltage_min_design_uv;	    /* microVolts */
 	int voltage_max_design_uv;	    /* microVolts */
+	int tricklecharge_current_ua;	    /* microAmps */
 	int precharge_current_ua;	    /* microAmps */
+	int precharge_voltage_max_uv;	    /* microVolts */
 	int charge_term_current_ua;	    /* microAmps */
+	int charge_restart_voltage_uv;	    /* microVolts */
+	int overvoltage_limit_uv;	    /* microVolts */
 	int constant_charge_current_max_ua; /* microAmps */
 	int constant_charge_voltage_max_uv; /* microVolts */
 	int factory_internal_resistance_uohm;   /* microOhms */
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
