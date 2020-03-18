Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D9189B60
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 12:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRLyC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 07:54:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44757 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRLyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 07:54:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4so11947491lji.11;
        Wed, 18 Mar 2020 04:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zoRPacgUUwB54FwEIycrbe2VmBw2Xek495+jUrdW3CU=;
        b=aR3mLq/bs2LFEmZT3I3v/BeAe0YGR328LaRGezTzZNfUCqssBnTp8evp7M9utbqVVz
         SF0ustaMeqhBJFEbtykMaIu9mYQqQ+6Nvh8GwRVPEqw5FYYQdcizQsk3o7QEOLmsVabw
         FCUIyEu18gqlv5zMGRd5MmCg7N34WzBMiRugpZ3C2gImnzyZH4SKbiDpukTm1ITeb0YL
         uNHseR17u8VKb7ty209axl4FgTbTTtl4Syfu9Cyq5F0O7Vhd+xpJfR6Ym78u/09Ld+4h
         q3gt6hMF+V5eXERtnqkFkgDgxwsdhbRh3i504HNPBEwfDTNWlNj5f55gmebYnxPNZrHo
         gQkw==
X-Gm-Message-State: ANhLgQ3FaQgZfTqE3qqHG5NbjvMiVvKB73m5QCIkn0Zg8yZA8AU8KdEJ
        qsCRrQrRlrpk7xQSvEH+VYc=
X-Google-Smtp-Source: ADFU+vsKuMcCNKGnVfDBAMwhBkb9839wKENBAgAHnM5AAvN2lOnM4rawj/9KXwM9cA/Rli3YM23Frg==
X-Received: by 2002:a05:651c:233:: with SMTP id z19mr2029033ljn.176.1584532438025;
        Wed, 18 Mar 2020 04:53:58 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id z5sm4441325lfq.71.2020.03.18.04.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:53:57 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:53:52 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [PATCH v5 7/9] power: supply: add battery parameters
Message-ID: <a1f8695542773179ffb7327852eea4a21f520649.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
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
---

No changes since v4

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
