Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A155220719
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgGOI0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgGOI0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBDDC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so1527586wrs.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihjHslCIw8qoMVK4GXrRB+3Lj/xZDniOVXUYfLOZNm8=;
        b=oy8I177G6dJEDpBrdxhbNXr6eWAuiaucCN6BvpWmTV5GJxmYxNYnN1lFkHFXt8M7oJ
         R6ooMcsuYbuh02++yZ3V1ni9aBPhi6hpoSKyNhGDRWo43fdxVCsgOoZffKPobP3zkTiv
         k1X64hU5n+M4+g/wkseLyImHKdQSD8Z7ZBfTlmvaEPUafxpQW4DWnIjgpTLrNIN91DCC
         ZwfFLnc41wUqXeat4AEy47ZQi+r5c1s1Au00TOolQbNhWPB64J/oC4wYg+3FLbODPSIt
         p+D3lrRh9pLo17RdsiHs72QqQDn9fD3W3v0kzW7WPerA5H4IZ4650ZhJvO/Sm5tklwvq
         Aw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihjHslCIw8qoMVK4GXrRB+3Lj/xZDniOVXUYfLOZNm8=;
        b=nBY6BqbGmFeqSrSTFRyR9faOpRSEnfSq94zNhq9cm9ig3b3dNV+Uch1PGbpSIk26Tl
         7DTehkCLzavJKZtNyJdcgjTBJCrFwwNnx+JJtS1xqmkGqIce2GVUnla4oXg63cqvdQpO
         2SLRdwasjN9dys/d43vAmmEwIe5pOyccpHzmtgTuDoDSpQro9AoXCRCT9HAndubDgIC7
         T0mgVu4AyxYwsFsT5TwfbRQBnQPQauTWX7ydnjw8dJh6E5yluJImxzp6GK7i6imwDuxu
         +Ir6Tckvytcam8HjSrbW6OTaYO/KZxSvJESG43q8NbtTcwVGL2CPLm+Xgtrjfm4NDRQd
         Bozw==
X-Gm-Message-State: AOAM530GiQbIdHCp1EExDN6e4XSBJUkLNypP0+pksU5oqh0lfZM3E2wX
        070B7RaAE0ozl6On7tcYyn/ntg==
X-Google-Smtp-Source: ABdhPJwrIr6A0DAwJDikfm63DJ+83JVkApYPpXTo2osG/PQ/mYSYmt5yVyxC0lkykW5emZGajYIhZA==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr10062532wrw.197.1594801600826;
        Wed, 15 Jul 2020 01:26:40 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dominik Brodowski <linux@brodo.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Shin <jacob.shin@amd.com>
Subject: [PATCH v2 02/13] cpufreq: cpufreq: Demote lots of function headers unworthy of kerneldoc status
Date:   Wed, 15 Jul 2020 09:26:23 +0100
Message-Id: <20200715082634.3024816-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Also provide missing function parameter description for 'cpu' and 'policy'.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/cpufreq.c:60: warning: cannot understand function prototype: 'struct cpufreq_driver *cpufreq_driver; '
 drivers/cpufreq/cpufreq.c:90: warning: Function parameter or member 'cpufreq_policy_notifier_list' not described in 'BLOCKING_NOTIFIER_HEAD'
 drivers/cpufreq/cpufreq.c:312: warning: Function parameter or member 'val' not described in 'adjust_jiffies'
 drivers/cpufreq/cpufreq.c:312: warning: Function parameter or member 'ci' not described in 'adjust_jiffies'
 drivers/cpufreq/cpufreq.c:538: warning: Function parameter or member 'policy' not described in 'cpufreq_driver_resolve_freq'
 drivers/cpufreq/cpufreq.c:686: warning: Function parameter or member 'file_name' not described in 'show_one'
 drivers/cpufreq/cpufreq.c:686: warning: Function parameter or member 'object' not described in 'show_one'
 drivers/cpufreq/cpufreq.c:731: warning: Function parameter or member 'file_name' not described in 'store_one'
 drivers/cpufreq/cpufreq.c:731: warning: Function parameter or member 'object' not described in 'store_one'
 drivers/cpufreq/cpufreq.c:741: warning: Function parameter or member 'policy' not described in 'show_cpuinfo_cur_freq'
 drivers/cpufreq/cpufreq.c:741: warning: Function parameter or member 'buf' not described in 'show_cpuinfo_cur_freq'
 drivers/cpufreq/cpufreq.c:754: warning: Function parameter or member 'policy' not described in 'show_scaling_governor'
 drivers/cpufreq/cpufreq.c:754: warning: Function parameter or member 'buf' not described in 'show_scaling_governor'
 drivers/cpufreq/cpufreq.c:770: warning: Function parameter or member 'policy' not described in 'store_scaling_governor'
 drivers/cpufreq/cpufreq.c:770: warning: Function parameter or member 'buf' not described in 'store_scaling_governor'
 drivers/cpufreq/cpufreq.c:770: warning: Function parameter or member 'count' not described in 'store_scaling_governor'
 drivers/cpufreq/cpufreq.c:806: warning: Function parameter or member 'policy' not described in 'show_scaling_driver'
 drivers/cpufreq/cpufreq.c:806: warning: Function parameter or member 'buf' not described in 'show_scaling_driver'
 drivers/cpufreq/cpufreq.c:815: warning: Function parameter or member 'policy' not described in 'show_scaling_available_governors'
 drivers/cpufreq/cpufreq.c:815: warning: Function parameter or member 'buf' not described in 'show_scaling_available_governors'
 drivers/cpufreq/cpufreq.c:859: warning: Function parameter or member 'policy' not described in 'show_related_cpus'
 drivers/cpufreq/cpufreq.c:859: warning: Function parameter or member 'buf' not described in 'show_related_cpus'
 drivers/cpufreq/cpufreq.c:867: warning: Function parameter or member 'policy' not described in 'show_affected_cpus'
 drivers/cpufreq/cpufreq.c:867: warning: Function parameter or member 'buf' not described in 'show_affected_cpus'
 drivers/cpufreq/cpufreq.c:901: warning: Function parameter or member 'policy' not described in 'show_bios_limit'
 drivers/cpufreq/cpufreq.c:901: warning: Function parameter or member 'buf' not described in 'show_bios_limit'
 drivers/cpufreq/cpufreq.c:1625: warning: Function parameter or member 'dev' not described in 'cpufreq_remove_dev'
 drivers/cpufreq/cpufreq.c:1625: warning: Function parameter or member 'sif' not described in 'cpufreq_remove_dev'
 drivers/cpufreq/cpufreq.c:2380: warning: Function parameter or member 'cpu' not described in 'cpufreq_get_policy'
 drivers/cpufreq/cpufreq.c:2771: warning: Function parameter or member 'driver' not described in 'cpufreq_unregister_driver'

Cc: Dominik Brodowski <linux@brodo.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Shin <jacob.shin@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 036f4cc42ede2..17c1c3becd925 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -52,7 +52,7 @@ static LIST_HEAD(cpufreq_governor_list);
 
 static char default_governor[CPUFREQ_NAME_LEN];
 
-/**
+/*
  * The "cpufreq driver" - the arch- or hardware-dependent low
  * level driver of CPUFreq support, and its spinlock. This lock
  * also protects the cpufreq_cpu_data array.
@@ -80,7 +80,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol);
 
-/**
+/*
  * Two notifier lists: the "policy" list is involved in the
  * validation process for a new CPU frequency policy; the
  * "transition" list for kernel code that needs to handle
@@ -300,7 +300,7 @@ struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
 
-/**
+/*
  * adjust_jiffies - adjust the system "loops_per_jiffy"
  *
  * This function alters the system "loops_per_jiffy" for the clock
@@ -526,6 +526,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 /**
  * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
  * one.
+ * @policy: associated policy to interrogate
  * @target_freq: target frequency to resolve.
  *
  * The target to driver frequency mapping is cached in the policy.
@@ -670,7 +671,7 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
 	return get_governor(str_governor);
 }
 
-/**
+/*
  * cpufreq_per_cpu_attr_read() / show_##file_name() -
  * print out cpufreq information
  *
@@ -712,7 +713,7 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	return ret;
 }
 
-/**
+/*
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
  */
 #define store_one(file_name, object)			\
@@ -733,7 +734,7 @@ static ssize_t store_##file_name					\
 store_one(scaling_min_freq, min);
 store_one(scaling_max_freq, max);
 
-/**
+/*
  * show_cpuinfo_cur_freq - current CPU frequency as detected by hardware
  */
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
@@ -747,7 +748,7 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 	return sprintf(buf, "<unknown>\n");
 }
 
-/**
+/*
  * show_scaling_governor - show the current policy for the specified CPU
  */
 static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
@@ -762,7 +763,7 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 	return -EINVAL;
 }
 
-/**
+/*
  * store_scaling_governor - store policy for the specified CPU
  */
 static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
@@ -799,7 +800,7 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 	return ret ? ret : count;
 }
 
-/**
+/*
  * show_scaling_driver - show the cpufreq driver currently loaded
  */
 static ssize_t show_scaling_driver(struct cpufreq_policy *policy, char *buf)
@@ -807,7 +808,7 @@ static ssize_t show_scaling_driver(struct cpufreq_policy *policy, char *buf)
 	return scnprintf(buf, CPUFREQ_NAME_PLEN, "%s\n", cpufreq_driver->name);
 }
 
-/**
+/*
  * show_scaling_available_governors - show the available CPUfreq governors
  */
 static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
@@ -851,7 +852,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 }
 EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
 
-/**
+/*
  * show_related_cpus - show the CPUs affected by each transition even if
  * hw coordination is in use
  */
@@ -860,7 +861,7 @@ static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
 	return cpufreq_show_cpus(policy->related_cpus, buf);
 }
 
-/**
+/*
  * show_affected_cpus - show the CPUs affected by each transition
  */
 static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
@@ -894,7 +895,7 @@ static ssize_t show_scaling_setspeed(struct cpufreq_policy *policy, char *buf)
 	return policy->governor->show_setspeed(policy, buf);
 }
 
-/**
+/*
  * show_bios_limit - show the current cpufreq HW/BIOS limitation
  */
 static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
@@ -1616,7 +1617,7 @@ static int cpufreq_offline(unsigned int cpu)
 	return 0;
 }
 
-/**
+/*
  * cpufreq_remove_dev - remove a CPU device
  *
  * Removes the cpufreq interface for a CPU device.
@@ -2373,6 +2374,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
  * cpufreq_get_policy - get the current cpufreq_policy
  * @policy: struct cpufreq_policy into which the current cpufreq_policy
  *	is written
+ * @cpu: CPU to find the policy for
  *
  * Reads the current cpufreq policy.
  */
@@ -2759,7 +2761,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
 
-/**
+/*
  * cpufreq_unregister_driver - unregister the current CPUFreq driver
  *
  * Unregister the current CPUFreq driver. Only call this if you have
-- 
2.25.1

