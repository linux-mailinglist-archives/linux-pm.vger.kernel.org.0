Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE613A3D5F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFKHnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 03:43:24 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:50897 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFKHnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 03:43:23 -0400
Received: by mail-pj1-f46.google.com with SMTP id g4so5250898pjk.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ALGu6qp/vYdKI4RdFgdTsZIAua5DO5/Dcw3j60S5Kk4=;
        b=weGxOLIxqUpNwnJXF9C4mxeuwdFZ84OTo4hkGlph9sIsK3lkNEOFvBXbNAVl/RTkIs
         fbQIdycDt4CQXxKGCrtdZlm0v7PcQJH9d6lyA67WaYFqQItqsm/I+sbNOq9L76TO0mzN
         x0yRjooPkpJRw6+vHonuaf/T/MDbmOk59Q1oNsQQ/PXGrNs323BsLvw1KT3JXtHINSUU
         hErAgVeWGD/jt7rxalaW97fDsy1ssoWkhrIG96w9ayqV9CZub8Qtp6+5VXYwMXn20VBi
         fiAS3CgvqRwkDbt5PgFyh9N8bUu8Y9e3R4+5BVTmly2JPw6F2jjcUOAGEj17Fqz79A0o
         FYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALGu6qp/vYdKI4RdFgdTsZIAua5DO5/Dcw3j60S5Kk4=;
        b=t3MqVhasRt01BxZv3TpxbBLZGDRDvnhwnjksLiRUHp3eT62ZYT2srZLH24h2dKQtNL
         A+yrUbU5frZWcmmDH+WKOhurbFLPrG1Zilm+447utLt8NNBvbyYscu9jeTNKzjrUN2yC
         eSLUJ4jsKfdPdWLvqcXfPBDCWV7yuXr4ALAmxoi8Na44CQHdRTAdblHiPKI3gBtVbZQH
         yPkiAyFiSJyY9zg5TRO5oTE8hYT6GzxXIhOx09HAmivruXxP6RormJ/zJW6dclt3bMot
         a8IAn+1RIWezYeGrnRIxJY9KR00DwdUw5e6A5skUlWwqaapyxSpSkq9xOgV5YLTztBAY
         usQg==
X-Gm-Message-State: AOAM530+Lix5wBa1jPh6JenybSGeYwpQ9bIAX5G3yOnqBoGQtMKxIgS8
        w41Qqnqk4td8ixfBHU3MlhEEXA==
X-Google-Smtp-Source: ABdhPJzi4uRCgH01KvkL1AEA7ev2vuESs4W0mv2gXjLog4wlOwhOS8XdQG0qTjqKN/JVL6XSNfAr5A==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr7586553pjb.115.1623397210888;
        Fri, 11 Jun 2021 00:40:10 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id n23sm4566293pgv.76.2021.06.11.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:40:10 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:10:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Revert "cpufreq: CPPC: Add support for frequency
 invariance"
Message-ID: <20210611074008.57u27wtyqv4ossde@vireshk-i7>
References: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
 <YMMSt65aj0KKHy1A@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMMSt65aj0KKHy1A@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-06-21, 09:37, Peter Zijlstra wrote:
> Alternatively: "depends on BROKEN" ?

This is what I wanted to do, but Rafael didn't like it :)

https://lore.kernel.org/linux-pm/28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org/

-- 
viresh
