Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5111FAD08
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFPJsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 05:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFPJsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 05:48:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13215C05BD43
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:48:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so907495wrs.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJhllO4Kw1J0lTqgGNFCN8u51U+dY+0Qg1YUtifz2DQ=;
        b=Iqt3U+EfoGwvBO6gas6vWDONtJcu2N7OabeDosatCNXRpqIICI/AjsCW8QzOB5T2JW
         +WmzTSoalx3YRc9j98uetf0Sj/G3aJVxXRQyBl1hksCpwFHP58WKdMc3KHYMcCQHUnMl
         cAUrneMR1ctDU75iXTrOL+XHK2lQsWkh2CtlCJ6olN5YqdQVcZxBjvhYKEn17zsb9Dl6
         gbiKcLBuSB1yFzPdk/soPZZbcfzAQprsSj9xOINTAlVDBk1mJrVeIAlJB93n1TvblA0J
         +/wCrtG3RUhzaNIVOUtRKLK3mr/WaUd4Lylf9SMJtZzZN98FkPruwhHkpkb7zaGmpTge
         5VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJhllO4Kw1J0lTqgGNFCN8u51U+dY+0Qg1YUtifz2DQ=;
        b=G4B+uWshJeOfuhDpnIdOeWICB6N7nqMzh9RzDlz/Xjl1R9lm2ervyeBBr6S7T0zZKp
         DhUYFr2UWbpPAsFyLJG7HhInJ/rhFIrAuWYwgsG9KNUNIHShp5qNeoBG6vru0faZ6JmQ
         P+VPA2kEttO9LyKd9Yzd61SHSSw6Euy8yRJxMo68M/AZiskAWHH8Kd1l84Evjhxwhq2D
         dK8WzYRnOs4qA2KhjSu8IAfh7U0esZB3wx/DaFyWcfV9TCcaLmCnXvn7EYYP6rry0KeQ
         orBVwkIFpyk4npApjlPRYWMvCjcwFotsbiuqQ0WBuowdNqy6NO0Y7lEkN1PRqzaWW/pN
         CJXw==
X-Gm-Message-State: AOAM530FGdkTwpXmHi2essWcVPEVS+MyC8t/k7A+oEivAkRy4xZPCL1k
        hCu/7MP5SVQg9IIVDyGtPWVPkw==
X-Google-Smtp-Source: ABdhPJxETXYc1b9IwZwaRsxXKvkaimQeMqws2xB6B3SE1nYCRT49lzWEH9qFjPJvIMNqDEW6+58+fg==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr2208922wrm.142.1592300886614;
        Tue, 16 Jun 2020 02:48:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id n23sm3107753wmc.0.2020.06.16.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:48:06 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:48:02 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616094802.GA139416@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
 <20200616092759.rjnk3lef4tedfust@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616092759.rjnk3lef4tedfust@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 16 Jun 2020 at 14:57:59 (+0530), Viresh Kumar wrote:
> There is another problem here which we need to look at. Any governor
> which is built as a module and isn't currently used, should be allowed
> to unload. And this needs to be tested by you as well, should be easy
> enough.
> 
> With the current implementation, you take a reference to the default
> governor when the driver is registered and drop it only when the
> driver goes away. Which means we won't be able to unload the module of
> the governor even if it isn't used. Which is wrong. The solution I
> proposed had the same issue as well.
> 
> You need to figure out a way where we don't need to keep holding the
> module hostage even when it isn't used. I see two ways at least for
> the same:
> 
> - Do that from the existing place: cpufreq_init_policy().
> 
> - And I think this can be done from governor-register/unregister as
>   well.
> 
> Second one sounds good, if it is feasible to do that.

Good point.

I'm thinking something along the lines of:

---8<---
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0f05caedc320..a9219404e07f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2340,6 +2340,11 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
 		list_add(&governor->governor_list, &cpufreq_governor_list);
 	}
 
+	if (!strncasecmp(cpufreq_param_governor, governor->name, CPUFREQ_NAME_LEN))
+		default_governor = governor;
+	else if (!default_governor && cpufreq_default_governor() == governor)
+		default_governor = cpufreq_default_governor();
+
 	mutex_unlock(&cpufreq_governor_mutex);
 	return err;
 }
@@ -2368,6 +2373,8 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 
 	mutex_lock(&cpufreq_governor_mutex);
 	list_del(&governor->governor_list);
+	if (governor == default_governor)
+		default_governor = cpufreq_default_governor();
 	mutex_unlock(&cpufreq_governor_mutex);
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
--->8---

should do the trick. That removes the unnecessary reference count, and
feels like a good place to hook things -- that is how cpuidle does it
too IIRC.

I'll double check the locking/synchronization, but that shouldn't be too
bad (famous last words).

Cheers,
Quentin
