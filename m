Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC5209B84
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390746AbgFYIu4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390453AbgFYIuz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 04:50:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0AC0613ED
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 01:50:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so2909287pjs.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JEMoZdpFmrFhFcFBcdt9FFDGd+0A8OhsnWsQtV3mDFY=;
        b=zwcL9Y65FiPLi2vjuyj40QyTUjgv3aeO4hIU2vSpY+ujIZWGaNlfkCfdnIbFsNxo0H
         s2bxZH7BVoYdiRgMEO/Vg6ESWbMhb3nv/KAEMF1vtI/9xGSuo+SXo03llv+PmHWmUC8n
         2Fuh04JomaNSCobeuTTpqT4sCG7KY1xn0mKHLmWhjxI/XPEc/dehP6bUzCl0o7UY9Xxk
         gP27jOnkzXmkF6VH+uuxfwPM1NkKvSVA28LRw3MgNoRtiU2Pfr7WPki43eagX+zgnSVT
         PqOmYzAJqDo2V2tahpUFRzZbvkj5DnYF48KOvH3PCv7nYdSDRdi4B74G+fWo74pp9cMm
         mZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEMoZdpFmrFhFcFBcdt9FFDGd+0A8OhsnWsQtV3mDFY=;
        b=oSFeU/5oI+Hvs23OgPYO4WXxBQsM2r4wQuXE/d6EfC8nkwgFtF/L4Lqj615JO1caqV
         xtw5WttJf2tMleqftxsvErcp7DbdY7w3E02IlZJ/YLwSeW0f8dt+dbqKcIrPdXt9CVt+
         bG4dmJI/A2ZEdEm/k28oq98hoHXjLNb4NBicHscxps6hf+e+HCY8/sqwe/iXBv+qtM0a
         zuZI9t+6cVrIX39a7Sz3FZH+l6H/nT/zxFAQ7B1aO1J6Ehxtf/IQ8S3FNS6cKbyuRMk4
         Sq+kI4F/eg3vNPeR8iOtfXK0Aq5a4AtJhBdXxrs2vxo6GniJf0hlkezDh6H59TFs1bmI
         dhzg==
X-Gm-Message-State: AOAM531wYLD0LWhXaHo0dS1JWlR2lIR8+j/T9Pe7IDbV5LoHjgHGpWMw
        6+ywkX1N5+MiFMgIvr8fToMJ7w==
X-Google-Smtp-Source: ABdhPJzHllegdQIG8KbY6WzYzQnZ64LxOSyUGGS4GTbuRzkA6CihktIRU3UyCCXiZkNESNztdGrrfg==
X-Received: by 2002:a17:90a:74cb:: with SMTP id p11mr2162481pjl.89.1593075055236;
        Thu, 25 Jun 2020 01:50:55 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id s9sm19347192pgo.22.2020.06.25.01.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 01:50:54 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:20:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, adharmap@codeaurora.org
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200625085052.4ah4wbog3guj74v4@vireshk-i7>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200624055023.xofefhohf7wifme5@vireshk-i7>
 <CAJZ5v0ja_rM7i=psW1HRyzEpW=8QwP2u9p+ihN3FS8_53bbxTQ@mail.gmail.com>
 <20200624153259.GA2844@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624153259.GA2844@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-20, 16:32, Quentin Perret wrote:
> Right, but I must admit that, looking at this more, I'm getting a bit
> confused with the overall locking for governors :/
> 
> When in cpufreq_init_policy() we find a governor using
> find_governor(policy->last_governor), what guarantees this governor is
> not concurrently unregistered? That is, what guarantees this governor
> doesn't go away between that find_governor() call, and the subsequent
> call to try_module_get() in cpufreq_set_policy() down the line?
> 
> Can we somewhat assume that whatever governor is referred to by
> policy->last_governor will have a non-null refcount? Or are the
> cpufreq_online() and cpufreq_unregister_governor() path mutually
> exclusive? Or is there something else?

This should be sufficient to fix pending issues I believe. Based over your
patches.

-- 
viresh

-------------------------8<-------------------------
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 25 Jun 2020 13:15:23 +0530
Subject: [PATCH] cpufreq: Fix locking issues with governors

The locking around governors handling isn't adequate currently. The list
of governors should never be traversed without locking in place. Also we
must make sure the governor isn't removed while it is still referenced
by code.

Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 59 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4b1a5c0173cf..dad6b85f4c89 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -624,6 +624,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 	return NULL;
 }
 
+static struct cpufreq_governor *get_governor(const char *str_governor)
+{
+	struct cpufreq_governor *t;
+
+	mutex_lock(&cpufreq_governor_mutex);
+	t = find_governor(str_governor);
+	if (!t)
+		goto unlock;
+
+	if (!try_module_get(t->owner))
+		t = NULL;
+
+unlock:
+	mutex_unlock(&cpufreq_governor_mutex);
+
+	return t;
+}
+
 static unsigned int cpufreq_parse_policy(char *str_governor)
 {
 	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
@@ -643,28 +661,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
 {
 	struct cpufreq_governor *t;
 
-	mutex_lock(&cpufreq_governor_mutex);
-
-	t = find_governor(str_governor);
-	if (!t) {
-		int ret;
-
-		mutex_unlock(&cpufreq_governor_mutex);
-
-		ret = request_module("cpufreq_%s", str_governor);
-		if (ret)
-			return NULL;
-
-		mutex_lock(&cpufreq_governor_mutex);
+	t = get_governor(str_governor);
+	if (t)
+		return t;
 
-		t = find_governor(str_governor);
-	}
-	if (t && !try_module_get(t->owner))
-		t = NULL;
-
-	mutex_unlock(&cpufreq_governor_mutex);
+	if (request_module("cpufreq_%s", str_governor))
+		return NULL;
 
-	return t;
+	return get_governor(str_governor);
 }
 
 /**
@@ -818,12 +822,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 		goto out;
 	}
 
+	mutex_lock(&cpufreq_governor_mutex);
 	for_each_governor(t) {
 		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
 		    - (CPUFREQ_NAME_LEN + 2)))
-			goto out;
+			break;
 		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
 	}
+	mutex_unlock(&cpufreq_governor_mutex);
 out:
 	i += sprintf(&buf[i], "\n");
 	return i;
@@ -1060,11 +1066,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
 	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
+	bool put_governor = false;
+	int ret;
 
 	if (has_target()) {
 		/* Update policy governor to the one used before hotplug. */
-		gov = find_governor(policy->last_governor);
+		gov = get_governor(policy->last_governor);
 		if (gov) {
+			put_governor = true;
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 policy->governor->name, policy->cpu);
 		} else if (default_governor) {
@@ -1091,7 +1100,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 			return -ENODATA;
 	}
 
-	return cpufreq_set_policy(policy, gov, pol);
+	ret = cpufreq_set_policy(policy, gov, pol);
+	if (put_governor)
+		module_put(gov->owner);
+
+	return ret;
 }
 
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
