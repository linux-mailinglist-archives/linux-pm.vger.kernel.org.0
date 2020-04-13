Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB831A6DC5
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbgDMVHA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbgDMVG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 17:06:57 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28334C0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 14:06:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e22so9529425pgm.22
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HSxjufempazlx5EL6Oqz0WzuegPQO1JBIjf6VYFe9Lg=;
        b=eBBGEhSwmUtbM/28R1jPRtSlGoaZjrh5Iw30aQEybCW1f1TsI2w2+Qy0VWPC2m97ZO
         JMok85CQUNXRhH+16KHF/vM6RGhmirRuYun9Moz78tVUxpMP6OxQrbRd2btFZrBIXtre
         xqlCj9t3+qlmQzeYstPxszQwbROImI5htMdCYhSNzR24TbaK8Bokor57AJm0sv1ChxMv
         a9XyUjj6+JoGQvkzN3FWOYrPaWYhWptZreUxY1axoCVDImtsibhIxuG6eEkNUn7XUVLC
         s4dJ7/i/7OxBLcqYZtmApixSQe85DAB0mzV5Cu2Fm3c/c/+5FFJcij5Ja/nYnzL9kJKG
         QJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HSxjufempazlx5EL6Oqz0WzuegPQO1JBIjf6VYFe9Lg=;
        b=RViF05O9iv096o9UbhDAGg3jdfAXa4IJMurZD+kOsZBP75ssrOWn+z1u8b5aWbfzwR
         AgRnmJtqjB5N0kbB2EjRYGmfXYU0e5gdqbqtA/HDqS859QfSh+wUHLOtMQ8s/8iD9Hy+
         I+MCwA88JD6d2M7hjxUSBJc16knSiRax6uMyEKID6kJwDCGcPNOP4zqgydqKbXg9vR2X
         gE1CXjC1q4IXcb6dt3sC9fXYIBprBc8hRlXOQSvZaiTDoS90hYb+TKIeSGhrEm5R6hlE
         DGYQKSGmey+k45oiXRUd7cUjjeBGTKdH5CkysQW5Ap3Uhj58lvGtBwxees0YUuZymXit
         7Z2Q==
X-Gm-Message-State: AGi0PuahQZJ+sm7GJmUPwvWN4sirWIjaOOPGltJNEW2La2LevntSqvvY
        aFJzL2eiO3zmq4d7QH7XQZw/ymNcH36ifzebTm4aag==
X-Google-Smtp-Source: APiQypLj2wxTeXWWD/akXvUHZhHVqCJxN8UAQy1avGH0RwTxLR0YBDSDF0srfJAh7ctMWC0hfTGONqJkcAD2wa1lC0/KAg==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr21257991pjn.178.1586812016579;
 Mon, 13 Apr 2020 14:06:56 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:06:44 -0700
In-Reply-To: <20200413210644.201801-1-matthewgarrett@google.com>
Message-Id: <20200413210644.201801-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20200413210644.201801-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 3/3] thermal/int340x_thermal: Don't require IDSP to exist
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
index f36e3e9d246ea..bece011451e17 100644
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

