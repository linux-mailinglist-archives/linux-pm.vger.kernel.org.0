Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35D34761B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 11:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCXK2x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 06:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhCXK2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 06:28:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B300AC0613E0
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 03:28:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id g10so7677274plt.8
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=WEBWemoFlRUxDAbCOU3NDRqXpUI03UUvlFIm/pLjApQ=;
        b=CYYeJbjrV8vZbCZbbhcN71gEbVRP0wGfVvYukP1jBaKV/abhvcAEEhipldOWxkq9rn
         z3o5RensIhxNdOFL2duyElfITMGckHutAnuWJ9tMF8iUBT4eAp9ata7bKiWZOFhRJqIq
         3IPFUnNsSgCPLn1OUhtyamVjXXWCgupWH1rDWGmrujf+4O/Eh2xvrw9QocRbI4lW4GzS
         qlfmrB1tNM5DvzAR+ZNCNBwZx5iylxKVLjhgZ2UJWbSYC09lMXdhgIfcw3OV77sSOfWP
         rzMSnGrvRB/ch/LojbAcn86mMBf5pJwPm4EIfwmQnavbbcDyIZAA1HrN5eBooM6xIVUo
         eGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=WEBWemoFlRUxDAbCOU3NDRqXpUI03UUvlFIm/pLjApQ=;
        b=BgXk4T3QUDbCBiHqNIhUf8EFbl4HUE6QqsBCEo7EIsgcbcRoDip3UMliv7j6IgzYGj
         mpQvLxCWM4SYewfFM23CKbur62sWFTLnYuJVUoeOglXu1Oa4ccngh91sd5fVGo86QZeB
         3lO/TL+y8uBYmPV/SdVyuZdC067HWtwjzNtg3U551T5BRoAaLNeUHAEu+019AgMmiXC2
         RyBW/3Px3MuTILTH77X4KqsGmEVmoQIByEv5nfEQq5KtEUSPMdH9bCuXD1FgLT92S9lR
         VxmPJC3Y6XevNwHt1+wSzVAz+a2nZRZUbRvfElW6d5iAlcKEtPymFplcifsSkEqdYJm+
         BEZw==
X-Gm-Message-State: AOAM531WOzOZV+lhkTHS3vswQQIujoSz0vGCF7jwrlp1rqxiHdOIkBsA
        zkai7wYTcTeimNqpnmAu+cc=
X-Google-Smtp-Source: ABdhPJxdHo/ZM+cnOAGT6X96x1jRbbr1j93R/LIDztG82wVbDY1bssL5bIHxXpiKyuLtoWdb5KwJWw==
X-Received: by 2002:a17:90a:f2d5:: with SMTP id gt21mr2888722pjb.197.1616581687195;
        Wed, 24 Mar 2021 03:28:07 -0700 (PDT)
Received: from MacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id gf20sm1968176pjb.39.2021.03.24.03.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 03:28:06 -0700 (PDT)
To:     linux@dominikbrodowski.net, sherry.hurwitz@amd.com, trenn@suse.com,
        linux-pm@vger.kernel.org
Cc:     lishujin@kuaishou.com
From:   xufuhai <xufuhai1992@gmail.com>
Subject: [PATCH 2/2] cpupower: fix amd cpu (family >= 0x17) active state issue
Message-ID: <e3f8c0f1-63dc-9b25-7129-d0a4ee87f62a@gmail.com>
Date:   Wed, 24 Mar 2021 18:28:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: xufuhai <xufuhai@kuaishou.com>

If the read_msr function is executed by a non-root user, the function
returns -1, which means that there is no permission to access /dev/cpu/%d/msr,
but cpufreq_has_boost_support should also return -1 immediately, and should not
follow the original logic to return 0, which will cause amd The cpupower tool
returns the turbo active status as 0.

Reproduce procedure:
        cpupower frequency-info

Signed-off-by: xufuhai <xufuhai@kuaishou.com>
Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
Signed-off-by: lishujin <lishujin@kuaishou.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..be96f9ce18eb 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -30,10 +30,15 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		 */
 
 		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
-			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
+			ret = read_msr(cpu, MSR_AMD_HWCR, &val);
+			if (!ret) {
 				if (!(val & CPUPOWER_AMD_CPBDIS))
 					*active = 1;
-			}
+			} else
+				/* no permission to access /dev/cpu/%d/msr, return -1 immediately,
+				 * and should not follow the original logic to return 0
+				 */
+				return ret;
 		} else {
 			ret = amd_pci_get_num_boost_states(active, states);
 			if (ret)
-- 
2.24.3 (Apple Git-128)
