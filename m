Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76B22D220
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 01:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGXXRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 19:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgGXXRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 19:17:50 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFD1C0619D3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 16:17:48 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id k4so9408400oik.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=BDEeEoZeABHc+HXpCOvYajS5mvgHITn4YjQHRlTsxl0=;
        b=d+aIo4o56/TqcXavacmRnL6W408B4PflSNTk5w+KuA6bFV2rrAzqbqOYnF33nB4Gfj
         HvTt6jpnoQZwbWtaNIsNAkcfcRB85NnoZTIgVIQjUr+fXsUjysRMytHYWmDncOM3VUUK
         QE/ooqZ76DfB1qDivyg4j+8VFrJQf8cNqcpqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=BDEeEoZeABHc+HXpCOvYajS5mvgHITn4YjQHRlTsxl0=;
        b=Sn1K3EOahpcmY/Xe8WMuXA+r1iqKZj9wfpFEamI/8lIrg+E46ueL6HrBjZ0JiQ8Gt8
         bbYgiuxBPqd+MXHYE23f1wepK5CylgPmLu+8Ob5A5JfA7ksMKvrt7tlp5wjoQkCXJZra
         uU1yx8NmVDBfNtPGMYLNB0qcsf7JBEeooysVPZCdpay9TWDzaF5rW0GBejSshSpGPx6g
         REaiWNviNB75wXZjThDkMjM/UvUG13RJhEgCE0PHQgi3SezONEMa8FDTrBZQnpEfhsDA
         ZsUn7T/eTh9vm/k2qSDKu+ph1kfHpQm4z/2w6KIuH7vL/UD83FS6RkD0IJLgGrRgGNmq
         P26Q==
X-Gm-Message-State: AOAM532Gy5y9BulbVO2o6ySYx3BF76H2d7jzZyMZd9LgWCnSnUwNZUmI
        2wCi1hy80lNtXv9EClPn0kj+wg==
X-Google-Smtp-Source: ABdhPJy+ZTNPeYQLwxF/zT6Poor3lEjzdUUxErLTvxo4LbXU9Ynx6mtXCGgCkuThX12P+TV9csMjdQ==
X-Received: by 2002:a05:6808:a01:: with SMTP id n1mr9634050oij.112.1595632667264;
        Fri, 24 Jul 2020 16:17:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t5sm438984oih.19.2020.07.24.16.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 16:17:46 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.9-rc1
Message-ID: <77dacd99-533a-751b-9c88-5fc03ddc29ca@linuxfoundation.org>
Date:   Fri, 24 Jul 2020 17:17:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------306F1F46DE76E4D6112D14BE"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------306F1F46DE76E4D6112D14BE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.9-rc1.

This cpupower update for Linux 5.9-rc1 consists of 2 fixes to coccicheck
warnings and one change to replacing HTTP links with HTTPS ones.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.9-rc1

for you to fetch changes up to fa0866a1d1be8ffa6979bf2127272b7e3d511fcd:

   cpupower: Replace HTTP links with HTTPS ones (2020-07-17 11:58:04 -0600)

----------------------------------------------------------------
linux-cpupower-5.9-rc1

This cpupower update for Linux 5.9-rc1 consists of 2 fixes to coccicheck
warnings and one change to replacing HTTP links with HTTPS ones.

----------------------------------------------------------------
Alexander A. Klimov (1):
       cpupower: Replace HTTP links with HTTPS ones

Shuah Khan (2):
       cpupower: Fix comparing pointer to 0 coccicheck warns
       cpupower: Fix NULL but dereferenced coccicheck errors

  tools/power/cpupower/lib/cpufreq.c           | 10 +++++-----
  tools/power/cpupower/man/cpupower-monitor.1  |  4 ++--
  tools/power/cpupower/utils/helpers/bitmask.c |  6 +++---
  3 files changed, 10 insertions(+), 10 deletions(-)

----------------------------------------------------------------

--------------306F1F46DE76E4D6112D14BE
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.9-rc1.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.9-rc1.diff"

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 6e04304560ca..c3b56db8b921 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -285,7 +285,7 @@ struct cpufreq_available_governors *cpufreq_get_available_governors(unsigned
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -362,7 +362,7 @@ struct cpufreq_available_frequencies
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -418,7 +418,7 @@ struct cpufreq_available_frequencies
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -493,7 +493,7 @@ static struct cpufreq_affected_cpus *sysfs_get_cpu_list(unsigned int cpu,
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -726,7 +726,7 @@ struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 70a56476f4b0..8ee737eefa5c 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -170,7 +170,7 @@ displayed.
 
 .SH REFERENCES
 "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 14h Processors"
-http://support.amd.com/us/Processor_TechDocs/43170.pdf
+https://support.amd.com/us/Processor_TechDocs/43170.pdf
 
 "Intel® Turbo Boost Technology
 in Intel® Core™ Microarchitecture (Nehalem) Based Processors"
@@ -178,7 +178,7 @@ http://download.intel.com/design/processor/applnots/320354.pdf
 
 "Intel® 64 and IA-32 Architectures Software Developer's Manual
 Volume 3B: System Programming Guide"
-http://www.intel.com/products/processor/manuals
+https://www.intel.com/products/processor/manuals
 
 .SH FILES
 .ta
diff --git a/tools/power/cpupower/utils/helpers/bitmask.c b/tools/power/cpupower/utils/helpers/bitmask.c
index 6c7932f5bd66..649d87cb8b0f 100644
--- a/tools/power/cpupower/utils/helpers/bitmask.c
+++ b/tools/power/cpupower/utils/helpers/bitmask.c
@@ -26,11 +26,11 @@ struct bitmask *bitmask_alloc(unsigned int n)
 	struct bitmask *bmp;
 
 	bmp = malloc(sizeof(*bmp));
-	if (bmp == 0)
+	if (!bmp)
 		return 0;
 	bmp->size = n;
 	bmp->maskp = calloc(longsperbits(n), sizeof(unsigned long));
-	if (bmp->maskp == 0) {
+	if (!bmp->maskp) {
 		free(bmp);
 		return 0;
 	}
@@ -40,7 +40,7 @@ struct bitmask *bitmask_alloc(unsigned int n)
 /* Free `struct bitmask` */
 void bitmask_free(struct bitmask *bmp)
 {
-	if (bmp == 0)
+	if (!bmp)
 		return;
 	free(bmp->maskp);
 	bmp->maskp = (unsigned long *)0xdeadcdef;  /* double free tripwire */

--------------306F1F46DE76E4D6112D14BE--
