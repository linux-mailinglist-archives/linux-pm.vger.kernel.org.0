Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1B2D6B40
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 00:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgLJW6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 17:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387740AbgLJW5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 17:57:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFCC0611D0;
        Thu, 10 Dec 2020 14:57:13 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so5574358pfu.13;
        Thu, 10 Dec 2020 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZteqEo5dum2oY6sAzGjepA85X4v2vyEYokB4KqxqTgA=;
        b=TUUfFFjMN/wZMPt4tAVydvbcDxRAa0drzqEe/AWAOMBU2bZxso75BCq++GHFFjDJUy
         h3m1Fcr+Lfr0xxTx8vgQv5lkfRhA1guqu2hdTO4f/LzKbIHzqxXVfgqXq/oRwihztfbp
         WVWnSfzlZBpCF3qE1q3ORqyhAkLbbcSANG9y5rryte0yt6DUZ8aADs96DGCgi80G8h5J
         eOwYl3oja0CyR22r9K/38/J8cVf0NRt/Qs1NUJGkXDDlrFYBcqWwHElt7bHeNLx0F00R
         qXBSP9+im7zu+5E7xMngNscHjpcC1KneDzl5sKddto8o47ZS5YqeU/as6cJFrbc/RSYy
         D7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZteqEo5dum2oY6sAzGjepA85X4v2vyEYokB4KqxqTgA=;
        b=OI5OdRBMSBcXXRjz9N737sKS5+t+LCMwaU6EX1rPtXN2m+4MvaaP0TcL2R7knyyezO
         4sAZ4w0k7LvbyqJTpyxeT2mc1Kg5jdysoe8oK3zXgZTFyuxF3EXxTAmLRclwa/GVSQIc
         3w0lM0CCE8zAVEu20t4xaCWpN+PZzslK1ubguUiowl539HOD7ESlr1ZXJ/VXrFuxbd5u
         rbx1cRXEeDP3ucUVvkf642s0Ybd+ts7LrM4pkvHsG3OeXWs9AFjtjEADY0DoiKmc6QvO
         Vji2nTnqKY5EYhWS39S7WHYS5MdZegY0/2LoIqqZppAnd1XRDip72Hi7oQ7pTBTw38jk
         xztw==
X-Gm-Message-State: AOAM531xTUg/8f6/MegKSdGcAeVXc1MS0NlKGpdy1ILMImbcWjqnD0Yg
        yX67VCVFeyKDhAytIfFnjEw=
X-Google-Smtp-Source: ABdhPJyPcpt3x5D3l6rkCqLYEE72wk8GdWXKsmGjsFssbFwGiDWMj9Xy2UzFgMv09FcyK3s0rFKgNA==
X-Received: by 2002:a17:90a:2e84:: with SMTP id r4mr10001322pjd.147.1607641033190;
        Thu, 10 Dec 2020 14:57:13 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id w24sm7469681pfn.100.2020.12.10.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:57:12 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de
Subject: [PATCH 2/2] cpufreq: acpi-cpufreq: Add processor to the ignore PSD override list
Date:   Fri, 11 Dec 2020 07:56:40 +0900
Message-Id: <20201210225640.317719-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210225640.317719-1-punitagrawal@gmail.com>
References: <20201210225640.317719-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Booting Linux on a Zen2 based processor (family: 0x17, model: 0x60,
stepping: 0x1) shows the following message in the logs -

    acpi_cpufreq: overriding BIOS provided _PSD data

Although commit 5368512abe08 ("acpi-cpufreq: Honor _PSD table setting
on new AMD CPUs") indicates that the override is not required for Zen3
onwards, it seems that domain information can be trusted even on
certain earlier systems. Update the check, to skip the override for
Zen2 processors known to work without the override.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Wei Huang <wei.huang2@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 126315ad225f..32b6449a438b 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -198,8 +198,13 @@ static bool amd_override_acpi_psd(unsigned int cpu_id)
 	if (c->x86_vendor == X86_VENDOR_AMD) {
 		if (!check_amd_hwpstate_cpu(cpu_id))
 			return false;
-
-		return c->x86 < 0x19;
+		/*
+		 * CPU's before Zen3 (except some Zen2) need the
+		 * override.
+		 */
+		return (c->x86 < 0x19) &&
+			!(c->x86 == 0x17 && c->x86_model == 0x60 &&
+			  c->x86_stepping == 0x1);
 	}
 
 	return false;
-- 
2.29.2

