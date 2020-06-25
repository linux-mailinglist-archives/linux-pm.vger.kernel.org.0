Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94628209D53
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 13:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404131AbgFYLO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404069AbgFYLO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 07:14:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BA1C061573
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 04:14:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so5137568wme.5
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/lDDVQxBaGyt+9YnrsQ1wKsoAv0GGQeOtACQNKqcjA=;
        b=k36VGpGdF5OlhC+8f1yEnrrYH8Ad3A5QPOITnITknSyJCbzwoGN78Phj6ZxCGzPxxP
         kfqk0XRGUZAuVYSSfevip8RpnneAjP5HY01vLdRN5mv4/0MIGvIsFV3roI86k/FdQd1Z
         uUJGRXZtkTjCxdIJ2qRbkCYpAm0K65IdTCXNicemA5LBSda8pFhWChhQzbzA5n4TlUX9
         4kfmO3h6SmX/YkuH7DPpSGNQgLCdbhpjbA+54w5Y/6tVi7qbP1E9IVRjb5cBuvRJ4f53
         OIwi1yoa8kGusFkZ9fR7tPZ00ZUEZVhYc6PMH0UqC/xrkyll6mHxz6S5UiYMgpk1f14c
         csvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/lDDVQxBaGyt+9YnrsQ1wKsoAv0GGQeOtACQNKqcjA=;
        b=VqL0tJiOodVW5Wh4t1Ey++hh7km8C36DmO0fenfZkGZG2p5EBlUvje2GZm9EMzmX/n
         CDPJSYJ0A8iACJkq61nvHbWkas2g0WrSy/CGBZIHryQL6BZPjo1+cLin00G0NAWBAF2R
         eSs0VUazW69gnJwURsg5gUTOPoj864UT+YJO4CN5WQAZcNLvS9ql+55ZZIkc22/EhbuJ
         WXlOLLoGmFWPYEM5NCddrlUVuxffkSGg0C/U5KZOumkQLFRKVnNDwkNhwG4coaS+YHQK
         xK569+ixkasdRcUDiEZdSnETGzpxD3KngrVxx5e/oOhvZQqe6HurnlVuSVzvWTw10AKt
         8umQ==
X-Gm-Message-State: AOAM531uPFeT5uxzE4+Rk/4ZgLn4M5GUaDavYFkIrTalG9ddB7tXjBjH
        RnhBHlO1bNBrnba7SbEvovCWXg==
X-Google-Smtp-Source: ABdhPJxgdPBbbMLdq/cmKASgPLLX/kkQN2E3eojVcP9qm12NwASF3dDjPJXzHTgAZP6ShUd3wYJ70Q==
X-Received: by 2002:a7b:cb0f:: with SMTP id u15mr2850767wmj.34.1593083696262;
        Thu, 25 Jun 2020 04:14:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f14sm14454978wro.90.2020.06.25.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:14:55 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:14:52 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix locking issues with governors
Message-ID: <20200625111452.GA200288@google.com>
References: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh

On Thursday 25 Jun 2020 at 16:24:16 (+0530), Viresh Kumar wrote:
> The locking around governors handling isn't adequate currently. The list
> of governors should never be traversed without locking in place. Also we
> must make sure the governor isn't removed while it is still referenced
> by code.

Thanks for having a look at this!

This solves the issue for the reference to policy->last_governor, but
given that your patch is based on top of
20200623142138.209513-3-qperret@google.com, 'default_governor' needs a
similar treatment I think.

Perhaps something along the lines of the (completely untested) snippet
below?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dad6b85f4c89..9d7cf2ce2768 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1062,6 +1062,17 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 	return NULL;
 }
 
+static bool get_default_governor(void)
+{
+	bool ret;
+
+	mutex_lock(&cpufreq_governor_mutex);
+	ret = default_governor && !try_module_get(default_governor->owner);
+	mutex_unlock(&cpufreq_governor_mutex);
+
+	return ret;
+}
+
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1073,20 +1084,21 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 		/* Update policy governor to the one used before hotplug. */
 		gov = get_governor(policy->last_governor);
 		if (gov) {
-			put_governor = true;
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 policy->governor->name, policy->cpu);
-		} else if (default_governor) {
+		} else if (get_default_governor()) {
 			gov = default_governor;
 		} else {
 			return -ENODATA;
 		}
+		put_governor = true;
 	} else {
 		/* Use the default policy if there is no last_policy. */
 		if (policy->last_policy) {
 			pol = policy->last_policy;
-		} else if (default_governor) {
+		} else if (get_default_governor()) {
 			pol = cpufreq_parse_policy(default_governor->name);
+			module_put(default_governor->owner);
 			/*
 			 * In case the default governor is neiter "performance"
 			 * nor "powersave", fall back to the initial policy
