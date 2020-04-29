Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD32C1BD552
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD2HCl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 03:02:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35632 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2HCk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 03:02:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id r17so735235lff.2;
        Wed, 29 Apr 2020 00:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r85BWktV4eKffhP5bEUSsTAbCcixIe97gDFSAa6NS3Q=;
        b=d8MO2agmSpgE0t4Hwc90drXsc3Pv1WIi8szDM6PgnW9tGkvHMCKa2FXPicLcaz5cRk
         VoC5Ku1ChYdJxOEk1Ry1m8wojb6TR1gra6U3vGnuoBFj80dYS6ced27SOsft25wOiGwX
         0gCtCruF4C8PokGM1nVQHp79akAtxAloqfIRAAbECwpCH1EqYp1mRP6t3CblnvJYJwuJ
         6A9cK15ooQvgWyXEJa/DHmAThnspbBwbK7LGrW/tfPqPZA/9OwiLneDYhtnm6JEMit/M
         OLn/uxKAq7kOt9aAyJrVUNC2VrSO2rJoyvWJXxjDGZ1uomaQSHWPrfHovWDyjrt/iyRR
         7zwA==
X-Gm-Message-State: AGi0Pubrxt37PQaeOvRhUYeEYRnkGk+OBjy/Gjvxe1EdpYQhGdqWK4Ot
        frKKgVFQCFHpgngvySXEooXRkB+D
X-Google-Smtp-Source: APiQypIFi9ou7QBNuT6F+ieYM01MLBxKnRbK+Vb4zU2l2zTUMF/LaQAO7c13hHD9GVjqgs8VW8hnsg==
X-Received: by 2002:ac2:47f0:: with SMTP id b16mr21856798lfp.81.1588143758172;
        Wed, 29 Apr 2020 00:02:38 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id h24sm1618370lji.99.2020.04.29.00.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:02:37 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:01:49 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     sre@kernel.org, robh+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v10 07/11] power: supply: add battery parameters
Message-ID: <9b59e3674ad89fddf83aa6396c8699e71836be0c.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add parsing of new device-tree battery bindings.

     - trickle-charge-current-microamp
     - precharge-upper-limit-microvolt
     - re-charge-voltage-microvolt
     - over-voltage-threshold-microvolt

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

No changes since v9

 drivers/power/supply/power_supply_core.c | 8 ++++++++
 include/linux/power_supply.h             | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1a9a9fae73d3..02b37fe6061c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -620,10 +620,18 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->voltage_min_design_uv);
 	of_property_read_u32(battery_np, "voltage-max-design-microvolt",
 			     &info->voltage_max_design_uv);
+	of_property_read_u32(battery_np, "trickle-charge-current-microamp",
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
index dcd5a71e6c67..d01322d1ab52 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -346,8 +346,12 @@ struct power_supply_battery_info {
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
