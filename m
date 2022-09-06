Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192785AF5DD
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 22:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIFU3K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIFU3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 16:29:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FED9F18D
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 13:28:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so12439844plr.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date;
        bh=SApL559VYDv9mxhkQIS6YUpqlo0DYsAvN9Xj3AgwwP4=;
        b=KKciEglp50UDtPQYV1U8Si6GNn/Hiq/jaSfPNvLXNp45LRMYss6qcUPsOuVDncEgnD
         nCUXZXyifNEA7Nv/zmWpkbd9HMUTgbQdvVwVKcI++L8HysUmzVI9ByHbx7EImHttaRZy
         TwRLBY4XxU4hQKME1v4sjFq/H/6XkoLI2tGx1hur+O4g0dJXTH/X5rhEUtc3k9T/Bw4a
         uRE9ryzV9h/vSbR7GOFIFsSueYy6dlEVGhccIIKX6SBLhT+fGNtxUkMfv0X6CrxS+0rI
         4DQEVyEXVWusMqXEFw9/vGKsPVfnIaMUWHj5dAockg1Iuzm1bKr0sl24+ARnaAuGr55r
         9uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=SApL559VYDv9mxhkQIS6YUpqlo0DYsAvN9Xj3AgwwP4=;
        b=lAqaBFulv5qd09sF7rFKKge+N5hqyAfwq2LXMiBRqTr3EqfHwJELKWxRJIyJYQyP1Y
         +gKk9f+VVvTOsADnCHPFsXmMgg2D3d09nP5TzLa3inA0EBA8eksEoSLcY6thfU1F3BkZ
         DOxYWHQExXIFBwC7XCRVKP4ROhzVdkYHZvJ3SuZJez7CtUGHInvvKYZvyzo0huWyFh4v
         YRFeyhtLQ71YqlmTBc+miz7ow8KkKf36jEffIBcfuqskfH/TDeoQGshh2xpmGOOzLXBr
         G2jSrwJs4e8g+oMNq5mTHH08WjwAkiXMOxu7GxCRyy7wq05XeBmbUku8/+WUdyu97+/+
         nl7w==
X-Gm-Message-State: ACgBeo3fydIvSbpyUZhJo26OwHctv3gkp/Z8rJ4GCdwCEuEKhgb+rHh4
        MThioGmIj8VX1JNmy8so+F6UwP/9j3dwmw==
X-Google-Smtp-Source: AA6agR7OW3M4SN20bl/4uQ8Fo/RbeMbkiE0/fFGk7TUUcm3CNeoFe4xJ5BTKhJI7f9u9sEOHi4BfrQ==
X-Received: by 2002:a17:902:a704:b0:174:3ad5:30b8 with SMTP id w4-20020a170902a70400b001743ad530b8mr257196plq.14.1662496137190;
        Tue, 06 Sep 2022 13:28:57 -0700 (PDT)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001715a939ac5sm10412275plf.295.2022.09.06.13.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 13:28:56 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'srinivas pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <lenb@kernel.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>,
        "'M. Cagri Ari'" <cagriari@pm.me>
References: <003901d8c22d$02447f70$06cd7e50$@telus.net>
In-Reply-To: <003901d8c22d$02447f70$06cd7e50$@telus.net>
Subject: [PATCH] cpufreq: intel_pstate: Add Tigerlake support in no-HWP mode
Date:   Tue, 6 Sep 2022 13:28:57 -0700
Message-ID: <003c01d8c22f$4a8e2270$dfaa6750$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKqNjiovqToChG3xUCNkHPXWq7dTqwv7neQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Users may disable HWP in firmware, in which case intel_pstate wouldn't load
unless the CPU model is explicitly supported.

Add TIGERLAKE to the list of CPUs that can register intel_pstate while not
advertising the HWP capability. Without this change, an TIGERLAKE in no-HWP
mode could only use the acpi_cpufreq frequency scaling driver.

See also commits:
d8de7a44e11f: cpufreq: intel_pstate: Add Skylake servers support
fbdc21e9b038: cpufreq: intel_pstate: Add Icelake servers support in no-HWP mode
706c5328851d: cpufreq: intel_pstate: Add Cometlake support in no-HWP mode

Reported by: M. Cargi Ari <cagriari@pm.me>
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 57cdb3679885..fc3ebeb0bbe5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2416,6 +2416,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(SKYLAKE_X,		core_funcs),
 	X86_MATCH(COMETLAKE,		core_funcs),
 	X86_MATCH(ICELAKE_X,		core_funcs),
+	X86_MATCH(TIGERLAKE,		core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
--
2.25.1


