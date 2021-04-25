Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9985136A43F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Apr 2021 04:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhDYCvp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Apr 2021 22:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYCvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Apr 2021 22:51:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE02C061574;
        Sat, 24 Apr 2021 19:51:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so1115894pjz.0;
        Sat, 24 Apr 2021 19:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=b8hpyDKfB8kYMTlAMk33KCFRc04U8eD4yoRmXwd6/1k=;
        b=m6/cs0w0zl6hseoLN0XCTkyI/2aaLandJbgVegkAFPACOK3vgxjDEN5tLvAX1mD8LC
         5Gf5JRweI4mz1gIzNfuzpOQlhubhNHMR8dvqdayX6FNX7heS/1KzGY6Ion08+021ddws
         b1yErDu2H1Y3qst8pJNLJKXW8KYUeKSyAhSaSFYo2HM/3mKIMIPc8UCQSmgFxwhx2e7t
         4q4+zeFWDd4bTfijVbR3Iric+0Ao9j/bEHZRoJZufWoTxoI4ari8fd//FBjTia+fPgac
         gp/OLZrfhU056jbmUBPpSN6zNINdKiCXXSjfiZqJo9FrHFgl3+2bLThsr3SfEXHOKVam
         qCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=b8hpyDKfB8kYMTlAMk33KCFRc04U8eD4yoRmXwd6/1k=;
        b=QIJGKP2FOn1UbEgv7uzxJf+08sp0ZSe2dRT0Ihn5UUsDC5UkVMi82H6NpcX/9f1vQ0
         GiVJuoCtTUMvQVcoUD5diIl/LqqkFniNLj9mVW+y8q+BRElmRVNeRANEOnX+9/hlOBru
         EPulZzr/3vMTwqWKlWoh7EYQxccPXHl0+CI00v92rs9egK8xl+9s7RAsED6+72lsvj98
         Onsy5aD35l8Trtk4mIBMDPIQ7xNlFTCVDmpL2+6OYeApK98pyLZdSG9m84JNg8k0Vlf1
         09jZEVPpAtbiv9JQLPL3F5GSbOCBVersdXlPUDxJuPr7QAinFpISXvBy8kz2O7BoFo4l
         lhXw==
X-Gm-Message-State: AOAM533FV4a1h5JGQcEQjXGPhfaPNbEOh5pnOztGcRedphi5EFnoNUJ4
        u8hUPC2zhv1WKMPLpf6cJAQ=
X-Google-Smtp-Source: ABdhPJzaM529HYznmdqky15x5KtHD46TLDcKeJaBCy+6gtf9+tlf+8eGhlbgwiZ3K2b7y+HYzPva4w==
X-Received: by 2002:a17:90b:180b:: with SMTP id lw11mr14262132pjb.6.1619319065616;
        Sat, 24 Apr 2021 19:51:05 -0700 (PDT)
Received: from MacBook-Pro.local ([154.48.252.71])
        by smtp.gmail.com with ESMTPSA id p22sm10620324pjz.20.2021.04.24.19.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 19:51:04 -0700 (PDT)
To:     shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.com>
From:   =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>
Subject: [PATCH v4 2/2] cpupower: Fix to return negative value if no
 permisssion for read_msr
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>
Message-ID: <2dccdf57-1546-e55e-2efe-3ac91ed7f043@gmail.com>
Date:   Sun, 25 Apr 2021 10:51:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: xufuhai <xufuhai@kuaishou.com>

If the read_msr function is executed by a non-root user, the function returns 
-1, which means that there is no permission to access /dev/cpu/%d/msr, but 
cpufreq_has_boost_support should also return -1 immediately, and should not
follow the original logic to return 0, which will cause amd The cpupower tool
returns the boost active state as 0.

Reproduce procedure:
        cpupower frequency-info

Reported-by:   yangrui <yangrui@kuaishou.com>
Signed-off-by: xufuhai <xufuhai@kuaishou.com>
Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
Signed-off-by: lishujin <lishujin@kuaishou.com>
Reviewed-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..565f8c414396 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -16,7 +16,7 @@
 int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
                        int *states)
 {
-       int ret;
+       int ret = 0;
        unsigned long long val;

        *support = *active = *states = 0;
@@ -30,18 +30,21 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
                 */

                if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
-                       if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
+                       /*
+                        * no permission to access /dev/cpu/%d/msr, return -1 immediately,
+                        * and should not follow the original logic to return 0
+                        */
+                       ret = read_msr(cpu, MSR_AMD_HWCR, &val);
+                       if (!ret) {
                                if (!(val & CPUPOWER_AMD_CPBDIS))
                                        *active = 1;
                        }
                } else {
                        ret = amd_pci_get_num_boost_states(active, states);
-                       if (ret)
-                               return ret;
                }
        } else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
                *support = *active = 1;
-       return 0;
+       return ret;
 }

 int cpupower_intel_get_perf_bias(unsigned int cpu)
--
2.24.3 (Apple Git-128)

