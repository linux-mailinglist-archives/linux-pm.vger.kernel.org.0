Return-Path: <linux-pm+bounces-25802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECDA95052
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 13:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A720189392B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD042641F6;
	Mon, 21 Apr 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="le9XKH/I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCE2641F1
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235479; cv=none; b=mBGdMN905uGtCK6uawc5i+bRrrKt9PLwB377xcl1AeMK2GqEuN9rTHn47B6lqlbKX+O8yecR5ka5+q8GUNTvte4Uz7gbmUKJBvOZxrXi7yuuIqtAabb1HLkVXjmUTKj76NhbWhsjEgGHMk/uzi/v007BA1+RWLmXZbX3sm483Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235479; c=relaxed/simple;
	bh=s3frcA3z8CU9QoLViSopNt7NDFbwWp2nvh7sL5twsvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjXAAIsYTPK0E+k+IdFh/FQpMbjJ1aJsWrceI/cruaNVh1mgEauj2MCjwbdu4Oeg0lvfa47ddpETNsWrTId4pQc6OGJYZgTJKGdMcUTd4pjeAm3lcZ8TeXNzuCFIlgud/3W+JuwCZfb9PTCz2nrhvN2g3DYY9mYjfpj9LMsc6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=le9XKH/I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736bfa487c3so3343663b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745235476; x=1745840276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43VGHzqPuUUky7P+XVbisg9LKWNE+KONN6bM0cOxWLk=;
        b=le9XKH/ILqSYCgvMidOJkI6uWNAkkDOMLfrea0mxcj03KL9zwTENCDWmooAEef0h7w
         AjFq0LYPC5cOxUQCgBSC/NDP32a9lAkhYzEgplSqqFIJI4TBqtuabho+oFy6WC/5E2Kq
         eraqHSiV+cAMUBBfk11elXRot8gYfZo0M6sTdnndlises0tRN8HqhLIxFVWsOaV1R9Lh
         qRnltynHsz0CucirKB8mN/NRmkY27EicNsYlf7GAyZFr6wX5tfOjhjEQ7SsbEUa0c4Rb
         PoIij4gIt3Te6N8/wCigLLdiECF4i0BxaTBmPKzKlP7JYUvYRyf7s/1RMbCANb5Mj9Ha
         kj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745235476; x=1745840276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43VGHzqPuUUky7P+XVbisg9LKWNE+KONN6bM0cOxWLk=;
        b=s+QS/mY4fn7NoZaP0hEOs6iMzU+/tceQEf8ALp7GBovMCy+4AD/ayR9aoC2m6fF7eO
         idoUv7VVQg2EAAwdBc6jMJIQT3v0sNVWzmJKMbxx2gHcYfdPRUFnyUAa7xLinZ3lPV61
         vARg0Y+k9zvJetihkEWQpn12FS1DfT8UrZ9t+aY6tTaclltnlUGTu0fZ2ytd8NfHQYyz
         GDofTyZxq1MTb/AFEbn65w4Ysf9obzG3x636h1OpTXM0pnIK2z1tbGnCD3K5Ac/0RylZ
         5zURygub08auPk5ptbTnxmjaPGrJjogk0AXrZz1xSDWy1N9LJpbQEwA1uSMhXcVz1gPW
         hK1w==
X-Forwarded-Encrypted: i=1; AJvYcCUO5BEgsjXsEdHVIXylfyfQqit267tIOZfUf6DWLpYYNHoJItAstE3QBqAy0sU4i1UIZeyOZB61vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDx6d23cFKRECeTvv0OyGcCllTH28f87M+MgxVeq9hlKCp59vb
	N78ulROZF6fwZjM25t+DwjJsG4mStdmEuTnqVcqwVDMp7lmtTJ7UJGcMQMuWhfo=
X-Gm-Gg: ASbGncuNXGbGu71dmX7fikSqTvZ2zlYxKI320nrA4pp8eIdYCCTxBAG+p3JOdfYFbRm
	mNW1uimcE/caXwPBqZhtVhFwCb3qbWbVU/r8HLUCXDTr4lVSSDukri88WBEstcmcNUXma1T7bce
	aujtLdmqaF+3lZe8f1+2c2JpHEMovAF+F6srA4KvVqPtuixTvBO/n3/f6/F1qP93J/KjTOTjhYh
	I70VC4OFaavStRH8WTEgMr7QU0pl8xlusG7rbl9rBpTuxO2LXfiHxo0nJedR4kKYMFK1tgBi58F
	u/wX8UkqE9K2O6S5uBhJiuG4VHj3eXSPMyhOGMHUJw==
X-Google-Smtp-Source: AGHT+IFaOdeoa+0VB3w8t8nak86cJD6PiC30jYw32fp5hlcubY8z8edZqqzW2n5AsXdt/BtdeOUuzg==
X-Received: by 2002:a17:90b:5486:b0:301:c5cb:7b13 with SMTP id 98e67ed59e1d1-3087bb3beadmr14241658a91.3.1745235476099;
        Mon, 21 Apr 2025 04:37:56 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df1e9adsm6370181a91.27.2025.04.21.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:37:55 -0700 (PDT)
Date: Mon, 21 Apr 2025 17:07:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250421113753.lwukxhi45bnmqbpq@vireshk-i7>
References: <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
 <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>

Coming back to this response again:

On 19-04-25, 17:35, zhenglifeng (A) wrote:
> Yes, the policy boost will be forcibly set to mirror the global boost. This
> indicates that the global boost value is the default value of policy boost
> each time the CPU goes online. Otherwise, we'll meet things like:
> 
> 1. The global boost is set to disabled after a CPU going offline but the
> policy boost is still be enabled after the CPU going online again.

This is surely a valid case, we must not enable policy boost when
global boost is disabled.

> 2. The global boost is set to enabled after a CPU going offline and the
> rest of the online CPUs are all boost enabled. However, the offline CPU
> remains in the boost disabled state after it going online again. Users
> have to set its boost state separately.

I now this this is the right behavior. The policy wasn't present when
the global boost was enabled and so the action doesn't necessarily
apply to it.

This is how I think this should be fixed, we may still need to fix
acpi driver's bug separately though:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3841c9da6cac..7ac8b4c28658 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -620,6 +620,20 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
        return sysfs_emit(buf, "%d\n", policy->boost_enabled);
 }

+static int policy_set_boost(struct cpufreq_policy *policy, bool enable, bool forced)
+{
+       if (!forced && (policy->boost_enabled == enable))
+               return 0;
+
+       policy->boost_enabled = enable;
+
+       ret = cpufreq_driver->set_boost(policy, enable);
+       if (ret)
+               policy->boost_enabled = !policy->boost_enabled;
+
+       return ret;
+}
+
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
                                 const char *buf, size_t count)
 {
@@ -635,21 +649,14 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
        if (!policy->boost_supported)
                return -EINVAL;

-       if (policy->boost_enabled == enable)
-               return count;
-
-       policy->boost_enabled = enable;
-
        cpus_read_lock();
-       ret = cpufreq_driver->set_boost(policy, enable);
+       ret = policy_set_boost(policy, enable, false);
        cpus_read_unlock();

-       if (ret) {
-               policy->boost_enabled = !policy->boost_enabled;
-               return ret;
-       }
+       if (!ret)
+               return count;

-       return count;
+       return ret;
 }

 static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
@@ -1617,16 +1624,17 @@ static int cpufreq_online(unsigned int cpu)
        if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
                policy->cdev = of_cpufreq_cooling_register(policy);

-       /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+       /*
+        * Let the per-policy boost flag mirror the cpufreq_driver boost during
+        * initialization for a new policy. For an existing policy, maintain the
+        * previous boost value unless global boost is disabled now.
+        */
        if (cpufreq_driver->set_boost && policy->boost_supported &&
-           policy->boost_enabled != cpufreq_boost_enabled()) {
-               policy->boost_enabled = cpufreq_boost_enabled();
-               ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
+           (new_policy || !cpufreq_boost_enabled())) {
+               ret = policy_set_boost(policy, cpufreq_boost_enabled(), false);
                if (ret) {
-                       /* If the set_boost fails, the online operation is not affected */
-                       pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
-                               str_enable_disable(policy->boost_enabled));
-                       policy->boost_enabled = !policy->boost_enabled;
+                       pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__,
+                               policy->cpu, str_enable_disable(cpufreq_boost_enabled()));
                }
        }

@@ -2864,12 +2872,9 @@ static int cpufreq_boost_trigger_state(int state)
                if (!policy->boost_supported)
                        continue;

-               policy->boost_enabled = state;
-               ret = cpufreq_driver->set_boost(policy, state);
-               if (ret) {
-                       policy->boost_enabled = !policy->boost_enabled;
+               ret = policy_set_boost(policy, state, true);
+               if (ret)
                        goto err_reset_state;
-               }
        }
        cpus_read_unlock();

-- 
viresh

