Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F21C8240
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgEGGMW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:12:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36087 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGGMV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 02:12:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id t2so3430103lfc.3;
        Wed, 06 May 2020 23:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufo521eNj6zKPHOveBIAN40MExbsGCbJ0/HqyU4/tUY=;
        b=H6lGfriN+KfKjI+i46AJCJnJFQWFcG4+aEEi4VH2q5DtAcIpufzfzFVPZtPcCFsPow
         AqZj8uyIZ6GSBKCY5d1nVeGnPEcRnZEIKZHyZNRgP2zDjvOsT1Hhxg+5DdEmMqc5GApR
         MCQHziOsIn8dCLF194bO87ptkZAULfn7t6n8RppdC6Lz4cqb4r2wZ9x4NBrvnuWoNs0i
         XtBJd0x/wXC9yhcFB3BEgHjvgFi8nfQF60Zvzxv5eZuXH3mVWeJQA91V6fJtkupfRAEf
         y3uhD0OUR18j39UKab16FQUNIw+huYQQ4ut0IRaJ7ZC5QiDEbVHKIhZXu8WFkttUkSZN
         ziZg==
X-Gm-Message-State: AGi0PuZkQ6TheQAluUbiHAQBLjPMhQSr/Qf9y7empW/8UcvroJMO9EsM
        FE8PqXCXkhCrTHPBJwNPng4=
X-Google-Smtp-Source: APiQypL3tblmoxcib0D+gE4riHbyGPOtuFRTXDr11iLStNY+/qODAN3OuA+EjN8XwGia1HSKVcbEOQ==
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr7992085lfb.176.1588831938965;
        Wed, 06 May 2020 23:12:18 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f9sm3109126lfm.62.2020.05.06.23.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:12:18 -0700 (PDT)
Date:   Thu, 7 May 2020 09:11:32 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 07/11] power: supply: add battery parameters
Message-ID: <53a1727b3d449c1622fdbd735745d1622f0b5c4f.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
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
