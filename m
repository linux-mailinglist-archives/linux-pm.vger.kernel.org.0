Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8717C983
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 01:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGAOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 19:14:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37130 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCGAOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 19:14:37 -0500
Received: by mail-io1-f68.google.com with SMTP id k4so3833902ior.4
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=qHW39RVm7bhWzHPvxHxpEyDEco8gsFv/J35u+/IoltA=;
        b=J79Zz33ccEHtFjCmy9lqmtpwTUvJI7SNKysWkS0rgJ7VSULB0xWC3T/IZbHYf/Luhg
         NOJbQKNg9RQdTxHqlkXNm/RKY3MsZmRAzD0Hvgs2LmdlkYLR6HaRxFVaObdn0TsO1hYC
         K0om2DWVwl0rO0VzQnz2T8brn8vLec/IV5+Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=qHW39RVm7bhWzHPvxHxpEyDEco8gsFv/J35u+/IoltA=;
        b=MHSPdM9smo089R2r+QD48JRSHWA9bXnkyZF792SNFawISAbLBTCvNu/vLC7Ae6JdoT
         DyHvMq0p0fSyEYM4doe0cz9EMln7UPc76jVoeG1nATCVorBf7Fd9IxR+O5KM0Am738tu
         Cfvbwq1RXT/58PdAxyxyQPsJJuQ0/2fLKYmkEpe1C94pEJlGptpAjNWa0pmYDJWbnl3e
         E0LXGvSjikRZj0wtA06InP0asFXK8KAzqX/b+UC6t29aQGLYVSzq3B+/6AUKXxRpD9R8
         RrwasQ+LnejjErgD1odYNLeoC2Y4/UGPFigRuqABGfVob/iQtxy3A4rM1nQcM4gm93oY
         SAgg==
X-Gm-Message-State: ANhLgQ1RTb5U7OULV+Mqn7YOkhNuope34mCHcFA9Ldla/UJWdwNGu+E4
        D25DxeAYRonE/nZbjcCcAG4DkQ==
X-Google-Smtp-Source: ADFU+vsNFvIN9+G70hap688bVJo6dmQDejdpJW3FaYIdBZVo1714EoetqS+XDMy7CdNflLVK6xzBWw==
X-Received: by 2002:a02:ce95:: with SMTP id y21mr5632116jaq.115.1583540077080;
        Fri, 06 Mar 2020 16:14:37 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm4629011ils.78.2020.03.06.16.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 16:14:36 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mike Gilbert <floppym@gentoo.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.6-rc6
Message-ID: <fcbb3dc4-38ae-8361-bd6b-a00ae00c189c@linuxfoundation.org>
Date:   Fri, 6 Mar 2020 17:14:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8783B7F020BFEFD5BCAAC3F8"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------8783B7F020BFEFD5BCAAC3F8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.6-rc6.

This cpupower update for Linux 5.6-rc6 consists of a fix from
Mike Gilbert for build failures when -fno-common is enabled.
-fno-common will be default in gcc v10.

Diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.6-rc6

for you to fetch changes up to 2de7fb60a4740135e03cf55c1982e393ccb87b6b:

   cpupower: avoid multiple definition with gcc -fno-common (2020-03-02 
08:53:34 -0700)

----------------------------------------------------------------
linux-cpupower-5.6-rc6

This cpupower update for Linux 5.6-rc6 consists of a fix from
Mike Gilbert for build failures when -fno-common is enabled.
-fno-common will be default in gcc v10.

----------------------------------------------------------------
Mike Gilbert (1):
       cpupower: avoid multiple definition with gcc -fno-common

  tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c  | 2 +-
  tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 2 +-
  tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
  tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h | 2 +-
  4 files changed, 5 insertions(+), 3 deletions(-)
----------------------------------------------------------------

--------------8783B7F020BFEFD5BCAAC3F8
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.6-rc6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.6-rc6.diff"

diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 33dc34db4f3c..20f46348271b 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -82,7 +82,7 @@ static struct pci_access *pci_acc;
 static struct pci_dev *amd_fam14h_pci_dev;
 static int nbp1_entered;
 
-struct timespec start_time;
+static struct timespec start_time;
 static unsigned long long timediff;
 
 #ifdef DEBUG
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 3c4cee160b0e..a65f7d011513 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -19,7 +19,7 @@ struct cpuidle_monitor cpuidle_sysfs_monitor;
 
 static unsigned long long **previous_count;
 static unsigned long long **current_count;
-struct timespec start_time;
+static struct timespec start_time;
 static unsigned long long timediff;
 
 static int cpuidle_get_count_percent(unsigned int id, double *percent,
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 6d44fec55ad5..7c77045fef52 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -27,6 +27,8 @@ struct cpuidle_monitor *all_monitors[] = {
 0
 };
 
+int cpu_count;
+
 static struct cpuidle_monitor *monitors[MONITORS_MAX];
 static unsigned int avail_monitors;
 
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index 5b5eb1da0cce..c559d3115330 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -25,7 +25,7 @@
 #endif
 #define CSTATE_DESC_LEN 60
 
-int cpu_count;
+extern int cpu_count;
 
 /* Hard to define the right names ...: */
 enum power_range_e {

--------------8783B7F020BFEFD5BCAAC3F8--
