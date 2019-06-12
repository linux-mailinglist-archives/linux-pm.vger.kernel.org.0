Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46B4430FA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfFLU1G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 16:27:06 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:33515 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387844AbfFLU1G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 16:27:06 -0400
Received: by mail-io1-f50.google.com with SMTP id u13so14129772iop.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2019 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=n01BMcs7fBxk+Su0IaHbrT19JaQ+6dWso0UN0D7p0L8=;
        b=Lvgxfgrce6L8U858gDsUewPeiuZ+4j5QPRyin0guF5MFBp3T2S+UOXod7OOaIQptoL
         0LKTT1Umw80y7bPLj7H3KyU8ISMb1+QAkHR9nm/pEYdmvYAALzD0MAtx2o6SSvaoy7dW
         kM3jzBFy7YCQsATpSGFHx9LUaIdxDC81OdeKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=n01BMcs7fBxk+Su0IaHbrT19JaQ+6dWso0UN0D7p0L8=;
        b=RyDIgr4Ln/1dMMF2Vxvr3PK0aIgJeSnDfaQ/9PGLLfHkDYWS17RlilAKizbM6vV6AZ
         Hx7bI2wwm/F6hHjnCgkA02nvaQTSfgJymbsDND0pxTZOUcVD9hyOFMhSKqrb4kjQBxvU
         +pVw7CewhaX34mgwYfevNmINZyJBEy4uJo6Pdj9wxCsEsmgGp48SwPzPkdirnKuTjtFL
         UxX+ysL+LpF1vc+cXRZvUFAMpObduL6bMdwka4QgaDCxaJMDeXBHPhea7L9loWKP62fL
         3t5BxRejsFtqWo7q/COg60iS3iBfw1cMWD2p0TRUYxTwJO16DFQJDsD0qXFeQ9BRXsqQ
         WeEA==
X-Gm-Message-State: APjAAAUW4u9QxnxfbCDMxwTQ7gtBhiesRVcuJnMUe+Zbw2ZpD+lFSUxj
        fQmJ/4jgb9iei40/Ql74YnN0mQ==
X-Google-Smtp-Source: APXvYqyty9FFYerV5/56wDhSV6er5CSIOrKYh1N5f8wp3wX/W7O7t9rWjPxfLbqkiV7U+XUOXa0gmw==
X-Received: by 2002:a6b:e60b:: with SMTP id g11mr53543825ioh.9.1560371225622;
        Wed, 12 Jun 2019 13:27:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a130sm413349itb.14.2019.06.12.13.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:27:04 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.2-rc6
Message-ID: <376ea5d7-110a-71fe-7b02-efe1b0aed88e@linuxfoundation.org>
Date:   Wed, 12 Jun 2019 14:27:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DA1BC82BAC95C219E9AB2661"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------DA1BC82BAC95C219E9AB2661
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following update for Linux 5.2-rc6 or 5.3 depending on
your pull request schedule for Linus.

This cpupower update for Linux 5.2-rc6 consists of a fix and a minor
spelling correction.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

   Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.2-rc6

for you to fetch changes up to 04507c0a9385cc8280f794a36bfff567c8cc1042:

   cpupower : frequency-set -r option misses the last cpu in related cpu 
list (2019-06-04 09:06:50 -0600)

----------------------------------------------------------------
linux-cpupower-5.2-rc6

This cpupower update for Linux 5.2-rc6 consists of a fix and a minor
spelling correction.

----------------------------------------------------------------
Abhishek Goel (1):
       cpupower : frequency-set -r option misses the last cpu in related 
cpu list

Nick Black (1):
       cpupower: correct spelling of interval

  tools/power/cpupower/man/cpupower-monitor.1 | 2 +-
  tools/power/cpupower/po/cs.po               | 2 +-
  tools/power/cpupower/po/de.po               | 2 +-
  tools/power/cpupower/po/fr.po               | 2 +-
  tools/power/cpupower/po/it.po               | 2 +-
  tools/power/cpupower/po/pt.po               | 2 +-
  tools/power/cpupower/utils/cpufreq-set.c    | 2 ++
  7 files changed, 8 insertions(+), 6 deletions(-)

----------------------------------------------------------------

--------------DA1BC82BAC95C219E9AB2661
Content-Type: text/x-patch;
 name="linux-cpupower-5.2-rc6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.2-rc6.diff"

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 914cbb9d9cd0..70a56476f4b0 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -61,7 +61,7 @@ Only display specific monitors. Use the monitor string(s) provided by \-l option
 .PP
 \-i seconds
 .RS 4
-Measure intervall.
+Measure interval.
 .RE
 .PP
 \-c
diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index cb22c45c5069..bfc7e1702ec9 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -98,7 +98,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/de.po b/tools/power/cpupower/po/de.po
index 840c17cc450a..70887bb8ba95 100644
--- a/tools/power/cpupower/po/de.po
+++ b/tools/power/cpupower/po/de.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/fr.po b/tools/power/cpupower/po/fr.po
index b46ca2548f86..b6e505b34e4a 100644
--- a/tools/power/cpupower/po/fr.po
+++ b/tools/power/cpupower/po/fr.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/it.po b/tools/power/cpupower/po/it.po
index f80c4ddb9bda..a1deeb52c9e0 100644
--- a/tools/power/cpupower/po/it.po
+++ b/tools/power/cpupower/po/it.po
@@ -95,7 +95,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/po/pt.po b/tools/power/cpupower/po/pt.po
index 990f5267ffe8..902186585bb9 100644
--- a/tools/power/cpupower/po/pt.po
+++ b/tools/power/cpupower/po/pt.po
@@ -93,7 +93,7 @@ msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:74
 #, c-format
-msgid "\t -i: time intervall to measure for in seconds (default 1)\n"
+msgid "\t -i: time interval to measure for in seconds (default 1)\n"
 msgstr ""
 
 #: utils/idle_monitor/cpupower-monitor.c:75
diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index f49bc4aa2a08..6ed82fba5aaa 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -305,6 +305,8 @@ int cmd_freq_set(int argc, char **argv)
 				bitmask_setbit(cpus_chosen, cpus->cpu);
 				cpus = cpus->next;
 			}
+			/* Set the last cpu in related cpus list */
+			bitmask_setbit(cpus_chosen, cpus->cpu);
 			cpufreq_put_related_cpus(cpus);
 		}
 	}

--------------DA1BC82BAC95C219E9AB2661--
