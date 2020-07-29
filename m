Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32359231CF4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgG2Kwa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgG2Kw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 06:52:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA67C061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 03:52:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z5so13392345ybo.9
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ugRMFAn0FzEH6U3MDRf2DGkDlPPr8KlzMep2WjY159g=;
        b=S8LZfE1UmVZTz9fYRdg6DM85/f9Gra7EmKzW2069JUh7NZHp0og64X4enx7rfMc2nP
         szolAcqFWys0eqKq9toHVNIVGqKXyU0TLONNS4UqmhTZtSE3jk1sh6OMNeBP0qp/GAE1
         H1887XGT8CnmeRY05/0nLrWgi1K9toqkYkeoKgJhPrUDUoSqPH0VmhK2wi6GZFTBVwo3
         bKj0WjCnLG2pIxncVj4bCQx+ou/PRFgpnwpZo0GWLGeoIE+t2v3hqrYKZvxWgbIdX9AI
         i3G64ZNstAqZHJn/tCZCEdrGbKIul4KexaLZYaII9JXul5aygIxxFYEXBlaUjoQRaGvQ
         ZOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ugRMFAn0FzEH6U3MDRf2DGkDlPPr8KlzMep2WjY159g=;
        b=Qrg5PNm9qe2cLimunNaLgR/rthECk655cZtV4yylSKLHjXhhBNuT1fYPcI37FFahY8
         /lXiZ7uGHiTQoJzh5mWpy63IRXb0nTygGXYUtz6dunk2yQok0qxkO50mfcwXLhXYsRxZ
         788pd7uLIxSRog3UJ15Kptp4hNeCX1aTW5gUbdPE99lUsJXx4F2TCoaUZg1eH0XVQexL
         I+KhKI9RmLhOoHr+JN5AZFY5/R/zIGaN7DbxCRw8ykoQQJmlXn5fFoRJT/LxOl8cyVPJ
         JgCXK1mQfAlEP2OO00fvAOUKUYEPRD+/7B+LvWtH5v/oo20H9B2cRlzmlHuBZWWmSbI1
         j2UQ==
X-Gm-Message-State: AOAM530pAYfHvvU/G/1BY9lpc1D/YAYhUeg6JtUGyaeNvPiEwEFPwxFZ
        9PqnExZG9DcbXueWWJeTqN9QHup5gk+iiLxr
X-Google-Smtp-Source: ABdhPJyC+ESInuKukVedQEyRAk0dWvO/+1m2ouUjYg7htdOlaWKS+kGjqlRyigue4QQY3YHIZgG6Sm3ic3cfRfgs
X-Received: by 2002:a25:54f:: with SMTP id 76mr51294163ybf.367.1596019948823;
 Wed, 29 Jul 2020 03:52:28 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:52:05 +1000
In-Reply-To: <20200729105206.2991064-1-victording@google.com>
Message-Id: <20200729205144.2.I4cb96a95365506b77761c1416258672a7556b595@changeid>
Mime-Version: 1.0
References: <20200729105206.2991064-1-victording@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 2/3] powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Victor Ding <victording@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch changes the static struct rapl_msr_priv to a pointer to allow
using a different set of of RAPL MSR interface, preparing for supporting
AMD's RAPL MSR interface.

No functional changes.

Signed-off-by: Victor Ding <victording@google.com>
---

 drivers/powercap/intel_rapl_msr.c | 33 +++++++++++++++++--------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index d5487965bdfe..430b4819d6ab 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -30,7 +30,9 @@
 #define MSR_PLATFORM_POWER_LIMIT	0x0000065C
 
 /* private data for RAPL MSR Interface */
-static struct rapl_if_priv rapl_msr_priv = {
+static struct rapl_if_priv *rapl_msr_priv;
+
+static struct rapl_if_priv rapl_msr_priv_intel = {
 	.reg_unit = MSR_RAPL_POWER_UNIT,
 	.regs[RAPL_DOMAIN_PACKAGE] = {
 		MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS, MSR_PKG_PERF_STATUS, 0, MSR_PKG_POWER_INFO },
@@ -56,9 +58,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_msr_priv);
+		rp = rapl_add_package(cpu, rapl_msr_priv);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -71,7 +73,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
 	if (!rp)
 		return 0;
 
@@ -127,37 +129,38 @@ static int rapl_msr_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	rapl_msr_priv.read_raw = rapl_msr_read_raw;
-	rapl_msr_priv.write_raw = rapl_msr_write_raw;
+	rapl_msr_priv = &rapl_msr_priv_intel;
+	rapl_msr_priv->read_raw = rapl_msr_read_raw;
+	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
-	rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
-	if (IS_ERR(rapl_msr_priv.control_type)) {
+	rapl_msr_priv->control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
+	if (IS_ERR(rapl_msr_priv->control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
-		return PTR_ERR(rapl_msr_priv.control_type);
+		return PTR_ERR(rapl_msr_priv->control_type);
 	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
 				rapl_cpu_online, rapl_cpu_down_prep);
 	if (ret < 0)
 		goto out;
-	rapl_msr_priv.pcap_rapl_online = ret;
+	rapl_msr_priv->pcap_rapl_online = ret;
 
 	/* Don't bail out if PSys is not supported */
-	rapl_add_platform_domain(&rapl_msr_priv);
+	rapl_add_platform_domain(rapl_msr_priv);
 
 	return 0;
 
 out:
 	if (ret)
-		powercap_unregister_control_type(rapl_msr_priv.control_type);
+		powercap_unregister_control_type(rapl_msr_priv->control_type);
 	return ret;
 }
 
 static int rapl_msr_remove(struct platform_device *pdev)
 {
-	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
-	rapl_remove_platform_domain(&rapl_msr_priv);
-	powercap_unregister_control_type(rapl_msr_priv.control_type);
+	cpuhp_remove_state(rapl_msr_priv->pcap_rapl_online);
+	rapl_remove_platform_domain(rapl_msr_priv);
+	powercap_unregister_control_type(rapl_msr_priv->control_type);
 	return 0;
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

