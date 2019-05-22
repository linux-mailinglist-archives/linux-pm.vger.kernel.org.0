Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B098026A0A
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfEVSqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 14:46:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbfEVSqS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 14:46:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so1775872pfo.11;
        Wed, 22 May 2019 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u3rxD76Si1rreVR/ufwhff8U17kCLgf43o2tpv6BK14=;
        b=Nqqa9Cyrpeh6/rKfGS52PannNQ5CJ86HqxGN4VGXXouuktUkuyTFhAQ6pjbZ9s2Ker
         ckTJwFiT7Q4N2PBW31Lk1v4jOBz/1XAxKSNHyXL3kGTV6TLKEv/agmE42pS0tuPWTtnt
         4pGrJC/o5Em4xDYr9Z+gzhty60rZrbSA1tf/o7NqxEUihijsBI4MWjKQ5AQ0DfMddaXr
         /I3pbKzF52t1SiQHVcyBcF96RtikInCpmTHu0dOlMinHtJWQaZDIBfA9dBzVgdInwKy5
         IySN4jdnGgoADxuRxsA4VH4N0XEePcfCzES7GBD2rIN2hsN4HiEloxS04HhAo0M3S9yH
         UBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3rxD76Si1rreVR/ufwhff8U17kCLgf43o2tpv6BK14=;
        b=L+yAjNU7S/khdybSlSdx6s1cpqxDyNSqz/lcyE3g9Mm8U2QsgiRAfnW6qo1q7M426n
         YqAj+cE44LSnG3gsxbqXKe38LCGWGcppYuwYd1bZUBPCLXgXwlvrG1I3TnGqW6viPGAE
         Hront9Ozc5gMNk+5vjlO+apJj5J33ANWA8Te7mJqKX8UBZnxFmpBYI+XZR68JN+FaGbA
         aa3Oe1Z9HDoN6zBRl98W6CXOuwhsl2O9SGzBpHAa8uMXbOFGB7C7k2Cd4H3QGMxGF/1V
         zFofDb5suMtD6iJfmkSUzCoxf3gZnGAnypCVDB7JMmPSRNzIXPSWRsaaoWt/OQ6ZbLvh
         Qxhw==
X-Gm-Message-State: APjAAAUalvabfYRu2FT1as7Rx3ML7gduxdL0FX0gF07bZ48gxGYcI3bt
        ClhEFkbxr7C8kiKxUflgWf75Ts2m
X-Google-Smtp-Source: APXvYqwKvokex+zSA7Iaqc1vU0fduwM0j0rwO79QSTq0RtlnOfTyM7BZiW0XMI1F5kwKPmiWG9Vtyg==
X-Received: by 2002:a63:ec02:: with SMTP id j2mr67524982pgh.340.1558550776195;
        Wed, 22 May 2019 11:46:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 25sm2439585pfp.76.2019.05.22.11.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:46:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS
        CPUFREQ DRIVER), "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS CPUFREQ DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency
Date:   Wed, 22 May 2019 11:45:47 -0700
Message-Id: <20190522184547.31791-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184547.31791-1-f.fainelli@gmail.com>
References: <20190522184547.31791-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

What we read back from the register is going to be capped at 32-bits,
and cpufreq_freq_table.frequency is an unsigned int. Avoid any possible
value truncation by using the appropriate return value.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 6ed53ca8aa98..77b0e5d0fb13 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -384,12 +384,12 @@ static int brcm_avs_set_pstate(struct private_data *priv, unsigned int pstate)
 	return __issue_avs_command(priv, AVS_CMD_SET_PSTATE, true, args);
 }
 
-static unsigned long brcm_avs_get_voltage(void __iomem *base)
+static u32 brcm_avs_get_voltage(void __iomem *base)
 {
 	return readl(base + AVS_MBOX_VOLTAGE1);
 }
 
-static unsigned long brcm_avs_get_frequency(void __iomem *base)
+static u32 brcm_avs_get_frequency(void __iomem *base)
 {
 	return readl(base + AVS_MBOX_FREQUENCY) * 1000;	/* in kHz */
 }
@@ -653,14 +653,14 @@ static ssize_t show_brcm_avs_voltage(struct cpufreq_policy *policy, char *buf)
 {
 	struct private_data *priv = policy->driver_data;
 
-	return sprintf(buf, "0x%08lx\n", brcm_avs_get_voltage(priv->base));
+	return sprintf(buf, "0x%08x\n", brcm_avs_get_voltage(priv->base));
 }
 
 static ssize_t show_brcm_avs_frequency(struct cpufreq_policy *policy, char *buf)
 {
 	struct private_data *priv = policy->driver_data;
 
-	return sprintf(buf, "0x%08lx\n", brcm_avs_get_frequency(priv->base));
+	return sprintf(buf, "0x%08x\n", brcm_avs_get_frequency(priv->base));
 }
 
 cpufreq_freq_attr_ro(brcm_avs_pstate);
-- 
2.17.1

