Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4950B1DF2CD
	for <lists+linux-pm@lfdr.de>; Sat, 23 May 2020 01:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgEVXPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbgEVXPO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 19:15:14 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08BCC061A0E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 16:15:14 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id b18so9532664oti.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=OwOeBPry0dp2i7mErSJmNpJ5BuRUze6N/1MLL/C78zo=;
        b=Af5pmX5LhT/VqkIB6ZsoIOpT6tHP38n+BQwkma+9mtikuD38h3iScZa+8r3Ej3HgE+
         fblfTZGILrKCvF4b6/auao3ZqM8HDbrIyHxwRg/kh3akCShXyKxgJ8sIARoanX8S6Q2s
         +UDNkycf1N1YNAkAu4CnvpmjOJxSy5a/Jgbuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=OwOeBPry0dp2i7mErSJmNpJ5BuRUze6N/1MLL/C78zo=;
        b=nFt6DivhNknlAYqqxndO+kk0K2Qbrv/ndL9lfWUgmnDlr2VSfA+zp/NPv5+y9WxCaT
         Ciy+qxlzdDZvnQ4oqP8vMxQhun534mMHO3hukLfnJODsvARhF2/8hNXMjcfRwxwv1raO
         LHaT0URj4U1uLQkcpC/ntq0wchr4nMUZbfjW2MbfJrRWIm5rS/95W4rzaJg1Ac97WvLL
         WdvyyMcr+EAAztKO6Onc3Hn4S2NnTVCWg+pVEAIN65FUd10slJI17i+Bp4IkMylG4CYW
         BKOG12PFVyxr00emTTN5XqLLuRRLjR+zYxQyOkpf6f5vfKm7+pPhIXMTkojwAJdtCCiR
         xvnw==
X-Gm-Message-State: AOAM531fPX297xCZd07Mr0+qgdyJOrC2+UGdzv4lWxFAl+FIchlipflT
        BEIq2y22k5qvvAs+datAhuW+0Q==
X-Google-Smtp-Source: ABdhPJzoJ+rxUEGFFOIPSyKWN0LsfOOhcLykYcqPhGdsLA9Mb0DohczoXp52hav/3kCIY9tLIme1/Q==
X-Received: by 2002:a9d:66cd:: with SMTP id t13mr13345149otm.40.1590189314052;
        Fri, 22 May 2020 16:15:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s124sm3044562oig.19.2020.05.22.16.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 16:15:13 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.8-rc1
Message-ID: <7bf4d518-5772-9615-f925-8f9af4751d10@linuxfoundation.org>
Date:   Fri, 22 May 2020 17:15:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1FAC030DFED86EA474540D0C"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------1FAC030DFED86EA474540D0C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.8-rc1.

This cpupower update for Linux 5.8-rc1 consists of a single
patch to fix coccicheck unneeded semicolon warning.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

   Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.8-rc1

for you to fetch changes up to 7b0bf99b9ee497cc0f079472566aff716d033d43:

   cpupower: Remove unneeded semicolon (2020-05-08 10:13:26 -0600)

----------------------------------------------------------------
linux-cpupower-5.8-rc1

This cpupower update for Linux 5.8-rc1 consists of a single
patch to fix coccicheck unneeded semicolon warning.

----------------------------------------------------------------
Zou Wei (1):
       cpupower: Remove unneeded semicolon

  tools/power/cpupower/utils/cpupower-info.c                | 2 +-
  tools/power/cpupower/utils/cpupower-set.c                 | 2 +-
  tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c | 2 +-
  tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c   | 6 +++---
  tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c    | 2 +-
  tools/power/cpupower/utils/idle_monitor/nhm_idle.c        | 2 +-
  tools/power/cpupower/utils/idle_monitor/snb_idle.c        | 2 +-
  7 files changed, 9 insertions(+), 9 deletions(-)

----------------------------------------------------------------

--------------1FAC030DFED86EA474540D0C
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.8-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.8-rc1.diff"

diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index d3755ea70d4d..0ba61a2c4d81 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -62,7 +62,7 @@ int cmd_info(int argc, char **argv)
 		default:
 			print_wrong_arg_exit();
 		}
-	};
+	}
 
 	if (!params.params)
 		params.params = 0x7;
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 3cca6f715dd9..052044d7e012 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -72,7 +72,7 @@ int cmd_set(int argc, char **argv)
 		default:
 			print_wrong_arg_exit();
 		}
-	};
+	}
 
 	if (!params.params)
 		print_wrong_arg_exit();
diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
index 20f46348271b..5edd35bd9ee9 100644
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -117,7 +117,7 @@ static int amd_fam14h_get_pci_info(struct cstate *state,
 		break;
 	default:
 		return -1;
-	};
+	}
 	return 0;
 }
 
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index a65f7d011513..8b42c2f0a5b0 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -53,7 +53,7 @@ static int cpuidle_start(void)
 			dprint("CPU %d - State: %d - Val: %llu\n",
 			       cpu, state, previous_count[cpu][state]);
 		}
-	};
+	}
 	return 0;
 }
 
@@ -72,7 +72,7 @@ static int cpuidle_stop(void)
 			dprint("CPU %d - State: %d - Val: %llu\n",
 			       cpu, state, previous_count[cpu][state]);
 		}
-	};
+	}
 	return 0;
 }
 
@@ -172,7 +172,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
 		cpuidle_cstates[num].id = num;
 		cpuidle_cstates[num].get_count_percent =
 			cpuidle_get_count_percent;
-	};
+	}
 
 	/* Free this at program termination */
 	previous_count = malloc(sizeof(long long *) * cpu_count);
diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index 97ad3233a521..55e55b6b42f9 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -79,7 +79,7 @@ static int hsw_ext_get_count(enum intel_hsw_ext_id id, unsigned long long *val,
 		break;
 	default:
 		return -1;
-	};
+	}
 	if (read_msr(cpu, msr, val))
 		return -1;
 	return 0;
diff --git a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
index 114271165182..16eaf006f61f 100644
--- a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
@@ -91,7 +91,7 @@ static int nhm_get_count(enum intel_nhm_id id, unsigned long long *val,
 		break;
 	default:
 		return -1;
-	};
+	}
 	if (read_msr(cpu, msr, val))
 		return -1;
 
diff --git a/tools/power/cpupower/utils/idle_monitor/snb_idle.c b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
index df8b223cc096..811d63ab17a7 100644
--- a/tools/power/cpupower/utils/idle_monitor/snb_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
@@ -77,7 +77,7 @@ static int snb_get_count(enum intel_snb_id id, unsigned long long *val,
 		break;
 	default:
 		return -1;
-	};
+	}
 	if (read_msr(cpu, msr, val))
 		return -1;
 	return 0;

--------------1FAC030DFED86EA474540D0C--
