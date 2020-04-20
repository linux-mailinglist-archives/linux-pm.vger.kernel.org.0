Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAB1B0043
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 05:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDTDmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 23:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTDmb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 23:42:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2A7C061A0C;
        Sun, 19 Apr 2020 20:42:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w11so4383511pga.12;
        Sun, 19 Apr 2020 20:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=H9mqHilgo/Uld+P9kdUGuC1VtwvkHSgSfi4WjXEiHdw=;
        b=J8mJAyZaHhfIkN737Ii55LTQM5Pzzi8PJGPO5Kokt5CiPDuXK9md3Yc1zhAyjf7iM+
         K6FZSb0aKApvgtJ1QOHT7r4E1nONIP6jkoQbX+7tHaaf51uiwiaDLpEewctYNu8LNF8Q
         rX7jo91SOSf992AjZetK427WtYjWGBBzs8EbNcRQ+hf4OOB3+nPga1hEvV+r0UGkJmG0
         BwNGUfm1MF40KnR78Q9nLZcH9qUPt3T/jwdJTRwTBsUmvso0860Wwrc3maok+KrBQqgN
         YbJTq416JujB4qXwVi9MXDewokimSXmKEWJrAxi90S+5atdbWr7wQQzB2Rs/jamuhoFp
         Q6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=H9mqHilgo/Uld+P9kdUGuC1VtwvkHSgSfi4WjXEiHdw=;
        b=NfRjqxgsxIcL8gv7+9I3sfZoh8KAcyWFbIM1Lk7lrZiB7m94o820THQJftMQlXb9rY
         1sEICri5nTDmZGrvrUqxLVXk6aWYxMtizPFfwrXPr/IhD5d/vGkuSEj2dYwogYaxUbuI
         Mx7ekHJ+l5r98n9tSeZqZXV1d5+nSADK3ZCRjmtFkK3k1Kk9WjHmtJj0SjDU/gYR4uA7
         8ZMzKTH77nHJEW2rM5wbcxR67NhscMChkxHfndmQcylaJFn2gGnZcs+a/1qrY57lJV0l
         vg9nZJUFkDTz9eZil1cnbpz/JMayqUQ4j66qKaZPj+d3oXNF10mI9cmRDQndjD8SKStX
         RZHQ==
X-Gm-Message-State: AGi0PuYxVi8UflBUc1tvqF2PEbnuCtZvlGchemmwqnnX+f65rSsYOUk5
        8YnG9Qnuao6ulisaYv/D/siB1r4kLts=
X-Google-Smtp-Source: APiQypKu/gOsQ9EaCme/dDviV4AkJq9fT5CbA1/lkIWypGw0ImHcwZFKHo21FB7BDKXnhuRUQ4PrNw==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr6166402pff.168.1587354149160;
        Sun, 19 Apr 2020 20:42:29 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id d21sm12467660pjs.3.2020.04.19.20.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 20:42:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        yuanjiang.yu@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] power: supply: sc27xx: Set 'no_thermal' flag for SC27xx fuel gauge
Date:   Mon, 20 Apr 2020 11:42:04 +0800
Message-Id: <e976fc4b8a77abf272b27c345bbdee3960036f2f.1587353854.git.baolin.wang7@gmail.com>
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

There is no thermal zone should be created for the SC27XX FGU power supply,
thus set the 'no_thermal' flag as true.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index a7c8a8453db1..9dcd55f1d9f3 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -705,6 +705,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
 	.set_property		= sc27xx_fgu_set_property,
 	.external_power_changed	= sc27xx_fgu_external_power_changed,
 	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
+	.no_thermal		= true,
 };
 
 static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap)
-- 
2.17.1

