Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C841CB3E2
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHPsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:48:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40085 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHPsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:48:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id y4so2162139ljn.7;
        Fri, 08 May 2020 08:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufo521eNj6zKPHOveBIAN40MExbsGCbJ0/HqyU4/tUY=;
        b=Y3tqculfNqbcy1/ZN4z7Cq3h+u4zxvbFTbe2YwCRtVVCNCZnaSdGYQxsYsZlVPdv1v
         MaEmjgprAG7G3GFpbkzJjB+PYCQK9ucAHCDzrONGNn3/YXQKes4vk4SZlCsYKKtoqAK9
         Nw3v11B6OpM8Y7hIGJLZGATbZdkN12TvpFpZeYi6dO56bfKq8HKvBgX5bohxiyxPk6zB
         3NEPXuYz0uG9d7WQfn2Rfji6mSk10N4abPjn3n1RJkKc0Hgw+leglQwNU3Agq2/nIHhV
         cB8maEuUbe0tHNj2Jk3urcLN864zPi5Dqr6OXbLn20NrZHXtKogfr8GZG2Qi9s2VZRNk
         dX8Q==
X-Gm-Message-State: AOAM533wFsc+UFZG+nN8a3W3VirF7a4UpPPPdhphWA93Zj/BpZs5MDW9
        15P9y59OFlDX4XxH4nyZ5Es=
X-Google-Smtp-Source: ABdhPJwNoFms3oR76bUTdQNpkcz3yNaXw/f9RNr61G7M2dhNWVyGBnLZrsKRc4yQZJCBhrpFq6NWvA==
X-Received: by 2002:a2e:9dcd:: with SMTP id x13mr2054640ljj.120.1588952886135;
        Fri, 08 May 2020 08:48:06 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f27sm1466026lfe.93.2020.05.08.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:48:05 -0700 (PDT)
Date:   Fri, 8 May 2020 18:47:20 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 07/11] power: supply: add battery parameters
Message-ID: <07cb1ca75e3cec01f1c94558dd93dc3270050e0f.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
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
