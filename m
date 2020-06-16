Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED201FAC5C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgFPJ2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgFPJ2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 05:28:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09DC03E96A
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:28:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so1176120pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdcE3h12ioGr+7hsW5IVLEYOXezdbxNAFqbfrmJLRSE=;
        b=wPEIR5HB/ax8TnnqwOu3J6pC5s+9o0t3fzwRMbe0RIKWhsaPFHD1lqrV2tFTrsClYy
         fXJkkXXdUZRoLueisJyweahorxY75fMc3H0ThyA1LxjDI73N17olVG41cQQCKCdd0O+h
         r7CUz9eI4ZVzMpTIFpSxI0mIPvhl8qO85r/XMjg22vS3Ov3d8uAg7JEEGXGLqFjbB4jM
         +jLlfrPxEuG6Ujf7eDhe/obXkCYuFKN6vvjJFb7tzS1cRU7lDb/sEr2/4Fm9k7wR0Jez
         0SBvCXqtCJGTsyc0ZpZhkEPxr1q62rjUaEbuxcB+tb+lozLn/3eymIlUzcXcG3n+Gnye
         0aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdcE3h12ioGr+7hsW5IVLEYOXezdbxNAFqbfrmJLRSE=;
        b=Ysvt31aqN3eAyywzfC8pn0yXX+SjHSbwvbi2kjjlzHSzaCvhPGCfna/Dg+pQznfcd0
         NiehE1XGgY67UyacspAivgsBSW659q/S9chiSpRUqQ0tkNPcVZNkS5417H7HqVHZCfHm
         ZvQJi5irBAhFvqhAnV46+pNb1WcDu5YzIuso92kLupw4i7B95se56vlemKLubBnCY8dq
         f/j6lmRszoOBaVDVLCrBz5+wWjH75hFUFbq9g64v4p81yh0VxfMXFGssSpgBZAdA/rml
         qEsr6RTIEC9zJsNPBwlW/fXZONEPYfWE3Zwoy3KXsaG/VDPs58Q7IvLGhnhCXQeggsIb
         Bxgw==
X-Gm-Message-State: AOAM530QWC376e/ezEB0n084Zk1OwCoS5+avwAIUzDvfpUFanOHSVxld
        jvDnf8t64b7MgCEtRAiVyhcKyw==
X-Google-Smtp-Source: ABdhPJwsq5ESQOf7eSEAjznxqn8WuPCsn7fjszcUwCqSP6x8q4k9NAQZ5Lzj/jzTj5RJh+yG7ZljTA==
X-Received: by 2002:a17:90a:39ce:: with SMTP id k14mr1903225pjf.39.1592299681986;
        Tue, 16 Jun 2020 02:28:01 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id n4sm17088638pfq.9.2020.06.16.02.28.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 02:28:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:57:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616092759.rjnk3lef4tedfust@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616083107.GA122049@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-20, 09:31, Quentin Perret wrote:
> Right, so the reason I avoided cpufreq_core_init() was because it is
> called at core_initcall() time, which means I can't really assume the
> governors have been loaded by that time. By waiting for the driver to
> probe before detecting the default gov, we get that nice ordering. But
> yes, it feels odd to have it here :/
> 
> Thinking about it more, the natural fit for this would rather be the
> register/unregister path for governors directly. If that sounds good to
> you (?) I'll try to move it there in v2.

There is another problem here which we need to look at. Any governor
which is built as a module and isn't currently used, should be allowed
to unload. And this needs to be tested by you as well, should be easy
enough.

With the current implementation, you take a reference to the default
governor when the driver is registered and drop it only when the
driver goes away. Which means we won't be able to unload the module of
the governor even if it isn't used. Which is wrong. The solution I
proposed had the same issue as well.

You need to figure out a way where we don't need to keep holding the
module hostage even when it isn't used. I see two ways at least for
the same:

- Do that from the existing place: cpufreq_init_policy().

- And I think this can be done from governor-register/unregister as
  well.

Second one sounds good, if it is feasible to do that.

-- 
viresh
