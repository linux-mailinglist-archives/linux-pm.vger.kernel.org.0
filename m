Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5E1B0045
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 05:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDTDme (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 23:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTDmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 23:42:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A77C061A0C;
        Sun, 19 Apr 2020 20:42:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so3456028plt.2;
        Sun, 19 Apr 2020 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OLaM6Qu6tx9wARiWQDaw8WtmOfSiQlnO4zEaooNM6j0=;
        b=fVgABpYDIFpulLjWXtcFz+P5Pyc2BObkCqXc42k8zU5gZSVjLqIWsJTp/OI2ZoVWm4
         Xkr0wscWh/pXYYraltinY460aUXQqUp13SqABCcAzld1aWSeBRZWjbk3NUjDwiT9VpaB
         AjSP4Ngzk2uas6Mro4daKqLyQDHAVDoXFr0MOllaKQyyg66S7MjyhDsenBUNVDM+HkST
         aDuaw5DH0s4pTya4Bak9XTnZEDc2BGl2L5BFQ4YVEYEKzL2UZcy/Dw3zYSgqgpaHKn1s
         4/hqcSBbLh6CeHrY0YYFUHfLJ8ZsraGls/l5RCNspwusf/rRLubri0fdaFtvHSz3qi4A
         szWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OLaM6Qu6tx9wARiWQDaw8WtmOfSiQlnO4zEaooNM6j0=;
        b=OidBQKH1RkZgB/xgP2tOPQOXgsePHyHA+aImwJaTFjgkW9LobcrWwuYG8E8pgMILKG
         GvkuVy1KzsjWtWeKu4hfgbM9y3a1rgVU+eReS2/mx4iHWrNpT7MymLFwmtyGRWpHBEMT
         u/MtTUFtZbQSLXj2Cg786HoVWm6gFr70+j/6WExyo40JNy54Kpkj7Ub6We1I+4zgaEzC
         DavoXhVZ90ebi45l6vb5gHYRyXmH9l4Q6LPtJAY2RkylCUuudBW5T8GMCeHGmrorlJBj
         zG8Jlrm1gibrl1Mep1x2FmjIBdA40HBCgGH9Ea+6Usd5fdZX/4CmHKwalbOxXltpxns+
         pp/A==
X-Gm-Message-State: AGi0PuaXI0Qj+cRzCNjpplchMYRPh5+6nfiPCkTjyZ8K3AIq1jJ4nYot
        7ZvJI03FxxYegDVstXnFihI=
X-Google-Smtp-Source: APiQypLS0wLw9k9ccJRTnZb2qw34t9alZqR0SmMnF/oMyER23ILtnZD+YDYXuRIhj0tqZruIbxa0iA==
X-Received: by 2002:a17:902:561:: with SMTP id 88mr15393475plf.78.1587354153418;
        Sun, 19 Apr 2020 20:42:33 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id d21sm12467660pjs.3.2020.04.19.20.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 20:42:32 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        yuanjiang.yu@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] power: supply: sc27xx: Allow to change the battery full capacity
Date:   Mon, 20 Apr 2020 11:42:05 +0800
Message-Id: <88115ce628cda05d5c4961e364bb1204dbfeb03a.1587353854.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

The battery full capacity can be affected by the temperature or the
servicing time or other factors, so some platforms will track the
real battery full capacity in charger manager service. Thus we should
allow to change the battery full capacity by setting the
'POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN' property as writeable.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 9dcd55f1d9f3..5970d4a78016 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -656,6 +656,11 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 		ret = 0;
 		break;
 
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		data->total_cap = val->intval / 1000;
+		ret = 0;
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
@@ -676,7 +681,8 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
 	return psp == POWER_SUPPLY_PROP_CAPACITY ||
-		psp == POWER_SUPPLY_PROP_CALIBRATE;
+		psp == POWER_SUPPLY_PROP_CALIBRATE ||
+		psp == POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN;
 }
 
 static enum power_supply_property sc27xx_fgu_props[] = {
-- 
2.17.1

