Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9474C2C4270
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgKYOt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 09:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgKYOtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 09:49:25 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A27C0613D4;
        Wed, 25 Nov 2020 06:49:25 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b23so1208213pls.11;
        Wed, 25 Nov 2020 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zftXlCMDlUv3M6vYJwCp4nHdd8CdLRlT8N27SkFN6/4=;
        b=oAcj5kFn+GXNeuFnTvWWt/1y57oIZmm6b8sZRxT66t7+Z6TRw0kFySi1R0dKDqpREE
         QPh0BdX6S6mSaWP28wfeCdid03A1yFBiTG5rfft6MEwb3qOrS5XckvF+4JtFuvadtipf
         MTtZ6MdDATbQXsu67k0raOwycnef4cGsjx2yyoyBo8IWjmlpOS5gsnIUXsOzMqds7YJR
         EW0C7PmLUi188Y7OyglJNON6jzC7jhRUviQc2ENap4HfiqgpQH0CiXge4Ile+LvRCwqJ
         rZJzSSkBomRycNZg2LOR/81eDuprr5X9h4gQTMP50CxD/mgcQLA/N9WxWSRfVOqt9IYG
         ojFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zftXlCMDlUv3M6vYJwCp4nHdd8CdLRlT8N27SkFN6/4=;
        b=LCyzc0DJp1wWuqK+QuZBJXyygMwr191sCzecowyqTzm7ybhTCutp4/jUdD067QotX/
         v/qt/d6DdORUcD4ZX0XMey+2Y/FGNdIMjEeRdG+w4B3rtKYkUKUF+WM/cKIbCpg/u2LZ
         hi25US6HsRJ2myI0K4UFN6QUFIKP5ku4MmWhGUguJCQAgPgLQegSpDTCEmO22ek3IM23
         3uGECYSfISTw0EgJgnXceBf85U5ozlVx6Hxbi62sV0SvAluIgWg4e2sg15sJwc3LLm2z
         vdle0kUDp+qjCBpRNoZy/hUNC1H/oVCmbdqrTg56yYz8fxzbaqvPGCG26Z2xrncioV8J
         bSug==
X-Gm-Message-State: AOAM533vg+er7zpQ4SFcp/5P/Cpw4XbanxDVPkDbsCJTZ9w/MsYUgnpK
        +ufpWk0FNNhWW0Xd566r7Cs=
X-Google-Smtp-Source: ABdhPJwgGop2hVzbU3cBE0dD+oz2HBIhBsnVKLAmmb2QwR8CJylr2aJsYf5Apz5eWU2MVTNgGU161g==
X-Received: by 2002:a17:902:9b85:b029:da:1684:cc82 with SMTP id y5-20020a1709029b85b02900da1684cc82mr3487168plp.41.1606315765405;
        Wed, 25 Nov 2020 06:49:25 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id i29sm2412718pgb.10.2020.11.25.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:49:24 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org
Subject: [RFC PATCH 4/4] cpufreq: acpi-cpufreq: Use identifiers for AMD processor family
Date:   Wed, 25 Nov 2020 23:48:47 +0900
Message-Id: <20201125144847.3920-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125144847.3920-1-punitagrawal@gmail.com>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace the raw values for AMD processor family with recently
introduced identifier macros to improve code readability and
maintainability.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 29f1cd93541e..d8b8300ae9e0 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -202,8 +202,8 @@ static int override_acpi_psd(unsigned int cpu_id)
 		 * CPU's before Zen3 (except some Zen2) need the
 		 * override.
 		 */
-		return (c->x86 < 0x19) &&
-			!(c->x86 == 0x17 && c->x86_model == 0x60 &&
+		return (c->x86 < AMD_FAM_ZEN3) &&
+			!(c->x86 == AMD_FAM_ZEN && c->x86_model == 0x60 &&
 			  c->x86_stepping == 0x1);
 	}
 
@@ -735,7 +735,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-		    boot_cpu_data.x86 == 0xf) {
+		    boot_cpu_data.x86 == AMD_FAM_K8) {
 			pr_debug("AMD K8 systems must use native drivers.\n");
 			result = -ENODEV;
 			goto err_unreg;
-- 
2.29.2

