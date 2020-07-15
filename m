Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB722070C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgGOI04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgGOI0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84508C08C5DB
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so1528148wrs.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCQLIBPnltOFRS++BAxztAHTwj2wSWnOs3LHnUsG1Vw=;
        b=MCdybl3Gw37G1Bq/aJP5Pe/EbpLyiPirff+C0yH74i5zHU8WcFuucv4pc/ZhtSSWEb
         ttmjNt5ZOBIvwTOM+6NTPRrCdWBMnzyTvyBLIj9ihMHFxmoMVzIWV6oDuc6y7Ddiatc+
         odBn85hD3ytXmPY/VclQxhIvmv+JEXhZ/+C/UmsSczSruP7d2KHaPnrQXUuIKYHaVTle
         aqGRE6kd+T5yIuyJ7NE9pl8ssXT3aL++/ogfFrPvX97pp8CLI1PSDK5sv11Crmh69/s8
         cdeR7g8HxgeKnBP4l2E4bI0m07BfB8de3Xn+NIPTWcrVc0fTiXnI3i5b1Bf+irA6SiuL
         z/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCQLIBPnltOFRS++BAxztAHTwj2wSWnOs3LHnUsG1Vw=;
        b=fYKO7zp7NFKrph9q8pOMDDVm/kJpozkkG6s2ilBqeBLMgLmHXZd43m+cBwcdOXa7jZ
         ELDg4lVWTwZoB4pOmogAD8nauEj/63R2XtCedJTF+zM6QjzEQz78YPTbCnSwbQRPNzXk
         jr+MVwKk+rMxKJr0e2bzZ2cJ3mGQCi9lHYxOk16Q09kuFPle5MkIZCDFdnpQlz/hBdBd
         x4mvvmEavYZ7HeuM8VvPNWFPOCfNfLAmg5CLHoDgAYZHQHbvQrQmpcR4BQ/NVVKDV+Hs
         wAIyCBsxNFH3qVPYfr3+2tN9NhmW5iiehwuY3fnvyNhAuuEp9THN9xiI5ijuwyt43434
         icvg==
X-Gm-Message-State: AOAM531MxBCUEnK8sk+1OEYgqcJjbZqzehuqBX27TwBOLfIHgsRKIfee
        Thn4d2P0T6p7/mL5sLH3CAAFYg==
X-Google-Smtp-Source: ABdhPJxlua+SYa5MMQ296pyJ156z28xC7KELszStrbytWumw2AI+ZT38OsX9kXDGi5NnDOmPRNNLBQ==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr9955251wru.411.1594801612237;
        Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Matthew Garrett <mjg@redhat.com>,
        Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH v2 11/13] cpufreq: pcc-cpufreq: Mark sometimes used ID structs as __maybe_unused
Date:   Wed, 15 Jul 2020 09:26:32 +0100
Message-Id: <20200715082634.3024816-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not used when MODULE is not defined.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/pcc-cpufreq.c:619:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
 619 | static const struct acpi_device_id processor_device_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Matthew Garrett <mjg@redhat.com>
Cc: Nagananda Chumbalkar <nagananda.chumbalkar@hp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 5789fe7a94bd3..9f3fc7a073d07 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -616,7 +616,7 @@ static void __exit pcc_cpufreq_exit(void)
 	free_percpu(pcc_cpu_info);
 }
 
-static const struct acpi_device_id processor_device_ids[] = {
+static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, },
 	{ACPI_PROCESSOR_DEVICE_HID, },
 	{},
-- 
2.25.1

