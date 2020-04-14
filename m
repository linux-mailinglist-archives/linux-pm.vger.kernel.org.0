Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B551A70D5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 04:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgDNCKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403973AbgDNCKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 22:10:06 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA110C0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 19:10:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id p31so11070833qte.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 19:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UePEpdaC2ycyMQqKY3VvUVHzAITFO1WaLxj8IrY6qu8=;
        b=Y+Ch9R+mOG0WOz7fZC803YgQZdgH1am2v/9Ef141meGmpPoUbpreVAJyRcI+oV0cD9
         TaNv6Iyv8eMgXCqU0AopIUqaw2MfJ+Wru08nUN7ralt2JbP4Oz3f1JrsiNfg7xr1Enmz
         9mhYae6iwZsb2iGqDs8x9q/TckA9htOYT6zTGZS6YTzBRaGL9Dyen4eBhaJOfY9se8jy
         GKeqotAahau8bBySfs/8GeWVQOoIS3GUiKThD6S7NZQC/6q4ChRSGIkxIyif8eHtgOqE
         nqK00YyvOX6cvLtWTk5LlkFoF2zB2MtQjUMz7IZzCUKVXZXBDSkT1J0ygTqtr1lx0ca3
         rj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UePEpdaC2ycyMQqKY3VvUVHzAITFO1WaLxj8IrY6qu8=;
        b=Vkzm8JI6a8w1qbGATO4F0dRqyaFPzpzhhZ6xgfWiOO9uCnJE661Dc9Awo7c/UAqblq
         dSgBoDPN+H4oJE++0XHjsy8Fx/z40l81bd0Ho/+pdee8tYNxKOVDmG9FF8yrxBe0YSGf
         B+H5wIiaGqeeosJD5WHzYfBEq8bZXesLnvhG5/TNZDnuFu145oziNLUfav1R6JrMANv/
         bVd8c4fDCLS+ZBsnqYFCCPggvZvUmm6OCoQQzBmbpQXyhuYn75o97e0rcic07jTCq9DS
         OWGxL9VChfEYdD11LHcoq1DaBf77GOMLECyY3lmgkB6DUJ+5/Zw07KKGqda15kFhp2nC
         QOxg==
X-Gm-Message-State: AGi0PuZLhnxK06+gKKDn8Ssn6kc5KU88cTO3r2wWg4S9d7fjF5TvDKSf
        DDrZUXsZyC7p8+N9orjazdkYpeYP7wygwqgYCfSSsQ==
X-Google-Smtp-Source: APiQypIrcUF9MRaDBPvC8wMspH6egQhEXdv3UeW3HCocsYf3qGlfvURiiWOX63Mr0bOz4rfHeUbXGxtMjVCJ8/kI8altEg==
X-Received: by 2002:a0c:e848:: with SMTP id l8mr20182788qvo.82.1586830204047;
 Mon, 13 Apr 2020 19:10:04 -0700 (PDT)
Date:   Mon, 13 Apr 2020 19:09:53 -0700
In-Reply-To: <20200414020953.255364-1-matthewgarrett@google.com>
Message-Id: <20200414020953.255364-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20200414020953.255364-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH V2 3/3] thermal/int340x_thermal: Don't require IDSP to exist
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com,
        nisha.aram@intel.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

The IDSP method doesn't appear to exist on the most recent Intel platforms:
instead, the IDSP data is included in the GDDV blob. Since we probably don't
want to decompress and parse that in-kernel, just allow any UUID to be
written if IDSP is missing.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 3919098a73b47..19936709c2ad0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -96,6 +96,9 @@ static ssize_t available_uuids_show(struct device *dev,
 	int i;
 	int length = 0;
 
+	if (!priv->uuid_bitmap)
+		return sprintf(buf, "UNKNOWN\n");
+
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
 			if (PAGE_SIZE - length > 0)
@@ -113,11 +116,11 @@ static ssize_t current_uuid_show(struct device *dev,
 {
 	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
 
-	if (priv->uuid_bitmap & (1 << priv->current_uuid_index))
-		return sprintf(buf, "%s\n",
-			       int3400_thermal_uuids[priv->current_uuid_index]);
-	else
+	if (priv->current_uuid_index == -1)
 		return sprintf(buf, "INVALID\n");
+
+	return sprintf(buf, "%s\n",
+		       int3400_thermal_uuids[priv->current_uuid_index]);
 }
 
 static ssize_t current_uuid_store(struct device *dev,
@@ -128,9 +131,16 @@ static ssize_t current_uuid_store(struct device *dev,
 	int i;
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
-		if ((priv->uuid_bitmap & (1 << i)) &&
-		    !(strncmp(buf, int3400_thermal_uuids[i],
-			      sizeof(int3400_thermal_uuids[i]) - 1))) {
+		if (!strncmp(buf, int3400_thermal_uuids[i],
+			     sizeof(int3400_thermal_uuids[i]) - 1)) {
+			/*
+			 * If we have a list of supported UUIDs, make sure
+			 * this one is supported.
+			 */
+			if (priv->uuid_bitmap &&
+			    !(priv->uuid_bitmap & (1 << i)))
+				return -EINVAL;
+
 			priv->current_uuid_index = i;
 			return count;
 		}
@@ -462,9 +472,13 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	priv->adev = adev;
 
 	result = int3400_thermal_get_uuids(priv);
-	if (result)
+
+	/* Missing IDSP isn't fatal */
+	if (result && result != -ENODEV)
 		goto free_priv;
 
+	priv->current_uuid_index = -1;
+
 	result = acpi_parse_art(priv->adev->handle, &priv->art_count,
 				&priv->arts, true);
 	if (result)
-- 
2.26.0.110.g2183baf09c-goog

