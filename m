Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B672C4269
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgKYOtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 09:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKYOtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 09:49:17 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2940C0613D4;
        Wed, 25 Nov 2020 06:49:17 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so2602754pgg.13;
        Wed, 25 Nov 2020 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1I3F4x93QBnka2nDGMC5JfGYk1bQ37Bl9iSSpmaDtM=;
        b=V6OKSBNQAvJAezd5Hag6RU+goMxEycQIFMoSvwEDmtYjQTm4niWguaDLAlkBibiR/V
         meOjPykv6FOs3DnqRC1QTqE7M2xEHc6eXCw6pLVlKrZwdXL85Qt4CmR7p9076J6wR7YG
         RQUnnkdBAQDle5moSc/Y3+GfSvgmc4hXU1jLZE2niBI9iXxTB8YVM0EVRnklvdgo46T9
         LAb9pUsgjky9JeGXJhKCnteIZ+juI+LVRlkRrRDYrwaoXG+z57wCHwIFoKuVTpzZEJ5o
         A5nSDhHUoNw6tH+SThvpHDoCaC+HBsV30hgEifYoql/vjXxhTFQMq2v6dmeZWq3fAeyP
         bxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1I3F4x93QBnka2nDGMC5JfGYk1bQ37Bl9iSSpmaDtM=;
        b=G9gcUZrCmmBpWumGAxjwWxwfbtB3VhzK78pUcdaMqzkLvYzt6p67Z8Cd8ToWYSEo3H
         e6TWtoS3uIZqfEaOMA0/ezIQ3Sks2W3zIME6IMMQVwGuaKOoVxg8pIxKFAyuBxi236Z8
         HoIxgTAAl5qkF30/M4hd0QePVfTnBG9gnaOqx3vBvgz6WazqV5RN0FxtX43WGAnoCtwm
         g2vkkfOOAGSUKjuMnQHYZ03Zah9TvLw55Szl0c3bXrzX10UzC6UJlkWSSZhuhfIBbgRZ
         tyRgIxlfW5D420COAgW12tTs5c1cyxR0QfmykgyrQxcHdBmgDAsdTU4q93LgEBYWS5ON
         vjCQ==
X-Gm-Message-State: AOAM531aD9NDiP2D8HjPOc+u4MvwpFp9s98OrolfIgF2NxUM+zt2LO8N
        fn2Br0pr9GlC7Ef6C2DKmVg=
X-Google-Smtp-Source: ABdhPJys2pndSbrJqWCmE3inBNlXC1mcUssPb95pqUUsVTS32Fiue1SiOq0yd36BjrpnyWawhAuDUg==
X-Received: by 2002:a17:90a:e018:: with SMTP id u24mr4649278pjy.189.1606315757273;
        Wed, 25 Nov 2020 06:49:17 -0800 (PST)
Received: from localhost ([2405:6580:31a1:500:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id p6sm3385984pjt.13.2020.11.25.06.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:49:16 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     rjw@rjwysocki.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org
Subject: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the ignore PSD override list
Date:   Wed, 25 Nov 2020 23:48:45 +0900
Message-Id: <20201125144847.3920-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125144847.3920-1-punitagrawal@gmail.com>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
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
index b1e7df96d428..29f1cd93541e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -198,8 +198,13 @@ static int override_acpi_psd(unsigned int cpu_id)
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

