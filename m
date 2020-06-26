Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2220AA66
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 04:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgFZCOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 22:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgFZCOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 22:14:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D232C08C5DB
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 19:14:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so1314054pgf.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5o3IoNBS8kqHmXPb9rBGsy54P5rUFZhSKcIAVavfbM=;
        b=QRe4Ib+5fV9eQl0eypxjn3pVPZm6syKXHcdOl8PCejImzGkEDHWSoD61LueRICkUih
         0i2t0NH1KV7ykK7VClhkzSIlIE6TbIS5TZ8tyZUAUwtef3ueK8ksFvd1fxWtj0kUZyBh
         ayj8CnjPrfvlZWakWazIz7NkLt1x4CPff8sY8ln/IrmhQ1GQI3mveeaozPVZDYzlTxDS
         UpIS/3dDTz/MOs+XRGGWXR8uMVkbWpuSjMhjazUUu5MMpTniB9qEFeojbqfJeN7OZ21r
         u9URNO8ogVv39fuGzlHw/GoXnYng0eWkAlhN9RtnKu/PUS0HjEjcnWkgPQ4q07AChrur
         jqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5o3IoNBS8kqHmXPb9rBGsy54P5rUFZhSKcIAVavfbM=;
        b=Bzm6Wsfg8lwxnzdffb3WXB8SD7s3qtrQebMJB+JY0gBN+bBRPI6lEejpwlWqN4URv6
         9Lmq1SUE/9ml1W8WbqlSyB85jj2DF8W6VFVySSbkWQSNAlrU0AYVxrWlCiZRLMfi+UFU
         8hvnmJHInsiYI5NQQ56hESXfTh6FQaIHcjgGkr9Z3pVNzv6yI3BDEErhgEQkzb6Omqdv
         LQ3L1WZIW1u7Au+JOIFFyX5kC3axthgQK6hDiB+Kkkwl0n59hizgzywPU0+zQgU6M7GV
         t4b9M/ltrUAWDagePKarAREhAzl4xKQsKe6cSH0MXhyiodLaqFYtA+QxJKoWiQCJ+YYr
         Kz6A==
X-Gm-Message-State: AOAM532VxVGIUZvMDUnWxPCWUbkr1aXqwi1HwEkpr4WMJh+sY3+26YUq
        8J+5PWbco7GMLzLabO/p4MMb6Q==
X-Google-Smtp-Source: ABdhPJyeNz/9eBEvd7EjBKVWAdQz1ZzZv4JUKci8xV+/Ua9jyb7dc/YXL6S1k1wsVh++vfbWsUgRFQ==
X-Received: by 2002:a63:c50a:: with SMTP id f10mr722738pgd.167.1593137672741;
        Thu, 25 Jun 2020 19:14:32 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id g21sm23788354pfh.134.2020.06.25.19.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 19:14:32 -0700 (PDT)
Date:   Fri, 26 Jun 2020 07:44:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>, dsmythies@telus.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: force frequency update when limits
 change
Message-ID: <20200626021428.tnecyy3wt42slvik@vireshk-i7>
References: <20200625064614.101183-1-wvw@google.com>
 <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
 <CAGXk5yrA=oXZs9KAaELsO7+ex7xCggEwdWSC_KXrUWQnvKEpWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXk5yrA=oXZs9KAaELsO7+ex7xCggEwdWSC_KXrUWQnvKEpWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-06-20, 13:47, Wei Wang wrote:
> On Thu, Jun 25, 2020 at 3:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > I am sorry but I am not fully sure of what the problem is. Can you
> > describe that by giving an example with some random frequency, and
> > tell the expected and actual behavior ?
> >
> The problem is sugov thought next_freq already updated (but actually
> skipped by the rate limit thing) and all following updates will be
> skipped.

I am sorry, can you please give a detailed example with existing
frequency and limits, then the limits changed to new values, then what
exactly happens ?

> Actually this is specifically for Android common kernel 4.19's issue
> which has sugov_up_down_rate_limit in sugov_update_next_freq, let's
> continue discussion there.

If it is a mainline problem, we will surely get it fixed here. Just
that I am not able to understand the problem yet. Sorry about that.

-- 
viresh
