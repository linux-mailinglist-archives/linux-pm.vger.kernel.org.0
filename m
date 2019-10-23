Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFFE1AB1
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbfJWMfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 08:35:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39427 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbfJWMfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 08:35:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so20939447ljj.6;
        Wed, 23 Oct 2019 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JcGUwHNUmi5qOF1a27ni/CENfjWZcZrztrncDMQ0bW8=;
        b=D64ET+S/rv4gHRo0XeFvrV4wEcIce2rA2FSbjIKBtweLKnw6tTvqMk7ayU9TQg9pu/
         pNywHqqrjFMUxt3sBygBH5BBrP3urjnGedt1rmBMNUHwZRH8M2syjtXDa0BemRrZbvii
         Br6eZRW/9w83ZJlIxsg4+6pi5tOc86tDjyhX9gfPWSdtUgZgtL59GL4uxW2Mlr1o1/91
         6wyOszlXvnA6kgw8avDeQxDzVDUqBfUWB349TsduJmhhOkHlH+5NJjfNm4I1OMjfXNjw
         /xfh+rp9L+wPLMOfLr5ZtCneKPwL7BCCTEWHwN7YFpvxZHedpSdDyCN88KAYBnzuT8dC
         rL8w==
X-Gm-Message-State: APjAAAWXxpb2iunLzzMa2XRK+8rs8Xe3omAdD0CVhGcmAbLEKiBKeZV0
        JgO1YV4zZhpdHkTivm/kWxb9Xj1uwnw=
X-Google-Smtp-Source: APXvYqwiORXoUEBj+HPoPE4FEYiLqkev0ZKgtDUHE/fkDpXaGRJW4GEpDqrpPizZci9bxPbxX7SxVA==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr22260129ljj.52.1571834131816;
        Wed, 23 Oct 2019 05:35:31 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g3sm2488517lfb.58.2019.10.23.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:35:31 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:35:24 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: bd70528: Add MODULE_ALIAS to allow module
 auto loading
Message-ID: <20191023123453.GA2918@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bd70528 charger driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell for
charger is added.

Fixes: f8c7f7ddd8ef0 ("power: supply: Initial support for ROHM BD70528 PMIC charger block")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Not sure if this should be bugfix or new feature. I don't think Fixes
tag is a problem though.

 drivers/power/supply/bd70528-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 1bb32b7226d7..b8e1ec106627 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -741,3 +741,4 @@ module_platform_driver(bd70528_power);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 power-supply driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd70528-power");
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
