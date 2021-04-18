Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08B363343
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 05:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhDRDbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Apr 2021 23:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbhDRDbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Apr 2021 23:31:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65629C06174A;
        Sat, 17 Apr 2021 20:30:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r13so12270597pjf.2;
        Sat, 17 Apr 2021 20:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=b8hpyDKfB8kYMTlAMk33KCFRc04U8eD4yoRmXwd6/1k=;
        b=QD9CvGDnpgRbWHneXST4f0L73kDAKrhp4XF44qas6zt/UnZrKPbSzqonZ8FAnE//RE
         h3NtPhR2ozMriSrwaz8NzPEw52O0CSH2zQMETAV2Na7scbXV2z1+W2nnvfQL7Y+iimev
         Zj7HnYlGYEQneF0qmxYiKrEaEtIUfcR41XhxcZt1g9LakIUuE4A8UKDvy47qWbMJ5l1q
         TCHiofw7fJuy/Vxj6/hd8ZeIhSUczGAYrRn6X2DR4W0Wb4vflMHu+e/ouXO5Vtw0200L
         69L942WvYdPzXzKSOX+0R48uFimIsCBFRGqR1ya3b25A5zKMZSb2DhQWr+tN1MBPv7+S
         Zw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=b8hpyDKfB8kYMTlAMk33KCFRc04U8eD4yoRmXwd6/1k=;
        b=Z0piDkGHSfIHxGfbGW6+lRjq/0LglB1TYArHCzfGqCZlvtyJJUlnQSCyd2wwVisptD
         ELpY14v/H7ixT1k9LAi+rNO60nlTS/7189VxPSCwVGrf0GUav7AO6BGUVjB7rxHXZ1Jv
         XlSU7zg6nVni6/Kjd8relTiUhlIseUA5TNQKqYViUYcHbO+sVzF9sRDcbp6Y+pH9ql60
         8ZZVJwHIwKeyXfuczC/rMNzl9Y/dGALqibew2nlLr+BLl2nV7pQzLOH6Knr/rN60nzUu
         +yVDnhf+FXEnDTSV6SiuycinmQFnLsrHyMINJq6mAoKgtLeaC81HUYYMVb0uedr6y6Vw
         1Ijw==
X-Gm-Message-State: AOAM53186FCqrQFHRAExawIIslSRB6rOFKei+zP8kSE+8li/ekPa+OWT
        OW6oMSXCCUXA7n9VrOpOe1bCBRrlnPFlGt6ANz0=
X-Google-Smtp-Source: ABdhPJxVwmX7HDYx/7rgGE7WvOdjl595q58oeRIUlN4t0gD4eCaKlyLuuhwsjLOnNPEVKMVjCI2qTQ==
X-Received: by 2002:a17:90b:302:: with SMTP id ay2mr17772293pjb.84.1618716643019;
        Sat, 17 Apr 2021 20:30:43 -0700 (PDT)
Received: from MacBook-Pro.local ([154.48.252.71])
        by smtp.gmail.com with ESMTPSA id a26sm8803126pff.149.2021.04.17.20.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 20:30:42 -0700 (PDT)
From:   =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>
Subject: [PATCH v3 2/2] cpupower: Fix amd cpu (family >= 0x17) active state
 issue
To:     shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>
Message-ID: <6e35df20-753a-6c9c-8786-3fc87cdd17ba@gmail.com>
Date:   Sun, 18 Apr 2021 11:30:38 +0800
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

Reported-by: yangrui <yangrui@kuaishou.com>
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

