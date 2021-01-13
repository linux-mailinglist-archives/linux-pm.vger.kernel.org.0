Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A928C2F542E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbhAMUde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbhAMUde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 15:33:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0BC061794;
        Wed, 13 Jan 2021 12:32:53 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s26so4700113lfc.8;
        Wed, 13 Jan 2021 12:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+mMQvJM4wNZIQ6YSpFszBGOcba68DllQ5kC+BP4fDqA=;
        b=k4B2q1PiIdjAOMiVKZd5hh3UaTbrMuM7ssCdnyVI5r2KZsPJvV6y58C37Xhi9+H/ty
         OMWDNFW9NIpQhFZHmyAd8BFlJ/cpJelLNk9fXoDGWO8UjC84WCUwxfl88irrtkj4/0VT
         /SCzIoiUHiIiexLLjZrYvU3osnmDazLinjd69L0nq9Zu3basZZRg4vg4pv1aE0UsGUr9
         kc8FkHzOuEqTDusGcVROPh6on+sf9vl0hhMcf7c2N8plxat9xPi0HMcnSX5pLiAhyPZS
         I79CiGeyiOghlKOg0w5QPqOte1mz7s3u7+Z5BI9wH6tO2hZ/a5HEC5cC62D5dLqjgBcS
         NQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mMQvJM4wNZIQ6YSpFszBGOcba68DllQ5kC+BP4fDqA=;
        b=apwsRtm7rJ2S6UNcE9pK7hRfGZrauLTXqeE8Bs3WGy7ictZsHF0HUTglI/D0ZDbLLD
         AHeLIOl9VCqndwL3Yo2bAw39YycJuXm2OtbPdp+GYbRJWHaqLA9iTMWy4cTDLKicQMjw
         YeDsYgWt03WD9uyIgwMBuDqf6/FGbbiGLCxIQZKDH62OqVZKh2FZ2muoZTs55/9GZMQy
         msm2C+FpXqzUFtRwetRBBxsQGvYuVkecYfUatOIXccXdyuf5v00Kjgca8xS1fmMf7ShU
         8vTMWVOMZ8ZipWknRuQouZq2gUOCE5GbWREQCFCw5bYMXrolkQfI8XN7WoJ1rdpIyjcA
         qfZg==
X-Gm-Message-State: AOAM530mt07qOhDCXtq47Uai+STAsufuub8gyEYLrRDoQeY/OKJHz8PO
        Y72dB9COZUYxA+xT8eC2BWo=
X-Google-Smtp-Source: ABdhPJwcs0EZNBCk+4uLIDnvt23NEpqJqlglPMOPuIqXpYb6fjPHz2V0uv2YzDm0TH7D392Vu4sBkg==
X-Received: by 2002:ac2:51af:: with SMTP id f15mr1680335lfk.592.1610569971999;
        Wed, 13 Jan 2021 12:32:51 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id w202sm311194lff.182.2021.01.13.12.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:32:51 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/2] power: supply: core: Constify static struct attribute_group
Date:   Wed, 13 Jan 2021 21:32:43 +0100
Message-Id: <20210113203243.20146-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113203243.20146-1-rikard.falkeborn@gmail.com>
References: <20210113203243.20146-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of it is to put its address in an array of pointers to
const static structs. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 92dd63171193..c3d7cbcd4fad 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -374,7 +374,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-static struct attribute_group power_supply_attr_group = {
+static const struct attribute_group power_supply_attr_group = {
 	.attrs = __power_supply_attrs,
 	.is_visible = power_supply_attr_is_visible,
 };
-- 
2.30.0

