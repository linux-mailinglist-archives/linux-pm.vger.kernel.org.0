Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D73FF5B1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347481AbhIBVhW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347471AbhIBVhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 17:37:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD13C061575
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 14:36:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so2695274pff.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8y6wF+XQ52afzGRquz6577KWZV/UU/rjnNku3tx/TIU=;
        b=kFc970RVraCTGWGhfGtzUtm6CShTtpLV6TYXR2MBGnvekHUyEEaaQSUT0tUYlYS+Nn
         uKCZcYkaK0K3mDCNttkgSUi38AOq4FCuXmk+6T4krnNlME6t+hcN8JH3b8HlBqeQ1SK1
         KzwIWj6/LXmU76t7TWm7sqUfT+P6slzw4wZ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8y6wF+XQ52afzGRquz6577KWZV/UU/rjnNku3tx/TIU=;
        b=ZQ1W637lIHFmcLRB1Dn52TCjiv0jQFFg02iSmUR2ZEYWWJFeLwodRmNg9HIDoY2t/H
         B9cQDlkqxwZXT7uuSmaHH+NIGGxVp1Pum9pzDEN0ue7qt4CTWsIhHqvK0wTiGiJw9AZl
         9szxRM3WTw19i4Wkjd4WsksfSCTSh8QutanYkocLkuXWFMee8ddgQTssyUk8ijPVlQaU
         1Tdn0kM4S9iLId5JVbcuEJZnO20LnrXcB5CnHjcwhLsnGpL1T7aveUHzn3Cl4DLfTKN2
         ehu4pb2YAfU/rxCOPsx8wrYWopMeZUsdzksTN7puFa/AWvUDuy9wXD9tP1CyhWXLWQUx
         qwMQ==
X-Gm-Message-State: AOAM533IkMCvJOv0wssLkptnJrfX+5ZJ4O9YWjbwbLAsDJeD/oW7RxDp
        iEr0l3rlqrbR0aaMjyqW9IhAEg==
X-Google-Smtp-Source: ABdhPJyYmRju1CuAw4JTzujNjj7+qmkPyWJVyeKPIhKs5FgBhCIzTZw+RvZ6xOVOlv942yLfLLnJKg==
X-Received: by 2002:aa7:9250:0:b0:3f9:2b90:b34f with SMTP id 16-20020aa79250000000b003f92b90b34fmr237985pfp.7.1630618582491;
        Thu, 02 Sep 2021 14:36:22 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:d082:352a:f346:411a])
        by smtp.gmail.com with ESMTPSA id c68sm3167872pfc.150.2021.09.02.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:36:22 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com, badhri@google.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 3/3] usb: typec: Add partner power registration call
Date:   Thu,  2 Sep 2021 14:35:02 -0700
Message-Id: <20210902213500.3795948-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210902213500.3795948-1-pmalani@chromium.org>
References: <20210902213500.3795948-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a function to register a power supply device for a partner. Also,
ensure that the registered power supply gets unregistered when the
partner is removed.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/typec/class.c | 18 +++++++++++++++++-
 drivers/usb/typec/class.h |  2 ++
 include/linux/usb/typec.h |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeef453aa658..14a898440342 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -845,11 +845,27 @@ EXPORT_SYMBOL_GPL(typec_register_partner);
  */
 void typec_unregister_partner(struct typec_partner *partner)
 {
-	if (!IS_ERR_OR_NULL(partner))
+	if (!IS_ERR_OR_NULL(partner)) {
+		power_supply_unregister(partner->psy);
 		device_unregister(&partner->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(typec_unregister_partner);
 
+int typec_partner_register_psy(struct typec_partner *partner, const struct power_supply_desc *desc,
+			       const struct power_supply_config *cfg)
+{
+	partner->psy = power_supply_register(&partner->dev, desc, cfg);
+	if (IS_ERR(partner->psy)) {
+		dev_err(&partner->dev, "failed to register partner power supply (%ld)\n",
+				PTR_ERR(partner->psy));
+		return PTR_ERR(partner->psy);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_partner_register_psy);
+
 /* ------------------------------------------------------------------------- */
 /* Type-C Cable Plugs */
 
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index aef03eb7e152..b75b0f22d982 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -4,6 +4,7 @@
 #define __USB_TYPEC_CLASS__
 
 #include <linux/device.h>
+#include <linux/power_supply.h>
 #include <linux/usb/typec.h>
 
 struct typec_mux;
@@ -33,6 +34,7 @@ struct typec_partner {
 	int				num_altmodes;
 	u16				pd_revision; /* 0300H = "3.0" */
 	enum usb_pd_svdm_ver		svdm_version;
+	struct power_supply		*psy;
 };
 
 struct typec_port {
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index e2e44bb1dad8..905527dab78c 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -22,6 +22,9 @@ struct typec_altmode_ops;
 struct fwnode_handle;
 struct device;
 
+struct power_supply_desc;
+struct power_supply_config;
+
 enum typec_port_type {
 	TYPEC_PORT_SRC,
 	TYPEC_PORT_SNK,
@@ -132,6 +135,8 @@ int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmod
 struct typec_altmode
 *typec_partner_register_altmode(struct typec_partner *partner,
 				const struct typec_altmode_desc *desc);
+int typec_partner_register_psy(struct typec_partner *partner, const struct power_supply_desc *desc,
+			       const struct power_supply_config *cfg);
 int typec_plug_set_num_altmodes(struct typec_plug *plug, int num_altmodes);
 struct typec_altmode
 *typec_plug_register_altmode(struct typec_plug *plug,
-- 
2.33.0.153.gba50c8fa24-goog

