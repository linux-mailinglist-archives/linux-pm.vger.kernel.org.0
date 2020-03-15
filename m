Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE83185DD5
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgCOPOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgCOPOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so18078756wrm.9;
        Sun, 15 Mar 2020 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Szi3g7vWC5eovfWdznQDDs/l63PuCiAXPnlfpsPCp9k=;
        b=NxHtwUAv5sVwIHTKzLvr3hMJa+t/g+wNKgxYVHhZRSOExE3JjxUBfGNwmJ0qdd5+Vx
         ckgongkUVeLENSAZ3kXZLr5wrYqgsfVJfGCiw3KVBUn5Vu1yY5r7faIg0YdF8efA93p2
         ogxPnKO4EelGqkJSr3spqt5uFzfp/Rud+sGdEgfrMuY+yIQ4zRkO+WJH6g0d3xSyg/Qo
         LSuKzfl84X7ViHVUGVIp+va/PBKoheqsIlPFrSlJpz+U3dt+Qo/vhcrqNZ5YxXWQCJJV
         TD7HLUGY0M16ZD6FpECneH2LuK5wHyUb+KFwpXKtQ79dUsvCUZw7077kdGlM0tz7P4S2
         hHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Szi3g7vWC5eovfWdznQDDs/l63PuCiAXPnlfpsPCp9k=;
        b=f4i348iis0GHpwjyY1gVYSmwFKKXY0bv56bBflu2g6mHY3/04aLO4PHmARCx3aZP0l
         vX5BrOiuEKOuf6sBgE8iRJLs/GJRHGkqszd6bOvVMkseAW19GGeUAsUq0yoN0BsGFrh3
         sgSLi+1gELl0CTxVKlOxuk0gdakz0WvjxxY0OBZbL1dvLtbq3sdZN1TpQp3QbqbHaWqw
         9LuYQH1Vxg2I9hGW80OLF8YzukoXtYIx/WYee8Uo86Ge6iq1bWtqHhpnVjwZfovkI4cZ
         ZPMiOORnPnaCyfmWErFVArSde9lbSkoRlvbmCiXTK4hkcQv/cyT5cIooMb2IZrCBr87v
         hxaQ==
X-Gm-Message-State: ANhLgQ1CyB5/dZAo9ySLQ4bEGbT7Zz2XEyluJlsXhVcxVbfseUsqHDh0
        jUofVR000V1cqh/geTq4De8=
X-Google-Smtp-Source: ADFU+vsK1r0R32+VHrtus+wpgVaP+Lp8cLkCk3Z58IJoroB0mkZ1HTbTZjXvlky+gvAxL1tHtlZGlw==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr30330784wrp.59.1584285278008;
        Sun, 15 Mar 2020 08:14:38 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:37 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 05/15] power: supply: cpcap-battery: Add charge_now property
Date:   Sun, 15 Mar 2020 18:11:56 +0300
Message-Id: <20200315151206.30909-5-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add charge_now property.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 43e39485a617..db1b519e87c6 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -532,6 +532,7 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_POWER_NOW,
@@ -651,6 +652,12 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		val->intval = cpcap_battery_get_rough_capacity(ddata);
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		low = cpcap_battery_get_lowest(ddata);
+		if (!low->voltage)
+			return -ENODATA;
+		val->intval = low->counter_uah - latest->counter_uah;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (!ddata->charge_full)
 			return -ENODATA;
-- 
2.11.0

