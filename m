Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046801BB9F3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 11:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD1JhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 05:37:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgD1JhL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 05:37:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BE3D3B50836C88B459B;
        Tue, 28 Apr 2020 17:37:08 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 17:36:59 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] cpupower: Remove unneeded semicolon
Date:   Tue, 28 Apr 2020 17:43:15 +0800
Message-ID: <1588066995-71840-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes coccicheck warnings:

tools/power/cpupower/utils/cpupower-info.c:65:2-3: Unneeded semicolon
tools/power/cpupower/utils/cpupower-set.c:75:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:120:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:175:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:56:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:75:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c:82:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/nhm_idle.c:94:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/snb_idle.c:80:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/power/cpupower/utils/cpupower-info.c                | 2 +-
 tools/power/cpupower/utils/cpupower-set.c                 | 2 +-
 tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c   | 6 +++---
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c    | 2 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c        | 2 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index d3755ea..0ba61a2 100644
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
index 3cca6f7..052044d 100644
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
index 20f4634..5edd35b 100644
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
index a65f7d0..8b42c2f 100644
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
index 97ad323..55e55b6 100644
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
index 1142711..16eaf00 100644
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
index df8b223..811d63a 100644
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
-- 
2.6.2

