Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E6C1B115
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfEMHYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:24:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35152 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfEMHYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 03:24:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so8506018wmj.0;
        Mon, 13 May 2019 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iVAt5iI6mqugtCiFXfzqwJmqTMe8MsRRRyCMlSkj7hY=;
        b=gJpTiJVddmjubHzTpqyW93iYd9Kh5AcAkff5jWKHAN8Vzw8QdW4Wpv1hg2L5ckIC6c
         LJj9EXpe0QpsKwtCxvb34cA2PMYbxzGUw9NKw7IMo6rox1/WdBZkP3ou+OGKLKrC6+GF
         ExSe4dZij/GOUEgmvXkwFEivUecXtO497bi5UjC9HZaxrzYw3IdrZ9PQ8pqie2Igx6fk
         9rKZMWnCs7xbaThb6hcNwG/XByHqPVEDmoOhf/A8f3mwHrabWBqPnOdomrUTdrn5t1yg
         S6oF/BjZPAOxDwMTXANjWkWkirm/HFDBXYEG3RGLixuETX1092s9ioAJMImhdjmQxJrK
         6oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVAt5iI6mqugtCiFXfzqwJmqTMe8MsRRRyCMlSkj7hY=;
        b=X9xUiF9Ok5u8DG2Trn/lPzYHA/DBHB1WgssfQXnxH8biOJoebFW25FLK0Ke8cGJjPV
         o1GdUmIrsz6FydiFYclORIMZwMtoLnoyje+hneO1Bnfofgk/XgaThMw0nwt8YLkY7N1F
         sHf5bgpWuQi5s50xzlqRhaJVXiwC3jwzzeNZWseM4FG+DiIXCkNi/mOq+UovdzcCss+4
         0QUjuOa1PtZKias/V34x270O7fnitnKDlgiE3mh44dqx19D4Z3ECI6h8eT37Od4gBeuA
         7wQJmvDvz80J3K6zqqJBVH9FpTiINyfaBtg25/qkzuMK6Xm4v7q4Bwq6k9ws63Em6vOn
         W1RA==
X-Gm-Message-State: APjAAAVJoJu1L7GWMgKTq7gi0Y2YscW7ZfMUQuGKVmUP4N77usAgyBXu
        ZWQzQlXe+L96+V8F0Eiv9Bg=
X-Google-Smtp-Source: APXvYqwFcDG6bAeRkKLyQcnNYRRSRsAvc5yJRdcDA7W0BiPW2zrlnWqrtOG6bz1GpEkvce1AVTF5qQ==
X-Received: by 2002:a05:600c:23d2:: with SMTP id p18mr7199285wmb.66.1557732282700;
        Mon, 13 May 2019 00:24:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 19sm2595631wmk.3.2019.05.13.00.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 00:24:41 -0700 (PDT)
Date:   Mon, 13 May 2019 09:24:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Update MAINTAINERS to include schedutil governor
Message-ID: <20190513072439.GA34303@gmail.com>
References: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> List cpufreq maintainers as well for schedutil governor apart from
> scheduler maintainers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4244dd341eb7..7d4417d862a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4093,7 +4093,9 @@ F:	Documentation/admin-guide/pm/intel_pstate.rst
>  F:	Documentation/cpu-freq/
>  F:	Documentation/devicetree/bindings/cpufreq/
>  F:	drivers/cpufreq/
> +F:	kernel/sched/cpufreq*.c
>  F:	include/linux/cpufreq.h
> +F:	include/linux/sched/cpufreq.h
>  F:	tools/testing/selftests/cpufreq/

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
