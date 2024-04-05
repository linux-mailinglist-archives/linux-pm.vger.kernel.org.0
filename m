Return-Path: <linux-pm+bounces-5981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769D89A4B6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 21:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87AC1C20F9B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8817276C;
	Fri,  5 Apr 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4/A+dL1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E516C861
	for <linux-pm@vger.kernel.org>; Fri,  5 Apr 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344380; cv=none; b=VVJJQXBWZgbBTgcATVSfFRqb9/+CKaL5NGGAwnA7opm0VZoAETsOef7IiLFIQvAEnE5pdAadilRxhqsi3NN6MXixuC6S9nAZaWacIRPQQGKMu281HkxDKgzZNWOlykwUlmRpGmZOAkjEUtaALxXgA2v+y8R/usIGBxjzQuL0zxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344380; c=relaxed/simple;
	bh=A45E0Dnro4cEhAf8SKuZOXS769KAgPil2u/nCnyd29g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muCsIscIa2Z6ZXcJyjaSvcvNJOPT6Y8YwErXOAyoq316w0qoUFsQCcyZ5KYivukZ+p9iE/KAtL/PTgmzz/tJfXyspF9GhBKoBpYFkC+xv0QVJ2dU2oONQy5UxCcFNsi9sRbOzN6keh2pkWBw+mCT/TwSFk/IXlhcfHKA1PvgP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4/A+dL1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6993bc144a4so7111336d6.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712344377; x=1712949177; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPyPM8OZMD9zL8KPdnCOXzVIlNnWCyR7K2E5l5W+kwE=;
        b=Y4/A+dL1gyJ7pSFVsvjSOAqYOlnVlT2oqhAuNHzcgMLK8NFJXdF11+SoA0vvufOwVX
         HJHQSp81YmK47oV34vWBrby8spx4NIY1ywMX6BBWOcftCl5uALFzRpM0QICzOhAsQqML
         LdXBq+yct/VIKxXRmi5Hm9FPJuhwSfedEbbc42Rfj9oEee2Cdyk/6c/0obju/g/bppN8
         pyE3RckOQFK7gWKVRou5s3AanmulhjOUrMSWEddABmWC2ziyfupGrjkcI65rmUguIG0R
         kQBKqjo37CSdJNUAbHBBts+AZ3VIdspXICouu25F9ajAHyOea+MOAG3gbXbZ5jg5QLpR
         SXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712344377; x=1712949177;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPyPM8OZMD9zL8KPdnCOXzVIlNnWCyR7K2E5l5W+kwE=;
        b=QJhewURohhOBdXRZfjaan79XydIFDr6fdBz9voUg7H/mmxQyhAFWWBRABu4BNwp+IE
         4MlobVlic90w4BJxIs1JVOw1jicc3I2w2JByBEO7JqNLW5gQhP5fh0OWxg1bpcWAa7oX
         dglXadRaGNHb5Wj3kqM73xiSTcjtxexSLFKhQbb6CJwGOQS9pR/Eb+EKMCC4UYhRO2K8
         5ndhke0fiu9XvwxNXE7783Io6DpfHkHRaFm1drqt7Q3hWdyP/KSG7ChFCEVtX4Xa08TD
         QDI/u41VIucpxj5He3Rsc2PXSEWnawB/o9JWo7hR1C0p99sBnW6dYvM+n48erbYjOldZ
         KwTA==
X-Gm-Message-State: AOJu0YzDQM6by18jV7ELmLtiQ6Rf+3e1MAZc71mt9YTZI7nq+K/Sr4P8
	/Y3ws9bdFYDziArEAkByk2/U9WtoWox4igruz0uj2cOLsDZa7yHlvONPOki9
X-Google-Smtp-Source: AGHT+IFaTffPNO6NsGJ0r/6opSzs+iFCzgKybl3kOYZAZ9WpOCUgP+UiCfnscaicg+qEdz/1P5XvNw==
X-Received: by 2002:a05:6214:c63:b0:699:3798:5ff4 with SMTP id t3-20020a0562140c6300b0069937985ff4mr2139573qvj.40.1712344377360;
        Fri, 05 Apr 2024 12:12:57 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-959a-2db8-c6b5-99b4.inf6.spectrum.com. [2603:9000:9f01:67cf:959a:2db8:c6b5:99b4])
        by smtp.gmail.com with ESMTPSA id o3-20020a0cfa83000000b00691873a7748sm847906qvn.128.2024.04.05.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:12:57 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] pm: Take advantage of %ps to simplify debug output
Date: Fri,  5 Apr 2024 15:12:25 -0400
Message-Id: <2aaa9ba442f027fd9d1011c5fb30adea9bd1b799.1712344255.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

initcall_debug previous and new output:

...PM: calling pci_pm_suspend+0x0/0x1b0 @ 3233, parent: pci0000:00

...PM: calling pci_pm_suspend @ 3233, parent: pci0000:00

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/base/power/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f85f3515c258..de581c33095f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -209,7 +209,7 @@ static ktime_t initcall_debug_start(struct device *dev, void *cb)
 	if (!pm_print_times_enabled)
 		return 0;
 
-	dev_info(dev, "calling %pS @ %i, parent: %s\n", cb,
+	dev_info(dev, "calling %ps @ %i, parent: %s\n", cb,
 		 task_pid_nr(current),
 		 dev->parent ? dev_name(dev->parent) : "none");
 	return ktime_get();
@@ -224,7 +224,7 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
 		return;
 
 	rettime = ktime_get();
-	dev_info(dev, "%pS returned %d after %Ld usecs\n", cb, error,
+	dev_info(dev, "%ps returned %d after %Ld usecs\n", cb, error,
 		 (unsigned long long)ktime_us_delta(rettime, calltime));
 }
 
@@ -1963,7 +1963,7 @@ EXPORT_SYMBOL_GPL(dpm_suspend_start);
 void __suspend_report_result(const char *function, struct device *dev, void *fn, int ret)
 {
 	if (ret)
-		dev_err(dev, "%s(): %pS returns %d\n", function, fn, ret);
+		dev_err(dev, "%s(): %ps returns %d\n", function, fn, ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
 
-- 
2.40.1


