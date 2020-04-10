Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0947D1A4BCA
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 00:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDJWNT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 18:13:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgDJWNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 18:13:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so3869213wrt.6
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Mico83Ts6Z9TeO582WyGQ/zwaTm+b6l1oxUTdnb7r8=;
        b=N/MiSR6NAmnE1ZrkABq4zlrlK8ua6kZyZhYeAeV8XChVqFef8CbClWF+vRARHOEZws
         uoC+n58vC0vHwYL/PFmDYPIala8qQCtT4xtDLzyFO2fTWbbhoJzzixgZO/IUW1W964cM
         LrxQl8n1RMbilMAVUhU7nh4PsEbyOikPFu9yk4B3p4HwumyAIB/e6e7GflLnkcZrGBNJ
         8Bb2xsyYntBXGkIX/pN7Jf3FMySqgwAAKfh/f5RBq/a97v/+zz1MSNLVuZdBeb/3uYUP
         ym1CDLh2gWhGJ3EOPXdnLLvX1mqbCdtR6mvHek4d6FFkF4NRVeOFSiphppYQcSly3tjs
         wBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Mico83Ts6Z9TeO582WyGQ/zwaTm+b6l1oxUTdnb7r8=;
        b=eXPnQpp+XOaqMltpx/iiSVWU5smKkw4hZlLpumw8jwd+3AiOgt1qIiwKplnNpvShDQ
         Vcu0FagUlb6V9Aue7u/HQ0qARQEKh7jGgO5sMyKXHGiQpzW2CyR73GpIDEWH1rub2D77
         SEim4XLVLFLKk+KKly87L/jfqOjvlVIaiE+lADCFOSfsXTuSHyxLfrpOGt9f0QyUBgwo
         3CAQ+M1aXXWaaCgwZCAWb8jJfWV0lsvpjOVXTsqXfb50PkZbiteixRTaiv12Ho6Bvus4
         ypykeoy4i4dmaugj+Oor5UpBhhcD3SFGyN9YM1Q5N74O+lGUh9zBIezLtNFvjTW+3osY
         rhCw==
X-Gm-Message-State: AGi0PuavenR4V0oGEDItRrcZAe5tkxCM8q/I8cvb3dVcudVqWX5yGtFc
        FtOO3+frBZxOS8Hg0nlHOsln4A==
X-Google-Smtp-Source: APiQypJAsoxzI6Q0F859Mb3noemMFuNzQMvldjTr5RSJw1zMei5wjai3acaaYh68NVrRQ5pUPrZrsw==
X-Received: by 2002:a5d:5688:: with SMTP id f8mr6518986wrv.245.1586556783449;
        Fri, 10 Apr 2020 15:13:03 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:13:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 4/6] thermal: power_allocator: Remove useless test
Date:   Sat, 11 Apr 2020 00:12:33 +0200
Message-Id: <20200410221236.6484-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function power_actor_set_power() does check if the specified
cooling device is a power actor.

Call the function and handle the return code like what do the other
calls to power_actor_* functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/power_allocator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index f8e4219cf5de..fd7c8de02250 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -427,11 +427,10 @@ static int allocate_power(struct thermal_zone_device *tz,
 		if (instance->trip != trip_max_desired_temperature)
 			continue;
 
-		if (!cdev_is_power_actor(instance->cdev))
+		if (power_actor_set_power(instance->cdev, instance,
+					  granted_power[i]))
 			continue;
 
-		power_actor_set_power(instance->cdev, instance,
-				      granted_power[i]);
 		total_granted_power += granted_power[i];
 
 		i++;
-- 
2.17.1

