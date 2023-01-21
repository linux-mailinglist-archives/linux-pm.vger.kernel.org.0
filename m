Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB183676774
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jan 2023 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjAUQlh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Jan 2023 11:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAUQlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Jan 2023 11:41:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92FC27998
        for <linux-pm@vger.kernel.org>; Sat, 21 Jan 2023 08:41:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g23so7838864plq.12
        for <linux-pm@vger.kernel.org>; Sat, 21 Jan 2023 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JOX2RPz2RmtLcTQJgM9TGwdLXWI4jQY3SMsLFF1TY9E=;
        b=bmJaKN/bKfHhWZIWLtG2Pvn/c3k/r56F3JpBC0xtiCFoVEaZstRHrIIv1rj8TBRBQK
         wGmh1iELEC3vZAgMiqrS56nSh/t3U7tqztDw/H2VEfLSkeR1QCMYoqTPghwDD/2QCrw5
         VO14AFkoqIv8MWZbasbs6mAtQECs9VDv4lwofXmoUq/4KlG0fMQetgf4bsoUgGy+lik3
         iCQhilOxmKw4VQZOHVr45XTUNjUe9zsrVMCxbH7LXDj8dSRGuB/LGoASQVEf9hrp10zb
         7u40hGlgLiZadPrSVOFXcL/ND+1Ue99TeWOw+KvTXROW8+gNTQ2Nv94yPLnqpVnMziIb
         2geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOX2RPz2RmtLcTQJgM9TGwdLXWI4jQY3SMsLFF1TY9E=;
        b=Tj15zpokS9gucHdSK2Rmw9RKwM9JThMkaJ/bwdmqmMudECWKg8FmYIsOcsLLd6zTNW
         g8PtNsGoKw+hBdm52GYfThIyy4/sFkyH4Vn6oXFAtiL8N4A/YomSNYuw1nf9ZAgiU3+i
         AZVdqbwMQjJMj8bFEyezW2dqQJ+ZTR2RXPLAbysuJSSBnfaQ9U96ysn6vYa8FrZfsPr/
         MZJedaXbumYyqOn5qIDe/rbPC/5wltHXCkRX0crPyktJrTR3T93C36ER1q6IayHX4I2g
         +ucj69kJBHSySUO5c90iqhACa/r6q5RYpZiMohlF0tTHTORd/7ryKyTfiRdFruod2hFO
         p7dw==
X-Gm-Message-State: AFqh2krJLHqw+XhHa6LXmqmhWC40SZm44ySwyMcnZ/oHnmSPG6ZK+ovI
        opDUag/gY2ESyWLjDBtFPKU9wg==
X-Google-Smtp-Source: AMrXdXvq2npG37Pv2yeeR+lthk+zvozE0BI+KQV6/Q4aojPLb99SNXOuSBlijkfumF51ltILhLTyYA==
X-Received: by 2002:a17:902:e811:b0:194:98ef:a40e with SMTP id u17-20020a170902e81100b0019498efa40emr21966312plg.31.1674319294182;
        Sat, 21 Jan 2023 08:41:34 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b00174f61a7d09sm5790513plg.247.2023.01.21.08.41.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jan 2023 08:41:33 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Huang Rui'" <ray.huang@amd.com>, <sedat.dilek@gmail.com>,
        <li.meng@amd.com>, <skhan@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
In-Reply-To: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
Subject: [PATCH v2] selftests: amd-pstate: Don't delete source files via Makefile
Date:   Sat, 21 Jan 2023 08:41:35 -0800
Message-ID: <000601d92db7$39e9d0b0$adbd7210$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adkts+qzXK0iZufMT6q77LIlw14ifA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Revert the portion of a recent Makefile change that incorrectly
deletes source files when doing "make clean".

Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
v2: fix address list.
---
 tools/testing/selftests/amd-pstate/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 5f195ee756d6..5fd1424db37d 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -7,11 +7,6 @@ all:
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)

-ifeq (x86,$(ARCH))
-TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
-TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
-endif
-
 TEST_PROGS := run.sh
 TEST_FILES := basic.sh tbench.sh gitsource.sh

--
2.25.1



