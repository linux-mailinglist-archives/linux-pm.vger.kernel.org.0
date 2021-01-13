Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28092F542C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbhAMUdd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 15:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbhAMUdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 15:33:32 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F2C061786;
        Wed, 13 Jan 2021 12:32:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o17so4730303lfg.4;
        Wed, 13 Jan 2021 12:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wR7PNlqFv0AsQ67UQPizYRL3mDwsloHHs6vUO64bZCw=;
        b=p9wR9wam7GcQ5WP6JTjzgh2wNVZoCcPmFq8tzIqycoQgaRna3mYXkkYO0Hs+EwSfLK
         q4m+GwIsoDE5Bftm5l7YfYZpKJf7QtfwpD9oA+yQd++JYCy+bZy6TDlx2a6suA1vP1wT
         EpBiIS7vO9v/Rbjee919TFzAJ52m05sQEymTCBdbj1MwjcJXf+SYt0wylSouk8cV3cX5
         06bLgdOftATV1Z9uTp7zgndjzQl97fHcUySKZ0q6fmuUFchep716We08LAWbmaTyc8dU
         lwvs9SuGUR131mzkaygM6khFwODLnSa55dT0ftGYDlIhr6uh95Ts04jkLKlAExdOLpaD
         p5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wR7PNlqFv0AsQ67UQPizYRL3mDwsloHHs6vUO64bZCw=;
        b=jtkFv4zLW2AjlkPkCIgKeNbO3gQFJ4yImhFHMNkJyLI1ERU1CVsl5i8/xFgvBGiT5y
         SxJWzkbjo8AijAiUYvCNU3m16I+QxEGXvqlS8ROothATNt2wOHvkka4baq3mp22NhoSH
         x4UttW92zVrnjFKvhd0vOTQ1UO779dTOcg9wBejhMERpsATi2RjQUd442UHDZ/dcb4fd
         hQnRrjS1G63vgrad5mCKM7ouqKZojRC45KPRCcbxTkoyTEXhQQnwvmrJjCnQpjMA+YGm
         pG6x2VLp9xDNum7affG/PaJRU6L+9fx90BmE+Ep+yTsf+QsjLzoeoUc7I/uY/0PLUBQ0
         hmKg==
X-Gm-Message-State: AOAM532CrMo0/j4hW8M32wwV9tdzG0EzG9cLTIzPXTB3WTUIhECjPZRg
        LcDRGsldGEaH2bcE6p7iPH9FhNw0nz4=
X-Google-Smtp-Source: ABdhPJy1fGciFpN/VyFpVSu54hPHj2KcIK71p8DWdQ35cbqaj33IsJ8roD5zEwGmoWYRVXji9glmhg==
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr1521184lfd.291.1610569970890;
        Wed, 13 Jan 2021 12:32:50 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id w202sm311194lff.182.2021.01.13.12.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:32:50 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/2] power: supply: ltc4162-l: Constify static struct attribute_group
Date:   Wed, 13 Jan 2021 21:32:42 +0100
Message-Id: <20210113203243.20146-2-rikard.falkeborn@gmail.com>
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
 drivers/power/supply/ltc4162-l-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index cded6484febb..1a5cb4405ee3 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -666,7 +666,7 @@ static struct attribute *ltc4162l_sysfs_entries[] = {
 	NULL,
 };
 
-static struct attribute_group ltc4162l_attr_group = {
+static const struct attribute_group ltc4162l_attr_group = {
 	.name	= NULL,	/* put in device directory */
 	.attrs	= ltc4162l_sysfs_entries,
 };
-- 
2.30.0

