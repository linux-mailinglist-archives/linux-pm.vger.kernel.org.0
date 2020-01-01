Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119C512E0DF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2020 23:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgAAWqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jan 2020 17:46:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgAAWqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2020 17:46:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so37745964wrt.6;
        Wed, 01 Jan 2020 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lI4RrpMjz62JbgDo95yJS0Mqb0UUPAV2Uk9R9pg5xWw=;
        b=TqAERPi7ioFE24kW/xlN5KJtUG++NJrFGg4RbihfQMGJkFoOO53X4Sgb1cjKNiuZAk
         n6vCIyVXdNlOn7OOskTHXqlpvsXaJVv1zzgrQQhurdtDWl+CjeZp/ZMGeh/8LP8GqK1v
         lBHfctNT+4btCp3WNmKu8pydsN5H9ZWRR99Hw5o5d6veiv7wJbdgK/jUDoWRrsZ2bycd
         HzMGtB+03pi7G98v8+8FdUYLryt0+0uZOnRjqKCMYHDmx/Zg6cu5d0swFVhlQvIpoSnG
         Dyl0cQ4P/spYcr7VknXMHfpP9sAC0GIVOi/Ul/xAl56vaj/9TKNp4pdXkE9d0w+f81oO
         1F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lI4RrpMjz62JbgDo95yJS0Mqb0UUPAV2Uk9R9pg5xWw=;
        b=DJEU+vAZkqYhFzrUnQQ6MYpm3T+nqylN+tBAZ1FFDqSLfiRf+vG/4BzshHVBEwZi23
         Q4xTh5FJyKga4TAF+I5Jei0j8MrfkwI/Mxmt9sVAux6p/nymq61qUacAafw63l0HrQsY
         9uGpKkja4sncD9WAwVv/Xml8QyfhGnJP5c7impmf7sDGi5w8xLtP93berYfNjmL7w9Z5
         i9x4VD3MV4lzN8L3qLDTAQQRt5EAKgFYsQA/IE0CbETjpXiNCaAdx3pQ9ZV9k2VQb1T/
         83tYMpLrQoPfcZ8HQkXZ+jseULpWNaD5lNkGSmEklVYwJsknYVYFFhQ31EU6mPMxkkpc
         vxeQ==
X-Gm-Message-State: APjAAAXdfG6sUhPu/Es2bZAtGpjG9TPLax1yEnDmsMVaNlTx0kqHvF8T
        BGR9yB6IkzNNRutkMF8YEdA=
X-Google-Smtp-Source: APXvYqwcvgqHsuOBUqdpVpgj/4Ovg07UMavEEZQop+RHaSQ5McsAmZNxLKe70jp2roPHNxrB+FhLRg==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr83943283wru.382.1577918794911;
        Wed, 01 Jan 2020 14:46:34 -0800 (PST)
Received: from localhost.localdomain ([46.216.160.87])
        by smtp.gmail.com with ESMTPSA id c195sm7053994wmd.45.2020.01.01.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:46:33 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.93)
        (envelope-from <jekhor@gmail.com>)
        id 1imml6-00039s-6M; Thu, 02 Jan 2020 01:46:32 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 2/3] power: supply: bq25890_charger: Add DT and I2C ids for all supported chips
Date:   Thu,  2 Jan 2020 01:46:26 +0300
Message-Id: <20200101224627.12093-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20200101224627.12093-1-jekhor@gmail.com>
References: <20200101224627.12093-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bq25892, bq25895 and bq25896 to list of supported device IDs for
DeviceTree and I2C.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index a3dcd4eb1287..28a3f32001e2 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1041,12 +1041,18 @@ static const struct dev_pm_ops bq25890_pm = {
 
 static const struct i2c_device_id bq25890_i2c_ids[] = {
 	{ "bq25890", 0 },
+	{ "bq25892", 0 },
+	{ "bq25895", 0 },
+	{ "bq25896", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq25890_i2c_ids);
 
 static const struct of_device_id bq25890_of_match[] = {
 	{ .compatible = "ti,bq25890", },
+	{ .compatible = "ti,bq25892", },
+	{ .compatible = "ti,bq25895", },
+	{ .compatible = "ti,bq25896", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq25890_of_match);
-- 
2.25.0.rc0

