Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88941B255
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbhI1Ord (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 10:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241322AbhI1Orc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632840352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UXVxRzoO+stk1jCVHn72msXq/bQWSgfleFnZZjGNuf0=;
        b=CIqr/JwgkjATBiRPNlvxkizfNf1hnu8ffA8vd+4c5vMBPUtKIzHDLxhEs+4x8UC45JKYka
        cqCXrx0UnmGJ2u/sNmvoCA96kFnY0sjLd/kWQgIaZRGcmO/EJwjgnmSaTA/bv3LhPskiG6
        g+NDQJaJduCZUc5hEG8rfy6J7b0qmH0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344--ILS5L1rNleRGOjNc9ZdFg-1; Tue, 28 Sep 2021 10:45:50 -0400
X-MC-Unique: -ILS5L1rNleRGOjNc9ZdFg-1
Received: by mail-ot1-f70.google.com with SMTP id o12-20020a9d410c000000b00547056f6644so21213036ote.20
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UXVxRzoO+stk1jCVHn72msXq/bQWSgfleFnZZjGNuf0=;
        b=rXj/3/X4/5LaIHoHVSagGVAyqDJVZD86Ah4qMrrx0YHPzHAmC2oTF+KXRLAdp7d9ac
         Da1IBXxO5n+fd1UBNr7LYIVriTRj2c6Mf8RlWdb2v3KKttbrdzJb0iCFp4OQEBA75rL2
         7oM4uXFT0ipUObEO6RggnTHFRoFUwhut3zHVFB7CorVRRgTg3yToQatqt457So2C5gQi
         nv6HwZYFbrKmamEZy8gqSp0BaPaDUrG0aYXcR5kemV/ghVBZ2gtgsCSHNw3L4u7RfvaG
         hN8aKa2EOCmy+WiDkGuenFaGBDeCzYfv88EdopMfLl/+mc2/7B+xcTxXR9C6ijY22z0S
         F0aA==
X-Gm-Message-State: AOAM531if8VHRS0ttnsX94AQgdcSOVsslwYpElItLswFWDDInorSqhVQ
        kaftbUuEbkyuIdkKTJR6wZzJyGy3aRJ0hRJLIieiN+SmDxirxvYH2BtyDT6/4N0yTgGhgdEouf9
        ucTf6gtgJ8LszJVgcHKY=
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr3979708oic.86.1632840350276;
        Tue, 28 Sep 2021 07:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT5M0vZ9fvSxavrXKTrGoMLFoK8XR6Fl2E8vuT+l+KtGGJmMkl0jhm0bne/f0nQklxY0IE3g==
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr3979695oic.86.1632840350113;
        Tue, 28 Sep 2021 07:45:50 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j4sm4524081oia.56.2021.09.28.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:45:49 -0700 (PDT)
From:   trix@redhat.com
To:     sre@kernel.org, mka@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: core: move psy_has_property()
Date:   Tue, 28 Sep 2021 07:40:46 -0700
Message-Id: <20210928144046.272926-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A ranconfig produces this error
power_supply_core.c:1137:6: error: implicit declaration
  of function 'psy_has_property'
 1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&

psy_has_property() compiling is conditional on THERMAL.  It is used
in __power_supply_register() to check a non thermal property.
So move psy_has_property() out of the THERMAL conditional.

Fixes: 9ba533eb99bb ("power: supply: core: Add psy_has_property()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 75575ea45f21dd..fc12a4f407f431 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -951,6 +951,22 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
 
+static bool psy_has_property(const struct power_supply_desc *psy_desc,
+			     enum power_supply_property psp)
+{
+	bool found = false;
+	int i;
+
+	for (i = 0; i < psy_desc->num_properties; i++) {
+		if (psy_desc->properties[i] == psp) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
 #ifdef CONFIG_THERMAL
 static int power_supply_read_temp(struct thermal_zone_device *tzd,
 		int *temp)
@@ -975,22 +991,6 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
-static bool psy_has_property(const struct power_supply_desc *psy_desc,
-			     enum power_supply_property psp)
-{
-	bool found = false;
-	int i;
-
-	for (i = 0; i < psy_desc->num_properties; i++) {
-		if (psy_desc->properties[i] == psp) {
-			found = true;
-			break;
-		}
-	}
-
-	return found;
-}
-
 static int psy_register_thermal(struct power_supply *psy)
 {
 	int ret;
-- 
2.26.3

